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
	var filteredUsers = [Result]()
	
	let seed = "renderForest"
	var startIndex = 0
	let batchSize = 20
	var page = 1
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.register(UINib(nibName: "Cell", bundle: nil), forCellReuseIdentifier: "Cell")
		tableView.rowHeight = 100
		self.title = "Users"
		searchBar.delegate = self
		results.removeAll()
		loadData()
		filteredUsers = results
	}
	
	override func viewWillAppear(_ animated: Bool) {
		navigationController?.navigationBar.isHidden = true
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
				//var items = self.results
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
		switch (segmentedControl.selectedSegmentIndex) {
		case 0:
			returnValue = filtered.count //results.count
		case 1:
			returnValue = filteredUsers.count
			break
		default:
			break
		}
		return returnValue
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
		let filtered: [Result] = filteredUsers
		let user = filtered[indexPath.row] //results[indexpath.row]
		switch (segmentedControl.selectedSegmentIndex) {
		case 0:
			if indexPath.row == results.count - 1 {
				page+=1
			    loadData()
			}
			cell.setUp(result: user)
			break
		case 1:
			cell.userName.text = filteredUsers[indexPath.row].name?.first
			break
		default:
			break
		}
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if let detailVC = storyboard?.instantiateViewController(identifier: "DetailsVC") as? DetailsVC {
			let user = filteredUsers[indexPath.row]
			switch (segmentedControl.selectedSegmentIndex) {
			case 0:
				detailVC.nameString = (user.name?.first ?? "") + " " + (user.name?.last ?? "")
				detailVC.genderString = (user.gender?.rawValue ?? "") + " " + (user.phone ?? "")
				detailVC.countryString = user.location?.country ?? ""
				detailVC.locationString = (user.location?.state ?? "") + " " + (user.location?.street?.name ?? "")
				detailVC.longitude = user.location?.coordinates?.longitude ?? ""
				detailVC.latitude = user.location?.coordinates?.latitude ?? ""
				
				navigationController?.pushViewController(detailVC, animated: true)
				break
			case 1:
				detailVC.nameString = filteredUsers[indexPath.row].name?.first ?? ""
					navigationController?.pushViewController(detailVC, animated: true)
				break
			default:
				break
			}
		}
	}

	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		if let searchText = searchBar.text, !searchText.isEmpty {
			filteredUsers = results.filter { (item: Result) in
		return (item.name?.first!.lowercased().contains(searchText.lowercased()))!
					}
		} else {
			filteredUsers = results
		}
		tableView.reloadData()
	}
}

