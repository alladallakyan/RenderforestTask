//
//  SavedUser+CoreDataProperties.swift
//  
//
//  Created by Alvard Dallakyan on 01.02.21.
//
//

import Foundation
import CoreData


extension SavedUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedUser> {
        return NSFetchRequest<SavedUser>(entityName: "SavedUser")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var country: String?
    @NSManaged public var phone: String?
    @NSManaged public var streetName: String?
    @NSManaged public var state: String?
    @NSManaged public var picture: String?
	@NSManaged public var id: String?
	@NSManaged public var gender: String?

}
