//
//  TaskTableViewCell.swift
//  ToDoRealm
//
//  Created by Antonio Alves on 10/31/17.
//  Copyright © 2017 Antonio Alves. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var taskDueDateLabel: UILabel!
    @IBOutlet weak var taskPriorityLabel: UILabel!
    
    lazy var dateFormatter: DateFormatter = {
       let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()
    
    func configureCellForTask(_ task: Task) {
        taskNameLabel.text = task.name
        taskDueDateLabel.text = dateFormatter.string(from: task.dueDate)
        taskPriorityLabel.text = task.isItHighPriority ? "high" : "low"
    }

}
