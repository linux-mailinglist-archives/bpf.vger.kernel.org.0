Return-Path: <bpf+bounces-36232-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2263945106
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 18:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2192D1F26875
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 16:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCED1B9B2C;
	Thu,  1 Aug 2024 16:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cny0Y886"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3685D1B8EBA
	for <bpf@vger.kernel.org>; Thu,  1 Aug 2024 16:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722530667; cv=none; b=TUml1XnkBz68xYHHmZMKSsagoqJ8RWDPmXtuWF9FhZzHvFXLuza++zk5Hr/u7Cb9ElqLWHBPj3xW5vkmg41VqsWrcDlBt9t5r+s4oF6+W99+cBlbNL7qkofjg1x0BuWk3FFk9aWMClS7x/ifGIKkQSwC67FSyvK41JRVHZy3SfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722530667; c=relaxed/simple;
	bh=HAb950UTbub2J/bHKwzyB/wsStkG43OX7E0GFAqYNhg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oR9j+ZfDc9evMOj5souC5Xa+F2blP37UqMWv26CcDVysIFVqbM3y9qJbPnUfPmXdR9NvllZbtdQ8pe/bTpiRvPVDyyWbwppgPvN3usPzP1jF95oRMGl2EHpqAMc5mSvHiX3UIGDF7oQdsdNzZ3l0SUMlFJO5zhhTlBhCW4w+Ye8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cny0Y886; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2fcdce74-e1c8-481c-ac43-e15fbb6765d8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722530662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kiz2MmrWD/MoeSPmRiSej1q35SuGY78P8GPI3KyAUxg=;
	b=cny0Y886w66nkYirQT1yyt6XjxgViGlx5sfA4ZWCvdKoPmCYrMWKYA3zaVUm1g29NNJ8rl
	gjWSDQRXpmEd9LklwbGOpDg78280W9Le+YAGicfiYHaQHEU47dRQwYcAj45OpofR4xskF5
	HINdg7zFpClDy7fn8lwkTApf39mx3fM=
Date: Thu, 1 Aug 2024 09:44:14 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Supporting New Memory Barrier Types in BPF
To: "Jose E. Marchesi" <jemarch@gnu.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Peilin Ye <yepeilin@google.com>, bpf <bpf@vger.kernel.org>,
 Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>,
 Neel Natu <neelnatu@google.com>, Benjamin Segall <bsegall@google.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, David Vernet <dvernet@meta.com>,
 Dave Marchevsky <davemarchevsky@meta.com>
References: <20240729183246.4110549-1-yepeilin@google.com>
 <CAADnVQJqGzH+iT9M8ajT62H9+kAw1RXAdB42G3pvcLKPVmy8tg@mail.gmail.com>
 <24b57380-c829-4033-a7b1-06a4ed413a49@linux.dev> <87h6c4h0ju.fsf@gnu.org>
 <87v80kfhox.fsf@gnu.org>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <87v80kfhox.fsf@gnu.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 8/1/24 7:20 AM, Jose E. Marchesi wrote:
