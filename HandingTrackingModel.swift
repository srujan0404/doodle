//
//  HandingTrackingModel.swift
//  Doodle
//
//  Created by SST Reality Lab 02 on 14/06/24.
//

import SwiftUI
import RealityKit
import RealityKitContent
import ARKit

@MainActor class HandingTrackingModel: ObservableObject {
    private let session = ARKitSession()
    private let handTracking = HandTrackingProvider()
    private var contentEntity = Entity()
    
    private var meshEntities = [UUID : ModelEntity]()
    
    private let fingerEntities: [HandAnchor.Chirality: ModelEntity] = [
        .left: createFingerTip()
    ]
    
    func setupContentEntity() -> Entity {
        for entity in fingerEntities.values{
            contentEntity.addChild(entity)
        }
        
        return contentEntity
    }
    
}

