//
//  CoreDataManager.swift
//  RenderforestTask
//
//  Created by Alvard Dallakyan on 31.01.21.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
	
	private init() {}
	static let shared = CoreDataManager()
	lazy var context = persistentContainer.viewContext

	var savedUsers : [SavedUser]?
	
	lazy var persistentContainer: NSPersistentContainer = {
		let container = NSPersistentContainer(name: "RenderforestTask")
		container.loadPersistentStores(completionHandler: { (storeDescription, error) in
			if let error = error as NSError? {
				fatalError("Unresolved error \(error), \(error.userInfo)")
			}
		})
		return container
	}()
	
	func updateCoreData(user: Result) {
		guard let savedUser = mappingFrom(user) else {return}
		context.object(with: savedUser.objectID)
		saveContext()
		loadData()
	}
	
	func saveContext() {
		if context.hasChanges {
			do {
				try context.save()
				print("saved")
			} catch {
				let nserror = error as NSError
				fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
			}
		}
	}
	
	func loadData() {				
		let fetchRequest: NSFetchRequest<SavedUser> = SavedUser.fetchRequest()
		do {
			savedUsers = try context.fetch(fetchRequest)
		} catch {
			print("cannot fetch from database")
		}
	}
	
	func mappingFrom(_ result: Result?) -> SavedUser? {
		let saved = SavedUser(context: context)

		guard let fn = result?.name?.first else { return nil }
		saved.firstName = fn
		
		guard let ln = result?.name?.last else { return nil }
		saved.lastName = ln
		
		guard let sn = result?.location?.street?.name else { return nil }
		saved.streetName = sn
		
		guard let phone = result?.phone else { return nil }
		saved.phone = phone
		
		guard let state = result?.location?.state else { return nil }
		saved.state = state
		
		guard let country = result?.location?.country else { return nil }
		saved.country = country
		
		guard let street = result?.location?.street?.name else { return nil }
		saved.streetName = street
		
		guard let id = result?.id?.value else { return nil }
		saved.id = id
		
		guard let picture = result?.picture?.large else { return nil }
		saved.picture = picture
		
		guard let gender = result?.gender?.rawValue else { return nil }
		saved.gender = gender
		
		return saved
	}
	
}

