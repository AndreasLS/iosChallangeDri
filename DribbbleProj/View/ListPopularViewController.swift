//
//  ListPopularViewController.swift
//  DribbbleProj
//
//  Created by Andre Luiz Salla on 04/10/17.
//  Copyright © 2017 Andre Luiz Salla. All rights reserved.
//

import UIKit

class ListPopularViewController: UICollectionViewController {

    private var viewModel: ListPopularViewModel? = nil
    
    init(viewModel: ListPopularViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "ListPopularView", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = UIImageView.init(image: UIImage(image: .logo))
        self.collectionView?.register(UINib.init(nibName: "CellItemView", bundle: nil), forCellWithReuseIdentifier: "cellItemView")
        self.collectionView?.register(UINib.init(nibName: "ListPopularHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "listPopularHeader")
        viewModel?.delegate = self
        viewModel?.listPopular()
        
        let refreshControl = UIRefreshControl.init()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        collectionView?.refreshControl = refreshControl
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.shotsCount ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellItemView", for: indexPath)
        (cell as? CellItemView)?.viewModel = viewModel?.shotCellAtIndex(indexPath.row)
        return cell
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y + scrollView.frame.height) > (scrollView.contentSize.height * 0.9) {
            viewModel?.listPopular()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let suplementary = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "listPopularHeader", for: indexPath)
        return suplementary
    }
    
    @objc
    private func refresh() {
        viewModel?.refresh()
    }
    
}

extension ListPopularViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (min(self.view.frame.width, self.view.frame.height) / 2.0) - 10
        return CGSize.init(width: width, height: width)
        
    }
    
}

extension ListPopularViewController: ListPopularProtocol {
    
    func didRefresh() {
        self.collectionView?.reloadData()
    }
    
    func didSelected(next model: ShotViewModel) {
        self.present(ShotViewController.init(viewModel: model), animated: true, completion: nil)
    }
    
    func didLoadData(at index: Int) {
        collectionView?.insertItems(at: (index...(viewModel?.shotsCount  ?? 0) - 1).map{IndexPath.init(item: $0, section: 0)})
    }
    
    func didError(message: String) {
        let vc = UIAlertController.init(title: DribbbleStrings.erro.string, message: message, preferredStyle: .alert)
        vc.addAction(UIAlertAction.init(title: DribbbleStrings.ok.string, style: .default, handler: nil))
        self.present(vc, animated: true, completion: nil)
    }
    
    func stateDidChange(state: ListState) {
        switch state {
        case .loading:
            let activity = UIActivityIndicatorView.init(activityIndicatorStyle: .gray)
            activity.startAnimating()
            collectionView?.backgroundView = activity
        case .standing, .standingWithNext:
            collectionView?.backgroundView = nil
            collectionView?.refreshControl?.endRefreshing()
        case .noValue:
            collectionView?.backgroundView = nil
            collectionView?.refreshControl?.endRefreshing()
        default: break
        }
    }
    
}
