Return-Path: <bpf+bounces-35969-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 848699403AB
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 03:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8F4A1C22248
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 01:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C008827;
	Tue, 30 Jul 2024 01:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCoLiMc+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98AD8C0B
	for <bpf@vger.kernel.org>; Tue, 30 Jul 2024 01:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722302911; cv=none; b=ZnuW5KqPrTBWzZD7Io3PUy8O6jQqXL/I72EYAPERl7tPzaZqoT5Q8wTOIm8Wwlsbl+b+JKUhJiNskBGuQUt3q7lL9rPE9wULA/Z1zl9qfwEt/fIE5uG8NJLB54YOfQOFxr4dmryf/N16BUUorWg3xphcAfSwxgpW1yTeDSSgFbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722302911; c=relaxed/simple;
	bh=XBIroXslsCTkqARlFZXLjRiM/j8URSk6N3KDJNnl1l0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ONuYEyuLvCc1liJzwp//SriZk5n3TVLGVtFo94erJNIcK4RTDJ8a9FhJFPUq5Faj5MxEcBQska7ZQNwpbOwxiSE2Tp7Gn+wSyGNVW5wCg3yUpMlMKkWHZdtQBhM7lXMoG+qpWGb4PYYI7+iZLsMFgVAmHv3jFbFrc7rTriHMNJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mCoLiMc+; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-368584f9e36so1722342f8f.2
        for <bpf@vger.kernel.org>; Mon, 29 Jul 2024 18:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722302908; x=1722907708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2sRDq6y1kd+3A3EL+MZ/sPDZ6XnUYu6dCglaWJ1smIs=;
        b=mCoLiMc+5pHSdgct35ScK7FqpH8gvrSdmIl+cOqj5hZQajOqiukxGEC1SFbwRkT3hs
         OI7xjJrOUlZjla3nh4mG03Ae0n0OItZA2Qzf9Lpz8R7M/7MlctNfT4si2fGu+YjioPJ8
         9KQ/KOyHdhIYNg4816E0DUKI2ZyPSqS4K/YzPICbdIgD4tAqo3RKfLZGM43gV0AieGBb
         TSOll8/FaCZ7fF8S/4hGSTb9VSa60DJoTm2MFHBMuuL9udY4aIwRPUnOBRshtyiRmLJm
         fZs43j0nk9wl/osdBWFlpMUaaGaK0yZXOac8uVGwNl3MDOmgSUFHKo8ia4aSvzEPTggN
         CUwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722302908; x=1722907708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2sRDq6y1kd+3A3EL+MZ/sPDZ6XnUYu6dCglaWJ1smIs=;
        b=YnwJAIIFoYTDkaR+Dxn++W2DSNK3EcRWipaDHGK9F1wcsu4kVEoi1/HqrPiY3J90nI
         wwthyjYXupPhtcKOwvbAKInup4eA5DBXn6YivnzzP7z1vckGX1/gYP16nF5Jsfc5iyD6
         ck//SyDsejju06xj7CEC+9+bgxZsE+bG0138aKUzjSpoWkxaRmzjAc3aZBXGQqcpEaAW
         AcUhZs/wIp7O2MqWOPh7NA6Fn3KwFS9xEYePCFGMgvl9I0WmQOgBsLJKvXX7jqr3Rm2y
         tqPSQxcu8K+XyhSHx6CJfklfYJfJcSX9kcfF0qkF7bnm22J5ZsY8mCbDB+xZhjLBsXr3
         2Ytg==
X-Gm-Message-State: AOJu0YwP2nBiG/D+auov0PZhYalJTsfYOXqtQvFpZGhkDVjw6JOjVDw0
	pT531H0LT73HQcv6p1DgKIB2rNnO6VTBziPtotBU53glhZe4RSdVzCbKbdT+5Snri3sHjfC+hew
	ncJFezb8Ce0uaX9sPSyWoNDkmPTA=
X-Google-Smtp-Source: AGHT+IGeUnU05DGys2UYyJPNa9qqfgzd0rVr1oweLYn2/Hb1MCjZXF8HEYgEXpf8WnnZz/Cfb9rfhbA2lpm+0bBwPO4=
X-Received: by 2002:a5d:5f51:0:b0:35f:1f8a:e69a with SMTP id
 ffacd0b85a97d-36b5d073f43mr9887446f8f.49.1722302907556; Mon, 29 Jul 2024
 18:28:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729183246.4110549-1-yepeilin@google.com>
