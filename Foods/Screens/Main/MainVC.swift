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
        state[i: Keys.selectedItems] = 0
        v.set(dataSource: self)
        v.set(delegate: self)
        featchData()
    }
    
    //MARK: - Helpers
    func featchData() {
        network.getArticles { [weak self] resp in
            guard let self = self else {return}
            self.state[ad: Keys.sections] = resp[ad: Keys.sections]
        }
    }
    // Тут что-то грязное)
    func updateStateWith(id: String) {
        for section in 0 ..< state[ad: Keys.sections].count {
            if let index = state[ad: Keys.sections][section][ad: Keys.items].firstIndex(where: { items in
                items[s: Keys.id] == id
            }) {
                let isSelected = state[ad: Keys.sections][section][ad: Keys.items][index][b: Keys.isSelected]
                
                if state[i:Keys.selectedItems] <= 5 {
                    if isSelected {
                        state[i:Keys.selectedItems] -= 1
                    } else {
                        state[i:Keys.selectedItems] += 1
                    }
                    state[ad: Keys.sections][section][ad: Keys.items][index][b: Keys.isSelected] = !state[ad: Keys.sections][section][ad: Keys.items][index][b: Keys.isSelected]
                } else {
                    if isSelected {
                        state[i:Keys.selectedItems] -= 1
                        state[ad: Keys.sections][section][ad: Keys.items][index][b: Keys.isSelected] = !state[ad: Keys.sections][section][ad: Keys.items][index][b: Keys.isSelected]
                        
                    } else {
                        Notify.showError(title: "Selected the maximum number of cells")
                    }
                }
                
            }
        }
    }
}

//MARK: - UITableViewDataSource
extension MainVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {state[ad: Keys.sections].count}

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {1}
            
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FoodsTableViewCell.description(), for: indexPath) as? FoodsTableViewCell
        let data = state[ad: Keys.sections][indexPath.section]
        cell?.render(data: data)
        cell?.set(delegate: self)
        return cell ?? UITableViewCell()
    }
}

//MARK: - UITableViewDataSource
extension MainVC: UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderView.description()) as? HeaderView
        headerView?.render(data: state[ad: Keys.sections][section])
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {UITableView.automaticDimension}
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {UITableView.automaticDimension}

}

extension MainVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = collectionView.cellForItem(at: indexPath) as? ArticleCell else {return}
        let id = item.data[s: Keys.id]
        updateStateWith(id: id)
        Haptic.selection()
    }
}
