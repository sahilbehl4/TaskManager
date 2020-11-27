//
//  TasksViewModel.swift
//  TaskManager
//
//  Created by Sahil Behl on 2020-02-05.
//  Copyright © 2020 sahil. All rights reserved.
//

import UIKit

class TasksViewModel {
    weak var tableViewDelegate: TableViewModelDelegate?
    var sections: [TableSection] = []
    private var builder = TaskBuilder()
    private var taskCoreDataService = TaskCoreDataService.shared
    
    func configure() {
        guard let tasks = fetchAllTasks() else { return }
        loadSections(tasks: tasks)
    }

    private func loadSections(tasks: [Task]) {
        tableViewDelegate?.prepareForDataChange {
            self.sections.append(self.buildTodaySection(tasks: tasks))
            self.tableViewDelegate?.dataChanged()
        }
    }
    
    private func buildTodaySection(tasks: [Task]) -> TableSection {
        let rows: [TableRow] = tasks.compactMap {
            Row.task(data: self.builder.buildTaskCell(task: $0))
        }
        return Section(rows: rows, title: "Today")
    }
    
    func add(task: Task) {
        taskCoreDataService.saveToCoreData(task: task)
        tableViewDelegate?.prepareForDataChange {
            self.sections[0].rows.append(Row.task(data: self.builder.buildTaskCell(task: task)))
            self.tableViewDelegate?.insertTableRows(at: [IndexPath(row: (self.sections.first?.rows.count ?? 1) - 1, section: 0)], with: .fade)
        }
    }
    
    private func fetchAllTasks() -> [Task]? {
        return taskCoreDataService.fetchAllTasks()?.compactMap {
            Task(nsManagedTask: $0)
        }
    }
}

extension TasksViewModel: TableViewModel {
    func registerCells(in tableView: UITableView?) {
        tableView?.register(UINib(nibName: String(describing: TaskViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: TaskViewCell.self))
        tableView?.register(UINib(nibName: String(describing: HeaderCell.self), bundle: nil), forHeaderFooterViewReuseIdentifier: String(describing: HeaderCell.self))
    }

    struct Section: TableSection {
        var rows: [TableRow]
        var title: String?

        var estimatedHeaderHeight: CGFloat {
            return title != nil ? 42 : 0
        }

        var headerHeight: CGFloat {
            return title != nil ? 42 : 0
        }

        func headerView(for tableView: UITableView) -> UIView? {
            guard let title = title, let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: HeaderCell.self)) as? HeaderCell else {
                return nil
            }
            header.headerLabel.text = title
            return header
        }
    }

    enum Row: TableRow {
        case task(data: TaskViewCell.Data)

        func cell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell? {
            switch self {
            case let .task(data):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TaskViewCell.self), for: indexPath) as? TaskViewCell else { return nil }
                cell.configure(data: data)
                return cell
            }
        }
                
        func select(at indexPath: IndexPath, in tableView: UITableView) {
         
        }
         
        func deselect(at indexPath: IndexPath, in tableView: UITableView) {
         
        }
    }
    
    func edit(with style: UITableViewCell.EditingStyle, at indexPath: IndexPath) {
        if style == .delete {
            
        }
    }
}
