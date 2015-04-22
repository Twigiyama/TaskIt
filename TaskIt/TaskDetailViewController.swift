//
//  TaskDetailViewController.swift
//  TaskIt
//
//  Created by Asitha Rodrigo on 11/04/2015.
//  Copyright (c) 2015 Twig. All rights reserved.
//

import UIKit

class TaskDetailViewController: UIViewController {
    
    var detailTaskModel: TaskModel!


    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var subTaskTextField: UITextField!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.taskTextField.text = detailTaskModel.task
        self.subTaskTextField.text = detailTaskModel.subtask
        self.dueDatePicker.date = detailTaskModel.date
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func canceBarButtonTapped(sender: UIBarButtonItem) {
        
        self.navigationController?.popViewControllerAnimated(true)
    }

    @IBAction func doneBarButtonItemPressed(sender: UIBarButtonItem) {
        
        /* var task=TaskModel(task: taskTextField.text, subTask: subTaskTextField.text, date: dueDatePicker.date, completed: false)
        
        mainVC.baseArray[0][mainVC.tableView.indexPathForSelectedRow()!.row] = task */
        
        let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        
        detailTaskModel.task = taskTextField.text
        detailTaskModel.subtask = subTaskTextField.text
        detailTaskModel.date = dueDatePicker.date
        detailTaskModel.completed = detailTaskModel.completed
        
        appDelegate.saveContext()
        
        self.navigationController?.popViewControllerAnimated(true)
    }

}
