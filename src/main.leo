// SIMPLE ATM TRANSACTIONS

program devrelambas1989.aleo {

// Defines ATM transactions
// Record Keep track of money.
record Money {
    owner: address, // Who owns it
    amount: u64,   //  How much it is. 
}

// create money out of thin air (like the central bank)
transition create(owner: address, amount: u64) -> Money {
    assert_eq(self.caller, aleo1rhgdu77hgyqd3xjj8ucu3jj9r2krwz6mnzyd80gncr5fxcwlh5rsvzp9px);
    return Money {
        owner: owner,
        amount: amount,
    };
}

// Handles deposit transactions.
async transition deposit(money: Money, amount: u64) -> (Money, Future) {
    // - `money` : Record that you want to deposit money to.
    // - `amount`: Amount to be deposited.
    // Checks if the caller is the owner of the account.
    assert_eq(self.caller, money.owner);
    let difference: u64 = money.amount - amount;

    let remaining: Money = Money {
        owner: money.owner,
        amount: difference,
    };

    // Generates a hash for the account owner.
    let hash: field = BHP256::hash_to_field(money.owner);
    return (remaining, commit_deposit(hash, amount));
}

// To Store the balances on-chain.
mapping balance: field => u64;

    // Commits the deposit amount to the on-chain state.
    // - `hash`  : Owner's account hash.
    // - `amount`: Deposit amount.
    async function commit_deposit(hash: field, amount: u64) {
        let current_amount: u64 = Mapping::get_or_use(balance, hash, 0u64);
        Mapping::set(balance, hash, current_amount + amount);
    }
    
    // Processes withdrawal transactions.
    // - `recipient`: Account address for withdrawal.
    // - `amount`   : Withdrawal amount.
    async transition withdraw(recipient: address, amount: u64) -> (Money, Future) {
        assert_eq(self.caller, aleo1rhgdu77hgyqd3xjj8ucu3jj9r2krwz6mnzyd80gncr5fxcwlh5rsvzp9px);
        let hash: field = BHP256::hash_to_field(recipient);
        let token: Money = Money { owner: recipient, amount: amount};
        return (token, commit_withdraw(hash, amount));
    }

    // Updates the on-chain state for withdrawals.
    // - `hash`  : Account owner's hash.
    // - `amount`: Withdrawal amount.
    async function commit_withdraw(hash: field, amount: u64) {
        let current_amount: u64 = Mapping::get_or_use(balance, hash, 0u64);
        Mapping::set(balance, hash, current_amount - amount);
    }
}