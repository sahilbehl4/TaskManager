//
//  Task.swift
//  TaskManager
//
//  Created by Sahil Behl on 2020-02-14.
//  Copyright © 2020 sahil. All rights reserved.
//

import Foundation

struct Task {
    var task: String

    init(task: String) {
        self.task = task
    }
    
    init?(nsManagedTask: NSManagedTask) {
        guard let task = nsManagedTask.task else { return nil }
        self.task = task
    }
}
