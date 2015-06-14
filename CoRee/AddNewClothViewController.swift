//
//  AddNewClothViewController.swift
//  CoRee
//
//  Created by 佐藤一輝 on 2015/06/14.
//  Copyright (c) 2015年 validtationError. All rights reserved.
//

import UIKit



class AddNewClothViewController: UIViewController {
    
    var clothNameValue :String = ""
    var clothImageValue :String = ""
    
    @IBOutlet var cloth_icon: UIImageView!
    @IBOutlet var cloth_name: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cloth_name.text = clothNameValue
        
        println(clothImageValue)

        let url = NSURL(string: "https://coree.herokuapp.com\(clothImageValue)")
        var err: NSError?;
        var imageData :NSData = NSData(contentsOfURL: url!,options: NSDataReadingOptions.DataReadingMappedIfSafe, error: &err)!
        cloth_icon.image = UIImage(data:imageData);
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
