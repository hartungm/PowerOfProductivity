//
//  ViewController.swift
//  PowerOfProductivity
//
//  Created by Michael Hartung on 4/13/16.
//  Copyright © 2016 hartung-michael. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource {

	@IBOutlet weak var tableView: UITableView!
	
	var appDelegate: AppDelegate?
	var managedContext: NSManagedObjectContext?
	var tasks = [NSManagedObject]()
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		self.appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
		self.managedContext = self.appDelegate!.managedObjectContext as NSManagedObjectContext
		let fetchRequest = NSFetchRequest(entityName: "Task")
		
		do {
			let results = try managedContext?.executeFetchRequest(fetchRequest)
			tasks = results as! [NSManagedObject]
		} catch let error as NSError {
			print("Could not fetch \(error), \(error.userInfo)")
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
	}

	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return tasks.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = self.tableView.dequeueReusableCellWithIdentifier("cell")
		let task = tasks[indexPath.row]
		cell!.textLabel!.text = task.valueForKey("name") as? String
		return cell!
	}

	@IBAction func addTask(sender: AnyObject) {
		let alert = UIAlertController(title: "New Task", message: "Add a new task", preferredStyle: .Alert)
		
		let saveAction = UIAlertAction(title: "Save", style: .Default, handler: { (action:UIAlertAction) -> Void in
			let name = alert.textFields![0].text
			var complexity = Int(alert.textFields![1].text!)
			var priority = Int(alert.textFields![2].text!)
			
			
			if(complexity == nil) {
				let alertView = UIAlertController(title: "Complexity Error",
					message: "Complexity must be a number, setting to default of 1.",
					preferredStyle: .Alert)
				
				let okAction = UIAlertAction(title: "OK", style: .Default) {
					(action: UIAlertAction) -> Void in
				}
				
				alertView.addAction(okAction)
				
				self.presentViewController(alertView, animated: true, completion: nil)
				complexity = 1
			}
			
			if(priority == nil) {
				priority = 1
			}
			
			self.saveName(name!, complexity: complexity!, priority: priority!)
			self.tableView.reloadData()
		})
		
		let cancelAction = UIAlertAction(title: "Cancel", style: .Default) {
			(action: UIAlertAction) -> Void in
		}
		
		alert.addTextFieldWithConfigurationHandler { (textField) in
			textField.placeholder = "Task Name"
		}
		
		alert.addTextFieldWithConfigurationHandler { (textField) in
			textField.placeholder = "Complexity (1 - 10)"
		}
		
		alert.addTextFieldWithConfigurationHandler { (textField) in
			textField.placeholder = "Priority (1 - 10)"
		}
		
		alert.addAction(saveAction)
		alert.addAction(cancelAction)
		
		presentViewController(alert, animated: true, completion: nil)
	}
	
	func saveName(name: String, complexity: Int, priority: Int) {
		let entity = NSEntityDescription.entityForName("Task", inManagedObjectContext: self.managedContext!)
		let task = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: self.managedContext!)
		
		task.setValue(name, forKey: "name")
		task.setValue(complexity, forKey: "complexity")
		task.setValue(priority, forKey: "priority")
		
		do {
			try self.managedContext!.save()
			tasks.append(task)
		} catch let error as NSError {
			print("Could not save \(error), \(error.userInfo)")
		}
	}

}

