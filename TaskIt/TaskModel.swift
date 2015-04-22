//
//  TaskModel.swift
//  TaskIt
//
//  Created by Asitha Rodrigo on 16/04/2015.
//  Copyright (c) 2015 Twig. All rights reserved.
//

import Foundation
import CoreData

@objc(TaskModel)
class TaskModel: NSManagedObject {

    @NSManaged var completed: NSNumber
    @NSManaged var task: String
    @NSManaged var subtask: String
    @NSManaged var date: NSDate

}
