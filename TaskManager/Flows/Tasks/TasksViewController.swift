//
//  TasksViewController.swift
//  TaskManager
//
//  Created by Sahil Behl on 2020-02-05.
//  Copyright © 2020 sahil. All rights reserved.
//

import UIKit

class TasksViewController: UIViewController {

    @IBOutlet weak var tableView: TableView!

    let viewModel = TasksViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designNavigationBar()
        tableView.configure(viewModel: viewModel)
        viewModel.configure()
    }
    
    private func designNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(addTaskButtonPressed))
    }
    
    @objc func addTaskButtonPressed() {
        guard let addTaskViewController = UIStoryboard(name: "AddTask", bundle: nil).instantiateViewController(withIdentifier: String(describing: AddTaskViewController.self)) as? AddTaskViewController else { return }
        addTaskViewController.configure(textAddedCallback: createTextAddedCallback())
        self.present(addTaskViewController, animated: true, completion: nil)
    }
    
    private func createTextAddedCallback() -> ((Task) -> Void) {
        return { task in
            self.viewModel.add(task: task)
        }
    }
}
