//
//  AddTaskViewController.swift
//  TaskIt
//
//  Created by Asitha Rodrigo on 11/04/2015.
//  Copyright (c) 2015 Twig. All rights reserved.
//

import UIKit
import CoreData

protocol AddTaskViewControllerDelegate {
    
    func addTask(message: String)
    func addTaskCanceled(message: String)
}

class AddTaskViewController: UIViewController {

   
    
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var subTaskTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var delegate: AddTaskViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Background")!)


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonTapped(sender: UIButton) {

    
        self.dismissViewControllerAnimated(true, completion: nil)
        delegate?.addTask("Task was not added")
        
    }

    @IBAction func addTaskButtonTapped(sender: UIButton) {

        let appDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let managedObjectContext = ModelManager.instance.managedObjectContext
        let entityDescription = NSEntityDescription.entityForName("TaskModel", inManagedObjectContext: managedObjectContext!)
        let task = TaskModel(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext!)
        

        //let task = TaskModel(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext)
        //let task = TaskModel(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext!)
        
        if NSUserDefaults.standardUserDefaults().boolForKey(kShouldCapitaliseTaskKey) == true {
            task.task = taskTextField.text.capitalizedString
        } else {
                    task.task = taskTextField.text
        }
        

        task.subtask = subTaskTextField.text
        task.date = datePicker.date
        if NSUserDefaults.standardUserDefaults().boolForKey(kShouldCompleteNewTodoKey) {
            task.completed = true
        } else {
                    task.completed = false
        }

        
        ModelManager.instance.saveContext()
        
        var request = NSFetchRequest(entityName: "TaskModel")
        var error:NSError? = nil
        
        var results: NSArray = managedObjectContext!.executeFetchRequest(request, error: &error)!
        
        for res in results {
            println(res)
        }

        self.dismissViewControllerAnimated(true, completion: nil)
        delegate?.addTask("task Added")

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
