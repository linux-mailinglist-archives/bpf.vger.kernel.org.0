Return-Path: <bpf+bounces-35913-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3380793FD62
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 20:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F4C61C2212C
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 18:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4759315F32E;
	Mon, 29 Jul 2024 18:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Znya9fHH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476D41E86F
	for <bpf@vger.kernel.org>; Mon, 29 Jul 2024 18:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722278015; cv=none; b=CF/zMvRClq9j6uWCWBM9Xc6n9BKjO5g4/OGvxx9AvQ2WcFkZG/TGgLCJVjPOi2UP7LRvaPn9IHdrpwFBbejJRC7QXo1l//D5BeWawqa8Z0l5qBD216ft7YB1uNDdIiHpT/mNMvBARyKFWwpOb0sTUg1nuNY9Ae8iXfyk2fqxZRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722278015; c=relaxed/simple;
	bh=5Pt2yk3laILpXegj7FyIR+6V0QbrJFU6Dys4EAObdUY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GgEA64r6pVCL1J6Z53/b5EI4S2ZxyEqoo25XJ7nq/7/ksg+Qth2J7TEP29lfJa7ErLovxJ1fjMTPZhb1FD4VRpKoGdmdMDxnZW2K3EZ8IA+zGKnJjqYUy3UZk+OA4qsYYIR/dH2M6ImdL2hJYP84KuCMboG96qz5YHIeYYbKQaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Znya9fHH; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6643016423fso76432907b3.3
        for <bpf@vger.kernel.org>; Mon, 29 Jul 2024 11:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722278013; x=1722882813; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iHDk1uBjLVt55VXad5yPCXh8DORGRZVk5m/9Sqt5BzY=;
        b=Znya9fHHr7RBIRu2YlvXinIqrvJys1BzPlWDXsZSDuZtJ788I8wajjw9v1ANnsywuq
         dRdrlILZqAOgAm3FvGFhQzNtB+9r0nK8q9yEH8lpz3V2FG72io4/UZDA2DAps6sff90z
         lKlury3K1uRtcH50vY5ltuUM4CIyqNy+iaweBFuaHj411S5GHwjTG2trKvwAtxx1+Tim
         e/PNViDB0paEGMos/YAZSv4hakALmFLyK/vrLPTgybdZaLbjkdeCJixl4BXGDaC9MQMR
         eQ1BhgFQzJuw3P7fNMY1dtNEOuOOoF3eFAjzawkAth+l5KP7L0KQhG2yBa2UFnPC6eDP
         chDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722278013; x=1722882813;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iHDk1uBjLVt55VXad5yPCXh8DORGRZVk5m/9Sqt5BzY=;
        b=hSGqNO3c3ez0IuyvlNNpY3NcdXE2OjqwvuQYladjbohUsXFXglHGW3YMqp4qqRDaUZ
         q5DkaTi8KI5mNHxIkFm4CFx6x9gvJOUsa4OUtLaIvjAJXZADzB/TpS4TZIRxwQ2i2GhR
         /hh03jmrXaRTuXjfOAhq9ALcqGRf7ePo9Nu29cuE8WFm1zxcxHY2OG0wBjlg+wZB+Sk0
         3iIP7q+uNjtIIPxCLOqS3c+3waDcoNNPYWcjlqnU9UN/z43w3ua0BVzzdyzDvmK5CjF7
         fcXm2YE7IIZIgsMi2OIDOxcbTIRGnDzUHytG1dsJgdzgbt6cPE+14j7ddlHPDvmWKqhc
         7hvQ==
X-Gm-Message-State: AOJu0Yw/152HFL+M9vpWy1WbFXDIW7wpjTmnkMDVfIWC9wlliwI9VgPT
	JIuFsI6BVc0lQTiirQXzRRxGqBPawbHU4j1YTodi0e7ZHKTA9HoPIxDdkWSYISebLGOdEtlnQjB
	VFng9ACqNrA4bfG/wyc/q3iytFy6Vl1X8mls/gKI2Mcg+3bNJNV7K85UKIALR2mK51S1MFRcuxS
	YObfxOUE6UOFUbP2BUXbnt5lNCGO8bVL7hI8IV8ts=
X-Google-Smtp-Source: AGHT+IFB+pMc60YSRDi5ioRDlQyG+ypagoDMwcwCcTZ/LDSpoBPvpMjRL7iq6CPtNAXBv1K9OI6ba+YwzlYOjg==
X-Received: from yepeilin.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:266b])
 (user=yepeilin job=sendgmr) by 2002:a05:690c:ece:b0:62f:f535:f2c with SMTP id
 00721157ae682-67a053db18cmr2950907b3.2.1722278013259; Mon, 29 Jul 2024
 11:33:33 -0700 (PDT)
Date: Mon, 29 Jul 2024 18:32:44 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240729183246.4110549-1-yepeilin@google.com>
Subject: Supporting New Memory Barrier Types in BPF
From: Peilin Ye <yepeilin@google.com>
To: bpf@vger.kernel.org
Cc: Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>, Neel Natu <neelnatu@google.com>, 
	Benjamin Segall <bsegall@google.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, David Vernet <dvernet@meta.com>, 
	Dave Marchevsky <davemarchevsky@meta.com>, Peilin Ye <yepeilin@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi list!

As we are looking at running sched_ext-style BPF scheduling on architectures
with a more relaxed memory model (i.e. ARM), we would like to:

  1. have fine-grained control over memory ordering in BPF (instead of
     defaulting to a full barrier), for performance reasons
  2. pay closer attention to if memory barriers are being used correctly in
     BPF

