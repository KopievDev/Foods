//
//  MainVC.swift
//  Foods
//
//  Created by Ivan Kopiev on 17.02.2022.
//

import UIKit

class MainVC: BaseVC {
    //MARK: - Properties
    let v = MainView()
    let network: NetworkServiceProtocol!
    var sections: [Section] = [Section]()
    var countSelected: Int = 0
    //MARK: - Life cycle
    init(network: NetworkServiceProtocol) {
        self.network = network
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {view = v}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    func setUp() {
        v.set(dataSource: self)
        v.set(delegate: self)
        featchData()
    }
    
    //MARK: - Helpers
    func featchData() {
        network.getArticles(type: Welcome.self) { resp in
            self.sections = resp?.sections ?? [Section]()
            self.setSections()
            self.v.render()
        }
    }
    
    func setSections() {
        for index in 0..<sections.count {
            sections[index].number = index
            for indexItem in 0..<sections[index].items.count {
                sections[index].items[indexItem].isSelected = false
            }
        }
    }
    
    func canSelect(item: Item) -> Item {
        var copyItem = item
        let select = countSelected + 1
        let deSelect = countSelected - 1
        guard let isSelect = copyItem.isSelected else {return copyItem}
        
        if countSelected <= 5 {
            countSelected = isSelect ? deSelect : select
            copyItem.isSelected = !isSelect
        } else {
            if isSelect {
                countSelected = deSelect
                copyItem.isSelected = !isSelect
                return copyItem
            } else {
                Notify.showError(title: "Selected the maximum number of cells")
                copyItem.isSelected = false
                return copyItem
            }
        }
        return copyItem
    }
    
    func update(item: Item) {
        guard let sectionIndex = item.section,
              let index = sections[sectionIndex].items.firstIndex(where: { $0.id == item.id }) else {return}
        sections[sectionIndex].items[index] = canSelect(item: item)
    }
}

//MARK: - UITableViewDataSource
extension MainVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {sections.count}

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {1}
            
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FoodsTableViewCell.description(), for: indexPath) as? FoodsTableViewCell
        let data = sections[indexPath.section]
        cell?.render(with: data)
        cell?.set(delegate: self)
        return cell ?? UITableViewCell()
    }
}

//MARK: - UITableViewDataSource
extension MainVC: UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderView.description()) as? HeaderView
        headerView?.render(data: sections[section])
        return headerView
    }
}
//MARK: - UICollectionViewDelegate
extension MainVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Haptic.selection()
        guard let item = collectionView.cellForItem(at: indexPath) as? ArticleCell,
              let newItem = item.item else {return}
        update(item: newItem)
        if let section = item.item?.section {
            item.reloadData(data: sections[section])
        }
    }
}
