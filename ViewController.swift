//
//  ViewController.swift
//  TodoList0
//
//  Created by Andres Felipe Bedoya Martinez on 16/11/2016.
//  Copyright © 2016 ABedoya. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    //String array to store task
    
    var taskList = [NSManagedObject]()
    
    //Button add name because is the name of the task
    @IBAction func addName(_ sender: Any) {
        
        let alert = UIAlertController(title: "New Task",
                                      message: "Add a new task",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save",
                                       style: .default,
                                       handler: { (action:UIAlertAction) -> Void in
                                        
                                        let textField = alert.textFields!.first
                                        self.saveName(name: textField!.text!)
                                        self.tableView.reloadData()
        })
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default) { (action: UIAlertAction) -> Void in
        }
        
        alert.addTextField {
            (textField: UITextField) -> Void in
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert,
                animated: true,
                completion: nil)
    }        //set a title and register the UITableViewCell class with the table view
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\"The List\""
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "Cell")
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return taskList.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt
        indexPath: IndexPath) -> UITableViewCell {
        
        let cell =
            tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        let task = taskList[indexPath.row]
        
        cell!.textLabel!.text =
            task.value(forKey: "name") as? String
        
        return cell!
    }
    
    func saveName(name: String) {
        //1
        let appDelegate =
            UIApplication.shared.delegate  as! AppDelegate
        
        //EEE Should I add here persistent container??
        // http://stackoverflow.com/questions/37956720/how-to-create-managedobjectcontext-using-swift-3-in-xcode-8
        let managedContext = AppDelegate.ManagedObjectContext
        
        //2
        let entity =  NSEntityDescription.entityForName("Task",
                                                        inManagedObjectContext:managedContext)
        
        let person = NSManagedObject(entity: entity!,
                                     insertIntoManagedObjectContext: managedContext)
        
        //3
        person.setValue(name, forKey: "name")
        
        //4
        do {
            try managedContext.save()
            //5
            //EEE Don't get why this Error
            taskList.append(Task)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
}
