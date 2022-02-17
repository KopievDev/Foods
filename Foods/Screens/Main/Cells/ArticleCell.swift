//
//  ArticleCell.swift
//  Foods
//
//  Created by Ivan Kopiev on 17.02.2022.
//

import UIKit
import SDWebImage
class ArticleCell: CollectionViewCell {
    //MARK: - Propetries
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = .systemBlue
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
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
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            blurView.bottomAnchor.constraint(equalTo: bottomAnchor),
            blurView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: blurView.topAnchor,constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: blurView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: blurView.trailingAnchor, constant: -10),
            titleLabel.bottomAnchor.constraint(equalTo: blurView.bottomAnchor, constant: -10)
            
            
        ])
    }
    
    override func render(data: [String : Any?]) {
        self.data = data
        guard let url = URL(string: data[d:Keys.image][s:Keys.one_x]) else {return}
        titleLabel.text = data[s: Keys.title]
        layer.borderWidth = data[b: Keys.isSelected] ? 2 : 0
        imageView.sd_setImage(with: url, placeholderImage: nil, options: .delayPlaceholder) { _, _, _, _ in
        }
        
    }
}

