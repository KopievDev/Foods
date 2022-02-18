//
//  MainView.swift
//  Foods
//
//  Created by Ivan Kopiev on 17.02.2022.
//

import UIKit

class MainView: BaseView {
    // MARK: - Properties
    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: frame)
        tv.backgroundColor = Theme.backgroundColor
        tv.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        tv.register(FoodsTableViewCell.self, forCellReuseIdentifier: FoodsTableViewCell.description())
        tv.register(HeaderView.self, forHeaderFooterViewReuseIdentifier: HeaderView.description())
        tv.showsVerticalScrollIndicator = false
        tv.separatorStyle = .none
        return tv
    }()
    
    // MARK: - Life cycle
    override func setUp() {
        backgroundColor = Theme.backgroundColor
        addSubview(tableView)
    }
    
    override func render() {
        tableView.reloadData()
    }
    
    // MARK: - Helpers
    func set(dataSource: UITableViewDataSource) {
        tableView.dataSource = dataSource
    }
    
    func set(delegate: UITableViewDelegate) {
        tableView.delegate = delegate
    }
}

