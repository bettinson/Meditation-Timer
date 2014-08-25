//
//  AlertsViewController.swift
//  MeditationTimer
//
//  Created by Matt Bettinson on 2014-07-31.
//  Copyright (c) 2014 Matt Bettinson. All rights reserved.
//

import Foundation

class AlertsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var tableView: UITableView?
    let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView?.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        return nil
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        
    }
}
