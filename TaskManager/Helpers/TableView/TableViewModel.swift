//
//  TableViewModel.swift
//  TaskManager
//
//  Created by Sahil Behl on 2020-02-05.
//  Copyright © 2020 sahil. All rights reserved.
//

import UIKit

protocol TableViewModel {
    var sections: [TableSection] { get }
    var rows: [TableRow] { get }
    var tableViewDelegate: TableViewModelDelegate? { get set }

    func registerCells(in tableView: UITableView?)
}

extension TableViewModel {
    var sections: [TableSection] {
        return []
    }
    
    var rows: [TableRow] {
        return []
    }
    
    var numberOfSections: Int {
        return sections.count
    }
    
    func numberOfRows(section: Int) -> Int {
        return sections.isEmpty ? rows.count : sections[section].rows.count
    }
    
    
    func row(for indexPath: IndexPath) -> TableRow? {
        if sections.isEmpty {
            guard rows.count > indexPath.row else { return nil }
            return rows[indexPath.row]
        } else {
            guard sections.count > indexPath.section,
                  sections[indexPath.section].rows.count > indexPath.row
                else {
                    return nil
            }
            return sections[indexPath.section].rows[indexPath.row]
        }
    }
    
    func cell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell? {
        return row(for: indexPath)?.cell(tableView: tableView, indexPath: indexPath)
    }
    
    func selectRow(at indexPath: IndexPath, in tableView: UITableView) {
        row(for: indexPath)?.select(at: indexPath, in: tableView)
    }

    func deselectRow(at indexPath: IndexPath, in tableView: UITableView) {
        row(for: indexPath)?.deselect(at: indexPath, in: tableView)
    }
    
    func edit(with style:  UITableViewCell.EditingStyle, at indexPath: IndexPath) {}
}

protocol TableRow {
    func cell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell?
    func select(at indexPath: IndexPath, in tableView: UITableView)
    func deselect(at indexPath: IndexPath, in tableView: UITableView)
}

protocol TableSection {
    var rows: [TableRow] { get set }
    var estimatedHeaderHeight: CGFloat { get }
    var footerHeight: CGFloat { get }
    var headerHeight: CGFloat { get }
    
    func headerView(for tableView: UITableView) -> UIView?
}

extension TableSection {
    var footerHeight: CGFloat { return UITableView.automaticDimension }
}

protocol TableViewModelDelegate: class {
    func prepareForDataChange(completion: (() -> Void)?)
    func releaseDataChangeSemaphore()
    func dataChanged()
    func dataChanged(completion: (() -> Void)?)
    func insertTableRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation)
    func insertTableRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation, completion: (() -> Void)?)
}
