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
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.register(UINib(nibName: "Cell", bundle: nil), forCellReuseIdentifier: "Cell")
		navigationController?.navigationBar.isHidden = true
		tableView.rowHeight = 100
	}
}

extension UsersVC: UITableViewDataSource, UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell

		return cell
	}
	
	
	
}
