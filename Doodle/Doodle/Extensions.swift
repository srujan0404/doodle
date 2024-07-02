////
////  ModelEntity+Extensions.swift
////  HandTracking
////
////  Created by Srujan on 2/23/24.
////
//
import SwiftUI
import RealityKit
import UIKit
import Combine

extension ModelEntity {
   
   static func loadTexture(from url: URL, completion: @escaping (RealityKit.Material) -> Void) {
           URLSession.shared.dataTask(with: url) { data, response, error in
               if let data = data, let image = UIImage(data: data), let cgImage = image.cgImage {
                   let texture = try? TextureResource.generate(from: cgImage, options: .init(semantic: .color))
                   if let texture = texture {
                       var material = SimpleMaterial(color: .white, isMetallic: false)
                       material.baseColor = MaterialColorParameter.texture(texture)
                       completion(material)
                   }
               }
           }.resume()
       }
       
       static func createCarouselEntity(imageUrls: [String]) -> ModelEntity {
           let parentEntity = ModelEntity(mesh: .generateBox(width: 0.5, height: 0.250, depth: 0))
           
           let childEntity = ModelEntity(mesh: .generateBox(width: 0.25, height: 0.125, depth: 0))
           parentEntity.addChild(childEntity)
           
           var materials = [RealityKit.Material]()
           let urls = imageUrls.compactMap { URL(string: $0) }
           let dispatchGroup = DispatchGroup()
           
           for url in urls {
               dispatchGroup.enter()
               loadTexture(from: url) { material in
                   materials.append(material)
                   dispatchGroup.leave()
               }
           }
           
           dispatchGroup.notify(queue: .main) {
               var currentIndex = 0
               Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { timer in
                   if materials.isEmpty { return }
                   childEntity.model?.materials = [materials[currentIndex]]
                   currentIndex = (currentIndex + 1) % materials.count
               }
           }
           
           return parentEntity
       }
       
       static func createHandEntity() -> ModelEntity {
           let simpleMaterial = SimpleMaterial(color: UIColor(hex: "888888"), isMetallic: false)
           let parentEntity = ModelEntity(mesh: .generateBox(width: 0.5, height: 0.250, depth: 0), materials: [simpleMaterial])
           
//            let childMaterial = SimpleMaterial(color: UIColor(hex: "000000"), isMetallic: false)
//            let childEntity = ModelEntity(mesh: .generateBox(width: 0.25, height: 0.125, depth: 0), materials: [childMaterial])
//            parentEntity.addChild(childEntity)
           
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
           
           let carouselEntity = createCarouselEntity(imageUrls: imageUrls)
           parentEntity.addChild(carouselEntity)
           
           return parentEntity
       }
}
//
//extension UIColor {
//    convenience init(hex: String) {
//        let scanner = Scanner(string: hex)
//        var color: UInt64 = 0
//        scanner.scanHexInt64(&color)
//        let r = CGFloat((color & 0xFF0000) >> 16) / 255.0
//        let g = CGFloat((color & 0x00FF00) >> 8) / 255.0
//        let b = CGFloat(color & 0x0000FF) / 255.0
//        self.init(red: r, green: g, blue: b, alpha: 1.0)
//    }
//}
//
//
//let imageUrls = [
//    "https://picsum.photos/200/300",
//    "https://picsum.photos/200/301",
//    "https://picsum.photos/200/302",
//    "https://picsum.photos/200/303",
//    "https://picsum.photos/200/304",
//    "https://picsum.photos/200/305",
//    "https://picsum.photos/200/306",
//    "https://picsum.photos/200/307",
//    "https://picsum.photos/200/308",
//    "https://picsum.photos/200/309",
//    "https://picsum.photos/200/310"
//]

//import SwiftUI
//import RealityKit
//import UIKit
//import Combine
//
//class YourViewController: UIViewController {
//    var currentIndex = 0
//    var materials: [RealityKit.Material] = []
//    var childEntity: ModelEntity!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // Your setup code here
//        // For example, setting up RealityKit entities
//
//        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
//        swipeLeft.direction = .left
//        view.addGestureRecognizer(swipeLeft)
//        
//        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
//        swipeRight.direction = .right
//        view.addGestureRecognizer(swipeRight)
//    }
//    
//    @objc func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
//        if gesture.direction == .left {
//            currentIndex = (currentIndex + 1) % materials.count
//        } else if gesture.direction == .right {
//            currentIndex = (currentIndex - 1 + materials.count) % materials.count
//        }
//        updateMaterial()
//    }
//    
//    func updateMaterial() {
//        if !materials.isEmpty {
//            childEntity.model?.materials = [materials[currentIndex]]
//        }
//    }
//    
//    func setupRealityKit() {
//        // Your existing RealityKit setup code
//        let parentEntity = ModelEntity(mesh: .generateBox(width: 0.5, height: 0.250, depth: 0))
//        childEntity = ModelEntity(mesh: .generateBox(width: 0.25, height: 0.125, depth: 0))
//        parentEntity.addChild(childEntity)
//
//        let imageUrls = [
//            "https://picsum.photos/200/300",
//                "https://picsum.photos/200/301",
//                "https://picsum.photos/200/302",
//                "https://picsum.photos/200/303",
//                "https://picsum.photos/200/304",
//                "https://picsum.photos/200/305",
//                "https://picsum.photos/200/306",
//                "https://picsum.photos/200/307",
//                "https://picsum.photos/200/308",
//                "https://picsum.photos/200/309",
//                "https://picsum.photos/200/310"
//        ]
//
//        let urls = imageUrls.compactMap { URL(string: $0) }
//        let dispatchGroup = DispatchGroup()
//        
//        for url in urls {
//            dispatchGroup.enter()
//            ModelEntity.loadTexture(from: url) { material in
//                self.materials.append(material)
//                dispatchGroup.leave()
//            }
//        }
//        
//        dispatchGroup.notify(queue: .main) {
//            self.updateMaterial() // Set the initial material
//        }
//
//        // Add parentEntity to your RealityKit scene
//    }
//}
//
//extension ModelEntity {
//    static func loadTexture(from url: URL, completion: @escaping (RealityKit.Material) -> Void) {
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            if let data = data, let image = UIImage(data: data), let cgImage = image.cgImage {
//                let texture = try? TextureResource.generate(from: cgImage, options: .init(semantic: .color))
//                if let texture = texture {
//                    var material = SimpleMaterial(color: .white, isMetallic: false)
//                    material.baseColor = MaterialColorParameter.texture(texture)
//                    completion(material)
//                }
//            }
//        }.resume()
//    }
//}
