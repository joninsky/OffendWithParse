//
//  AllWordsViewController.swift
//  Offend
//
//  Created by Jon Vogel on 3/14/15.
//  Copyright (c) 2015 Jon Vogel. All rights reserved.
//

import UIKit

class AllWordViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
  
  @IBOutlet weak var myTableView: UITableView!
  
  var arrayOfAllWords: [PFObject]?

  override func viewDidLoad(){
    super.viewDidLoad()
    self.myTableView.delegate = self
    self.myTableView.dataSource = self
    OffensiveEngine.sharedEngine.getWords { (data) -> Void in
      
      self.arrayOfAllWords = data
      self.myTableView.reloadData()
    }
  
    self.navigationItem.title = "All Words!"
    self.myTableView.estimatedRowHeight = 100
    self.myTableView.rowHeight = UITableViewAutomaticDimension
  }
  
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    if self.arrayOfAllWords == nil {
      return 0
    }else{
      return self.arrayOfAllWords!.count
    }
  }
  
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    
    let Cell = tableView.dequeueReusableCellWithIdentifier("allCell", forIndexPath: indexPath) as AllCell
    Cell.layer.borderWidth = 2.0
    Cell.layer.borderColor = UIColor.blueColor().CGColor
    Cell.layer.cornerRadius = 5

  
    if self.arrayOfAllWords == nil {
      
      Cell.lblDefinition.text = "No Words, Check Internet Connection."
      
    }else{
      
      var word = self.arrayOfAllWords![indexPath.row]
      var w = word["word"] as? String
      
      Cell.lblWord.text = " \(w!)"
      Cell.lblDefinition.text = word["definition"] as?String
      Cell.lblWord?.layer.borderWidth = 1.0
      Cell.lblWord?.layer.borderColor = UIColor.blueColor().CGColor
      Cell.lblWord?.layer.cornerRadius = 5
      Cell.lblDefinition?.layer.borderWidth = 1.0
      Cell.lblDefinition?.layer.borderColor = UIColor.blueColor().CGColor
      Cell.lblDefinition?.layer.cornerRadius = 5

    }
    
    
    return Cell
    
  }
  
  
  
  
  
  
}