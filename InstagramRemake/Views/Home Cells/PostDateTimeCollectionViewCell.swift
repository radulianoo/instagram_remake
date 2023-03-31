//
//  PostDateTimeCollectionViewCell.swift
//  InstagramRemake
//
//  Created by Octav Radulian on 31.03.2023.
//

import UIKit

final class PostDateTimeCollectionViewCell: UICollectionViewCell {
    static let identifier = "PostDateTimeCollectionViewCell"
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .secondaryLabel
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(label)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = CGRect(x: 10, y: 0, width: contentView.width - 12, height: contentView.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
    }
    
    func configure(with viewModel: PostDateTimeCollectionViewCellViewModel) {
        let date = viewModel.date
        label.text = String.date(from: date)
    }
}
