//
//  LoginViewController.swift
//  RoadDangerChecker
//
//  Created by SeungMin Lee on 2022/05/27.
//

import UIKit

// MARK: - Model

let userModel = UserModel()
let loginModel = LoginModel()

// MARK: - Constants

enum Design {
    enum LoginTextField {
        static let leading: CGFloat = 32
        static let trailing: CGFloat = -32
        static let top: CGFloat = 256
        static let bottom: CGFloat = -512
    }
    
    enum TextFieldView {
        static let textLineLeading: CGFloat = 0.0
        static let textLineTrailing: CGFloat = 0.0
        static let textLineBottom: CGFloat = 0.0
        static let textLineHeight: CGFloat = 1.0
        
        static let imageViewBottom: CGFloat = -15.0
        static let imageViewLeading: CGFloat = 0.0
        static let imageViewHeight: CGFloat = 20.0
        static let imageViewWidth: CGFloat = 0.0
    }
}

//MARK: - LoginViewController

class LoginViewController: UIViewController, LoginModelDelegate {
    func login(_ musicPlayer: LoginModel, didLoginAvailable canLogin: Bool) {
        if canLogin {
            let mapContentViewController = MapContentViewContoller()
            mapContentViewController.modalPresentationStyle = .fullScreen
            present(mapContentViewController, animated: true, completion: nil)
        } else {
            signInButton.backgroundColor = .red
        }
    }
    
    
    //MARK: - SubViews
    private lazy var  idTextField : UITextField = {
        let idTextField = UITextField()
        idTextField.translatesAutoresizingMaskIntoConstraints = false
        idTextField.placeholder = "Id"
        idTextField.borderStyle = UITextField.BorderStyle.line
        idTextField.backgroundColor = UIColor.white
        idTextField.textColor = .black
        return idTextField
    }()
    
    private lazy var  passwordTextField : UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "Password"
        passwordTextField.borderStyle = UITextField.BorderStyle.line
        passwordTextField.backgroundColor = UIColor.white
        passwordTextField.textColor = .black
        return passwordTextField
    }()
    
    lazy var signInButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.lightGray
        button.setTitle("SIGN IN", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(signInButtonTapped(button:)), for: .touchUpInside)
        return button
    }()


    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        setupViews()
        loginModel.delegate = self
    }
    
    // MARK: - Setups
    
    private func setupViews() {
        view.addSubview(idTextField)
        idTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100.0).isActive = true
        idTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        idTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        idTextField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        view.addSubview(passwordTextField)
        passwordTextField.topAnchor.constraint(equalTo: idTextField.bottomAnchor, constant: 10.0).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        view.addSubview(signInButton)
        signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10.0).isActive = true
        signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        signInButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
    }
    
    @objc private func signInButtonTapped(button: UIButton) {
        loginModel.loginCheck(id: idTextField.text!, pwd: passwordTextField.text!)
    }
}
