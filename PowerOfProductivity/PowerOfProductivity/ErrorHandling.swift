//
//  ErrorHandling.swift
//  PowerOfProductivity
//
//  Created by Michael Hartung on 4/14/16.
//  Copyright © 2016 hartung-michael. All rights reserved.
//

import UIKit


class ErrorHandling {
	
	static func showError(controller: UIViewController, title: String, message: String) {
		let alertView = UIAlertController(title: title, message: message, preferredStyle: .Alert)
		let okAction = UIAlertAction(title: "OK", style: .Default) { (action) in }
		alertView.addAction(okAction)
		controller.presentViewController(alertView, animated: true, completion: nil)
	}
	
}