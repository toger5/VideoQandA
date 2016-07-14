//
//  Post.swift
//  Video Q&A
//
//  Created by Timo on 11/07/16.
//  Copyright © 2016 Timo. All rights reserved.
//

import Foundation
class Question: NSObject{
    
    let objectId: String?
    let name: String?
    let author: String?
    let date: Double?
    let question: String?
    var answers: [VideoAnswer]
    
    override init(){
        print("questionCreated")
        objectId = nil
        name = "noPostName"
        author = "noAuthor"
        question = "How To"
        date = NSDate().timeIntervalSince1970
        answers = []
    }
}
