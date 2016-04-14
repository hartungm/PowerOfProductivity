//
//  ViewController.swift
//  Power Of Productivity
//
//  Created by Michael Hartung on 4/7/16.
//  Copyright © 2016 hartung-michael. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		APIManager.getRequest("/tasks", getCompletionHandler: { (json: AnyObject) -> AnyObject in
			print(json)
			return json
		})
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

