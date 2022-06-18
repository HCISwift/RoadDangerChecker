import UIKit
import MapKit

class MapContentViewContoller: UIViewController {
    // MARK: - property
    let map = MKMapView()
    let chungNamCoordinate = CLLocationCoordinate2D(latitude: 36.36220885252049, longitude: 127.34467506408693)
    var tapForMarker = UITapGestureRecognizer()
    var tapForRoute = UITapGestureRecognizer()
    var routeStartAndDestination: [CLLocationCoordinate2D] = []
    var directionArray: [MKRoute] = []
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
    
    private let makeRouteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let playImage = UIImage(systemName: "play.fill", withConfiguration: UIImage.SymbolConfiguration(
            pointSize: 25))
        button.setImage(playImage, for: .normal)
        let pauseImage = UIImage(systemName: "pause.fill", withConfiguration: UIImage.SymbolConfiguration(
            pointSize: 25))
        button.addTarget(self, action: #selector(IsMakeRoute(_:)), for: .touchUpInside)
        button.setImage(pauseImage, for: .selected)
        
        return button
    }()
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
        view.addSubview(makeRouteButton)
        map.translatesAutoresizingMaskIntoConstraints = false // 빼 먹지 말자!
        
        NSLayoutConstraint.activate([
            makeRouteButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 35),
            makeRouteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            
            map.heightAnchor.constraint(equalTo: view.heightAnchor, constant: -80),
            map.topAnchor.constraint(equalTo: view.topAnchor),
            map.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            map.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        map.setRegion(MKCoordinateRegion(center: chungNamCoordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true)
        //let tap = UITapGestureRecognizer(target: self, action: #selector(self.didTappedMapView(_:)))
        self.tapForMarker = UITapGestureRecognizer(target: self, action: #selector(self.didTappedMapView(_:)))
        self.tapForRoute = UITapGestureRecognizer(target: self, action: #selector(self.didTappedForRoute(_:)))
        //map.addGestureRecognizer(tap)
    }
    // MARK: - Action
    @objc func MoveToFirstModal(_ sender: UIButton) {
        let firstModal = FirstModal()
        present(firstModal, animated: false)
    }
    
    @objc func MoveToSecondModal(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            print("hello")
            //map.delegate = nil
            roadButton.isSelected = false
            makeRouteButton.isSelected = false
            makeRouteButton.removeTarget(nil, action: nil, for: .allEvents)
            
            map.addGestureRecognizer(self.tapForMarker)
            map.removeGestureRecognizer(self.tapForRoute)
        } else {
            print("bye")
            makeRouteButton.addTarget(self, action: #selector(IsMakeRoute(_:)), for: .touchUpInside)
            //map.delegate = self
            map.removeGestureRecognizer(self.tapForMarker)
            }
        }
    
    @objc func IsMakeRoute(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            print("hi?")
            dangerButton.isSelected = false
            roadButton.isSelected = false
            dangerButton.removeTarget(nil, action: nil, for: .allEvents)
            
            map.removeGestureRecognizer(self.tapForMarker)
            map.addGestureRecognizer(self.tapForRoute)
            
        } else {
            print("byeee")
            dangerButton.addTarget(self, action: #selector(MoveToSecondModal(_:)), for: .touchUpInside)
            
            map.removeGestureRecognizer(self.tapForRoute)
            routeStartAndDestination = []
        }
    }
    
    @objc func didTappedForRoute(_ sender: UITapGestureRecognizer) {
        if (self.routeStartAndDestination.count < 2) {
            
            let location: CGPoint = sender.location(in: self.map)
            let mapPoint = self.map.convert(location, toCoordinateFrom: self.map)
            routeStartAndDestination.append(mapPoint)
        }
        else if(self.routeStartAndDestination.count == 2 ){
            print("Time to Make Route")
            let startPosition = routeStartAndDestination[0]
            let destinationPosition = routeStartAndDestination[1]
            createPath(start: startPosition, destination: destinationPosition)
            self.routeStartAndDestination = []
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
    private func addCustiomPin(coord: CLLocationCoordinate2D) -> MKAnnotation {
        let pin = MKPointAnnotation()
        pin.coordinate = coord
        pin.title = "위험 마커"
        return pin
    }
    
    private func createPath(start: CLLocationCoordinate2D, destination: CLLocationCoordinate2D) {
        let startMark = MKPlacemark(coordinate: start, addressDictionary: nil)
        let destinationMark = MKPlacemark(coordinate: destination, addressDictionary: nil)
        let startMapItem = MKMapItem(placemark: startMark)
        let destinationMapItem = MKMapItem(placemark: destinationMark)
        
        let startAnnotation = MKPointAnnotation()
        startAnnotation.title = "출발"
        if let location = startMark.location {
            startAnnotation.coordinate = location.coordinate
        }
        
        let destinationAnotation = MKPointAnnotation()
        destinationAnotation.title = "도착"
        if let location = destinationMark.location {
            destinationAnotation.coordinate = location.coordinate
        }
        
        self.map.showAnnotations([startAnnotation, destinationAnotation], animated: true)
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = startMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .automobile
        
        let direction = MKDirections(request: directionRequest)
        
        direction.calculate{ (response, error) in
            guard let response = response else {
                if let error = error {
                    print("Error Found! \(error)")
                }
                return
            }
            let route = response.routes[0]
            self.map.addOverlay(route.polyline, level: MKOverlayLevel.aboveRoads)
            let rect = route.polyline.boundingMapRect
            self.map.setRegion(MKCoordinateRegion(rect), animated: true)
        }
    }
    
}

// MARK: - Delegate
extension MapContentViewContoller: MKMapViewDelegate, AddMarkerModalDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let value = view.annotation?.title ?? nil {
            print(value)
            if value != "위험 마커" {
                return
            }
        }
        print("clicked Marker")
        let existingMarkerModal = ExistingMarkerModal()
        existingMarkerModal.modalPresentationStyle = .overFullScreen
        present(existingMarkerModal, animated: true, completion: nil)
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        print("Hello")
        var annotationView = self.map.dequeueReusableAnnotationView(withIdentifier: "Marker")
                
        if annotationView == nil {
                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "Marker")
                annotationView!.canShowCallout = true
                }
                else {
                annotationView!.annotation = annotation
                }
                
        switch (annotation.title) {
        case "위험 마커":
            annotationView?.image = UIImage(named: "Marker")
        case "출발":
            annotationView?.image = UIImage(named: "Start")
        case "도착":
            annotationView?.image = UIImage(named: "End")
        default:
            break;
        }
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.lineWidth = 4
        renderer.strokeColor = .systemRed
        return renderer
    }
    
    func canMakeAnnotation(location:CLLocationCoordinate2D?) {
        // 마커 생성, 그 마커는 클릭이 가능해야 함!
        let marker = addCustiomPin(coord: location!)
        self.map.addAnnotation(marker)
        
    }
}
