//
//  ArticleCell.swift
//  Foods
//
//  Created by Ivan Kopiev on 17.02.2022.
//
protocol ArticleCellDelegate: AnyObject {
    func reload(data: Section)
}

import UIKit
import SDWebImage

class ArticleCell: CollectionViewCell {
    //MARK: - Propetries
    weak var delegate: ArticleCellDelegate?
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = .systemGray
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .regular)
        let bv = UIVisualEffectView(effect: blurEffect)
        bv.translatesAutoresizingMaskIntoConstraints = false
        return bv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Theme.textColor
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "title"
        label.numberOfLines = 0
        return label
    }()
    
    var item: Item?
    
    // MARK: - Life cycle
    override func setUp() {
        layer.borderColor = Theme.selectedColor.cgColor
        layer.cornerRadius = 15
        clipsToBounds = true
        addSubview(imageView)
        addSubview(blurView)
        addSubview(titleLabel)
        createConstaints()
        
    }
    
    func createConstaints() {
        let inset = 10.0
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            blurView.bottomAnchor.constraint(equalTo: bottomAnchor),
            blurView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: blurView.topAnchor,constant: inset),
            titleLabel.leadingAnchor.constraint(equalTo: blurView.leadingAnchor, constant: inset),
            titleLabel.trailingAnchor.constraint(equalTo: blurView.trailingAnchor, constant: -inset),
            titleLabel.bottomAnchor.constraint(equalTo: blurView.bottomAnchor, constant: -inset)
            
            
        ])
    }

    func render(data: Item) {
        self.item = data
        guard let url = URL(string: item?.image.the1X ?? "") else {return}
        titleLabel.text = item?.title
        imageView.sd_setImage(with: url)
        layer.borderWidth = item?.isSelected ?? false ? 2 : 0
    }
    
    func reloadData(data: Section) {
        delegate?.reload(data: data)
    }
}

