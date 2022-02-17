//
//  FoodsTableViewCell.swift
//  Foods
//
//  Created by Ivan Kopiev on 17.02.2022.
//

import UIKit


class FoodsTableViewCell: TableViewCell {
    // MARK: - Properties
    var cells: [[String: Any?]] = [[:]]
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.register(ArticleCell.self, forCellWithReuseIdentifier: ArticleCell.description())
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        flowLayout.scrollDirection = .horizontal
        let width = (UIScreen.main.bounds.width)
        flowLayout.itemSize = CGSize(width: 100, height: 100)
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
    }
    
    override func render(data: [String : Any?]) {
        cells = data[ad: Keys.items]
        configCollectionView()
    }
    
    func configCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        flowLayout.scrollDirection = .horizontal
        let width = (UIScreen.main.bounds.width - 40) / 2
        flowLayout.itemSize = CGSize(width: width, height: width * 1.2)
        collectionView.collectionViewLayout = flowLayout
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.reloadData()
    }
    
    func createConstraints() {
    
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 210)
        ])
    }
    
    func set(delegate: UICollectionViewDelegate) {
        collectionView.delegate = delegate
    }
    
}

// MARK: - UICollectionViewDataSource
extension FoodsTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArticleCell.description(), for: indexPath) as? ArticleCell
        let data = cells[indexPath.row]
        cell?.render(data: data)
        return cell ?? UICollectionViewCell()
    }
    
}