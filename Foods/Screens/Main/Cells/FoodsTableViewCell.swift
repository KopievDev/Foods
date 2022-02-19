//
//  FoodsTableViewCell.swift
//  Foods
//
//  Created by Ivan Kopiev on 17.02.2022.
//

import UIKit


class FoodsTableViewCell: TableViewCell {
    // MARK: - Properties
    var items: [Item] = [Item]()
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.register(ArticleCell.self, forCellWithReuseIdentifier: ArticleCell.description())
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = Theme.backgroundColor
        cv.dataSource = self
        cv.translatesAutoresizingMaskIntoConstraints = false
       return cv
    }()
    // MARK: - Life cycle

    override func setUp() {
        contentView.addSubview(collectionView)
        createConstraints()
        configCollectionView()
    }
        
    func render(with section: Section?) {
        items = section?.items ?? [Item]()
        collectionView.reloadData()
    }
    
    func configCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        flowLayout.scrollDirection = .horizontal
        let width = (Screen.width - 40) / 2
        flowLayout.itemSize = CGSize(width: width, height: width * 1.2)
        collectionView.collectionViewLayout = flowLayout
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    func createConstraints() {
        let height = (Screen.width - 40) / 2 * 1.5
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentView.heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
    func set(delegate: UICollectionViewDelegate) {
        collectionView.delegate = delegate
    }
    
}

// MARK: - UICollectionViewDataSource
extension FoodsTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArticleCell.description(), for: indexPath) as? ArticleCell
        let data = items[indexPath.row]
        cell?.render(data: data)
        cell?.delegate = self
        return cell ?? UICollectionViewCell()
    }
    
}

extension FoodsTableViewCell: ArticleCellDelegate {
    func reload(data: Section) {
        render(with: data)
    }
}
