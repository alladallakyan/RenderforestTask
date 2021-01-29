//
//  DetailsVC.swift
//  RenderforestTask
//
//  Created by Alvard Dallakyan on 28.01.21.
//

import UIKit
import MapKit

class DetailsVC: UIViewController {

	@IBOutlet weak var mapView: MKMapView!
	@IBOutlet weak var userImage: UIImageView!
	@IBOutlet weak var userName: UILabel!
	@IBOutlet weak var userGender: UILabel!
	@IBOutlet weak var userCountry: UILabel!
	@IBOutlet weak var userLocation: UILabel!
	@IBOutlet weak var saveUserButton: UIButton!
	@IBOutlet weak var removeUserButton: UIButton!
	
	var nameString = String()
	
	override func viewDidLoad() {
        super.viewDidLoad()
		userName.text = nameString
		userImage.layer.borderWidth = 3
		userImage.layer.borderColor = UIColor.white.cgColor
		navigationController?.navigationBar.isHidden = false
		self.title = nameString
    }
	
	
	override func viewWillAppear(_ animated: Bool) {
		if saveUserButton.titleLabel?.text == "Save user" {
			saveUserButton.backgroundColor = .green
			saveUserButton.titleLabel?.textColor = .white
			removeUserButton.isHidden = true
		} else {
			saveUserButton.backgroundColor = .lightGray
			saveUserButton.titleLabel?.textColor = .black
			removeUserButton.isHidden = false
			removeUserButton.titleLabel?.textColor = .red
		}
	}
}
