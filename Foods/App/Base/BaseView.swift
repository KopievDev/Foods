//
//  BaseView.swift
//  Foods
//
//  Created by Ivan Kopiev on 17.02.2022.
//

import UIKit

protocol State: UIView {
    var state: [String: Any] {get set}
    func render()
}

class BaseView: UIView, State {
    //MARK: - Properies
    var state: [String : Any] = [:]
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    ///Первоначальная настройка интерфейса
    func setUp() {}
    
    ///Вызывается при изменении переменной `state`
    func render() {}

}


