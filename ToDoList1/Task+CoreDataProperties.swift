//
//  Task+CoreDataProperties.swift
//  ToDoList1
//
//  Created by aurelien on 18/11/2016.
//  Copyright © 2016 ABedoya. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task");
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var done: Bool
    @NSManaged public var name: String?
    @NSManaged public var longitude: Double
    @NSManaged public var latitude: Double

}
