//
//  ViewController.swift
//  UIKitWithSpriteKit
//
//  Created by Makeeyaf on 2021/02/14.
//

import UIKit

class ViewController: UIViewController {

    lazy var snowButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Snow", for: .normal)
        view.addTarget(self, action: #selector(mainToSnowView), for: .touchUpInside)
        return view
    }()

    lazy var popButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Pop", for: .normal)
        view.addTarget(self, action: #selector(mainToPopView), for: .touchUpInside)
        return view
    }()

    lazy var buttonStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [snowButton, popButton])
        view.axis = .vertical
        view.spacing = 15
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(buttonStack)
        buttonStack.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            buttonStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

    // MARK: Actions

    @objc private func mainToSnowView() {
        let vc = SnowViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc private func mainToPopView() {
        let vc = PopViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
