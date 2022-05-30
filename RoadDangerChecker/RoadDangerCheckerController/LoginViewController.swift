//
//  LoginViewController.swift
//  RoadDangerChecker
//
//  Created by SeungMin Lee on 2022/05/27.
//

import UIKit

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

class LoginViewController: UIViewController {
    
    //MARK: - SubViews
    
    let idTextField : TextFieldView = {
        let textFieldView = TextFieldView()
        textFieldView.translatesAutoresizingMaskIntoConstraints = false
        textFieldView.backgroundColor = UIColor.clear
        
        textFieldView.imageView.contentMode = .scaleAspectFill
        textFieldView.imageView.image = UIImage(systemName: "person.fill")
        textFieldView.imageView.tintColor = .white
        
        let attributesDictionary = [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        textFieldView.textField.attributedPlaceholder = NSAttributedString(string: "ID", attributes: attributesDictionary)
        textFieldView.textField.textColor = .black
        return textFieldView
    }()
    
    let passwordTextField : TextFieldView = {
        let textFieldView = TextFieldView()
        textFieldView.translatesAutoresizingMaskIntoConstraints = false
        textFieldView.backgroundColor = UIColor.clear
        
        textFieldView.imageView.contentMode = .scaleAspectFill
        textFieldView.imageView.image = UIImage(systemName: "lock.fill")
        textFieldView.imageView.tintColor = .white
        
        let attributesDictionary = [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        textFieldView.textField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: attributesDictionary)
        textFieldView.textField.textColor = .black
        return textFieldView
    }()
    
    lazy var signInButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.alpha = 0.4
        button.backgroundColor = UIColor.lightGray
        button.setTitle("SIGN IN", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.isEnabled = false
        button.addTarget(self, action: #selector(signInButtonTapped(button:)), for: .touchUpInside)
        return button
    }()
    
    let forgotPassword : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let signUpButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    // MARK: - Setups
    
    private func setupViews() {
        view.addSubview(idTextField)
        idTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100.0).isActive = true
        idTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        idTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        idTextField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        view.addSubview(passwordTextField)
        passwordTextField.topAnchor.constraint(equalTo: idTextField.bottomAnchor, constant: 10).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        view.addSubview(signInButton)
        signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10).isActive = true
        signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        signInButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    
    func showAlertVC(title: String) {
        let alertController = UIAlertController(title: title, message: "Need to implement code based on user requirements", preferredStyle: UIAlertController.Style.alert)
        let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion:{})
    }
    
    @objc private func signInButtonTapped(button: UIButton) {
        showAlertVC(title: "Sign In tapped")
    }
}

class TextFieldView: UIView {
    
    let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let textField : UITextField = {
        let textFieldView = UITextField()
        textFieldView.translatesAutoresizingMaskIntoConstraints = false
        return textFieldView
    }()
    
    let textlineView : UIView = {
        let textLineView = UIView()
        textLineView.translatesAutoresizingMaskIntoConstraints = false
        textLineView.backgroundColor = UIColor.white
        return textLineView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addingSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addingSubviews() {
        self.addSubview(textlineView)
        NSLayoutConstraint.activate([
            textlineView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Design.TextFieldView.textLineLeading),
            textlineView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Design.TextFieldView.textLineTrailing),
            textlineView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: Design.TextFieldView.textLineBottom),
            textlineView.heightAnchor.constraint(equalToConstant: Design.TextFieldView.textLineHeight),
        ])
        
        self.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.bottomAnchor.constraint(equalTo: textlineView.topAnchor, constant:Design.TextFieldView.imageViewBottom),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Design.TextFieldView.imageViewLeading),
            imageView.heightAnchor.constraint(equalToConstant: Design.TextFieldView.imageViewHeight),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, constant: Design.TextFieldView.imageViewWidth),
        ])
        
        self.addSubview(textField)
        NSLayoutConstraint.activate([
            textField.lastBaselineAnchor.constraint(equalTo: imageView.lastBaselineAnchor, constant: -1.0),
            textField.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8.0),
            textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0.0),
        ])
    }
}

