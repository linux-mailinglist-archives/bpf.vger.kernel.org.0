Return-Path: <bpf+bounces-68850-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A68B8683E
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 20:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBA631C27132
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 18:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C132D46B3;
	Thu, 18 Sep 2025 18:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gtmTMXBk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5542D94B8
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 18:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758221303; cv=none; b=gnBe2jShHqY/d+xFV4gcApWAFXiBkBmdnzPOGH3zkRXBZdGfODZ5/SQAWRzzfN8TOknFZOo2RzpGitKmPiAzDzd+jlmco0HgmRRvydseJq0l5WzbUvyxkdK1QfWe3jFNmW6Id6Ew85Z8Wt+2rPaazG1d14ERtfu3by+HUOS6w7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758221303; c=relaxed/simple;
	bh=Br9bbYOXnTea77uR4/8twVl1SmPv6cUv23AC245JFa4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kWCuyExt2Ora0Cnb90My3cLGz9vm/vfEgsLAxAKU73rHBwkVmxNT/ORaAehw+b0P9ZIi5yZbwmm/GyRk2EfE6jzfsq4TIhnb5RcQnIwtub4nZe8RUHqx/t3t2JoxJCQTSollVIKN1HjyifsfgqDdue1DGBGTotRrrdFf9AGGsEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gtmTMXBk; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-77e69f69281so7732b3a.1
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 11:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758221295; x=1758826095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5UZpS3DkMYhWEVLv8J2u6CbCvdrtfQZlnobvLyoj1WA=;
        b=gtmTMXBkinVzuIIX7NJ3jXenKgLyyNDFGEOXyK4ACKfPrQGJJZ7S8gsA0GDz/e7MQL
         HSfdca7bgEdHHqEZ9YsGHvhG0tPGHzT4QfaIN5vkoGv9hbKd87aX/pxxs1P4xnDbV9yL
         +6c9kL/Kl+TBlmDyfNvFd9TP/9WZBKlGpDxSMqCLLEZTDHCrJalJEK74nod3Uo2SIXae
         5t9aL7OetB2KyraETCu6sFuAlG+UcFzIeE2SZr1h6jlarHjqFgDeRQXau64vteBlwN2S
         Vcukk8SK5No1ZcFKhj76my8GMppPq6Ak2JOcdgQtidCKLzBzgZl3PykWkVxwa+gfJraR
         OUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758221295; x=1758826095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5UZpS3DkMYhWEVLv8J2u6CbCvdrtfQZlnobvLyoj1WA=;
        b=KVQZOjrUz7ZYbYnG3vnsAFE75nh6sO/Q4H2GIFOKwrcB0m8I1HmYNZMiEyFEDKrvXs
         ggvvnzUaMYXM5XZgJ0RN/284taAQJaNvCk8ue09hwGu6ddZR+LseXIAL/QjnpHRtoCns
         qzSQPsJbNoo5SypvR6w2uKr96LkwgMjKtBx6Qv/ZCE/fNY4wBgaCKdmBpFnpFu9b2/lU
         +0egx0RVhQgx4vonMbVqFkiqeJQvYhGj/aTM0F80UCONsEQcUDkSeCUyRb/oqyGp/+6m
         ABnYCVr6f9C4vvO2FTUt9fOZVDGqY+n34bTegzNICUFR+YNQ78tx5ra/ut5GElEX9cCr
         xHCA==
X-Gm-Message-State: AOJu0YxO8WJLtCIcdb0WJ2CMyrKA0WNFMJloc6hAKuqQMgmbni73uSzz
	RdxQtqmK1P7VnVXDY4S3zgWQN9jeSLwUS1J+80LSNFo09IlSAgJiNVaL9hN5ECUG
X-Gm-Gg: ASbGncv2YZLScASh3qCYNVUbevAgkE72PUdQ0LBucOvRP/nRV0+swepBE36cUnF1MuK
	r+oP80QXp0GIL2Dm6gnzJGg9IsBp8T4JMwTGT9ea/IjdXPTNO26CYddGy9ZxTWIlyXoWU5qqnOw
	IXa/wvLnizem2wYrRH928ecOVVR7HN0JBLj9OwuLMfa4TCC3+1VgAmkwvNbUxzpsQXbhY33CrvH
	f3WeZGRRPfbrrlMYGJCUzb1B2ngAMxC9BTefafme1Sg9NYZSBAbSigcvi+0RpcPTPGoThKuY4fU
	wfn0umEGseFCNp0SRI1FgePYZcofSeDBSzsmllqeQWKEUQDWYSR9iV0f1YNfpbSaq92bibNcgE2
	gXbWXpa+Vu5q8oq5VHPwhfv/Q9pfXSQA60VQ=
X-Google-Smtp-Source: AGHT+IFdowTnqtEKA2XiVDJzpmUVFaZQlq0+0amabPE22CmtngNOEc6Ze2B2h5Rjer8h2a4caD/DxQ==
X-Received: by 2002:a17:902:eccc:b0:24b:270e:56d4 with SMTP id d9443c01a7336-269b755c0a5mr10421305ad.4.1758221292525;
        Thu, 18 Sep 2025 11:48:12 -0700 (PDT)
Received: from honey-badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802e00b3sm32361505ad.90.2025.09.18.11.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 11:48:12 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 09/12] bpf: disable and remove registers chain based liveness
Date: Thu, 18 Sep 2025 11:47:38 -0700
Message-ID: <20250918-callchain-sensitive-liveness-v2-9-214ed2653eee@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250918-callchain-sensitive-liveness-v2-0-214ed2653eee@gmail.com>
References: <20250918-callchain-sensitive-liveness-v2-0-214ed2653eee@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Remove register chain based liveness tracking:
- struct bpf_reg_state->{parent,live} fields are no longer needed;
- REG_LIVE_WRITTEN marks are superseded by bpf_mark_stack_write()
  calls;
- mark_reg_read() calls are superseded by bpf_mark_stack_read();
- log.c:print_liveness() is superseded by logging in liveness.c;
- propagate_liveness() is superseded by bpf_update_live_stack();
- no need to establish register chains in is_state_visited() anymore;
- fix a bunch of tests expecting "_w" suffixes in verifier log
  messages.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 Documentation/bpf/verifier.rst                     | 264 -----------------
 include/linux/bpf_verifier.h                       |  25 --
 kernel/bpf/log.c                                   |  26 +-
 kernel/bpf/verifier.c                              | 315 ++-------------------
 tools/testing/selftests/bpf/prog_tests/align.c     | 178 ++++++------
 tools/testing/selftests/bpf/prog_tests/spin_lock.c |  12 +-
 .../selftests/bpf/prog_tests/test_veristat.c       |  44 +--
 .../selftests/bpf/progs/exceptions_assert.c        |  34 +--
 .../selftests/bpf/progs/iters_state_safety.c       |   4 +-
 .../selftests/bpf/progs/iters_testmod_seq.c        |   6 +-
 .../selftests/bpf/progs/mem_rdonly_untrusted.c     |   4 +-
 .../testing/selftests/bpf/progs/verifier_bounds.c  |  38 +--
 .../selftests/bpf/progs/verifier_global_ptr_args.c |   4 +-
 tools/testing/selftests/bpf/progs/verifier_ldsx.c  |   2 +-
 .../selftests/bpf/progs/verifier_precision.c       |  16 +-
 .../selftests/bpf/progs/verifier_scalar_ids.c      |  10 +-
 .../selftests/bpf/progs/verifier_spill_fill.c      |  40 +--
 .../bpf/progs/verifier_subprog_precision.c         |   6 +-
 tools/testing/selftests/bpf/verifier/bpf_st_mem.c  |   4 +-
 19 files changed, 226 insertions(+), 806 deletions(-)

diff --git a/Documentation/bpf/verifier.rst b/Documentation/bpf/verifier.rst
index 95e6f80a407e52419ef3ecbfc0c346fbeaf926b5..510d15bc697b86bce622ee3d1688b5d11a697644 100644
--- a/Documentation/bpf/verifier.rst
+++ b/Documentation/bpf/verifier.rst
@@ -347,270 +347,6 @@ However, only the value of register ``r1`` is important to successfully finish
 verification. The goal of the liveness tracking algorithm is to spot this fact
 and figure out that both states are actually equivalent.
 
-Data structures
-~~~~~~~~~~~~~~~
-
-Liveness is tracked using the following data structures::
-
-  enum bpf_reg_liveness {
-	REG_LIVE_NONE = 0,
-	REG_LIVE_READ32 = 0x1,
-	REG_LIVE_READ64 = 0x2,
-	REG_LIVE_READ = REG_LIVE_READ32 | REG_LIVE_READ64,
-	REG_LIVE_WRITTEN = 0x4,
-	REG_LIVE_DONE = 0x8,
-  };
-
-  struct bpf_reg_state {
- 	...
-	struct bpf_reg_state *parent;
- 	...
-	enum bpf_reg_liveness live;
- 	...
-  };
-
-  struct bpf_stack_state {
-	struct bpf_reg_state spilled_ptr;
-	...
-  };
-
-  struct bpf_func_state {
-	struct bpf_reg_state regs[MAX_BPF_REG];
-        ...
-	struct bpf_stack_state *stack;
-  }
-
-  struct bpf_verifier_state {
-	struct bpf_func_state *frame[MAX_CALL_FRAMES];
-	struct bpf_verifier_state *parent;
-        ...
-  }
-
-* ``REG_LIVE_NONE`` is an initial value assigned to ``->live`` fields upon new
-  verifier state creation;
-
-* ``REG_LIVE_WRITTEN`` means that the value of the register (or stack slot) is
-  defined by some instruction verified between this verifier state's parent and
-  verifier state itself;
-
-* ``REG_LIVE_READ{32,64}`` means that the value of the register (or stack slot)
-  is read by a some child state of this verifier state;
-
-* ``REG_LIVE_DONE`` is a marker used by ``clean_verifier_state()`` to avoid
-  processing same verifier state multiple times and for some sanity checks;
-
-* ``->live`` field values are formed by combining ``enum bpf_reg_liveness``
-  values using bitwise or.
-
-Register parentage chains
-~~~~~~~~~~~~~~~~~~~~~~~~~
-
-In order to propagate information between parent and child states, a *register
-parentage chain* is established. Each register or stack slot is linked to a
-corresponding register or stack slot in its parent state via a ``->parent``
-pointer. This link is established upon state creation in ``is_state_visited()``
-and might be modified by ``set_callee_state()`` called from
-``__check_func_call()``.
-
-The rules for correspondence between registers / stack slots are as follows:
-
-* For the current stack frame, registers and stack slots of the new state are
-  linked to the registers and stack slots of the parent state with the same
-  indices.
-
-* For the outer stack frames, only callee saved registers (r6-r9) and stack
-  slots are linked to the registers and stack slots of the parent state with the
-  same indices.
-
-* When function call is processed a new ``struct bpf_func_state`` instance is
-  allocated, it encapsulates a new set of registers and stack slots. For this
-  new frame, parent links for r6-r9 and stack slots are set to nil, parent links
-  for r1-r5 are set to match caller r1-r5 parent links.
-
-This could be illustrated by the following diagram (arrows stand for
-``->parent`` pointers)::
-
-      ...                    ; Frame #0, some instructions
-  --- checkpoint #0 ---
-  1 : r6 = 42                ; Frame #0
-  --- checkpoint #1 ---
-  2 : call foo()             ; Frame #0
-      ...                    ; Frame #1, instructions from foo()
-  --- checkpoint #2 ---
-      ...                    ; Frame #1, instructions from foo()
-  --- checkpoint #3 ---
-      exit                   ; Frame #1, return from foo()
-  3 : r1 = r6                ; Frame #0  <- current state
-
-             +-------------------------------+-------------------------------+
-             |           Frame #0            |           Frame #1            |
-  Checkpoint +-------------------------------+-------------------------------+
-  #0         | r0 | r1-r5 | r6-r9 | fp-8 ... |
-             +-------------------------------+
-                ^    ^       ^       ^
-                |    |       |       |
-  Checkpoint +-------------------------------+
-  #1         | r0 | r1-r5 | r6-r9 | fp-8 ... |
-             +-------------------------------+
-                     ^       ^       ^
-                     |_______|_______|_______________
-                             |       |               |
-               nil  nil      |       |               |      nil     nil
-                |    |       |       |               |       |       |
-  Checkpoint +-------------------------------+-------------------------------+
-  #2         | r0 | r1-r5 | r6-r9 | fp-8 ... | r0 | r1-r5 | r6-r9 | fp-8 ... |
-             +-------------------------------+-------------------------------+
-                             ^       ^               ^       ^       ^
-               nil  nil      |       |               |       |       |
-                |    |       |       |               |       |       |
-  Checkpoint +-------------------------------+-------------------------------+
-  #3         | r0 | r1-r5 | r6-r9 | fp-8 ... | r0 | r1-r5 | r6-r9 | fp-8 ... |
-             +-------------------------------+-------------------------------+
-                             ^       ^
-               nil  nil      |       |
-                |    |       |       |
-  Current    +-------------------------------+
-  state      | r0 | r1-r5 | r6-r9 | fp-8 ... |
-             +-------------------------------+
-                             \
-                               r6 read mark is propagated via these links
-                               all the way up to checkpoint #1.
-                               The checkpoint #1 contains a write mark for r6
-                               because of instruction (1), thus read propagation
-                               does not reach checkpoint #0 (see section below).
-
-Liveness marks tracking
-~~~~~~~~~~~~~~~~~~~~~~~
-
-For each processed instruction, the verifier tracks read and written registers
-and stack slots. The main idea of the algorithm is that read marks propagate
-back along the state parentage chain until they hit a write mark, which 'screens
-off' earlier states from the read. The information about reads is propagated by
-function ``mark_reg_read()`` which could be summarized as follows::
-
-  mark_reg_read(struct bpf_reg_state *state, ...):
-      parent = state->parent
-      while parent:
-          if state->live & REG_LIVE_WRITTEN:
-              break
-          if parent->live & REG_LIVE_READ64:
-              break
-          parent->live |= REG_LIVE_READ64
-          state = parent
-          parent = state->parent
-
-Notes:
-
-* The read marks are applied to the **parent** state while write marks are
-  applied to the **current** state. The write mark on a register or stack slot
-  means that it is updated by some instruction in the straight-line code leading
-  from the parent state to the current state.
-
-* Details about REG_LIVE_READ32 are omitted.
-
-* Function ``propagate_liveness()`` (see section :ref:`read_marks_for_cache_hits`)
-  might override the first parent link. Please refer to the comments in the
-  ``propagate_liveness()`` and ``mark_reg_read()`` source code for further
-  details.
-
-Because stack writes could have different sizes ``REG_LIVE_WRITTEN`` marks are
-applied conservatively: stack slots are marked as written only if write size
-corresponds to the size of the register, e.g. see function ``save_register_state()``.
-
-Consider the following example::
-
-  0: (*u64)(r10 - 8) = 0   ; define 8 bytes of fp-8
-  --- checkpoint #0 ---
-  1: (*u32)(r10 - 8) = 1   ; redefine lower 4 bytes
-  2: r1 = (*u32)(r10 - 8)  ; read lower 4 bytes defined at (1)
-  3: r2 = (*u32)(r10 - 4)  ; read upper 4 bytes defined at (0)
-
-As stated above, the write at (1) does not count as ``REG_LIVE_WRITTEN``. Should
-it be otherwise, the algorithm above wouldn't be able to propagate the read mark
-from (3) to checkpoint #0.
-
-Once the ``BPF_EXIT`` instruction is reached ``update_branch_counts()`` is
-called to update the ``->branches`` counter for each verifier state in a chain
-of parent verifier states. When the ``->branches`` counter reaches zero the
-verifier state becomes a valid entry in a set of cached verifier states.
-
-Each entry of the verifier states cache is post-processed by a function
-``clean_live_states()``. This function marks all registers and stack slots
-without ``REG_LIVE_READ{32,64}`` marks as ``NOT_INIT`` or ``STACK_INVALID``.
-Registers/stack slots marked in this way are ignored in function ``stacksafe()``
-called from ``states_equal()`` when a state cache entry is considered for
-equivalence with a current state.
-
-Now it is possible to explain how the example from the beginning of the section
-works::
-
-  0: call bpf_get_prandom_u32()
-  1: r1 = 0
-  2: if r0 == 0 goto +1
-  3: r0 = 1
-  --- checkpoint[0] ---
-  4: r0 = r1
-  5: exit
-
-* At instruction #2 branching point is reached and state ``{ r0 == 0, r1 == 0, pc == 4 }``
-  is pushed to states processing queue (pc stands for program counter).
-
-* At instruction #4:
-
-  * ``checkpoint[0]`` states cache entry is created: ``{ r0 == 1, r1 == 0, pc == 4 }``;
-  * ``checkpoint[0].r0`` is marked as written;
-  * ``checkpoint[0].r1`` is marked as read;
-
-* At instruction #5 exit is reached and ``checkpoint[0]`` can now be processed
-  by ``clean_live_states()``. After this processing ``checkpoint[0].r1`` has a
-  read mark and all other registers and stack slots are marked as ``NOT_INIT``
-  or ``STACK_INVALID``
-
-* The state ``{ r0 == 0, r1 == 0, pc == 4 }`` is popped from the states queue
-  and is compared against a cached state ``{ r1 == 0, pc == 4 }``, the states
-  are considered equivalent.
-
-.. _read_marks_for_cache_hits:
-
-Read marks propagation for cache hits
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-Another point is the handling of read marks when a previously verified state is
-found in the states cache. Upon cache hit verifier must behave in the same way
-as if the current state was verified to the program exit. This means that all
-read marks, present on registers and stack slots of the cached state, must be
-propagated over the parentage chain of the current state. Example below shows
-why this is important. Function ``propagate_liveness()`` handles this case.
-
-Consider the following state parentage chain (S is a starting state, A-E are
-derived states, -> arrows show which state is derived from which)::
-
-                   r1 read
-            <-------------                A[r1] == 0
-                                          C[r1] == 0
-      S ---> A ---> B ---> exit           E[r1] == 1
-      |
-      ` ---> C ---> D
-      |
-      ` ---> E      ^
-                    |___   suppose all these
-             ^           states are at insn #Y
-             |
-      suppose all these
-    states are at insn #X
-
-* Chain of states ``S -> A -> B -> exit`` is verified first.
-
-* While ``B -> exit`` is verified, register ``r1`` is read and this read mark is
-  propagated up to state ``A``.
-
-* When chain of states ``C -> D`` is verified the state ``D`` turns out to be
-  equivalent to state ``B``.
-
-* The read mark for ``r1`` has to be propagated to state ``C``, otherwise state
-  ``C`` might get mistakenly marked as equivalent to state ``E`` even though
-  values for register ``r1`` differ between ``C`` and ``E``.
-
 Understanding eBPF verifier messages
 ====================================
 
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index dec5da3a2e59dc22ef3cb60407f82267cf5a2c61..c7515da8500c56d9e6152657a00eb4fd76477856 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -26,27 +26,6 @@
 /* Patch buffer size */
 #define INSN_BUF_SIZE 32
 
