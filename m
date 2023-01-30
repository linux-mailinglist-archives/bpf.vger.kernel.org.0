Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AACA868190C
	for <lists+bpf@lfdr.de>; Mon, 30 Jan 2023 19:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238197AbjA3S1F (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Jan 2023 13:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238206AbjA3S0c (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Jan 2023 13:26:32 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F20847412
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 10:24:38 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id k8-20020a05600c1c8800b003dc57ea0dfeso2715303wms.0
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 10:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/LaOQenCpqNk+0zVEfa0yUs7p5540uEneI1dYhYI94c=;
        b=X1GrUuSW89CIKXmNjrWEs0QQl2Tnrd/3nDD6Jn/aVQPLwgIypRFV6fmH3Gg0WlSRlO
         ZjrqLSebPJUh0DjMd1BwCE3KwbS8R99+xkMMokSyCb9Snn+QpEVX2zySDugtY7py616h
         0/0482qc/S1jYGb09+upsf3kV2MNdeh5zdCLWdtONFj6k3HfxrbBpSW71elcUTX7BjXF
         6D+MFJlYVOLi3PFj2i2kCeJcOrSVY/rbi6YwWxy8AHu5PY7iinuJf33QM8K91DsD8TB4
         ppJNz5Q6fN1lwNAujGC5POG8qE8dz5qBIDK/KR4Gwhy9i4eEAxWFT3G6bPmDGyQta3Wo
         3N0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/LaOQenCpqNk+0zVEfa0yUs7p5540uEneI1dYhYI94c=;
        b=IQdVcPp5tWb6qVN/vKRMb3flUW4aA+DMxoyyJzVirgUCpGXR7WTKRDEvFALAGuUjjA
         s4tErbYlD9NQD/aX8g3pBS+sRZmiKBxWsD6HzCbsSNOKuqzV3PruFIany1Qv+u/nmJpd
         NvUcTlg+qJN6mtbw2GNKtj2wOfoSJB/5w1X2+HuvD1Vi5tUFYUpjUGVpQwNrrNbCDXDA
         cMeXM9p6N1BLSiH3H/34DcBxtr6QVXYJ/YkFBLHlRlicLLGi5olE5u0TzbRQdmdBOmgF
         AjpokgyVDzo7HpStrpXhqKUuXURixWWQTnitcFKc93Ij52GbG93egm3kXaMNo75a8gce
         vppA==
X-Gm-Message-State: AO0yUKXbI4GeSMEaODtLx4S/pS8wgsCHnpD83NL5l4IZLzgHtffUKGYH
        uU/TlygMo1MUHGjDd5a0+zBAYHHjzhY=
X-Google-Smtp-Source: AK7set/yxQutG4IXkkqtTOq16tHyiSjhOr0i3pclPUOI/+ti08/tXZvme9nq+XQ+AVz/KhHCgI4irg==
X-Received: by 2002:a05:600c:314a:b0:3dc:3f51:c697 with SMTP id h10-20020a05600c314a00b003dc3f51c697mr418158wmo.18.1675103071409;
        Mon, 30 Jan 2023 10:24:31 -0800 (PST)
Received: from pluto.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id fl22-20020a05600c0b9600b003d1e3b1624dsm17831712wmb.2.2023.01.30.10.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 10:24:31 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 1/1] docs/bpf: Add description of register liveness tracking algorithm
Date:   Mon, 30 Jan 2023 20:24:00 +0200
Message-Id: <20230130182400.630997-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230130182400.630997-1-eddyz87@gmail.com>
References: <20230130182400.630997-1-eddyz87@gmail.com>
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
 Documentation/bpf/verifier.rst | 266 +++++++++++++++++++++++++++++++++
 1 file changed, 266 insertions(+)

diff --git a/Documentation/bpf/verifier.rst b/Documentation/bpf/verifier.rst
index 3afa548ec28c..7269933428e1 100644
--- a/Documentation/bpf/verifier.rst
+++ b/Documentation/bpf/verifier.rst
@@ -316,6 +316,272 @@ Pruning considers not only the registers but also the stack (and any spilled
 registers it may hold).  They must all be safe for the branch to be pruned.
 This is implemented in states_equal().
 
+Some technical details about state pruning implementation could be found below.
+
+Register liveness tracking
+--------------------------
+
+In order to make state pruning effective liveness state is tracked for each
+register and stack slot. The basic idea is to identify which registers or stack
+slots were used by children of the state to reach the program exit. Registers
+that were never used could be removed from the cached state thus making more
+states equivalent to a cached state. This could be illustrated by the following
+program::
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
+
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
+~~~~~~~~~~~~~~~~~~~~~~~~~
+  
+In order to propagate information between parent and child states register
+parentage chain is established. Each register or stack slot is linked to a
+corresponding register or stack slot in it's parent state via a ``->parent``
+pointer. This link is established upon state creation in function
+``is_state_visited()`` and is never changed.
+
+The rules for correspondence between registers / stack slots are as follows:
+
+* For current stack frame registers and stack slots of the new state are linked
+  to the registers and stack slots of the parent state with the same indices.
+
+* For outer stack frames only caller saved registers (r6-r9) and stack slots are
+  linked to the registers and stack slots of the parent state with the same
+  indices.
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
+                        ^       ^         nil     nil     nil 
+                        |       |          |       |       |          
+  Checkpoint +--------------------------+--------------------------+
+  #2         | r0-r5 | r6-r9 | fp-8 ... | r0-r5 | r6-r9 | fp-8 ... |
+             +--------------------------+--------------------------+
+                        ^       ^          ^       ^       ^  
+                        |       |          |       |       |
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
+Also note: the read marks are applied to the **parent** state while write marks
+are applied to the **current** state.
+
+Because stack writes could have different sizes ``REG_LIVE_WRITTEN`` marks are
+applied conservatively: stack slots are marked as written only if write size
+corresponds to the size of the register, e.g. see function ``save_register_state()``.
+
+Consider the following example::
+
+  0: (*u64)(r10 - 8) = 0
+  --- checkpoint #0 ---
+  1: (*u32)(r10 - 8) = 1
+  2: r1 = (*u32)(r10 - 8)
+
+Because write size at instruction (1) is smaller than register size the write
+mark will not be added to fp-8 slot when (1) is verified, thus the fp-8 read at
+instruction (2) would propagate read mark for fp-8 up to checkpoint #0.
+
+Once ``BPF_EXIT`` instruction is reached function ``update_branch_counts()`` is
+called to update the ``->branches`` counter for each verifier state in a chain
+of parent verifier states. When ``->branches`` counter reaches zero the verifier
+state becomes a valid entry in a set of cached verifier states.
+
+Each entry of the verifier states cache is post-processed by a function
+``clean_live_states()``. This function marks all registers and stack slots
+without ``REG_LIVE_READ{32,64}`` marks as ``NOT_INIT`` or ``STACK_INVALID``.
+Registers/stack slots marked in this way are ignored in function ``stacksafe()``
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
+  
+* At instruction #4:
+  
+  * ``checkpoint[0]`` states cache entry is created: ``{ r0 == 1, r1 == 0, pc == 4 }``;
+  * ``checkpoint[0].r0`` is marked as written;
+  * ``checkpoint[0].r1`` is marked as read;
+
+* At instruction #5 exit is reached and ``checkpoint[0]`` can now be processed
+  by ``clean_live_states()``, after this processing ``checkpoint[0].r0`` has a
+  read mark and all other registers and stack slots are marked as ``NOT_INIT``
+  or ``STACK_INVALID``
+  
+* The state ``{ r0 == 0, r1 == 0, pc == 4 }`` is popped from the states queue
+  and is compared against a cached state ``{ r1 == 0, pc == 4 }``, the states
+  are considered equivalent.
+
+Read marks propagation for cache hits
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Another important point is handling of read marks when a previously verified
+state is found in the states cache. All read marks present on registers and
+stack slots of the cached state must be propagated over the parentage chain of
+the current state. Function ``propagate_liveness()`` handles this case.
+
+For example, consider the following state parentage chain (S is a
+starting state, A-E are derived states, -> arrows show which state is
+derived from which)::
+
+                      r1 read
+               <-------------                    A[r1] == 0
+                    +---+                        C[r1] == 0
+      S ---> A ---> | B | ---> exit              E[r1] == 1
+      |             |   |
+      ` ---> C ---> | D |
+      |             +---+
+      ` ---> E        
+                      ^
+             ^        |___   suppose all these
+             |             states are at insn #Y
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

