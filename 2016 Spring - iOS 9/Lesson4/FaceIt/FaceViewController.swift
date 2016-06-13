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

    var expression = FacialExpression(eyes: .Open, eyeBrows: .Forrowed, mouth: .Smile){didSet{UpdateUI()}}


    private let mouthCurvatures: [FacialExpression.Mouth:CGFloat] = [.Frown:-1, .Grin:0.5, .Smile:1,.Smirk:-0.5,.Neutral:0]
    private let eyeBrowTilts: [FacialExpression.EyeBrows:CGFloat] = [.Relaxed:0.5, .Forrowed: -0.5, .Normal:0]
    private func UpdateUI(){
        if expression.eyes == .Open{
            faceView.eyesOpen = true
        } else {
            faceView.eyesOpen = false
        }
        faceView.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0
        faceView.eyeBrowTilt = eyeBrowTilts[expression.eyeBrows] ?? 0
    }
}