In-Reply-To: <20240729183246.4110549-1-yepeilin@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 29 Jul 2024 18:28:16 -0700
Message-ID: <CAADnVQJqGzH+iT9M8ajT62H9+kAw1RXAdB42G3pvcLKPVmy8tg@mail.gmail.com>
Subject: Re: Supporting New Memory Barrier Types in BPF
To: Peilin Ye <yepeilin@google.com>, Yonghong Song <yonghong.song@linux.dev>, 
	"Jose E. Marchesi" <jemarch@gnu.org>
Cc: bpf <bpf@vger.kernel.org>, Josh Don <joshdon@google.com>, 
	Barret Rhoden <brho@google.com>, Neel Natu <neelnatu@google.com>, 
	Benjamin Segall <bsegall@google.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, David Vernet <dvernet@meta.com>, 
	Dave Marchevsky <davemarchevsky@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 11:33=E2=80=AFAM Peilin Ye <yepeilin@google.com> wr=
ote:
>
> Hi list!
>
> As we are looking at running sched_ext-style BPF scheduling on architectu=
res
> with a more relaxed memory model (i.e. ARM), we would like to:
>
>   1. have fine-grained control over memory ordering in BPF (instead of
>      defaulting to a full barrier), for performance reasons
>   2. pay closer attention to if memory barriers are being used correctly =
in
>      BPF
>
> To that end, our main goal here is to support more types of memory barrie=
rs in
> BPF.  While Paul E. McKenney et al. are working on the formalized BPF mem=
ory
> model [1], Paul agreed that it makes sense to support some basic types fi=
rst.
> Additionally, we noticed an issue with the __sync_*fetch*() compiler buil=
t-ins
> related to memory ordering, which will be described in details below.
>
> I. We need more types of BPF memory barriers
> --------------------------------------------
>
> Currently, when it comes to BPF memory barriers, our choices are effectiv=
ely
> limited to:
>
>   * compiler barrier: 'asm volatile ("" ::: "memory");'
>   * full memory barriers implied by compiler built-ins like
>     __sync_val_compare_and_swap()
>
> We need more.  During offline discussion with Paul, we agreed we can star=
t
> from:
>
>   * load-acquire: __atomic_load_n(... memorder=3D__ATOMIC_ACQUIRE);
>   * store-release: __atomic_store_n(... memorder=3D__ATOMIC_RELEASE);

we would need inline asm equivalent too. Similar to kernel
smp_load_acquire() macro.

> Theoretically, the BPF JIT compiler could also reorder instructions just =
like
> Clang or GCC, though it might not currently do so.  If we ever developed =
a more
> optimizing BPF JIT compiler, it would also be nice to have an optimizatio=
n
> barrier for it.  However, Alexei Starovoitov has expressed that defining =
a BPF
> instruction with 'asm volatile ("" ::: "memory");' semantics might be tri=
cky.

It can be a standalone insn that is a compiler barrier only but that feels =
like
a waste of an instruction. So depending how we end up encoding various
real barriers
there may be a bit to spend in such a barrier insn that is only a
compiler barrier.
In this case optimizing JIT barrier.

