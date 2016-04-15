//
//  CreateTaskViewController.swift
//  PowerOfProductivity
//
//  Created by Michael Hartung on 4/14/16.
//  Copyright © 2016 hartung-michael. All rights reserved.
//

import UIKit
import CoreData

class CreateTaskViewController : UIViewController {
	
	@IBOutlet weak var taskName: UITextField!
	@IBOutlet weak var taskComplexity: UITextField!
	@IBOutlet weak var taskPriority: UITextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		taskName.placeholder = "Task Name"
		taskComplexity.placeholder = "Complexity (1-10)"
		taskPriority.placeholder = "Priority (1-10)"
		taskComplexity.keyboardType = UIKeyboardType.DecimalPad
		taskPriority.keyboardType = UIKeyboardType.DecimalPad
	}
	
	@IBAction func createTask(sender: AnyObject) {
		
		let complexity = Int(taskComplexity.text!)
		let priority = Int(taskPriority.text!)
		var complexityValid = false
		var priorityValid = false
		
		if complexity != nil && complexity > 0 && complexity <= 10 {
			complexityValid = true
		}
		
		if priority != nil && priority > 0 && priority <= 10 {
			priorityValid = true
		}
		
		if(!complexityValid && !priorityValid) {
			ErrorHandling.showError(self, title: "Complexity and Priority Error", message: "Complexity and Priority must be set to a number between 1 and 10")
		}
		else if(!complexityValid) {
			ErrorHandling.showError(self, title: "Complexity Error", message: "Complexity must be set to a number between 1 and 10")
		}
		else if(!priorityValid) {
			ErrorHandling.showError(self, title: "Priority Error", message: "Priority must be set to a number between 1 and 10")
		}
		else {
			saveTask(complexity!, priority: priority!)
		}
	}
	
	@IBAction func back(sender: AnyObject) {
		if self.navigationController != nil {
			self.navigationController?.popViewControllerAnimated(true)
		}
	}
	
	func saveTask(complexity: Int, priority: Int) {
		let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
		let managedContext = appDelegate.managedObjectContext as NSManagedObjectContext
		
		let entity = NSEntityDescription.entityForName("Task", inManagedObjectContext: managedContext)
		let task = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
		
		task.setValue(taskName.text, forKey: "name")
		task.setValue(complexity, forKey: "complexity")
		task.setValue(priority, forKey: "priority")
		
		do {
			try managedContext.save()
		} catch let error as NSError {
			print("Could not save \(error), \(error.userInfo)")
		}
		back(self)
	}
}
