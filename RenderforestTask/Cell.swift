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
		let gender = (result.gender?.rawValue ?? "") + " " + (result.phone ?? "")
		let country = result.location?.country
		//let postcode = result.location?.postcode
		let location = (result.location?.state ?? "") + " " + (result.location?.street?.name ?? "")
		let image = result.picture
		self.userName.text = name
		self.userGender.text = gender
		self.userCountry.text = country
		self.userLocation.text = location
		//self.userImage.image = image
		}
    
}
//extension UIImageView {
//	public func transition(toImage image: UIImage?) {
//		UIView.transition(with: self, duration: 0.3, options: [.transitionCrossDissolve]) {
//			self.image = image
//		}; completion;: nil)
//	}
//}
