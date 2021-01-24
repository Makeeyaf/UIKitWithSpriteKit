//
//  SnowScene.swift
//  UIKitWithSpriteKit
//
//  Created by Makeeyaf on 2021/01/24.
//

import SpriteKit

class SnowScene: SKScene {

    // MARK: Lifecycle

    override func didMove(to view: SKView) {
        setScene(view)
        setSnowNode()
    }

    override func didApplyConstraints() {
        guard let view = view else { return }
        scene?.size = view.frame.size
    }

    private func setScene(_ view: SKView) {
        backgroundColor = .clear
        scene?.anchorPoint = CGPoint(x: 0.5, y: 1)
        scene?.scaleMode = .aspectFill
    }

    private func setSnowNode() {
        guard let snowNode = SKEmitterNode(fileNamed: "Snow") else { return }
        snowNode.position = .zero
        scene?.addChild(snowNode)
    }

}
