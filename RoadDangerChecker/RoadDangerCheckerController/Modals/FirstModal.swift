//
//  FIrstModal.swift
//  TabBarTest
//
//  Created by 정다운 on 2022/05/28.
//

import UIKit

// MARK: - MyCourseCollectionView
struct Data {
    let memberName = ["효정", "미미", "유아", "승희", "지호"
    ]
}

class MyCourseCollectionView: UICollectionView {
    // none
}

class SharedCollectionView: UICollectionView {
    // none
}

class CollectionViewCell: UICollectionViewCell {
    
    var memberNameLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpCell()
        setUpLabel()
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUpCell()
        setUpLabel()
    }
    
    func setUpCell() {
        memberNameLabel = UILabel()
        contentView.addSubview(memberNameLabel)
        memberNameLabel.translatesAutoresizingMaskIntoConstraints = false
        memberNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        memberNameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        memberNameLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        memberNameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    func setUpLabel() {
        memberNameLabel.font = UIFont.systemFont(ofSize: 12)
        memberNameLabel.textAlignment = .center
    }
}

// MARK: - CollectionView

class FirstModal: UITabBarController {
    
    private var customCollectionView: MyCourseCollectionView!
    private var sharedCollectionView: SharedCollectionView!
    private let data = Data()
    private var changeButton = -1
    
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
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected {
            setCollectionView(sender)
        }
    }
    
    func setCollectionView(_ sender: UIButton) {
        print(sender.titleLabel?.text!)
        if (sender.titleLabel?.text! == "My Course") {
            if (changeButton != 0) {
                changeButton = 0
                NSLayoutConstraint.activate([
                    customCollectionView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
                    customCollectionView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10),
                    customCollectionView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -10),
                    customCollectionView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
                ])
            }
        }
        else {
            if (changeButton != 1) {
                changeButton = 1
                customCollectionView.removeFromSuperview()
            }
        }
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
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected {
            setCollectionView(sender)
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
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
    let maxDimmedAlpha: CGFloat = 0.6
    lazy var dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = maxDimmedAlpha
        return view
    }()
    
    // Constants
    let defaultHeight: CGFloat = 500
    let dismissibleHeight: CGFloat = 200
    let maximumContainerHeight: CGFloat = UIScreen.main.bounds.height - 64
    // keep current new height, initial is default height
    var currentContainerHeight: CGFloat = 300
    
    // Dynamic container constraint
    var containerViewHeightConstraint: NSLayoutConstraint?
    var containerViewBottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        // tap gesture on dimmed view to dismiss
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleCloseAction))
        dimmedView.addGestureRecognizer(tapGesture)
        
        setupPanGesture()
        
        registerCollectionView()
        collectionViewDelegate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateShowDimmedView()
        animatePresentContainer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    // UITabBarControllerDelegate method
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected \(viewController.title!)")
    }
    
    func setupView() {
        view.backgroundColor = .clear
    }
    
    func setupConstraints() {
        // Add subviews
        view.addSubview(dimmedView)
        dimmedView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(topBarView)
        topBarView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        customCollectionView = MyCourseCollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        containerView.addSubview(customCollectionView)
        customCollectionView.translatesAutoresizingMaskIntoConstraints = false
        customCollectionView.backgroundColor = .clear
        
        // Set static constraints
        NSLayoutConstraint.activate([
            // set dimmedView edges to superview
            dimmedView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmedView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dimmedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            // set container static constraint (trailing & leading)
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            topBarView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            topBarView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 150),
            topBarView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -150),
            topBarView.heightAnchor.constraint(equalToConstant: CGFloat(10)),
            
            stackView.topAnchor.constraint(equalTo: topBarView.bottomAnchor, constant: 10),
            stackView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10),
            stackView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -10),
        ])
        
        // Set dynamic constraints
        // First, set container to default height
        // after panning, the height can expand
        containerViewHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: defaultHeight)
        
        // By setting the height to default height, the container will be hide below the bottom anchor view
        // Later, will bring it up by set it to 0
        // set the constant to default height to bring it down again
        containerViewBottomConstraint = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: defaultHeight)
        // Activate constraints
        containerViewHeightConstraint?.isActive = true
        containerViewBottomConstraint?.isActive = true
    }
    
    func registerCollectionView() {
        customCollectionView.register(CollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "cellIdentifier")
    }
    
    func collectionViewDelegate() {
        customCollectionView.delegate = self
        customCollectionView.dataSource = self
    }
    
    func setupPanGesture() {
        // add pan gesture recognizer to the view controller's view (the whole screen)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture(gesture:)))
        // change to false to immediately listen on gesture movement
        panGesture.delaysTouchesBegan = false
        panGesture.delaysTouchesEnded = false
        view.addGestureRecognizer(panGesture)
    }
    
    @objc func handleCloseAction() {
        animateDismissView()
    }
    
    // MARK: Pan gesture handler
    @objc func handlePanGesture(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        // Drag to top will be minus value and vice versa
        print("Pan gesture y offset: \(translation.y)")
        
        // Get drag direction
        let isDraggingDown = translation.y > 0
        print("Dragging direction: \(isDraggingDown ? "going down" : "going up")")
        
        // New height is based on value of dragging plus current container height
        let newHeight = currentContainerHeight - translation.y
        
        // Handle based on gesture state
        switch gesture.state {
        case .changed:
            // This state will occur when user is dragging
            if newHeight < maximumContainerHeight {
                // Keep updating the height constraint
                containerViewHeightConstraint?.constant = newHeight
                // refresh layout
                view.layoutIfNeeded()
            }
        case .ended:
            // This happens when user stop drag,
            // so we will get the last height of container
            
            // Condition 1: If new height is below min, dismiss controller
            if newHeight < dismissibleHeight {
                self.animateDismissView()
            }
            else if newHeight < defaultHeight {
                // Condition 2: If new height is below default, animate back to default
                animateContainerHeight(defaultHeight)
            }
            else if newHeight < maximumContainerHeight && isDraggingDown {
                // Condition 3: If new height is below max and going down, set to default height
                animateContainerHeight(defaultHeight)
            }
            else if newHeight > defaultHeight && !isDraggingDown {
                // Condition 4: If new height is below max and going up, set to max height at top
                animateContainerHeight(maximumContainerHeight)
            }
        default:
            break
        }
    }
    
    func animateContainerHeight(_ height: CGFloat) {
        UIView.animate(withDuration: 0.4) {
            // Update container height
            self.containerViewHeightConstraint?.constant = height
            // Call this to trigger refresh constraint
            self.view.layoutIfNeeded()
        }
        // Save current height
        currentContainerHeight = height
    }
    
    // MARK: Present and dismiss animation
    func animatePresentContainer() {
        // update bottom constraint in animation block
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint?.constant = 0
            // call this to trigger refresh constraint
            self.view.layoutIfNeeded()
        }
    }
    
    func animateShowDimmedView() {
        dimmedView.alpha = 0
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = self.maxDimmedAlpha
        }
    }
    
    func animateDismissView() {
        // hide blur view
        dimmedView.alpha = maxDimmedAlpha
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = 0
        } completion: { _ in
            // once done, dismiss without animation
            self.dismiss(animated: false)
        }
        // hide main view by updating bottom constraint in animation block
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint?.constant = self.defaultHeight
            // call this to trigger refresh constraint
            self.view.layoutIfNeeded()
        }
    }
}

extension FirstModal: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width / 3 - 1
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.memberName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = customCollectionView.dequeueReusableCell(withReuseIdentifier: "cellIdentifier", for: indexPath) as! CollectionViewCell
        cell.memberNameLabel.text = data.memberName[indexPath.row]
        return cell
    }
}
