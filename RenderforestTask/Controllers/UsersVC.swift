//
//  ViewController.swift
//  RenderforestTask
//
//  Created by Alvard Dallakyan on 28.01.21.
//

import UIKit
import Moya

let loadViewData = "loadData"

enum Tabs: Int {
	case all = 0
	case saved
	
}

class UsersVC: UIViewController {

	@IBOutlet weak var segmentedControl: UISegmentedControl!
	@IBOutlet weak var searchBar: UISearchBar!
	@IBOutlet weak var tableView: UITableView!
	
	var userProvider = MoyaProvider<UserService>()
	
	let update = Notification.Name(rawValue: updateKey)
	
	var results = [Result]()
	var filteredUsers = [Result]()
	var savedUsers = [SavedUser]()
	
	let seed = "renderForest"
	var startIndex = 0
	let batchSize = 20
	var page = 1
	
	override func viewDidLoad() {
		super.viewDidLoad()
		registerCell()
		tableView.rowHeight = 100
		self.title = "Users"
		searchBar.delegate = self
		searchBar.placeholder = "Search"
		results.removeAll()
		creatObserver()
		loadData()
	}
	
	func registerCell() {
		tableView.register(UINib(nibName: "Cell", bundle: nil), forCellReuseIdentifier: "Cell")
	}
	
	override func viewWillAppear(_ animated: Bool) {
		navigationController?.navigationBar.isHidden = true
		CoreDataManager.shared.loadData()
		updateData()
		savedUsers = CoreDataManager.shared.savedUsers!
		tableView.reloadData()
	}

	deinit {
		NotificationCenter.default.removeObserver(self)
	}
	
	private func updateData() {
		let name = NSNotification.Name(rawValue: loadViewData)
		NotificationCenter.default.post(name: name, object: nil)
		tableView.reloadData()
	}
	
	func creatObserver() {
		NotificationCenter.default.addObserver(self, selector: #selector(UsersVC.updateTabelView(notification:)), name: update, object: nil)
	}
	
	@objc func updateTabelView(notification: NSNotification) {
		updateData()
	}
	
	@IBAction func changeUsersListButtonTapped(_ sender: Any) {
		tableView.reloadData()
	}
	
	func loadData() {
		userProvider.request(.readUsers(seed: seed, results: batchSize, page: page)) { [self] (result) in
			switch result {
			case .success(let response):
				let results = try? response.map(User.self).results
				var items: [Result] = self.results
				items.append(contentsOf: results ?? [])
				if self.startIndex < items.count {
					self.results = items
					self.startIndex = items.count
					DispatchQueue.main.async {
						self.tableView.reloadData()
					}
				}
				self.filteredUsers = self.results
			case .failure(let error):
				print(error)
			}
		}
	}
}

extension UsersVC: UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		var returnValue = 0
		let filtered: [Result] = filteredUsers
		let tab = Tabs(rawValue: segmentedControl.selectedSegmentIndex)
		switch (tab) {
		case .all:
			returnValue = filtered.count
		case .saved:
			returnValue = savedUsers.count
		case .none:
			print("error")
		}
		return returnValue
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
		let tab = Tabs(rawValue: segmentedControl.selectedSegmentIndex)
		switch (tab) {
		case .all:
			let filtered: [Result] = filteredUsers
			let user = filtered[indexPath.row]
			if indexPath.row == results.count - 1 {
				page+=1
			    loadData()
			}
			cell.setUp(result: user)
		case .saved:
			let savedUser = savedUsers[indexPath.row]
			cell.setUpSavedUsers(savedUser: savedUser)
			break
		default:
			break
		}
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if let detailVC = storyboard?.instantiateViewController(identifier: "DetailsVC") as? DetailsVC {
			let tab = Tabs(rawValue: segmentedControl.selectedSegmentIndex)
			switch (tab) {
			case .all:
				let user = filteredUsers[indexPath.row]
				let currentId = user.id?.value
				for i in CoreDataManager.shared.savedUsers! {
					if currentId == i.id {
						detailVC.isSaved = true
						break
					}
				}
				detailVC.selectedUser = user
				navigationController?.pushViewController(detailVC, animated: true)
				break
			case .saved:
				let savedUser = savedUsers[indexPath.row]
				let userDetail = filteredUsers.first { result  -> Bool in
					result.id?.value == savedUser.id
				}
				let currentId = savedUser.id
				for i in savedUsers {
					if currentId == i.id {
						detailVC.isSaved = true
						break
					}
				}
				detailVC.selectedUser = userDetail
				navigationController?.pushViewController(detailVC, animated: true)
				break
			default:
				break
			}
		}
	}

	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		let tab = Tabs(rawValue: segmentedControl.selectedSegmentIndex)
		switch (tab) {
		case .all:
			if let searchText = searchBar.text, !searchText.isEmpty {
				filteredUsers = results.filter { (item: Result) in
			return (item.name?.first!.lowercased().contains(searchText.lowercased()))!
				}
			} else {
				filteredUsers = results
			}
			tableView.reloadData()
			break
		case .saved:
			break
		default:
			break
		}
	}
}

