//
//  QrReadViewController.swift
//  CoRee
//
//  Created by 佐藤一輝 on 2015/06/14.
//  Copyright (c) 2015年 validtationError. All rights reserved.
//

import UIKit
import AVFoundation

/*
QRコード読み取り
*/
class QrReadViewController: UIViewController ,AVCaptureMetadataOutputObjectsDelegate{
    
    var cnt = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // セッションの作成.
        let mySession: AVCaptureSession! = AVCaptureSession()
        
        // デバイス一覧の取得.
        let devices = AVCaptureDevice.devices()
        
        // デバイスを格納する.
        var myDevice: AVCaptureDevice!
        
        // バックカメラをmyDeviceに格納.
        for device in devices{
            if(device.position == AVCaptureDevicePosition.Back){
                myDevice = device as! AVCaptureDevice
            }
        }
        
        // バックカメラから入力(Input)を取得.
        let myVideoInput = AVCaptureDeviceInput.deviceInputWithDevice(myDevice, error: nil) as! AVCaptureDeviceInput
        
        if mySession.canAddInput(myVideoInput) {
            // セッションに追加.
            mySession.addInput(myVideoInput)
        }
        
        // 出力(Output)をMeta情報に.
        let myMetadataOutput: AVCaptureMetadataOutput! = AVCaptureMetadataOutput()
        
        if mySession.canAddOutput(myMetadataOutput) {
            // セッションに追加.
            mySession.addOutput(myMetadataOutput)
            // Meta情報を取得した際のDelegateを設定.
            myMetadataOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
            // 判定するMeta情報にQRCodeを設定.
            myMetadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
        }
        
        // 画像を表示するレイヤーを生成.
        let myVideoLayer : AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer.layerWithSession(mySession) as! AVCaptureVideoPreviewLayer
        myVideoLayer.frame = self.view.bounds
        myVideoLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        // Viewに追加.
        self.view.layer.addSublayer(myVideoLayer)
        
        // セッション開始.
        mySession.startRunning()
    }
    
    // Meta情報を検出際に呼ばれるdelegate.
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        cnt += 1
        if metadataObjects.count > 0 && cnt == 1 {
            let qrData: AVMetadataMachineReadableCodeObject  = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
            println("\(qrData.stringValue)")
            
            var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let userID = appDelegate.userID
            let twitterAuthToken = appDelegate.twitterAuthToken
            let twitterAuthTokenSecret = appDelegate.twitterAuthTokenSecret
            
            let rowData = "user_id=\(userID!)&provider=twitter&auth_token=\(twitterAuthToken!)&auth_token_secret=\(twitterAuthTokenSecret!)"
            let encodeData = rowData.dataUsingEncoding(NSUTF8StringEncoding)
            
            let url = NSURL(string: "https://coree.herokuapp.com"+qrData.stringValue)!
            var request = NSMutableURLRequest(URL: url)
            
            // set the method(HTTP-GET)
            request.HTTPMethod = "GET"
            request.setValue("\(appDelegate.userID!):\(appDelegate.serverToken!)", forHTTPHeaderField: "Authorization")
            
            var task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: {data, response, error in
                var json = JSON(data: data)
                //println(json)
                if(json["msg"].string == "success"){
                    self.performSegueWithIdentifier("AddNewClothViewController",sender: json["cloth"].object)
                }
            })
            task.resume()
        }
    }
    // Segue 準備
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "AddNewClothViewController" {
            let setView = segue.destinationViewController as! AddNewClothViewController
            
            setView.clothNameValue = sender["name"] as! String
            setView.clothImageValue = sender["icon"] as! String
        }
    }
}

