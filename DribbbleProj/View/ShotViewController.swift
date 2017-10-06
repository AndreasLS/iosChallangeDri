//
//  ShotViewController.swift
//  DribbbleProj
//
//  Created by Andre Luiz Salla on 05/10/17.
//  Copyright © 2017 Andre Luiz Salla. All rights reserved.
//
import UIKit
import DTFoundation
import DTCoreText

class ShotViewController: UIViewController {

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var foregroundImage: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tituloLabel: UILabel!
    @IBOutlet weak var autorLabel: UILabel!
    @IBOutlet weak var descricaoLabel: UILabel!
    @IBOutlet weak var autorImage: UIImageView!
    @IBOutlet weak var backgroundView: UIView!
    
    private var viewModel: ShotViewModel?

    init(viewModel: ShotViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "ShotView", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.delegate = self
        setShot()
        adjustLayout()
    }
    
    private func adjustLayout() {
        autorImage.layer.cornerRadius = autorImage.frame.width / 2.0
        autorImage.clipsToBounds = true
        autorImage.layer.borderColor = UIColor.alto.cgColor
        autorImage.layer.borderWidth = 1.0
        foregroundImage.layer.borderWidth = 1.0
        foregroundImage.layer.borderColor = UIColor.white.withAlphaComponent(0.7).cgColor
    }
    
    private func setShot() {
        if let url = URL.init(string: viewModel?.shotUrl ?? "") {
            foregroundImage.contentMode = .center
            foregroundImage.alpha = 0.5
            foregroundImage.af_setImage(withURL: url, placeholderImage: UIImage.init(image: .picture), filter: nil, progress: nil, progressQueue: DispatchQueue.global(), imageTransition: UIImageView.ImageTransition.crossDissolve(0.6), runImageTransitionIfCached: false, completion: {[unowned self] (_) in
                self.foregroundImage.alpha = 1
                self.foregroundImage.contentMode = .scaleAspectFill
            })
            
            backgroundImage.af_setImage(withURL: url, placeholderImage: nil, filter: nil, progress: nil, progressQueue: DispatchQueue.global(), imageTransition: UIImageView.ImageTransition.crossDissolve(0.6), runImageTransitionIfCached: false, completion: nil)
        }
        if let url = URL.init(string: viewModel?.avatar ?? "") {
            autorImage.af_setImage(withURL: url, placeholderImage: UIImage.init(image: .avatar), filter: nil, progress: nil, progressQueue: DispatchQueue.global(), imageTransition: UIImageView.ImageTransition.crossDissolve(0.6), runImageTransitionIfCached: false, completion: nil)
        }
        
        tituloLabel.text = viewModel?.titulo
        autorLabel.text = viewModel?.autor
        
        let string = viewModel?.descricao ?? ""
        let attributed : NSMutableAttributedString
        do {
            attributed = try NSMutableAttributedString(data: string.data(using: String.Encoding.unicode, allowLossyConversion: true)!, options: [NSAttributedString.DocumentReadingOptionKey.documentType : NSAttributedString.DocumentType.html], documentAttributes: nil)
        } catch {
            attributed = NSMutableAttributedString.init(string: string)
        }
        attributed.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 14), range: NSRange.init(location: 0, length: attributed.length))
        
        descricaoLabel.attributedText = attributed
    }
    
    @IBAction func closeShot(_ sender: Any?) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}

extension ShotViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        foregroundImage.alpha = 1 - (scrollView.contentOffset.y / backgroundView.frame.minY)
    }
}
