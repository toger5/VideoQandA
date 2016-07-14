//
//  videoAnswer.swift
//  Video Q&A
//
//  Created by Timo on 13/07/16.
//  Copyright © 2016 Timo. All rights reserved.
//

import Foundation

class VideoAnswer: NSObject{
    
    let objectId: String?
    let videoFileName: String?
    let tubeName: String?
    let author: String?
    let date: Double?
    let videoName: String?
    let questionid: String?
    let previewImage: String?
    
    override init(){
        print("videoAnswerCreated")
        objectId = nil
        videoFileName = "no Descritption"
        tubeName = "noPostName"
        videoName = "noName Video"
        author = "noAuthor"
        questionid = "id"
        previewImage = "noIMg"
        date = NSDate().timeIntervalSince1970
    }
}
