//
//  String+Extension.swift
//  RenderforestTask
//
//  Created by Alvard Dallakyan on 06.02.21.
//

import Foundation
import MapKit
import UIKit

var imageCache = NSCache<NSString, UIImage>()

extension UIImageView {

	func loadImage(urlString: String) {
		
		if let cacheImage = imageCache.object(forKey: (urlString as AnyObject) as! NSString) {
			self.image = cacheImage
			return
		}
		
		guard let url = URL(string: urlString) else { return }
		
		URLSession.shared.dataTask(with: url) { (data, response, error) in
			if let error = error {
				print("Couldn't download image: ", error)
				return
			}
			
			guard let data = data else { return }
			let cachedImage = UIImage(data: data)
			imageCache.setObject(cachedImage!, forKey: (urlString as AnyObject) as! NSString)
			
			DispatchQueue.main.async {
				self.image = cachedImage
			}
		}.resume()

	}
}

