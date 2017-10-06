//
//  DribbbleStrings.swift
//  DribbbleProj
//
//  Created by Andre Luiz Salla on 06/10/17.
//  Copyright © 2017 Andre Luiz Salla. All rights reserved.
//

import Foundation

enum DribbbleStrings {
    
    case erroDesconhecido
    case erro
    case ok
    
    var string: String {
        switch self {
        case .erroDesconhecido: return NSLocalizedString("msg_erro_desconhecido", comment: "")
        case .erro: return NSLocalizedString("label_erro", comment: "")
        case .ok: return NSLocalizedString("label_ok", comment: "")
        }
    }
    
}
