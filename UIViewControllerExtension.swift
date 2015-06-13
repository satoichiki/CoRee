//
//  UIViewControllerExtension.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 1/19/15.
//  Copyright (c) 2015 Yuji Hato. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func setNavigationBarItem() {
        self.addLeftBarButtonWithImage(UIImage(named: "ic_menu_black_24dp")!)
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor(red: 34/255, green: 37/255, blue: 63/255, alpha: 1.0)
        //self.addRightBarButtonWithImage(UIImage(named: "camera-icon.png")!)
        self.slideMenuController()?.removeLeftGestures()
        //self.slideMenuController()?.removeRightGestures()
        self.slideMenuController()?.addLeftGestures()
        //self.slideMenuController()?.addRightGestures()
    }
    
    func removeNavigationBarItem() {
        self.navigationItem.leftBarButtonItem = nil
        //self.navigationItem.rightBarButtonItem = nil
        self.slideMenuController()?.removeLeftGestures()
        //self.slideMenuController()?.removeRightGestures()
    }
}