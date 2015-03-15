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
  @IBOutlet var doneButton: UIBarButtonItem!
  @IBOutlet weak var txtViewHeight: NSLayoutConstraint!
  @IBOutlet weak var racistSwitch: UISwitch!
  @IBOutlet weak var sexistSwitch: UISwitch!
  
  
  var userString: String = "Select to add your own words! Put an \"#\" where you want an offensive word to appear."
  
  //var screenHeight: CGFloat?
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
    self.txtMyPhrase.text = self.userString
    
    //Set up the navigation controller apperance
    self.navigationItem.title = "Offend"
    self.navigationController?.navigationBar.barTintColor = UIColor.blueColor()
    self.doneButton.enabled = false
    self.doneButton.title = nil
    
    self.racistSwitch.on = GlobalStuff.sharedInstance.wantRacist
    self.sexistSwitch.on = GlobalStuff.sharedInstance.wantSexist
    
  }
  
  
  //MARK: Text View delegate methods
  func textViewDidBeginEditing(textView: UITextView) {
    
    self.txtViewHeight.constant = 120
    self.view.needsUpdateConstraints()
    
    UIView.animateWithDuration(1, animations: { () -> Void in
      self.view.layoutIfNeeded()
    })
    self.doneButton.enabled = true
    self.doneButton.title = "Done"
    
    self.txtMyPhrase.text = ""
  }
  
  
  func textViewShouldEndEditing(textView: UITextView) -> Bool {
    self.txtViewHeight.constant = 8
    self.view.needsUpdateConstraints()
    
    UIView.animateWithDuration(0.5, animations: { () -> Void in
      self.view.layoutIfNeeded()
    })
    
    self.doneButton.enabled = false
    self.doneButton.title = nil
    self.userString = self.txtMyPhrase.text
    self.txtMyPhrase.resignFirstResponder()
    return true
  }
  
  
  

  //MARK: Action outlet
  @IBAction func generate(sender: AnyObject) {
   

    self.txtMyPhrase.resignFirstResponder()
    
    var phraseToParse: String = self.userString
    self.txtMyPhrase.text = OffensiveEngine.sharedEngine.parseUserString(phraseToParse)
  }
  
  @IBAction func presentInfo(sender: AnyObject) {
    
    var alertController = UIAlertController(title: "Instructions", message: "Put an asterisk \"#\" where you want bad words to appear", preferredStyle: UIAlertControllerStyle.Alert)
    
    var dismissAction = UIAlertAction(title: "Fuck Off", style: UIAlertActionStyle.Default, handler: nil)
    
    alertController.addAction(dismissAction)
    
    self.presentViewController(alertController, animated: true, completion: nil)
    
  }
  
  @IBAction func racistSelect(sender: AnyObject) {
    GlobalStuff.sharedInstance.wantRacist = self.racistSwitch.on
    OffensiveEngine.sharedEngine.getAllWords(GlobalStuff.sharedInstance.wantRacist, wantSexist: GlobalStuff.sharedInstance.wantSexist) { (newResults) -> Void in
      
      OffensiveEngine.sharedEngine.arrayOfWords = newResults
    }
    
  }
  
  @IBAction func sexistSelect(sender: AnyObject) {
    GlobalStuff.sharedInstance.wantSexist = self.sexistSwitch.on
    OffensiveEngine.sharedEngine.getAllWords(GlobalStuff.sharedInstance.wantRacist, wantSexist: GlobalStuff.sharedInstance.wantSexist) { (newResults) -> Void in
      
      OffensiveEngine.sharedEngine.arrayOfWords = newResults
    }
  }
  
  
  @IBAction func doneButtonPressed(sender: AnyObject) {
    self.txtMyPhrase.resignFirstResponder()
  }
  
  
  //MARK: Self overide functions
  override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
    self.txtMyPhrase.resignFirstResponder()
  }
  
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
   let DVC = segue.destinationViewController as ShareViewController
    DVC.thePhrase = self.txtMyPhrase.text
  }
  
  

}

