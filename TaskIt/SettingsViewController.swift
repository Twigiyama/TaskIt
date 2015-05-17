//
//  SettingsViewController.swift
//  TaskIt
//
//  Created by Asitha Rodrigo on 16/05/2015.
//  Copyright (c) 2015 Twig. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var capitaliseTableView: UITableView!
    
    @IBOutlet weak var completeNewTodoTableView: UITableView!
    
    @IBOutlet weak var versionLabel: UILabel!
    
    let kVersionNumber = "1.0"
    let kShouldCapitaliseTaskKey = "shouldCapitaliseTask"
    let kShouldCompleteNewTodoKey = "shouldCompleteNewTodo"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
        
        self.capitaliseTableView.delegate = self
        self.capitaliseTableView.dataSource = self
        self.capitaliseTableView.scrollEnabled = false
        
        self.completeNewTodoTableView.delegate = self
        self.completeNewTodoTableView.dataSource = self
        self.completeNewTodoTableView.scrollEnabled = false
        
        self.title = "Settings"
        
        var doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("doneBarButtonItemPressed:"))
        self.navigationItem.leftBarButtonItem = doneButton
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func doneBarButtonItemPressed (barButtonItem: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    //Table View functions
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if tableView == self.capitaliseTableView {
            
            var capitaliseCell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("capitaliseCell") as UITableViewCell
            if indexPath.row == 0 {
                capitaliseCell.textLabel?.text = "Do not capitalise"
                if NSUserDefaults.standardUserDefaults().boolForKey(kShouldCapitaliseTaskKey) == false {
                    capitaliseCell.accessoryType = UITableViewCellAccessoryType.Checkmark
                    
                } else {
                    capitaliseCell.accessoryType = UITableViewCellAccessoryType.None
                }
                
            } else {
                capitaliseCell.textLabel?.text = "Yes Capitalise!"
                if NSUserDefaults.standardUserDefaults().boolForKey(kShouldCapitaliseTaskKey) == true {
                    capitaliseCell.accessoryType = UITableViewCellAccessoryType.Checkmark
                } else {
                    capitaliseCell.accessoryType = UITableViewCellAccessoryType.None
                }
            }
          return capitaliseCell
        }
        
        else {
            var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("completeNewTodoCell") as UITableViewCell
            if indexPath.row == 0 {
                cell.textLabel?.text = "Do not complete Task"
                if NSUserDefaults.standardUserDefaults().boolForKey(kShouldCompleteNewTodoKey) == false {
                    cell.accessoryType = UITableViewCellAccessoryType.Checkmark
                } else {
                    cell.accessoryType = UITableViewCellAccessoryType.None
                }
            } else {
                cell.textLabel?.text = "Yes complete Task"
                if NSUserDefaults.standardUserDefaults().boolForKey(kShouldCompleteNewTodoKey) == true {
                    cell.accessoryType = UITableViewCellAccessoryType.Checkmark
                }
                else {
                    cell.accessoryType = UITableViewCellAccessoryType.None
                }
            }
            return cell
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 30
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == self.capitaliseTableView {
            return "Capitalise New Task"
        } else {
            return "Complete New Task"
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView == self.capitaliseTableView {
            if indexPath.row == 0 {
                NSUserDefaults.standardUserDefaults().setBool(false, forKey: kShouldCapitaliseTaskKey)
            } else {
                NSUserDefaults.standardUserDefaults().setBool(true, forKey: kShouldCapitaliseTaskKey)
            }
        } else {
            if indexPath.row == 0 {
                NSUserDefaults.standardUserDefaults().setBool(false, forKey: kShouldCompleteNewTodoKey)
            } else {
                NSUserDefaults.standardUserDefaults().setBool(true, forKey: kShouldCompleteNewTodoKey)
                }
        }
        NSUserDefaults.standardUserDefaults().synchronize()
        tableView.reloadData()
        }
    }




