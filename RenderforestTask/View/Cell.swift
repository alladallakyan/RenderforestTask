//
//  Cell.swift
//  RenderforestTask
//
//  Created by Alvard Dallakyan on 28.01.21.
//

import UIKit

class Cell: UITableViewCell {
	
	@IBOutlet weak var userImage: UIImageView!
	@IBOutlet weak var userName: UILabel!
	@IBOutlet weak var userGender: UILabel!
	@IBOutlet weak var userCountry: UILabel!
	@IBOutlet weak var userLocation: UILabel!
	
	override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
	
	func setUp(result: Result) {
		let name = (result.name?.first ?? "") + " " + (result.name?.last ?? "")
		let gender = (result.gender?.rawValue ?? "") + ", " + (result.phone ?? "")
		let country = result.location?.country
		let location = (result.location?.state ?? "") + " " + (result.location?.street?.name ?? "")
		self.userName.text = name
		self.userGender.text = gender
		self.userCountry.text = country
		self.userLocation.text = location
		self.userImage.loadImage(urlString: (result.picture?.large)!)
	
	}
	
	func setUpSavedUsers(savedUser: SavedUser) {
		let name = (savedUser.firstName ?? "") + " " + (savedUser.lastName ?? "")
		let gender = (savedUser.gender ?? "") + ", " + (savedUser.phone ?? "")
		let country = savedUser.country
		let location = (savedUser.state ?? "") + " " + (savedUser.streetName ?? "")
		self.userName.text = name
		self.userGender.text = gender
		self.userCountry.text = country
		self.userLocation.text = location
		self.userImage.loadImage(urlString: (savedUser.picture) ?? "")
	}
}

