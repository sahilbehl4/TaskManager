//
//  TaskCoreDataService.swift
//  TaskManager
//
//  Created by Sahil Behl on 2020-02-17.
//  Copyright © 2020 sahil. All rights reserved.
//

import Foundation
import CoreData

class TaskCoreDataService {
    
    static let shared = TaskCoreDataService()
    
    private init() {}
    
    // MARK: - CRUD
    
    func saveToCoreData(task: Task) {
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "NSManagedTask", in: context)
        guard let newTask = NSManagedObject(entity: entity!, insertInto: context) as? NSManagedTask  else {
            return
        }
        newTask.dateCreated = Date()
        newTask.task = task.task
        newTask.isDone = false
        
        do {
            try context.save()
        } catch {
            print("FAILED SAVING TASK")
        }
    }
    
    func fetchAllTasks() -> [NSManagedTask]? {
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "NSManagedTask")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            if let tasks = result as? [NSManagedTask] {
                return tasks
            }
        } catch {
            print("Failed")
        }
        return nil
    }
}
