//
//  CourseModel.swift
//  RoadDangerChecker
//
//  Created by SeungMin Lee on 2022/06/17.
//
import UIKit

class CourseModal:UIViewController {
    // MARK: - property
    let courseViewWidth: CGFloat = 380.0
    let courseViewHeight: CGFloat = 530.0
    
    // MARK: - SubView
    private lazy var courseContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray3
        view.layer.cornerRadius = 10.0
        view.clipsToBounds = true
        return view
    }()
    
    private let titleTextLabel: UILabel = {
        let label = UILabel()
        label.text = "A 분식집까지 가는 길"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        return label
    }()
    
    private let courseImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10.0
        imageView.image = UIImage(named: "UserRoute")
        imageView.contentMode = .scaleAspectFit
        return imageView
    } ()
    
    private let courseNameTextLabel: UILabel = {
        let label = UILabel()
        label.text = "코스 설명"
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
    
    private let startButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGray5
        button.layer.cornerRadius = 10.0
        button.setTitle("코스 시작하기", for: .normal)
        return button
    } ()
    
    private let getAnotherCourseButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGray5
        button.layer.cornerRadius = 10.0
        button.setTitle("다른 코스 보기", for: .normal)
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
        courseContainerView.addSubview(courseImageView)
        courseContainerView.addSubview(courseNameTextLabel)
        courseContainerView.addSubview(detailTextLabel)
        courseContainerView.addSubview(startButton)
        courseContainerView.addSubview(getAnotherCourseButton)
        
        titleTextLabel.translatesAutoresizingMaskIntoConstraints = false
        courseImageView.translatesAutoresizingMaskIntoConstraints = false
        courseNameTextLabel.translatesAutoresizingMaskIntoConstraints = false
        detailTextLabel.translatesAutoresizingMaskIntoConstraints = false
        startButton.translatesAutoresizingMaskIntoConstraints = false
        getAnotherCourseButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            courseContainerView.heightAnchor.constraint(equalToConstant: courseViewHeight),
            courseContainerView.widthAnchor.constraint(equalToConstant: courseViewWidth),
            courseContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            courseContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            titleTextLabel.centerXAnchor.constraint(equalTo: courseContainerView.centerXAnchor),
            titleTextLabel.topAnchor.constraint(equalTo: courseContainerView.topAnchor, constant: 5),
            
            courseImageView.widthAnchor.constraint(equalToConstant: 345),
            courseImageView.heightAnchor.constraint(equalToConstant: 180),
            courseImageView.centerXAnchor.constraint(equalTo: courseContainerView.centerXAnchor),
            courseImageView.topAnchor.constraint(equalTo: courseContainerView.topAnchor, constant: 40),
            
            courseNameTextLabel.topAnchor.constraint(equalTo: courseImageView.bottomAnchor, constant: 10),
            courseNameTextLabel.leadingAnchor.constraint(equalTo: courseImageView.leadingAnchor),
            
            detailTextLabel.topAnchor.constraint(equalTo: courseNameTextLabel.bottomAnchor, constant: 5),
            detailTextLabel.trailingAnchor.constraint(equalTo: courseContainerView.trailingAnchor, constant: -20),
            detailTextLabel.leadingAnchor.constraint(equalTo: courseContainerView.leadingAnchor, constant: 20),
            
            startButton.heightAnchor.constraint(equalToConstant: 30),
            startButton.widthAnchor.constraint(equalToConstant: 150),
            startButton.bottomAnchor.constraint(equalTo: courseContainerView.bottomAnchor, constant: -40),
            startButton.leadingAnchor.constraint(equalTo: courseContainerView.leadingAnchor, constant: 25),
            
            getAnotherCourseButton.heightAnchor.constraint(equalToConstant: 30),
            getAnotherCourseButton.widthAnchor.constraint(equalToConstant: 150),
            getAnotherCourseButton.bottomAnchor.constraint(equalTo: courseContainerView.bottomAnchor, constant: -40),
            getAnotherCourseButton.trailingAnchor.constraint(equalTo: courseContainerView.trailingAnchor, constant: -25),
        ])
        
    }
    
    private func SetupAction() {
        startButton.addTarget(self, action: #selector(dismissModal(_:)), for: .touchUpInside)
        getAnotherCourseButton.addTarget(self, action: #selector(dismissModal(_:)), for: .touchUpInside)
    }
    // MARK: - Action
    @objc func dismissModal(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

