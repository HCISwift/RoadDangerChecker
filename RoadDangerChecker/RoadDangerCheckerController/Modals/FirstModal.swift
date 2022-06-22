//
//  FIrstModal.swift
//  TabBarTest
//
//  Created by 정다운 on 2022/05/28.
//

import UIKit

class FirstModal: UIViewController {
    
    let sharedViewController = SharedViewController()
    
    lazy var topBarView: UIView = {
        let topBarView = UIView()
        topBarView.backgroundColor = .systemGray2
        return topBarView
    }()
    
    lazy var MyCourseButton: UIButton = {
        let courseButton = UIButton()
        courseButton.setTitle("My Course", for: .normal)
        courseButton.setTitleColor(UIColor.black, for: .normal)
        courseButton.backgroundColor = UIColor.systemGray2
        courseButton.layer.cornerRadius = 16
        courseButton.clipsToBounds = true
        
        courseButton.addTarget(self, action: #selector(didCourseButtonClicked(_:)), for: .touchUpInside)
        
        return courseButton
    }()
    
    @objc private func didCourseButtonClicked(_ sender: UIButton) {
        MySharedButton.backgroundColor = UIColor.systemGray2
        sender.backgroundColor = .white
        
        
        containerView.addSubview(myCourseView)
        myCourseView.translatesAutoresizingMaskIntoConstraints = false
        sharedView.isHidden = true
        myCourseView.isHidden = false
        NSLayoutConstraint.activate([
            myCourseView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            myCourseView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10),
            myCourseView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -10),
        ])
    }
    
    lazy var MySharedButton: UIButton = {
        let sharedButton = UIButton()
        sharedButton.setTitle("Shared", for: .normal)
        sharedButton.setTitleColor(UIColor.black, for: .normal)
        sharedButton.backgroundColor = UIColor.systemGray2
        sharedButton.layer.cornerRadius = 16
        sharedButton.clipsToBounds = true
        
        sharedButton.addTarget(self, action: #selector(didSharedButtonClicked(_:)), for: .touchUpInside)
        
        return sharedButton
    }()
    
    @objc private func didSharedButtonClicked(_ sender: UIButton) {
        MyCourseButton.backgroundColor = UIColor.systemGray2
        sender.backgroundColor = .white
        
        containerView.addSubview(sharedView)
        sharedView.translatesAutoresizingMaskIntoConstraints = false
        sharedView.isHidden = false
        myCourseView.isHidden = true
        NSLayoutConstraint.activate([
            sharedView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            sharedView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10),
            sharedView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -10),
        ])
    }
    
    lazy var myCourseView: UIImageView = {
        let myCourseView = UIImageView(image: UIImage(named: "MyCourse"))
        
        return myCourseView
    }()
    
    lazy var sharedView: UIButton = {
        let sharedView = UIButton()
        sharedView.setImage(UIImage(named: "Shared"), for: .normal)
        
        sharedView.addTarget(self, action: #selector(didsharedViewClicked(_:)), for: .touchUpInside)
        
        return sharedView
    }()
    
    @objc private func didsharedViewClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected {
            present(sharedViewController, animated: true)
        }
    }
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [MyCourseButton, MySharedButton])
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = 20.0
        return stackView
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.layer.cornerRadius = 16
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
    func setupView() {
        view.backgroundColor = .clear
        
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(topBarView)
        topBarView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupConstraints() {
        // Set static constraints
        NSLayoutConstraint.activate([
            // set container static constraint (trailing & leading)
            
            containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height / 2),
            containerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            containerView.rightAnchor.constraint(equalTo: view.rightAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            topBarView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            topBarView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 150),
            topBarView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -150),
            topBarView.heightAnchor.constraint(equalToConstant: CGFloat(10)),
            
            stackView.topAnchor.constraint(equalTo: topBarView.bottomAnchor, constant: 10),
            stackView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10),
            stackView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -10),
        ])
    }
    
}
