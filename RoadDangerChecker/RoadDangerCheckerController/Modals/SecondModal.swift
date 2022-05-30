//
//  SecondModal.swift
//  TabBarTest
//
//  Created by 정다운 on 2022/05/28.
//

import UIKit

class SecondModal: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissMe))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissMe() -> Void {
            dismiss(animated: true, completion: nil)
        }
}
