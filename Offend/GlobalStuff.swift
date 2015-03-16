//
//  GlobalStuff.swift
//  Offend
//
//  Created by Jon Vogel on 3/13/15.
//  Copyright (c) 2015 Jon Vogel. All rights reserved.
//

import UIKit
import CoreData

class GlobalStuff: NSObject {
  
  class var sharedInstance: GlobalStuff{
    struct Static {
      static let instance: GlobalStuff = GlobalStuff()
    }
    
    return Static.instance
  }
  
  var variableInstance: GlobalVariables?
  
  var wantRacist: Bool!
  var wantSexist: Bool!
  
  var userName: String?
  var userObject: PFObject?
  
  var appDelegate: AppDelegate?
  
  override init() {
    super.init()
    self.appDelegate = UIApplication.sharedApplication().delegate as AppDelegate?
    self.setFromCoreData()
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
    query.whereKey("userstring", equalTo: "\(userName)")
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
  
  //CoreData stuff 
  
  func saveToCoreData() {
    self.variableInstance?.wantRacist = self.wantRacist
    self.variableInstance?.wantSexist = self.wantSexist
    self.variableInstance?.userName = self.userName!
    
    self.appDelegate?.managedObjectContext?.save(nil)
  }
  
  func setFromCoreData() {
    let fetchRequest = NSFetchRequest(entityName: "GlobalVariables")
    if let results = self.appDelegate!.managedObjectContext?.executeFetchRequest(fetchRequest, error: nil) {
      
      self.variableInstance = results.first as? GlobalVariables
      self.wantRacist = self.variableInstance!.wantRacist.boolValue
      self.wantSexist = self.variableInstance!.wantSexist.boolValue
      self.userName = self.variableInstance!.userName
      if self.userObject == nil {
        let query = PFQuery(className: "Users")
        query.whereKey("userstring", equalTo: "\(self.userName!)")
        query.findObjectsInBackgroundWithBlock { (returnedUser, error) -> Void in
          if error != true {
            if returnedUser.isEmpty != true {
              self.userObject = returnedUser.first as? PFObject
            }
          }
        }
      }
    }
  }
  

  
}








