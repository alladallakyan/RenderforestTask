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
	
	override func viewDidLoad() {
        super.viewDidLoad()
		userImage.layer.borderWidth = 3
		userImage.layer.borderColor = UIColor.white.cgColor
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
