//
//  BankApi.swift
//  ATM
//
//  Created by User on 07.02.2021.
//

protocol BankApi {
    func showUserBalance()
    func showUserToppedUpMobilePhoneCash(cash: Float)
    func showUserToppedUpMobilePhoneDeposite(deposit: Float)
    func showWithdrawalDeposit(cash: Float)
    func showTopUpAccount(cash: Float)
    func showError(error: TextErrors)
    
    func checkUserPhone(phone: String) -> Bool
    func checkMaxUserCash(cash: Float) -> Bool
    func checkMaxAccountDeposit(withdraw: Float) -> Bool
    func checkCurrentUser(userCardId: String, userCardPin: Int) -> Bool
    
    func topUpPhoneBalanceCash(pay: Float)
    func topUpPhoneBalanceDeposit(pay: Float)
    func getCashFromDeposit(cash: Float)
    func putCashDeposit(topUp: Float)
}
