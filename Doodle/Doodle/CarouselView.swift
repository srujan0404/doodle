//
//  CarouselView.swift
//  HandTracking
//
//  Created by Srujan on 02/07/24.
//

import RealityKit
import UIKit
import Combine

class CarouselView: UIView {
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    
    var imageUrls: [String] = [] {
        didSet {
            setupImages()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupScrollView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupScrollView()
    }
    
    private func setupScrollView() {
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        scrollView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
    }
    
    private func setupImages() {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for url in imageUrls {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            
            // Load image from URL
            if let imageUrl = URL(string: url) {
                URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                    if let data = data, let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            imageView.image = image
                        }
                    }
                }.resume()
            }
            
            stackView.addArrangedSubview(imageView)
        }
        
        scrollView.contentSize = CGSize(width: frame.width * CGFloat(imageUrls.count), height: frame.height)
    }
}

class CarouselViewController: UIViewController {
    let carouselView = CarouselView()
    let imageUrls = [
        "https://picsum.photos/200/300",
        "https://picsum.photos/200/301",
        "https://picsum.photos/200/302",
        "https://picsum.photos/200/303",
        "https://picsum.photos/200/304",
        "https://picsum.photos/200/305",
        "https://picsum.photos/200/306",
        "https://picsum.photos/200/307",
        "https://picsum.photos/200/308",
        "https://picsum.photos/200/309",
        "https://picsum.photos/200/310"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(carouselView)
        carouselView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            carouselView.topAnchor.constraint(equalTo: view.topAnchor),
            carouselView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            carouselView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            carouselView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        carouselView.imageUrls = imageUrls
    }
}
