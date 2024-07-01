//
//  HandingTrackingModel.swift
//  Doodle
//
//  Created by Venkatesh Alampally on 14/06/24.
//
//import SwiftUI
//import RealityKit
//import RealityKitContent
//import ARKit
//
//@MainActor class HandTrackingModel: ObservableObject {
//    private let session = ARKitSession()
//    private let handTracking = HandTrackingProvider()
//    private var contentEntity = Entity()
//    
//    private var meshEntities = [UUID : ModelEntity]()
//    
//    private let fingerEntities: [HandAnchor.Chirality: ModelEntity] = [
//        .left: createFingerTip(),
//        .right: createFingerTip()
//    ]
//    
//    func setupContentEntity() -> Entity {
//        for entity in fingerEntities.values {
//            contentEntity.addChild(entity)
//        }
//        
//        return contentEntity
//    }
//    
//    private static func createFingerTip() -> ModelEntity {
//        let mesh = MeshResource.generateSphere(radius: 0.01)
//        let material = SimpleMaterial(color: .red, isMetallic: true)
//        let modelEntity = ModelEntity(mesh: mesh, materials: [material])
//        return modelEntity
//    }
//}

//
//  HandTrackingModel.swift
//  Doodle
//
//  Created by Venkatesh Alampally on 14/06/24.
//
import SwiftUI
import RealityKit
import ARKit

// TODO: change the ARSession to ARKitSession as soon as possible
@MainActor class HandTrackingModel: ObservableObject {
    private var handTrackingProvider = HandTrackingProvider()
    private var contentEntity = Entity()
    
    private var fingerEntities: [HandAnchor.Chirality: ModelEntity] = [
        .left: createFingerTip(),
        .right: createFingerTip()
    ]
    
    @Published var leftFingerTipPosition: SIMD3<Float>? = nil
    
    func setupContentEntity() -> Entity {
        for entity in fingerEntities.values {
            contentEntity.addChild(entity)
        }
        
        return contentEntity
    }
    
    private static func createFingerTip() -> ModelEntity {
        let mesh = MeshResource.generateSphere(radius: 0.005)
        let material = SimpleMaterial(color: .red, isMetallic: true)
        let modelEntity = ModelEntity(mesh: mesh, materials: [material])
        return modelEntity
    }
    
    init() {
        if HandTrackingProvider.isSupported {
            ARKitSession()
        } else {
            print("Hand tracking is not supported on this device.")
        }
    }
}
