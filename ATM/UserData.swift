//
//  UserData.swift
//  ATM
//
//  Created by User on 24.01.2021.
//

protocol UserData {
    var userName: String {get}
    var userCardId: String {get}
    var userCardPin: Int {get}
    var userCash: Float {get set}
    var userBankDeposit: Float {get set}
    var userPhone: String {get}
    var userPhoneBalance: Float {get set}
}
