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
    private var viewModels = [[HomeFeedCellType]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Home"
        
        configureCollectionView()
        fetchPosts()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
    }
    
    private func fetchPosts() {
        //mock data
        let postData: [HomeFeedCellType] = [
            .poster(viewModel: PosterCollectionViewCellViewModel(username: "Octav", profilePictureURL: URL(string: "https://images.unsplash.com/profile-1674906760257-dad1baa28b74?dpr=1&auto=format&fit=crop&w=150&h=150&q=60&crop=faces&bg=fff")!)),
            .post(viewModel: PostCollectionViewCellViewModel(postURL: URL(string: "https://www.usnews.com/object/image/00000186-7a58-d975-aff7-fffbc8910000/iguazu-falls-stock.jpg?update-time=1677089883729&size=responsive970")!)),
            .actions(viewModel: PostActionsCollectionViewCellViewModel(isLiked: true)),
            .likeCount(viewModel: PostLikesCollectionViewCellViewModel(likers: ["NicoletteOshea"])),
            .caption(viewModel: PostCaptionCollectionViewCellViewModel(username: "Octav", caption: "This is awsome post")),
            .timestamp(viewModel: PostDateTimeCollectionViewCellViewModel(date: Date()))
        ]
        viewModels.append(postData)
        collectionView?.reloadData()
    }
    
    //MARK: - CollectionView Delegate & DataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModels.count
    }
    //one cell for the header , one for the post , one for the like etc
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels[section].count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellType = viewModels[indexPath.section][indexPath.row]
        
        switch cellType {
            
        case .poster(viewModel: let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.identifier, for: indexPath) as? PosterCollectionViewCell else {
                fatalError()
            }
            cell.configure(with: viewModel)
            return cell
            
        case .post(viewModel: let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCollectionViewCell.identifier, for: indexPath) as? PostCollectionViewCell else {
                fatalError()
            }
            cell.configure(with: viewModel)
            return cell
            
        case .actions(viewModel: let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostActionsCollectionViewCell.identifier, for: indexPath) as? PostActionsCollectionViewCell else {
                fatalError()
            }
            cell.configure(with: viewModel)
            return cell
            
        case .likeCount(viewModel: let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostLikesCollectionViewCell.identifier, for: indexPath) as? PostLikesCollectionViewCell else {
                fatalError()
            }
            cell.configure(with: viewModel)
            return cell
            
        case .caption(viewModel: let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCaptionsCollectionViewCell.identifier, for: indexPath) as? PostCaptionsCollectionViewCell else {
                fatalError()
            }
            cell.configure(with: viewModel)
            return cell
            
        case .timestamp(viewModel: let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostDateTimeCollectionViewCell.identifier, for: indexPath) as? PostDateTimeCollectionViewCell else {
                fatalError()
            }
            cell.configure(with: viewModel)
            return cell
        }
        
        
    }
    
}

extension HomeViewController {
    
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
        
        collectionView.register(PosterCollectionViewCell.self,
                                forCellWithReuseIdentifier: PosterCollectionViewCell.identifier)
        collectionView.register(PostCollectionViewCell.self,
                                forCellWithReuseIdentifier: PostCollectionViewCell.identifier)
        collectionView.register(PostActionsCollectionViewCell.self,
                                forCellWithReuseIdentifier: PostActionsCollectionViewCell.identifier)
        collectionView.register(PostLikesCollectionViewCell.self,
                                forCellWithReuseIdentifier: PostLikesCollectionViewCell.identifier)
        collectionView.register(PostCaptionsCollectionViewCell.self,
                                forCellWithReuseIdentifier: PostCaptionsCollectionViewCell.identifier)
        collectionView.register(PostDateTimeCollectionViewCell.self,
                                forCellWithReuseIdentifier: PostDateTimeCollectionViewCell.identifier)
        
        
        self.collectionView = collectionView
    }
    
}

