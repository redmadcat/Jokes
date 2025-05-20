//
//  ViewController.swift
//  Jokes
//
//  Created by Roman Yaschenkov on 18.04.2025.
//

import UIKit

final class ViewController: UIViewController {
    // MARK: - @IBOutlet
    @IBOutlet private weak var jokeIdLabel: UILabel!
    @IBOutlet private weak var jokeValueLabel: UILabel!
    @IBOutlet private weak var jokeTypeLabel: UILabel!
    @IBOutlet private weak var jokeTypeNameLabel: UILabel!
    
    @IBOutlet private weak var setupLabel: UILabel!
    @IBOutlet private weak var jokeBodyLabel: UILabel!
    
    @IBOutlet private weak var refreshButton: UIButton!
    @IBOutlet private weak var showPunchlineButton: UIButton!
        
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        jokeIdLabel.font = .robotoMedium16
        jokeValueLabel.font = .robotoMedium16
        jokeTypeLabel.font = .robotoMedium16
        jokeTypeNameLabel.font = .robotoMedium16
        setupLabel.font = .robotoMedium16
        showPunchlineButton.titleLabel?.font = .robotoMedium16
        jokeBodyLabel.font = .robotoMedium24
    }
    
    // MARK: - @IBAction
    @IBAction private func showPunchline(_ sender: Any) {
        let alert = UIAlertController(
            title: "Punchline",
            message: "For fowl play",
            preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ok", style: .default)
        
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct ViewControllerPreview: PreviewProvider {
    static var devices = ["iPnone SE", "iPhone 11 Pro Max"]
    
    static var previews: some View {
        ForEach(devices, id: \.self) { deviceName in
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ViewController").toPreview()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
#endif