-/* Liveness marks, used for registers and spilled-regs (in stack slots).
- * Read marks propagate upwards until they find a write mark; they record that
- * "one of this state's descendants read this reg" (and therefore the reg is
- * relevant for states_equal() checks).
- * Write marks collect downwards and do not propagate; they record that "the
- * straight-line code that reached this state (from its parent) wrote this reg"
- * (and therefore that reads propagated from this state or its descendants
- * should not propagate to its parent).
- * A state with a write mark can receive read marks; it just won't propagate
- * them to its parent, since the write mark is a property, not of the state,
- * but of the link between it and its parent.  See mark_reg_read() and
- * mark_stack_slot_read() in kernel/bpf/verifier.c.
- */
-enum bpf_reg_liveness {
-	REG_LIVE_NONE = 0, /* reg hasn't been read or written this branch */
-	REG_LIVE_READ32 = 0x1, /* reg was read, so we're sensitive to initial value */
-	REG_LIVE_READ64 = 0x2, /* likewise, but full 64-bit content matters */
-	REG_LIVE_READ = REG_LIVE_READ32 | REG_LIVE_READ64,
-	REG_LIVE_WRITTEN = 0x4, /* reg was written first, screening off later reads */
-};
-
 #define ITER_PREFIX "bpf_iter_"
 
 enum bpf_iter_state {
@@ -211,8 +190,6 @@ struct bpf_reg_state {
 	 * allowed and has the same effect as bpf_sk_release(sk).
 	 */
 	u32 ref_obj_id;
-	/* parentage chain for liveness checking */
-	struct bpf_reg_state *parent;
 	/* Inside the callee two registers can be both PTR_TO_STACK like
 	 * R1=fp-8 and R2=fp-8, but one of them points to this function stack
 	 * while another to the caller's stack. To differentiate them 'frameno'
@@ -225,7 +202,6 @@ struct bpf_reg_state {
 	 * patching which only happens after main verification finished.
 	 */
 	s32 subreg_def;
-	enum bpf_reg_liveness live;
 	/* if (!precise && SCALAR_VALUE) min/max/tnum don't affect safety */
 	bool precise;
 };
@@ -852,7 +828,6 @@ struct bpf_verifier_env {
 	/* array of pointers to bpf_scc_info indexed by SCC id */
 	struct bpf_scc_info **scc_info;
 	u32 scc_cnt;
-	bool internal_error;
 };
 
 static inline struct bpf_func_info_aux *subprog_aux(struct bpf_verifier_env *env, int subprog)
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 0d6d7bfb2fd05e3870c4741f657257187158fff6..f50533169cc34ed5410b5c5a658d5778dd958b75 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -542,17 +542,6 @@ static char slot_type_char[] = {
 	[STACK_IRQ_FLAG] = 'f'
 };
 
-static void print_liveness(struct bpf_verifier_env *env,
-			   enum bpf_reg_liveness live)
-{
-	if (live & (REG_LIVE_READ | REG_LIVE_WRITTEN))
-		verbose(env, "_");
-	if (live & REG_LIVE_READ)
-		verbose(env, "r");
-	if (live & REG_LIVE_WRITTEN)
-		verbose(env, "w");
-}
-
 #define UNUM_MAX_DECIMAL U16_MAX
 #define SNUM_MAX_DECIMAL S16_MAX
 #define SNUM_MIN_DECIMAL S16_MIN
@@ -770,7 +759,6 @@ void print_verifier_state(struct bpf_verifier_env *env, const struct bpf_verifie
 		if (!print_all && !reg_scratched(env, i))
 			continue;
 		verbose(env, " R%d", i);
-		print_liveness(env, reg->live);
 		verbose(env, "=");
 		print_reg_state(env, state, reg);
 	}
@@ -803,9 +791,7 @@ void print_verifier_state(struct bpf_verifier_env *env, const struct bpf_verifie
 					break;
 			types_buf[j] = '\0';
 
-			verbose(env, " fp%d", (-i - 1) * BPF_REG_SIZE);
-			print_liveness(env, reg->live);
-			verbose(env, "=%s", types_buf);
+			verbose(env, " fp%d=%s", (-i - 1) * BPF_REG_SIZE, types_buf);
 			print_reg_state(env, state, reg);
 			break;
 		case STACK_DYNPTR:
@@ -814,7 +800,6 @@ void print_verifier_state(struct bpf_verifier_env *env, const struct bpf_verifie
 			reg = &state->stack[i].spilled_ptr;
 
 			verbose(env, " fp%d", (-i - 1) * BPF_REG_SIZE);
-			print_liveness(env, reg->live);
 			verbose(env, "=dynptr_%s(", dynptr_type_str(reg->dynptr.type));
 			if (reg->id)
 				verbose_a("id=%d", reg->id);
@@ -829,9 +814,8 @@ void print_verifier_state(struct bpf_verifier_env *env, const struct bpf_verifie
 			if (!reg->ref_obj_id)
 				continue;
 
-			verbose(env, " fp%d", (-i - 1) * BPF_REG_SIZE);
-			print_liveness(env, reg->live);
-			verbose(env, "=iter_%s(ref_id=%d,state=%s,depth=%u)",
+			verbose(env, " fp%d=iter_%s(ref_id=%d,state=%s,depth=%u)",
+				(-i - 1) * BPF_REG_SIZE,
 				iter_type_str(reg->iter.btf, reg->iter.btf_id),
 				reg->ref_obj_id, iter_state_str(reg->iter.state),
 				reg->iter.depth);
@@ -839,9 +823,7 @@ void print_verifier_state(struct bpf_verifier_env *env, const struct bpf_verifie
 		case STACK_MISC:
 		case STACK_ZERO:
 		default:
-			verbose(env, " fp%d", (-i - 1) * BPF_REG_SIZE);
-			print_liveness(env, reg->live);
-			verbose(env, "=%s", types_buf);
+			verbose(env, " fp%d=%s", (-i - 1) * BPF_REG_SIZE, types_buf);
 			break;
 		}
 	}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6b327cd25b1afcc25453bcd15a0f347658b93fcc..933f59166f4381bf9fb2bfdea5793c64c1d5638e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -787,8 +787,6 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
 		state->stack[spi - 1].spilled_ptr.ref_obj_id = id;
 	}
 
-	state->stack[spi].spilled_ptr.live |= REG_LIVE_WRITTEN;
-	state->stack[spi - 1].spilled_ptr.live |= REG_LIVE_WRITTEN;
 	bpf_mark_stack_write(env, state->frameno, BIT(spi - 1) | BIT(spi));
 
 	return 0;
@@ -806,29 +804,6 @@ static void invalidate_dynptr(struct bpf_verifier_env *env, struct bpf_func_stat
 	__mark_reg_not_init(env, &state->stack[spi].spilled_ptr);
 	__mark_reg_not_init(env, &state->stack[spi - 1].spilled_ptr);
 
-	/* Why do we need to set REG_LIVE_WRITTEN for STACK_INVALID slot?
-	 *
-	 * While we don't allow reading STACK_INVALID, it is still possible to
-	 * do <8 byte writes marking some but not all slots as STACK_MISC. Then,
-	 * helpers or insns can do partial read of that part without failing,
-	 * but check_stack_range_initialized, check_stack_read_var_off, and
-	 * check_stack_read_fixed_off will do mark_reg_read for all 8-bytes of
-	 * the slot conservatively. Hence we need to prevent those liveness
-	 * marking walks.
-	 *
-	 * This was not a problem before because STACK_INVALID is only set by
-	 * default (where the default reg state has its reg->parent as NULL), or
-	 * in clean_live_states after REG_LIVE_DONE (at which point
-	 * mark_reg_read won't walk reg->parent chain), but not randomly during
-	 * verifier state exploration (like we did above). Hence, for our case
-	 * parentage chain will still be live (i.e. reg->parent may be
-	 * non-NULL), while earlier reg->parent was NULL, so we need
-	 * REG_LIVE_WRITTEN to screen off read marker propagation when it is
-	 * done later on reads or by mark_dynptr_read as well to unnecessary
-	 * mark registers in verifier state.
-	 */
-	state->stack[spi].spilled_ptr.live |= REG_LIVE_WRITTEN;
-	state->stack[spi - 1].spilled_ptr.live |= REG_LIVE_WRITTEN;
 	bpf_mark_stack_write(env, state->frameno, BIT(spi - 1) | BIT(spi));
 }
 
@@ -938,9 +913,6 @@ static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
 	__mark_reg_not_init(env, &state->stack[spi].spilled_ptr);
 	__mark_reg_not_init(env, &state->stack[spi - 1].spilled_ptr);
 
-	/* Same reason as unmark_stack_slots_dynptr above */
-	state->stack[spi].spilled_ptr.live |= REG_LIVE_WRITTEN;
-	state->stack[spi - 1].spilled_ptr.live |= REG_LIVE_WRITTEN;
 	bpf_mark_stack_write(env, state->frameno, BIT(spi - 1) | BIT(spi));
 
 	return 0;
@@ -1059,7 +1031,6 @@ static int mark_stack_slots_iter(struct bpf_verifier_env *env,
 			else
 				st->type |= PTR_UNTRUSTED;
 		}
-		st->live |= REG_LIVE_WRITTEN;
 		st->ref_obj_id = i == 0 ? id : 0;
 		st->iter.btf = btf;
 		st->iter.btf_id = btf_id;
@@ -1095,9 +1066,6 @@ static int unmark_stack_slots_iter(struct bpf_verifier_env *env,
 
 		__mark_reg_not_init(env, st);
 
-		/* see unmark_stack_slots_dynptr() for why we need to set REG_LIVE_WRITTEN */
-		st->live |= REG_LIVE_WRITTEN;
-
 		for (j = 0; j < BPF_REG_SIZE; j++)
 			slot->slot_type[j] = STACK_INVALID;
 
@@ -1194,7 +1162,6 @@ static int mark_stack_slot_irq_flag(struct bpf_verifier_env *env,
 	bpf_mark_stack_write(env, reg->frameno, BIT(spi));
 	__mark_reg_known_zero(st);
 	st->type = PTR_TO_STACK; /* we don't have dedicated reg type */
-	st->live |= REG_LIVE_WRITTEN;
 	st->ref_obj_id = id;
 	st->irq.kfunc_class = kfunc_class;
 
@@ -1248,8 +1215,6 @@ static int unmark_stack_slot_irq_flag(struct bpf_verifier_env *env, struct bpf_r
 
 	__mark_reg_not_init(env, st);
 
-	/* see unmark_stack_slots_dynptr() for why we need to set REG_LIVE_WRITTEN */
-	st->live |= REG_LIVE_WRITTEN;
 	bpf_mark_stack_write(env, reg->frameno, BIT(spi));
 
 	for (i = 0; i < BPF_REG_SIZE; i++)
@@ -2886,8 +2851,6 @@ static void init_reg_state(struct bpf_verifier_env *env,
 
 	for (i = 0; i < MAX_BPF_REG; i++) {
 		mark_reg_not_init(env, regs, i);
-		regs[i].live = REG_LIVE_NONE;
-		regs[i].parent = NULL;
 		regs[i].subreg_def = DEF_NOT_SUBREG;
 	}
 
@@ -3568,64 +3531,12 @@ static int check_subprogs(struct bpf_verifier_env *env)
 	return 0;
 }
 
-/* Parentage chain of this register (or stack slot) should take care of all
- * issues like callee-saved registers, stack slot allocation time, etc.
- */
-static int mark_reg_read(struct bpf_verifier_env *env,
-			 const struct bpf_reg_state *state,
-			 struct bpf_reg_state *parent, u8 flag)
-{
-	bool writes = parent == state->parent; /* Observe write marks */
-	int cnt = 0;
-
-	while (parent) {
-		/* if read wasn't screened by an earlier write ... */
-		if (writes && state->live & REG_LIVE_WRITTEN)
-			break;
-		/* The first condition is more likely to be true than the
-		 * second, checked it first.
-		 */
-		if ((parent->live & REG_LIVE_READ) == flag ||
-		    parent->live & REG_LIVE_READ64)
-			/* The parentage chain never changes and
-			 * this parent was already marked as LIVE_READ.
-			 * There is no need to keep walking the chain again and
-			 * keep re-marking all parents as LIVE_READ.
-			 * This case happens when the same register is read
-			 * multiple times without writes into it in-between.
-			 * Also, if parent has the stronger REG_LIVE_READ64 set,
-			 * then no need to set the weak REG_LIVE_READ32.
-			 */
-			break;
-		/* ... then we depend on parent's value */
-		parent->live |= flag;
-		/* REG_LIVE_READ64 overrides REG_LIVE_READ32. */
-		if (flag == REG_LIVE_READ64)
-			parent->live &= ~REG_LIVE_READ32;
-		state = parent;
-		parent = state->parent;
-		writes = true;
-		cnt++;
-	}
-
-	if (env->longest_mark_read_walk < cnt)
-		env->longest_mark_read_walk = cnt;
-	return 0;
-}
-
 static int mark_stack_slot_obj_read(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 				    int spi, int nr_slots)
 {
-	struct bpf_func_state *state = func(env, reg);
 	int err, i;
 
 	for (i = 0; i < nr_slots; i++) {
-		struct bpf_reg_state *st = &state->stack[spi - i].spilled_ptr;
-
-		err = mark_reg_read(env, st, st->parent, REG_LIVE_READ64);
-		if (err)
-			return err;
-
 		err = bpf_mark_stack_read(env, reg->frameno, env->insn_idx, BIT(spi - i));
 		if (err)
 			return err;
@@ -3837,15 +3748,13 @@ static int __check_reg_arg(struct bpf_verifier_env *env, struct bpf_reg_state *r
 		if (rw64)
 			mark_insn_zext(env, reg);
 
-		return mark_reg_read(env, reg, reg->parent,
-				     rw64 ? REG_LIVE_READ64 : REG_LIVE_READ32);
+		return 0;
 	} else {
 		/* check whether register used as dest operand can be written to */
 		if (regno == BPF_REG_FP) {
 			verbose(env, "frame pointer is read only\n");
 			return -EACCES;
 		}
-		reg->live |= REG_LIVE_WRITTEN;
 		reg->subreg_def = rw64 ? DEF_NOT_SUBREG : env->insn_idx + 1;
 		if (t == DST_OP)
 			mark_reg_unknown(env, regs, regno);
@@ -5050,12 +4959,7 @@ static void assign_scalar_id_before_mov(struct bpf_verifier_env *env,
 /* Copy src state preserving dst->parent and dst->live fields */
 static void copy_register_state(struct bpf_reg_state *dst, const struct bpf_reg_state *src)
 {
-	struct bpf_reg_state *parent = dst->parent;
-	enum bpf_reg_liveness live = dst->live;
-
 	*dst = *src;
-	dst->parent = parent;
-	dst->live = live;
 }
 
 static void save_register_state(struct bpf_verifier_env *env,
@@ -5066,8 +4970,6 @@ static void save_register_state(struct bpf_verifier_env *env,
 	int i;
 
 	copy_register_state(&state->stack[spi].spilled_ptr, reg);
-	if (size == BPF_REG_SIZE)
-		state->stack[spi].spilled_ptr.live |= REG_LIVE_WRITTEN;
 
 	for (i = BPF_REG_SIZE; i > BPF_REG_SIZE - size; i--)
 		state->stack[spi].slot_type[i - 1] = STACK_SPILL;
@@ -5216,17 +5118,6 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 			for (i = 0; i < BPF_REG_SIZE; i++)
 				scrub_spilled_slot(&state->stack[spi].slot_type[i]);
 
-		/* only mark the slot as written if all 8 bytes were written
-		 * otherwise read propagation may incorrectly stop too soon
-		 * when stack slots are partially written.
-		 * This heuristic means that read propagation will be
-		 * conservative, since it will add reg_live_read marks
-		 * to stack slots all the way to first state when programs
-		 * writes+reads less than 8 bytes
-		 */
-		if (size == BPF_REG_SIZE)
-			state->stack[spi].spilled_ptr.live |= REG_LIVE_WRITTEN;
-
 		/* when we zero initialize stack slots mark them as such */
 		if ((reg && register_is_null(reg)) ||
 		    (!reg && is_bpf_st_mem(insn) && insn->imm == 0)) {
@@ -5419,7 +5310,6 @@ static void mark_reg_stack_read(struct bpf_verifier_env *env,
 		/* have read misc data from the stack */
 		mark_reg_unknown(env, state->regs, dst_regno);
 	}
-	state->regs[dst_regno].live |= REG_LIVE_WRITTEN;
 }
 
 /* Read the stack at 'off' and put the results into the register indicated by
@@ -5466,7 +5356,6 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 				return -EACCES;
 			}
 
-			mark_reg_read(env, reg, reg->parent, REG_LIVE_READ64);
 			if (dst_regno < 0)
 				return 0;
 
@@ -5520,7 +5409,6 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 					insn_flags = 0; /* not restoring original register state */
 				}
 			}
-			state->regs[dst_regno].live |= REG_LIVE_WRITTEN;
 		} else if (dst_regno >= 0) {
 			/* restore register state from stack */
 			copy_register_state(&state->regs[dst_regno], reg);
@@ -5528,7 +5416,6 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 			 * has its liveness marks cleared by is_state_visited()
 			 * which resets stack/reg liveness for state transitions
 			 */
-			state->regs[dst_regno].live |= REG_LIVE_WRITTEN;
 		} else if (__is_pointer_value(env->allow_ptr_leaks, reg)) {
 			/* If dst_regno==-1, the caller is asking us whether
 			 * it is acceptable to use this value as a SCALAR_VALUE
@@ -5540,7 +5427,6 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 				off);
 			return -EACCES;
 		}
-		mark_reg_read(env, reg, reg->parent, REG_LIVE_READ64);
 	} else {
 		for (i = 0; i < size; i++) {
 			type = stype[(slot - i) % BPF_REG_SIZE];
@@ -5554,7 +5440,6 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 				off, i, size);
 			return -EACCES;
 		}
-		mark_reg_read(env, reg, reg->parent, REG_LIVE_READ64);
 		if (dst_regno >= 0)
 			mark_reg_stack_read(env, reg_state, off, off + size, dst_regno);
 		insn_flags = 0; /* we are not restoring spilled register */
@@ -8182,13 +8067,10 @@ static int check_stack_range_initialized(
 		/* reading any byte out of 8-byte 'spill_slot' will cause
 		 * the whole slot to be marked as 'read'
 		 */
-		mark_reg_read(env, &state->stack[spi].spilled_ptr,
-			      state->stack[spi].spilled_ptr.parent,
-			      REG_LIVE_READ64);
 		err = bpf_mark_stack_read(env, reg->frameno, env->insn_idx, BIT(spi));
 		if (err)
 			return err;
-		/* We do not set REG_LIVE_WRITTEN for stack slot, as we can not
+		/* We do not call bpf_mark_stack_write(), as we can not
 		 * be sure that whether stack slot is written to or not. Hence,
 		 * we must still conservatively propagate reads upwards even if
 		 * helper may write to the entire memory range.
@@ -11026,8 +10908,7 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 		}
 
 		/* we are going to rely on register's precise value */
-		err = mark_reg_read(env, r0, r0->parent, REG_LIVE_READ64);
-		err = err ?: mark_chain_precision(env, BPF_REG_0);
+		err = mark_chain_precision(env, BPF_REG_0);
 		if (err)
 			return err;
 
@@ -11931,17 +11812,11 @@ static void __mark_btf_func_reg_size(struct bpf_verifier_env *env, struct bpf_re
 
 	if (regno == BPF_REG_0) {
 		/* Function return value */
-		reg->live |= REG_LIVE_WRITTEN;
 		reg->subreg_def = reg_size == sizeof(u64) ?
 			DEF_NOT_SUBREG : env->insn_idx + 1;
-	} else {
+	} else if (reg_size == sizeof(u64)) {
 		/* Function argument */
-		if (reg_size == sizeof(u64)) {
-			mark_insn_zext(env, reg);
-			mark_reg_read(env, reg, reg->parent, REG_LIVE_READ64);
-		} else {
-			mark_reg_read(env, reg, reg->parent, REG_LIVE_READ32);
-		}
+		mark_insn_zext(env, reg);
 	}
 }
 
@@ -15685,7 +15560,6 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 					 */
 					assign_scalar_id_before_mov(env, src_reg);
 					copy_register_state(dst_reg, src_reg);
-					dst_reg->live |= REG_LIVE_WRITTEN;
 					dst_reg->subreg_def = DEF_NOT_SUBREG;
 				} else {
 					/* case: R1 = (s8, s16 s32)R2 */
@@ -15704,7 +15578,6 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 						if (!no_sext)
 							dst_reg->id = 0;
 						coerce_reg_to_size_sx(dst_reg, insn->off >> 3);
-						dst_reg->live |= REG_LIVE_WRITTEN;
 						dst_reg->subreg_def = DEF_NOT_SUBREG;
 					} else {
 						mark_reg_unknown(env, regs, insn->dst_reg);
@@ -15730,7 +15603,6 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 						 */
 						if (!is_src_reg_u32)
 							dst_reg->id = 0;
-						dst_reg->live |= REG_LIVE_WRITTEN;
 						dst_reg->subreg_def = env->insn_idx + 1;
 					} else {
 						/* case: W1 = (s8, s16)W2 */
@@ -15741,7 +15613,6 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 						copy_register_state(dst_reg, src_reg);
 						if (!no_sext)
 							dst_reg->id = 0;
-						dst_reg->live |= REG_LIVE_WRITTEN;
 						dst_reg->subreg_def = env->insn_idx + 1;
 						coerce_subreg_to_size_sx(dst_reg, insn->off >> 3);
 					}
@@ -18551,11 +18422,6 @@ static void clean_func_state(struct bpf_verifier_env *env,
 
 	for (i = 0; i < st->allocated_stack / BPF_REG_SIZE; i++) {
 		if (!bpf_stack_slot_alive(env, st->frameno, i)) {
-			if (st->stack[i].spilled_ptr.live & REG_LIVE_READ) {
-				verifier_bug(env, "incorrect live marks #1 for insn %d frameno %d spi %d\n",
-					     env->insn_idx, st->frameno, i);
-				env->internal_error = true;
-			}
 			__mark_reg_not_init(env, &st->stack[i].spilled_ptr);
 			for (j = 0; j < BPF_REG_SIZE; j++)
 				st->stack[i].slot_type[j] = STACK_INVALID;
@@ -18584,25 +18450,23 @@ static void clean_verifier_state(struct bpf_verifier_env *env,
  * but a lot of states will get revised from liveness point of view when
  * the verifier explores other branches.
  * Example:
- * 1: r0 = 1
+ * 1: *(u64)(r10 - 8) = 1
  * 2: if r1 == 100 goto pc+1
- * 3: r0 = 2
- * 4: exit
- * when the verifier reaches exit insn the register r0 in the state list of
- * insn 2 will be seen as !REG_LIVE_READ. Then the verifier pops the other_branch
- * of insn 2 and goes exploring further. At the insn 4 it will walk the
- * parentage chain from insn 4 into insn 2 and will mark r0 as REG_LIVE_READ.
+ * 3: *(u64)(r10 - 8) = 2
+ * 4: r0 = *(u64)(r10 - 8)
+ * 5: exit
+ * when the verifier reaches exit insn the stack slot -8 in the state list of
+ * insn 2 is not yet marked alive. Then the verifier pops the other_branch
+ * of insn 2 and goes exploring further. After the insn 4 read, liveness
+ * analysis would propagate read mark for -8 at insn 2.
  *
  * Since the verifier pushes the branch states as it sees them while exploring
  * the program the condition of walking the branch instruction for the second
  * time means that all states below this branch were already explored and
  * their final liveness marks are already propagated.
  * Hence when the verifier completes the search of state list in is_state_visited()
- * we can call this clean_live_states() function to mark all liveness states
- * as st->cleaned to indicate that 'parent' pointers of 'struct bpf_reg_state'
- * will not be used.
- * This function also clears the registers and stack for states that !READ
- * to simplify state merging.
+ * we can call this clean_live_states() function to clear dead the registers and stack
+ * slots to simplify state merging.
  *
  * Important note here that walking the same branch instruction in the callee
  * doesn't meant that the states are DONE. The verifier has to compare
@@ -18777,7 +18641,6 @@ static struct bpf_reg_state unbound_reg;
 static __init int unbound_reg_init(void)
 {
 	__mark_reg_unknown_imprecise(&unbound_reg);
-	unbound_reg.live |= REG_LIVE_READ;
 	return 0;
 }
 late_initcall(unbound_reg_init);
@@ -19072,91 +18935,6 @@ static bool states_equal(struct bpf_verifier_env *env,
 	return true;
 }
 
-/* Return 0 if no propagation happened. Return negative error code if error
- * happened. Otherwise, return the propagated bit.
- */
-static int propagate_liveness_reg(struct bpf_verifier_env *env,
-				  struct bpf_reg_state *reg,
-				  struct bpf_reg_state *parent_reg)
-{
-	u8 parent_flag = parent_reg->live & REG_LIVE_READ;
-	u8 flag = reg->live & REG_LIVE_READ;
-	int err;
-
-	/* When comes here, read flags of PARENT_REG or REG could be any of
-	 * REG_LIVE_READ64, REG_LIVE_READ32, REG_LIVE_NONE. There is no need
-	 * of propagation if PARENT_REG has strongest REG_LIVE_READ64.
-	 */
-	if (parent_flag == REG_LIVE_READ64 ||
-	    /* Or if there is no read flag from REG. */
-	    !flag ||
-	    /* Or if the read flag from REG is the same as PARENT_REG. */
-	    parent_flag == flag)
-		return 0;
-
-	err = mark_reg_read(env, reg, parent_reg, flag);
-	if (err)
-		return err;
-
-	return flag;
-}
-
-/* A write screens off any subsequent reads; but write marks come from the
- * straight-line code between a state and its parent.  When we arrive at an
- * equivalent state (jump target or such) we didn't arrive by the straight-line
- * code, so read marks in the state must propagate to the parent regardless
- * of the state's write marks. That's what 'parent == state->parent' comparison
- * in mark_reg_read() is for.
- */
-static int propagate_liveness(struct bpf_verifier_env *env,
-			      const struct bpf_verifier_state *vstate,
-			      struct bpf_verifier_state *vparent,
-			      bool *changed)
-{
-	struct bpf_reg_state *state_reg, *parent_reg;
-	struct bpf_func_state *state, *parent;
-	int i, frame, err = 0;
-	bool tmp = false;
-
-	changed = changed ?: &tmp;
-	if (vparent->curframe != vstate->curframe) {
-		WARN(1, "propagate_live: parent frame %d current frame %d\n",
-		     vparent->curframe, vstate->curframe);
-		return -EFAULT;
-	}
-	/* Propagate read liveness of registers... */
-	BUILD_BUG_ON(BPF_REG_FP + 1 != MAX_BPF_REG);
-	for (frame = 0; frame <= vstate->curframe; frame++) {
-		parent = vparent->frame[frame];
-		state = vstate->frame[frame];
-		parent_reg = parent->regs;
-		state_reg = state->regs;
-		/* We don't need to worry about FP liveness, it's read-only */
-		for (i = frame < vstate->curframe ? BPF_REG_6 : 0; i < BPF_REG_FP; i++) {
-			err = propagate_liveness_reg(env, &state_reg[i],
-						     &parent_reg[i]);
-			if (err < 0)
-				return err;
-			*changed |= err > 0;
-			if (err == REG_LIVE_READ64)
-				mark_insn_zext(env, &parent_reg[i]);
-		}
-
-		/* Propagate stack slots. */
-		for (i = 0; i < state->allocated_stack / BPF_REG_SIZE &&
-			    i < parent->allocated_stack / BPF_REG_SIZE; i++) {
-			parent_reg = &parent->stack[i].spilled_ptr;
-			state_reg = &state->stack[i].spilled_ptr;
-			err = propagate_liveness_reg(env, state_reg,
-						     parent_reg);
-			*changed |= err > 0;
-			if (err < 0)
-				return err;
-		}
-	}
-	return 0;
-}
-
 /* find precise scalars in the previous equivalent state and
  * propagate them into the current state
  */
@@ -19176,8 +18954,7 @@ static int propagate_precision(struct bpf_verifier_env *env,
 		first = true;
 		for (i = 0; i < BPF_REG_FP; i++, state_reg++) {
 			if (state_reg->type != SCALAR_VALUE ||
-			    !state_reg->precise ||
-			    !(state_reg->live & REG_LIVE_READ))
+			    !state_reg->precise)
 				continue;
 			if (env->log.level & BPF_LOG_LEVEL2) {
 				if (first)
@@ -19194,8 +18971,7 @@ static int propagate_precision(struct bpf_verifier_env *env,
 				continue;
 			state_reg = &state->stack[i].spilled_ptr;
 			if (state_reg->type != SCALAR_VALUE ||
-			    !state_reg->precise ||
-			    !(state_reg->live & REG_LIVE_READ))
+			    !state_reg->precise)
 				continue;
 			if (env->log.level & BPF_LOG_LEVEL2) {
 				if (first)
@@ -19245,9 +19021,6 @@ static int propagate_backedges(struct bpf_verifier_env *env, struct bpf_scc_visi
 		changed = false;
 		for (backedge = visit->backedges; backedge; backedge = backedge->next) {
 			st = &backedge->state;
-			err = propagate_liveness(env, st->equal_state, st, &changed);
-			if (err)
-				return err;
 			err = propagate_precision(env, st->equal_state, st, &changed);
 			if (err)
 				return err;
@@ -19271,7 +19044,7 @@ static bool states_maybe_looping(struct bpf_verifier_state *old,
 	fcur = cur->frame[fr];
 	for (i = 0; i < MAX_BPF_REG; i++)
 		if (memcmp(&fold->regs[i], &fcur->regs[i],
-			   offsetof(struct bpf_reg_state, parent)))
+			   offsetof(struct bpf_reg_state, frameno)))
 			return false;
 	return true;
 }
@@ -19369,7 +19142,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 	struct bpf_verifier_state_list *sl;
 	struct bpf_verifier_state *cur = env->cur_state, *new;
 	bool force_new_state, add_new_state, loop;
-	int i, j, n, err, states_cnt = 0;
+	int n, err, states_cnt = 0;
 	struct list_head *pos, *tmp, *head;
 
 	force_new_state = env->test_state_freq || is_force_checkpoint(env, insn_idx) ||
@@ -19526,28 +19299,16 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 		loop = incomplete_read_marks(env, &sl->state);
 		if (states_equal(env, &sl->state, cur, loop ? RANGE_WITHIN : NOT_EXACT)) {
 hit:
-			if (env->internal_error)
-				return -EFAULT;
 			sl->hit_cnt++;
-			/* reached equivalent register/stack state,
-			 * prune the search.
-			 * Registers read by the continuation are read by us.
-			 * If we have any write marks in env->cur_state, they
-			 * will prevent corresponding reads in the continuation
-			 * from reaching our parent (an explored_state).  Our
-			 * own state will get the read marks recorded, but
-			 * they'll be immediately forgotten as we're pruning
-			 * this state and will pop a new one.
-			 */
-			err = propagate_liveness(env, &sl->state, cur, NULL);
 
 			/* if previous state reached the exit with precision and
 			 * current state is equivalent to it (except precision marks)
 			 * the precision needs to be propagated back in
 			 * the current state.
 			 */
+			err = 0;
 			if (is_jmp_point(env, env->insn_idx))
-				err = err ? : push_jmp_history(env, cur, 0, 0);
+				err = push_jmp_history(env, cur, 0, 0);
 			err = err ? : propagate_precision(env, &sl->state, cur, NULL);
 			if (err)
 				return err;
@@ -19642,8 +19403,6 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 			return 1;
 		}
 miss:
-		if (env->internal_error)
-			return -EFAULT;
 		/* when new state is not going to be added do not increase miss count.
 		 * Otherwise several loop iterations will remove the state
 		 * recorded earlier. The goal of these heuristics is to have
@@ -19729,38 +19488,6 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 	cur->dfs_depth = new->dfs_depth + 1;
 	clear_jmp_history(cur);
 	list_add(&new_sl->node, head);
-
-	/* connect new state to parentage chain. Current frame needs all
-	 * registers connected. Only r6 - r9 of the callers are alive (pushed
-	 * to the stack implicitly by JITs) so in callers' frames connect just
-	 * r6 - r9 as an optimization. Callers will have r1 - r5 connected to
-	 * the state of the call instruction (with WRITTEN set), and r0 comes
-	 * from callee with its full parentage chain, anyway.
-	 */
-	/* clear write marks in current state: the writes we did are not writes
-	 * our child did, so they don't screen off its reads from us.
-	 * (There are no read marks in current state, because reads always mark
-	 * their parent and current state never has children yet.  Only
-	 * explored_states can get read marks.)
-	 */
-	for (j = 0; j <= cur->curframe; j++) {
-		for (i = j < cur->curframe ? BPF_REG_6 : 0; i < BPF_REG_FP; i++)
-			cur->frame[j]->regs[i].parent = &new->frame[j]->regs[i];
-		for (i = 0; i < BPF_REG_FP; i++)
-			cur->frame[j]->regs[i].live = REG_LIVE_NONE;
-	}
-
-	/* all stack frames are accessible from callee, clear them all */
-	for (j = 0; j <= cur->curframe; j++) {
-		struct bpf_func_state *frame = cur->frame[j];
-		struct bpf_func_state *newframe = new->frame[j];
-
-		for (i = 0; i < frame->allocated_stack / BPF_REG_SIZE; i++) {
-			frame->stack[i].spilled_ptr.live = REG_LIVE_NONE;
-			frame->stack[i].spilled_ptr.parent =
-						&newframe->stack[i].spilled_ptr;
-		}
-	}
 	return 0;
 }
 
diff --git a/tools/testing/selftests/bpf/prog_tests/align.c b/tools/testing/selftests/bpf/prog_tests/align.c
index 1d53a8561ee2fcb88ddc040b227e31966d616b41..24c509ce4e5b2b8cbe0350c58474dc412bff0d52 100644
--- a/tools/testing/selftests/bpf/prog_tests/align.c
+++ b/tools/testing/selftests/bpf/prog_tests/align.c
@@ -42,11 +42,11 @@ static struct bpf_align_test tests[] = {
 		.matches = {
 			{0, "R1", "ctx()"},
 			{0, "R10", "fp0"},
-			{0, "R3_w", "2"},
-			{1, "R3_w", "4"},
-			{2, "R3_w", "8"},
-			{3, "R3_w", "16"},
-			{4, "R3_w", "32"},
+			{0, "R3", "2"},
+			{1, "R3", "4"},
+			{2, "R3", "8"},
+			{3, "R3", "16"},
+			{4, "R3", "32"},
 		},
 	},
 	{
@@ -70,17 +70,17 @@ static struct bpf_align_test tests[] = {
 		.matches = {
 			{0, "R1", "ctx()"},
 			{0, "R10", "fp0"},
-			{0, "R3_w", "1"},
-			{1, "R3_w", "2"},
-			{2, "R3_w", "4"},
-			{3, "R3_w", "8"},
-			{4, "R3_w", "16"},
-			{5, "R3_w", "1"},
-			{6, "R4_w", "32"},
-			{7, "R4_w", "16"},
-			{8, "R4_w", "8"},
-			{9, "R4_w", "4"},
-			{10, "R4_w", "2"},
+			{0, "R3", "1"},
+			{1, "R3", "2"},
+			{2, "R3", "4"},
+			{3, "R3", "8"},
+			{4, "R3", "16"},
+			{5, "R3", "1"},
+			{6, "R4", "32"},
+			{7, "R4", "16"},
+			{8, "R4", "8"},
+			{9, "R4", "4"},
+			{10, "R4", "2"},
 		},
 	},
 	{
@@ -99,12 +99,12 @@ static struct bpf_align_test tests[] = {
 		.matches = {
 			{0, "R1", "ctx()"},
 			{0, "R10", "fp0"},
-			{0, "R3_w", "4"},
-			{1, "R3_w", "8"},
-			{2, "R3_w", "10"},
-			{3, "R4_w", "8"},
-			{4, "R4_w", "12"},
-			{5, "R4_w", "14"},
+			{0, "R3", "4"},
+			{1, "R3", "8"},
+			{2, "R3", "10"},
+			{3, "R4", "8"},
+			{4, "R4", "12"},
+			{5, "R4", "14"},
 		},
 	},
 	{
@@ -121,10 +121,10 @@ static struct bpf_align_test tests[] = {
 		.matches = {
 			{0, "R1", "ctx()"},
 			{0, "R10", "fp0"},
-			{0, "R3_w", "7"},
-			{1, "R3_w", "7"},
-			{2, "R3_w", "14"},
-			{3, "R3_w", "56"},
+			{0, "R3", "7"},
+			{1, "R3", "7"},
+			{2, "R3", "14"},
+			{3, "R3", "56"},
 		},
 	},
 
@@ -162,19 +162,19 @@ static struct bpf_align_test tests[] = {
 		},
 		.prog_type = BPF_PROG_TYPE_SCHED_CLS,
 		.matches = {
-			{6, "R0_w", "pkt(off=8,r=8)"},
-			{6, "R3_w", "var_off=(0x0; 0xff)"},
-			{7, "R3_w", "var_off=(0x0; 0x1fe)"},
-			{8, "R3_w", "var_off=(0x0; 0x3fc)"},
-			{9, "R3_w", "var_off=(0x0; 0x7f8)"},
-			{10, "R3_w", "var_off=(0x0; 0xff0)"},
-			{12, "R3_w", "pkt_end()"},
-			{17, "R4_w", "var_off=(0x0; 0xff)"},
-			{18, "R4_w", "var_off=(0x0; 0x1fe0)"},
-			{19, "R4_w", "var_off=(0x0; 0xff0)"},
-			{20, "R4_w", "var_off=(0x0; 0x7f8)"},
-			{21, "R4_w", "var_off=(0x0; 0x3fc)"},
-			{22, "R4_w", "var_off=(0x0; 0x1fe)"},
+			{6, "R0", "pkt(off=8,r=8)"},
+			{6, "R3", "var_off=(0x0; 0xff)"},
+			{7, "R3", "var_off=(0x0; 0x1fe)"},
+			{8, "R3", "var_off=(0x0; 0x3fc)"},
+			{9, "R3", "var_off=(0x0; 0x7f8)"},
+			{10, "R3", "var_off=(0x0; 0xff0)"},
+			{12, "R3", "pkt_end()"},
+			{17, "R4", "var_off=(0x0; 0xff)"},
+			{18, "R4", "var_off=(0x0; 0x1fe0)"},
+			{19, "R4", "var_off=(0x0; 0xff0)"},
+			{20, "R4", "var_off=(0x0; 0x7f8)"},
+			{21, "R4", "var_off=(0x0; 0x3fc)"},
+			{22, "R4", "var_off=(0x0; 0x1fe)"},
 		},
 	},
 	{
@@ -195,16 +195,16 @@ static struct bpf_align_test tests[] = {
 		},
 		.prog_type = BPF_PROG_TYPE_SCHED_CLS,
 		.matches = {
-			{6, "R3_w", "var_off=(0x0; 0xff)"},
-			{7, "R4_w", "var_off=(0x0; 0xff)"},
-			{8, "R4_w", "var_off=(0x0; 0xff)"},
-			{9, "R4_w", "var_off=(0x0; 0xff)"},
-			{10, "R4_w", "var_off=(0x0; 0x1fe)"},
-			{11, "R4_w", "var_off=(0x0; 0xff)"},
-			{12, "R4_w", "var_off=(0x0; 0x3fc)"},
-			{13, "R4_w", "var_off=(0x0; 0xff)"},
-			{14, "R4_w", "var_off=(0x0; 0x7f8)"},
-			{15, "R4_w", "var_off=(0x0; 0xff0)"},
+			{6, "R3", "var_off=(0x0; 0xff)"},
+			{7, "R4", "var_off=(0x0; 0xff)"},
+			{8, "R4", "var_off=(0x0; 0xff)"},
+			{9, "R4", "var_off=(0x0; 0xff)"},
+			{10, "R4", "var_off=(0x0; 0x1fe)"},
+			{11, "R4", "var_off=(0x0; 0xff)"},
+			{12, "R4", "var_off=(0x0; 0x3fc)"},
+			{13, "R4", "var_off=(0x0; 0xff)"},
+			{14, "R4", "var_off=(0x0; 0x7f8)"},
+			{15, "R4", "var_off=(0x0; 0xff0)"},
 		},
 	},
 	{
@@ -235,14 +235,14 @@ static struct bpf_align_test tests[] = {
 		},
 		.prog_type = BPF_PROG_TYPE_SCHED_CLS,
 		.matches = {
-			{2, "R5_w", "pkt(r=0)"},
-			{4, "R5_w", "pkt(off=14,r=0)"},
-			{5, "R4_w", "pkt(off=14,r=0)"},
+			{2, "R5", "pkt(r=0)"},
+			{4, "R5", "pkt(off=14,r=0)"},
+			{5, "R4", "pkt(off=14,r=0)"},
 			{9, "R2", "pkt(r=18)"},
 			{10, "R5", "pkt(off=14,r=18)"},
-			{10, "R4_w", "var_off=(0x0; 0xff)"},
-			{13, "R4_w", "var_off=(0x0; 0xffff)"},
-			{14, "R4_w", "var_off=(0x0; 0xffff)"},
+			{10, "R4", "var_off=(0x0; 0xff)"},
+			{13, "R4", "var_off=(0x0; 0xffff)"},
+			{14, "R4", "var_off=(0x0; 0xffff)"},
 		},
 	},
 	{
@@ -299,12 +299,12 @@ static struct bpf_align_test tests[] = {
 			/* Calculated offset in R6 has unknown value, but known
 			 * alignment of 4.
 			 */
-			{6, "R2_w", "pkt(r=8)"},
-			{7, "R6_w", "var_off=(0x0; 0x3fc)"},
+			{6, "R2", "pkt(r=8)"},
+			{7, "R6", "var_off=(0x0; 0x3fc)"},
 			/* Offset is added to packet pointer R5, resulting in
 			 * known fixed offset, and variable offset from R6.
 			 */
-			{11, "R5_w", "pkt(id=1,off=14,"},
+			{11, "R5", "pkt(id=1,off=14,"},
 			/* At the time the word size load is performed from R5,
 			 * it's total offset is NET_IP_ALIGN + reg->off (0) +
 			 * reg->aux_off (14) which is 16.  Then the variable
@@ -320,12 +320,12 @@ static struct bpf_align_test tests[] = {
 			 * instruction to validate R5 state. We also check
 			 * that R4 is what it should be in such case.
 			 */
-			{18, "R4_w", "var_off=(0x0; 0x3fc)"},
-			{18, "R5_w", "var_off=(0x0; 0x3fc)"},
+			{18, "R4", "var_off=(0x0; 0x3fc)"},
+			{18, "R5", "var_off=(0x0; 0x3fc)"},
 			/* Constant offset is added to R5, resulting in
 			 * reg->off of 14.
 			 */
-			{19, "R5_w", "pkt(id=2,off=14,"},
+			{19, "R5", "pkt(id=2,off=14,"},
 			/* At the time the word size load is performed from R5,
 			 * its total fixed offset is NET_IP_ALIGN + reg->off
 			 * (14) which is 16.  Then the variable offset is 4-byte
@@ -337,21 +337,21 @@ static struct bpf_align_test tests[] = {
 			/* Constant offset is added to R5 packet pointer,
 			 * resulting in reg->off value of 14.
 			 */
-			{26, "R5_w", "pkt(off=14,r=8)"},
+			{26, "R5", "pkt(off=14,r=8)"},
 			/* Variable offset is added to R5, resulting in a
 			 * variable offset of (4n). See comment for insn #18
 			 * for R4 = R5 trick.
 			 */
-			{28, "R4_w", "var_off=(0x0; 0x3fc)"},
-			{28, "R5_w", "var_off=(0x0; 0x3fc)"},
+			{28, "R4", "var_off=(0x0; 0x3fc)"},
+			{28, "R5", "var_off=(0x0; 0x3fc)"},
 			/* Constant is added to R5 again, setting reg->off to 18. */
-			{29, "R5_w", "pkt(id=3,off=18,"},
+			{29, "R5", "pkt(id=3,off=18,"},
 			/* And once more we add a variable; resulting var_off
 			 * is still (4n), fixed offset is not changed.
 			 * Also, we create a new reg->id.
 			 */
-			{31, "R4_w", "var_off=(0x0; 0x7fc)"},
-			{31, "R5_w", "var_off=(0x0; 0x7fc)"},
+			{31, "R4", "var_off=(0x0; 0x7fc)"},
+			{31, "R5", "var_off=(0x0; 0x7fc)"},
 			/* At the time the word size load is performed from R5,
 			 * its total fixed offset is NET_IP_ALIGN + reg->off (18)
 			 * which is 20.  Then the variable offset is (4n), so
@@ -397,12 +397,12 @@ static struct bpf_align_test tests[] = {
 			/* Calculated offset in R6 has unknown value, but known
 			 * alignment of 4.
 			 */
-			{6, "R2_w", "pkt(r=8)"},
-			{7, "R6_w", "var_off=(0x0; 0x3fc)"},
+			{6, "R2", "pkt(r=8)"},
+			{7, "R6", "var_off=(0x0; 0x3fc)"},
 			/* Adding 14 makes R6 be (4n+2) */
-			{8, "R6_w", "var_off=(0x2; 0x7fc)"},
+			{8, "R6", "var_off=(0x2; 0x7fc)"},
 			/* Packet pointer has (4n+2) offset */
-			{11, "R5_w", "var_off=(0x2; 0x7fc)"},
+			{11, "R5", "var_off=(0x2; 0x7fc)"},
 			{12, "R4", "var_off=(0x2; 0x7fc)"},
 			/* At the time the word size load is performed from R5,
 			 * its total fixed offset is NET_IP_ALIGN + reg->off (0)
@@ -414,11 +414,11 @@ static struct bpf_align_test tests[] = {
 			/* Newly read value in R6 was shifted left by 2, so has
 			 * known alignment of 4.
 			 */
-			{17, "R6_w", "var_off=(0x0; 0x3fc)"},
+			{17, "R6", "var_off=(0x0; 0x3fc)"},
 			/* Added (4n) to packet pointer's (4n+2) var_off, giving
 			 * another (4n+2).
 			 */
-			{19, "R5_w", "var_off=(0x2; 0xffc)"},
+			{19, "R5", "var_off=(0x2; 0xffc)"},
 			{20, "R4", "var_off=(0x2; 0xffc)"},
 			/* At the time the word size load is performed from R5,
 			 * its total fixed offset is NET_IP_ALIGN + reg->off (0)
@@ -459,18 +459,18 @@ static struct bpf_align_test tests[] = {
 		.prog_type = BPF_PROG_TYPE_SCHED_CLS,
 		.result = REJECT,
 		.matches = {
-			{3, "R5_w", "pkt_end()"},
+			{3, "R5", "pkt_end()"},
 			/* (ptr - ptr) << 2 == unknown, (4n) */
-			{5, "R5_w", "var_off=(0x0; 0xfffffffffffffffc)"},
+			{5, "R5", "var_off=(0x0; 0xfffffffffffffffc)"},
 			/* (4n) + 14 == (4n+2).  We blow our bounds, because
 			 * the add could overflow.
 			 */
-			{6, "R5_w", "var_off=(0x2; 0xfffffffffffffffc)"},
+			{6, "R5", "var_off=(0x2; 0xfffffffffffffffc)"},
 			/* Checked s>=0 */
 			{9, "R5", "var_off=(0x2; 0x7ffffffffffffffc)"},
 			/* packet pointer + nonnegative (4n+2) */
-			{11, "R6_w", "var_off=(0x2; 0x7ffffffffffffffc)"},
-			{12, "R4_w", "var_off=(0x2; 0x7ffffffffffffffc)"},
+			{11, "R6", "var_off=(0x2; 0x7ffffffffffffffc)"},
+			{12, "R4", "var_off=(0x2; 0x7ffffffffffffffc)"},
 			/* NET_IP_ALIGN + (4n+2) == (4n), alignment is fine.
 			 * We checked the bounds, but it might have been able
 			 * to overflow if the packet pointer started in the
@@ -478,7 +478,7 @@ static struct bpf_align_test tests[] = {
 			 * So we did not get a 'range' on R6, and the access
 			 * attempt will fail.
 			 */
-			{15, "R6_w", "var_off=(0x2; 0x7ffffffffffffffc)"},
+			{15, "R6", "var_off=(0x2; 0x7ffffffffffffffc)"},
 		}
 	},
 	{
@@ -513,12 +513,12 @@ static struct bpf_align_test tests[] = {
 			/* Calculated offset in R6 has unknown value, but known
 			 * alignment of 4.
 			 */
-			{6, "R2_w", "pkt(r=8)"},
-			{8, "R6_w", "var_off=(0x0; 0x3fc)"},
+			{6, "R2", "pkt(r=8)"},
+			{8, "R6", "var_off=(0x0; 0x3fc)"},
 			/* Adding 14 makes R6 be (4n+2) */
-			{9, "R6_w", "var_off=(0x2; 0x7fc)"},
+			{9, "R6", "var_off=(0x2; 0x7fc)"},
 			/* New unknown value in R7 is (4n) */
-			{10, "R7_w", "var_off=(0x0; 0x3fc)"},
+			{10, "R7", "var_off=(0x0; 0x3fc)"},
 			/* Subtracting it from R6 blows our unsigned bounds */
 			{11, "R6", "var_off=(0x2; 0xfffffffffffffffc)"},
 			/* Checked s>= 0 */
@@ -566,16 +566,16 @@ static struct bpf_align_test tests[] = {
 			/* Calculated offset in R6 has unknown value, but known
 			 * alignment of 4.
 			 */
-			{6, "R2_w", "pkt(r=8)"},
-			{9, "R6_w", "var_off=(0x0; 0x3c)"},
+			{6, "R2", "pkt(r=8)"},
+			{9, "R6", "var_off=(0x0; 0x3c)"},
 			/* Adding 14 makes R6 be (4n+2) */
-			{10, "R6_w", "var_off=(0x2; 0x7c)"},
+			{10, "R6", "var_off=(0x2; 0x7c)"},
 			/* Subtracting from packet pointer overflows ubounds */
-			{13, "R5_w", "var_off=(0xffffffffffffff82; 0x7c)"},
+			{13, "R5", "var_off=(0xffffffffffffff82; 0x7c)"},
 			/* New unknown value in R7 is (4n), >= 76 */
-			{14, "R7_w", "var_off=(0x0; 0x7fc)"},
+			{14, "R7", "var_off=(0x0; 0x7fc)"},
 			/* Adding it to packet pointer gives nice bounds again */
-			{16, "R5_w", "var_off=(0x2; 0x7fc)"},
+			{16, "R5", "var_off=(0x2; 0x7fc)"},
 			/* At the time the word size load is performed from R5,
 			 * its total fixed offset is NET_IP_ALIGN + reg->off (0)
 			 * which is 2.  Then the variable offset is (4n+2), so
diff --git a/tools/testing/selftests/bpf/prog_tests/spin_lock.c b/tools/testing/selftests/bpf/prog_tests/spin_lock.c
index e3ea5dc2f697c40da1e0c4928b295369205fb9bd..254fbfeab06a221df5116c35dda860fab7c56b4c 100644
--- a/tools/testing/selftests/bpf/prog_tests/spin_lock.c
+++ b/tools/testing/selftests/bpf/prog_tests/spin_lock.c
@@ -13,22 +13,22 @@ static struct {
 	const char *err_msg;
 } spin_lock_fail_tests[] = {
 	{ "lock_id_kptr_preserve",
-	  "5: (bf) r1 = r0                       ; R0_w=ptr_foo(id=2,ref_obj_id=2) "
-	  "R1_w=ptr_foo(id=2,ref_obj_id=2) refs=2\n6: (85) call bpf_this_cpu_ptr#154\n"
+	  "5: (bf) r1 = r0                       ; R0=ptr_foo(id=2,ref_obj_id=2) "
+	  "R1=ptr_foo(id=2,ref_obj_id=2) refs=2\n6: (85) call bpf_this_cpu_ptr#154\n"
 	  "R1 type=ptr_ expected=percpu_ptr_" },
 	{ "lock_id_global_zero",
-	  "; R1_w=map_value(map=.data.A,ks=4,vs=4)\n2: (85) call bpf_this_cpu_ptr#154\n"
+	  "; R1=map_value(map=.data.A,ks=4,vs=4)\n2: (85) call bpf_this_cpu_ptr#154\n"
 	  "R1 type=map_value expected=percpu_ptr_" },
 	{ "lock_id_mapval_preserve",
 	  "[0-9]\\+: (bf) r1 = r0                       ;"
-	  " R0_w=map_value(id=1,map=array_map,ks=4,vs=8)"
-	  " R1_w=map_value(id=1,map=array_map,ks=4,vs=8)\n"
+	  " R0=map_value(id=1,map=array_map,ks=4,vs=8)"
+	  " R1=map_value(id=1,map=array_map,ks=4,vs=8)\n"
 	  "[0-9]\\+: (85) call bpf_this_cpu_ptr#154\n"
 	  "R1 type=map_value expected=percpu_ptr_" },
 	{ "lock_id_innermapval_preserve",
 	  "[0-9]\\+: (bf) r1 = r0                      ;"
 	  " R0=map_value(id=2,ks=4,vs=8)"
-	  " R1_w=map_value(id=2,ks=4,vs=8)\n"
+	  " R1=map_value(id=2,ks=4,vs=8)\n"
 	  "[0-9]\\+: (85) call bpf_this_cpu_ptr#154\n"
 	  "R1 type=map_value expected=percpu_ptr_" },
 	{ "lock_id_mismatch_kptr_kptr", "bpf_spin_unlock of different lock" },
diff --git a/tools/testing/selftests/bpf/prog_tests/test_veristat.c b/tools/testing/selftests/bpf/prog_tests/test_veristat.c
index 367f47e4a936d43c66926f21a1422390232fc46e..b38c16b4247f77eca4a43275d9dd20a3de934919 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_veristat.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_veristat.c
@@ -75,26 +75,26 @@ static void test_set_global_vars_succeeds(void)
 	    " -vl2 > %s", fix->veristat, fix->tmpfile);
 
 	read(fix->fd, fix->output, fix->sz);
-	__CHECK_STR("_w=0xf000000000000001 ", "var_s64 = 0xf000000000000001");
-	__CHECK_STR("_w=0xfedcba9876543210 ", "var_u64 = 0xfedcba9876543210");
-	__CHECK_STR("_w=0x80000000 ", "var_s32 = -0x80000000");
-	__CHECK_STR("_w=0x76543210 ", "var_u32 = 0x76543210");
-	__CHECK_STR("_w=0x8000 ", "var_s16 = -32768");
-	__CHECK_STR("_w=0xecec ", "var_u16 = 60652");
-	__CHECK_STR("_w=128 ", "var_s8 = -128");
-	__CHECK_STR("_w=255 ", "var_u8 = 255");
-	__CHECK_STR("_w=11 ", "var_ea = EA2");
-	__CHECK_STR("_w=12 ", "var_eb = EB2");
-	__CHECK_STR("_w=13 ", "var_ec = EC2");
-	__CHECK_STR("_w=1 ", "var_b = 1");
-	__CHECK_STR("_w=170 ", "struct1[2].struct2[1][2].u.var_u8[2]=170");
-	__CHECK_STR("_w=0xaaaa ", "union1.var_u16 = 0xaaaa");
-	__CHECK_STR("_w=171 ", "arr[3]= 171");
-	__CHECK_STR("_w=172 ", "arr[EA2] =172");
-	__CHECK_STR("_w=10 ", "enum_arr[EC2]=EA3");
-	__CHECK_STR("_w=173 ", "matrix[31][7][11]=173");
-	__CHECK_STR("_w=174 ", "struct1[2].struct2[1][2].u.mat[5][3]=174");
-	__CHECK_STR("_w=175 ", "struct11[7][5].struct2[0][1].u.mat[3][0]=175");
+	__CHECK_STR("=0xf000000000000001 ", "var_s64 = 0xf000000000000001");
+	__CHECK_STR("=0xfedcba9876543210 ", "var_u64 = 0xfedcba9876543210");
+	__CHECK_STR("=0x80000000 ", "var_s32 = -0x80000000");
+	__CHECK_STR("=0x76543210 ", "var_u32 = 0x76543210");
+	__CHECK_STR("=0x8000 ", "var_s16 = -32768");
+	__CHECK_STR("=0xecec ", "var_u16 = 60652");
+	__CHECK_STR("=128 ", "var_s8 = -128");
+	__CHECK_STR("=255 ", "var_u8 = 255");
+	__CHECK_STR("=11 ", "var_ea = EA2");
+	__CHECK_STR("=12 ", "var_eb = EB2");
+	__CHECK_STR("=13 ", "var_ec = EC2");
+	__CHECK_STR("=1 ", "var_b = 1");
+	__CHECK_STR("=170 ", "struct1[2].struct2[1][2].u.var_u8[2]=170");
+	__CHECK_STR("=0xaaaa ", "union1.var_u16 = 0xaaaa");
+	__CHECK_STR("=171 ", "arr[3]= 171");
+	__CHECK_STR("=172 ", "arr[EA2] =172");
+	__CHECK_STR("=10 ", "enum_arr[EC2]=EA3");
+	__CHECK_STR("=173 ", "matrix[31][7][11]=173");
+	__CHECK_STR("=174 ", "struct1[2].struct2[1][2].u.mat[5][3]=174");
+	__CHECK_STR("=175 ", "struct11[7][5].struct2[0][1].u.mat[3][0]=175");
 
 out:
 	teardown_fixture(fix);
@@ -117,8 +117,8 @@ static void test_set_global_vars_from_file_succeeds(void)
 	SYS(out, "%s set_global_vars.bpf.o -G \"@%s\" -vl2 > %s",
 	    fix->veristat, input_file, fix->tmpfile);
 	read(fix->fd, fix->output, fix->sz);
-	__CHECK_STR("_w=0x8000 ", "var_s16 = -32768");
-	__CHECK_STR("_w=0xecec ", "var_u16 = 60652");
+	__CHECK_STR("=0x8000 ", "var_s16 = -32768");
+	__CHECK_STR("=0xecec ", "var_u16 = 60652");
 
 out:
 	close(fd);
diff --git a/tools/testing/selftests/bpf/progs/exceptions_assert.c b/tools/testing/selftests/bpf/progs/exceptions_assert.c
index 5e0a1ca96d4e2764ed780ee7459b367fcffaec1d..a01c2736890f9482e5a16bc943e7d877600149c2 100644
--- a/tools/testing/selftests/bpf/progs/exceptions_assert.c
+++ b/tools/testing/selftests/bpf/progs/exceptions_assert.c
@@ -18,43 +18,43 @@
 		return *(u64 *)num;					\
 	}
 
-__msg(": R0_w=0xffffffff80000000")
+__msg(": R0=0xffffffff80000000")
 check_assert(s64, ==, eq_int_min, INT_MIN);
-__msg(": R0_w=0x7fffffff")
+__msg(": R0=0x7fffffff")
 check_assert(s64, ==, eq_int_max, INT_MAX);
-__msg(": R0_w=0")
+__msg(": R0=0")
 check_assert(s64, ==, eq_zero, 0);
-__msg(": R0_w=0x8000000000000000 R1_w=0x8000000000000000")
+__msg(": R0=0x8000000000000000 R1=0x8000000000000000")
 check_assert(s64, ==, eq_llong_min, LLONG_MIN);
-__msg(": R0_w=0x7fffffffffffffff R1_w=0x7fffffffffffffff")
+__msg(": R0=0x7fffffffffffffff R1=0x7fffffffffffffff")
 check_assert(s64, ==, eq_llong_max, LLONG_MAX);
 
-__msg(": R0_w=scalar(id=1,smax=0x7ffffffe)")
+__msg(": R0=scalar(id=1,smax=0x7ffffffe)")
 check_assert(s64, <, lt_pos, INT_MAX);
-__msg(": R0_w=scalar(id=1,smax=-1,umin=0x8000000000000000,var_off=(0x8000000000000000; 0x7fffffffffffffff))")
+__msg(": R0=scalar(id=1,smax=-1,umin=0x8000000000000000,var_off=(0x8000000000000000; 0x7fffffffffffffff))")
 check_assert(s64, <, lt_zero, 0);
-__msg(": R0_w=scalar(id=1,smax=0xffffffff7fffffff")
+__msg(": R0=scalar(id=1,smax=0xffffffff7fffffff")
 check_assert(s64, <, lt_neg, INT_MIN);
 
-__msg(": R0_w=scalar(id=1,smax=0x7fffffff)")
+__msg(": R0=scalar(id=1,smax=0x7fffffff)")
 check_assert(s64, <=, le_pos, INT_MAX);
-__msg(": R0_w=scalar(id=1,smax=0)")
+__msg(": R0=scalar(id=1,smax=0)")
 check_assert(s64, <=, le_zero, 0);
-__msg(": R0_w=scalar(id=1,smax=0xffffffff80000000")
+__msg(": R0=scalar(id=1,smax=0xffffffff80000000")
 check_assert(s64, <=, le_neg, INT_MIN);
 
-__msg(": R0_w=scalar(id=1,smin=umin=0x80000000,umax=0x7fffffffffffffff,var_off=(0x0; 0x7fffffffffffffff))")
+__msg(": R0=scalar(id=1,smin=umin=0x80000000,umax=0x7fffffffffffffff,var_off=(0x0; 0x7fffffffffffffff))")
 check_assert(s64, >, gt_pos, INT_MAX);
-__msg(": R0_w=scalar(id=1,smin=umin=1,umax=0x7fffffffffffffff,var_off=(0x0; 0x7fffffffffffffff))")
+__msg(": R0=scalar(id=1,smin=umin=1,umax=0x7fffffffffffffff,var_off=(0x0; 0x7fffffffffffffff))")
 check_assert(s64, >, gt_zero, 0);
-__msg(": R0_w=scalar(id=1,smin=0xffffffff80000001")
+__msg(": R0=scalar(id=1,smin=0xffffffff80000001")
 check_assert(s64, >, gt_neg, INT_MIN);
 
-__msg(": R0_w=scalar(id=1,smin=umin=0x7fffffff,umax=0x7fffffffffffffff,var_off=(0x0; 0x7fffffffffffffff))")
+__msg(": R0=scalar(id=1,smin=umin=0x7fffffff,umax=0x7fffffffffffffff,var_off=(0x0; 0x7fffffffffffffff))")
 check_assert(s64, >=, ge_pos, INT_MAX);
-__msg(": R0_w=scalar(id=1,smin=0,umax=0x7fffffffffffffff,var_off=(0x0; 0x7fffffffffffffff))")
+__msg(": R0=scalar(id=1,smin=0,umax=0x7fffffffffffffff,var_off=(0x0; 0x7fffffffffffffff))")
 check_assert(s64, >=, ge_zero, 0);
-__msg(": R0_w=scalar(id=1,smin=0xffffffff80000000")
+__msg(": R0=scalar(id=1,smin=0xffffffff80000000")
 check_assert(s64, >=, ge_neg, INT_MIN);
 
 SEC("?tc")
diff --git a/tools/testing/selftests/bpf/progs/iters_state_safety.c b/tools/testing/selftests/bpf/progs/iters_state_safety.c
index b381ac0c736cf0a47cc74d40ec1f9a462cbf4cff..d273b46dfc7c19e73c6c88e03b59bae617d960b8 100644
--- a/tools/testing/selftests/bpf/progs/iters_state_safety.c
+++ b/tools/testing/selftests/bpf/progs/iters_state_safety.c
@@ -30,7 +30,7 @@ int force_clang_to_emit_btf_for_externs(void *ctx)
 
 SEC("?raw_tp")
 __success __log_level(2)
-__msg("fp-8_w=iter_num(ref_id=1,state=active,depth=0)")
+__msg("fp-8=iter_num(ref_id=1,state=active,depth=0)")
 int create_and_destroy(void *ctx)
 {
 	struct bpf_iter_num iter;
@@ -196,7 +196,7 @@ int leak_iter_from_subprog_fail(void *ctx)
 
 SEC("?raw_tp")
 __success __log_level(2)
-__msg("fp-8_w=iter_num(ref_id=1,state=active,depth=0)")
+__msg("fp-8=iter_num(ref_id=1,state=active,depth=0)")
 int valid_stack_reuse(void *ctx)
 {
 	struct bpf_iter_num iter;
diff --git a/tools/testing/selftests/bpf/progs/iters_testmod_seq.c b/tools/testing/selftests/bpf/progs/iters_testmod_seq.c
index 6543d5b6e0a976b7af2d723177698f15517643d7..83791348bed5268c155b21a772c5f952994f27f6 100644
--- a/tools/testing/selftests/bpf/progs/iters_testmod_seq.c
+++ b/tools/testing/selftests/bpf/progs/iters_testmod_seq.c
@@ -20,7 +20,7 @@ __s64 res_empty;
 
 SEC("raw_tp/sys_enter")
 __success __log_level(2)
-__msg("fp-16_w=iter_testmod_seq(ref_id=1,state=active,depth=0)")
+__msg("fp-16=iter_testmod_seq(ref_id=1,state=active,depth=0)")
 __msg("fp-16=iter_testmod_seq(ref_id=1,state=drained,depth=0)")
 __msg("call bpf_iter_testmod_seq_destroy")
 int testmod_seq_empty(const void *ctx)
@@ -38,7 +38,7 @@ __s64 res_full;
 
 SEC("raw_tp/sys_enter")
 __success __log_level(2)
-__msg("fp-16_w=iter_testmod_seq(ref_id=1,state=active,depth=0)")
+__msg("fp-16=iter_testmod_seq(ref_id=1,state=active,depth=0)")
 __msg("fp-16=iter_testmod_seq(ref_id=1,state=drained,depth=0)")
 __msg("call bpf_iter_testmod_seq_destroy")
 int testmod_seq_full(const void *ctx)
@@ -58,7 +58,7 @@ static volatile int zero = 0;
 
 SEC("raw_tp/sys_enter")
 __success __log_level(2)
-__msg("fp-16_w=iter_testmod_seq(ref_id=1,state=active,depth=0)")
+__msg("fp-16=iter_testmod_seq(ref_id=1,state=active,depth=0)")
 __msg("fp-16=iter_testmod_seq(ref_id=1,state=drained,depth=0)")
 __msg("call bpf_iter_testmod_seq_destroy")
 int testmod_seq_truncated(const void *ctx)
diff --git a/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c b/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c
index 4f94c971ae8626a845024dd7b08878cec2ff82bc..3b984b6ae7c0b94a993470a3fe8185fce1214f4a 100644
--- a/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c
+++ b/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c
@@ -8,8 +8,8 @@
 SEC("tp_btf/sys_enter")
 __success
 __log_level(2)
-__msg("r8 = *(u64 *)(r7 +0)          ; R7_w=ptr_nameidata(off={{[0-9]+}}) R8_w=rdonly_untrusted_mem(sz=0)")
-__msg("r9 = *(u8 *)(r8 +0)           ; R8_w=rdonly_untrusted_mem(sz=0) R9_w=scalar")
+__msg("r8 = *(u64 *)(r7 +0)          ; R7=ptr_nameidata(off={{[0-9]+}}) R8=rdonly_untrusted_mem(sz=0)")
+__msg("r9 = *(u8 *)(r8 +0)           ; R8=rdonly_untrusted_mem(sz=0) R9=scalar")
 int btf_id_to_ptr_mem(void *ctx)
 {
 	struct task_struct *task;
diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index fbccc20555f48d2788f4bbcb3c591dfb46ccb49d..0a72e0228ea9a24e614cdc06f96fe90a63ceb9cf 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -926,7 +926,7 @@ l1_%=:	r0 = 0;						\
 SEC("socket")
 __description("bounds check for non const xor src dst")
 __success __log_level(2)
-__msg("5: (af) r0 ^= r6                      ; R0_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=431,var_off=(0x0; 0x1af))")
+__msg("5: (af) r0 ^= r6                      ; R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=431,var_off=(0x0; 0x1af))")
 __naked void non_const_xor_src_dst(void)
 {
 	asm volatile ("					\
@@ -947,7 +947,7 @@ __naked void non_const_xor_src_dst(void)
 SEC("socket")
 __description("bounds check for non const or src dst")
 __success __log_level(2)
-__msg("5: (4f) r0 |= r6                      ; R0_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=431,var_off=(0x0; 0x1af))")
+__msg("5: (4f) r0 |= r6                      ; R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=431,var_off=(0x0; 0x1af))")
 __naked void non_const_or_src_dst(void)
 {
 	asm volatile ("					\
@@ -968,7 +968,7 @@ __naked void non_const_or_src_dst(void)
 SEC("socket")
 __description("bounds check for non const mul regs")
 __success __log_level(2)
-__msg("5: (2f) r0 *= r6                      ; R0_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=3825,var_off=(0x0; 0xfff))")
+__msg("5: (2f) r0 *= r6                      ; R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=3825,var_off=(0x0; 0xfff))")
 __naked void non_const_mul_regs(void)
 {
 	asm volatile ("					\
@@ -1241,7 +1241,7 @@ l0_%=:	r0 = 0;						\
 SEC("tc")
 __description("multiply mixed sign bounds. test 1")
 __success __log_level(2)
-__msg("r6 *= r7 {{.*}}; R6_w=scalar(smin=umin=0x1bc16d5cd4927ee1,smax=umax=0x1bc16d674ec80000,smax32=0x7ffffeff,umax32=0xfffffeff,var_off=(0x1bc16d4000000000; 0x3ffffffeff))")
+__msg("r6 *= r7 {{.*}}; R6=scalar(smin=umin=0x1bc16d5cd4927ee1,smax=umax=0x1bc16d674ec80000,smax32=0x7ffffeff,umax32=0xfffffeff,var_off=(0x1bc16d4000000000; 0x3ffffffeff))")
 __naked void mult_mixed0_sign(void)
 {
 	asm volatile (
@@ -1264,7 +1264,7 @@ __naked void mult_mixed0_sign(void)
 SEC("tc")
 __description("multiply mixed sign bounds. test 2")
 __success __log_level(2)
-__msg("r6 *= r7 {{.*}}; R6_w=scalar(smin=smin32=-100,smax=smax32=200)")
+__msg("r6 *= r7 {{.*}}; R6=scalar(smin=smin32=-100,smax=smax32=200)")
 __naked void mult_mixed1_sign(void)
 {
 	asm volatile (
@@ -1287,7 +1287,7 @@ __naked void mult_mixed1_sign(void)
 SEC("tc")
 __description("multiply negative bounds")
 __success __log_level(2)
-__msg("r6 *= r7 {{.*}}; R6_w=scalar(smin=umin=smin32=umin32=0x3ff280b0,smax=umax=smax32=umax32=0x3fff0001,var_off=(0x3ff00000; 0xf81ff))")
+__msg("r6 *= r7 {{.*}}; R6=scalar(smin=umin=smin32=umin32=0x3ff280b0,smax=umax=smax32=umax32=0x3fff0001,var_off=(0x3ff00000; 0xf81ff))")
 __naked void mult_sign_bounds(void)
 {
 	asm volatile (
@@ -1311,7 +1311,7 @@ __naked void mult_sign_bounds(void)
 SEC("tc")
 __description("multiply bounds that don't cross signed boundary")
 __success __log_level(2)
-__msg("r8 *= r6 {{.*}}; R6_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=11,var_off=(0x0; 0xb)) R8_w=scalar(smin=0,smax=umax=0x7b96bb0a94a3a7cd,var_off=(0x0; 0x7fffffffffffffff))")
+__msg("r8 *= r6 {{.*}}; R6=scalar(smin=smin32=0,smax=umax=smax32=umax32=11,var_off=(0x0; 0xb)) R8=scalar(smin=0,smax=umax=0x7b96bb0a94a3a7cd,var_off=(0x0; 0x7fffffffffffffff))")
 __naked void mult_no_sign_crossing(void)
 {
 	asm volatile (
@@ -1331,7 +1331,7 @@ __naked void mult_no_sign_crossing(void)
 SEC("tc")
 __description("multiplication overflow, result in unbounded reg. test 1")
 __success __log_level(2)
-__msg("r6 *= r7 {{.*}}; R6_w=scalar()")
+__msg("r6 *= r7 {{.*}}; R6=scalar()")
 __naked void mult_unsign_ovf(void)
 {
 	asm volatile (
@@ -1353,7 +1353,7 @@ __naked void mult_unsign_ovf(void)
 SEC("tc")
 __description("multiplication overflow, result in unbounded reg. test 2")
 __success __log_level(2)
-__msg("r6 *= r7 {{.*}}; R6_w=scalar()")
+__msg("r6 *= r7 {{.*}}; R6=scalar()")
 __naked void mult_sign_ovf(void)
 {
 	asm volatile (
@@ -1376,7 +1376,7 @@ __naked void mult_sign_ovf(void)
 SEC("socket")
 __description("64-bit addition, all outcomes overflow")
 __success __log_level(2)
-__msg("5: (0f) r3 += r3 {{.*}} R3_w=scalar(umin=0x4000000000000000,umax=0xfffffffffffffffe)")
+__msg("5: (0f) r3 += r3 {{.*}} R3=scalar(umin=0x4000000000000000,umax=0xfffffffffffffffe)")
 __retval(0)
 __naked void add64_full_overflow(void)
 {
@@ -1396,7 +1396,7 @@ __naked void add64_full_overflow(void)
 SEC("socket")
 __description("64-bit addition, partial overflow, result in unbounded reg")
 __success __log_level(2)
-__msg("4: (0f) r3 += r3 {{.*}} R3_w=scalar()")
+__msg("4: (0f) r3 += r3 {{.*}} R3=scalar()")
 __retval(0)
 __naked void add64_partial_overflow(void)
 {
@@ -1416,7 +1416,7 @@ __naked void add64_partial_overflow(void)
 SEC("socket")
 __description("32-bit addition overflow, all outcomes overflow")
 __success __log_level(2)
-__msg("4: (0c) w3 += w3 {{.*}} R3_w=scalar(smin=umin=umin32=0x40000000,smax=umax=umax32=0xfffffffe,var_off=(0x0; 0xffffffff))")
+__msg("4: (0c) w3 += w3 {{.*}} R3=scalar(smin=umin=umin32=0x40000000,smax=umax=umax32=0xfffffffe,var_off=(0x0; 0xffffffff))")
 __retval(0)
 __naked void add32_full_overflow(void)
 {
@@ -1436,7 +1436,7 @@ __naked void add32_full_overflow(void)
 SEC("socket")
 __description("32-bit addition, partial overflow, result in unbounded u32 bounds")
 __success __log_level(2)
-__msg("4: (0c) w3 += w3 {{.*}} R3_w=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))")
+__msg("4: (0c) w3 += w3 {{.*}} R3=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))")
 __retval(0)
 __naked void add32_partial_overflow(void)
 {
@@ -1456,7 +1456,7 @@ __naked void add32_partial_overflow(void)
 SEC("socket")
 __description("64-bit subtraction, all outcomes underflow")
 __success __log_level(2)
-__msg("6: (1f) r3 -= r1 {{.*}} R3_w=scalar(umin=1,umax=0x8000000000000000)")
+__msg("6: (1f) r3 -= r1 {{.*}} R3=scalar(umin=1,umax=0x8000000000000000)")
 __retval(0)
 __naked void sub64_full_overflow(void)
 {
@@ -1477,7 +1477,7 @@ __naked void sub64_full_overflow(void)
 SEC("socket")
 __description("64-bit subtraction, partial overflow, result in unbounded reg")
 __success __log_level(2)
-__msg("3: (1f) r3 -= r2 {{.*}} R3_w=scalar()")
+__msg("3: (1f) r3 -= r2 {{.*}} R3=scalar()")
 __retval(0)
 __naked void sub64_partial_overflow(void)
 {
@@ -1496,7 +1496,7 @@ __naked void sub64_partial_overflow(void)
 SEC("socket")
 __description("32-bit subtraction overflow, all outcomes underflow")
 __success __log_level(2)
-__msg("5: (1c) w3 -= w1 {{.*}} R3_w=scalar(smin=umin=umin32=1,smax=umax=umax32=0x80000000,var_off=(0x0; 0xffffffff))")
+__msg("5: (1c) w3 -= w1 {{.*}} R3=scalar(smin=umin=umin32=1,smax=umax=umax32=0x80000000,var_off=(0x0; 0xffffffff))")
 __retval(0)
 __naked void sub32_full_overflow(void)
 {
@@ -1517,7 +1517,7 @@ __naked void sub32_full_overflow(void)
 SEC("socket")
 __description("32-bit subtraction, partial overflow, result in unbounded u32 bounds")
 __success __log_level(2)
-__msg("3: (1c) w3 -= w2 {{.*}} R3_w=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))")
+__msg("3: (1c) w3 -= w2 {{.*}} R3=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))")
 __retval(0)
 __naked void sub32_partial_overflow(void)
 {
@@ -1617,7 +1617,7 @@ l0_%=:	r0 = 0;				\
 SEC("socket")
 __description("bounds deduction cross sign boundary, positive overlap")
 __success __log_level(2) __flag(BPF_F_TEST_REG_INVARIANTS)
-__msg("3: (2d) if r0 > r1 {{.*}} R0_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=127,var_off=(0x0; 0x7f))")
+__msg("3: (2d) if r0 > r1 {{.*}} R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=127,var_off=(0x0; 0x7f))")
 __retval(0)
 __naked void bounds_deduct_positive_overlap(void)
 {
@@ -1650,7 +1650,7 @@ l0_%=:	r0 = 0;				\
 SEC("socket")
 __description("bounds deduction cross sign boundary, two overlaps")
 __failure __flag(BPF_F_TEST_REG_INVARIANTS)
-__msg("3: (2d) if r0 > r1 {{.*}} R0_w=scalar(smin=smin32=-128,smax=smax32=127,umax=0xffffffffffffff80)")
+__msg("3: (2d) if r0 > r1 {{.*}} R0=scalar(smin=smin32=-128,smax=smax32=127,umax=0xffffffffffffff80)")
 __msg("frame pointer is read only")
 __naked void bounds_deduct_two_overlaps(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c b/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
index 181da86ba5f040f57c4cbba9a79c4a06d1759ce4..6630a92b1b47e75019ef8d4c7e5ee7e069766083 100644
--- a/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
+++ b/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
@@ -215,7 +215,7 @@ __weak int subprog_untrusted(const volatile struct task_struct *restrict task __
 SEC("tp_btf/sys_enter")
 __success
 __log_level(2)
-__msg("r1 = {{.*}}; {{.*}}R1_w=trusted_ptr_task_struct()")
+__msg("r1 = {{.*}}; {{.*}}R1=trusted_ptr_task_struct()")
 __msg("Func#1 ('subprog_untrusted') is global and assumed valid.")
 __msg("Validating subprog_untrusted() func#1...")
 __msg(": R1=untrusted_ptr_task_struct")
@@ -278,7 +278,7 @@ __weak int subprog_enum_untrusted(enum bpf_attach_type *p __arg_untrusted)
 SEC("tp_btf/sys_enter")
 __success
 __log_level(2)
-__msg("r1 = {{.*}}; {{.*}}R1_w=trusted_ptr_task_struct()")
+__msg("r1 = {{.*}}; {{.*}}R1=trusted_ptr_task_struct()")
 __msg("Func#1 ('subprog_void_untrusted') is global and assumed valid.")
 __msg("Validating subprog_void_untrusted() func#1...")
 __msg(": R1=rdonly_untrusted_mem(sz=0)")
diff --git a/tools/testing/selftests/bpf/progs/verifier_ldsx.c b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
index 52edee41caf674dab477e9f24a12827fcdc08e24..f087ffb79f203c7f321fac17da5f2bf18928b869 100644
--- a/tools/testing/selftests/bpf/progs/verifier_ldsx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
@@ -65,7 +65,7 @@ __naked void ldsx_s32(void)
 SEC("socket")
 __description("LDSX, S8 range checking, privileged")
 __log_level(2) __success __retval(1)
-__msg("R1_w=scalar(smin=smin32=-128,smax=smax32=127)")
+__msg("R1=scalar(smin=smin32=-128,smax=smax32=127)")
 __naked void ldsx_s8_range_priv(void)
 {
 	asm volatile (
diff --git a/tools/testing/selftests/bpf/progs/verifier_precision.c b/tools/testing/selftests/bpf/progs/verifier_precision.c
index 73fee2aec6983c5694ddd8a118fc75ba2a9b0420..1fe090cd6744950a48498d043c32c6561869ce81 100644
--- a/tools/testing/selftests/bpf/progs/verifier_precision.c
+++ b/tools/testing/selftests/bpf/progs/verifier_precision.c
@@ -144,21 +144,21 @@ SEC("?raw_tp")
 __success __log_level(2)
 /*
  * Without the bug fix there will be no history between "last_idx 3 first_idx 3"
- * and "parent state regs=" lines. "R0_w=6" parts are here to help anchor
+ * and "parent state regs=" lines. "R0=6" parts are here to help anchor
  * expected log messages to the one specific mark_chain_precision operation.
  *
  * This is quite fragile: if verifier checkpointing heuristic changes, this
  * might need adjusting.
  */
-__msg("2: (07) r0 += 1                       ; R0_w=6")
+__msg("2: (07) r0 += 1                       ; R0=6")
 __msg("3: (35) if r0 >= 0xa goto pc+1")
 __msg("mark_precise: frame0: last_idx 3 first_idx 3 subseq_idx -1")
 __msg("mark_precise: frame0: regs=r0 stack= before 2: (07) r0 += 1")
 __msg("mark_precise: frame0: regs=r0 stack= before 1: (07) r0 += 1")
 __msg("mark_precise: frame0: regs=r0 stack= before 4: (05) goto pc-4")
 __msg("mark_precise: frame0: regs=r0 stack= before 3: (35) if r0 >= 0xa goto pc+1")
-__msg("mark_precise: frame0: parent state regs= stack=:  R0_rw=P4")
-__msg("3: R0_w=6")
+__msg("mark_precise: frame0: parent state regs= stack=:  R0=P4")
+__msg("3: R0=6")
 __naked int state_loop_first_last_equal(void)
 {
 	asm volatile (
@@ -233,8 +233,8 @@ __naked void bpf_cond_op_not_r10(void)
 
 SEC("lsm.s/socket_connect")
 __success __log_level(2)
-__msg("0: (b7) r0 = 1                        ; R0_w=1")
-__msg("1: (84) w0 = -w0                      ; R0_w=0xffffffff")
+__msg("0: (b7) r0 = 1                        ; R0=1")
+__msg("1: (84) w0 = -w0                      ; R0=0xffffffff")
 __msg("mark_precise: frame0: last_idx 2 first_idx 0 subseq_idx -1")
 __msg("mark_precise: frame0: regs=r0 stack= before 1: (84) w0 = -w0")
 __msg("mark_precise: frame0: regs=r0 stack= before 0: (b7) r0 = 1")
@@ -268,8 +268,8 @@ __naked int bpf_neg_3(void)
 
 SEC("lsm.s/socket_connect")
 __success __log_level(2)
-__msg("0: (b7) r0 = 1                        ; R0_w=1")
-__msg("1: (87) r0 = -r0                      ; R0_w=-1")
+__msg("0: (b7) r0 = 1                        ; R0=1")
+__msg("1: (87) r0 = -r0                      ; R0=-1")
 __msg("mark_precise: frame0: last_idx 2 first_idx 0 subseq_idx -1")
 __msg("mark_precise: frame0: regs=r0 stack= before 1: (87) r0 = -r0")
 __msg("mark_precise: frame0: regs=r0 stack= before 0: (b7) r0 = 1")
diff --git a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
index dba3ca728f6e6f48e17940ec47e20cd4bfa211b2..c0ce690ddb68a7c5033e59d67004263d0e791a0c 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
@@ -353,7 +353,7 @@ __flag(BPF_F_TEST_STATE_FREQ)
  * collect_linked_regs() can't tie more than 6 registers for a single insn.
  */
 __msg("8: (25) if r0 > 0x7 goto pc+0         ; R0=scalar(id=1")
-__msg("9: (bf) r6 = r6                       ; R6_w=scalar(id=2")
+__msg("9: (bf) r6 = r6                       ; R6=scalar(id=2")
 /* check that r{0-5} are marked precise after 'if' */
 __msg("frame0: regs=r0 stack= before 8: (25) if r0 > 0x7 goto pc+0")
 __msg("frame0: parent state regs=r0,r1,r2,r3,r4,r5 stack=:")
@@ -779,12 +779,12 @@ __success
 __retval(0)
 /* Check that verifier believes r1/r0 are zero at exit */
 __log_level(2)
-__msg("4: (77) r1 >>= 32                     ; R1_w=0")
-__msg("5: (bf) r0 = r1                       ; R0_w=0 R1_w=0")
+__msg("4: (77) r1 >>= 32                     ; R1=0")
+__msg("5: (bf) r0 = r1                       ; R0=0 R1=0")
 __msg("6: (95) exit")
 __msg("from 3 to 4")
-__msg("4: (77) r1 >>= 32                     ; R1_w=0")
-__msg("5: (bf) r0 = r1                       ; R0_w=0 R1_w=0")
+__msg("4: (77) r1 >>= 32                     ; R1=0")
+__msg("5: (bf) r0 = r1                       ; R0=0 R1=0")
 __msg("6: (95) exit")
 /* Verify that statements to randomize upper half of r1 had not been
  * generated.
diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
index 1e5a511e8494afa75883f02a5ac1bfdf734e6988..7a13dbd794b2fb88038b529f1a954bc8e09e1644 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -506,17 +506,17 @@ SEC("raw_tp")
 __log_level(2)
 __success
 /* fp-8 is spilled IMPRECISE value zero (represented by a zero value fake reg) */
-__msg("2: (7a) *(u64 *)(r10 -8) = 0          ; R10=fp0 fp-8_w=0")
+__msg("2: (7a) *(u64 *)(r10 -8) = 0          ; R10=fp0 fp-8=0")
 /* but fp-16 is spilled IMPRECISE zero const reg */
-__msg("4: (7b) *(u64 *)(r10 -16) = r0        ; R0_w=0 R10=fp0 fp-16_w=0")
+__msg("4: (7b) *(u64 *)(r10 -16) = r0        ; R0=0 R10=fp0 fp-16=0")
 /* validate that assigning R2 from STACK_SPILL with zero value  doesn't mark register
  * precise immediately; if necessary, it will be marked precise later
  */
-__msg("6: (71) r2 = *(u8 *)(r10 -1)          ; R2_w=0 R10=fp0 fp-8_w=0")
+__msg("6: (71) r2 = *(u8 *)(r10 -1)          ; R2=0 R10=fp0 fp-8=0")
 /* similarly, when R2 is assigned from spilled register, it is initially
  * imprecise, but will be marked precise later once it is used in precise context
  */
-__msg("10: (71) r2 = *(u8 *)(r10 -9)         ; R2_w=0 R10=fp0 fp-16_w=0")
+__msg("10: (71) r2 = *(u8 *)(r10 -9)         ; R2=0 R10=fp0 fp-16=0")
 __msg("11: (0f) r1 += r2")
 __msg("mark_precise: frame0: last_idx 11 first_idx 0 subseq_idx -1")
 __msg("mark_precise: frame0: regs=r2 stack= before 10: (71) r2 = *(u8 *)(r10 -9)")
@@ -598,7 +598,7 @@ __log_level(2)
 __success
 /* fp-4 is STACK_ZERO */
 __msg("2: (62) *(u32 *)(r10 -4) = 0          ; R10=fp0 fp-8=0000????")
-__msg("4: (71) r2 = *(u8 *)(r10 -1)          ; R2_w=0 R10=fp0 fp-8=0000????")
+__msg("4: (71) r2 = *(u8 *)(r10 -1)          ; R2=0 R10=fp0 fp-8=0000????")
 __msg("5: (0f) r1 += r2")
 __msg("mark_precise: frame0: last_idx 5 first_idx 0 subseq_idx -1")
 __msg("mark_precise: frame0: regs=r2 stack= before 4: (71) r2 = *(u8 *)(r10 -1)")
@@ -640,25 +640,25 @@ SEC("raw_tp")
 __log_level(2) __flag(BPF_F_TEST_STATE_FREQ)
 __success
 /* make sure fp-8 is IMPRECISE fake register spill */
-__msg("3: (7a) *(u64 *)(r10 -8) = 1          ; R10=fp0 fp-8_w=1")
+__msg("3: (7a) *(u64 *)(r10 -8) = 1          ; R10=fp0 fp-8=1")
 /* and fp-16 is spilled IMPRECISE const reg */
-__msg("5: (7b) *(u64 *)(r10 -16) = r0        ; R0_w=1 R10=fp0 fp-16_w=1")
+__msg("5: (7b) *(u64 *)(r10 -16) = r0        ; R0=1 R10=fp0 fp-16=1")
 /* validate load from fp-8, which was initialized using BPF_ST_MEM */
-__msg("8: (79) r2 = *(u64 *)(r10 -8)         ; R2_w=1 R10=fp0 fp-8=1")
+__msg("8: (79) r2 = *(u64 *)(r10 -8)         ; R2=1 R10=fp0 fp-8=1")
 __msg("9: (0f) r1 += r2")
 __msg("mark_precise: frame0: last_idx 9 first_idx 7 subseq_idx -1")
 __msg("mark_precise: frame0: regs=r2 stack= before 8: (79) r2 = *(u64 *)(r10 -8)")
 __msg("mark_precise: frame0: regs= stack=-8 before 7: (bf) r1 = r6")
 /* note, fp-8 is precise, fp-16 is not yet precise, we'll get there */
-__msg("mark_precise: frame0: parent state regs= stack=-8:  R0_w=1 R1=ctx() R6_r=map_value(map=.data.two_byte_,ks=4,vs=2) R10=fp0 fp-8_rw=P1 fp-16_w=1")
+__msg("mark_precise: frame0: parent state regs= stack=-8:  R0=1 R1=ctx() R6=map_value(map=.data.two_byte_,ks=4,vs=2) R10=fp0 fp-8=P1 fp-16=1")
 __msg("mark_precise: frame0: last_idx 6 first_idx 3 subseq_idx 7")
 __msg("mark_precise: frame0: regs= stack=-8 before 6: (05) goto pc+0")
 __msg("mark_precise: frame0: regs= stack=-8 before 5: (7b) *(u64 *)(r10 -16) = r0")
 __msg("mark_precise: frame0: regs= stack=-8 before 4: (b7) r0 = 1")
 __msg("mark_precise: frame0: regs= stack=-8 before 3: (7a) *(u64 *)(r10 -8) = 1")
-__msg("10: R1_w=map_value(map=.data.two_byte_,ks=4,vs=2,off=1) R2_w=1")
+__msg("10: R1=map_value(map=.data.two_byte_,ks=4,vs=2,off=1) R2=1")
 /* validate load from fp-16, which was initialized using BPF_STX_MEM */
-__msg("12: (79) r2 = *(u64 *)(r10 -16)       ; R2_w=1 R10=fp0 fp-16=1")
+__msg("12: (79) r2 = *(u64 *)(r10 -16)       ; R2=1 R10=fp0 fp-16=1")
 __msg("13: (0f) r1 += r2")
 __msg("mark_precise: frame0: last_idx 13 first_idx 7 subseq_idx -1")
 __msg("mark_precise: frame0: regs=r2 stack= before 12: (79) r2 = *(u64 *)(r10 -16)")
@@ -668,12 +668,12 @@ __msg("mark_precise: frame0: regs= stack=-16 before 9: (0f) r1 += r2")
 __msg("mark_precise: frame0: regs= stack=-16 before 8: (79) r2 = *(u64 *)(r10 -8)")
 __msg("mark_precise: frame0: regs= stack=-16 before 7: (bf) r1 = r6")
 /* now both fp-8 and fp-16 are precise, very good */
-__msg("mark_precise: frame0: parent state regs= stack=-16:  R0_w=1 R1=ctx() R6_r=map_value(map=.data.two_byte_,ks=4,vs=2) R10=fp0 fp-8_rw=P1 fp-16_rw=P1")
+__msg("mark_precise: frame0: parent state regs= stack=-16:  R0=1 R1=ctx() R6=map_value(map=.data.two_byte_,ks=4,vs=2) R10=fp0 fp-8=P1 fp-16=P1")
 __msg("mark_precise: frame0: last_idx 6 first_idx 3 subseq_idx 7")
 __msg("mark_precise: frame0: regs= stack=-16 before 6: (05) goto pc+0")
 __msg("mark_precise: frame0: regs= stack=-16 before 5: (7b) *(u64 *)(r10 -16) = r0")
 __msg("mark_precise: frame0: regs=r0 stack= before 4: (b7) r0 = 1")
-__msg("14: R1_w=map_value(map=.data.two_byte_,ks=4,vs=2,off=1) R2_w=1")
+__msg("14: R1=map_value(map=.data.two_byte_,ks=4,vs=2,off=1) R2=1")
 __naked void stack_load_preserves_const_precision(void)
 {
 	asm volatile (
@@ -719,22 +719,22 @@ __success
 /* make sure fp-8 is 32-bit FAKE subregister spill */
 __msg("3: (62) *(u32 *)(r10 -8) = 1          ; R10=fp0 fp-8=????1")
 /* but fp-16 is spilled IMPRECISE zero const reg */
-__msg("5: (63) *(u32 *)(r10 -16) = r0        ; R0_w=1 R10=fp0 fp-16=????1")
+__msg("5: (63) *(u32 *)(r10 -16) = r0        ; R0=1 R10=fp0 fp-16=????1")
 /* validate load from fp-8, which was initialized using BPF_ST_MEM */
-__msg("8: (61) r2 = *(u32 *)(r10 -8)         ; R2_w=1 R10=fp0 fp-8=????1")
+__msg("8: (61) r2 = *(u32 *)(r10 -8)         ; R2=1 R10=fp0 fp-8=????1")
 __msg("9: (0f) r1 += r2")
 __msg("mark_precise: frame0: last_idx 9 first_idx 7 subseq_idx -1")
 __msg("mark_precise: frame0: regs=r2 stack= before 8: (61) r2 = *(u32 *)(r10 -8)")
 __msg("mark_precise: frame0: regs= stack=-8 before 7: (bf) r1 = r6")
-__msg("mark_precise: frame0: parent state regs= stack=-8:  R0_w=1 R1=ctx() R6_r=map_value(map=.data.two_byte_,ks=4,vs=2) R10=fp0 fp-8_r=????P1 fp-16=????1")
+__msg("mark_precise: frame0: parent state regs= stack=-8:  R0=1 R1=ctx() R6=map_value(map=.data.two_byte_,ks=4,vs=2) R10=fp0 fp-8=????P1 fp-16=????1")
 __msg("mark_precise: frame0: last_idx 6 first_idx 3 subseq_idx 7")
 __msg("mark_precise: frame0: regs= stack=-8 before 6: (05) goto pc+0")
 __msg("mark_precise: frame0: regs= stack=-8 before 5: (63) *(u32 *)(r10 -16) = r0")
 __msg("mark_precise: frame0: regs= stack=-8 before 4: (b7) r0 = 1")
 __msg("mark_precise: frame0: regs= stack=-8 before 3: (62) *(u32 *)(r10 -8) = 1")
-__msg("10: R1_w=map_value(map=.data.two_byte_,ks=4,vs=2,off=1) R2_w=1")
+__msg("10: R1=map_value(map=.data.two_byte_,ks=4,vs=2,off=1) R2=1")
 /* validate load from fp-16, which was initialized using BPF_STX_MEM */
-__msg("12: (61) r2 = *(u32 *)(r10 -16)       ; R2_w=1 R10=fp0 fp-16=????1")
+__msg("12: (61) r2 = *(u32 *)(r10 -16)       ; R2=1 R10=fp0 fp-16=????1")
 __msg("13: (0f) r1 += r2")
 __msg("mark_precise: frame0: last_idx 13 first_idx 7 subseq_idx -1")
 __msg("mark_precise: frame0: regs=r2 stack= before 12: (61) r2 = *(u32 *)(r10 -16)")
@@ -743,12 +743,12 @@ __msg("mark_precise: frame0: regs= stack=-16 before 10: (73) *(u8 *)(r1 +0) = r2
 __msg("mark_precise: frame0: regs= stack=-16 before 9: (0f) r1 += r2")
 __msg("mark_precise: frame0: regs= stack=-16 before 8: (61) r2 = *(u32 *)(r10 -8)")
 __msg("mark_precise: frame0: regs= stack=-16 before 7: (bf) r1 = r6")
-__msg("mark_precise: frame0: parent state regs= stack=-16:  R0_w=1 R1=ctx() R6_r=map_value(map=.data.two_byte_,ks=4,vs=2) R10=fp0 fp-8_r=????P1 fp-16_r=????P1")
+__msg("mark_precise: frame0: parent state regs= stack=-16:  R0=1 R1=ctx() R6=map_value(map=.data.two_byte_,ks=4,vs=2) R10=fp0 fp-8=????P1 fp-16=????P1")
 __msg("mark_precise: frame0: last_idx 6 first_idx 3 subseq_idx 7")
 __msg("mark_precise: frame0: regs= stack=-16 before 6: (05) goto pc+0")
 __msg("mark_precise: frame0: regs= stack=-16 before 5: (63) *(u32 *)(r10 -16) = r0")
 __msg("mark_precise: frame0: regs=r0 stack= before 4: (b7) r0 = 1")
-__msg("14: R1_w=map_value(map=.data.two_byte_,ks=4,vs=2,off=1) R2_w=1")
+__msg("14: R1=map_value(map=.data.two_byte_,ks=4,vs=2,off=1) R2=1")
 __naked void stack_load_preserves_const_precision_subreg(void)
 {
 	asm volatile (
diff --git a/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
index 9d415f7ce599b06b5783e0e11f0b43c78544dae9..ac3e418c2a9616f9d6329ff50ce97cf357ed80dd 100644
--- a/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
+++ b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
@@ -105,7 +105,7 @@ __msg("mark_precise: frame0: regs=r0 stack= before 4: (27) r0 *= 4")
 __msg("mark_precise: frame0: regs=r0 stack= before 3: (57) r0 &= 3")
 __msg("mark_precise: frame0: regs=r0 stack= before 10: (95) exit")
 __msg("mark_precise: frame1: regs=r0 stack= before 9: (bf) r0 = (s8)r10")
-__msg("7: R0_w=scalar")
+__msg("7: R0=scalar")
 __naked int fp_precise_subprog_result(void)
 {
 	asm volatile (
@@ -141,7 +141,7 @@ __msg("mark_precise: frame1: regs=r0 stack= before 10: (bf) r0 = (s8)r1")
  * anyways, at which point we'll break precision chain
  */
 __msg("mark_precise: frame1: regs=r1 stack= before 9: (bf) r1 = r10")
-__msg("7: R0_w=scalar")
+__msg("7: R0=scalar")
 __naked int sneaky_fp_precise_subprog_result(void)
 {
 	asm volatile (
@@ -681,7 +681,7 @@ __msg("mark_precise: frame0: last_idx 10 first_idx 7 subseq_idx -1")
 __msg("mark_precise: frame0: regs=r7 stack= before 9: (bf) r1 = r8")
 __msg("mark_precise: frame0: regs=r7 stack= before 8: (27) r7 *= 4")
 __msg("mark_precise: frame0: regs=r7 stack= before 7: (79) r7 = *(u64 *)(r10 -8)")
-__msg("mark_precise: frame0: parent state regs= stack=-8:  R0_w=2 R6_w=1 R8_rw=map_value(map=.data.vals,ks=4,vs=16) R10=fp0 fp-8_rw=P1")
+__msg("mark_precise: frame0: parent state regs= stack=-8:  R0=2 R6=1 R8=map_value(map=.data.vals,ks=4,vs=16) R10=fp0 fp-8=P1")
 __msg("mark_precise: frame0: last_idx 18 first_idx 0 subseq_idx 7")
 __msg("mark_precise: frame0: regs= stack=-8 before 18: (95) exit")
 __msg("mark_precise: frame1: regs= stack= before 17: (0f) r0 += r2")
diff --git a/tools/testing/selftests/bpf/verifier/bpf_st_mem.c b/tools/testing/selftests/bpf/verifier/bpf_st_mem.c
index b616575c3b00a5b74a5e4af180fe91004258e506..ce13002c7a199b72dd3990c92135ca4b7c7a7ea6 100644
--- a/tools/testing/selftests/bpf/verifier/bpf_st_mem.c
+++ b/tools/testing/selftests/bpf/verifier/bpf_st_mem.c
@@ -93,7 +93,7 @@
 	.expected_attach_type = BPF_SK_LOOKUP,
 	.result = VERBOSE_ACCEPT,
 	.runs = -1,
-	.errstr = "0: (7a) *(u64 *)(r10 -8) = -44        ; R10=fp0 fp-8_w=-44\
+	.errstr = "0: (7a) *(u64 *)(r10 -8) = -44        ; R10=fp0 fp-8=-44\
 	2: (c5) if r0 s< 0x0 goto pc+2\
-	R0_w=-44",
+	R0=-44",
 },

-- 
2.51.0

