//
//  AddMarkerModal.swift
//  TabBarTest
//
//  Created by 정다운 on 2022/06/05.
//

import UIKit

class AddMarkerModal: UIViewController {
    // MARK: - property
    let viewWidth: CGFloat = 300.0
    let viewHeight: CGFloat = 500.0
    var annotationMakeFlag = false
    var location: Array<CGFloat> = [CGFloat]()
    
    // MARK: - Subview
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray2
        view.layer.cornerRadius = 10.0
        view.clipsToBounds = true
        return view
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(.Icon.cancel, for: .normal)
        return button
    } ()
    
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.layer.cornerRadius = 10.0
        
        return imageView
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.text = "이미지를 넣으세요"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        
        return label
    }()
    
    private let detailTextField: UITextField = {
        let detailText = UITextField()
        detailText.placeholder = "세부사항을 입력하세요."
        detailText.backgroundColor = .black
        detailText.textColor = .white
        return detailText
    } ()
    
    private let detailTextLabel: UILabel = {
        let label = UILabel()
        label.text = "도로 아스팔트 파손"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)

        return label
    } ()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGray5
        button.layer.cornerRadius = 10.0
        // button color
        button.setTitle("등록하기", for: .normal)
        return button
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupView()
        SetupAction()
    }
    
    // MARK: - Setup
    private func SetupView() {
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(closeButton)
        containerView.addSubview(imageView)
        containerView.addSubview(textLabel)
        containerView.addSubview(detailTextField)
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        detailTextField.translatesAutoresizingMaskIntoConstraints = false
        
        self.detailTextField.delegate = self
        
        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalToConstant: viewHeight),
            containerView.widthAnchor.constraint(equalToConstant: viewWidth),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            closeButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            closeButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5),
            
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 280),
            imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 40),
            
            textLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            textLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            detailTextField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 60),
            detailTextField.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
        ])
    }
    
    private func SetupAction() {
        closeButton.addTarget(self, action: #selector(dismissModal(_:)), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveAnnotation(_:)), for: .touchUpInside)
        
        let tapImageView = UITapGestureRecognizer(target: self, action: #selector(changeImageView(_:)))
        imageView.addGestureRecognizer(tapImageView)
        imageView.isUserInteractionEnabled = true
    }
    
    // MARK: - Action
    @objc func dismissModal(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @objc func saveAnnotation(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil) // 일단 눈속임.. 올바른 구현은 아님!
    }
    @objc func changeImageView(_ sender: UITapGestureRecognizer) {
        print("changeImageVIew")
        self.imageView.image = UIImage.Icon.roadMarker
        imageView.contentMode = .scaleAspectFit
    }
    
}

extension AddMarkerModal: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 엔터를 누르면 -> TextField 삭제하고, 그 위치 그대로
        if textField == self.detailTextField {
            print("deleteField")
            imageView.isUserInteractionEnabled = true
            self.detailTextField.removeFromSuperview()
            self.textLabel.text = "2022년 5월 20일 3시"
            
            containerView.addSubview(detailTextLabel)
            containerView.addSubview(saveButton)
            detailTextLabel.translatesAutoresizingMaskIntoConstraints = false
            saveButton.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                detailTextLabel.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 20),
                detailTextLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
                saveButton.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 60),
                saveButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            ])
        }
        return true
    }
}
