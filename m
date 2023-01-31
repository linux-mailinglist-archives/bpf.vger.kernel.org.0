Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E75856834EA
	for <lists+bpf@lfdr.de>; Tue, 31 Jan 2023 19:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjAaSMj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Jan 2023 13:12:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjAaSMi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Jan 2023 13:12:38 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A86119F1A
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 10:12:36 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id h16so15027150wrz.12
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 10:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=trDbRUz9AF2fvMgGmpirVH+BfZoMCPR9mWNPNQIEIg4=;
        b=Qi8Vkf7rFPSx7adLDMgDehuiM34jrAYggH7CItVBc51UiFTdRUbc/wox3STwd/hjIb
         jaw0/hZ51Jt+VDyE/UnRJFkXWOgqsf53gX7LdYs3mVgIUI9hI0NfholVsLN3C6fOFmgk
         PixRoA6svswhVNT8xy14DlRSZxVmhJBn+0uFp50RxJ1LLWTLtK+t819vCYnNZ9Ecttl4
         Z+gSmNG/ZQkawlS/hd9xmZccmj0ESkkVzy4ZO49S3KiQSYW0hqdp1ZuxVDzgTlo0eLo2
         CEDrpTkw9IZ+qpZwhXyR+OZ/NsNqztD5G1tkRY6rVjQwhSX1oKUdeOtNuWM4RfSLyEMy
         nuxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=trDbRUz9AF2fvMgGmpirVH+BfZoMCPR9mWNPNQIEIg4=;
        b=rfs25DPRg59Rc21c0pSJfagMp6wMkMTip86PVZfyJiZQJaB+FU9RHQc9/MFM7SdC/z
         hqReeGCVOu1GRKIytAJb1mKiqY4VDj0ipFEmfcnYX9H3jgthdzRyOhDgUHm7s/i0o4Om
         E1AVPKcBF31XARp0PNSTnvOvXLza05ckinUasjj7bhNgVQ0xCUi7Ak/AL1pAM6mTkJOY
         Qmn72dQHTJKhu0xYTn+CKGVwVkhA325Bb61iBJCFpQ3jWp1uyR4ih+LiBi1KzG3jCwf9
         iPcZRgkDtlHMZNDsm01q1gN+T3Vwl7rNduGHqoSV0VXW8aiBnSQWHyvE+xbTU5ziaX70
         dBGw==
X-Gm-Message-State: AO0yUKXN1hi4Jir2u8thmK3zgnhXNhXnAZQS8UAiZUCYluU1kizlPHGT
        UrOo7BaPJEq1iAaDBDAPHVE8yIgSI//ZdA==
X-Google-Smtp-Source: AK7set8lENvLktim4ClvCCQXVT/VtsfN7RyxdWjuoMXcPto+kEHAd/iP4d4Ir2Wi0xjValzJKAst2g==
X-Received: by 2002:adf:fcd2:0:b0:2bf:bdbd:25c1 with SMTP id f18-20020adffcd2000000b002bfbdbd25c1mr3543474wrs.26.1675188754595;
        Tue, 31 Jan 2023 10:12:34 -0800 (PST)
Received: from pluto.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id z12-20020a5d4d0c000000b002bbb2d43f65sm15409044wrt.14.2023.01.31.10.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 10:12:34 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com, ecree.xilinx@gmail.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 1/1] docs/bpf: Add description of register liveness tracking algorithm
Date:   Tue, 31 Jan 2023 20:11:18 +0200
Message-Id: <20230131181118.733845-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230131181118.733845-1-eddyz87@gmail.com>
References: <20230131181118.733845-1-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is a followup for [1], adds an overview for the register liveness
tracking, covers the following points:
- why register liveness tracking is useful;
- how register parentage chains are constructed;
- how liveness marks are applied using the parentage chains.

[1] https://lore.kernel.org/bpf/CAADnVQKs2i1iuZ5SUGuJtxWVfGYR9kDgYKhq3rNV+kBLQCu7rA@mail.gmail.com/

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 Documentation/bpf/verifier.rst | 280 +++++++++++++++++++++++++++++++++
 1 file changed, 280 insertions(+)

