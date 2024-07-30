Return-Path: <bpf+bounces-35993-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4C7940616
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 05:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B25421C21CD8
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 03:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8201474A7;
	Tue, 30 Jul 2024 03:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QaE3U8NL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F853EA72
	for <bpf@vger.kernel.org>; Tue, 30 Jul 2024 03:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722311342; cv=none; b=s32YhONvAZgHGAv3iqLwtDEZxrPWgEMiqqMhYTpXSz/OasOkbz3MRQLGpnBqEf0xRILJ7A1ZFjtHx2a7s4BQT1eMGQejib4mMdKCdIUIwwTPA/kTJlol5Prei4cc3DA06tpENIRVgiSny2YqKGlLSuqH5P1WYw6Rbk73xyuPynk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722311342; c=relaxed/simple;
	bh=3RjoXJ+bSJMJXtk/7Pbd+mXNR6n2EglWtV8Xg9MpvR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7ZQ7rGTftSPULM5MsLDleBYuaqPBg475TCnaG/N5hE01uSTJOp/LoBN+hNbBHJrQarwjXfMeUAlXDq54PQRB1zbgHIexW66sc7813m35xlmOn8EGbDgNg9TpcSf/v3lzbKaqpOEW5RFWMFEin4j8fu22obN8vVvFKxbOWt+cas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QaE3U8NL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B8EC32782;
	Tue, 30 Jul 2024 03:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722311342;
	bh=3RjoXJ+bSJMJXtk/7Pbd+mXNR6n2EglWtV8Xg9MpvR8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=QaE3U8NLo2VYc6ExTY8tCK+5P7WEcmXDKaYoVaBb3zZecJFsezei59Ukza+Tm8Lp7
	 Lk/ADxyQna3uBw34fhg3SACce8Zyw4ihwgTryAXeCwerEF20GQwQEt6tyr/YsTWla/
	 g57UCx45pRDfzQySheQtAGPZJpb0mSHNG4jj/ZxNXvEWJTXhanp2KEUY3LGPiKUWKU
	 B3F5aMHmW1Jch4SnjghmZ+NFNdg6qPTcXgwYGTHFXi04VjXZZIFtOZ7W/DCfjWGkJu
	 73m/sBenaja+KLCLNQhKdzMqjZaE7C9uuker6IXaHB+8t6RZNH4yVoILN7KoGeo7Kf
	 HB2VSiVJaXzPA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BA1E6CE0E7A; Mon, 29 Jul 2024 20:49:01 -0700 (PDT)
Date: Mon, 29 Jul 2024 20:49:01 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Peilin Ye <yepeilin@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	"Jose E. Marchesi" <jemarch@gnu.org>, bpf <bpf@vger.kernel.org>,
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>,
	Neel Natu <neelnatu@google.com>,
	Benjamin Segall <bsegall@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	David Vernet <dvernet@meta.com>,
	Dave Marchevsky <davemarchevsky@meta.com>
Subject: Re: Supporting New Memory Barrier Types in BPF
Message-ID: <9fd26a67-f39f-4ff7-b433-612351e5ebc3@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240729183246.4110549-1-yepeilin@google.com>
 <CAADnVQJqGzH+iT9M8ajT62H9+kAw1RXAdB42G3pvcLKPVmy8tg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJqGzH+iT9M8ajT62H9+kAw1RXAdB42G3pvcLKPVmy8tg@mail.gmail.com>

On Mon, Jul 29, 2024 at 06:28:16PM -0700, Alexei Starovoitov wrote:
> On Mon, Jul 29, 2024 at 11:33 AM Peilin Ye <yepeilin@google.com> wrote:
> >
> > Hi list!
> >
> > As we are looking at running sched_ext-style BPF scheduling on architectures
> > with a more relaxed memory model (i.e. ARM), we would like to:
> >
> >   1. have fine-grained control over memory ordering in BPF (instead of
> >      defaulting to a full barrier), for performance reasons
> >   2. pay closer attention to if memory barriers are being used correctly in
> >      BPF
> >
> > To that end, our main goal here is to support more types of memory barriers in
> > BPF.  While Paul E. McKenney et al. are working on the formalized BPF memory
> > model [1], Paul agreed that it makes sense to support some basic types first.
> > Additionally, we noticed an issue with the __sync_*fetch*() compiler built-ins
> > related to memory ordering, which will be described in details below.
> >
> > I. We need more types of BPF memory barriers
> > --------------------------------------------
> >
> > Currently, when it comes to BPF memory barriers, our choices are effectively
> > limited to:
> >
> >   * compiler barrier: 'asm volatile ("" ::: "memory");'
> >   * full memory barriers implied by compiler built-ins like
> >     __sync_val_compare_and_swap()
> >
> > We need more.  During offline discussion with Paul, we agreed we can start
> > from:
> >
> >   * load-acquire: __atomic_load_n(... memorder=__ATOMIC_ACQUIRE);
> >   * store-release: __atomic_store_n(... memorder=__ATOMIC_RELEASE);
> 
> we would need inline asm equivalent too. Similar to kernel
> smp_load_acquire() macro.
> 
> > Theoretically, the BPF JIT compiler could also reorder instructions just like
> > Clang or GCC, though it might not currently do so.  If we ever developed a more
> > optimizing BPF JIT compiler, it would also be nice to have an optimization
> > barrier for it.  However, Alexei Starovoitov has expressed that defining a BPF
> > instruction with 'asm volatile ("" ::: "memory");' semantics might be tricky.
> 
> It can be a standalone insn that is a compiler barrier only but that feels like
> a waste of an instruction. So depending how we end up encoding various
> real barriers
> there may be a bit to spend in such a barrier insn that is only a
> compiler barrier.
> In this case optimizing JIT barrier.

