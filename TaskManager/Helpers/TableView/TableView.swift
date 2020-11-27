//
//  TableView.swift
//  TaskManager
//
//  Created by Sahil Behl on 2020-02-05.
//  Copyright © 2020 sahil. All rights reserved.
//

import UIKit

class TableView: UITableView {
    
    var viewModel: TableViewModel?
    var dataChangeSemaphore = DispatchSemaphore(value: 1)
    
    func configure(viewModel: TableViewModel) {
        self.viewModel = viewModel
        self.viewModel?.tableViewDelegate = self
        self.viewModel?.registerCells(in: self)
        
        delegate = self
        dataSource = self
    }
}

extension TableView: UITableViewDelegate, UITableViewDataSource {
    override func numberOfRows(inSection section: Int) -> Int {
        viewModel?.numberOfSections ?? 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows(section: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel?.cell(tableView: tableView, indexPath: indexPath) ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return viewModel?.sections.isEmpty ?? false ? nil : viewModel?.sections[section].headerView(for: tableView)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.selectRow(at: indexPath, in: tableView)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        viewModel?.deselectRow(at: indexPath, in: tableView)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return viewModel?.sections.isEmpty ?? false ? 0 : viewModel?.sections[section].estimatedHeaderHeight ?? 0
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return viewModel?.sections.isEmpty ?? false ? 0 : viewModel?.sections[section].headerHeight ?? 0
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return viewModel?.sections.isEmpty ?? false ? 0 : viewModel?.sections[section].footerHeight ?? 0
    }
    
    func insertTableRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation) {
        insertTableRows(at: indexPaths, with: animation, completion: nil)
    }

    func insertTableRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation, completion: (() -> Void)?) {
        OperationQueue.main.addOperation {
            CATransaction.begin()
            CATransaction.setCompletionBlock {
                self.dataChangeSemaphore.signal()
                completion?()
            }
            self.insertRows(at: indexPaths, with: animation)
            CATransaction.commit()
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        viewModel?.edit(with: editingStyle, at: indexPath)
    }

}


extension TableView: TableViewModelDelegate {
    func prepareForDataChange(completion: (() -> Void)?) {
        DispatchQueue.global().async {
            self.dataChangeSemaphore.wait()
            DispatchQueue.main.sync {
                completion?()
            }
        }
    }

    func releaseDataChangeSemaphore() {
        OperationQueue.main.addOperation {
            self.dataChangeSemaphore.signal()
        }
    }

    func dataChanged() {
        dataChanged(completion: nil)
    }

    func dataChanged(completion: (() -> Void)?) {
        OperationQueue.main.addOperation {
            CATransaction.begin()
            CATransaction.setCompletionBlock {
                self.dataChangeSemaphore.signal()
                completion?()
            }
            self.reloadData()
            self.layoutIfNeeded()

            CATransaction.commit()
        }
    }
}
