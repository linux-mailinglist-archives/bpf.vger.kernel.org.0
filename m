Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4784967A55B
	for <lists+bpf@lfdr.de>; Tue, 24 Jan 2023 23:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235135AbjAXWFJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Jan 2023 17:05:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjAXWFG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Jan 2023 17:05:06 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FAAD51C7D
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 14:04:48 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id z5so15275458wrt.6
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 14:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J/UK0qtjLMB11M8mYi7P8nvQNDDPoiLkKRn38oJiu68=;
        b=To3kPVhzj1LMch6VZp/eExmPcXl8m6lpMHVrvmh2vHE7cWcWyjgcyXN2t6kyVlFNpS
         d+2Iu7D96XN7Pepdamz/0jPqi++cbAHnBiIUWHOYhSJou/GIvHfzDMqgTNzInPlK70Ss
         EiNdtLLPpvr2gETHbISIaCqCsEg3YuWO6vU8dLp3SmzJtmJwBJ1omkU7Wg0Ij6Hxz9n2
         E2GG0Mh1nlNt4RRByuxZXNm3XWvO/mtHQxkhwC1lezAJNX2Val4aFG9I5WMBGyThbzW0
         UiBrJE6RfWbNGIg/YG5FYkj+/FJaDETsyCX+PjSPjqamtNJfGYMgEqhvKDSF4uSq9wGf
         OPHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J/UK0qtjLMB11M8mYi7P8nvQNDDPoiLkKRn38oJiu68=;
        b=QBa0Gmkeg4iZJl3/q8Sh6JRjXGoYwdgg1kTde5jtHGyFeN04A5KT9tnJkSB8+NtlFQ
         ri/XJPvqpxyq053ZnWlUEBv6EvvlnkHv0XB5g7eMIW3RssShpgHNBzGQiDaSZk+kwgIR
         bc+k4yYZNHCCZOUB1yHYnTMKDZRMlLHUV6pgiCijUzDi4jMVjVS09SXjJF2fbEMkuAZ+
         OD7zYEmueb7HVVDUWcV4U+OGz7p9wSmd8ovoLuqRlraskwSd1672Ia5szaUta2LHA8WL
         yV4WwoXjzt7/HT4O3N4YBoai47YByYNFOLeOvCL9kUTlfEPPLkg5kG/lq7XcLiSSRprN
         EFTw==
X-Gm-Message-State: AFqh2kpqHjoFWff0azDVh2jmocxrcgt5mvn308JP0BHxDU1BQ1ToHmId
        SQW1GefQnwPl11y/jhc2ovNUI2dzbYM=
X-Google-Smtp-Source: AMrXdXvuGhDoEhsT30jlFoojQg/rLSiXBbF5GvzNeTBvwc9Nf8Ggw1fBWHJN55oBvdBv34+3j1GExQ==
X-Received: by 2002:a05:6000:1c04:b0:232:be5d:5ee9 with SMTP id ba4-20020a0560001c0400b00232be5d5ee9mr28814230wrb.64.1674597881991;
        Tue, 24 Jan 2023 14:04:41 -0800 (PST)
Received: from pluto.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id q14-20020adff78e000000b002be07cbefb2sm3348974wrp.18.2023.01.24.14.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 14:04:40 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, Eduard Zingerman <eddyz87@gmail.com>
Subject: [RFC bpf-next] docs/bpf: Add description of register liveness tracking algorithm
Date:   Wed, 25 Jan 2023 00:03:43 +0200
Message-Id: <20230124220343.2942203-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.39.0
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
 Documentation/bpf/verifier.rst | 237 +++++++++++++++++++++++++++++++++
 1 file changed, 237 insertions(+)

diff --git a/Documentation/bpf/verifier.rst b/Documentation/bpf/verifier.rst
index d4326caf01f9..77578ed5a277 100644
--- a/Documentation/bpf/verifier.rst
+++ b/Documentation/bpf/verifier.rst
@@ -316,6 +316,243 @@ Pruning considers not only the registers but also the stack (and any spilled
 registers it may hold).  They must all be safe for the branch to be pruned.
 This is implemented in states_equal().
 
