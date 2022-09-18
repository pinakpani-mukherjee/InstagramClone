//
//  HomeFeedCellType.swift
//  InstagramClone
//
//  Created by Pinakpani Mukherjee on 2022/09/18.
//

import Foundation

enum HomeFeedCellType {
    case poster(viewModel:PosterCollectionViewCellViewModel)
    case post(viewModel:PostCollectionViewCellViewModel)
    case actions(viewModel:PostActionsCollectionsViewCellViewModel)
    case likeCount(viewModel:PostLikesCollectionViewCellViewModel)
    case caption(viewModel:PostCaptionCollectionViewCellViewModel)
    case timestamp(viewModel:PostDatetimeCollectionViewCellViewModel)
}
