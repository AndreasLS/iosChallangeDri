//
//  ShotViewModel.swift
//  DribbbleProj
//
//  Created by Andre Luiz Salla on 05/10/17.
//  Copyright © 2017 Andre Luiz Salla. All rights reserved.
//

import Foundation

class ShotViewModel {
    
    private let shot: Shot
    var titulo: String {
        return shot.title
    }
    var autor: String {
        return shot.userName
    }
    var shotUrl: String {
        return shot.imageLarge
    }
    var descricao: String {
        return shot.description
    }
    
    var avatar: String {
        return shot.avatarUser ?? ""
    }
    
    init(shot: Shot) {
        self.shot = shot
    }
    
}
