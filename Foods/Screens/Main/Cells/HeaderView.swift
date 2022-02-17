//
//  HeaderView.swift
//  Foods
//
//  Created by Ivan Kopiev on 17.02.2022.
//

import UIKit

class HeaderView: UITableViewHeaderFooterView {
    // MARK: - Properties
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "TITLE"
        return label
    }()
    // MARK: - Life cycle

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        addSubview(titleLabel)
        createConstraints()
    }
    
    func createConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    func render(data: [String : Any?]) {
        titleLabel.attributedText = data[s: Keys.header].add(attributs: (UIFont.boldSystemFont(ofSize: 22), Theme.textColor))
    }
    
}


