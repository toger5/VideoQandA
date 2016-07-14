//
//  BlessHelper.swift
//  Video Q&A
//
//  Created by Timo on 11/07/16.
//  Copyright © 2016 Timo. All rights reserved.
//

import Foundation

class Bless{
    
    static let backendless = Backendless.sharedInstance()
    
    static func addQuestion(question: Question){
        var error: Fault?
        print("question added \(question)")
        let dataStore = backendless.data.of(question.ofClass())
        dataStore.save(question, fault: &error)
        if (error == nil){
            print("uplodaded")
        }else{
            print(error)
        }
    }
    
    static func addAns(){
        let ans = VideoAnswer()
        var error: Fault?
        print("ans added \(ans)")
        let dataStore = backendless.data.of(ans.ofClass())
        dataStore.save(ans, fault: &error)
        if (error == nil){
            print("uplodaded")
        }else{
            print(error)
        }
    }
    
    static func addVideoAnswer(videoAnswer: VideoAnswer,question: Question){
        question.answers.append(videoAnswer)
        var error: Fault?
        let result = backendless.data.of(question.ofClass()).save(question, fault:  &error) as? Question
        if error == nil {
//            print("Contact has been saved: \(result!.objectId)")
        }
        else {
         }
        
        //        backendless.persistenceService.of(videoAnswer.ofClass()).save(videoAnswer)
    }
    static func getRecentQuestions(amount: Int, callbackBlock: (BackendlessCollection!) -> Void){
        
        let dataStore = backendless.data.of(Question.ofClass())
        let dataQuery = BackendlessDataQuery()
        dataQuery.queryOptions.pageSize = amount
        dataQuery.queryOptions.sortBy = ["date"]
        
        dataStore.find(dataQuery, response: callbackBlock, error: { (Fault) in
            print("Error in getRecentQuestions: \(Fault)")
        })
    }
    
    static func getVideoAnswersForQuesiton(question: Question) -> Question?{
        
        var error: Fault?
        let questionWithVideoAnswers = backendless.data.of(Question.ofClass()).load(question, relations: ["answers"], fault: &error) as? Question
        if error == nil {
            print("VideoAnswers have been found: \(questionWithVideoAnswers)")
            return questionWithVideoAnswers!
        }
        else {
            print("Server reported an error: \(error)")
            
        }
        return nil
    }
    
    static func registerUser(mail: String, password: String) {
        
        Types.tryblock({ () -> Void in
            
            let user = BackendlessUser()
            user.email = mail
            user.password = password
            
            let registeredUser = Bless.backendless.userService.registering(user)
            print("User has been registered (SYNC): \(registeredUser)")
            },
                       
                       catchblock: { (exception) -> Void in
                        print("Server reported an error: \(exception as! Fault)")
            }
        )
    }
    
    static func userLogin(mail: String, password: String) {
        
        // - sync methods with fault as exception (full "try/catch/finally" version)
        Types.tryblock({ () -> Void in
            // - user login
            let user = Bless.backendless.userService.login(mail, password: password)
            print("LOGINED USER: \(user)")
            },
                       catchblock: { (exception) -> Void in
                        print("Server reported an error: \(exception as! Fault)")
            }
        )
    }
    
}