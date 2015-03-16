//
//  PhraseCell.swift
//  Offend
//
//  Created by Jon Vogel on 3/15/15.
//  Copyright (c) 2015 Jon Vogel. All rights reserved.
//

import Foundation

import Foundation
import QuartzCore

class PhraseCell: UITableViewCell {
  

  @IBOutlet weak var phraseImage: UIImageView!
  
  @IBOutlet weak var phraseLabel: UILabel!
  
  @IBOutlet weak var postedByLabel: UILabel!
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    //    self.lblWord?.layer.borderWidth = 2.0
    //    self.lblWord?.layer.borderColor = UIColor.blueColor().CGColor
    //    self.lblWord?.layer.cornerRadius = 5
    //    self.lblDefinition?.layer.borderWidth = 2.0
    //    self.lblDefinition?.layer.borderColor = UIColor.blueColor().CGColor
    //    self.lblDefinition?.layer.cornerRadius = 5
  }
  
  //  override init(frame: CGRect) {
  //    super.init(frame: frame)
  //
  //    self.lblWord?.layer.borderWidth = 2.0
  //    self.lblWord?.layer.borderColor = UIColor.blueColor().CGColor
  //    self.lblWord?.layer.cornerRadius = 5
  //    self.lblDefinition?.layer.borderWidth = 2.0
  //    self.lblDefinition?.layer.borderColor = UIColor.blueColor().CGColor
  //    self.lblDefinition?.layer.cornerRadius = 5
  //
  //  }
  //
  //  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
  //    super.init(style: style, reuseIdentifier: reuseIdentifier)
  //
  //    self.lblWord?.layer.borderWidth = 2.0
  //    self.lblWord?.layer.borderColor = UIColor.blueColor().CGColor
  //    self.lblWord?.layer.cornerRadius = 5
  //    self.lblDefinition?.layer.borderWidth = 2.0
  //    self.lblDefinition?.layer.borderColor = UIColor.blueColor().CGColor
  //    self.lblDefinition?.layer.cornerRadius = 5
  //  }
  
  
  
}