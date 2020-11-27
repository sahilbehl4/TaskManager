//
//  AddTaskViewController.swift
//  TaskManager
//
//  Created by Sahil Behl on 2020-02-13.
//  Copyright © 2020 sahil. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    var textAddedCallback: ((Task) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        textField.becomeFirstResponder()
    }
    
    func configure(textAddedCallback: @escaping ((Task) -> Void)) {
        self.textAddedCallback = textAddedCallback
    }

    
    @IBAction func saveButtonTapped(_ sender: Any) {
        if let task = textField.text {
            textAddedCallback?(Task(task: task))
            dismiss(animated: true, completion: nil)
        }
    }
}
