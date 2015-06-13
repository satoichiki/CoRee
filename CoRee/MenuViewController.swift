//
//  MenuViewController.swift
//  CoRee
//
//  Created by 佐藤一輝 on 2015/06/13.
//  Copyright (c) 2015年 validtationError. All rights reserved.
//

import UIKit
/*
enum LeftMenu: Int {
    case Main = 0
    case Closet
    case Profile
}

protocol LeftMenuProtocol : class {
    func changeViewController(menu: LeftMenu)
}

class MenuViewController : UIViewController, LeftMenuProtocol {

    
    @IBOutlet var tableView: UITableView!

    var menus = ["おすすめ", "クローゼット", "プロフィール"]
    var mainViewController: UIViewController!
    var closetViewController: UIViewController!
    var profileViewController: UIViewController!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1.0)
        
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        let closetViewController = storyboard.instantiateViewControllerWithIdentifier("ClosetViewController") as! ClosetViewController
        self.closetViewController = UINavigationController(rootViewController: closetViewController)
        
        let profileViewController = storyboard.instantiateViewControllerWithIdentifier("ProfileViewController") as! ProfileViewController
        self.profileViewController = UINavigationController(rootViewController: profileViewController)
        
        self.tableView.registerCellClass(BaseTableViewCell.self)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: BaseTableViewCell = BaseTableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: BaseTableViewCell.identifier)
        cell.backgroundColor = UIColor(red: 64/255, green: 170/255, blue: 239/255, alpha: 1.0)
        cell.textLabel?.font = UIFont.italicSystemFontOfSize(18)
        cell.textLabel?.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        cell.textLabel?.text = menus[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let menu = LeftMenu(rawValue: indexPath.item) {
            self.changeViewController(menu)
        }
    }
    
    func changeViewController(menu: LeftMenu) {
        switch menu {
        case .Main:
            self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true)
        case .Closet:
            self.slideMenuController()?.changeMainViewController(self.closetViewController, close: true)
            break
        case .Profile:
            self.slideMenuController()?.changeMainViewController(self.profileViewController, close: true)
            break
        default:
            break
        }
    }
    
}

*/