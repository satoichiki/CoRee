//
//  LoginViewController.swift
//  CoRee
//
//  Created by 佐藤一輝 on 2015/06/13.
//  Copyright (c) 2015年 validtationError. All rights reserved.
//


import UIKit
import TwitterKit

/*
ログイン画面
*/
class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let logInButton = TWTRLogInButton(logInCompletion: {
            (session: TWTRSession!, error: NSError!) in
            // play with Twitter session
            if(error == nil){
                var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.userID = session.userID
                appDelegate.twitterAuthToken = session.authToken
                appDelegate.twitterAuthTokenSecret = session.authTokenSecret
                
                var selfStoryboard = self.storyboard
                let loginLoadViewController: UIViewController = selfStoryboard?.instantiateViewControllerWithIdentifier("LoginLoadViewController") as! LoginLoadViewController
                self.presentViewController(loginLoadViewController, animated: true, completion: nil)
            }else{
                println(error)
            }
        })
        logInButton.center = self.view.center
        self.view.addSubview(logInButton)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

