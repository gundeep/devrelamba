program devrelambas1989.aleo;

record Money:
    owner as address.private;
    amount as u64.private;


mapping balance:
	key as field.public;
	value as u64.public;

function create:
    input r0 as address.private;
    input r1 as u64.private;
    assert.eq self.caller aleo1rhgdu77hgyqd3xjj8ucu3jj9r2krwz6mnzyd80gncr5fxcwlh5rsvzp9px;
    cast r0 r1 into r2 as Money.record;
    output r2 as Money.record;



function deposit:
    input r0 as Money.record;
    input r1 as u64.private;
    assert.eq self.caller r0.owner;
    sub r0.amount r1 into r2;
    cast r0.owner r2 into r3 as Money.record;
    hash.bhp256 r0.owner into r4 as field;
    async deposit r4 r1 into r5;
    output r3 as Money.record;
    output r5 as devrelambas1989.aleo/deposit.future;

finalize deposit:
    input r0 as field.public;
    input r1 as u64.public;
    get.or_use balance[r0] 0u64 into r2;
    add r2 r1 into r3;
    set r3 into balance[r0];




function withdraw:
    input r0 as address.private;
    input r1 as u64.private;
    assert.eq self.caller aleo1rhgdu77hgyqd3xjj8ucu3jj9r2krwz6mnzyd80gncr5fxcwlh5rsvzp9px;
    hash.bhp256 r0 into r2 as field;
    cast r0 r1 into r3 as Money.record;
    async withdraw r2 r1 into r4;
    output r3 as Money.record;
    output r4 as devrelambas1989.aleo/withdraw.future;

finalize withdraw:
    input r0 as field.public;
    input r1 as u64.public;
    get.or_use balance[r0] 0u64 into r2;
    sub r2 r1 into r3;
    set r3 into balance[r0];

