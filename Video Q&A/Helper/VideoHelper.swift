//
//  VideoHelper.swift
//  Video Q&A
//
//  Created by Timo on 12/07/16.
//  Copyright © 2016 Timo. All rights reserved.
//

import Foundation

@objc class VideoHelper: NSObject{
    

//    let backendless: Backendless
    var publisher: MediaPublisher?
    var player: MediaPlayer?
    
    func publishVideoWithFileName(fileName: String, target: UIView){
        
        let options = MediaPublishOptions.recordStream(target) as! MediaPublishOptions
        options.orientation = .Portrait
        
        options.resolution = RESOLUTION_HIGH
//        options.resolution = RESOLUTION_VGA
        publisher = Bless.backendless.mediaService.publishStream(fileName, tube:"Default", options: options, responder:self)
        
    }
    
    
    func playVideoWithFileName(fileName: String, target: UIImageView){
        
        let options = MediaPlaybackOptions.recordStream(target) as! MediaPlaybackOptions
        options.clientBufferMs = 100000
        options.isLive = false
        options.orientation = .Up
        options.isRealTime = false
        print(Bless.backendless.userService.currentUser)
        self.player = Bless.backendless.mediaService.playbackStream(fileName, tube: "Default", options: options, responder: self)
    }
    
    
    func switchFrontBackCamera(){
        if publisher != nil{
            publisher?.switchCameras()
        }
    }
    
    func pauseVideo(){
        player?.pause()
    }
    func resumeVideo(){
        player?.resume()
    }
    func stopVideo(){
        print("----------------------- stopMediaControl ------------------------------------------------------")
        
        if (publisher != nil) {
            publisher?.stop()
            publisher = nil;
        }
        
        if (player != nil){
            player?.stop()
            player = nil;
        }
    }
    
    func disconnect(){
        print("----------------------- stopMediaControl ------------------------------------------------------")
        
        if (publisher != nil) {
            publisher?.stop()
            publisher = nil;
        }
        
        if (player != nil){
            player?.stop()
            player = nil;
        }
    }
}

// MediaStreamerDelegate protocol methods
extension VideoHelper: IMediaStreamerDelegate{
    
    func streamStateChanged(sender: AnyObject!, state: Int32, description: String!) {
        
        print("<IMediaStreamerDelegate> streamStateChanged: \(state) = \(description)");
        
        switch state {
            
        case 0: //CONN_DISCONNECTED
            
            disconnect()
            return
            
        case 1: //CONN_CONNECTED
            return
            
        case 2: //STREAM_CREATED
            
            return
            
        case 3: //STREAM_PLAYING
            
            // PUBLISHER
            if (publisher != nil) {
                
                if (description != "NetStream.Publish.Start") {
                    disconnect()
                    return
                }
                
            }
            
            // PLAYER
            if (player != nil) {
                
                if (description == "NetStream.Play.StreamNotFound") {
                    disconnect()
                    return
                }
                
                if (description != "NetStream.Play.Start") {
                    return
                }
                
            }
            
            return
            
        case 4: //STREAM_PAUSED
            
            if (description == "NetStream.Play.StreamNotFound") {
            }
            
            disconnect()
            return
            
        default:
            return
        }
    }
    
    @objc func streamConnectFailed(sender: AnyObject!, code: Int32, description: String!) {
        
        print("<IMediaStreamerDelegate> streamConnectFailed: \(code) = \(description)");
        
        disconnect()
    }
}


