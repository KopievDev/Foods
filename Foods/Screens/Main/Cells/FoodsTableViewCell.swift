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
    
    override func render(data: [String : Any?]) {
        cells = data[ad: Keys.items]
        collectionView.reloadData()
    }
    
    func configCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        flowLayout.scrollDirection = .horizontal
        let width = (UIScreen.main.bounds.width - 40) / 2
        flowLayout.itemSize = CGSize(width: width, height: width * 1.2)
        collectionView.collectionViewLayout = flowLayout
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    func createConstraints() {
        let height = (UIScreen.main.bounds.width - 40) / 2 * 1.4
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
        cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArticleCell.description(), for: indexPath) as? ArticleCell
        let data = cells[indexPath.row]
        cell?.render(data: data)
        return cell ?? UICollectionViewCell()
    }
    
}
