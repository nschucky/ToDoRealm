//
//  CreateTaskViewController.swift
//  ToDoRealm
//
//  Created by Antonio Alves on 10/31/17.
//  Copyright © 2017 Antonio Alves. All rights reserved.
//

import UIKit
import RealmSwift

class CreateTaskViewController: UIViewController {

    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var taskNameField: UITextField!
    @IBOutlet weak var prioritySwitch: UISwitch!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var task: Task?
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskNameField.becomeFirstResponder()
        
        if let task = task {
            title = "Edit Task"
            taskNameField.text = task.name
            prioritySwitch.isOn = task.isItHighPriority
            datePicker.date = task.dueDate
            updateDone()
        } else {
            title = "New Task"
            updateDone()
        }
    }
    @IBAction func taskNameFieldChanged(_ sender: UITextField) {
        updateDone()
    }
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        taskNameField.resignFirstResponder()
        updateDone()
    }
    
    
    @IBAction func cancePressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func donePressed(_ sender: UIBarButtonItem) {
        if let task = task {
            try! realm.write {
                task.name = taskNameField.text!
                task.dueDate = datePicker.date
                task.isItHighPriority = prioritySwitch.isOn
                dismiss(animated: true, completion: nil)
            }
        } else {
        
            let task = Task()
            task.name = taskNameField.text!
            task.dueDate = datePicker.date
            task.isItHighPriority = prioritySwitch.isOn
            
            try! realm.write {
                realm.add(task)
                dismiss(animated: true, completion: nil)
            }
        }
        
    }
    
    fileprivate func updateDone() {
        if taskNameField.text == "" || datePicker.date < Date() {
            doneButton.isEnabled = false
        } else {
            doneButton.isEnabled = true
        }
    }


}
