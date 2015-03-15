//
//  AddViewController
//  Offend
//
//  Created by Jon Vogel on 3/10/15.
//  Copyright (c) 2015 Jon Vogel. All rights reserved.
//

import UIKit


class AddViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate  {
  
  
  @IBOutlet weak var txtInputField: UITextField!
  
  @IBOutlet weak var swtchRacist: UISwitch!
  
  @IBOutlet weak var swtchSexist: UISwitch!
  
  @IBOutlet weak var txtDefinition: UITextView!
  
  @IBOutlet weak var addWordButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.txtInputField.delegate = self
    self.txtDefinition.delegate = self
    self.addWordButton.layer.borderWidth = 2.0
    self.addWordButton.layer.borderColor = UIColor.blueColor().CGColor
    self.addWordButton.layer.cornerRadius = 5
    self.txtInputField.layer.borderWidth = 2.0
    self.txtInputField.layer.borderColor = UIColor.blueColor().CGColor
    self.txtInputField.layer.cornerRadius = 5
    self.txtDefinition.layer.borderWidth = 2.0
    self.txtDefinition.layer.borderColor = UIColor.blueColor().CGColor
    self.txtDefinition.layer.cornerRadius = 5
  
    self.navigationItem.title = "Add A Word!"
  }
  
  
  @IBAction func addWordAction(sender: AnyObject) {
    
    self.txtInputField.resignFirstResponder()
    
    
    var wordToAdd: NSString = self.txtInputField.text.capitalizedString
    
    if wordToAdd == "" {
      let alertController = UIAlertController(title: "No Can Do", message: "We need a word dude.", preferredStyle: UIAlertControllerStyle.Alert)
      let alertActionDismiss = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
      alertController.addAction(alertActionDismiss)
      self.presentViewController(alertController, animated: true, completion: nil)
      return
    } else if wordToAdd.componentsSeparatedByString(" ").count > 1 {
      let alertController = UIAlertController(title: "No Can Do", message: "No more than one word.", preferredStyle: UIAlertControllerStyle.Alert)
      let alertActionDismiss = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
      alertController.addAction(alertActionDismiss)
      self.presentViewController(alertController, animated: true, completion: nil)
      return
    }
    
    
    OffensiveEngine.sharedEngine.checkIfWordExists(wordToAdd, completion: { (test) -> Void in
      if test == false {
        let alertController = UIAlertController(title: "Confirmation", message: "Are you shure you want to submit \(wordToAdd) to the global data base?", preferredStyle: UIAlertControllerStyle.Alert)
        
        let alertActionDismiss = UIAlertAction(title: "No", style: UIAlertActionStyle.Default, handler: nil)
        let alertActionSend = UIAlertAction(title: "Submit", style: UIAlertActionStyle.Default) { (action) -> Void in
          
          var badWordToAdd = PFObject(className: "Words")
          badWordToAdd["word"] = wordToAdd
          badWordToAdd["isRacist"] = self.swtchRacist.on
          badWordToAdd["isSexist"] = self.swtchSexist.on
          badWordToAdd["definition"] = self.txtDefinition.text
          badWordToAdd.saveInBackgroundWithBlock { (didSave, error) -> Void in
            if didSave {
              println("Save Success")
              self.txtInputField.text = ""
              self.txtDefinition.text = ""
            }else{
              println("Save Fail")
            }
          }
        }
        alertController.addAction(alertActionDismiss)
        alertController.addAction(alertActionSend)
        self.presentViewController(alertController, animated: true, completion: nil)
      }else{
        let alertController = UIAlertController(title: "No Can Do", message: "\(wordToAdd) is already in the data base, please contribute something original.", preferredStyle: UIAlertControllerStyle.Alert)
        let alertActionDismiss = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        alertController.addAction(alertActionDismiss)
        self.presentViewController(alertController, animated: true, completion: nil)
      }
    })
  }
  
  func textViewDidBeginEditing(textView: UITextView) {
    if textView == self.txtDefinition{
      if self.txtDefinition.text == "Definition"{
        self.txtDefinition.text = ""
      }
    }
  }
  
  func textViewDidEndEditing(textView: UITextView) {
    self.txtDefinition.resignFirstResponder()
  }
  
  
  //MARK: text field functions
  func textFieldDidBeginEditing(textField: UITextField) {
    if textField == self.txtInputField {
      if self.txtInputField.text == "Word"{
        self.txtInputField.text = ""
      }
    }
  }
  
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    
    self.txtInputField.resignFirstResponder()
    return true
    
  }
  
  override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
  
    if self.txtInputField.isFirstResponder() == true {
      self.txtInputField.resignFirstResponder()
    }else if self.txtDefinition.isFirstResponder() == true {
      self.txtDefinition.resignFirstResponder()
    }
    
  }
  
  
}