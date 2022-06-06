import UIKit

class AddMarkerModal: UIViewController {
    // MARK: - property
    let viewWidth: CGFloat = 100.0
    let viewHeight: CGFloat = 100.0
    
    // MARK: - Subview
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemCyan
        view.layer.cornerRadius = 10.0
        view.clipsToBounds = true
        return view
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(.Icon.cancel, for: .normal)
        button.addTarget(self, action: #selector(dismissModal(_:)), for: .touchUpInside)
        return button
    } ()
    
    /*
    private let imageView: UIImageView = {
        
    }()
    
    private let textLabel: UILabel = {
        
    }()*/
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupView()
        
    }
    
    // MARK: - Setup
    private func SetupView() {
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalToConstant: viewHeight),
            containerView.widthAnchor.constraint(equalToConstant: viewWidth),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    // MARK: - Action
    @objc func dismissModal(_ sender: UIButton) {
        
    }
    @objc func saveAnnotation(_ sender: UIButton) {
        
    }
    
}
