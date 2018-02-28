//
//  ViewController.swift
//  InteractionMask
//
//  Created by Paige Sun on 2018-02-27.
//  Copyright © 2018 Paige Sun. All rights reserved.
//
//  Allow the island image to only respond to touches when the image has an alpha.

import UIKit

class ViewController: UIViewController {
    
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackground()
        setupLabel()
        setupTappableIsland()
    }

    // MARK: - The Important View
    
    func setupTappableIsland() {
        let islandImageView = TouchableMaskView()
        let islandImage = #imageLiteral(resourceName: "island")
        islandImageView.image = islandImage
        islandImageView.isUserInteractionEnabled = true

        view.addSubview(islandImageView)
        islandImageView.constrainAspectRatio(to: islandImage.size)
        islandImageView.constrainCenterY(to: view)
        islandImageView.constrainEdgesHorizontally(to: view)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(islandTapped))
        islandImageView.addGestureRecognizer(tapRecognizer)
    }
    
    @objc private func islandTapped() {
        label.text = (label.text ?? "") + "🏝"
    }
    
    // MARK: Unimportant Views
    
    func setupBackground() {
        let skyImageView = UIImageView()
        skyImageView.image = #imageLiteral(resourceName: "sky")
        view.addSubview(skyImageView)
        skyImageView.constrainEdges(to: view)
    }
    
    func setupLabel() {
        label.text = ""
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 30)
        view.addSubview(label)
        label.constrainCenterX(to: view)
        label.constrainEdgesHorizontally(to: view)
        label.constrainBottom(to: view, inset: 80)
    }
}
