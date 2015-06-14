//
//  LoginLoadViewController.swift
//  CoRee
//
//  Created by 佐藤一輝 on 2015/06/13.
//  Copyright (c) 2015年 validtationError. All rights reserved.
//

import UIKit

/*
ログインの処理画面
ログイン処理完了時→RecommendViewControllerへリダイレクト
*/
class LoginLoadViewController: UIViewController {
    
    @IBOutlet var loadingIcon: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingIcon.startAnimating()
        
        var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let userID = appDelegate.userID
        let twitterAuthToken = appDelegate.twitterAuthToken
        let twitterAuthTokenSecret = appDelegate.twitterAuthTokenSecret
        
        let rowData = "user_id=\(userID!)&provider=twitter&auth_token=\(twitterAuthToken!)&auth_token_secret=\(twitterAuthTokenSecret!)"
        let encodeData = rowData.dataUsingEncoding(NSUTF8StringEncoding)
        
        let url = NSURL(string: "https://coree.herokuapp.com/api/user/login")!
        var request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.HTTPBody = encodeData
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {response, data, err in
            if (data != nil) {
                let json = JSON(data: data)
                if (json["msg"].string != "error") {
                    self.loadingIcon.stopAnimating()
                    
                    var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                    appDelegate.serverToken = json["msg"].string
                    
                    var selfStoryboard = self.storyboard
                    
                    let mainViewController = selfStoryboard!.instantiateViewControllerWithIdentifier("RecommendViewController") as! RecommendViewController
                    
                    let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
                    
                    self.presentViewController(nvc, animated: true, completion: nil)
                    
                }
            }
            
            //let loginViewController: UIViewController = LoginViewController()
            //loginViewController.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
            //self.presentViewController(loginViewController, animated: true, completion: nil)
        })
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

