//
//  PostCollectionViewCell.swift
//  InstagramClone
//
//  Created by Pinakpani Mukherjee on 2022/09/18.
//

import UIKit
import SDWebImage

protocol PostCollectionViewCellDelegate: AnyObject {
    func postCollectionViewCellDidLike(_ cell:PostCollectionViewCell)

}

class PostCollectionViewCell: UICollectionViewCell {
    static let identifier = "PostCollectionViewCell"
    
    weak var delegate: PostCollectionViewCellDelegate?
    
    private let imageView:  UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let heartImageView: UIImageView = {
        let image = UIImage(systemName: "suit.heart.fill",
                        withConfiguration: UIImage.SymbolConfiguration(pointSize: 50))
        let imageView = UIImageView(image: image)
        imageView.tintColor = .white
        imageView.isHidden = true
        imageView.alpha = 0
        return imageView
    }()
    
    // MARK:- Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(imageView)
        contentView.addSubview(heartImageView)
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(didDoubleTapToLike))
        tap.numberOfTapsRequired = 2
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tap)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
        let size: CGFloat = contentView.width/5
        heartImageView.frame = CGRect(x: (contentView.width-size)/2,
                                      y: (contentView.height-size)/2,
                                      width: size,
                                      height: size)
    }
    
    override func prepareForReuse() {
         super.prepareForReuse()
        imageView.image = nil
    }
     
    func configure(with viewModel:PostCollectionViewCellViewModel) {
        imageView.sd_setImage(with: viewModel.postURL, completed: nil)
    }
    @objc func didDoubleTapToLike(){
        heartImageView.isHidden = false
        UIView.animate(withDuration: 0.4) {
            self.heartImageView.alpha = 1
        } completion: { done in
            if done {
                UIView.animate(withDuration: 0.4) {
                    self.heartImageView.alpha = 0
                } completion: { done in
                    if done {
                        self.heartImageView.isHidden = true
                    }
                }
            }
        }

        delegate?.postCollectionViewCellDidLike(self)
    }
}

