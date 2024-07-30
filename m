Return-Path: <bpf+bounces-35997-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D25489406C4
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 07:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53D2B1F234C9
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 05:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A87E16631D;
	Tue, 30 Jul 2024 05:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DiVTueDy"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC1D2114
	for <bpf@vger.kernel.org>; Tue, 30 Jul 2024 05:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722316479; cv=none; b=saVFnlgyMYixRWTELCfb9iyIaMFlc1jmLu+U84hrvvJNvEVFPinRpLHuy1cLOkG9MdgsclaNHLwCZPWbxmNqI1zMcDKlAXI8d08ZuybUZCXMZk+qD6ZXugzoyxNXdrgufnAkDtOcEfRYhy9/DGU7dBvjhPAt6BEOtw11wK+N+QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722316479; c=relaxed/simple;
	bh=eo9pfzE8J3C5T90DXC0xJHNLHSR+DD+dXo9gbyzlMxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nwTRYFUthddYi4jCGQpx4eC/UHlDBaug5cV4065ZPaSgql7TSfrgYpMM0Ysg1lGe7V5h1KW5VLHuUTS7jBIZYVOizA5b13yorikekIH6MshNBxACjwHcZQ7vq774cQt+Hp9KbQ3FnP1HAXTntd48M5YqEKHoz3WnES4aKKW98bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DiVTueDy; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <24b57380-c829-4033-a7b1-06a4ed413a49@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722316474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aeEQr55fnGqlTyItMWtOVFKJNLEehnQDAvq83BlpXW4=;
	b=DiVTueDyqC3BdaBslieYfOQ3k2t6qKNh0JcvT/lynxPkTIDjW28ZJ3SJ4rq7IzvnyF7r3E
	TFHV8DdXHtm7yXk+8R6jLOI7AFoJRPHj6p8yMUXPFa7bjApGJvosYYN/UjFfeALYX2yXn7
	4idmo2Yzz3t6Rfy6s2t6ahNj7+yvdys=
Date: Mon, 29 Jul 2024 22:14:26 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Supporting New Memory Barrier Types in BPF
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Peilin Ye <yepeilin@google.com>, "Jose E. Marchesi" <jemarch@gnu.org>
Cc: bpf <bpf@vger.kernel.org>, Josh Don <joshdon@google.com>,
 Barret Rhoden <brho@google.com>, Neel Natu <neelnatu@google.com>,
 Benjamin Segall <bsegall@google.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 David Vernet <dvernet@meta.com>, Dave Marchevsky <davemarchevsky@meta.com>
References: <20240729183246.4110549-1-yepeilin@google.com>
 <CAADnVQJqGzH+iT9M8ajT62H9+kAw1RXAdB42G3pvcLKPVmy8tg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQJqGzH+iT9M8ajT62H9+kAw1RXAdB42G3pvcLKPVmy8tg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 7/29/24 6:28 PM, Alexei Starovoitov wrote:
