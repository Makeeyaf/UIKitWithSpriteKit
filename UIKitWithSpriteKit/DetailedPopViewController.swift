//
//  DetailedPopViewController.swift
//  UIKitWithSpriteKit
//
//  Created by Makeeyaf on 2021/02/14.
//

import UIKit
import SpriteKit

class DetailedPopViewController: UIViewController {
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 2
        view.font = .systemFont(ofSize: 18, weight: .semibold)
        view.textColor = .label
        view.text = "A Cup of Coffee"
        return view
    }()

    lazy var subtitleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 3
        view.font = .systemFont(ofSize: 16, weight: .regular)
        view.textColor = .systemGray
        view.text = "Photo by tabitha turner on Unsplash"
        return view
    }()

    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "cup")
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 6
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray.cgColor
        view.clipsToBounds = true
        return view
    }()

    lazy var container: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 6
        return view
    }()

    lazy var labelStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            titleLabel,
            subtitleLabel,
        ])

        view.spacing = 4
        view.axis = .vertical

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
        addViews()
        setConstraints()

        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(setImage))
        container.addGestureRecognizer(tapRecognizer)
    }

    private func addViews() {
        view.addSubview(paticleView)
        view.addSubview(container)

        [imageView, labelStack].forEach {
            container.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(setImage))
        container.addGestureRecognizer(tapRecognizer)

        [paticleView, container].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            imageView.topAnchor.constraint(equalTo: container.topAnchor, constant: 10),
            imageView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10),
            imageView.widthAnchor.constraint(equalToConstant: 80),
            imageView.heightAnchor.constraint(equalToConstant: 80),

            labelStack.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            labelStack.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10),
            labelStack.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            labelStack.widthAnchor.constraint(equalToConstant: 160),
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
        let scene = DetailedPopScene()
        scene.emitter?.particleTexture = texture
        paticleView.presentScene(scene)

        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) { [weak self] in
            self?.isButtonAvailable = true
        }
    }
}

class DetailedPopScene: SKScene {
    let emitter: SKEmitterNode? = {
        let node = SKEmitterNode(fileNamed: "Magic")
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
