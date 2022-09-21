//
//  PostCaptionCollectionViewCell.swift
//  InstagramClone
//
//  Created by Pinakpani Mukherjee on 2022/09/18.
//

import UIKit

class PostCaptionCollectionViewCell: UICollectionViewCell {
    static let identifier = "PostCaptionCollectionViewCell"
    private let label:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size = label.sizeThatFits(CGSize(width:contentView.bounds.size.width-12,
                                      height:contentView.bounds.size.height))
        label.frame = CGRect(x: 12, y: 3, width: size.width , height: size.height)
    }
    
    override func prepareForReuse() {
         super.prepareForReuse()
        label.text = nil
    }
     
    func configure(with viewModel:PostCaptionCollectionViewCellViewModel) {
        label.text = "\(viewModel.username): \(viewModel.caption ?? "")"
    }
}
