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
    self.getAllWords()
    
  }
  
  func initForTesting(){
    self.arrayOfWords = ["Shit", "Fuck", "Damn", "Hell"]
  }

  
  private func getAllWords() {
    
    var query = PFQuery(className: "Words")
    query.findObjectsInBackgroundWithBlock { (returnedData, error) -> Void in
      if error != true {
        for item in returnedData{
          if let dictionaryForWord = item as? PFObject{
            self.arrayOfWords.append(dictionaryForWord["word"] as String)
          }
        }
        
      }
    }
  }
  
  func parseUserString(theString: String) -> String {
    if self.arrayOfWords.isEmpty {
      self.getAllWords()
      return "No Offensive Words Available"
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
  
  
//End Class
}