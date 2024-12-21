Return-Path: <bpf+bounces-47492-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 715B79F9DAF
	for <lists+bpf@lfdr.de>; Sat, 21 Dec 2024 02:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E14618977F0
	for <lists+bpf@lfdr.de>; Sat, 21 Dec 2024 01:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1039A1DA3D;
	Sat, 21 Dec 2024 01:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZrmB6mkf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED18A259481
	for <bpf@vger.kernel.org>; Sat, 21 Dec 2024 01:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734744174; cv=none; b=JEiRehKFSo2YPxee9uIN3rBABvMH7S4KcpegnP7SsGDqN1ja246FYoIYsXnuGOZBD3vcw1/3/9+emc8FI3rW+FIyXgmqOL+hP3hVLqTY6PO0aYPtLwDAORUzZCShi73729ydS1bpnb73VmrvbaTRLY4rzh1ULNEeY6f9ePAxkJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734744174; c=relaxed/simple;
	bh=AjMAPTJyJfy3aurgbJ79jInu7h0p50Bg8/5HnbBkfHY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KddU0nSI/7hWLHEoiDUTmuH1QbaJkdU+8inUjownr4IjW3NcbMoyNn+7B3w4yIuAZG9S/kOE2wrIjQ6x2byDXmB7NpmVL3LKszllb5yljoAp3lmmbLDLYPX7+UcafdNzXbaAKpOUA7GqsVU/cIKSOW5JF91TT2VmHORXur/Mq08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZrmB6mkf; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-2a3b2770597so1931855fac.0
        for <bpf@vger.kernel.org>; Fri, 20 Dec 2024 17:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734744172; x=1735348972; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iBaC/VOWE2Wu0XLmvjEVSokBWjrtphrt0OkjvzoO/yI=;
        b=ZrmB6mkf/rnMkm6P09nE1/1rP5TxG6+GAh+q5VQh9PUSxcr0fYPxJOkd5/8k4iCbGL
         WpQztA3Fd5pOxyGlKjXrbFCeYcedLclgxGSLjCIqlS7GoYFfOkd00npIdFNQ04bAiUwF
         OK4uxFFzY66ERxloil+eSPU5FAWuXOGMVvJiCvl7rRe/04RTdTETGow4eZNpdbQUaYiU
         z6bz3x3BeA2ZM67u3KzCfD8qGC8ZRwtZa5ySoLd2JJa0Kq0OzIXWeq9VjEQcQZ3/cSJQ
         c/98b12WwOxdyHNB+jBsOd+7CdIsvgMxznFa6izmy8cEsZG32wIDJJ+JknTlG/5lq7kt
         d42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734744172; x=1735348972;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iBaC/VOWE2Wu0XLmvjEVSokBWjrtphrt0OkjvzoO/yI=;
        b=dDAx6DoArLY9/ijxUQaiJ2jv3oIkdDHZEJblazT8OckedqsS/vH7Nnw84eQNAXNfye
         6KGHH8pPUmKk2C6kdXfwFsBgnRILxVrAcG6SxxEIVuHLdgv9DbD5GXpDdyQkciofvBoE
         0oCUFywFRvcyJ1A/MVqbOAp7HBaHIPKs0P5y9Gfzko8LxyJo0QK9sHlOHVmvIj1vDNK3
         Tm1DUTUmMkoOqj4BR+rayTMuXegs9iy2CEj7rSwQo45Q7WGq/Ao6olZffFxOpHfE1v16
         tj5z703Bu4oRxN5tO0sg9e6wriHRAQcLV0iM6csGd2iNNtKyQ5EzOZgJyMf/BN6IP/bi
         u+XA==
X-Gm-Message-State: AOJu0YxbG6IvOM4bqsxsZsMSyESg3FTBKQSpLvvOHg1BTUFByzXfFdrM
	Qzu5qwzCg+hAxOvZ5rItrdUrxhbi9IsE4iG/4ThE6lA/H4f2v+85uD5vhWEb7DpK9YHdieSRcYD
	2E11VVNbBEWBBzLiVSwYfAuHk0/hl6WCBjeoeWL8EL+3h1z0U4gAxMW81cJtA8iT0c9YQ/LIVCa
	rDssHNZ4QkG8w+Pf3YBRAnBSeszC7JkzDmhTpHIKA=