+Some technical details about state pruning implementation could be found below.
+
+Register liveness tracking
+--------------------------
+
+In order to make state pruning effective liveness state is tracked for each
+register and stack spill slot. The basic idea is to identify which registers or
+stack slots were used by children of the state to reach the program exit.
+Registers that were never used could be removed from the cached state thus
+making more states equivalent to a cached state. This could be illustrated by
+the following program::
+
+  0: call bpf_get_prandom_u32()
+  1: r1 = 0
+  2: if r0 == 0 goto +1
+  3: r0 = 1
+  --- checkpoint ---
+  4: r0 = r1
+  5: exit
+
+Suppose that state cache entry is created at instruction #4 (such entries are
+also called "checkpoints" in the text below), verifier reaches this instruction
+in two states:
+* r0 = 1, r1 = 0
+* r0 = 0, r1 = 0
+
+However, only the value of register ``r1`` is important to successfully finish
+verification. The goal of liveness tracking algorithm is to spot this fact and
+figure out that both states are actually equivalent.
+
+Data structures
+~~~~~~~~~~~~~~~
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
+* ``REG_LIVE_WRITTEN`` means that the value of the register (or spill slot) is
+  defined by some instruction "executed" within verifier state;
+* ``REG_LIVE_READ{32,64}`` means that the value of the register (or spill slot)
+  is read by some instruction "executed" within verifier state;
+* ``REG_LIVE_DONE`` is a marker used by ``clean_verifier_state()`` to avoid
+  processing same verifier state multiple times and for some sanity checks;
+* ``->live`` field values are formed by combining ``enum bpf_reg_liveness``
+  values using bitwise or.
+
+Register parent chains
+~~~~~~~~~~~~~~~~~~~~~~
+  
+In order to propagate information between parent and child states register
+parentage chain is established. Each register or spilled stack slot is linked to
+a corresponding register or stack spill slot in it's parent state via a
+``->parent`` pointer. This link is established upon state creation in function
+``is_state_visited()`` and is never changed.
+
+The rules for correspondence between registers / stack spill slots are as
+follows:
+
+* For current stack frame registers and stack spill slots of the new state are
+  linked to the registers and stack spill slots of the parent state with the
+  same indices.
+
+* For outer stack frames only caller saved registers (r6-r9) and stack spill
+  slots are linked to the registers and stack spill slots of the parent state
+  with the same indices.
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
+             +--------------------------+--------------------------+ 
+             |         Frame #0         |         Frame #1         |
+  Checkpoint +--------------------------+--------------------------+
+  #0         | r0-r5 | r6-r9 | fp-8 ... |                           
+             +--------------------------+                           
+                ^       ^       ^
+                |       |       |          
+  Checkpoint +--------------------------+                           
+  #1         | r0-r5 | r6-r9 | fp-8 ... |                           
+             +--------------------------+
+                        ^       ^                           
+                        |       |                           
+  Checkpoint +--------------------------+--------------------------+
+  #2         | r0-r5 | r6-r9 | fp-8 ... | r0-r5 | r6-r9 | fp-8 ... |
+             +--------------------------+--------------------------+
+                        ^       ^          ^       ^      ^  
+                        |       |          |       |      |
+  Checkpoint +--------------------------+--------------------------+
+  #3         | r0-r5 | r6-r9 | fp-8 ... | r0-r5 | r6-r9 | fp-8 ... |
+             +--------------------------+--------------------------+
+                        ^       ^
+                        |       |          
+  Current    +--------------------------+                           
+  state      | r0-r5 | r6-r9 | fp-8 ... |                           
+             +--------------------------+
+                        \           
+                          r6 read mark is propagated via
+                          these links all the way up to
+                          checkpoint #1.
+
+Liveness marks tracking
+~~~~~~~~~~~~~~~~~~~~~~~
+
+For each processed instruction verifier propagates information about reads up
+the parentage chain and saves information about writes in the current state.
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
+Also note: the read marks are applied to the *parent* state while write marks
+are applied to the *current* state.
+
+Because stack writes could have different sizes ``REG_LIVE_WRITTEN`` marks are
+applied conservatively: stack spills are marked as written only if write size
+corresponds to the size of the register, see function ``save_register_state()``
+for an example.
+
+Once ``BPF_EXIT`` instruction is reached function ``update_branch_counts()`` is
+called to update the ``->branches`` counter for each verifier state in a chain
+of parent verifier states. When ``->branches`` counter reaches zero the verifier
+state becomes a valid entry in a set of cached verifier states.
+
+Each entry of the verifier states cache is post-processed by a function
+``clean_live_states()``. This function marks all registers and stack spills
+without ``REG_LIVE_READ{32,64}`` marks as ``NOT_INIT`` or ``STACK_INVALID``.
+Registers/stack spills marked in this way are ignored in function ``stacksafe()``
+called from ``states_equal()`` when state cache entry is considered for
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
+* At instruction #4:
+  
+  * ``checkpoint[0]`` states cache entry is created: ``{ r0 == 1, r1 == 0, pc == 4 }``;
+  * ``checkpoint[0].r0`` is marked as written;
+  * ``checkpoint[0].r1`` is marked as read;
+
+* At instruction #5 exit is reached and ``checkpoint[0]`` can now be processed
+  by ``clean_live_states()``, after this processing ``checkpoint[0].r0`` has a
+  read mark and all other registers and stack spills are marked as ``NOT_INIT``
+  or ``STACK_INVALID``
+* The state ``{ r0 == 0, r1 == 0, pc == 4 }`` is popped from the states queue
+  and is compared against a cached state ``{ r1 == 0, pc == 4 }``, the states
+  are considered equivalent.
+
+Read marks propagation for cache hits
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Another important point is handling of read marks when a previously verified
+state is found in the states cache. All read marks present on registers and
+stack spills of the cached state must be propagated over the parentage chain of
+the current state. Function ``propagate_liveness()`` handles this case.
+
+For example, consider the following state parentage chain::
+
+          +---+  
+   A ---> | B | ---> exit
+          |   |
+   C ---> | D |
+          +---+
+         
+* Chain ``A -> B -> exit`` is verified first;
+* State ``B`` has read marks for registers ``r1`` and ``r2``;
+* State ``D`` is considered equivalent to state ``B``;
+
+* Read marks for ``r1`` and ``r2`` have to be added in state ``C``, otherwise
+  state ``C`` might get mistakenly marked as equivalent to some future state
+  ``E`` with different values for registers in question.
+
 Understanding eBPF verifier messages
 ====================================
 
-- 
2.39.0

