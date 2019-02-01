//
//  ProfileViewController.swift
//  FoxCast
//
//  Created by Vaibhav Parmar on 31/01/19.
//  Copyright © 2019 Nickelfox. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    
    var viewModel = ProfileViewModel()
    var isGridView: Bool = false
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
        
    }
    
    private func initialSetup() {
        self.setupCollectionView()
        self.isGridView = FirebaseRemoteConfig.shared.boolValue(forKey: .gridView)
        let paramText = self.isGridView ? "Grid" : "List"
        Analytics.logEvent("viewOpened", parameters: ["layout": paramText])
    }
    
}

extension ProfileViewController: UICollectionViewDataSource {
    
    private func setupCollectionView() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.registerCell(ListCollectionCell.self)
        self.collectionView.registerCell(GridCollectionCell.self)
        self.collectionView.contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.rowCount
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = self.isGridView ? GridCollectionCell.reuseIdentifier : ListCollectionCell.reuseIdentifier
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier,
                                                      for: indexPath) as! CollectionViewCell
        cell.item = self.viewModel.cellModel(at: indexPath)
        cell.delegate = self
        return cell
    }
}

extension ProfileViewController: UICollectionViewDelegate {
    
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let gridViewSize = CGSize(width: collectionView.bounds.width / 2 - 24, height: 165)
        let listViewSize = CGSize(width: collectionView.bounds.width - 32, height: 205)
        
        return self.isGridView ? gridViewSize : listViewSize
    }
}
