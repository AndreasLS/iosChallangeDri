//
//  Parseable.swift
//  DribbbleProj
//
//  Created by Andre Luiz Salla on 04/10/17.
//  Copyright © 2017 Andre Luiz Salla. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol Parseable {
    
    init?(_ json: JSON)
    init?(_ data: Data?)
}

extension Parseable {
    
    init? (_ data: Data?) {
        guard let data = data else {
            return nil
        }
        self.init(JSON.init(data: data))
    }
}

struct ArrayParseable<T>: Parseable where T: Parseable {
    let array: [T]
    init?(_ json: JSON) {
        array = json.array?.flatMap{T.init($0)} ?? []
    }
}