X-Google-Smtp-Source: AGHT+IH2I23NnWzgwgZwelOD9GXrr0eqPRFQhaNzfMzvKJgQ7f4VLn4ylzizlioMK/a1mRSIVVjokh0uMxkV2Q==
X-Received: from oany18.prod.google.com ([2002:a05:6870:3892:b0:29f:ae3c:aeb8])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6870:65aa:b0:29e:6117:bd45 with SMTP id 586e51a60fabf-2a7fb2ff438mr2846358fac.31.1734744172062;
 Fri, 20 Dec 2024 17:22:52 -0800 (PST)
Date: Sat, 21 Dec 2024 01:22:04 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <cover.1734742802.git.yepeilin@google.com>
Subject: [PATCH RFC bpf-next v1 0/4] Introduce load-acquire and store-release
 BPF instructions
From: Peilin Ye <yepeilin@google.com>
To: bpf@vger.kernel.org
Cc: Peilin Ye <yepeilin@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Xu Kuohai <xukuohai@huaweicloud.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Quentin Monnet <qmo@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
	Shuah Khan <shuah@kernel.org>, Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>, 
	Neel Natu <neelnatu@google.com>, Benjamin Segall <bsegall@google.com>, 
	David Vernet <dvernet@meta.com>, Dave Marchevsky <davemarchevsky@meta.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all!

This RFC patchset adds kernel support for BPF load-acquire and store-release
instructions (for background, please see [1]).  Currently only arm64 is
supported for RFC.  The corresponding LLVM changes can be found at:
  https://github.com/llvm/llvm-project/pull/108636

As discussed on GitHub [2], define both load-acquire and store-release as
BPF_STX | BPF_ATOMIC instructions.  The following new flags are introduced:

  BPF_ATOMIC_LOAD    0x10
  BPF_ATOMIC_STORE   0x20

  BPF_RELAXED        0x0
  BPF_ACQUIRE        0x1
  BPF_RELEASE        0x2
  BPF_ACQ_REL        0x3
  BPF_SEQ_CST        0x4

  BPF_LOAD_ACQ       (BPF_ATOMIC_LOAD | BPF_ACQUIRE)
  BPF_STORE_REL      (BPF_ATOMIC_STORE | BPF_RELEASE)

Bit 4-7 of 'imm' encodes the new atomic operations (load and store), and bit
0-3 specifies the memory order.  A load-acquire is a BPF_STX | BPF_ATOMIC
instruction with 'imm' set to BPF_LOAD_ACQ (0x11).  Similarly, a store-release
is a BPF_STX | BPF_ATOMIC instruction with 'imm' set to BPF_STORE_REL (0x22).

For bit 4-7 of 'imm' we need to avoid conflicts with existing
BPF_STX | BPF_ATOMIC instructions.  Currently the following values (a subset
of BPFArithOp<>) are in use:

  def BPF_ADD  : BPFArithOp<0x0>;
  def BPF_OR   : BPFArithOp<0x4>;
  def BPF_AND  : BPFArithOp<0x5>;
  def BPF_XOR  : BPFArithOp<0xa>;
  def BPF_XCHG    : BPFArithOp<0xe>;
  def BPF_CMPXCHG : BPFArithOp<0xf>;

0x1 and 0x2 were chosen for the new instructions because:

  * BPFArithOp<0x1> is BPF_SUB.  Compilers already handle atomic subtraction
    by generating a BPF NEG followed by a BPF ADD instruction.

  * BPFArithOp<0x2> is BPF_MUL, and we do not have a plan for adding BPF
    atomic multiplication instructions.

So we think by choosing 0x1 and 0x2, we can avoid having conflicts with
BPFArithOp<> in the future.  Previously 0xb was chosen because we will never
need BPF_MOV (BPFArithOp<0xb>) for BPF_ATOMIC.  Please suggest if you think
different values should be used.

Based on [3], the BPF load-acquire, the arm64 JIT compiler generates LDAR
(RCsc) instead of LDAPR (RCpc).  Will Deacon also suggested LDAR over LDAPR in
an offlist conversation for the following reasons:

  a. Not all CPUs support LDAPR, as also pointed out in Paul E. McKenney's
     email (search for "older ARM64 hardware" in [3]).

  b. The extra ordering provided by RCsc is important in some use cases e.g.
     locks.

  c. The arm64 ISA does not provide e.g. other atomic memory operations in
     RCpc.  In other words, it is not worth losing the extra ordering that
     LDAR provides, if we would still be using RCsc for all other cases.

Unlike existing atomic operations that only support BPF_W (32-bit) and
BPF_DW (64-bit) size modifiers, load-acquires and store-releases also
support BPF_B (8-bit) and BPF_H (16-bit).  An 8- or 16-bit load-acquire
zero-extends the value before writing it to a 32-bit register, just like
LDARH and friends.

