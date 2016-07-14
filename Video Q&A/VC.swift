//
//  ViewController.swift
//  VideoService
/*
 * *********************************************************************************************************************
 *
 *  BACKENDLESS.COM CONFIDENTIAL
 *
 *  ********************************************************************************************************************
 *
 *  Copyright 2014 BACKENDLESS.COM. All Rights Reserved.
 *
 *  NOTICE: All information contained herein is, and remains the property of Backendless.com and its suppliers,
 *  if any. The intellectual and technical concepts contained herein are proprietary to Backendless.com and its
 *  suppliers and may be covered by U.S. and Foreign Patents, patents in process, and are protected by trade secret
 *  or copyright law. Dissemination of this information or reproduction of this material is strictly forbidden
 *  unless prior written permission is obtained from Backendless.com.
 *
 *  ********************************************************************************************************************
 */

import UIKit

class VC: UIViewController {

    @IBOutlet var btnPublish : UIButton!
    @IBOutlet var btnPlayback : UIButton!
    @IBOutlet var btnStopMedia : UIButton!
    @IBOutlet var btnSwapCamera : UIButton!
    @IBOutlet var preView : UIView!
    @IBOutlet var playbackView : UIImageView!
    @IBOutlet var textField : UITextField!
    @IBOutlet var lblLive : UILabel!
    @IBOutlet var switchView : UISwitch!
    @IBOutlet var netActivity : UIActivityIndicatorView!
    
//    var backendless = Backendless.sharedInstance()
    
    var videoHelper: VideoHelper? = nil
    let VIDEO_TUBE = "Default"
    
    
    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    

    override func viewDidLoad() {
        
        videoHelper = VideoHelper()
        super.viewDidLoad()
//        Bless.registerUser("toger5@homtail.de", password: "1234567")
        Bless.userLogin("toger5@homtail.de", password: "1234567")
        let quest = Question()
        let answer = VideoAnswer()
        //print(quest.answers)
        Bless.addQuestion(quest)
        Bless.addVideoAnswer(answer, question: quest)
//        Bless.addVideoAnswer(VideoAnswer(), question: quest)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
//    func registerUser() {
//        
//        Types.tryblock({ () -> Void in
//            
//            let user = BackendlessUser()
//            user.email = "bob@foo.com"
//            user.password = "bob"
//            
//            let registeredUser = Bless.backendless.userService.registering(user)
//            print("User has been registered (SYNC): \(registeredUser)")
//            },
//                       
//                       catchblock: { (exception) -> Void in
//                        print("Server reported an error: \(exception as! Fault)")
//            }
//        )
//    }
//    
//    func userLogin() {
//        
//        // - sync methods with fault as exception (full "try/catch/finally" version)
//        Types.tryblock({ () -> Void in
//            
//            // - user login
//            let user = Bless.backendless.userService.login("bob@foo.com", password:"bob")
//            print("LOGINED USER: \(user)")
//            },
//                       
//                       catchblock: { (exception) -> Void in
//                        print("Server reported an error: \(exception as! Fault)")
//            }
//        )
//    }
    
    
    // IBActions
    
    @IBAction func switchCamerasControl(sender: AnyObject) {
        
        print("----------------------- switchCamerasControl ------------------------------------------------------")
        
        videoHelper!.switchFrontBackCamera()
    }
    
    @IBAction func stopMediaControl(sender: AnyObject){
        print("----------------------- stopMediaControl ------------------------------------------------------")
        
        videoHelper!.stopVideo()
        if (videoHelper!.player != nil)
        {
            self.playbackView.hidden = true
            self.btnStopMedia.hidden = true
        }
        
        self.btnPublish.hidden = false
        self.btnPlayback.hidden = false
        self.textField.enabled = true
        self.switchView.enabled = true
        
        self.netActivity.stopAnimating()
    }
    
    @IBAction func disconnectMediaControl(sender: AnyObject) {
        
        print("----------------------- disconectMediaControl ------------------------------------------------------")
        videoHelper!.disconnect()
        if (videoHelper!.publisher != nil) {
            
            self.preView.hidden = true
            self.btnStopMedia.hidden = true
            self.btnSwapCamera.hidden = true
        }
        
        if (videoHelper!.player != nil)
        {
            self.playbackView.hidden = true
            self.btnStopMedia.hidden = true
        }
        
        self.btnPublish.hidden = false
        self.btnPlayback.hidden = false
        self.textField.enabled = true
        self.switchView.enabled = true
        
        self.netActivity.stopAnimating()
    }
    
    @IBAction func playbackControl(sender: AnyObject) {
        
        print("----------------------- playbackControl ------------------------------------------------------")
        if let text = textField.text{
            videoHelper!.playVideoWithFileName(text , target: playbackView)
        }else{
            textField.text = "pls insert Something New"
        }
        self.btnPublish.hidden = true
        self.btnPlayback.hidden = true
        self.textField.enabled = false
        self.switchView.enabled = false
        
        self.netActivity.startAnimating()
    }
    
    @IBAction func publishControl(sender: AnyObject) {
        
        print("----------------------- publishControl ------------------------------------------------------")
        
        if let text = textField.text{
            videoHelper!.publishVideoWithFileName(text, target: preView)
        }else{
            textField.text = "pls insert Something New"
        }
        
        self.btnPublish.hidden = true
        self.btnPlayback.hidden = true
        self.textField.enabled = false
        self.switchView.enabled = false
        
        self.netActivity.startAnimating()
    }
    
    @IBAction func viewTapped(sender: AnyObject) {
        textField.resignFirstResponder()
    }
    
    // UITextFieldDelegate protocol methods
    
    func textFieldShouldReturn(_textField: UITextField) {
        textField.resignFirstResponder()
    }
    
//    // MediaStreamerDelegate protocol methods
//    
//    func streamStateChanged(sender: AnyObject!, state: Int32, description: String!) {
//        
//        print("<IMediaStreamerDelegate> streamStateChanged: \(state) = \(description)");
//        
//        switch state {
//            
//        case 0: //CONN_DISCONNECTED
//            
//            stopMediaControl(sender)
//            return
//            
//        case 1: //CONN_CONNECTED
//            return
//            
//        case 2: //STREAM_CREATED
//            
//            self.btnStopMedia.hidden = false
//            return
//            
//        case 3: //STREAM_PLAYING
//            
//            // PUBLISHER
//            if (_publisher != nil) {
//                
//                if (description != "NetStream.Publish.Start") {
//                    stopMediaControl(sender)
//                    return
//                }
//                
//                self.preView.hidden = false
//                self.btnSwapCamera.hidden = false
//                
//                netActivity.stopAnimating()
//            }
//            
//            // PLAYER
//            if (_player != nil) {
//                
//                if (description == "NetStream.Play.StreamNotFound") {
//                    stopMediaControl(sender)
//                    return
//                }
//                
//                if (description != "NetStream.Play.Start") {
//                    return
//                }
//                
//                self.playbackView.hidden = false
//                
//                netActivity.stopAnimating()
//            }
//            
//            return
//            
//        case 4: //STREAM_PAUSED
//            
//            if (description == "NetStream.Play.StreamNotFound") {
//            }
//            
//            stopMediaControl(sender)
//            return
//            
//        default:
//            return
//        }
//    }
//    
//    func streamConnectFailed(sender: AnyObject!, code: Int32, description: String!) {
//        
//        print("<IMediaStreamerDelegate> streamConnectFailed: \(code) = \(description)");
//        
//        stopMediaControl(sender)
//    }
}