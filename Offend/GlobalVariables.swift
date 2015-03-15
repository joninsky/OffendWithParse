//
//  GlobalVariables.swift
//  Offend
//
//  Created by Jon Vogel on 3/15/15.
//  Copyright (c) 2015 Jon Vogel. All rights reserved.
//

import Foundation
import CoreData

class GlobalVariables: NSManagedObject {

    @NSManaged var userName: String
    @NSManaged var wantRacist: NSNumber
    @NSManaged var wantSexist: NSNumber

}
