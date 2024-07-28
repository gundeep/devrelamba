# devrelambas1989.aleo

This is a simple Aleo program to act as a ATM hightlighting the use of Aleo's asynchronous transactions and the use of the Aleo Record model.

## How to run

1. Clone the repository

```bash
git clone https://github.com/devrelambas1989/aleo-atm.git
```

2. Create some Money, using create function
leo run create aleo1s3ws5tra87fjycnjrwsjcrnw2qxr8jfqqdugnf0xzqqw29q9m5pqem2u4t 70u64

3. Deposit some money
leo run deposit "{
    owner: aleo1s3ws5tra87fjycnjrwsjcrnw2qxr8jfqqdugnf0xzqqw29q9m5pqem2u4t.private,
    amount: 100u64.private,
}" 10u64 

4. Withdraw money
leo run withdraw aleo1t0uer3jgtsgmx5tq6x6f9ecu8tr57rzzfnc2dgmcqldceal0ls9qf6st7a 5u64

Note: Choose approriate caller for creating money Depsosits and Withdrawals.