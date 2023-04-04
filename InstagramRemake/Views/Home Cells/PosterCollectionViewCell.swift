//
//  PosterCollectionViewCell.swift
//  InstagramRemake
//
//  Created by Octav Radulian on 31.03.2023.
//
import SDWebImage
import UIKit

//on a tap we are sending to the XVC
//we add a protocol for this in order to set up the delegate design pattern

protocol PosterCollectionViewCellDelegate: AnyObject {
    //is AnyObject because we can put weak on the delegate property
    func posterCollectionViewCellDidTapMore(_ cell: PosterCollectionViewCell)
    func posterCollectionViewCellDidTapUsername(_ cell: PosterCollectionViewCell)
}

final class PosterCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PosterCollectionViewCell"
    
    //add the delegate property, is weak because we don't want to create a memory leak
    weak var delegate: PosterCollectionViewCellDelegate?
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private let moreButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        let image = UIImage(systemName: "ellipsis", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        button.setImage(image, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(imageView)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(moreButton)
        moreButton.addTarget(self, action: #selector(didTapMore), for: .touchUpInside)
        //add the gesture recognizer
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapUsername))
        usernameLabel.isUserInteractionEnabled = true
        usernameLabel.addGestureRecognizer(tap)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imagePadding: CGFloat = 4
        let imageSize: CGFloat = contentView.height - (imagePadding * 2)
        imageView.frame = CGRect(x: imagePadding, y: imagePadding, width: imageSize, height: imageSize)
        imageView.layer.cornerRadius = imageSize / 2
        
        usernameLabel.sizeToFit()
        usernameLabel.frame = CGRect(x: imageView.right + 10, y: 0, width: usernameLabel.width, height: contentView.height)
        
        moreButton.frame = CGRect(x: contentView.width - 55, y: (contentView.height - 50)/2, width: 50, height: 50)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        usernameLabel.text = nil
        imageView.image = nil
    }
    
    func configure(with viewModel: PosterCollectionViewCellViewModel) {
        usernameLabel.text = viewModel.username
        imageView.sd_setImage(with: viewModel.profilePictureURL, completed: nil)
    }
    
    @objc func didTapUsername() {
        delegate?.posterCollectionViewCellDidTapUsername(self)
    }
    
    @objc func didTapMore() {
        delegate?.posterCollectionViewCellDidTapMore(self)
    }
    
}
