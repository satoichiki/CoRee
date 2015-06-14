//
//  Singletone.swift
//  CoRee
//
//  Created by 佐藤一輝 on 2015/06/14.
//  Copyright (c) 2015年 validtationError. All rights reserved.
//

import UIKit

class Singletone {
    class var sharedController : QrReadViewController{
        struct Singleton {
            static let instance = QrReadViewController()
        }
        return Singleton.instance
    }
}