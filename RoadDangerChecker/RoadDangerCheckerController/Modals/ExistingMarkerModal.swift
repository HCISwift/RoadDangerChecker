//
//  ExistingMarkerModal.swift
//  RoadDangerChecker
//
//  Created by 정다운 on 2022/06/16.
//

import UIKit

class ExistingMarkerModal: UIViewController {
    // MARK: - property
    let ExistingviewWidth: CGFloat = 300.0
    let ExistingviewHeight: CGFloat = 420.0
    
    // MARK: - Subview
    private lazy var ExistingcontainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray2
        view.layer.cornerRadius = 10.0
        view.clipsToBounds = true
        return view
    }()
    
    private let ExistingcloseButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(.Icon.cancel, for: .normal)
        return button
    } ()
    
    private let ExistingimageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.Icon.roadMarker
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10.0
        
        return imageView
    }()
    
    private let ExistingtextLabel: UILabel = {
        let label = UILabel()
        label.text = "2022년 5월 20일 3시"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        
        return label
    }()
    
    private let ExistingdetailTextLabel: UILabel = {
        let label = UILabel()
        label.text = "도로 아스팔트 파손"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)

        return label
    } ()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SetupView()
        SetupAction()
    }
    
    // MARK: - Setup
    private func SetupView() {
        view.addSubview(ExistingcontainerView)
        ExistingcontainerView.translatesAutoresizingMaskIntoConstraints = false
        
        ExistingcontainerView.addSubview(ExistingcloseButton)
        ExistingcontainerView.addSubview(ExistingimageView)
        ExistingcontainerView.addSubview(ExistingtextLabel)
        ExistingcontainerView.addSubview(ExistingdetailTextLabel)
        
        ExistingcloseButton.translatesAutoresizingMaskIntoConstraints = false
        ExistingimageView.translatesAutoresizingMaskIntoConstraints = false
        ExistingtextLabel.translatesAutoresizingMaskIntoConstraints = false
        ExistingdetailTextLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            ExistingcontainerView.heightAnchor.constraint(equalToConstant: ExistingviewHeight),
            ExistingcontainerView.widthAnchor.constraint(equalToConstant: ExistingviewWidth),
            ExistingcontainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ExistingcontainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            ExistingcloseButton.trailingAnchor.constraint(equalTo: ExistingcontainerView.trailingAnchor, constant: -10),
            ExistingcloseButton.topAnchor.constraint(equalTo: ExistingcontainerView.topAnchor, constant: 5),
            
            ExistingimageView.widthAnchor.constraint(equalToConstant: 200),
            ExistingimageView.heightAnchor.constraint(equalToConstant: 280),
            ExistingimageView.centerXAnchor.constraint(equalTo: ExistingcontainerView.centerXAnchor),
            ExistingimageView.topAnchor.constraint(equalTo: ExistingcontainerView.topAnchor, constant: 40),
            
            ExistingtextLabel.topAnchor.constraint(equalTo: ExistingimageView.bottomAnchor, constant: 20),
            ExistingtextLabel.centerXAnchor.constraint(equalTo: ExistingcontainerView.centerXAnchor),
            
            ExistingdetailTextLabel.topAnchor.constraint(equalTo: ExistingimageView.bottomAnchor, constant: 60),
            ExistingdetailTextLabel.centerXAnchor.constraint(equalTo: ExistingcontainerView.centerXAnchor),
        ])
    }
    
    private func SetupAction() {
        ExistingcloseButton.addTarget(self, action: #selector(dismissModal(_:)), for: .touchUpInside)
    }

    // MARK: - Action
    @objc func dismissModal(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
