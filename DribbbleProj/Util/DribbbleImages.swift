//
//  DribbbleImages.swift
//  DribbbleProj
//
//  Created by Andre Luiz Salla on 04/10/17.
//  Copyright © 2017 Andre Luiz Salla. All rights reserved.
//

import Foundation

enum DribbbleImages {
    
    case logo
    case avatar
    case picture
    
    var name: String {
        switch self {
        case .logo: return "logo"
        case .avatar: return "avatar"
        case .picture: return "picture"
        }
        
    }
}
