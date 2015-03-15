//
//  GlobalStuff.swift
//  Offend
//
//  Created by Jon Vogel on 3/13/15.
//  Copyright (c) 2015 Jon Vogel. All rights reserved.
//

import UIKit

class GlobalStuff: NSObject {
  
  class var sharedInstance: GlobalStuff{
    struct Static {
      static let instance: GlobalStuff = GlobalStuff()
    }
    
    return Static.instance
  }
  
  var wantRacist: Bool!
  var wantSexist: Bool!
  
  var userName: String?
  var userObject: PFObject?
  
  var appDelegate: AppDelegate?
  
  override init() {
    super.init()
    self.wantRacist = false
    self.wantSexist = false
    self.appDelegate = UIApplication.sharedApplication().delegate as AppDelegate?
  }
  
  
  func makeUser(theName: String) {
    
    userObject = PFObject(className: "Users")
    userObject!.setObject(theName, forKey: "userstring")
    self.userName = theName
    self.saveUserStuff()
    
    

  }
  
  
  
  func saveUserStuff(){
    self.userObject!.saveInBackgroundWithBlock { (didSave, error) -> Void in
      if didSave{
        println("User Save Success!")
      }else{
        println("User Save Fail!")
      }
    }
  }
  
  func checkIfUserExists(userName: String, completion: (Bool) -> Void) {
    
    let query = PFQuery(className: "Users")
    
    query.whereKey("usersString", equalTo: "\(userName)")
    
    query.findObjectsInBackgroundWithBlock { (returnedUser, error) -> Void in
      if error != true {
        if returnedUser.isEmpty == true {
          NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
            completion(false)
          })
        }else {
          NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
            completion(true)
          })
        }
      }
    }
  }
  
  
  
}