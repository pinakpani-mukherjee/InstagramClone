//
//  PostActionsCollectionViewCell.swift
//  InstagramClone
//
//  Created by Pinakpani Mukherjee on 2022/09/18.
//

import UIKit

protocol PostActionsCollectionViewCellDelegate: AnyObject {
    func postActionsCollectionViewCellDidTapLike(_ cell:PostActionsCollectionViewCell, is_liked:Bool)
    func postActionsCollectionViewCellDidTapComment(_ cell:PostActionsCollectionViewCell)
    func postActionsCollectionViewCellDidTapShare(_ cell:PostActionsCollectionViewCell)
}


class PostActionsCollectionViewCell: UICollectionViewCell {
    static let identifier = "PostActionsCollectionViewCell"
    weak var delegate: PostActionsCollectionViewCellDelegate?
    private var isLiked = false
    
    private let likeButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        let image = UIImage(systemName: "suit.heart",
                        withConfiguration: UIImage.SymbolConfiguration(pointSize: 44))
        button.setImage(image, for: .normal)
        return button
    }()
    
    private let commentButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        let image = UIImage(systemName: "message",
                        withConfiguration: UIImage.SymbolConfiguration(pointSize: 44))
        button.setImage(image, for: .normal)
        return button
    }()
    
    private let shareButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        let image = UIImage(systemName: "paperplane",
                        withConfiguration: UIImage.SymbolConfiguration(pointSize: 44))
        button.setImage(image, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        contentView.addSubview(likeButton)
        contentView.addSubview(commentButton)
        contentView.addSubview(shareButton)
        
        // Configure Actions
        likeButton.addTarget(self, action: #selector(didTapLike), for: .touchUpInside)
        commentButton.addTarget(self, action: #selector(didTapComment), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(didTapShare), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc func didTapLike(){
        if self.isLiked{
            let image = UIImage(systemName: "suit.heart",
                            withConfiguration: UIImage.SymbolConfiguration(pointSize: 44))
            likeButton.setImage(image, for: .normal)
            likeButton.tintColor = .label
        }
        else{
            let image = UIImage(systemName: "suit.heart.fill",
                            withConfiguration: UIImage.SymbolConfiguration(pointSize: 44))
            likeButton.setImage(image, for: .normal)
            likeButton.tintColor = .red
        }
        delegate?.postActionsCollectionViewCellDidTapLike(self,is_liked: !isLiked )
        self.isLiked = !isLiked
    }
    @objc func didTapComment(){
        delegate?.postActionsCollectionViewCellDidTapComment(self)
    }
    @objc func didTapShare(){
        delegate?.postActionsCollectionViewCellDidTapShare(self)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size:CGFloat = contentView.height/1.15
        likeButton.frame = CGRect(x: 5,
                                  y: (contentView.height - size),
                                  width: size, height:
                                    size)
        commentButton.frame = CGRect(x: likeButton.right+16,
                                  y: (contentView.height - size),
                                  width: size, height:
                                    size)
        shareButton.frame = CGRect(x: commentButton.right+16,
                                  y: (commentButton.height - size) ,
                                  width: size, height:
                                    size)
    }
    
    override func prepareForReuse() {
         super.prepareForReuse()
    }
     
    func configure(with viewModel:PostActionsCollectionsViewCellViewModel) {
        isLiked = viewModel.isLiked
        if isLiked{
            let image = UIImage(systemName: "suit.heart.fill",
                            withConfiguration: UIImage.SymbolConfiguration(pointSize: 44))
            likeButton.setImage(image, for: .normal)
            likeButton.tintColor = .red
        }
    }
}
