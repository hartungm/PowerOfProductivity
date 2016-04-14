//
//  APIManager.swift
//  Power Of Productivity
//
//  Created by Michael Hartung on 4/7/16.
//  Copyright © 2016 hartung-michael. All rights reserved.
//

import Foundation

class APIManager: NSObject, NSURLConnectionDataDelegate {
	
	static let baseUrl = "https://tranquil-reef-24312.herokuapp.com/api"
	
	static func getRequest(url: String, getCompletionHandler: (result: AnyObject) -> AnyObject) {
		let endpoint = "\(baseUrl)\(url)"
		let url = NSURL(string: endpoint)!
		let session = NSURLSession.sharedSession()
		
		session.dataTaskWithRequest(NSURLRequest(URL: url))
		
		session.dataTaskWithURL(url, completionHandler: {
			(data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
			
			do {
				let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
				getCompletionHandler(result: json)
			} catch {
				print("Shit Happens")
			}
			
		}).resume()
	}
}