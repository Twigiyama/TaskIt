//
//  AddTaskViewController.swift
//  TaskIt
//
//  Created by Asitha Rodrigo on 11/04/2015.
//  Copyright (c) 2015 Twig. All rights reserved.
//

import UIKit
import CoreData

class AddTaskViewController: UIViewController {

   
    
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var subTaskTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonTapped(sender: UIButton) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func addTaskButtonTapped(sender: UIButton) {

        let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        let managedObjectContext = appDelegate.managedObjectContext
        let entityDescription = NSEntityDescription.entityForName("TaskModel", inManagedObjectContext: managedObjectContext!)
        let task = TaskModel(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext!)
        

        //let task = TaskModel(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext)
        //let task = TaskModel(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext!)
        
        task.task = taskTextField.text
        task.subtask = subTaskTextField.text
        task.date = datePicker.date
        task.completed = false
        
        appDelegate.saveContext()
        
        var request = NSFetchRequest(entityName: "TaskModel")
        var error:NSError? = nil
        
        var results: NSArray = managedObjectContext!.executeFetchRequest(request, error: &error)!
        
        for res in results {
            println(res)
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
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
