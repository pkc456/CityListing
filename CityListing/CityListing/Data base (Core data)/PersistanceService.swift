//
//  PersistanceService.swift
//  CityListing
//
//  Created by Pardeep on 19/12/17.
//  Copyright © 2017 www.programmingcrew.in. All rights reserved.
//

import Foundation
import CoreData

class PersistanceService{
    
    private init(){
        
    }
    
    static var context : NSManagedObjectContext{
        return persistentContainer.viewContext
    }
    
    // MARK: - Core Data stack
    
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CityListing")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support    
    static func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
