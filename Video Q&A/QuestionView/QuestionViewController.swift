////
////  QuestionViewController.swift
////  Video Q&A
////
////  Created by Timo on 11/07/16.
////  Copyright © 2016 Timo. All rights reserved.
////
//
//import UIKit
//
//
//class QuestionViewController: UIViewController, IMediaStreamerDelegate{
//    @IBOutlet weak var playbackView: UIImageView!
//    
//    @IBOutlet weak var preView: UIView!
//    
//    override func viewDidAppear(animated: Bool) {
//        super.viewDidAppear(animated)
//
//    }
//    
//    
//    @IBAction func publishControl(sender: AnyObject) {
//        var options: MediaPublishOptions
//        //        if (false /*needs to be controller by a switch*/) {
//        //            options = MediaPublishOptions.liveStream(self.preView) as! MediaPublishOptions
//        //        }
//        //        else {
//        options = MediaPublishOptions.recordStream(self.preView) as! MediaPublishOptions
//        //        }
//        print("publish")
//        options.orientation = .Portrait
//        options.resolution = RESOLUTION_CIF
//        
//        _publisher = backendless.mediaService.publishStream("tt", tube:VIDEO_TUBE, options:options, responder:self)
//        
//        //        self.btnPublish.hidden = true
//        //        self.btnPlayback.hidden = true
//        //        self.textField.enabled = false
//        //        self.switchView.enabled = false
//        
//        //        self.netActivity.startAnimating()
//    }
//    
//    
//    @IBAction func playbackControl(sender: AnyObject) {
//        var options: MediaPlaybackOptions
//        //        if (/*switchView.on*/false) {
//        //            options = MediaPlaybackOptions.liveStream(self.playbackView) as! MediaPlaybackOptions
//        //        }
//        //        else {
//        options = MediaPlaybackOptions.recordStream(self.playbackView) as! MediaPlaybackOptions
//        //        }
//        
//        options.orientation = .Up
//        options.isRealTime = false /*switchView.on*/
//        
//        _player = backendless.mediaService.playbackStream("tt", tube:VIDEO_TUBE, options:options, responder:self)
//        
//        //        self.btnPublish.hidden = true
//        //        self.btnPlayback.hidden = true
//        //        self.textField.enabled = false
//        //        self.switchView.enabled = false
//        //
//        //        self.netActivity.startAnimating()
//    }
//    
//    @IBAction func stopMediaControl(sender: AnyObject) {
//        
//        print("----------------------- stopMediaControl ------------------------------------------------------")
//        print("publisher \(_publisher)")
//        print("publisher \(_player)")
//        if (_publisher != nil) {
//            
//            _publisher?.disconnect()
//            _publisher = nil;
//            
//            self.preView.hidden = true
//            //            self.btnStopMedia.hidden = true
//            //            self.btnSwapCamera.hidden = true
//        }
//        
//        if (_player != nil)
//        {
//            _player?.disconnect()
//            _player = nil;
//            self.playbackView.hidden = true
//            //            self.btnStopMedia.hidden = true
//        }
//        
//        //        self.btnPublish.hidden = false
//        //        self.btnPlayback.hidden = false
//        //        self.textField.enabled = true
//        //        self.switchView.enabled = true
//        //
//        //        self.netActivity.stopAnimating()
//    }
//    
//    func streamStateChanged(sender: AnyObject!, state: Int32, description: String!) {
//        
//        switch state {
//            
//        case 0: //CONN_DISCONNECTED
//            
//            //stopMediaControl(sender)
//            return
//            
//        case 1: //CONN_CONNECTED
//            return
//            
//        case 2: //STREAM_CREATED
//            
//            //self.btnStopMedia.hidden = false
//            return
//            
//        case 3: //STREAM_PLAYING
//            
//            // PUBLISHER
//            if (self._publisher != nil) {
//                
//                if (description != "NetStream.Publish.Start") {
//                    //stopMediaControl(sender)
//                    return
//                }
//                
//                self.preView.hidden = false
//                //self.btnSwapCamera.hidden = false
//                //netActivity.stopAnimating()
//            }
//            
//            // PLAYER
//            if (_player != nil) {
//                
//                if (description == "NetStream.Play.StreamNotFound") {
//                    //stopMediaControl(sender)
//                    return
//                }
//                
//                if (description != "NetStream.Play.Start") {
//                    return
//                }
//                
//                self.playbackView.hidden = false
//                //netActivity.stopAnimating()
//            }
//            
//            return
//            
//        case 4: //STREAM_PAUSED
//            
//            if (description == "NetStream.Play.StreamNotFound") {
//            }
//            
//            //stopMediaControl(sender)
//            return
//            
//        default:
//            return
//        }
//    }
//    
//    func streamConnectFailed(sender: AnyObject!, code: Int32, description: String){ /*stopMediaControl(sender)*/ }
//    
//    
//}