Examples of using the new instructions (assuming little-endian):

  long foo(long *ptr) {
      return __atomic_load_n(ptr, __ATOMIC_ACQUIRE);
  }

Using clang -mcpu=v4, foo() can be compiled to:

  db 10 00 00 11 00 00 00  r0 = load_acquire((u64 *)(r1 + 0x0))
  95 00 00 00 00 00 00 00  exit

  opcode (0xdb): BPF_ATOMIC | BPF_DW | BPF_STX
  imm (0x00000011): BPF_LOAD_ACQ

For arm64, an LDAR instruction would be generated by the JIT compiler for
the above, e.g.:

  ldar  x7, [x0]

Similarly, consider this 16-bit store-release:

  void bar(short *ptr, short val) {
      __atomic_store_n(ptr, val, __ATOMIC_RELEASE);
  }

bar() can be compiled to (again, using clang -mcpu=v4):

  cb 21 00 00 22 00 00 00  store_release((u16 *)(r1 + 0x0), w2)
  95 00 00 00 00 00 00 00  exit

  opcode (0xcb): BPF_ATOMIC | BPF_H | BPF_STX
  imm (0x00000022): BPF_ATOMIC_STORE | BPF_RELEASE

An STLRH will be generated for it, e.g.:

  stlrh  w1, [x0]

For a complete mapping for ARM64:

  load-acquire     8-bit  LDARB
 (BPF_LOAD_ACQ)   16-bit  LDARH
                  32-bit  LDAR (32-bit)
                  64-bit  LDAR (64-bit)
  store-release    8-bit  STLRB
 (BPF_STORE_REL)  16-bit  STLRH
                  32-bit  STLR (32-bit)
                  64-bit  STLR (64-bit)

Using in arena is supported.  Inline assembly is also supported.  For example:

  asm volatile("%0 = load_acquire((u64 *)(%1 + 0x0))" :
               "=r"(ret) : "r"(ptr) : "memory");

A new pre-defined macro, __BPF_FEATURE_LOAD_ACQ_STORE_REL, can be used to
detect if clang supports BPF load-acquire and store-release.

Please refer to individual kernel patches (and LLVM commits) for details.
Any suggestions or corrections would be much appreciated!

[1] https://lore.kernel.org/all/20240729183246.4110549-1-yepeilin@google.com/
[2] https://github.com/llvm/llvm-project/pull/108636#issuecomment-2389403477
[3] https://lore.kernel.org/bpf/75d1352e-c05e-4fdf-96bf-b1c3daaf41f0@paulmck-laptop/

Thanks,
Peilin Ye (4):
  bpf/verifier: Factor out check_load()
  bpf: Introduce load-acquire and store-release instructions
  selftests/bpf: Delete duplicate verifier/atomic_invalid tests
  selftests/bpf: Add selftests for load-acquire and store-release
    instructions

 arch/arm64/include/asm/insn.h                 |  8 ++
 arch/arm64/lib/insn.c                         | 34 +++++++
 arch/arm64/net/bpf_jit.h                      | 20 +++++
 arch/arm64/net/bpf_jit_comp.c                 | 85 +++++++++++++++++-
 include/linux/filter.h                        |  2 +
 include/uapi/linux/bpf.h                      | 13 +++
 kernel/bpf/core.c                             | 41 ++++++++-
 kernel/bpf/disasm.c                           | 14 +++
 kernel/bpf/verifier.c                         | 88 ++++++++++++-------
 tools/include/uapi/linux/bpf.h                | 13 +++
 .../selftests/bpf/prog_tests/arena_atomics.c  | 61 ++++++++++++-
 .../selftests/bpf/prog_tests/atomics.c        | 57 +++++++++++-
 .../selftests/bpf/progs/arena_atomics.c       | 62 ++++++++++++-
 tools/testing/selftests/bpf/progs/atomics.c   | 62 ++++++++++++-
 .../selftests/bpf/verifier/atomic_invalid.c   | 28 +++---
 .../selftests/bpf/verifier/atomic_load.c      | 71 +++++++++++++++
 .../selftests/bpf/verifier/atomic_store.c     | 70 +++++++++++++++
 17 files changed, 672 insertions(+), 57 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/verifier/atomic_load.c
 create mode 100644 tools/testing/selftests/bpf/verifier/atomic_store.c

-- 
2.47.1.613.gc27f4b7a9f-goog


