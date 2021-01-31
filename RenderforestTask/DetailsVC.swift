//
//  DetailsVC.swift
//  RenderforestTask
//
//  Created by Alvard Dallakyan on 28.01.21.
//

import UIKit
import MapKit

class DetailsVC: UIViewController, MKMapViewDelegate {

	@IBOutlet weak var mapView: MKMapView!
	@IBOutlet weak var userImage: UIImageView!
	@IBOutlet weak var userName: UILabel!
	@IBOutlet weak var userGender: UILabel!
	@IBOutlet weak var userCountry: UILabel!
	@IBOutlet weak var userLocation: UILabel!
	@IBOutlet weak var saveUserButton: UIButton!
	@IBOutlet weak var removeUserButton: UIButton!
	
	var nameString = String()
	var genderString = String()
	var countryString = String()
	var locationString = String()
	var latitude = String()
	var longitude = String()
	
	override func viewDidLoad() {
        super.viewDidLoad()
		userImage.layer.borderWidth = 3
		userImage.layer.borderColor = UIColor.white.cgColor
		navigationController?.navigationBar.isHidden = false
		self.title = nameString
		mapView.delegate = self
		setRegioOnMap()
		setUserDetails()
    }
	
	func setUserDetails() {
		userName.text = nameString
		userGender.text = genderString
		userCountry.text = countryString
		userLocation.text = locationString
	}
	
	func setRegioOnMap() {
		var center: CLLocationCoordinate2D = CLLocationCoordinate2D()
		center.latitude = CLLocationDegrees(latitude)!
		center.longitude = CLLocationDegrees(longitude)!
		self.mapView.setRegion(MKCoordinateRegion(center: center, span: self.mapView.region.span), animated: true)
		//self.mapView.setRegion(MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)), animated: true)
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
