//
//  LoginModel.swift
//  RoadDangerChecker
//
//  Created by SeungMin Lee on 2022/05/30.
//

import UIKit

protocol LoginModelDelegate: AnyObject {
    func login(_ musicPlayer: LoginModel, didLoginAvailable canLogin: Bool)
}

class LoginModel {
    weak var delegate: LoginModelDelegate?
    
    func loginCheck(id: String, pwd: String){
        for user in userModel.users {
            if user.email == id && user.password == pwd {
                delegate?.login(self, didLoginAvailable: true)
            } else {
                delegate?.login(self, didLoginAvailable: false)
            }
        }
    }
}


