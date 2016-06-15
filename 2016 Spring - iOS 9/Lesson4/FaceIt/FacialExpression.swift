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
        case open, close, squinting
    }
    enum EyeBrows: Int{
        case relaxed, normal, forrowed
        func moreRelaxedBrow() -> EyeBrows{
            return EyeBrows(rawValue: rawValue - 1) ?? .relaxed
        }
        func moreForrowedBrow() -> EyeBrows{
            return EyeBrows(rawValue: rawValue + 1) ?? .forrowed
        }
    }
    enum Mouth: Int{
        case frown, smirk, neutral, grin, smile
        func saderMouth() -> Mouth{
            return Mouth(rawValue: rawValue - 1) ?? .frown
        }
        func happierMouth() -> Mouth{
            return Mouth(rawValue: rawValue + 1) ?? .smile
        }
    }
    var eyes: Eye
    var eyeBrows: EyeBrows
    var mouth: Mouth
}
