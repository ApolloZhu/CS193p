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
        case open, closed, squinting
    }
    enum EyeBrows: Int{
        case relaxed, normal, sorrowed
        func moreRelaxed() -> EyeBrows{
            return EyeBrows(rawValue: rawValue - 1) ?? .relaxed
        }
        func moreSorrowed() -> EyeBrows{
            return EyeBrows(rawValue: rawValue + 1) ?? .sorrowed
        }
    }
    enum Mouth: Int{
        case frown, smirk, neutral, grin, smile
        func sadder() -> Mouth{
            return Mouth(rawValue: rawValue - 1) ?? .frown
        }
        func happier() -> Mouth{
            return Mouth(rawValue: rawValue + 1) ?? .smile
        }
    }
    var eyes: Eye
    var eyeBrows: EyeBrows
    var mouth: Mouth
}
