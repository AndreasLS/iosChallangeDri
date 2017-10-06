//
//  Shot.swift
//  DribbbleProj
//
//  Created by Andre Luiz Salla on 04/10/17.
//  Copyright © 2017 Andre Luiz Salla. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Shot: Parseable {
    
    let id: Int
    let title: String
    let description: String
    let imageSmall: String
    let imageLarge: String
    let viewCount: Int
    let userName: String
    let avatarUser: String?
    
    init?(_ json: JSON) {
        guard let id = json["id"].int,
            let title = json["title"].string,
            let description = json["description"].string,
            let imageSmall = json["images"]["teaser"].string,
            let imageLarge = json["images"]["normal"].string,
            let viewCount = json["views_count"].int,
            let userName = json["user"]["name"].string else {
                return nil
        }
        self.id = id
        self.title = title
        self.description = description
        self.imageSmall = imageSmall
        self.imageLarge = imageLarge
        self.viewCount = viewCount
        self.userName = userName
        
        self.avatarUser = json["user"]["avatar_url"].string
    }
    
}
