 //
//  TabBarController.swift
//
//  OutRun
//  Copyright (C) 2020 Tim Fraedrich <timfraedrich@icloud.com>
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.
//

import UIKit
import SwiftUI

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    static var lastCurrent: TabBarController?
    
    private let placeholder = PlaceholderController()
    private let addButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        TabBarController.lastCurrent = self
        
        self.tabBar.barTintColor = .backgroundColor
        self.tabBar.isTranslucent = false
        
        let listController = WorkoutListViewController()
        let timeline = NavigationController(rootViewController: listController)
        timeline.tabBarItem = UITabBarItem(
            title: LS["TabBar.Timeline"],
            image: .tabbarTimeline,
            selectedImage: .tabbarTimelineFilled
        )
        
        // Create a reference to the the appropriate storyboard
        let storyboard = UIStoryboard(name: "InsuranceStoryboard", bundle: nil)

        // Instantiate the desired view controller from the storyboard using the view controllers identifier
        // Cast is as the custom view controller type you created in order to access it's properties and methods
        let insuranceController = storyboard.instantiateViewController(withIdentifier: "someID")
        
//        let insuranceController = InsuranceViewOldController()
        let insurance = NavigationController(rootViewController: insuranceController)
        insurance.tabBarItem = UITabBarItem(
            title: "Insurance",
            image: .tabbarInsurance,
            selectedImage: .tabbarInsuranceFilled
        )

        //let walletController = WalletVC()
        //1. import swiftUI and add these lines to render the SwiftUI view directly from here
        let swiftUIViewController = UIHostingController(rootView: WalletView(onSwapView: false))
        self.navigationController?.pushViewController(swiftUIViewController, animated: true)

        let wallet = NavigationController(rootViewController: swiftUIViewController)
        wallet.tabBarItem = UITabBarItem(
            //title: LS["TabBar.Timeline"],
            title: "Wallet",
            image: UIImage(systemName: "bitcoinsign.circle"),
            //selectedImage: .tabbarTimelineFilled
            selectedImage: UIImage(systemName: "bitcoinsign.circle.filled")
        )

        let settingsController = SettingsViewController()
        settingsController.settingsModelClosure = {
            return SettingsModel.main
        }
        let settings = NavigationController(rootViewController: settingsController)
        let settingsTabBarItem = UITabBarItem(
            title: LS["TabBar.Settings"],
            image: .tabbarSettings,
            selectedImage: .tabbarSettingsFilled
        )
        settings.tabBarItem = settingsTabBarItem
        
        self.viewControllers = [timeline, wallet, placeholder, insurance, settings]
        
        addButton.layer.cornerRadius = 29
        addButton.backgroundColor = .accentColor
        addButton.layer.borderColor = UIColor.backgroundColor.withAlphaComponent(0.2).cgColor
        addButton.layer.borderWidth = 4
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(displayNewWorkoutAlert))
        addButton.addGestureRecognizer(longPressGesture)
        
        addButton.addTarget(self, action: #selector(showNewWorkoutController), for: .touchUpInside)
        
        self.tabBar.addSubview(addButton)
        
        var bottomOffset: CGFloat = 5.0
                
        if let window = UIApplication.shared.keyWindow {
            bottomOffset += window.safeAreaInsets.bottom
        }
        
        addButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-bottomOffset)
            make.width.height.equalTo(58)
        }
        let plusIcon = UIImageView(image: .tabbarPlus)
        plusIcon.tintColor = .white
        addButton.addSubview(plusIcon)
        plusIcon.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalTo(20)
        }
        
        let bgrdView = UIView()
        bgrdView.backgroundColor = .backgroundColor
        self.tabBar.insertSubview(bgrdView, at: 0)
        bgrdView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: -1, left: 0, bottom: 0, right: 0))
        }
        
        self.addDebugGestureRecognizer()
    }
    
    deinit {
        if TabBarController.lastCurrent == self {
            TabBarController.lastCurrent = nil
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController is PlaceholderController {
            return false
        }
        if let selectionObserver = viewController.findFirstNonTabOrNavigationController() as? TabBarSelectionObserver {
            selectionObserver.willGetSelected()
        }
        if let currentSelectionObserver = tabBarController.selectedViewController?.findFirstNonTabOrNavigationController() as? TabBarSelectionObserver, currentSelectionObserver != viewController {
            currentSelectionObserver.willGetDeselected(newController: viewController)
        }
        return true
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if #available(iOS 13.0, *) {
            if previousTraitCollection?.hasDifferentColorAppearance(comparedTo: traitCollection) ?? false {
                self.addButton.layer.borderColor = UIColor.foregroundColor.withAlphaComponent(0.2).cgColor
            }
        }
    }
    
    @objc private func displayNewWorkoutAlert(sender: UILongPressGestureRecognizer) {
        print("Long press detected")
        if sender.state == .began {
            let alert = WorkoutTypeAlert(
                action: { (type) in
                    let controller = NewWorkoutViewController()
                    controller.type = type
                    self.showDetailViewController(controller, sender: self)
                },
                manualAction: {
                    let controller = EditWorkoutController()
                    self.showDetailViewController(NavigationController(rootViewController: controller), sender: self)
                }
            )
            alert.present(on: self)
        }
    }
    @objc private func showNewWorkoutController() { //showNewWorkotuController is a button??
        print("New Workout Button Pressed")
        let controller = NewWorkoutViewController()
//        let controller = AayushViewController()
        self.showDetailViewController(controller, sender: self) //what does this do???
    }
    
    func addDebugGestureRecognizer() {
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(recognizeDebugGesture(recognizer:)))
        recognizer.numberOfTapsRequired = 10
        recognizer.delaysTouchesBegan = false
        recognizer.delaysTouchesEnded = false
        
        self.tabBar.addGestureRecognizer(recognizer)
        
    }
    
    @objc func recognizeDebugGesture(recognizer: UITapGestureRecognizer) {
        if self.selectedIndex == 2 {
            self.showDetailViewController(NavigationController(rootViewController: DebugController()), sender: self)
        }
    }
    
}
