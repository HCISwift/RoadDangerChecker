import UIKit
import MapKit

class MapContentViewContoller: UIViewController {
    // MARK: - property
    let map = MKMapView()
    let chungNamCoordinate = CLLocationCoordinate2D(latitude: 36.36220885252049, longitude: 127.34467506408693)
    var tapForMarker = UITapGestureRecognizer()
    var isMakeAnnotation = false
    
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
        //let tap = UITapGestureRecognizer(target: self, action: #selector(self.didTappedMapView(_:)))
        self.tapForMarker = UITapGestureRecognizer(target: self, action: #selector(self.didTappedMapView(_:)))
        //map.addGestureRecognizer(tap)
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
            map.delegate = nil
            map.addGestureRecognizer(self.tapForMarker)
        } else {
            print("bye")
            map.delegate = self
            map.removeGestureRecognizer(self.tapForMarker)
            }
        }
    
    @objc func didTappedMapView(_ sender: UITapGestureRecognizer) {
        print("Hello?")
        let location: CGPoint = sender.location(in: self.map)
        let mapPoint = self.map.convert(location, toCoordinateFrom: self.map)
        let addMarkerModal = AddMarkerModal()
        addMarkerModal.location = mapPoint
        
        addMarkerModal.modalPresentationStyle = .overFullScreen
        addMarkerModal.delegate = self
        present(addMarkerModal, animated: true, completion: nil)
    }
    // MARK: - Custom Func
    private func addCustiomPin(coord: CLLocationCoordinate2D) -> MKPointAnnotation {
        let pin = MKPointAnnotation()
        pin.coordinate = coord
        pin.title = "위험 마커"
        return pin
    }
}

// MARK: - Delegate
extension MapContentViewContoller: MKMapViewDelegate, AddMarkerModalDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("clicked Marker")
        let existingMarkerModal = ExistingMarkerModal()
        existingMarkerModal.modalPresentationStyle = .overFullScreen
        present(existingMarkerModal, animated: true, completion: nil)
    }
    
    func canMakeAnnotation(location:CLLocationCoordinate2D?) {
        // 마커 생성, 그 마커는 클릭이 가능해야 함!
        let marker = addCustiomPin(coord: location!)
        self.map.addAnnotation(marker)
        
    }
}