> II. Implicit barriers can get confusing
> ---------------------------------------
>
> We noticed that, as a bit of a surprise, the __sync_*fetch*() built-ins d=
o not
> always imply a full barrier for BPF on ARM.  For example, when using LLVM=
, the
> frequently-used __sync_fetch_and_add() can either imply "relaxed" (no bar=
rier),
> or "acquire and release" (full barrier) semantics, depending on if its re=
turn
> value is used:
>
> Case (a): return value is used
>
>   SEC("...")
>   int64_t foo;
>
>   int64_t func(...) {
>       return __sync_fetch_and_add(&foo, 1);
>   }
>
> For case (a), Clang gave us:
>
>   3:    db 01 00 00 01 00 00 00 r0 =3D atomic_fetch_add((u64 *)(r1 + 0x0)=
, r0)
>
>   opcode    (0xdb): BPF_STX | BPF_ATOMIC | BPF_DW
>   imm (0x00000001): BPF_ADD | BPF_FETCH
>
> Case (b): return value is ignored
>
>   SEC("...")
>   int64_t foo;
>
>   int64_t func(...) {
>       __sync_fetch_and_add(&foo, 1);
>
>       return foo;
>   }
>
> For case (b), Clang gave us:
>
>   3:    db 12 00 00 00 00 00 00 lock *(u64 *)(r2 + 0x0) +=3D r1
>
>   opcode    (0xdb): BPF_STX | BPF_ATOMIC | BPF_DW
>   imm (0x00000000): BPF_ADD
>
> LLVM decided to drop BPF_FETCH, since the return value of
> __sync_fetch_and_add() is being ignored [2].  Now, if we take a look at
> emit_lse_atomic() in the BPF JIT compiler code for ARM64 (suppose that LS=
E
> atomic instructions are being used):
>
>   case BPF_ADD:
>           emit(A64_STADD(isdw, reg, src), ctx);
>           break;
>   <...>
>   case BPF_ADD | BPF_FETCH:
>           emit(A64_LDADDAL(isdw, src, reg, src), ctx);
>           break;
>
> STADD is an alias for LDADD.  According to [3]:
>
>   * LDADDAL for case (a) has "acquire" plus "release" semantics
>   * LDADD for case (b) "has neither acquire nor release semantics"
>
> This is pretty non-intuitive; a compiler built-in should not have inconsi=
stent
> implications on memory ordering, and it is better not to require all BPF
> programmers to memorize this.
>
> GCC seems a bit ambiguous [4] on whether __sync_*fetch*() built-ins shoul=
d
> always imply a full barrier.  GCC considers these __sync_*() built-ins as
> "legacy", and introduced a new set of __atomic_*() built-ins ("Memory Mod=
el
> Aware Atomic Operations") [5] to replace them.  These __atomic_*() built-=
ins
> are designed to be a lot more explicit on memory ordering, for example:
>
>   type __atomic_fetch_add (type *ptr, type val, int memorder)
>
> This requires the programmer to specify a memory order type (relaxed, acq=
uire,
> release...) via the "memorder" parameter.  Currently in LLVM, for BPF, th=
ose
> __atomic_*fetch*() built-ins seem to be aliases to their __sync_*fetch*()
> counterparts (the "memorder" parameter seems effectively ignored), and ar=
e not
> fully supported.

This sounds like a compiler bug.

Yonghong, Jose,
do you know what compilers do for other backends?
Is it allowed to convert sycn_fetch_add into sync_add when fetch part is un=
used?

> III. Next steps
> ---------------
>
> Roughly, the scope of this work includes:
>
>   * decide how to extend the BPF ISA (add new instructions and/or extend
>     current ones)

ldx/stx insns support MEM and MEMSX modifiers.
Adding MEM_ACQ_REL feels like a natural fit. Better name?

For barriers we would need a new insn. Not sure which class would fit the b=
est.
Maybe BPF_LD ?

Another alternative for barriers is to use nocsr kfuncs.
Then we have the freedom to make mistakes and fix them later.
One kfunc per barrier would do.
JITs would inline them into appropriate insns.
In bpf progs they will be used just like in the kernel code smp_mb(),
smp_rmb(), etc.

I don't think compilers have to emit barriers from C code, so my
preference is kfuncs atm.

>   * teach LLVM and GCC to generate the new/extended instructions
>   * teach the BPF verifier to understand them
>   * teach the BPF JIT compiler to compile them
>   * update BPF memory model and tooling
>   * update IETF specification
>
> Additionally, for the issue described in the previous section, we need to=
:
>
>   * check if GCC has the same behavior
>   * at least clearly document the implied effects on BPF memory ordering =
of
>     current __sync_*fetch*() built-ins (especially for architectures like=
 ARM),
>     as described
>   * fully support the new __atomic_*fetch*() built-ins for BPF to replace=
 the
>     __sync_*fetch*() ones
>
> Any suggestions or corrections would be most welcome!
>
> Thanks,
> Peilin Ye
>
>
> [1] Instruction-Level BPF Memory Model
> https://docs.google.com/document/d/1TaSEfWfLnRUi5KqkavUQyL2tThJXYWHS15qcb=
xIsFb0/edit?usp=3Dsharing
>
> [2] For more information, see LLVM commit 286daafd6512 ("[BPF] support at=
omic
>     instructions").  Search for "LLVM will check the return value" in the
>     commit message.
>
> [3] Arm Architecture Reference Manual for A-profile architecture (ARM DDI
>     0487K.a, ID032224), C6.2.149, page 2006
>
> [4] https://gcc.gnu.org/onlinedocs/gcc/_005f_005fsync-Builtins.html
>     6.58 Legacy __sync Built-in Functions for Atomic Memory Access
>     "In most cases, these built-in functions are considered a full barrie=
r."
>
> [5] https://gcc.gnu.org/onlinedocs/gcc/_005f_005fatomic-Builtins.html
>     6.59 Built-in Functions for Memory Model Aware Atomic Operations
>

