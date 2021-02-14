//
//  PopViewController.swift
//  UIKitWithSpriteKit
//
//  Created by Makeeyaf on 2021/02/14.
//

import UIKit
import SpriteKit

class PopViewController: UIViewController {
    let label: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 16, weight: .semibold)
        view.text = "Makeeyaf"
        return view
    }()

    let container: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPink
        view.layer.cornerRadius = 6
        return view
    }()

    lazy var paticleView: SKView = {
        let view = SKView()
        view.backgroundColor = .clear
        let scene = SKScene()
        scene.backgroundColor = .clear
        view.presentScene(scene)
        return view
    }()

    var isButtonAvailable: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(paticleView)
        view.addSubview(container)
        container.addSubview(label)

        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(setImage))
        container.addGestureRecognizer(tapRecognizer)

        [paticleView, container, label].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            label.topAnchor.constraint(equalTo: container.topAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10),
            label.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10),
        ])

        NSLayoutConstraint.activate([
            container.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            container.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])

        NSLayoutConstraint.activate([
            paticleView.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            paticleView.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            paticleView.widthAnchor.constraint(equalTo: view.widthAnchor),
            paticleView.heightAnchor.constraint(equalTo: view.heightAnchor),
        ])
    }

    @objc func setImage() {
        guard isButtonAvailable, let image = container.asUIImage() else { return }
        isButtonAvailable = false

        let texture = SKTexture(image: image)
        let scene = PopScene()
        scene.emitter?.particleTexture = texture
        paticleView.presentScene(scene)

        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) { [weak self] in
            self?.isButtonAvailable = true
        }
    }
}


extension UIView {
    func asUIImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: self.frame.width, height: self.frame.height), true, 1)

        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        layer.render(in: context)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image
    }
}

class PopScene: SKScene {
    let emitter: SKEmitterNode? = {
        let node = SKEmitterNode(fileNamed: "Paticle")
        node?.position = .zero
        return node
    }()

    // MARK: Lifecycle

    override func didMove(to view: SKView) {
        setScene(view)
        guard let emitter = emitter else { return }
        scene?.addChild(emitter)
    }

    override func didApplyConstraints() {
        guard let view = view else { return }
        scene?.size = view.frame.size
    }

    private func setScene(_ view: SKView) {
        backgroundColor = .clear
        scene?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        scene?.scaleMode = .aspectFill
    }
}
