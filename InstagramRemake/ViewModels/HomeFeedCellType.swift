//
//  HomeFeedCellType.swift
//  InstagramRemake
//
//  Created by Octav Radulian on 31.03.2023.
//

import Foundation

enum HomeFeedCellType {
    case poster(viewModel: PosterCollectionViewCellViewModel)
    case post(viewModel: PostCollectionViewCellViewModel)
    case actions(viewModel:PostActionsCollectionViewCellViewModel)
    case likeCount(viewModel: PostLikesCollectionViewCellViewModel)
    case caption(viewModel: PostCaptionCollectionViewCellViewModel)
    case timestamp(viewModel:PostDateTimeCollectionViewCellViewModel)
}
