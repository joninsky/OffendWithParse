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
  
  //Create the engine, we are not using the singleton pattern.
  var OE = OffensiveEngine()
  
  //Set up funciton where we set up the Offensive engine. 
  override func setUp() {
        super.setUp()
    
    var appParseKey = "OhF1OMRPtn1H51chOzSxtfic9vd56Aknqpg8FfWE"
    var appClientKey = "mNa69y5JRo3mRvsafomFYme1mFKYMSHv0XjbrObk"
    
    
    Parse.setApplicationId(appParseKey, clientKey: appClientKey)

    var exception = self.expectationWithDescription("Exception")
    var query = PFQuery(className: "Words")
    query.findObjectsInBackgroundWithBlock { (returnedData, error) -> Void in
      if error != true {
        for item in returnedData{
          if let dictionaryForWord = item as? PFObject{
            self.OE.arrayOfWords.append(dictionaryForWord["word"] as String)
          }
        }
        exception.fulfill()
      }
    }
    
    self.waitForExpectationsWithTimeout(10, handler: { (error) -> Void in
      
      
    })
    
    
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
    XCTAssertTrue(OE.arrayOfWords.count > 0, "Array of words in OE is 0")
  }
  
  func testOEParseStringWithEmpty(){
  
    var theString = OE.parseUserString("")
    
    let returnedWords = theString.componentsSeparatedByString(" ")
    
    XCTAssert(returnedWords.count == 2, "Didn't get the right amount of words back")
    
  }
  
  func testOEParseStringWithNoHash(){
    
    let theString = "No Good"
    
    XCTAssert(OE.parseUserString(theString) == "In order to generate an offensive word we need at least one \"#\" or nothing, Follow the Fucking directions.", "Did not get back expected string")
  }
  
  func testOEParseWithTMultipleHash() {
    
    let theString = OE.parseUserString("# # # # #")
    
    let results = theString.componentsSeparatedByString(" ")
    
    XCTAssert(results.count == 5, "Didn't get the right count")
    
  }
  
  func testWithMirroredhash(){
    
    let theString = OE.parseUserString("# this #")
    
    let results = theString.componentsSeparatedByString(" ")
    
    XCTAssertTrue(results.count == 3, "Does not equal Three")
    
  }
  
  
  
  
    
}
