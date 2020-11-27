//
//  SettingsViewController.swift
//  TaskManager
//
//  Created by Sahil Behl on 2020-05-22.
//  Copyright © 2020 sahil. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.accessibilityViewIsModal = true
//        let pa5th = customView.layer.
    }
    
    @IBOutlet weak var settings: UILabel!
    
    @IBAction func button(_ sender: Any) {
    }

    @IBOutlet weak var customView: CustomView!
}