diff --git a/Documentation/bpf/verifier.rst b/Documentation/bpf/verifier.rst
index 3afa548ec28c..34093d60fe87 100644
--- a/Documentation/bpf/verifier.rst
+++ b/Documentation/bpf/verifier.rst
@@ -316,6 +316,286 @@ Pruning considers not only the registers but also the stack (and any spilled
 registers it may hold).  They must all be safe for the branch to be pruned.
 This is implemented in states_equal().
 
+Some technical details about state pruning implementation could be found below.
+
+Register liveness tracking
+==========================
+
+In order to make state pruning effective, liveness state is tracked for each
+register and stack slot. The basic idea is to track which registers and stack
+slots are actually used during subseqeuent execution of the program, until
+program exit is reached. Registers and stack slots that were never used could be
+removed from the cached state thus making more states equivalent to a cached
+state. This could be illustrated by the following program::
+
+  0: call bpf_get_prandom_u32()
+  1: r1 = 0
+  2: if r0 == 0 goto +1
+  3: r0 = 1
+  --- checkpoint ---
+  4: r0 = r1
+  5: exit
+
+Suppose that a state cache entry is created at instruction #4 (such entries are
+also called "checkpoints" in the text below). The verifier could reach the
+instruction with one of two possible register states:
+
+* r0 = 1, r1 = 0
+* r0 = 0, r1 = 0
+
+However, only the value of register ``r1`` is important to successfully finish
+verification. The goal of the liveness tracking algorithm is to spot this fact
+and figure out that both states are actually equivalent.
+
+Data structures
+===============
+
+Liveness is tracked using the following data structures::
+
+  enum bpf_reg_liveness {
+	REG_LIVE_NONE = 0,
+	REG_LIVE_READ32 = 0x1,
+	REG_LIVE_READ64 = 0x2,
+	REG_LIVE_READ = REG_LIVE_READ32 | REG_LIVE_READ64,
+	REG_LIVE_WRITTEN = 0x4,
+	REG_LIVE_DONE = 0x8,
+  };
+
+  struct bpf_reg_state {
+ 	...
+	struct bpf_reg_state *parent;
+ 	...
+	enum bpf_reg_liveness live;
+ 	...
+  };
+
+  struct bpf_stack_state {
+	struct bpf_reg_state spilled_ptr;
+	...
+  };
+
+  struct bpf_func_state {
+	struct bpf_reg_state regs[MAX_BPF_REG];
+        ...
+	struct bpf_stack_state *stack;
+  }
+
+  struct bpf_verifier_state {
+	struct bpf_func_state *frame[MAX_CALL_FRAMES];
+	struct bpf_verifier_state *parent;
+        ...
+  }
+
+* ``REG_LIVE_NONE`` is an initial value assigned to ``->live`` fields upon new
+  verifier state creation;
+
+* ``REG_LIVE_WRITTEN`` means that the value of the register (or stack slot) is
+  defined by some instruction "executed" within verifier state;
+
+* ``REG_LIVE_READ{32,64}`` means that the value of the register (or stack slot)
+  is read by some instruction "executed" within verifier state;
+
+* ``REG_LIVE_DONE`` is a marker used by ``clean_verifier_state()`` to avoid
+  processing same verifier state multiple times and for some sanity checks;
+
+* ``->live`` field values are formed by combining ``enum bpf_reg_liveness``
+  values using bitwise or.
+
+Register parentage chains
+=========================
+
+In order to propagate information between parent and child states, a *register
+parentage chain* is established. Each register or stack slot is linked to a
+corresponding register or stack slot in its parent state via a ``->parent``
+pointer. This link is established upon state creation in ``is_state_visited()``
+and might be modified by ``set_callee_state()`` called from
+``__check_func_call()``.
+
+The rules for correspondence between registers / stack slots are as follows:
+
+* For the current stack frame, registers and stack slots of the new state are
+  linked to the registers and stack slots of the parent state with the same
+  indices.
+
+* For the outer stack frames, only caller saved registers (r6-r9) and stack
+  slots are linked to the registers and stack slots of the parent state with the
+  same indices.
+
+* When function call is processed a new ``struct bpf_func_state`` instance is
+  allocated, it encapsulates a new set of registers and stack slots. For this
+  new frame, parent links for r6-r9 and stack slots are set to nil, parent links
+  for r1-r5 are set to match caller r1-r5 parent links.
+
+This could be illustrated by the following diagram (arrows stand for
+``->parent`` pointers)::
+
+      ...                    ; Frame #0, some instructions
+  --- checkpoint #0 ---
+  1 : r6 = 42                ; Frame #0
+  --- checkpoint #1 ---
+  2 : call foo()             ; Frame #0
+      ...                    ; Frame #1, instructions from foo()
+  --- checkpoint #2 ---
+      ...                    ; Frame #1, instructions from foo()
+  --- checkpoint #3 ---
+      exit                   ; Frame #1, return from foo()
+  3 : r1 = r6                ; Frame #0  <- current state
+
+             +-------------------------------+-------------------------------+
+             |           Frame #0            |           Frame #1            |
+  Checkpoint +-------------------------------+-------------------------------+
+  #0         | r0 | r1-r5 | r6-r9 | fp-8 ... |
+             +-------------------------------+
+                ^    ^       ^       ^
+                |    |       |       |
+  Checkpoint +-------------------------------+
+  #1         | r0 | r1-r5 | r6-r9 | fp-8 ... |
+             +-------------------------------+
+                     ^       ^       ^
+                     |_______|_______|_______________
+                             |       |               |
+               nil  nil      |       |               |      nil     nil
+                |    |       |       |               |       |       |
+  Checkpoint +-------------------------------+-------------------------------+
+  #2         | r0 | r1-r5 | r6-r9 | fp-8 ... | r0 | r1-r5 | r6-r9 | fp-8 ... |
+             +-------------------------------+-------------------------------+
+                             ^       ^               ^       ^       ^
+               nil  nil      |       |               |       |       |
+                |    |       |       |               |       |       |
+  Checkpoint +-------------------------------+-------------------------------+
+  #3         | r0 | r1-r5 | r6-r9 | fp-8 ... | r0 | r1-r5 | r6-r9 | fp-8 ... |
+             +-------------------------------+-------------------------------+
+                             ^       ^
+               nil  nil      |       |
+                |    |       |       |
+  Current    +-------------------------------+
+  state      | r0 | r1-r5 | r6-r9 | fp-8 ... |
+             +-------------------------------+
+                             \
+                               r6 read mark is propagated via
+                               these links all the way up to
+                               checkpoint #1.
+
+Liveness marks tracking
+=======================
+
+For each processed instruction, the verifier propagates information about reads
+up the parentage chain and saves information about writes in the current state.
+The information about reads is propagated by function ``mark_reg_read()`` which
+could be summarized as follows::
+
+  mark_reg_read(struct bpf_reg_state *state):
+      parent = state->parent
+      while parent:
+          if parent->live & REG_LIVE_WRITTEN:
+              break
+          if parent->live & REG_LIVE_READ64:
+              break
+          parent->live |= REG_LIVE_READ64
+          state = parent
+          parent = state->parent
+
+Note: details about REG_LIVE_READ32 are omitted.
+
+Also note: the read marks are applied to the **parent** state while write marks
+are applied to the **current** state.
+
+Because stack writes could have different sizes ``REG_LIVE_WRITTEN`` marks are
+applied conservatively: stack slots are marked as written only if write size
+corresponds to the size of the register, e.g. see function ``save_register_state()``.
+
+Consider the following example::
+
+  0: (*u64)(r10 - 8) = 0   ; define 8 bytes of fp-8
+  --- checkpoint #0 ---
+  1: (*u32)(r10 - 8) = 1   ; redefine lower 4 bytes
+  2: r1 = (*u32)(r10 - 8)  ; read lower 4 bytes defined at (1)
+  3: r2 = (*u32)(r10 - 4)  ; read upper 4 bytes defined at (0)
+
+As stated above, the write at (1) does not count as ``REG_LIVE_WRITTEN``. Should
+it be otherwise, the algorithm above wouldn't be able to propagate the read mark
+from (3) to checkpoint #0.
+
+Once the ``BPF_EXIT`` instruction is reached ``update_branch_counts()`` is
+called to update the ``->branches`` counter for each verifier state in a chain
+of parent verifier states. When the ``->branches`` counter reaches zero the
+verifier state becomes a valid entry in a set of cached verifier states.
+
+Each entry of the verifier states cache is post-processed by a function
+``clean_live_states()``. This function marks all registers and stack slots
+without ``REG_LIVE_READ{32,64}`` marks as ``NOT_INIT`` or ``STACK_INVALID``.
+Registers/stack slots marked in this way are ignored in function ``stacksafe()``
+called from ``states_equal()`` when a state cache entry is considered for
+equivalence with a current state.
+
+Now it is possible to explain how the example from the beginning of the section
+works::
+
+  0: call bpf_get_prandom_u32()
+  1: r1 = 0
+  2: if r0 == 0 goto +1
+  3: r0 = 1
+  --- checkpoint[0] ---
+  4: r0 = r1
+  5: exit
+
+* At instruction #2 branching point is reached and state ``{ r0 == 0, r1 == 0, pc == 4 }``
+  is pushed to states processing queue (pc stands for program counter).
+
+* At instruction #4:
+
+  * ``checkpoint[0]`` states cache entry is created: ``{ r0 == 1, r1 == 0, pc == 4 }``;
+  * ``checkpoint[0].r0`` is marked as written;
+  * ``checkpoint[0].r1`` is marked as read;
+
+* At instruction #5 exit is reached and ``checkpoint[0]`` can now be processed
+  by ``clean_live_states()``. After this processing ``checkpoint[0].r0`` has a
+  read mark and all other registers and stack slots are marked as ``NOT_INIT``
+  or ``STACK_INVALID``
+
+* The state ``{ r0 == 0, r1 == 0, pc == 4 }`` is popped from the states queue
+  and is compared against a cached state ``{ r1 == 0, pc == 4 }``, the states
+  are considered equivalent.
+
+Read marks propagation for cache hits
+=====================================
+
+Another point is the handling of read marks when a previously verified state is
+found in the states cache. Upon cache hit verifier must behave in the same way
+as if the current state was verified to the program exit. This means that all
+read marks, present on registers and stack slots of the cached state, must be
+propagated over the parentage chain of the current state. Example below shows
+why this is important. Function ``propagate_liveness()`` handles this case.
+
+Consider the following state parentage chain (S is a starting state, A-E are
+derived states, -> arrows show which state is derived from which)::
+
+                   r1 read
+            <-------------                A[r1] == 0
+                                          C[r1] == 0
+      S ---> A ---> B ---> exit           E[r1] == 1
+      |
+      ` ---> C ---> D
+      |
+      ` ---> E      ^
+                    |___   suppose all these
+             ^           states are at insn #Y
+             |
+      suppose all these
+    states are at insn #X
+
+* Chain of states ``S -> A -> B -> exit`` is verified first.
+
+* While ``B -> exit`` is verified, register ``r1`` is read and this read mark is
+  propagated up to state ``A``.
+
+* When chain of states ``C -> D`` is verified the state ``D`` turns out to be
+  equivalent to state ``B``.
+
+* The read mark for ``r1`` has to be propagated to state ``C``, otherwise state
+  ``C`` might get mistakenly marked as equivalent to state ``E`` even though
+  values for register ``r1`` differ between ``C`` and ``E``.
+
 Understanding eBPF verifier messages
 ====================================
 
-- 
2.39.0

