import UIKit
import MapKit

class MapContentViewContoller: UIViewController {
    // MARK: - property
    let map = MKMapView()
    let chungNamCoordinate = CLLocationCoordinate2D(latitude: 36.36220885252049, longitude: 127.34467506408693)
    
    // MARK: - SubViews
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
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupTabBar()
        SetupMap()
        
        map.delegate = self
        
        let safeAreaGuide = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            buttonStackView.heightAnchor.constraint(equalToConstant: 80.0),
            buttonStackView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            buttonStackView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            buttonStackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -5),
        ])
        
    }
    
    // MARK: - Setup
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
    private func SetupMap() {
        view.addSubview(map)
        map.translatesAutoresizingMaskIntoConstraints = false // 빼 먹지 말자!
        NSLayoutConstraint.activate([
            map.heightAnchor.constraint(equalTo: view.heightAnchor, constant: -80),
            map.topAnchor.constraint(equalTo: view.topAnchor),
            map.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            map.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        map.setRegion(MKCoordinateRegion(center: chungNamCoordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true)
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.didTappedMapView(_:)))
        map.addGestureRecognizer(tap)
    }
    
    
    // MARK: - Action
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
    
    @objc func didTappedMapView(_ sender: UITapGestureRecognizer) {
        print("Hello?")
        let addMarkerModal = AddMarkerModal()
        addMarkerModal.modalPresentationStyle = .overFullScreen
        present(addMarkerModal, animated: true, completion: nil)
    }
   
}

// MARK: - Delegate
extension MapContentViewContoller: MKMapViewDelegate, CLLocationManagerDelegate {
    
}
