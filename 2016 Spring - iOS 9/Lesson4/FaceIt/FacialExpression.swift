//
//  FacialExpression.swift
//  FaceIt
//
//  Created by Apollonian on 6/12/16.
//  Copyright © 2016 WWITDC. All rights reserved.
//

import Foundation

struct FacialExpression{
    enum Eye: Int{
        case Open, Close, Squinting
    }
    enum EyeBrows: Int{
        case Relaxed, Normal, Forrowed
        func moreRelaxedBrow() -> EyeBrows{
            return EyeBrows(rawValue: rawValue - 1) ?? .Relaxed
        }
        func moreForrowedBrow() -> EyeBrows{
            return EyeBrows(rawValue: rawValue + 1) ?? .Forrowed
        }
    }
    enum Mouth: Int{
        case Frown, Smirk, Neutral, Grin, Smile
        func saderMouth() -> Mouth{
            return Mouth(rawValue: rawValue - 1) ?? .Frown
        }
        func happierMouth() -> Mouth{
            return Mouth(rawValue: rawValue + 1) ?? .Smile
        }
    }
    var eyes: Eye
    var eyeBrows: EyeBrows
    var mouth: Mouth
}