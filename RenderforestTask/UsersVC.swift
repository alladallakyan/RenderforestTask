//
//  ViewController.swift
//  RenderforestTask
//
//  Created by Alvard Dallakyan on 28.01.21.
//

import UIKit

class UsersVC: UIViewController {

	@IBOutlet weak var segmentedControl: UISegmentedControl!
	@IBOutlet weak var searchBar: UISearchBar!
	@IBOutlet weak var tableView: UITableView!
	
	var users = ["a", "b", "c", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "w", "x", "y", "z"]
	var savedUsers = ["r", "s", "t", "w", "x", "y", "z","j", "k", "l", "m", "n", "o", "p", "q"]
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.register(UINib(nibName: "Cell", bundle: nil), forCellReuseIdentifier: "Cell")
		tableView.rowHeight = 100
		self.title = "Users"
	}
	
	override func viewWillAppear(_ animated: Bool) {
		navigationController?.navigationBar.isHidden = true
	}
	
	
	@IBAction func changeUsersListButtonTapped(_ sender: Any) {
		tableView.reloadData()
	}
}

extension UsersVC: UITableViewDataSource, UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		var returnValue = 0
		
		switch (segmentedControl.selectedSegmentIndex) {
		case 0:
			returnValue = users.count
			break
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

		switch (segmentedControl.selectedSegmentIndex) {
		case 0:
			cell.userName.text = users[indexPath.row]
			break
		case 1:
			cell.userName.text = savedUsers[indexPath.row]
			break
		default:
			break
		}
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if let viewController = storyboard?.instantiateViewController(identifier: "DetailsVC") as? DetailsVC {
			switch (segmentedControl.selectedSegmentIndex) {
			case 0:
				viewController.nameString = users[indexPath.row]
					navigationController?.pushViewController(viewController, animated: true)
				break
			case 1:
				viewController.nameString = savedUsers[indexPath.row]
					navigationController?.pushViewController(viewController, animated: true)
				break
			default:
				break
			}
		}
	}
}
