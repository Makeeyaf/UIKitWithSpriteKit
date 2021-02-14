//
//  ViewController.swift
//  UIKitWithSpriteKit
//
//  Created by Makeeyaf on 2021/01/24.
//

import UIKit
import SpriteKit

class SnowViewController: UIViewController {

    // MARK: Views

    lazy var snowView: SKView = {
        let view = SKView()
        view.backgroundColor = .clear
        let scene = SnowScene()
        view.presentScene(scene)
        return view
    }()

    lazy var photo: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "photo")
        view.clipsToBounds = true
        view.layer.cornerRadius = 6
        view.contentMode = .scaleAspectFill
        return view
    }()

    lazy var credit: UILabel = {
        let view = UILabel()
        view.attributedText = {
            let normal: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 16, weight: .regular),
                .foregroundColor: UIColor.label,
            ]
            let underline: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 16, weight: .regular),
                .underlineStyle: NSUnderlineStyle.single.rawValue,
                .foregroundColor: UIColor.systemGray,
            ]

            var text = NSMutableAttributedString()
            [
                NSAttributedString(string: "Photo by ", attributes: normal),
                NSAttributedString(string: "Santiago Gomez", attributes: underline),
                NSAttributedString(string: " on ", attributes: normal),
                NSAttributedString(string: "Unsplash", attributes: underline),
            ].forEach {
                text.append($0)
            }

            return text
        }()
        return view
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        overrideUserInterfaceStyle = .dark
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        [photo, credit, snowView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        setConstraints()
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            photo.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            photo.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            photo.topAnchor.constraint(equalTo: view.topAnchor),
            photo.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])

        NSLayoutConstraint.activate([
            credit.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            credit.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])

        NSLayoutConstraint.activate([
            snowView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            snowView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            snowView.topAnchor.constraint(equalTo: view.topAnchor),
            snowView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

