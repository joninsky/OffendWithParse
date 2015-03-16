//
//  PhrasesViewController.swift
//  Offend
//
//  Created by Jon Vogel on 3/15/15.
//  Copyright (c) 2015 Jon Vogel. All rights reserved.
//

import UIKit

class PhrasesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate , UISearchBarDelegate{
  
  @IBOutlet weak var myTableView: UITableView!
  
  @IBOutlet weak var mySearchBar: UISearchBar!
  
  var arrayOfPhrases: [PFObject]?
  override func viewDidLoad() {
    super.viewDidLoad()
    self.myTableView.dataSource = self
    self.myTableView.delegate = self
    self.mySearchBar.delegate = self
    self.myTableView.registerNib(UINib(nibName: "PhraseCells", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "phraseCell")
    self.myTableView.estimatedRowHeight = 125
    self.myTableView.rowHeight = UITableViewAutomaticDimension
    
    OffensiveEngine.sharedEngine.getPhrases { (allPhrases) -> Void in
      
      self.arrayOfPhrases = allPhrases
      
      self.myTableView.reloadData()
    }
    
    self.navigationItem.title = "Phrases"
  }
  
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if self.arrayOfPhrases == nil {
      return 1
    }else{
      return self.arrayOfPhrases!.count
    }
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let Cell = tableView.dequeueReusableCellWithIdentifier("phraseCell", forIndexPath: indexPath) as PhraseCell
    
    Cell.layer.borderWidth = 2.0
    Cell.layer.borderColor = UIColor.blueColor().CGColor
    Cell.layer.cornerRadius = 5
    Cell.phraseLabel.text = ""
    Cell.phraseImage.image = nil
    
    if self.arrayOfPhrases == nil {
      Cell.phraseLabel.text = "No Phrases"
    } else if self.arrayOfPhrases?.count == 0{
      Cell.phraseLabel.text = "User does not exist or has no posts, check capitalization on your user search."
    }else{
      let phrase = self.arrayOfPhrases![indexPath.row]
      Cell.phraseLabel.text = phrase["phrase"] as? String
      if let theUser = phrase["user"] as? PFObject {
        OffensiveEngine.sharedEngine.getUserName(theUser.objectId, completion: { (returnedString) -> Void in
          Cell.postedByLabel.text = "Posted By: \(returnedString)"
          
        })
        
        println(theUser.objectId)
      }
      if let image = phrase["attachedImage"] as? PFFile{
        image.getDataInBackgroundWithBlock({ (imageData, error) -> Void in
          Cell.phraseImage.image = UIImage(data: imageData)
        })
      }else{
        let imageURL = NSBundle.mainBundle().pathForResource("Icon-76", ofType: "png")
      
        let defaultImage = UIImage(contentsOfFile: imageURL!)
        
        Cell.phraseImage.image = defaultImage
      }
      Cell.phraseLabel.layer.borderWidth = 2.0
      Cell.phraseLabel.layer.borderColor = UIColor.blueColor().CGColor
      Cell.phraseLabel.layer.cornerRadius = 5
    }
    
    Cell.layoutIfNeeded()
    return Cell
    
  }
  
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    OffensiveEngine.sharedEngine.findPostsForUser(searchBar.text, completion: { (newObjects) -> Void in
      
      self.arrayOfPhrases = newObjects
      self.myTableView .reloadData()
      self.mySearchBar.resignFirstResponder()
      
    })
    
  }
  
  
  @IBAction func refreshAllPosts(sender: AnyObject) {
    
    OffensiveEngine.sharedEngine.getPhrases { (allPhrases) -> Void in
      
      self.arrayOfPhrases = allPhrases
      
      self.myTableView.reloadData()
    }
    
  }
  

}