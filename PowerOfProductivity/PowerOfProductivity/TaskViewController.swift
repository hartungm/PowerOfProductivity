//
//  TaskViewController.swift
//  PowerOfProductivity
//
//  Created by Michael Hartung on 4/13/16.
//  Copyright © 2016 hartung-michael. All rights reserved.
//

import UIKit
import CoreData

class TaskViewController: UIViewController, UITableViewDataSource {
	
	@IBOutlet weak var tableView: UITableView!
	var appDelegate: AppDelegate?
	var managedContext: NSManagedObjectContext?
	var tasks = [NSManagedObject]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		self.appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
		self.managedContext = self.appDelegate!.managedObjectContext as NSManagedObjectContext
		let fetchRequest = NSFetchRequest(entityName: "Task")
		
		do {
			let results = try managedContext?.executeFetchRequest(fetchRequest)
			tasks = results as! [NSManagedObject]
			self.tableView.reloadData()
		} catch let error as NSError {
			print("Could not fetch \(error), \(error.userInfo)")
			ErrorHandling.showError(self, title: "Error loading tasks", message: "There was an error loading task data.")
		}
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
}
