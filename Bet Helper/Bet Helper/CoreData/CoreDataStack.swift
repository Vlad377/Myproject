//
//  CoreDataStack.swift
//  Bet Helper
//
//  Created by Vladyslav Zhulavskyi on 12/7/18.
//  Copyright © 2018 Vladyslav Zhulavskyi. All rights reserved.
//

import Foundation
import CoreData

// MARK: - Core Data stack

class CoreDataStack {
    
    // MARK: Shared
    
    static let currentStack = CoreDataStack()
    
    // MARK: Properties
    
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Bet_Helper")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: Public
    
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
