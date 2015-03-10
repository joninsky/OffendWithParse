//
//  OffendTests.swift
//  OffendTests
//
//  Created by Jon Vogel on 3/9/15.
//  Copyright (c) 2015 Jon Vogel. All rights reserved.
//

import UIKit
import XCTest

class OffendTests: XCTestCase {
    
  var delegate: AppDelegate?
  
  
  
  
  override func setUp() {
        super.setUp()
    
    self.delegate = UIApplication.sharedApplication().delegate as? AppDelegate
    
    
    
    
    }
    
    override func tearDown() {
      
      self.delegate = nil
      
      super.tearDown()
    }
    
    func testAppLaunch() {
      XCTAssertNotNil(self.delegate, "Delegate is Nil")
    }
  
  
  func testWindowInstatniation(){
    
    XCTAssertNotNil(self.delegate?.window, "Window Not Nill")
  
  }
  
  func testForRootViewController(){
    
    
    XCTAssertNotNil(self.delegate?.window?.rootViewController, "App has a root view controller")
    
  }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
