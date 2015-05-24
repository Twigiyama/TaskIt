//
//  ViewController.swift
//  TaskIt
//
//  Created by Asitha Rodrigo on 08/04/2015.
//  Copyright (c) 2015 Twig. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate, TaskDetailViewControllerDelegate, AddTaskViewControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    
    var fetchedResultsController: NSFetchedResultsController = NSFetchedResultsController()
    
    // var taskArray: [TaskModel] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        fetchedResultsController = getFetchedResultsController()
        fetchedResultsController.delegate = self
        fetchedResultsController.performFetch(nil)
        println(fetchedResultsController.description)
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Background")!)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("iCloudUpdated"), name: "coreDataUpdated", object: nil)

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showTaskDetail" {
            
            let detailVC: TaskDetailViewController = segue.destinationViewController as! TaskDetailViewController
            let indexPath = self.tableView.indexPathForSelectedRow()
            let thisTask = fetchedResultsController.objectAtIndexPath(indexPath!) as! TaskModel
            detailVC.detailTaskModel = thisTask
            detailVC.delegate = self
     
            
        }
        
        else if segue.identifier == "showTaskAdd" {
            
            let addTaskVC: AddTaskViewController = segue.destinationViewController as! AddTaskViewController
            addTaskVC.delegate = self
  
        }
    }
    
    @IBAction func addButtonTapped(sender: UIBarButtonItem) {
        
        self.performSegueWithIdentifier("showTaskAdd", sender: self)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return fetchedResultsController.sections!.count
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let rows = fetchedResultsController.sections![section].numberOfObjects
        return rows
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        println(indexPath.row)
        
        let taskItem: TaskModel = fetchedResultsController.objectAtIndexPath(indexPath) as! TaskModel
        
        var cell: TaskCell = tableView.dequeueReusableCellWithIdentifier("myCell") as! TaskCell
        
        cell.taskLabel.text = taskItem.task
        cell.descriptionLabel.text = taskItem.subtask
        cell.dateLabel.text = Date.toString(date: taskItem.date)
        return cell
    }
    
    //UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        println(indexPath.row)
        
        performSegueWithIdentifier("showTaskDetail", sender: self)
    
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 25
    }
    
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    
        if fetchedResultsController.sections?.count == 1 {
            let fetchedObjects = fetchedResultsController.fetchedObjects!
            let testTask:TaskModel = fetchedObjects[0] as! TaskModel
            if testTask.completed == true {
                return "Completed"
            }
            else {
                return "To Do"
            }
        }
            
        else {
        if section == 0 {
            return "To do"
        }
        
        else {
            return "Completed"
            }
        }
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.backgroundColor = UIColor.clearColor()
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {

        let thisTask = fetchedResultsController.objectAtIndexPath(indexPath) as! TaskModel
        
        if thisTask.completed == 0 {
            thisTask.completed = 1
        } else {
            thisTask.completed = 0
        
        }
    
        ModelManager.instance.saveContext()
        
    }
    
    //NSFetchedResultsControlledDelegate

  
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.reloadData()
    }
    
        //Helper
        
    func taskFetchRequest() -> NSFetchRequest {
            let fetchRequest = NSFetchRequest(entityName: "TaskModel")
            let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
            let completedDescriptor = NSSortDescriptor(key: "completed", ascending: true)
            fetchRequest.sortDescriptors = [completedDescriptor, sortDescriptor]
            return fetchRequest
    
    }
    
    func getFetchedResultsController() -> NSFetchedResultsController {
            fetchedResultsController = NSFetchedResultsController(fetchRequest: taskFetchRequest(), managedObjectContext: ModelManager.instance.managedObjectContext!, sectionNameKeyPath: "completed", cacheName: nil)
        return fetchedResultsController
    }
    
    //TaskDetailViewControllerDelegate
    func taskDetailEdited() {
        showAlert()
    }
    
    func addTask(message: String) {
        showAlert(message: message)
    }
    
    func addTaskCanceled(message: String) {
        showAlert(message: message)
    }
    
    
    func showAlert(message: String = "Congratulations") {
        var alert = UIAlertController(title: "Change Made!", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert,
            animated: true, completion: nil)
    }
    
    //iCloud Notification
    func iCloudUpated() {
        tableView.reloadData()
    }

}

