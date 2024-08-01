Return-Path: <bpf+bounces-36225-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B3E944BA9
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 14:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22794B21491
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 12:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C712619538D;
	Thu,  1 Aug 2024 12:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b="NjSl2lNH"
X-Original-To: bpf@vger.kernel.org
Received: from eggs.gnu.org (eggs.gnu.org [209.51.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5660114D443
	for <bpf@vger.kernel.org>; Thu,  1 Aug 2024 12:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.51.188.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722516484; cv=none; b=eJBLeMVw3ErDK/BvNxwo9BsDYqdoRxVwRjAcF89EN8PEvHwbUuv+t6MiBeGkFXZP1hrNtZNzBcMVqSXunTXERKWHpFYwZIFMwLsmI2AXq+H+6XVHTMC4HOdViPavwDXrX+6vKuaCQICqSRw4FC7zSw+oZuCd/780LMRZXjgwxT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722516484; c=relaxed/simple;
	bh=Z77NADmlUIvyX7sMFWC1uQQH9ZuuNAQwuvGbKhrXejM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dDk9/Hi3dgLfVDQUTHkJkVr1inFTR13iKoBsQ2Jmb2WXRr6ihw6seUWifu1+uXekO2qkRw2h5Wbl5gXfd4enoxSYLrqJsKqMJQHXKzQsHxo6tVjHAcwPCejQY2cqHbIiKrAoZdj3A0Sx5F8xmWDS3AO2kDlSHXsWqk1+0U5iIY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org; spf=pass smtp.mailfrom=gnu.org; dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b=NjSl2lNH; arc=none smtp.client-ip=209.51.188.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
	by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <jemarch@gnu.org>)
	id 1sZVDm-0005x0-VY; Thu, 01 Aug 2024 08:47:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
	s=fencepost-gnu-org; h=MIME-Version:Date:References:In-Reply-To:Subject:To:
	From; bh=cLtTI5aDpVkqi3h3wegi8eiUwEKQQHh2T2w0eEXQR+Y=; b=NjSl2lNHAdJFD1iounFr
	Sqr6TgFefzWUkxW7ihLNmd1N+tJOEJkMG1LX1QgsomiI4Wfi2SGicVQa+Tk+sL9XP6MXFed66bvV2
	quSS60GurxGq+y7AMS+toBO3sv8AiXgudlqKeGXZ3TjfK4siC1PZyRXPmRJ/jf5LGQ8m4MpaKK5at
	jnJ4rHwW6b3fYIGt71UC6SdfnhVG27nwnhElFRFa9JeNG4hdMZ+xDlHBdGr0o8FfebscwihtUEu92
	7+fZtnFdtUsVCmiQICQQ8VMH+8zOLLnFRnZAh/L+i6OlqwSf4xNX9CHkwCjWMzW+SxDH6rLnoPMOw
	LpgpdkdYDBdjSA==;
From: "Jose E. Marchesi" <jemarch@gnu.org>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,  Peilin Ye
 <yepeilin@google.com>,  bpf <bpf@vger.kernel.org>,  Josh Don
 <joshdon@google.com>,  Barret Rhoden <brho@google.com>,  Neel Natu
 <neelnatu@google.com>,  Benjamin Segall <bsegall@google.com>,  "Paul E.
 McKenney" <paulmck@kernel.org>,  Alexei Starovoitov <ast@kernel.org>,
  David Vernet <dvernet@meta.com>,  Dave Marchevsky
 <davemarchevsky@meta.com>
Subject: Re: Supporting New Memory Barrier Types in BPF
In-Reply-To: <24b57380-c829-4033-a7b1-06a4ed413a49@linux.dev> (Yonghong Song's
	message of "Mon, 29 Jul 2024 22:14:26 -0700")
References: <20240729183246.4110549-1-yepeilin@google.com>
	<CAADnVQJqGzH+iT9M8ajT62H9+kAw1RXAdB42G3pvcLKPVmy8tg@mail.gmail.com>
	<24b57380-c829-4033-a7b1-06a4ed413a49@linux.dev>
Date: Thu, 01 Aug 2024 14:47:49 +0200
Message-ID: <87h6c4h0ju.fsf@gnu.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


> On 7/29/24 6:28 PM, Alexei Starovoitov wrote:
>> On Mon, Jul 29, 2024 at 11:33=E2=80=AFAM Peilin Ye <yepeilin@google.com>=
 wrote:
>>> Hi list!
>>>
>>> As we are looking at running sched_ext-style BPF scheduling on architec=
tures
>>> with a more relaxed memory model (i.e. ARM), we would like to:
>>>
>>>    1. have fine-grained control over memory ordering in BPF (instead of
>>>       defaulting to a full barrier), for performance reasons
>>>    2. pay closer attention to if memory barriers are being used correct=
ly in
>>>       BPF
>>>
>>> To that end, our main goal here is to support more types of memory barr=
iers in
>>> BPF.  While Paul E. McKenney et al. are working on the formalized BPF m=
emory
>>> model [1], Paul agreed that it makes sense to support some basic types =
first.
>>> Additionally, we noticed an issue with the __sync_*fetch*() compiler bu=
ilt-ins
>>> related to memory ordering, which will be described in details below.
>>>
>>> I. We need more types of BPF memory barriers
>>> --------------------------------------------
>>>
>>> Currently, when it comes to BPF memory barriers, our choices are effect=
ively
>>> limited to:
>>>
>>>    * compiler barrier: 'asm volatile ("" ::: "memory");'
>>>    * full memory barriers implied by compiler built-ins like
>>>      __sync_val_compare_and_swap()
>>>
>>> We need more.  During offline discussion with Paul, we agreed we can st=
art
>>> from:
>>>
>>>    * load-acquire: __atomic_load_n(... memorder=3D__ATOMIC_ACQUIRE);
>>>    * store-release: __atomic_store_n(... memorder=3D__ATOMIC_RELEASE);
>> we would need inline asm equivalent too. Similar to kernel
>> smp_load_acquire() macro.
>>
>>> Theoretically, the BPF JIT compiler could also reorder instructions jus=
t like
>>> Clang or GCC, though it might not currently do so.  If we ever develope=
d a more
>>> optimizing BPF JIT compiler, it would also be nice to have an optimizat=
ion
>>> barrier for it.  However, Alexei Starovoitov has expressed that definin=
g a BPF
>>> instruction with 'asm volatile ("" ::: "memory");' semantics might be t=
ricky.
>> It can be a standalone insn that is a compiler barrier only but that fee=
ls like
>> a waste of an instruction. So depending how we end up encoding various
>> real barriers
>> there may be a bit to spend in such a barrier insn that is only a
>> compiler barrier.
>> In this case optimizing JIT barrier.
>>
>>> II. Implicit barriers can get confusing
>>> ---------------------------------------
>>>
>>> We noticed that, as a bit of a surprise, the __sync_*fetch*() built-ins=
 do not
>>> always imply a full barrier for BPF on ARM.  For example, when using LL=
VM, the
>>> frequently-used __sync_fetch_and_add() can either imply "relaxed" (no b=
arrier),
>>> or "acquire and release" (full barrier) semantics, depending on if its =
return
>>> value is used:
>>>
>>> Case (a): return value is used
>>>
>>>    SEC("...")
>>>    int64_t foo;
>>>
>>>    int64_t func(...) {
>>>        return __sync_fetch_and_add(&foo, 1);
>>>    }
>>>
>>> For case (a), Clang gave us:
>>>
>>>    3:    db 01 00 00 01 00 00 00 r0 =3D atomic_fetch_add((u64 *)(r1 + 0=
x0), r0)
>>>
>>>    opcode    (0xdb): BPF_STX | BPF_ATOMIC | BPF_DW
>>>    imm (0x00000001): BPF_ADD | BPF_FETCH
>>>
>>> Case (b): return value is ignored
>>>
>>>    SEC("...")
>>>    int64_t foo;
>>>
>>>    int64_t func(...) {
>>>        __sync_fetch_and_add(&foo, 1);
>>>
>>>        return foo;
>>>    }
>>>
>>> For case (b), Clang gave us:
>>>
>>>    3:    db 12 00 00 00 00 00 00 lock *(u64 *)(r2 + 0x0) +=3D r1
>>>
>>>    opcode    (0xdb): BPF_STX | BPF_ATOMIC | BPF_DW
>>>    imm (0x00000000): BPF_ADD
>>>
>>> LLVM decided to drop BPF_FETCH, since the return value of
>>> __sync_fetch_and_add() is being ignored [2].  Now, if we take a look at
>>> emit_lse_atomic() in the BPF JIT compiler code for ARM64 (suppose that =
LSE
>>> atomic instructions are being used):
>>>
>>>    case BPF_ADD:
>>>            emit(A64_STADD(isdw, reg, src), ctx);
>>>            break;
>>>    <...>
>>>    case BPF_ADD | BPF_FETCH:
>>>            emit(A64_LDADDAL(isdw, src, reg, src), ctx);
>>>            break;
>>>
>>> STADD is an alias for LDADD.  According to [3]:
>>>
>>>    * LDADDAL for case (a) has "acquire" plus "release" semantics
>>>    * LDADD for case (b) "has neither acquire nor release semantics"
>>>
>>> This is pretty non-intuitive; a compiler built-in should not have incon=
sistent
>>> implications on memory ordering, and it is better not to require all BPF
>>> programmers to memorize this.
>>>
>>> GCC seems a bit ambiguous [4] on whether __sync_*fetch*() built-ins sho=
uld
>>> always imply a full barrier.  GCC considers these __sync_*() built-ins =
as
>>> "legacy", and introduced a new set of __atomic_*() built-ins ("Memory M=
odel
>>> Aware Atomic Operations") [5] to replace them.  These __atomic_*() buil=
t-ins
>>> are designed to be a lot more explicit on memory ordering, for example:
>>>
>>>    type __atomic_fetch_add (type *ptr, type val, int memorder)
>>>
>>> This requires the programmer to specify a memory order type (relaxed, a=
cquire,
>>> release...) via the "memorder" parameter.  Currently in LLVM, for BPF, =
those
>>> __atomic_*fetch*() built-ins seem to be aliases to their __sync_*fetch*=
()
>>> counterparts (the "memorder" parameter seems effectively ignored), and =
are not
>>> fully supported.
>> This sounds like a compiler bug.
>>
>> Yonghong, Jose,
>> do you know what compilers do for other backends?
>> Is it allowed to convert sycn_fetch_add into sync_add when fetch part is=
 unused?
>
> This behavior is introduced by the following llvm commit:
> https://github.com/llvm/llvm-project/commit/286daafd65129228e08a1d07aa4ca=
74488615744
>
> Specifically the following commit message:
>
> =3D=3D=3D=3D=3D=3D=3D
> Similar to xadd, atomic xadd, xor and xxor (atomic_<op>)
> instructions are added for atomic operations which do not
> have return values. LLVM will check the return value for
> __sync_fetch_and_{add,and,or,xor}.
> If the return value is used, instructions atomic_fetch_<op>
> will be used. Otherwise, atomic_<op> instructions will be used.
> =3D=3D=3D=3D=3D=3D
>
> Basically, if no return value, __sync_fetch_and_add() will use
> xadd insn. The decision is made at that time to maintain backward compati=
bility.
> For one example, in bcc
>   https://github.com/iovisor/bcc/blob/master/src/cc/export/helpers.h#L1444
> we have
>   #define lock_xadd(ptr, val) ((void)__sync_fetch_and_add(ptr, val))
>
> Should we use atomic_fetch_*() always regardless of whether the return
> val is used or not? Probably, it should still work. Not sure what gcc
> does for this case.

GCC behaves similarly.

For program A:

  long foo;
=20=20
  long func () {
        return __sync_fetch_and_add(&foo, 1);
  }

bpf-unknown-none-gcc -O2 compiles to:

  0000000000000000 <func>:
     0:	18 00 00 00 00 00 00 00 	r0=3D0 ll
     8:	00 00 00 00 00 00 00 00=20
    10:	b7 01 00 00 01 00 00 00 	r1=3D1
    18:	db 10 00 00 01 00 00 00 	r1=3Datomic_fetch_add((u64*)(r0+0),r1)
    20:	bf 10 00 00 00 00 00 00 	r0=3Dr1
    28:	95 00 00 00 00 00 00 00 	exit

And for program B:

  long foo;
=20=20
  long func () {
       __sync_fetch_and_add(&foo, 1);
        return foo;
  }

bpf-unknown-none-gcc -O2 compiles to:

  0000000000000000 <func>:
     0:	18 00 00 00 00 00 00 00 	r0=3D0 ll
     8:	00 00 00 00 00 00 00 00=20
    10:	b7 01 00 00 01 00 00 00 	r1=3D1
    18:	db 10 00 00 00 00 00 00 	lock *(u64*)(r0+0)+=3Dr1
    20:	79 00 00 00 00 00 00 00 	r0=3D*(u64*)(r0+0)
    28:	95 00 00 00 00 00 00 00 	exit

Internally:

- When compiling the program A GCC decides to emit an
  `atomic_fetch_addDI' insn, documented as:

  'atomic_fetch_addMODE', 'atomic_fetch_subMODE'
  'atomic_fetch_orMODE', 'atomic_fetch_andMODE'
  'atomic_fetch_xorMODE', 'atomic_fetch_nandMODE'

     These patterns emit code for an atomic operation on memory with
     memory model semantics, and return the original value.  Operand 0
     is an output operand which contains the value of the memory
     location before the operation was performed.  Operand 1 is the
     memory on which the atomic operation is performed.  Operand 2 is
     the second operand to the binary operator.  Operand 3 is the memory
     model to be used by the operation.

  The BPF backend defines atomic_fetch_add for DI modes (long) to expand
  to this BPF instruction:

      %w0 =3D atomic_fetch_add((<smop> *)%1, %w0)

- When compiling the program B GCC decides to emit an `atomic_addDI'
  insn, documented as:

  'atomic_addMODE', 'atomic_subMODE'
  'atomic_orMODE', 'atomic_andMODE'
  'atomic_xorMODE', 'atomic_nandMODE'

     These patterns emit code for an atomic operation on memory with
     memory model semantics.  Operand 0 is the memory on which the
     atomic operation is performed.  Operand 1 is the second operand to
     the binary operator.  Operand 2 is the memory model to be used by
     the operation.

  The BPF backend defines atomic_fetch_add for DI modes (long) to expand
  to this BPF instruction:

      lock *(<smop> *)%w0 +=3D %w1

This is done for all targets. In x86-64, for example, case A compiles
to:

  0000000000000000 <func>:
     0:	b8 01 00 00 00       	mov    $0x1,%eax
     5:	f0 48 0f c1 05 00 00 	lock xadd %rax,0x0(%rip)        # e <func+0xe>
     c:	00 00=20
     e:	c3                   	retq=20=20=20

And case B compiles to:

  0000000000000000 <func>:
     0:	f0 48 83 05 00 00 00 	lock addq $0x1,0x0(%rip)        # 9 <func+0x9>
     7:	00 01=20
     9:	48 8b 05 00 00 00 00 	mov    0x0(%rip),%rax        # 10 <func+0x10>
    10:	c3                   	retq=20=20=20

Why wouldn't the compiler be allowed to optimize from atomic_fetch_add
to atomic_add in this case?

>
>>
>>> III. Next steps
>>> ---------------
>>>
>>> Roughly, the scope of this work includes:
>>>
>>>    * decide how to extend the BPF ISA (add new instructions and/or exte=
nd
>>>      current ones)
>> ldx/stx insns support MEM and MEMSX modifiers.
>> Adding MEM_ACQ_REL feels like a natural fit. Better name?
>>
>> For barriers we would need a new insn. Not sure which class would fit th=
e best.
>> Maybe BPF_LD ?
>>
>> Another alternative for barriers is to use nocsr kfuncs.
>> Then we have the freedom to make mistakes and fix them later.
>> One kfunc per barrier would do.
>> JITs would inline them into appropriate insns.
>> In bpf progs they will be used just like in the kernel code smp_mb(),
>> smp_rmb(), etc.
>>
>> I don't think compilers have to emit barriers from C code, so my
>> preference is kfuncs atm.
>>
>>>    * teach LLVM and GCC to generate the new/extended instructions
>>>    * teach the BPF verifier to understand them
>>>    * teach the BPF JIT compiler to compile them
>>>    * update BPF memory model and tooling
>>>    * update IETF specification
>>>
>>> Additionally, for the issue described in the previous section, we need =
to:
>>>
>>>    * check if GCC has the same behavior
>>>    * at least clearly document the implied effects on BPF memory orderi=
ng of
>>>      current __sync_*fetch*() built-ins (especially for architectures l=
ike ARM),
>>>      as described
>>>    * fully support the new __atomic_*fetch*() built-ins for BPF to repl=
ace the
>>>      __sync_*fetch*() ones
>>>
>>> Any suggestions or corrections would be most welcome!
>>>
>>> Thanks,
>>> Peilin Ye
>>>
>>>
>>> [1] Instruction-Level BPF Memory Model
>>> https://docs.google.com/document/d/1TaSEfWfLnRUi5KqkavUQyL2tThJXYWHS15q=
cbxIsFb0/edit?usp=3Dsharing
>>>
>>> [2] For more information, see LLVM commit 286daafd6512 ("[BPF] support =
atomic
>>>      instructions").  Search for "LLVM will check the return value" in =
the
>>>      commit message.
>>>
>>> [3] Arm Architecture Reference Manual for A-profile architecture (ARM D=
DI
>>>      0487K.a, ID032224), C6.2.149, page 2006
>>>
>>> [4] https://gcc.gnu.org/onlinedocs/gcc/_005f_005fsync-Builtins.html
>>>      6.58 Legacy __sync Built-in Functions for Atomic Memory Access
>>>      "In most cases, these built-in functions are considered a full bar=
rier."
>>>
>>> [5] https://gcc.gnu.org/onlinedocs/gcc/_005f_005fatomic-Builtins.html
>>>      6.59 Built-in Functions for Memory Model Aware Atomic Operations
>>>

