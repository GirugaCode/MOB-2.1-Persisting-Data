//
//  CoreDataStack.swift
//  plants
//
//  Created by Ryan Nguyen on 4/22/19.
//  Copyright © 2019 Adriana González Martínez. All rights reserved.
//

import Foundation
import CoreData //import the core data module

class CoreDataStack {
    
    
    private let modelName: String //create a private property to store the modelName
    
    //we always need this
    lazy var managedContext: NSManagedObjectContext = {
        return self.storeContainer.viewContext
    }()
    
    init(modelName: String) {
        self.modelName = modelName //initializer needed to save the modelName into the private property
    }
    
    //lazy instantiate the NSPersistentContainer, passing the modelName
    private lazy var storeContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores {(storeDescription, error) in
            if let error = error as NSError? {
                print("Error: \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    func saveContext() {
        // Checking if we need save
        guard managedContext.hasChanges else { return }
        
        do {
            // Saves the object
            try managedContext.save()
        } catch let error as NSError {
            // If fails, throw errors
            print("yo foo this aint right! \(error), \(error.userInfo)")
        }
    }
    
}