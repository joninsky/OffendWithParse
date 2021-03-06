//
//  ShareViewController.swift
//  Offend
//
//  Created by Jon Vogel on 3/13/15.
//  Copyright (c) 2015 Jon Vogel. All rights reserved.
//

import UIKit

class ShareViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  @IBOutlet weak var myImageView: UIImageView!
  @IBOutlet weak var txtPhraseToShare: UILabel!
  @IBOutlet weak var shareButton: UIButton!
  var thePhrase: String!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
  
    txtPhraseToShare.text = thePhrase
    
    
    txtPhraseToShare.layer.borderWidth = 2.0
    txtPhraseToShare.layer.borderColor = UIColor.blueColor().CGColor
    txtPhraseToShare.layer.cornerRadius = 5
    
    shareButton.layer.borderWidth = 2.0
    shareButton.layer.borderColor = UIColor.blueColor().CGColor
    shareButton.layer.cornerRadius = 5
    
    myImageView.layer.borderWidth = 2.0
    myImageView.layer.borderColor = UIColor.blueColor().CGColor
    myImageView.layer.cornerRadius = 5
    
    self.navigationItem.title = "Share"
    
  }
  
  
  @IBAction func shareAction(sender: AnyObject) {
    
    if GlobalStuff.sharedInstance.userName == "" {
      let alertController = UIAlertController(title: "Name", message: "We need a user name from you in order to share your offensive phrase", preferredStyle: UIAlertControllerStyle.Alert)
      
      //Dismiss Alert action
      let alertActionDismiss = UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
      })
      //Create action
      let alertActionCreate = UIAlertAction(title: "Create", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
        //Create a UIText Field out of the first object int he array of text fields
        let field = alertController.textFields?.first as UITextField
        //Use Offensive engine singleton to check if user exists
        GlobalStuff.sharedInstance.checkIfUserExists(field.text, completion: { (decision) -> Void in
          if decision == false {
            GlobalStuff.sharedInstance.makeUser(field.text)
            var imageData: NSData?
            var imageFile: PFFile?
            if self.myImageView.image != nil {
              imageData = UIImagePNGRepresentation(self.myImageView.image)
              imageFile = PFFile(name: "NewImage.png", data: imageData, contentType: "Image")
            }
            let myNewPhrase = PFObject(className: "SavedPhrases")
            myNewPhrase.setObject(self.txtPhraseToShare.text, forKey: "phrase")
            myNewPhrase.setObject(GlobalStuff.sharedInstance.userObject!, forKey: "user")
            if imageFile != nil{
              myNewPhrase["attachedImage"] = imageFile
            }
            myNewPhrase.saveInBackgroundWithBlock({ (didSave, error) -> Void in
              if didSave {
                println("Phrase Saved")
              }else{
                println("Phrase not saved")
              }
            })
          }else{
            println("User Exists!")
          }
        })
      })
      
      //Add the actions and present the Controller
      alertController.addAction(alertActionDismiss)
      alertController.addAction(alertActionCreate)
      alertController.addTextFieldWithConfigurationHandler({ (theField) -> Void in
        theField.placeholder = "New Name"
        
      })
      presentViewController(alertController, animated: true, completion: nil)
      
    }else{
      let alertController = UIAlertController(title: "You Shure?", message: "Are you shure you want to upload this phrase? All phrases can be viewed in the Explore tab.", preferredStyle: UIAlertControllerStyle.Alert)
      
      //Dismiss Alert action
      let alertActionDismiss = UIAlertAction(title: "Yes!", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
        var imageData: NSData?
        var imageFile: PFFile?
        if self.myImageView.image != nil {
          imageData = UIImagePNGRepresentation(self.myImageView.image)
          imageFile = PFFile(name: "NewImage.png", data: imageData, contentType: "Image")
        }
        self.txtPhraseToShare.text = self.thePhrase
        let newPhrase = PFObject(className: "SavedPhrases")
        newPhrase["phrase"] = self.txtPhraseToShare.text
        newPhrase["user"] = GlobalStuff.sharedInstance.userObject!
        if imageFile != nil{
          newPhrase["attachedImage"] = imageFile
        }
        newPhrase.saveInBackgroundWithBlock({ (didSave, error) -> Void in
          if didSave {
            println("Phrase Saved")
            self.navigationController?.popViewControllerAnimated(true)
          }else{
            println("Phrase not saved")
          }
        })
      })
      
      alertController.addAction(alertActionDismiss)
      presentViewController(alertController, animated: true, completion: nil)
    }
  }
  
  @IBAction func cameraButtonAction(sender: AnyObject) {
    let imagePickerController = UIImagePickerController()
    imagePickerController.sourceType = UIImagePickerControllerSourceType.Camera
    imagePickerController.allowsEditing = true
    imagePickerController.delegate = self
    self.presentViewController(imagePickerController, animated: true, completion: nil)
  }
  
  //MARK: Image Picker Controller delegate
  
  func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
    
    self.myImageView.image = info[UIImagePickerControllerEditedImage] as? UIImage
    //self.navigationController?.popViewControllerAnimated(true)
    picker.dismissViewControllerAnimated(true, completion: nil)
  }
  
  func imagePickerControllerDidCancel(picker: UIImagePickerController) {
    picker.dismissViewControllerAnimated(true, completion: nil)
  }
  
  
  
  
}