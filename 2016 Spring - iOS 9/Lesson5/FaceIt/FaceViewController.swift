//
//  FaceViewController.swift
//  FaceIt
//
//  Created by Apollonian on 6/12/16.
//  Copyright © 2016 WWITDC. All rights reserved.
//

import UIKit

class FaceViewController: UIViewController {

    @IBOutlet weak var faceView: FaceView!{didSet{
        update()
        faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: #selector(FaceView.changeScale(_:))))
        let happierFaceExpression = UISwipeGestureRecognizer(target: self, action: #selector(FaceViewController.increaseHappiness))
        happierFaceExpression.direction = .Up
        faceView.addGestureRecognizer(happierFaceExpression)
        let sadderFaceExpression = UISwipeGestureRecognizer(target: self, action: #selector(FaceViewController.decreaseHappiness))
        sadderFaceExpression.direction = .Down
        faceView.addGestureRecognizer(sadderFaceExpression)
        faceView.addGestureRecognizer(UIRotationGestureRecognizer(target: self, action: #selector(FaceViewController.changeEyeBrow(_:))))
        }}
    func increaseHappiness(){
        expression.mouth = expression.mouth.happierMouth()
    }
    func decreaseHappiness(){
        expression.mouth = expression.mouth.sadderMouth()
        ()
    }
    @IBAction func toggleEyes(recognizer: UITapGestureRecognizer) {
        if recognizer.state == .Ended{
            switch expression.eyes {
            case .Open:
                expression.eyes = .Close
            case .Close:
                expression.eyes = .Open
            case .Squinting:
                break
            }
        }
    }
    func changeEyeBrow(recognizer: UIRotationGestureRecognizer){
        if recognizer.state == .Ended{
            if recognizer.rotation > 0{
                expression.eyeBrows = expression.eyeBrows.moreRelaxedBrow()
            } else {
                expression.eyeBrows = expression.eyeBrows.moreSorrowedBrow()
            }
            recognizer.rotation = 0
        }
    }
    var expression = FacialExpression(eyes: .Open, eyeBrows: .Sorrowed, mouth: .Smile){didSet{update()}}
    private let mouthCurvatures : [FacialExpression.Mouth:CGFloat] = [.Frown: -1, .Smirk: -0.5, .Neutral:0, .Grin:0.5, .Smile:1]
    private let eyeBrowTilts : [FacialExpression.EyeBrows:CGFloat] = [.Relaxed: 0.5, .Normal: 0, .Sorrowed: -0.5]

    func update(){
        faceView.eyesOpen = expression.eyes == .Open
        faceView.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0
        faceView.eyeBowTilt = eyeBrowTilts[expression.eyeBrows] ?? 0
    }
    
    
}

