//
//  ViewController.swift
//  RenderforestTask
//
//  Created by Alvard Dallakyan on 28.01.21.
//

import UIKit
import Moya

class UsersVC: UIViewController {

	@IBOutlet weak var segmentedControl: UISegmentedControl!
	@IBOutlet weak var searchBar: UISearchBar!
	@IBOutlet weak var tableView: UITableView!
	
	var userProvider = MoyaProvider<UserService>()
	
	var results = [Result]()
	var savedUsers = [Result]()
	
	let seed = "renderForest"
	var startIndex = 0
	let batchSize = 20
	var page = 1
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.register(UINib(nibName: "Cell", bundle: nil), forCellReuseIdentifier: "Cell")
		tableView.rowHeight = 100
		self.title = "Users"
		results.removeAll()
		loadData()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		navigationController?.navigationBar.isHidden = true
	}
	
	@IBAction func changeUsersListButtonTapped(_ sender: Any) {
		tableView.reloadData()
	}
	
	func loadData() {
		userProvider.request(.readUsers(seed: seed, results: batchSize, page: page)) { (result) in
			switch result {
			case .success(let response):
				let results = try? response.map(User.self).results
				//
				var items = self.results
				items.append(contentsOf: results ?? [])
				
				if self.startIndex < items.count {
					self.results = items
					self.startIndex = items.count
					print("results\(self.results.count)")
					print("startIndex\(self.startIndex)")
					print("items\(items.count)")
					DispatchQueue.main.async {
						self.tableView.reloadData()
					}
				}
				//
				//self.results = results ?? []
				//self.tableView.reloadData()
			case .failure(let error):
				print(error)
			}
		}
	}
}

extension UsersVC: UITableViewDataSource, UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		var returnValue = 0
		
		switch (segmentedControl.selectedSegmentIndex) {
		case 0:
			returnValue = results.count
		case 1:
			returnValue = savedUsers.count
			break
		default:
			break
		}
		return returnValue
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
		let user = results[indexPath.row].name
		switch (segmentedControl.selectedSegmentIndex) {
		case 0:
			if indexPath.row == results.count - 1 { // last cell
				page+=1
				loadData()
				print("page\(page)")
				//tableView.reloadData()
			}
			cell.userName.text = user?.first
			break
		case 1:
			cell.userName.text = savedUsers[indexPath.row].name?.first
			break
		default:
			break
		}
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if let viewController = storyboard?.instantiateViewController(identifier: "DetailsVC") as? DetailsVC {
			let user = results[indexPath.row].name
			switch (segmentedControl.selectedSegmentIndex) {
			case 0:
				viewController.nameString = user?.first ?? ""
					navigationController?.pushViewController(viewController, animated: true)
				break
			case 1:
				viewController.nameString = savedUsers[indexPath.row].name?.first ?? ""
					navigationController?.pushViewController(viewController, animated: true)
				break
			default:
				break
			}
		}
	}
}
