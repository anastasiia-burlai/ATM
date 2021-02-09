//
//  NothernBank.swift
//  ATM
//
//  Created by User on 07.02.2021.
//

class NothernBank: BankApi {
    var user: UserData
    
    init(user: UserData) {
        self.user = user
    }
    
    func showUserBalance() {
        print("Deposit balance: \(user.userBankDeposit)")
    }
    
    func showUserToppedUpMobilePhoneCash(cash: Float) {
        print("New phone balance (\(user.userPhone)): \(user.userPhoneBalance)")
        print("New cash balance: \(user.userCash)")
    }
    
    func showUserToppedUpMobilePhoneDeposite(deposit: Float) {
        print("New phone balance (\(user.userPhone)): \(user.userPhoneBalance)")
        print("New deposit balance: \(user.userBankDeposit)")
    }
    
    func showWithdrawalDeposit(cash: Float) {
        print("New cash balance: \(user.userCash)")
        print("New deposit balance: \(user.userBankDeposit)")
    }
    
    func showTopUpAccount(cash: Float) {
        print("New deposit balance: \(user.userBankDeposit)")
        print("New cash balance: \(user.userCash)")
    }
    
    func showError(error: TextErrors) {
        print(error.rawValue)
    }
    
    func checkUserPhone(phone: String) -> Bool {
        return phone == user.userPhone
    }
    
    func checkMaxUserCash(cash: Float) -> Bool {
        return cash <= user.userCash
    }
    
    func checkMaxAccountDeposit(withdraw: Float) -> Bool {
        return withdraw <= user.userBankDeposit
    }
    
    func checkCurrentUser(userCardId: String, userCardPin: Int) -> Bool {
        return userCardId == user.userCardId && userCardPin == user.userCardPin
    }
    
    func topUpPhoneBalanceCash(pay: Float) {
        if pay <= 0 {
            showError(error: .negativeAmount)
            return
        }
        if (checkMaxUserCash(cash: pay)) {
            user.userCash -= pay
            user.userPhoneBalance += pay
            showUserToppedUpMobilePhoneCash(cash: pay)
        } else {
            showError(error: .insufficientSumInCash)
        }
    }
    
    func topUpPhoneBalanceDeposit(pay: Float) {
        if pay <= 0 {
            showError(error: .negativeAmount)
            return
        }
        if (checkMaxAccountDeposit(withdraw: pay)) {
            user.userBankDeposit -= pay
            user.userPhoneBalance += pay
            showUserToppedUpMobilePhoneDeposite(deposit: pay)
        } else {
            showError(error: .insufficientSumOnDeposit)
        }
    }
    
    func getCashFromDeposit(cash: Float) {
        if cash <= 0 {
            showError(error: .negativeAmount)
            return
        }
        if (checkMaxAccountDeposit(withdraw: cash)) {
            user.userBankDeposit -= cash
            user.userCash += cash
            showWithdrawalDeposit(cash: cash)
        } else {
            showError(error: .insufficientSumOnDeposit)
        }
    }
    
    func putCashDeposit(topUp: Float) {
        if topUp <= 0 {
            showError(error: .negativeAmount)
            return
        }
        if (checkMaxUserCash(cash: topUp)) {
            user.userCash -= topUp
            user.userBankDeposit += topUp
            showTopUpAccount(cash: topUp)
        } else {
            showError(error: .insufficientSumInCash)
        }
    }
}
