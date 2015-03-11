//
//  PrimaryViewController
//  Offend
//
//  Created by Jon Vogel on 3/9/15.
//  Copyright (c) 2015 Jon Vogel. All rights reserved.
//

import UIKit
import QuartzCore

class PrimaryViewController: UIViewController, UITextViewDelegate{

  //MARK: Properties
  @IBOutlet weak var txtMyPhrase: UITextView!
  @IBOutlet weak var generateButton: UIButton!
  
  var badWords: [AnyObject]?
  var arrayOfWords = [String]()
  
  //MARK: Lifecycle methods
  override func viewDidLoad() {
    super.viewDidLoad()
    self.txtMyPhrase.delegate = self
    //Set up the borders of the UIElements
    self.generateButton.layer.borderWidth = 2.0
    self.generateButton.layer.borderColor = UIColor.blueColor().CGColor
    self.generateButton.layer.cornerRadius = 5
    self.txtMyPhrase.layer.borderWidth = 2.0
    self.txtMyPhrase.layer.borderColor = UIColor.blueColor().CGColor
    self.txtMyPhrase.layer.cornerRadius = 5
    
    //Set up the navigation controller apperance
    self.navigationItem.title = "Offend"
    self.navigationController?.navigationBar.barTintColor = UIColor.blueColor()
    
    self.arrayOfWords = OffensiveEngine.sharedEngine.arrayOfWords

  }
  
  
  //MARK: Text View delegate methods
  
  
  func textViewDidBeginEditing(textView: UITextView) {
    
    self.txtMyPhrase.text = ""
  }
  
  
  func textViewShouldEndEditing(textView: UITextView) -> Bool {
    self.txtMyPhrase.resignFirstResponder()
    return true
  }
  

  //MARK: Action outlet
  @IBAction func generate(sender: AnyObject) {
    
      let phraseToParse = self.txtMyPhrase.text
    
      self.txtMyPhrase.text = OffensiveEngine.sharedEngine.parseUserString(phraseToParse)
  }
  
  @IBAction func presentInfo(sender: AnyObject) {
    
    var alertController = UIAlertController(title: "Instructions", message: "Put an asterisk \"*\" where you want bad words to appear", preferredStyle: UIAlertControllerStyle.Alert)
    
    var dismissAction = UIAlertAction(title: "Fuck Off", style: UIAlertActionStyle.Default, handler: nil)
    
    alertController.addAction(dismissAction)
    
    self.presentViewController(alertController, animated: true, completion: nil)
    
  }
  
  //MARK: Self overide functions
  override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
    self.txtMyPhrase.resignFirstResponder()
  }
  
  
  

}

