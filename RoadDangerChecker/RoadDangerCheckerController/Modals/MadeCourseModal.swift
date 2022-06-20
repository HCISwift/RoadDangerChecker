//
//  MadeCourseModal.swift
//  RoadDangerChecker
//
//  Created by 정다운 on 2022/06/18.
//

import UIKit

class MadeCourseModal:UIViewController {
    // MARK: - property
    let courseViewWidth: CGFloat = 380.0
    let courseViewHeight: CGFloat = 530.0
    
    // MARK: - SubView
    private lazy var courseContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray3
        view.layer.opacity = 0.8
        view.layer.cornerRadius = 10.0
        view.clipsToBounds = true
        return view
    }()
    
    private let titleTextLabel: UILabel = {
        let label = UILabel()
        label.text = "이 코스의 이름은?"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        return label
    }()
    
    private let courseNameTextLabel: UILabel = {
        let label = UILabel()
        label.text = "코스에 대한 설명을 적어주세요."
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        return label
    } ()
    
    private let detailTextLabel: UILabel = {
        let label = UILabel()
        label.text = "대로에서 은행로를 따라 A분식집까지 가는 코스입니다."
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        return label
    } ()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(.Icon.cancel, for: .normal)
        return button
    } ()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGray5
        button.layer.cornerRadius = 10.0
        button.setTitle("저장하기", for: .normal)
        return button
    } ()
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SetupView()
        SetupAction()
    }
    
    // MARK: - Setup
    private func SetupView() {
        view.addSubview(courseContainerView)
        courseContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        courseContainerView.addSubview(titleTextLabel)
        courseContainerView.addSubview(closeButton)
        courseContainerView.addSubview(courseNameTextLabel)
        courseContainerView.addSubview(detailTextLabel)
        courseContainerView.addSubview(saveButton)
        
        titleTextLabel.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        courseNameTextLabel.translatesAutoresizingMaskIntoConstraints = false
        detailTextLabel.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            courseContainerView.heightAnchor.constraint(equalToConstant: courseViewHeight),
            courseContainerView.widthAnchor.constraint(equalToConstant: courseViewWidth),
            courseContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            courseContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            titleTextLabel.centerXAnchor.constraint(equalTo: courseContainerView.centerXAnchor),
            titleTextLabel.topAnchor.constraint(equalTo: courseContainerView.topAnchor, constant: 5),
            
            closeButton.trailingAnchor.constraint(equalTo: courseContainerView.trailingAnchor, constant: -10),
            closeButton.topAnchor.constraint(equalTo: courseContainerView.topAnchor, constant: 5),
            
            courseNameTextLabel.topAnchor.constraint(equalTo: titleTextLabel.bottomAnchor, constant: 20),
            courseNameTextLabel.centerXAnchor.constraint(equalTo: courseContainerView.centerXAnchor),
            
            detailTextLabel.topAnchor.constraint(equalTo: courseNameTextLabel.bottomAnchor, constant: 5),
            detailTextLabel.trailingAnchor.constraint(equalTo: courseContainerView.trailingAnchor, constant: -20),
            detailTextLabel.leadingAnchor.constraint(equalTo: courseContainerView.leadingAnchor, constant: 20),
            
            saveButton.heightAnchor.constraint(equalToConstant: 30),
            saveButton.widthAnchor.constraint(equalToConstant: 150),
            saveButton.bottomAnchor.constraint(equalTo: courseContainerView.bottomAnchor, constant: -40),
            saveButton.centerXAnchor.constraint(equalTo: courseContainerView.centerXAnchor)
        ])
        
    }
    
    private func SetupAction() {
        saveButton.addTarget(self, action: #selector(dismissModal(_:)), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(dismissModal(_:)), for: .touchUpInside)
    }
    // MARK: - Action
    @objc func dismissModal(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

