//
//  GlobalStuff.swift
//  Offend
//
//  Created by Jon Vogel on 3/13/15.
//  Copyright (c) 2015 Jon Vogel. All rights reserved.
//

import Foundation

class GlobalStuff: NSObject {
  
  class var sharedInstance: GlobalStuff{
    struct Static {
      static let instance: GlobalStuff = GlobalStuff()
    }
    
    return Static.instance
  }
  
  var wantRacist: Bool!
  var wantSexist: Bool!
  
  override init() {
    super.init()
    self.wantRacist = false
    self.wantSexist = false
  }
  
  
  
  
}