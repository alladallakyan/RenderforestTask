//
//  DetailsVC.swift
//  RenderforestTask
//
//  Created by Alvard Dallakyan on 28.01.21.
//

import UIKit
import MapKit
import CoreData

let updateKey = "update"

class DetailsVC: UIViewController, MKMapViewDelegate {

	@IBOutlet weak var mapView: MKMapView!
	@IBOutlet weak var userImage: UIImageView!
	@IBOutlet weak var userName: UILabel!
	@IBOutlet weak var userGender: UILabel!
	@IBOutlet weak var userCountry: UILabel!
	@IBOutlet weak var userLocation: UILabel!
	@IBOutlet weak var saveUserButton: UIButton!
	@IBOutlet weak var removeUserButton: UIButton!
	
	var isSaved: Bool = false {
		didSet{
	      updateUI()
		}
	}

	var nameString = String()
	var latitude = String()
	var longitude = String()
	
	var selectedUser : Result?
	
	override func viewDidLoad() {
        super.viewDidLoad()
		userImage.layer.borderWidth = 3
		userImage.layer.borderColor = UIColor.white.cgColor
		navigationController?.navigationBar.isHidden = false
		self.title = nameString
		mapView.delegate = self
		setRegioOnMap()
		removeUserButton.isHidden = true
		saveUserButton.backgroundColor = .systemGreen
		setUserDetails()
    }
	
	func setUserDetails() {
		userName.text = selectedUser?.name?.first
		userGender.text = (selectedUser?.gender?.rawValue ?? " ") + ", " + (selectedUser?.phone ?? " ")
		userCountry.text = selectedUser?.location?.country
		userLocation.text = (selectedUser?.location?.state ?? "") + " " + (selectedUser?.location?.street?.name ?? "")
		latitude = selectedUser?.location?.coordinates?.latitude ?? ""
		longitude = selectedUser?.location?.coordinates?.longitude ?? ""
		userImage.loadImage(urlString: (selectedUser?.picture?.large)!)
	}
	
	func updateUI() {
		DispatchQueue.main.async {
			let title = self.isSaved ? "User Saved" : "Save User"
			self.removeUserButton.isHidden = !self.isSaved
			self.saveUserButton.isEnabled = !self.isSaved
			self.saveUserButton.setTitle(title, for: .normal)
			self.saveUserButton.backgroundColor = self.isSaved ? .gray : .systemGreen
		}
	}
	
	func setRegioOnMap() {
		var center: CLLocationCoordinate2D = CLLocationCoordinate2D()
		
		guard let latitudeString = selectedUser?.location?.coordinates?.latitude else { return}
		guard let longitudeString = selectedUser?.location?.coordinates?.longitude else { return}
		
		center.longitude = Double(longitudeString)!
		center.latitude = Double(latitudeString)!
		mapView.setCenter(center, animated: true)
	}

	@IBAction func saveUser(_ sender: Any) {
		let name = NSNotification.Name(rawValue: updateKey)
		NotificationCenter.default.post(name: name, object: nil)
		guard let userToSave = selectedUser else { return }
		CoreDataManager.shared.updateCoreData(user: userToSave)
		isSaved = true
		return
	}
	
	@IBAction func removeUser(_ sender: Any) {
		for i in CoreDataManager.shared.savedUsers! {
			if selectedUser?.id?.value == i.id {
				CoreDataManager.shared.context.delete(i) // will not remove the object when enter the detailview from saved uses page, as still cant pass the details
				isSaved = false
				CoreDataManager.shared.saveContext()
			}
		}
	}
}
