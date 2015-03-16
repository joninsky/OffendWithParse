//
//  OffensiveEngine.swift
//  Offend
//
//  Created by Jon Vogel on 3/11/15.
//  Copyright (c) 2015 Jon Vogel. All rights reserved.
//

import Foundation

class OffensiveEngine: NSObject {
  
  class var sharedEngine: OffensiveEngine{
    struct Static {
      static let instance: OffensiveEngine = OffensiveEngine()
    }
    
    return Static.instance
  }
  
  var arrayOfWords: [String] = [String]()
  
  override init(){
    super.init()
    self.getAllWords(GlobalStuff.sharedInstance.wantRacist, wantSexist: GlobalStuff.sharedInstance.wantSexist) { (returnedArray) -> Void in
      self.arrayOfWords = returnedArray
    }
  }
  
    func getAllWords(wantRacist: Bool, wantSexist: Bool, completion:  ([String]) -> Void) {
    
    
    //Create the Query object
    var query: PFQuery?
    
    //Decide which predicate to use
    if wantRacist == false && wantSexist == false {
      let predicatePG = NSPredicate(format: "isRacist == false AND isSexist == false")
      query = PFQuery(className: "Words", predicate: predicatePG)
    }else if wantRacist == false {
      let predicateNoRacist = NSPredicate(format: "isRacist == false")
      query = PFQuery(className: "Words", predicate: predicateNoRacist)
    } else if wantSexist == false {
      let predicateNoSexist = NSPredicate(format: "isSexist == false")
      query = PFQuery(className: "Words", predicate: predicateNoSexist)
    }else{
      query = PFQuery(className: "Words")
    }
    
    
    //Do an aSynchronous network call which calls the completion hadler.
    query!.findObjectsInBackgroundWithBlock { (returnedData, error) -> Void in
      //Check if error
      if error != true {
        var arrayToBuild = [String]()
        for item in returnedData{
          if let dictionaryForWord = item as? PFObject{
            arrayToBuild.append(dictionaryForWord["word"] as String)
            
          }
        }
        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
          completion(arrayToBuild)
        })
      }
    }
  }
  
  func parseUserString(theString: String) -> String {
    if self.arrayOfWords.isEmpty {
      return "No Offensive Words Available, check internet connection."
    }
    if theString.isEmpty {
      var positionOne: UInt32 = arc4random_uniform(UInt32(self.arrayOfWords.count))
      var positionTwo: UInt32 = arc4random_uniform(UInt32(self.arrayOfWords.count))
      
      while positionOne == positionTwo{
        positionTwo = arc4random_uniform(UInt32(self.arrayOfWords.count))
      }
      
      return "\(self.arrayOfWords[Int(positionOne)])" + " " + "\(self.arrayOfWords[Int(positionTwo)])"
    }else if (theString.rangeOfString("#") == nil){
      return "In order to generate an offensive word we need at least one \"#\" or nothing, Follow the Fucking directions."
    }

    var stringToReturn = ""
    let arrayOfComponents = theString.componentsSeparatedByString("#")
    var arrayOfAppendedWords = [String]()
    for item in arrayOfComponents {
      if item == arrayOfComponents.last {
        if item != "#"{
          stringToReturn = stringToReturn + item
        }else{
          var position = arc4random_uniform(UInt32(self.arrayOfWords.count))
          var word = self.arrayOfWords[Int(position)]
          
          stringToReturn = stringToReturn + item + "\(word)"
        }
      }else{
        var position = arc4random_uniform(UInt32(self.arrayOfWords.count))
        var word = self.arrayOfWords[Int(position)]
        
        stringToReturn = stringToReturn + item + "\(word)"
      }
    }
    
    
    return stringToReturn
  }
  
  
  func getWords(completion: ([PFObject]) -> Void){
    let query = PFQuery(className: "Words")
    query.orderByAscending("word")
    //Do an aSynchronous network call which calls the completion hadler.
    query!.findObjectsInBackgroundWithBlock { (returnedData, error) -> Void in
      //Check if error
      if error != true {
        
        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
          completion(returnedData as [PFObject])
        })
      }
    }
  }
  
  func checkIfWordExists(theWord: String, completion: (Bool) -> Void){
    
    let query = PFQuery(className: "Words")
    query.whereKey("word", equalTo: "\(theWord)")
    
    query!.findObjectsInBackgroundWithBlock { (returnedData, error) -> Void in
      //Check if error
      if error != true {
        if returnedData.isEmpty == true {
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
  
  func findPostsForUser(searchedName: String, completion: ([PFObject]) ->Void){
    
    GlobalStuff.sharedInstance.checkIfUserExists(searchedName, completion: { (decision) -> Void in
      if decision{
        
        let userQuery = PFQuery(className: "Users")
        userQuery.whereKey("userstring", equalTo: "\(searchedName)")
        userQuery.findObjectsInBackgroundWithBlock({ (returnedUser, error) -> Void in
          if error != true{
            let userObject = returnedUser.first as? PFObject
            
            let query = PFQuery(className: "SavedPhrases")
            query.whereKey("user", equalTo: userObject)
            
            query.findObjectsInBackgroundWithBlock { (returnedData, error) -> Void in
              if error != true {
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                  completion(returnedData as [PFObject])
                })
              }
            }
            
          }
        })
      }else{
        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
          completion([])
        })
      }
    })
  }
  
  func getUserName(idString: String, completion: (String) -> Void){
    let query = PFQuery(className: "Users")
    
    query.getObjectInBackgroundWithId("\(idString)", block: { (theObject, error) -> Void in
      if error != true {
        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
          completion(theObject["userstring"] as String)
        })
      }
    })
  }
  
  
  func getPhrases(completion: ([PFObject]) -> Void){
    let query = PFQuery(className: "SavedPhrases")
    query.findObjectsInBackgroundWithBlock { (returnedObjects, error) -> Void in
      NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
        completion(returnedObjects as [PFObject])
      })
    }
  }
  
  
  
  
  
  
//End Class
}