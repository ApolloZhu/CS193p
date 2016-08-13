//
//  EmotionsViewController.swift
//  FaceIt
//
//  Created by Apollonian on 8/9/16.
//  Copyright © 2016 WWITDC. All rights reserved.
//

import UIKit

class EmotionsViewController: UIViewController {

    private let emotionalFaces: [String:FacialExpression] = [
        "angry":FacialExpression(eyes: .closed, eyeBrows: .sorrowed, mouth: .frown),
        "happy":FacialExpression(eyes: .open, eyeBrows: .normal, mouth: .smile),
        "worried":FacialExpression(eyes: .open, eyeBrows: .relaxed, mouth: .smirk),
        "mischievious":FacialExpression(eyes: .open, eyeBrows: .sorrowed, mouth: .grin)
    ]

    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        var destination = segue.destination
        if let navigationViewController = destination as? UINavigationController{
            destination = navigationViewController.visibleViewController ?? destination
        }
        if let faceViewController = destination as? FaceViewController{
            if let identifier = segue.identifier{
                if let expression = emotionalFaces[identifier]{
                    faceViewController.expression = expression
                    if let sendingButton = sender as? UIButton{
                        faceViewController.navigationItem.title = sendingButton.currentTitle
                    }
                }
            }
        }
    }

}
