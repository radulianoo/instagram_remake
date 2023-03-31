//
//  PostCaptionsCollectionViewCell.swift
//  InstagramRemake
//
//  Created by Octav Radulian on 31.03.2023.
//

import UIKit

final class PostCaptionsCollectionViewCell: UICollectionViewCell {
    static let identifier = "PostCaptionsCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        contentView.backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(with viewModel: PostCaptionCollectionViewCellViewModel) {
        
    }
}
