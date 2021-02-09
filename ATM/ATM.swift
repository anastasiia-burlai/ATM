//
//  ATM.swift
//  ATM
//
//  Created by User on 07.02.2021.
//

class ATM {
    private let userCardId: String
    private let userCardPin: Int
    private var someBank: BankApi
    private let action: UserActions
    private let paymentMethod: PaymentMethod?
    
    init(userCardId: String, userCardPin: Int, someBank: BankApi, action: UserActions, paymentMethod: PaymentMethod? = nil) {
        self.userCardId = userCardId
        self.userCardPin = userCardPin
        self.someBank = someBank
        self.action = action
        self.paymentMethod = paymentMethod
        
        sendUserDataToBank(userCardId: userCardId, userCardPin: userCardPin, actions: action, payment: paymentMethod )
    }
    
    
    public final func sendUserDataToBank(userCardId: String, userCardPin: Int, actions: UserActions, payment: PaymentMethod?) {
        if !someBank.checkCurrentUser(userCardId: userCardId, userCardPin: userCardPin) {
            someBank.showError(error: .incorrectCardIdOrPin)
            return
        }
        if case .userPressedTopUpPhoneBtn = actions, payment == nil {
            someBank.showError(error: .missingPaymentType)
            return
        }
        switch actions {
        case .userPressedGetCashFromDepositBtn(let amount):
            someBank.getCashFromDeposit(cash: amount)
        case .userPressedPutCashToDepositBtn(let amount):
            someBank.putCashDeposit(topUp: amount)
        case .userPressedTopUpPhoneBtn(let amount):
            switch payment {
            case .cash:
                someBank.topUpPhoneBalanceCash(pay: amount)
            default:
                someBank.topUpPhoneBalanceDeposit(pay: amount)
            }
        default:
            someBank.showUserBalance()
        }
    }
}
