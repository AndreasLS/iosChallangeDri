//
//  CellItemView.swift
//  DribbbleProj
//
//  Created by Andre Luiz Salla on 04/10/17.
//  Copyright © 2017 Andre Luiz Salla. All rights reserved.
//

import UIKit
import AlamofireImage

class CellItemView: UICollectionViewCell {
    
    @IBOutlet weak var imageShot: UIImageView!
    @IBOutlet weak var viewCount: UILabel!
    @IBOutlet weak var background: UIView!
    
    var viewModel: CellItemViewModel? {
        didSet {
            if oldValue == nil {
                adjustLayout()
            }
            configure()
        }
    }
    
    private func adjustLayout() {
        background.layer.cornerRadius = 3.0
        background.layer.borderColor = UIColor.lilyWhite.cgColor
        background.layer.borderWidth = 1.0
        background.layer.masksToBounds = false
        background.layer.shadowColor = UIColor.alto.cgColor
        background.layer.shadowOffset = CGSize.init(width: 0, height: 3)
        background.layer.shadowOpacity = 0.5
        
        let tap = UITapGestureRecognizer.init()
        tap.addTarget(self, action: #selector(selectCell))
        background.addGestureRecognizer(tap)
    }
    
    private func configure() {
        
        imageShot.image = nil
        guard let viewModel = viewModel else {return}
        
        let nf = NumberFormatter.init()
        nf.numberStyle = .none
        viewCount.text = nf.string(for: viewModel.viewCount) ?? "-"
        if let url = URL.init(string: viewModel.imageSmall) {
            imageShot.af_setImage(withURL: url, placeholderImage: nil, filter: nil, progress: nil, progressQueue: DispatchQueue.global(), imageTransition: UIImageView.ImageTransition.crossDissolve(0.6), runImageTransitionIfCached: false, completion: nil)
        }
        
    }
    
    @objc
    private func selectCell() {
        viewModel?.select()
    }
    
}