When reading BPF instructions back into a compiler backend, would
it make sense to convert an acquire-load instruction back to
__atomic_load_n(... memorder=__ATOMIC_ACQUIRE)?  Or the internal
representation thereof?

							Thanx, Paul

> > II. Implicit barriers can get confusing
> > ---------------------------------------
> >
> > We noticed that, as a bit of a surprise, the __sync_*fetch*() built-ins do not
> > always imply a full barrier for BPF on ARM.  For example, when using LLVM, the
> > frequently-used __sync_fetch_and_add() can either imply "relaxed" (no barrier),
> > or "acquire and release" (full barrier) semantics, depending on if its return
> > value is used:
> >
> > Case (a): return value is used
> >
> >   SEC("...")
> >   int64_t foo;
> >
> >   int64_t func(...) {
> >       return __sync_fetch_and_add(&foo, 1);
> >   }
> >
> > For case (a), Clang gave us:
> >
> >   3:    db 01 00 00 01 00 00 00 r0 = atomic_fetch_add((u64 *)(r1 + 0x0), r0)
> >
> >   opcode    (0xdb): BPF_STX | BPF_ATOMIC | BPF_DW
> >   imm (0x00000001): BPF_ADD | BPF_FETCH
> >
> > Case (b): return value is ignored
> >
> >   SEC("...")
> >   int64_t foo;
> >
> >   int64_t func(...) {
> >       __sync_fetch_and_add(&foo, 1);
> >
> >       return foo;
> >   }
> >
> > For case (b), Clang gave us:
> >
> >   3:    db 12 00 00 00 00 00 00 lock *(u64 *)(r2 + 0x0) += r1
> >
> >   opcode    (0xdb): BPF_STX | BPF_ATOMIC | BPF_DW
> >   imm (0x00000000): BPF_ADD
> >
> > LLVM decided to drop BPF_FETCH, since the return value of
> > __sync_fetch_and_add() is being ignored [2].  Now, if we take a look at
> > emit_lse_atomic() in the BPF JIT compiler code for ARM64 (suppose that LSE
> > atomic instructions are being used):
> >
> >   case BPF_ADD:
> >           emit(A64_STADD(isdw, reg, src), ctx);
> >           break;
> >   <...>
> >   case BPF_ADD | BPF_FETCH:
> >           emit(A64_LDADDAL(isdw, src, reg, src), ctx);
> >           break;
> >
> > STADD is an alias for LDADD.  According to [3]:
> >
> >   * LDADDAL for case (a) has "acquire" plus "release" semantics
> >   * LDADD for case (b) "has neither acquire nor release semantics"
> >
> > This is pretty non-intuitive; a compiler built-in should not have inconsistent
> > implications on memory ordering, and it is better not to require all BPF
> > programmers to memorize this.
> >
> > GCC seems a bit ambiguous [4] on whether __sync_*fetch*() built-ins should
> > always imply a full barrier.  GCC considers these __sync_*() built-ins as
> > "legacy", and introduced a new set of __atomic_*() built-ins ("Memory Model
> > Aware Atomic Operations") [5] to replace them.  These __atomic_*() built-ins
> > are designed to be a lot more explicit on memory ordering, for example:
> >
> >   type __atomic_fetch_add (type *ptr, type val, int memorder)
> >
> > This requires the programmer to specify a memory order type (relaxed, acquire,
> > release...) via the "memorder" parameter.  Currently in LLVM, for BPF, those
> > __atomic_*fetch*() built-ins seem to be aliases to their __sync_*fetch*()
> > counterparts (the "memorder" parameter seems effectively ignored), and are not
> > fully supported.
> 
> This sounds like a compiler bug.
> 
> Yonghong, Jose,
> do you know what compilers do for other backends?
> Is it allowed to convert sycn_fetch_add into sync_add when fetch part is unused?
> 
> > III. Next steps
> > ---------------
> >
> > Roughly, the scope of this work includes:
> >
> >   * decide how to extend the BPF ISA (add new instructions and/or extend
> >     current ones)
> 
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
> >   * teach LLVM and GCC to generate the new/extended instructions
> >   * teach the BPF verifier to understand them
> >   * teach the BPF JIT compiler to compile them
> >   * update BPF memory model and tooling
> >   * update IETF specification
> >
> > Additionally, for the issue described in the previous section, we need to:
> >
> >   * check if GCC has the same behavior
> >   * at least clearly document the implied effects on BPF memory ordering of
> >     current __sync_*fetch*() built-ins (especially for architectures like ARM),
> >     as described
> >   * fully support the new __atomic_*fetch*() built-ins for BPF to replace the
> >     __sync_*fetch*() ones
> >
> > Any suggestions or corrections would be most welcome!
> >
> > Thanks,
> > Peilin Ye
> >
> >
> > [1] Instruction-Level BPF Memory Model
> > https://docs.google.com/document/d/1TaSEfWfLnRUi5KqkavUQyL2tThJXYWHS15qcbxIsFb0/edit?usp=sharing
> >
> > [2] For more information, see LLVM commit 286daafd6512 ("[BPF] support atomic
> >     instructions").  Search for "LLVM will check the return value" in the
> >     commit message.
> >
> > [3] Arm Architecture Reference Manual for A-profile architecture (ARM DDI
> >     0487K.a, ID032224), C6.2.149, page 2006
> >
> > [4] https://gcc.gnu.org/onlinedocs/gcc/_005f_005fsync-Builtins.html
> >     6.58 Legacy __sync Built-in Functions for Atomic Memory Access
> >     "In most cases, these built-in functions are considered a full barrier."
> >
> > [5] https://gcc.gnu.org/onlinedocs/gcc/_005f_005fatomic-Builtins.html
> >     6.59 Built-in Functions for Memory Model Aware Atomic Operations
> >

