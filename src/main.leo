// The 'devrelambas1989' program.

// ATM transactions

// The AccountHolder record datatype.
record accountHolder {
    owner: address,
    amount: u64,
}
// store the amount on chain;
mapping balances: field => u64;

// Deposit money to ATM.
    // Returns a new Token with the remaining amount of money.
    // - `token` : A record containing tokens to deposit.
    // - `amount`: The amount of tokens to deposit.
async transition deposit(token: Token, amount: u64) -> (Token, Future) {
    let difference: u64 = token.amount - amount;

    let remaining: Token = Token {
        owner: token.owner,
        amount: difference,
    };

    // Compute the hash of the token owner.
    let hash: field = BHP256::hash_to_field(token.owner);

    return (remaining, finalize_deposit(hash, amount));
}




let a: u16 = 475u16;
program devrelambas1989.aleo {
    transition main(public a: u32, b: u32) -> u32 {
        let c: u32 = a + b;
        return c;
    }
}
