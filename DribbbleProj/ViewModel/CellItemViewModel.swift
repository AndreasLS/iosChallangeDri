//
//  CellItemViewModel.swift
//  DribbbleProj
//
//  Created by Andre Luiz Salla on 04/10/17.
//  Copyright © 2017 Andre Luiz Salla. All rights reserved.
//

import Foundation

protocol CellItemViewModelDelegate {
    func select(id: Int)
}

class CellItemViewModel {
    
    var delegate: CellItemViewModelDelegate?
    
    let imageSmall: String
    let viewCount: Int
    let id: Int
    
    init(_ shot: Shot) {
        imageSmall = shot.imageSmall
        viewCount = shot.viewCount
        id = shot.id
    }
    
    func select() {
        delegate?.select(id: id)
    }
}
