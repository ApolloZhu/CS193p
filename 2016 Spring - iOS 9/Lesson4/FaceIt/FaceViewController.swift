//
//  FaceViewController.swift
//  FaceIt
//
//  Created by Apollonian on 6/12/16.
//  Copyright © 2016 WWITDC. All rights reserved.
//

import UIKit

class FaceViewController: UIViewController {

    @IBOutlet weak var faceView: FaceView!{didSet{UpdateUI()}}

    var expression = FacialExpression(eyes: .open, eyeBrows: .forrowed, mouth: .smile){didSet{UpdateUI()}}


    private let mouthCurvatures: [FacialExpression.Mouth:CGFloat] = [.frown:-1, .grin:0.5, .smile:1,.smirk:-0.5,.neutral:0]
    private let eyeBrowTilts: [FacialExpression.EyeBrows:CGFloat] = [.relaxed:0.5, .forrowed: -0.5, .normal:0]
    private func UpdateUI(){
        if expression.eyes == .open{
            faceView.eyesOpen = true
        } else {
            faceView.eyesOpen = false
        }
        faceView.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0
        faceView.eyeBrowTilt = eyeBrowTilts[expression.eyeBrows] ?? 0
    }
}