To that end, our main goal here is to support more types of memory barriers in
BPF.  While Paul E. McKenney et al. are working on the formalized BPF memory
model [1], Paul agreed that it makes sense to support some basic types first.
Additionally, we noticed an issue with the __sync_*fetch*() compiler built-ins
related to memory ordering, which will be described in details below.

I. We need more types of BPF memory barriers
--------------------------------------------

Currently, when it comes to BPF memory barriers, our choices are effectively
limited to:

  * compiler barrier: 'asm volatile ("" ::: "memory");'
  * full memory barriers implied by compiler built-ins like
    __sync_val_compare_and_swap()

We need more.  During offline discussion with Paul, we agreed we can start
from:

  * load-acquire: __atomic_load_n(... memorder=__ATOMIC_ACQUIRE);
  * store-release: __atomic_store_n(... memorder=__ATOMIC_RELEASE);

Theoretically, the BPF JIT compiler could also reorder instructions just like
Clang or GCC, though it might not currently do so.  If we ever developed a more
optimizing BPF JIT compiler, it would also be nice to have an optimization
barrier for it.  However, Alexei Starovoitov has expressed that defining a BPF
instruction with 'asm volatile ("" ::: "memory");' semantics might be tricky.

II. Implicit barriers can get confusing
---------------------------------------

We noticed that, as a bit of a surprise, the __sync_*fetch*() built-ins do not
always imply a full barrier for BPF on ARM.  For example, when using LLVM, the
frequently-used __sync_fetch_and_add() can either imply "relaxed" (no barrier),
or "acquire and release" (full barrier) semantics, depending on if its return
value is used:

Case (a): return value is used

  SEC("...")
  int64_t foo;

  int64_t func(...) {
      return __sync_fetch_and_add(&foo, 1);
  }

For case (a), Clang gave us:

  3:	db 01 00 00 01 00 00 00	r0 = atomic_fetch_add((u64 *)(r1 + 0x0), r0)

  opcode    (0xdb): BPF_STX | BPF_ATOMIC | BPF_DW
  imm (0x00000001): BPF_ADD | BPF_FETCH

Case (b): return value is ignored

  SEC("...")
  int64_t foo;

  int64_t func(...) {
      __sync_fetch_and_add(&foo, 1);

      return foo;
  }

For case (b), Clang gave us:

  3:	db 12 00 00 00 00 00 00	lock *(u64 *)(r2 + 0x0) += r1

  opcode    (0xdb): BPF_STX | BPF_ATOMIC | BPF_DW
  imm (0x00000000): BPF_ADD

LLVM decided to drop BPF_FETCH, since the return value of
__sync_fetch_and_add() is being ignored [2].  Now, if we take a look at
emit_lse_atomic() in the BPF JIT compiler code for ARM64 (suppose that LSE
atomic instructions are being used):

  case BPF_ADD:
          emit(A64_STADD(isdw, reg, src), ctx);
          break;
  <...>
  case BPF_ADD | BPF_FETCH:
          emit(A64_LDADDAL(isdw, src, reg, src), ctx);
          break;

STADD is an alias for LDADD.  According to [3]:

  * LDADDAL for case (a) has "acquire" plus "release" semantics
  * LDADD for case (b) "has neither acquire nor release semantics"

This is pretty non-intuitive; a compiler built-in should not have inconsistent
implications on memory ordering, and it is better not to require all BPF
programmers to memorize this.

GCC seems a bit ambiguous [4] on whether __sync_*fetch*() built-ins should
always imply a full barrier.  GCC considers these __sync_*() built-ins as
"legacy", and introduced a new set of __atomic_*() built-ins ("Memory Model
Aware Atomic Operations") [5] to replace them.  These __atomic_*() built-ins
are designed to be a lot more explicit on memory ordering, for example:

  type __atomic_fetch_add (type *ptr, type val, int memorder)

This requires the programmer to specify a memory order type (relaxed, acquire,
release...) via the "memorder" parameter.  Currently in LLVM, for BPF, those
__atomic_*fetch*() built-ins seem to be aliases to their __sync_*fetch*()
counterparts (the "memorder" parameter seems effectively ignored), and are not
fully supported.

III. Next steps
---------------

Roughly, the scope of this work includes:

  * decide how to extend the BPF ISA (add new instructions and/or extend
    current ones)
  * teach LLVM and GCC to generate the new/extended instructions
  * teach the BPF verifier to understand them
  * teach the BPF JIT compiler to compile them
  * update BPF memory model and tooling
  * update IETF specification

Additionally, for the issue described in the previous section, we need to:

  * check if GCC has the same behavior
  * at least clearly document the implied effects on BPF memory ordering of
    current __sync_*fetch*() built-ins (especially for architectures like ARM),
    as described
  * fully support the new __atomic_*fetch*() built-ins for BPF to replace the
    __sync_*fetch*() ones

Any suggestions or corrections would be most welcome!

Thanks,
Peilin Ye


[1] Instruction-Level BPF Memory Model
https://docs.google.com/document/d/1TaSEfWfLnRUi5KqkavUQyL2tThJXYWHS15qcbxIsFb0/edit?usp=sharing

[2] For more information, see LLVM commit 286daafd6512 ("[BPF] support atomic
    instructions").  Search for "LLVM will check the return value" in the
    commit message.

[3] Arm Architecture Reference Manual for A-profile architecture (ARM DDI
    0487K.a, ID032224), C6.2.149, page 2006

[4] https://gcc.gnu.org/onlinedocs/gcc/_005f_005fsync-Builtins.html
    6.58 Legacy __sync Built-in Functions for Atomic Memory Access
    "In most cases, these built-in functions are considered a full barrier."

[5] https://gcc.gnu.org/onlinedocs/gcc/_005f_005fatomic-Builtins.html
    6.59 Built-in Functions for Memory Model Aware Atomic Operations


