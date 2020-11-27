//
//  TaskBuilder.swift
//  TaskManager
//
//  Created by Sahil Behl on 2020-02-05.
//  Copyright © 2020 sahil. All rights reserved.
//

import Foundation

class TaskBuilder {
    func buildTaskCell(task: Task) ->  TaskViewCell.Data {
        return TaskViewCell.Data(task: task, isChecked: false)
    }
}