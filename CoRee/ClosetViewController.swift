//
//  SwiftViewController.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 1/19/15.
//  Copyright (c) 2015 Yuji Hato. All rights reserved.
//



import UIKit

class ClosetViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    
    var clothBigCategory = ["トップス", "ジャケット", "パンツ","シューズ","帽子"]
    
    override func viewDidLoad() {
        self.title = "クローゼット"
        
        self.tableView.dataSource = self
        self.tableView.delegate = self

        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        self.addRightBarButtonWithImage(UIImage(named: "camera-icon24.png")!)
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor(red: 34/255, green: 37/255, blue: 63/255, alpha: 1.0)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clothBigCategory.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: ClosetCell = tableView.dequeueReusableCellWithIdentifier("ClosetCell", forIndexPath: indexPath) as! ClosetCell
        
        cell.setCell(clothBigCategory[indexPath.row],cellIndex: indexPath.row)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}