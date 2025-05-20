//
//  ViewController.swift
//  Jokes
//
//  Created by Roman Yaschenkov on 18.04.2025.
//

import UIKit

final class ViewController: UIViewController, JokesFactoryDelegate {
    // MARK: - @IBOutlet
    @IBOutlet private weak var jokeIdTitleLabel: UILabel!
    @IBOutlet private weak var jokeIdValueLabel: UILabel!
    @IBOutlet private weak var jokeTypeTitleLabel: UILabel!
    @IBOutlet private weak var jokeTypeValueLabel: UILabel!
    @IBOutlet private weak var jokeSetupTitleLabel: UILabel!
    @IBOutlet private weak var jokeSetupValueLabel: UILabel!
    @IBOutlet private weak var refreshButton: UIButton!
    @IBOutlet private weak var showPunchlineButton: UIButton!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Definition
    private var jokesFactory: JokesFactoryProtocol?
    private var currentJoke: Joke?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureServices()
    }
    
    private func configureUI() {
        jokeIdTitleLabel.font = .robotoMedium16
        jokeIdValueLabel.font = .robotoMedium16
        jokeTypeTitleLabel.font = .robotoMedium16
        jokeTypeValueLabel.font = .robotoMedium16
        jokeSetupTitleLabel.font = .robotoMedium16
        showPunchlineButton.titleLabel?.font = .robotoMedium16
        jokeSetupValueLabel.font = .robotoMedium24
    }
    
    private func configureServices() {
        showActivityIndicator(true)
        
        jokesFactory = JokesFactory(jokesLoader: JokesLoader(), delegate: self)
        jokesFactory?.requestNextJoke()
    }
    
    private func showActivityIndicator(_ isAnimating: Bool) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            
            if (isAnimating) {
                self.activityIndicator.isHidden = false
                self.activityIndicator.startAnimating()
                self.refreshButton.isEnabled = false
                self.showPunchlineButton.isEnabled = false
            } else {
                self.activityIndicator.isHidden = true
                self.activityIndicator.stopAnimating()
                self.refreshButton.isEnabled = true
                self.showPunchlineButton.isEnabled = true
            }
        }
    }
        
    // MARK: - JokesFactoryDelegate
    func didReceiveNextJoke(joke: Joke?) {
        showActivityIndicator(false)
        guard let joke else { return }
        currentJoke = joke
        
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            
            self.jokeIdValueLabel.text = String(joke.id)
            self.jokeTypeValueLabel.text = joke.type
            self.jokeSetupValueLabel.text = joke.setup
        }
    }
        
    func didFailToLoadData(with error: Error) {
        showActivityIndicator(false)
    }
    
    // MARK: - @IBAction
    @IBAction private func showPunchline(_ sender: Any) {
        let alert = UIAlertController(
            title: "Punchline",
            message: currentJoke?.punchline,
            preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ok", style: .default)
        
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction private func refresh(_ sender: Any) {
        showActivityIndicator(true)
        jokesFactory?.requestNextJoke()
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

