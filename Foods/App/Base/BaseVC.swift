//
//  BaseVC.swift
//  Foods
//
//  Created by Ivan Kopiev on 17.02.2022.
//

import UIKit

class BaseVC: UIViewController {
    
    var stateView: State! { return self.view as? State }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {.portrait}
    override var shouldAutorotate: Bool {false}
    
    private var _state : [String: Any] = [:]
    public var state : [String: Any] {
        get { _state}
        set {
            _state = newValue
            stateView.state = newValue
            stateView.render()
        }
    }
    
    @objc func returnFromVC() {
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        } else {
            dismiss(animated: true, completion: nil);
        }
    }
}
