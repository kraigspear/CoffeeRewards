//
//  ViewController.swift
//  CoffeeRewards
//
//  Created by Kraig Spear on 8/30/16.
//  Copyright © 2016 Meijer. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak fileprivate var qrImageView: UIImageView!
    @IBOutlet weak fileprivate var nameLabel: UILabel!
    @IBOutlet weak fileprivate var dispensedLabel: UILabel!
    @IBOutlet weak fileprivate var untilNextReward: UILabel!
    //MARK: - Members
    private var viewModel: MainViewModel!

    //MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = MainViewModel(delegate: self)
        viewModel.name = "Kraig"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        viewModel.reload()
    }
    
    //MARK: - Actions
    
    @IBAction func tabAction(_ sender: AnyObject) {
        viewModel.coffeeDispensed{}
    }
}

extension MainViewController: MainViewModelDelegate {
    func onPropertyChanged(property: MainViewModelProperty) {
        switch property {
        case .qrCode(image: let image):
            qrImageView.image = image
        case .welcomeText(welcomeText: let welcomeText):
            nameLabel.text = welcomeText
        case .dispensed(dispensed: let dispensedText):
            dispensedLabel.text = dispensedText
        case .untilNextReward(untilNextReward: let nextReward):
            untilNextReward.text = nextReward
        default:
            break
        }
    }
    
    func qrImageSize() -> CGSize {
        return self.qrImageView.frame.size
    }
}

