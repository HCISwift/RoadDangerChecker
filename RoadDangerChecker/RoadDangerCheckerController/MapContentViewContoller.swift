import UIKit

class MapContentViewContoller: UIViewController {
    // MARK: property
    
    // MARK: SubViews
    private lazy var roadButton:UIButton = {
        let button = UIButton()
        button.setImage(.Icon.road, for: .normal)
        button.setImage(.Icon.roadSelected, for: .selected)
        button.addTarget(self, action: #selector(MoveToFirstModal(_:)), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        //(View 돌리는 코드)button.contentVerticalAlignment = .center
        button.contentVerticalAlignment = .center
        return button
    } ()
    
    private lazy var dangerButton: UIButton = {
        let button = UIButton()
        button.setImage(.Icon.danger, for: .normal)
        button.setImage(.Icon.dangerSelected, for: UIControl.State.selected)
        button.addTarget(self, action: #selector(MoveToSecondModal(_:)), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        //(View 돌리는 코드)button.contentVerticalAlignment = .center
        button.contentVerticalAlignment = .center
        return button
    } ()
    
    private let settingButton: UIButton = {
        let button = UIButton()
        button.setImage(.Icon.setting, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        //(View 돌리는 코드)button.contentVerticalAlignment = .center
        button.contentVerticalAlignment = .center
        return button
    } ()
    
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .systemGray2
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .darkGray
        SetupTabBar()
        
        let safeAreaGuide = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            buttonStackView.heightAnchor.constraint(equalToConstant: 80.0),
            buttonStackView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            buttonStackView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            buttonStackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -5),
        ])
    }
    // MARK: Setup
    private func SetupTabBar() {
        view.addSubview(buttonStackView)
        NSLayoutConstraint.activate([
            roadButton.widthAnchor.constraint(equalToConstant: 50.0),
            roadButton.heightAnchor.constraint(equalToConstant: 50.0),
            dangerButton.widthAnchor.constraint(equalToConstant: 50.0),
            dangerButton.heightAnchor.constraint(equalToConstant: 50.0),
            settingButton.widthAnchor.constraint(equalToConstant: 50.0),
            settingButton.heightAnchor.constraint(equalToConstant: 50.0),
        ])
        
        buttonStackView.addArrangedSubview(roadButton)
        buttonStackView.addArrangedSubview(dangerButton)
        buttonStackView.addArrangedSubview(settingButton)
    }
    
    
    // MARK: Action
    @objc func MoveToFirstModal(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected {
            print("hello")
        } else {
            print("bye")
        }
    }
    
    @objc func MoveToSecondModal(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            print("hello")
        } else {
            print("bye")
            }
        }
   
}
