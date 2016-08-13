//
//  FaceViewController.swift
//  FaceIt
//
//  Created by Apollonian on 6/12/16.
//  Copyright © 2016 WWITDC. All rights reserved.
//

import UIKit

class FaceViewController: UIViewController {

    @IBOutlet weak var faceView: FaceView!{
        didSet{
            update()
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: #selector(FaceView.changeScale(_:))))
            let happierFaceExpression = UISwipeGestureRecognizer(target: self, action: #selector(FaceViewController.increaseHappiness))
            happierFaceExpression.direction = .up
            faceView.addGestureRecognizer(happierFaceExpression)
            let sadderFaceExpression = UISwipeGestureRecognizer(target: self, action: #selector(FaceViewController.decreaseHappiness))
            sadderFaceExpression.direction = .down
            faceView.addGestureRecognizer(sadderFaceExpression)
            faceView.addGestureRecognizer(UIRotationGestureRecognizer(target: self, action: #selector(FaceViewController.changeEyeBrow(_:))))
        }
    }

    func increaseHappiness(){
        expression.mouth = expression.mouth.happier()
    }

    func decreaseHappiness(){
        expression.mouth = expression.mouth.sadder()
    }

    @IBAction func toggleEyes(_ recognizer: UITapGestureRecognizer) {
        if recognizer.state == .ended{
            switch expression.eyes {
            case .open:
                expression.eyes = .closed
            case .closed:
                expression.eyes = .open
            case .squinting:
                break
            }
        }
    }
    func changeEyeBrow(_ recognizer: UIRotationGestureRecognizer){
        if recognizer.state == .ended{
            if recognizer.rotation > 0{
                expression.eyeBrows = expression.eyeBrows.moreRelaxed()
            } else {
                expression.eyeBrows = expression.eyeBrows.moreSorrowed()
            }
            recognizer.rotation = 0
        }
    }
    var expression = FacialExpression(eyes: .open, eyeBrows: .sorrowed, mouth: .smile){didSet{update()}}
    private let mouthCurvatures : [FacialExpression.Mouth:CGFloat] = [.frown: -1, .smirk: -0.5, .neutral:0, .grin:0.5, .smile:1]
    private let eyeBrowTilts : [FacialExpression.EyeBrows:CGFloat] = [.relaxed: 0.5, .normal: 0, .sorrowed: -0.5]

    func update(){
        guard faceView != nil else {return}
        faceView.eyesOpen = expression.eyes == .open
        faceView.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0
        faceView.eyeBowTilt = eyeBrowTilts[expression.eyeBrows] ?? 0
    }
    
    
}

