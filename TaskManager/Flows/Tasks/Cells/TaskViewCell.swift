//
//  TaskViewCell.swift
//  TaskManager
//
//  Created by Sahil Behl on 2020-02-05.
//  Copyright © 2020 sahil. All rights reserved.
//

import UIKit

class TaskViewCell: UITableViewCell {
    //MARK: - Outlets

    @IBOutlet weak var task: UILabel!
    @IBOutlet weak var checkMarkButton: UIButton!
    
    var check = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func checkButtonPressed(_ sender: Any) {
        check = !check
        checkMarkButton.setImage(check ? #imageLiteral(resourceName: "checkMark") : #imageLiteral(resourceName: "checkMarkOutline"), for: .normal)
//        self.layoutIfNeeded()
    }
    
    func set(text: String) {
        task.text = text
    }
    
    func configure(data: Data) {
        task.text = data.task.task
        check = data.isChecked
        checkMarkButton.imageView?.image = data.isChecked ? #imageLiteral(resourceName: "checkMark") : #imageLiteral(resourceName: "checkMarkOutline")
    }
}

extension TaskViewCell {
    struct Data {
        var task: Task
        var isChecked: Bool
    }
}