> On Mon, Jul 29, 2024 at 11:33 AM Peilin Ye <yepeilin@google.com> wrote:
>> Hi list!
>>
>> As we are looking at running sched_ext-style BPF scheduling on architectures
>> with a more relaxed memory model (i.e. ARM), we would like to:
>>
>>    1. have fine-grained control over memory ordering in BPF (instead of
>>       defaulting to a full barrier), for performance reasons
>>    2. pay closer attention to if memory barriers are being used correctly in
>>       BPF
>>
>> To that end, our main goal here is to support more types of memory barriers in
>> BPF.  While Paul E. McKenney et al. are working on the formalized BPF memory
>> model [1], Paul agreed that it makes sense to support some basic types first.
>> Additionally, we noticed an issue with the __sync_*fetch*() compiler built-ins
>> related to memory ordering, which will be described in details below.
>>
>> I. We need more types of BPF memory barriers
>> --------------------------------------------
>>
>> Currently, when it comes to BPF memory barriers, our choices are effectively
>> limited to:
>>
>>    * compiler barrier: 'asm volatile ("" ::: "memory");'
>>    * full memory barriers implied by compiler built-ins like
>>      __sync_val_compare_and_swap()
>>
>> We need more.  During offline discussion with Paul, we agreed we can start
>> from:
>>
>>    * load-acquire: __atomic_load_n(... memorder=__ATOMIC_ACQUIRE);
>>    * store-release: __atomic_store_n(... memorder=__ATOMIC_RELEASE);
> we would need inline asm equivalent too. Similar to kernel
> smp_load_acquire() macro.
>
>> Theoretically, the BPF JIT compiler could also reorder instructions just like
>> Clang or GCC, though it might not currently do so.  If we ever developed a more
>> optimizing BPF JIT compiler, it would also be nice to have an optimization
>> barrier for it.  However, Alexei Starovoitov has expressed that defining a BPF
>> instruction with 'asm volatile ("" ::: "memory");' semantics might be tricky.
> It can be a standalone insn that is a compiler barrier only but that feels like
> a waste of an instruction. So depending how we end up encoding various
> real barriers
> there may be a bit to spend in such a barrier insn that is only a
> compiler barrier.
> In this case optimizing JIT barrier.
>
>> II. Implicit barriers can get confusing
>> ---------------------------------------
>>
>> We noticed that, as a bit of a surprise, the __sync_*fetch*() built-ins do not
>> always imply a full barrier for BPF on ARM.  For example, when using LLVM, the
>> frequently-used __sync_fetch_and_add() can either imply "relaxed" (no barrier),
>> or "acquire and release" (full barrier) semantics, depending on if its return
>> value is used:
>>
>> Case (a): return value is used
>>
>>    SEC("...")
>>    int64_t foo;
>>
>>    int64_t func(...) {
>>        return __sync_fetch_and_add(&foo, 1);
>>    }
>>
>> For case (a), Clang gave us:
>>
>>    3:    db 01 00 00 01 00 00 00 r0 = atomic_fetch_add((u64 *)(r1 + 0x0), r0)
>>
>>    opcode    (0xdb): BPF_STX | BPF_ATOMIC | BPF_DW
>>    imm (0x00000001): BPF_ADD | BPF_FETCH
>>
>> Case (b): return value is ignored
>>
>>    SEC("...")
>>    int64_t foo;
>>
>>    int64_t func(...) {
>>        __sync_fetch_and_add(&foo, 1);
>>
>>        return foo;
>>    }
>>
>> For case (b), Clang gave us:
>>
>>    3:    db 12 00 00 00 00 00 00 lock *(u64 *)(r2 + 0x0) += r1
>>
>>    opcode    (0xdb): BPF_STX | BPF_ATOMIC | BPF_DW
>>    imm (0x00000000): BPF_ADD
>>
>> LLVM decided to drop BPF_FETCH, since the return value of
>> __sync_fetch_and_add() is being ignored [2].  Now, if we take a look at
>> emit_lse_atomic() in the BPF JIT compiler code for ARM64 (suppose that LSE
>> atomic instructions are being used):
>>
>>    case BPF_ADD:
>>            emit(A64_STADD(isdw, reg, src), ctx);
>>            break;
>>    <...>
>>    case BPF_ADD | BPF_FETCH:
>>            emit(A64_LDADDAL(isdw, src, reg, src), ctx);
>>            break;
>>
>> STADD is an alias for LDADD.  According to [3]:
>>
>>    * LDADDAL for case (a) has "acquire" plus "release" semantics
>>    * LDADD for case (b) "has neither acquire nor release semantics"
>>
>> This is pretty non-intuitive; a compiler built-in should not have inconsistent
>> implications on memory ordering, and it is better not to require all BPF
>> programmers to memorize this.
>>
>> GCC seems a bit ambiguous [4] on whether __sync_*fetch*() built-ins should
>> always imply a full barrier.  GCC considers these __sync_*() built-ins as
>> "legacy", and introduced a new set of __atomic_*() built-ins ("Memory Model
>> Aware Atomic Operations") [5] to replace them.  These __atomic_*() built-ins
>> are designed to be a lot more explicit on memory ordering, for example:
>>
>>    type __atomic_fetch_add (type *ptr, type val, int memorder)
>>
>> This requires the programmer to specify a memory order type (relaxed, acquire,
>> release...) via the "memorder" parameter.  Currently in LLVM, for BPF, those
>> __atomic_*fetch*() built-ins seem to be aliases to their __sync_*fetch*()
>> counterparts (the "memorder" parameter seems effectively ignored), and are not
>> fully supported.
> This sounds like a compiler bug.
>
> Yonghong, Jose,
> do you know what compilers do for other backends?
> Is it allowed to convert sycn_fetch_add into sync_add when fetch part is unused?

This behavior is introduced by the following llvm commit:
https://github.com/llvm/llvm-project/commit/286daafd65129228e08a1d07aa4ca74488615744

Specifically the following commit message:

=======
Similar to xadd, atomic xadd, xor and xxor (atomic_<op>)
instructions are added for atomic operations which do not
have return values. LLVM will check the return value for
__sync_fetch_and_{add,and,or,xor}.
If the return value is used, instructions atomic_fetch_<op>
will be used. Otherwise, atomic_<op> instructions will be used.
======

Basically, if no return value, __sync_fetch_and_add() will use
xadd insn. The decision is made at that time to maintain backward compatibility.
For one example, in bcc
   https://github.com/iovisor/bcc/blob/master/src/cc/export/helpers.h#L1444
we have
   #define lock_xadd(ptr, val) ((void)__sync_fetch_and_add(ptr, val))

Should we use atomic_fetch_*() always regardless of whether the return
val is used or not? Probably, it should still work. Not sure what gcc
does for this case.

>
>> III. Next steps
>> ---------------
>>
>> Roughly, the scope of this work includes:
>>
>>    * decide how to extend the BPF ISA (add new instructions and/or extend
>>      current ones)
> ldx/stx insns support MEM and MEMSX modifiers.
> Adding MEM_ACQ_REL feels like a natural fit. Better name?
>
> For barriers we would need a new insn. Not sure which class would fit the best.
> Maybe BPF_LD ?
>
> Another alternative for barriers is to use nocsr kfuncs.
> Then we have the freedom to make mistakes and fix them later.
> One kfunc per barrier would do.
> JITs would inline them into appropriate insns.
> In bpf progs they will be used just like in the kernel code smp_mb(),
> smp_rmb(), etc.
>
> I don't think compilers have to emit barriers from C code, so my
> preference is kfuncs atm.
>
>>    * teach LLVM and GCC to generate the new/extended instructions
>>    * teach the BPF verifier to understand them
>>    * teach the BPF JIT compiler to compile them
>>    * update BPF memory model and tooling
>>    * update IETF specification
>>
>> Additionally, for the issue described in the previous section, we need to:
>>
>>    * check if GCC has the same behavior
>>    * at least clearly document the implied effects on BPF memory ordering of
>>      current __sync_*fetch*() built-ins (especially for architectures like ARM),
>>      as described
>>    * fully support the new __atomic_*fetch*() built-ins for BPF to replace the
>>      __sync_*fetch*() ones
>>
>> Any suggestions or corrections would be most welcome!
>>
>> Thanks,
>> Peilin Ye
>>
>>
>> [1] Instruction-Level BPF Memory Model
>> https://docs.google.com/document/d/1TaSEfWfLnRUi5KqkavUQyL2tThJXYWHS15qcbxIsFb0/edit?usp=sharing
>>
>> [2] For more information, see LLVM commit 286daafd6512 ("[BPF] support atomic
>>      instructions").  Search for "LLVM will check the return value" in the
>>      commit message.
>>
>> [3] Arm Architecture Reference Manual for A-profile architecture (ARM DDI
>>      0487K.a, ID032224), C6.2.149, page 2006
>>
>> [4] https://gcc.gnu.org/onlinedocs/gcc/_005f_005fsync-Builtins.html
>>      6.58 Legacy __sync Built-in Functions for Atomic Memory Access
>>      "In most cases, these built-in functions are considered a full barrier."
>>
>> [5] https://gcc.gnu.org/onlinedocs/gcc/_005f_005fatomic-Builtins.html
>>      6.59 Built-in Functions for Memory Model Aware Atomic Operations
>>

