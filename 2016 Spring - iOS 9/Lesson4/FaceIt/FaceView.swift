//
//  FaceView.swift
//  FaceIt

//
//  Created by Apollonian on 6/12/16.
//  Copyright © 2016 WWITDC. All rights reserved.
//

import UIKit

@IBDesignable class FaceView: UIView {
    @IBInspectable var scale : CGFloat = 0.9 {didSet{setNeedsDisplay()}}

    ///  1 -> Full smile; -1 -> Full frown
    @IBInspectable var mouthCurvature: CGFloat = 0 {didSet{setNeedsDisplay()}}

    @IBInspectable var eyesOpen = true {didSet{setNeedsDisplay()}}
    ///  1 -> Full relaxed; -1 -> Full forrowed
    @IBInspectable var eyeBrowTilt: CGFloat = 0 {didSet{setNeedsDisplay()}}
    @IBInspectable var lineWidth : CGFloat = 5 {didSet{setNeedsDisplay()}}
    @IBInspectable var color: UIColor = .blueColor() {didSet{setNeedsDisplay()}}


    private var skullRadius : CGFloat {
        return min(bounds.width, bounds.height) / 2 * scale
    }
    //let skullCenter = convertPoint(center, toView: superview)
    private var skullCenter : CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }

    private struct Ratios {
        static let SkullRadiusToEyeOffset: CGFloat = 3
        static let SkullRadiusToEyeRadius: CGFloat = 10
        static let SkullRadiusToMouthWidth: CGFloat = 1
        static let SkullRadiusToMouthHeight: CGFloat = 3
        static let SkullRadiusToMouthOffset: CGFloat = 3
        static let SkullRadiusToBrowsOffset: CGFloat = 5
    }

    private enum Eye{
        case Left, Right
    }

    private func pathForCircleCenteredAtPoint(midPoint: CGPoint, withRadius radius: CGFloat) -> UIBezierPath{
        let path =  UIBezierPath(arcCenter: midPoint, radius: radius, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: true)
        path.lineWidth = lineWidth
        return path
    }

    private func getEyeCenter(eye: Eye) -> CGPoint{
        let eyeOffset = skullRadius / Ratios.SkullRadiusToEyeOffset
        var eyeCenter = skullCenter
        eyeCenter.y -= eyeOffset
        switch eye {
        case .Left: eyeCenter.x -= eyeOffset
        case .Right: eyeCenter.x += eyeOffset
        }
        return eyeCenter
    }

    private func pathForEye(eye: Eye) -> UIBezierPath{
        let eyeRadius = skullRadius / Ratios.SkullRadiusToEyeRadius
        let eyeCenter = getEyeCenter(eye)
        if eyesOpen{
            return pathForCircleCenteredAtPoint(eyeCenter, withRadius: eyeRadius)
        } else {
            let path = UIBezierPath()
            path.moveToPoint(CGPointMake(eyeCenter.x - eyeRadius, eyeCenter.y))
            path.addLineToPoint(CGPointMake(eyeCenter.x + eyeRadius, eyeCenter.y))
            path.lineWidth = lineWidth
            return path
        }
    }

    private func pathForMouth() -> UIBezierPath{
        let mouthWidth = skullRadius / Ratios.SkullRadiusToMouthWidth
        let mouthHeight = skullRadius / Ratios.SkullRadiusToMouthHeight
        let mouthOffset = skullRadius / Ratios.SkullRadiusToMouthOffset
        let mouthRect = CGRect(x: skullCenter.x - mouthWidth / 2, y: skullCenter.y + mouthOffset, width: mouthWidth, height: mouthHeight)
        let smileOffset = CGFloat(max(-1, min(mouthCurvature, 1)))*mouthRect.height
        let start = CGPoint(x: mouthRect.minX, y: mouthRect.minY)
        let end = CGPoint(x: mouthRect.maxX, y: mouthRect.minY)
        let cp1 = CGPoint(x: mouthRect.minX + mouthRect.width / 3, y: mouthRect.minY + smileOffset)
        let cp2 = CGPoint(x: mouthRect.maxX - mouthRect.width / 3, y: mouthRect.minY + smileOffset)
        let path = UIBezierPath()
        path.moveToPoint(start)
        path.addCurveToPoint(end, controlPoint1: cp1, controlPoint2: cp2)
        path.lineWidth = lineWidth
        return path
    }

    private func pathForEyeBrows(eye: Eye) -> UIBezierPath{
        var tilt = eyeBrowTilt
        if eye == .Left{
            tilt *= -1
        }
        var browCenter = getEyeCenter(eye)
        browCenter.y -= skullRadius / Ratios.SkullRadiusToBrowsOffset
        let eyeRadius = skullRadius / Ratios.SkullRadiusToEyeRadius
        let tiltOffset = CGFloat(max(-1, min(tilt, 1))) * eyeRadius / 2
        let browStart = CGPointMake(browCenter.x - eyeRadius, browCenter.y - tiltOffset)
        let browEnd = CGPointMake(browCenter.x + eyeRadius, browCenter.y + tiltOffset)
        let path = UIBezierPath()
        path.moveToPoint(browStart)
        path.addLineToPoint(browEnd)
        path.lineWidth = lineWidth
        return path
    }

    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        color.setStroke()
        pathForCircleCenteredAtPoint(skullCenter, withRadius: skullRadius).stroke()
        pathForEye(.Left).stroke()
        pathForEye(.Right).stroke()
        pathForMouth().stroke()
        pathForEyeBrows(.Left).stroke()
        pathForEyeBrows(.Right).stroke()
    }

}