>>> On 7/29/24 6:28 PM, Alexei Starovoitov wrote:
>>>> On Mon, Jul 29, 2024 at 11:33 AM Peilin Ye <yepeilin@google.com> wrote:
>>>>> Hi list!
>>>>>
>>>>> As we are looking at running sched_ext-style BPF scheduling on architectures
>>>>> with a more relaxed memory model (i.e. ARM), we would like to:
>>>>>
>>>>>     1. have fine-grained control over memory ordering in BPF (instead of
>>>>>        defaulting to a full barrier), for performance reasons
>>>>>     2. pay closer attention to if memory barriers are being used correctly in
>>>>>        BPF
>>>>>
>>>>> To that end, our main goal here is to support more types of memory barriers in
>>>>> BPF.  While Paul E. McKenney et al. are working on the formalized BPF memory
>>>>> model [1], Paul agreed that it makes sense to support some basic types first.
>>>>> Additionally, we noticed an issue with the __sync_*fetch*() compiler built-ins
>>>>> related to memory ordering, which will be described in details below.
>>>>>
>>>>> I. We need more types of BPF memory barriers
>>>>> --------------------------------------------
>>>>>
>>>>> Currently, when it comes to BPF memory barriers, our choices are effectively
>>>>> limited to:
>>>>>
>>>>>     * compiler barrier: 'asm volatile ("" ::: "memory");'
>>>>>     * full memory barriers implied by compiler built-ins like
>>>>>       __sync_val_compare_and_swap()
>>>>>
>>>>> We need more.  During offline discussion with Paul, we agreed we can start
>>>>> from:
>>>>>
>>>>>     * load-acquire: __atomic_load_n(... memorder=__ATOMIC_ACQUIRE);
>>>>>     * store-release: __atomic_store_n(... memorder=__ATOMIC_RELEASE);
>>>> we would need inline asm equivalent too. Similar to kernel
>>>> smp_load_acquire() macro.
>>>>
>>>>> Theoretically, the BPF JIT compiler could also reorder instructions just like
>>>>> Clang or GCC, though it might not currently do so.  If we ever developed a more
>>>>> optimizing BPF JIT compiler, it would also be nice to have an optimization
>>>>> barrier for it.  However, Alexei Starovoitov has expressed that defining a BPF
>>>>> instruction with 'asm volatile ("" ::: "memory");' semantics might be tricky.
>>>> It can be a standalone insn that is a compiler barrier only but that feels like
>>>> a waste of an instruction. So depending how we end up encoding various
>>>> real barriers
>>>> there may be a bit to spend in such a barrier insn that is only a
>>>> compiler barrier.
>>>> In this case optimizing JIT barrier.
>>>>
>>>>> II. Implicit barriers can get confusing
>>>>> ---------------------------------------
>>>>>
>>>>> We noticed that, as a bit of a surprise, the __sync_*fetch*() built-ins do not
>>>>> always imply a full barrier for BPF on ARM.  For example, when using LLVM, the
>>>>> frequently-used __sync_fetch_and_add() can either imply "relaxed" (no barrier),
>>>>> or "acquire and release" (full barrier) semantics, depending on if its return
>>>>> value is used:
>>>>>
>>>>> Case (a): return value is used
>>>>>
>>>>>     SEC("...")
>>>>>     int64_t foo;
>>>>>
>>>>>     int64_t func(...) {
>>>>>         return __sync_fetch_and_add(&foo, 1);
>>>>>     }
>>>>>
>>>>> For case (a), Clang gave us:
>>>>>
>>>>>     3:    db 01 00 00 01 00 00 00 r0 = atomic_fetch_add((u64 *)(r1 + 0x0), r0)
>>>>>
>>>>>     opcode    (0xdb): BPF_STX | BPF_ATOMIC | BPF_DW
>>>>>     imm (0x00000001): BPF_ADD | BPF_FETCH
>>>>>
>>>>> Case (b): return value is ignored
>>>>>
>>>>>     SEC("...")
>>>>>     int64_t foo;
>>>>>
>>>>>     int64_t func(...) {
>>>>>         __sync_fetch_and_add(&foo, 1);
>>>>>
>>>>>         return foo;
>>>>>     }
>>>>>
>>>>> For case (b), Clang gave us:
>>>>>
>>>>>     3:    db 12 00 00 00 00 00 00 lock *(u64 *)(r2 + 0x0) += r1
>>>>>
>>>>>     opcode    (0xdb): BPF_STX | BPF_ATOMIC | BPF_DW
>>>>>     imm (0x00000000): BPF_ADD
>>>>>
>>>>> LLVM decided to drop BPF_FETCH, since the return value of
>>>>> __sync_fetch_and_add() is being ignored [2].  Now, if we take a look at
>>>>> emit_lse_atomic() in the BPF JIT compiler code for ARM64 (suppose that LSE
>>>>> atomic instructions are being used):
>>>>>
>>>>>     case BPF_ADD:
>>>>>             emit(A64_STADD(isdw, reg, src), ctx);
>>>>>             break;
>>>>>     <...>
>>>>>     case BPF_ADD | BPF_FETCH:
>>>>>             emit(A64_LDADDAL(isdw, src, reg, src), ctx);
>>>>>             break;
>>>>>
>>>>> STADD is an alias for LDADD.  According to [3]:
>>>>>
>>>>>     * LDADDAL for case (a) has "acquire" plus "release" semantics
>>>>>     * LDADD for case (b) "has neither acquire nor release semantics"
>>>>>
>>>>> This is pretty non-intuitive; a compiler built-in should not have inconsistent
>>>>> implications on memory ordering, and it is better not to require all BPF
>>>>> programmers to memorize this.
>>>>>
>>>>> GCC seems a bit ambiguous [4] on whether __sync_*fetch*() built-ins should
>>>>> always imply a full barrier.  GCC considers these __sync_*() built-ins as
>>>>> "legacy", and introduced a new set of __atomic_*() built-ins ("Memory Model
>>>>> Aware Atomic Operations") [5] to replace them.  These __atomic_*() built-ins
>>>>> are designed to be a lot more explicit on memory ordering, for example:
>>>>>
>>>>>     type __atomic_fetch_add (type *ptr, type val, int memorder)
>>>>>
>>>>> This requires the programmer to specify a memory order type (relaxed, acquire,
>>>>> release...) via the "memorder" parameter.  Currently in LLVM, for BPF, those
>>>>> __atomic_*fetch*() built-ins seem to be aliases to their __sync_*fetch*()
>>>>> counterparts (the "memorder" parameter seems effectively ignored), and are not
>>>>> fully supported.
>>>> This sounds like a compiler bug.
>>>>
>>>> Yonghong, Jose,
>>>> do you know what compilers do for other backends?
>>>> Is it allowed to convert sycn_fetch_add into sync_add when fetch part is unused?
>>> This behavior is introduced by the following llvm commit:
>>> https://github.com/llvm/llvm-project/commit/286daafd65129228e08a1d07aa4ca74488615744
>>>
>>> Specifically the following commit message:
>>>
>>> =======
>>> Similar to xadd, atomic xadd, xor and xxor (atomic_<op>)
>>> instructions are added for atomic operations which do not
>>> have return values. LLVM will check the return value for
>>> __sync_fetch_and_{add,and,or,xor}.
>>> If the return value is used, instructions atomic_fetch_<op>
>>> will be used. Otherwise, atomic_<op> instructions will be used.
>>> ======
>>>
>>> Basically, if no return value, __sync_fetch_and_add() will use
>>> xadd insn. The decision is made at that time to maintain backward compatibility.
>>> For one example, in bcc
>>>    https://github.com/iovisor/bcc/blob/master/src/cc/export/helpers.h#L1444
>>> we have
>>>    #define lock_xadd(ptr, val) ((void)__sync_fetch_and_add(ptr, val))
>>>
>>> Should we use atomic_fetch_*() always regardless of whether the return
>>> val is used or not? Probably, it should still work. Not sure what gcc
>>> does for this case.
>> GCC behaves similarly.
>>
>> For program A:
>>
>>    long foo;
>>    
>>    long func () {
>>          return __sync_fetch_and_add(&foo, 1);
>>    }
>>
>> bpf-unknown-none-gcc -O2 compiles to:
>>
>>    0000000000000000 <func>:
>>       0:	18 00 00 00 00 00 00 00 	r0=0 ll
>>       8:	00 00 00 00 00 00 00 00
>>      10:	b7 01 00 00 01 00 00 00 	r1=1
>>      18:	db 10 00 00 01 00 00 00 	r1=atomic_fetch_add((u64*)(r0+0),r1)
>>      20:	bf 10 00 00 00 00 00 00 	r0=r1
>>      28:	95 00 00 00 00 00 00 00 	exit
>>
>> And for program B:
>>
>>    long foo;
>>    
>>    long func () {
>>         __sync_fetch_and_add(&foo, 1);
>>          return foo;
>>    }
>>
>> bpf-unknown-none-gcc -O2 compiles to:
>>
>>    0000000000000000 <func>:
>>       0:	18 00 00 00 00 00 00 00 	r0=0 ll
>>       8:	00 00 00 00 00 00 00 00
>>      10:	b7 01 00 00 01 00 00 00 	r1=1
>>      18:	db 10 00 00 00 00 00 00 	lock *(u64*)(r0+0)+=r1
>>      20:	79 00 00 00 00 00 00 00 	r0=*(u64*)(r0+0)
>>      28:	95 00 00 00 00 00 00 00 	exit
>>
>> Internally:
>>
>> - When compiling the program A GCC decides to emit an
>>    `atomic_fetch_addDI' insn, documented as:
>>
>>    'atomic_fetch_addMODE', 'atomic_fetch_subMODE'
>>    'atomic_fetch_orMODE', 'atomic_fetch_andMODE'
>>    'atomic_fetch_xorMODE', 'atomic_fetch_nandMODE'
>>
>>       These patterns emit code for an atomic operation on memory with
>>       memory model semantics, and return the original value.  Operand 0
>>       is an output operand which contains the value of the memory
>>       location before the operation was performed.  Operand 1 is the
>>       memory on which the atomic operation is performed.  Operand 2 is
>>       the second operand to the binary operator.  Operand 3 is the memory
>>       model to be used by the operation.
>>
>>    The BPF backend defines atomic_fetch_add for DI modes (long) to expand
>>    to this BPF instruction:
>>
>>        %w0 = atomic_fetch_add((<smop> *)%1, %w0)
>>
>> - When compiling the program B GCC decides to emit an `atomic_addDI'
>>    insn, documented as:
>>
>>    'atomic_addMODE', 'atomic_subMODE'
>>    'atomic_orMODE', 'atomic_andMODE'
>>    'atomic_xorMODE', 'atomic_nandMODE'
>>
>>       These patterns emit code for an atomic operation on memory with
>>       memory model semantics.  Operand 0 is the memory on which the
>>       atomic operation is performed.  Operand 1 is the second operand to
>>       the binary operator.  Operand 2 is the memory model to be used by
>>       the operation.
>>
>>    The BPF backend defines atomic_fetch_add for DI modes (long) to expand
>>    to this BPF instruction:
>>
>>        lock *(<smop> *)%w0 += %w1
>>
>> This is done for all targets. In x86-64, for example, case A compiles
>> to:
>>
>>    0000000000000000 <func>:
>>       0:	b8 01 00 00 00       	mov    $0x1,%eax
>>       5:	f0 48 0f c1 05 00 00 	lock xadd %rax,0x0(%rip)        # e <func+0xe>
>>       c:	00 00
>>       e:	c3                   	retq
>>
>> And case B compiles to:
>>
>>    0000000000000000 <func>:
>>       0:	f0 48 83 05 00 00 00 	lock addq $0x1,0x0(%rip)        # 9 <func+0x9>
>>       7:	00 01
>>       9:	48 8b 05 00 00 00 00 	mov    0x0(%rip),%rax        # 10 <func+0x10>
>>      10:	c3                   	retq
>>
>> Why wouldn't the compiler be allowed to optimize from atomic_fetch_add
>> to atomic_add in this case?
> Ok I see.  The generic compiler optimization is ok.  It is the backend
> that is buggy because it emits BPF instruction sequences with different
> memory ordering semantics for atomic_OP and atomic_fetch_OP.
>
> The only difference between fetching and non-fetching builtins is that
> in one case the original value is returned, in the other the new value.
> Other than that they should be equivalent.
>
> For ARM64, GCC generates for case A:
>
>    0000000000000000 <func>:
>       0:	90000001 	adrp	x1, 0 <func>
>       4:	d2800020 	mov	x0, #0x1                   	// #1
>       8:	91000021 	add	x1, x1, #0x0
>       c:	f8e00020 	ldaddal	x0, x0, [x1]
>      10:	d65f03c0 	ret
>
> And this for case B:
>
>    0000000000000000 <func>:
>       0:	90000000 	adrp	x0, 0 <func>
>       4:	d2800022 	mov	x2, #0x1                   	// #1
>       8:	91000001 	add	x1, x0, #0x0
>       c:	f8e20021 	ldaddal	x2, x1, [x1]
>      10:	f9400000 	ldr	x0, [x0]
>      14:	d65f03c0 	ret
>
> i.e. GCC emits LDADDAL for both atomic_add and atomic_fetch_add internal
> insns.  Like in x86-64, both sequences have same memory ordering
> semantics.
>
> Allright we are changing GCC to always emit fetch versions of sequences
> for all the supported atomic operations: add, and, or, xor.  After the
> change the `lock' versions of the instructions will not be generated by
> the compiler at all out of inline asm.
>
> Will send a headsup when done.

Thanks! https://github.com/llvm/llvm-project/pull/101428
is the change in llvm side.

[...]

