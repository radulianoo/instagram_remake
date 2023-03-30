//
//  ViewController.swift
//  InstagramRemake
//
//  Created by Octav Radulian on 22.03.2023.
//

import UIKit

//home VC for the user with posts

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    private var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Home"
        
        configureCollectionView()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
    }
    
    func configureCollectionView() {
        let sectionHeight: CGFloat = 240 + view.width
        
        //we define it here because we have acess now to self.view.width
        let collectionView = UICollectionView(frame: .zero,
                              collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { index, _ -> NSCollectionLayoutSection? in
            //components for the compositionalLayout - item
            let posterItems = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(60)))
            
            //one Bigger cell for the post
            let postItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1)))
            
            //actions cell
            let actionItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40)))
            
            //like count cell
            let likeCountItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40)))
            
            //captions cell
            let captionItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(60)))
            
            //timestamp cell
            let timeStampItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40)))
            
            //group
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(sectionHeight)),
                subitems: [posterItems, postItem, actionItem, likeCountItem, captionItem, timeStampItem])
            //section
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 0, bottom: 10, trailing: 0)
            return section
        }))
        
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self,
                                forCellWithReuseIdentifier: "cell")
        
        self.collectionView = collectionView
    }

    //MARK: - CollectionView Delegate & DataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    //one cell for the header , one for the post , one for the like etc
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    let colors: [UIColor] = [.red, .blue, .green, .cyan, .magenta, .orange]

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.contentView.backgroundColor = colors[indexPath.row]
        return cell
    }
    
}

