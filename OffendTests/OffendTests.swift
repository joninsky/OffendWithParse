//
//  OffendTests.swift
//  OffendTests
//
//  Created by Jon Vogel on 3/9/15.
//  Copyright (c) 2015 Jon Vogel. All rights reserved.
//

import UIKit
import XCTest
import Offend

class OffendTests: XCTestCase {
  
  
  var OE = OffensiveEngine()
  
  override func setUp() {
        super.setUp()
  
    OffensiveEngine.sharedEngine
    
    
    
    }
    
    override func tearDown() {
      
      //self.delegate = nil
      
      super.tearDown()
    }
    
    func testOEInstantiation() {
      XCTAssertNotNil(self.OE, "OE is Nil")
    }
  
    func testOESharedInstance(){
      XCTAssertNotNil(OffensiveEngine.sharedEngine, "OE Shared instance is nil")
    }
  
  func testOEArrayOfWordsNotNill() {
    XCTAssertTrue(OffensiveEngine.sharedEngine.arrayOfWords.count > 0, "Array of words in OE is 0")
  }
  
  func testOEParseStringWithEmpty(){
  
    var theString = OE.parseUserString("")
    
    let returnedWords = theString.componentsSeparatedByString(" ")
    
    XCTAssert(returnedWords.count == 2, "Didn't get the right amount of words back")
    
  }
  
  func testOEParseStringWithNoHash(){
    
    let theString = "No Good"
    
    XCTAssert(OffensiveEngine.sharedEngine.parseUserString(theString) == "In order to generate an offensive word we need at least one \"#\" or nothing, Follow the Fucking directions.", "Did not get back expected string")
  }
  
  func testOEParseWithTMultipleHash() {
    
    let theString = OE.parseUserString("# # # # #")
    
    let results = theString.componentsSeparatedByString(" ")
    
    XCTAssert(results.count == 5, "Didn't get the right count")
    
    
    
  }
  
  
  
  
    
}
