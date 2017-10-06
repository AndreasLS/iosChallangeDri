//
//  DribbbleColors.swift
//  DribbbleProj
//
//  Created by Andre Luiz Salla on 04/10/17.
//  Copyright © 2017 Andre Luiz Salla. All rights reserved.
//

import Foundation
import UIKit

enum DribbbleColors {
    
    case navigation
    
    var color: UIColor {
        switch self {
            case .navigation: return .mineShaft
        }
    }
}

extension UIColor {
    
    class var mineShaft: UIColor {return UIColor(red:0.20, green:0.20, blue:0.20, alpha:1.0)}
    class var lilyWhite: UIColor {return UIColor(red:0.92, green:0.92, blue:0.92, alpha:1.0)}
    class var alto: UIColor {return UIColor(red:0.85, green:0.85, blue:0.85, alpha:1.0)}
}
