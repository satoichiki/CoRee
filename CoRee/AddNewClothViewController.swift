//
//  AddNewClothViewController.swift
//  CoRee
//
//  Created by 佐藤一輝 on 2015/06/14.
//  Copyright (c) 2015年 validtationError. All rights reserved.
//

import UIKit



class AddNewClothViewController: UIViewController, PayPalPaymentDelegate {
    var config = PayPalConfiguration()
    
    var clothNameValue :String = ""
    var clothImageValue :String = ""
    var clothAmountValue :Int = 0
    
    @IBOutlet var cloth_icon: UIImageView!
    @IBOutlet var cloth_name: UITextField!
    @IBOutlet var cloth_amount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cloth_name.text = clothNameValue
        
        println(clothImageValue)

        let url = NSURL(string: clothImageValue)
        var err: NSError?;
        var imageData :NSData = NSData(contentsOfURL: url!,options: NSDataReadingOptions.DataReadingMappedIfSafe, error: &err)!
        cloth_icon.image = UIImage(data:imageData);
        
        cloth_amount.text = String(clothAmountValue)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true);
        PayPalMobile.preconnectWithEnvironment(PayPalEnvironmentNoNetwork)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buyClicked(sender : AnyObject) {
        let amount = NSDecimalNumber(string: String(self.clothAmountValue))
        
        println("amount \(amount)")
        
        var payment = PayPalPayment()
        payment.amount = amount
        payment.currencyCode = "USD"
        payment.shortDescription = "Clothes payment"
        
        if (!payment.processable) {
            println("You messed up!")
        } else {
            println("This works")
            
            var paymentViewController = PayPalPaymentViewController(payment: payment, configuration: config, delegate: self)
            self.presentViewController(paymentViewController, animated: false, completion: nil)
        }
    }
    
    func payPalPaymentViewController(paymentViewController: PayPalPaymentViewController!, didCompletePayment completedPayment: PayPalPayment!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func payPalPaymentDidCancel(paymentViewController: PayPalPaymentViewController!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
