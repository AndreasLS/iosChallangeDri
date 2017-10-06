//
//  UIImage+Utils.swift
//  DribbbleProj
//
//  Created by Andre Luiz Salla on 04/10/17.
//  Copyright © 2017 Andre Luiz Salla. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    convenience init?(image: DribbbleImages) {
        self.init(named: image.name)
    }
    
}
