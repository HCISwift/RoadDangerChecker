//
//  SharedViewController.swift
//  RoadDangerChecker
//
//  Created by SeungMin Lee on 2022/06/18.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    let madeCourseModal = MadeCourseModal()
    
    let itemBox: UIView = {
        let itemBox = UIView()
        itemBox.backgroundColor = .gray
        return itemBox
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage.map.mapImage)

        return imageView
    }()
    
    let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.backgroundColor = .systemGray2
        nameLabel.textColor = .white
        nameLabel.textAlignment = .center
        return nameLabel
    }()
    
    let stackView: UIStackView = {
        let star1 = UIImageView(image: UIImage(named: "starFill"))
        let star2 = UIImageView(image: UIImage(named: "starFill"))
        let star3 = UIImageView(image: UIImage(named: "starFill"))
        let stackView = UIStackView(arrangedSubviews: [star1, star2, star3])
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = 1
        stackView.backgroundColor = .clear
        
        NSLayoutConstraint.activate([
            star1.widthAnchor.constraint(equalToConstant: 20),
            star1.heightAnchor.constraint(equalToConstant: 20),
            star2.widthAnchor.constraint(equalToConstant: 20),
            star2.heightAnchor.constraint(equalToConstant: 20),
            star3.widthAnchor.constraint(equalToConstant: 20),
            star3.heightAnchor.constraint(equalToConstant: 20),
        ])
        
        return stackView
    }()
    
    lazy var courseDetailButton: UIButton = {
        let courseDetailButton = UIButton()
        courseDetailButton.setTitle("자세히", for: .normal)
        courseDetailButton.setTitleColor(UIColor.white, for: .normal)
        courseDetailButton.backgroundColor = .systemGray2

        courseDetailButton.addTarget(CollectionViewCell.self, action: #selector(didDetailButtonTap(_:)), for: .touchUpInside)
        
        return courseDetailButton
    }()
    
    @objc private func didDetailButtonTap(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected {
            present(madeCourseModal, animated: true)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupConstraints()
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
        setupConstraints()
    }
    
    func setupView() {
        contentView.addSubview(itemBox)
        itemBox.translatesAutoresizingMaskIntoConstraints = false
        itemBox.layer.cornerRadius = 30
        
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 45
        
        contentView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.clipsToBounds = true
        nameLabel.layer.cornerRadius = 20
        
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(courseDetailButton)
        courseDetailButton.translatesAutoresizingMaskIntoConstraints = false
        courseDetailButton.clipsToBounds = true
        courseDetailButton.layer.cornerRadius = 20
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            itemBox.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 4),
            itemBox.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 16),
            itemBox.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -16),
            itemBox.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -4),
            
            imageView.topAnchor.constraint(equalTo: itemBox.topAnchor, constant: 16),
            imageView.leftAnchor.constraint(equalTo: itemBox.leftAnchor, constant: 16),
            imageView.bottomAnchor.constraint(equalTo: itemBox.bottomAnchor, constant: -16),
            imageView.widthAnchor.constraint(equalToConstant: 175),
            
            nameLabel.topAnchor.constraint(equalTo: itemBox.topAnchor, constant: 32),
            nameLabel.rightAnchor.constraint(equalTo: itemBox.rightAnchor, constant: -8),
            nameLabel.widthAnchor.constraint(equalToConstant: 175),
            nameLabel.heightAnchor.constraint(equalToConstant: 48),
            
            stackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            stackView.rightAnchor.constraint(equalTo: itemBox.rightAnchor, constant: -64),
            
            courseDetailButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 4),
            courseDetailButton.rightAnchor.constraint(equalTo: itemBox.rightAnchor, constant: -8),
            courseDetailButton.widthAnchor.constraint(equalToConstant: 175),
            courseDetailButton.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
    
}

extension UIImage {
    enum map {
        static let mapImage = UIImage(named: "SharedMap")
    }
}

let map: [UIImage] = [UIImage(named: "SharedMap")!, UIImage(named: "SharedMap")!, UIImage(named: "SharedMap")!]

let nameLabel = ["집에서 충남대학교까지", "집에서 다이소까지", "집에서 농협까지"]

class CustomCollectionView: UICollectionView {

    // none

}

class SharedViewController: UIViewController {
    
    private var customCollectionView: CustomCollectionView!
    private let data = Data()
    
    let labelView: UILabel = {
        let labelView = UILabel()
        labelView.backgroundColor = .gray
        labelView.text = "Course"
        labelView.textColor = .white
        labelView.textAlignment = .center
        return labelView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setLabelView()
        setCollectionView()
        registerCollectionView()
        collectionViewDelegate()
    }
    
    func setCollectionView() {
        customCollectionView = CustomCollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        customCollectionView.translatesAutoresizingMaskIntoConstraints = false
        customCollectionView.backgroundColor = .black
        customCollectionView.layer.cornerRadius = 30
        
        view.addSubview(customCollectionView)
        NSLayoutConstraint.activate([
            customCollectionView.topAnchor.constraint(equalTo: labelView.bottomAnchor, constant: 20),
            customCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            customCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            customCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func setLabelView() {
        view.addSubview(labelView)
        labelView.translatesAutoresizingMaskIntoConstraints = false
        labelView.clipsToBounds = true
        labelView.layer.cornerRadius = 25
        NSLayoutConstraint.activate([
            labelView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            labelView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: view.frame.width / 4),
            labelView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -(view.frame.width / 4)),
            labelView.heightAnchor.constraint(equalToConstant: view.frame.height / 16),
        ])
    }
    
    func registerCollectionView() {
        customCollectionView.register(CollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "cellIdentifier")
    }
    
    func collectionViewDelegate() {
        customCollectionView.delegate = self
        customCollectionView.dataSource = self
    }
}

extension SharedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width: CGFloat = collectionView.frame.width
        
        return CGSize(width: width, height: width/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = customCollectionView.dequeueReusableCell(withReuseIdentifier: "cellIdentifier", for: indexPath) as! CollectionViewCell
        cell.imageView.image = map[indexPath.row]
        cell.nameLabel.text = nameLabel[indexPath.row]
        return cell
    }
    
}
