//
//  RecommendViewController.swift
//  CoRee
//
//  Created by 佐藤一輝 on 2015/06/13.
//  Copyright (c) 2015年 validtationError. All rights reserved.
//

import UIKit
import CoreLocation

/*
ユーザのオススメ画面
*/
class RecommendViewController: UIViewController, CLLocationManagerDelegate{
    
    /*ファッション画像*/
    @IBOutlet var tops: UIImageView!
    @IBOutlet var jacket: UIImageView!
    @IBOutlet var pants: UIImageView!
    @IBOutlet var hat: UIImageView!
    @IBOutlet var shoes: UIImageView!
    
    
    /*天気の情報*/
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var weatherImage: UIImageView!
    @IBOutlet var weatherLabel: UILabel!
    @IBOutlet var tempLabel: UILabel!
    @IBOutlet var regionLabel: UILabel!
    
    var myLocationManager:CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addLeftBarButtonWithImage(UIImage(named: "ic_menu_black_24dp")!)
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor(red: 34/255, green: 37/255, blue: 63/255, alpha: 1.0)
        
        dateLabel.text = "load.."
        weatherLabel.text = ""
        tempLabel.text = ""
        regionLabel.text = ""
        
        var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let userID = appDelegate.userID
        let twitterAuthToken = appDelegate.twitterAuthToken
        let twitterAuthTokenSecret = appDelegate.twitterAuthTokenSecret
        
        let rowData = "user_id=\(userID!)&provider=twitter&auth_token=\(twitterAuthToken!)&auth_token_secret=\(twitterAuthTokenSecret!)"
        let encodeData = rowData.dataUsingEncoding(NSUTF8StringEncoding)
        
        let url = NSURL(string: "https://coree.herokuapp.com/api/user/cloths/recommendation")!
        var request = NSMutableURLRequest(URL: url)
        
        // set the method(HTTP-GET)
        request.HTTPMethod = "GET"
        request.setValue("\(appDelegate.userID!):\(appDelegate.serverToken!)", forHTTPHeaderField: "Authorization")
        
        var task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: {data, response, error in
            var json = JSON(data: data)
            
            for (key: String, subJson: JSON) in json["cloths"] {
                if((subJson["cloth"]["big_category_id"] != nil) && (subJson["cloth"]["icon"] != nil)) {
                    println(subJson["cloth"]["big_category_id"])
                    var big_category = subJson["cloth"]["big_category_id"].int; //大カテゴリ
                    var icon_url = subJson["cloth"]["icon"].string;//アイコンの画像
                    self.setImage(big_category!, icon: icon_url!)
                }
            }
            
        })
        task.resume()
        
        
        // 現在地を取得します
        myLocationManager = CLLocationManager()
        myLocationManager.delegate = self
        
        // セキュリティ認証のステータスを取得.
        let status = CLLocationManager.authorizationStatus()
        
        //現在地認証の確認
        myLocationManager.requestAlwaysAuthorization()
        
        // 取得精度の設定.
        myLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // 取得頻度の設定.
        myLocationManager.distanceFilter = 100
        myLocationManager.startUpdatingLocation()

    }
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        //println("didChangeAuthorizationStatus");
        
        // 認証のステータスをログで表示.
        var statusStr = "";
        switch (status) {
        case .NotDetermined:
            statusStr = "NotDetermined"
        case .Restricted:
            statusStr = "Restricted"
        case .Denied:
            statusStr = "Denied"
        case .AuthorizedAlways:
            statusStr = "AuthorizedAlways"
        case .AuthorizedWhenInUse:
            statusStr = "AuthorizedWhenInUse"
        }
        //println(" CLAuthorizationStatus: \(statusStr)")
    }
    
    // 位置情報取得に成功
    func locationManager(manager: CLLocationManager!,didUpdateLocations locations: [AnyObject]!){
        // 緯度・経度の表示.
        var lat = manager.location.coordinate.latitude
        var lon = manager.location.coordinate.longitude
        var string = "http://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)"
        
        var url = NSURL(string: string)!
        var task = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: {data, response, error in
            self.dateLabel.text = "data"
            var json = JSON(data: data)
            //temp_max はケルビンで取得されるため、273.15引き、温度に変換
            var temp_max:Int = Int(json["main"]["temp_max"].double! - 273.15)
            var temp_min:Int = Int(json["main"]["temp_min"].double! - 273.15)
            
            var weatherEn:String = json["weather"][0]["main"].string!.lowercaseString
            
            let now = NSDate() // 現在日時の取得
            let dateFormatter = NSDateFormatter()
            dateFormatter.locale = NSLocale(localeIdentifier: "en_JP") // ロケールの設定
            dateFormatter.dateFormat = "M/dd" // 日付フォーマットの設定
            
            var weekdays:[String?] = [nil, "日", "月", "火", "水", "木", "金", "土"]
            let myWeekday = NSCalendar.currentCalendar().components(NSCalendarUnit.CalendarUnitWeekday, fromDate: now).weekday
            
            var dateText:String = dateFormatter.stringFromDate(now)+"(\(weekdays[myWeekday]!))"
            
            var weatherJp  = ""
            switch weatherEn {
            case "clear":
                weatherJp = "晴れ"
                break
            case "clouds":
                weatherJp = "くもり"
                break
            case "rain":
                weatherJp = "雨"
                break
            default:
                weatherJp = "雨"
                break
            }
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.dateLabel.text = dateText
                self.weatherImage.image = UIImage(named: weatherEn+".png")
                self.weatherLabel.text = weatherJp
                self.tempLabel.text = "\(temp_max)℃ \(temp_min)℃"
                self.regionLabel.text = "東京"
            })
            
        })
        task.resume()
    }
    
    //APIから呼び出した画像をセット
    func setImage(id: Int,icon: String) {
        
        println(icon)

        let url = NSURL(string: icon)
        var err: NSError?;
        var imageData :NSData = NSData(contentsOfURL: url!,options: NSDataReadingOptions.DataReadingMappedIfSafe, error: &err)!
        switch  id{
        //トップス
        case 1:
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tops.image = UIImage(data:imageData)
            })
            break
        //ジャケット
        case 2:
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.jacket.image = UIImage(data:imageData)
            })
            break
        //パンツ
        case 3:
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.pants.image = UIImage(data:imageData)
            })
            break
        //スカート
        case 4:
            break
        //ワンピース
        case 5:
            break
        //シューズ
        case 6:
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.shoes.image = UIImage(data:imageData)
            })
            break
        //帽子
        case 7:
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.hat.image = UIImage(data:imageData)
            })
            break
        default:
            break
        }
    }
    
    
    // 位置情報取得に失敗した時に呼び出されるデリゲート.
    func locationManager(manager: CLLocationManager!,didFailWithError error: NSError!){
        print("error")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
    }
    
}

