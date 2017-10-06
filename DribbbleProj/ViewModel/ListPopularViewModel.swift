//
//  ListPopularViewModel.swift
//  DribbbleProj
//
//  Created by Andre Luiz Salla on 04/10/17.
//  Copyright © 2017 Andre Luiz Salla. All rights reserved.
//

import Foundation

enum ListState {
    case none
    case loading
    case willRefresh
    case refreshing
    case standing
    case standingWithNext
    case loadingNext
    case noValue
}

protocol ListPopularProtocol {
    func didRefresh()
    func didLoadData(at index: Int)
    func didSelected(next model: ShotViewModel)
    func didError(message: String)
    func stateDidChange(state: ListState)
}

class ListPopularViewModel {
    
    var delegate: ListPopularProtocol? = .none
    var page: Int = 0
    
    private var shots: [Shot] = []
    
    public var shotsCount: Int {
        return shots.count
    }
    
    private var state: ListState = .none {
        didSet{
            if let delegate = delegate, oldValue != state {
                delegate.stateDidChange(state: state)
            }
        }
    }
    
    func shotCellAtIndex(_ index: Int) -> CellItemViewModel? {
        if shots.count > index {
            let cell = CellItemViewModel.init(shots[index])
            cell.delegate = self
            return cell
        }
        return nil
    }
    
    func refresh() {
        state = .willRefresh
        page = 0
        listPopular()
    }
    
    func listPopular() {
        guard let delegate = delegate else {return}
        if state != .none
            && state != .standingWithNext
            && state != .willRefresh {
            return
        }
        if state == .willRefresh {
            state = .refreshing
        } else if state == .standingWithNext {
            state = .loadingNext
        } else {
            state = .loading
        }
        page += 1
        ApiAccess<Shot>.listPopularShots(page: page) {[weak self] (result) in
            switch result {
            case .success(let result):
                let oldIndex = self?.shotsCount
                
                let retorno = result?.array ?? []
                let previousState = self?.state ?? .none
                
                if retorno.count == 0 {
                    self?.state = .standing
                } else {
                    self?.state = .standingWithNext
                }
                
                if previousState == .refreshing {
                    self?.shots = retorno
                    self?.delegate?.didRefresh()
                } else {
                    self?.shots += retorno
                    self?.delegate?.didLoadData(at: oldIndex ?? 0)
                }
            case .failure(let message):
                delegate.didError(message: message)
                self?.state = .standing
            }
        }
    }
    
}

extension ListPopularViewModel: CellItemViewModelDelegate {
    
    func select(id: Int) {
        if let shot = (shots.filter{$0.id == id}.first),
            let delegate = delegate {
            delegate.didSelected(next: ShotViewModel.init(shot: shot))
        }
    }
    
}
