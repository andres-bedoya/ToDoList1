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
        let app = UIApplication.shared.delegate  as! AppDelegate
        
        //EEE Should I add here persistent container??
        // http://stackoverflow.com/questions/37956720/how-to-create-managedobjectcontext-using-swift-3-in-xcode-8
        
        // FIX : Here you are trying to access the "managedObjectContext" attribute of the appDelegate.
        // But if you look in your app delegate file their is nothing like this. But you had declaired a containeur.
        // and this container has a ManagedObjectContext as attribute (called viewContext)
        
        let managedContext = app.persistentContainer.viewContext
        
       // let managedContext = AppDelegate.ManagedObjectContext
        
        //2
        let entity =  NSEntityDescription.entity(forEntityName: "Task",
                                                 in:managedContext)
        
        let t = NSManagedObject(entity: entity!,
                                     insertInto: managedContext) as! Task
        
        //3
        t.name = name
        //person.setValue(name, forKey: "name")
        
        //4
        do {
            try managedContext.save()
            //5
            //EEE Don't get why this Error
            
            // When you write Task with a big T you refer to the Class
            // So you try to add a class in in the task list.
            // In fact what you are trying to do is to add an object of the class Task in taskList
            // (what we call a Task instance)
            
            //taskList.append(Task)
            taskList.append(t)
            
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
}
