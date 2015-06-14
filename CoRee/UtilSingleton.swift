//
//  UtilSingleton.swift
//  CoRee
//
//  Created by 佐藤一輝 on 2015/06/14.
//  Copyright (c) 2015年 validtationError. All rights reserved.
//

import Foundation

class UtilSingleton: NSObject {
    
    
    
    var iVal: Int = 0
    
    
    
    class var shareInstance: UtilSingleton {
        
        get {
            
            struct Static {
                
                static var instance: UtilSingleton? = nil
                
                static var token: dispatch_once_t = 0
                
            }
            
            dispatch_once(&Static.token, {
                
                Static.instance = UtilSingleton()
                
            })
            
            return Static.instance!
            
        }
        
    }
    
}


