Return-Path: <bpf+bounces-68844-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A804AB8682A
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 20:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A38A81C26DA1
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 18:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D932D7DED;
	Thu, 18 Sep 2025 18:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZYKWy9E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48412D5A19
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 18:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758221293; cv=none; b=QnvaHgx9yc5rQ1q7j2Lt8NWaknfdZJHFtP2YOGXYM9ntDBr3D/Xj7Pa791LWyVsv9Y5+qx+mVoOiPDqMZONmSLA9aIE9nQo2OOw3PlC1pjL9yI/yEMas0e/+R19MgMZaQat2e4BG9ZgPaCSjzhf8PQHfteiF3lfh1Y5HrgaEK6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758221293; c=relaxed/simple;
	bh=T7J/gR9NrAWb5IYp4iw47AGvOoc9ms33Paz/sRSqB7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p+MvlvYlULveRwWqQGLM1GYJ3tWO3Wr6C9FTiIJMyGbPr2EAzv4xCAr319UDOTdyB66KQCtRa8ofts9Lf0KpUZ4dY3CcRIHCb6T/YY11PlomiZ7NZajvv6Gm78qngdTxsz/ZD7x3TBhYHOyqVXMnCp/TTesO6oPE+nn/lOtYPaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NZYKWy9E; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-77d37d71967so945514b3a.0
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 11:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758221290; x=1758826090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ijs9tJ/cWRnx8/e2FyrRj3+qqHrSLCys7zOxFmqPoR4=;
        b=NZYKWy9Ebq5dGgmBLQV8ktPe3aQqnusvY6scZLNZqY6Ka/z8udFSXEBDxE8y1362jK
         cEJd4PEsQuh9Xc+HJ917gZFx6GnM3vd6LBIsausHUmLyY7+Lws6B9DwlHS5BlpBTqAap
         m0UfvfRX8O10/QW/11PVqKnocYlJqwsaLk5uqTx02+pBTFO7TvQwcnFi2EIxEgfrL5ki
         oR5J1RJYwaV5Hopi0lGRfFFbPWnI+jalp8+5yG9acK3cS63nFqcV1fUSC8R9w/iZ3g5w
         vboXd7W+XVocoAuhitlHeUoEbyXvlxjxCGhzD0lU2MPpMn8Has6r811DYEtfZUJd7UjG
         gBng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758221290; x=1758826090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ijs9tJ/cWRnx8/e2FyrRj3+qqHrSLCys7zOxFmqPoR4=;
        b=UgwTYSbYlIrd+Pb/N8q8XVbyCNe+l2tcICimQXwvXHAkNBusTqJCFmTmzl/b8hvWMt
         IE4EFxeZpoJXQnQVGJyvRTJDQuc5NbrCRqazCUu7S/0mCxjiM7q7O2L3WRC4jlNLBg6L
         ADJpwfgqO0AN7OWn9b7KNhMMxxHWFR5wbVeDPR3TsSe1CIXYUJ9V5HK8r+5B3aq9lLv2
         +5L6PruwyA2lVthp8gm2BCquAkyYkJyOtP5sm82g5x3pkUz4+VGrfmOApN+tfLbeOFux
         Hfi9wOYli1X7cBf2jXm9+57Ltw4PlBLdCvWYP+uuWOaLd7eeSMq4hv7hDUp+fXnKxykY
         tOHg==
X-Gm-Message-State: AOJu0YzOS7Hw+23FTDa5LhS/Sz2M5RCcStZ7XXIqUDT6zxpPHlGAqOkp
	3gyq/lj3L/FwPWkf1SyEqN2MaFSJi381Phq6PcnX31Xm1W2rtusZelYM1enruvsX
X-Gm-Gg: ASbGncvDc5k22WJjzM0N+5qLt8gHeNmcNjgOYtEC0HtKUs6kFf2VsCWVzKND9MeMAc4
	ryfX8HV1rBiFBxHCr6k/6wcY/mBHXiz84iamTO11CikRx4S9brlCtxDfrUI4u+NWNacWoKynmf2
	gD8MKUYyp6Yf+zREXU5YShwkcDemDaAehj3bARGNaNGbkhKHZu8xA/6YNKdD37ceUi5qLY7DMIg
	jdnMo/0IkbTrBLiBCawfadVQz//Bac2BrtpF3CbKvCcjULadw7rinY2FBysFODY9v7KkrxYiJKt
	R0hSybedgebSODL7DzBNpb0I85K3APXoWLJuF1gaLD04Iy3g/b9pxuy4uDAAPXQf+Mt7WuKeH5w
	/1r4bCUPZM/ZiAGNEVRu3tUbETmYtQORZjqyHsPEaAhjwdQ==
X-Google-Smtp-Source: AGHT+IFRo+xpWddZx73fQyAPWO/dThG5yiiJTtiZJeZuNeTDF853anenpcZB8EUPz5XL2xJ+J7Gj8g==
X-Received: by 2002:a17:902:74cc:b0:265:62b6:c51a with SMTP id d9443c01a7336-2697d795331mr39752325ad.23.1758221289781;
        Thu, 18 Sep 2025 11:48:09 -0700 (PDT)
Received: from honey-badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802e00b3sm32361505ad.90.2025.09.18.11.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 11:48:09 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 06/12] bpf: callchain sensitive stack liveness tracking using CFG
Date: Thu, 18 Sep 2025 11:47:35 -0700
Message-ID: <20250918-callchain-sensitive-liveness-v2-6-214ed2653eee@gmail.com>
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

This commit adds a flow-sensitive, context-sensitive, path-insensitive
data flow analysis for live stack slots:
- flow-sensitive: uses program control flow graph to compute data flow
  values;
- context-sensitive: collects data flow values for each possible call
  chain in a program;
- path-insensitive: does not distinguish between separate control flow
  graph paths reaching the same instruction.

Compared to the current path-sensitive analysis, this approach trades
some precision for not having to enumerate every path in the program.
This gives a theoretical capability to run the analysis before main
verification pass. See cover letter for motivation.

The basic idea is as follows:
- Data flow values indicate stack slots that might be read and stack
  slots that are definitely written.
- Data flow values are collected for each
  (call chain, instruction number) combination in the program.
- Within a subprogram, data flow values are propagated using control
  flow graph.
- Data flow values are transferred from entry instructions of callee
  subprograms to call sites in caller subprograms.

In other words, a tree of all possible call chains is constructed.
Each node of this tree represents a subprogram. Read and write marks
are collected for each instruction of each node. Live stack slots are
first computed for lower level nodes. Then, information about outer
stack slots that might be read or are definitely written by a
subprogram is propagated one level up, to the corresponding call
instructions of the upper nodes. Procedure repeats until root node is
processed.

In the absence of value range analysis, stack read/write marks are
collected during main verification pass, and data flow computation is
triggered each time verifier.c:states_equal() needs to query the
information.

Implementation details are documented in kernel/bpf/liveness.c.
Quantitative data about verification performance changes and memory
consumption is in the cover letter.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |  14 +
 kernel/bpf/Makefile          |   2 +-
 kernel/bpf/liveness.c        | 677 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 692 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index bd87e80f94231647183bb148045c200cc2104f31..2e3bdd50e2ba46040d6806a0b6ac18124fcb6c75 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -745,6 +745,8 @@ struct bpf_scc_info {
 	struct bpf_scc_visit visits[];
 };
 
+struct bpf_liveness;
+
 /* single container for all structs
  * one verifier_env per bpf_check() call
  */
@@ -846,6 +848,7 @@ struct bpf_verifier_env {
 	struct bpf_insn insn_buf[INSN_BUF_SIZE];
 	struct bpf_insn epilogue_buf[INSN_BUF_SIZE];
 	struct bpf_scc_callchain callchain_buf;
+	struct bpf_liveness *liveness;
 	/* array of pointers to bpf_scc_info indexed by SCC id */
 	struct bpf_scc_info **scc_info;
 	u32 scc_cnt;
@@ -1074,4 +1077,15 @@ int bpf_insn_successors(struct bpf_prog *prog, u32 idx, u32 succ[2]);
 void bpf_fmt_stack_mask(char *buf, ssize_t buf_sz, u64 stack_mask);
 bool bpf_calls_callback(struct bpf_verifier_env *env, int insn_idx);
 
+int bpf_stack_liveness_init(struct bpf_verifier_env *env);
+void bpf_stack_liveness_free(struct bpf_verifier_env *env);
+int bpf_update_live_stack(struct bpf_verifier_env *env);
+int bpf_mark_stack_read(struct bpf_verifier_env *env, u32 frameno, u32 insn_idx, u64 mask);
+void bpf_mark_stack_write(struct bpf_verifier_env *env, u32 frameno, u64 mask);
+int bpf_reset_stack_write_marks(struct bpf_verifier_env *env, u32 insn_idx);
+int bpf_commit_stack_write_marks(struct bpf_verifier_env *env);
+int bpf_live_stack_query_init(struct bpf_verifier_env *env, struct bpf_verifier_state *st);
+bool bpf_stack_slot_alive(struct bpf_verifier_env *env, u32 frameno, u32 spi);
+void bpf_reset_live_stack_callchain(struct bpf_verifier_env *env);
+
 #endif /* _LINUX_BPF_VERIFIER_H */
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index f6cf8c2af5f7b3ebb20d8ffff2af163da7655fa4..7fd0badfacb12f46c0d0e496e36892aaed1b09e0 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -6,7 +6,7 @@ cflags-nogcse-$(CONFIG_X86)$(CONFIG_CC_IS_GCC) := -fno-gcse
 endif
 CFLAGS_core.o += -Wno-override-init $(cflags-nogcse-yy)
 
-obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o log.o token.o
+obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o log.o token.o liveness.o
 obj-$(CONFIG_BPF_SYSCALL) += bpf_iter.o map_iter.o task_iter.o prog_iter.o link_iter.o
 obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
 obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
new file mode 100644
index 0000000000000000000000000000000000000000..6f9dfaaf6e64faeaee074926be7fcdaa57b22bc3
--- /dev/null
+++ b/kernel/bpf/liveness.c
@@ -0,0 +1,677 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+
+#include <linux/bpf_verifier.h>
+#include <linux/hashtable.h>
+#include <linux/jhash.h>
+#include <linux/slab.h>
+
+/*
+ * This file implements live stack slots analysis. After accumulating
+ * stack usage data, the analysis answers queries about whether a
+ * particular stack slot may be read by an instruction or any of it's
+ * successors.  This data is consumed by the verifier states caching
+ * mechanism to decide which stack slots are important when looking for a
+ * visited state corresponding to the current state.
+ *
+ * The analysis is call chain sensitive, meaning that data is collected
+ * and queried for tuples (call chain, subprogram instruction index).
+ * Such sensitivity allows identifying if some subprogram call always
+ * leads to writes in the caller's stack.
+ *
+ * The basic idea is as follows:
+ * - As the verifier accumulates a set of visited states, the analysis instance
+ *   accumulates a conservative estimate of stack slots that can be read
+ *   or must be written for each visited tuple (call chain, instruction index).
+ * - If several states happen to visit the same instruction with the same
+ *   call chain, stack usage information for the corresponding tuple is joined:
+ *   - "may_read" set represents a union of all possibly read slots
+ *     (any slot in "may_read" set might be read at or after the instruction);
+ *   - "must_write" set represents an intersection of all possibly written slots
+ *     (any slot in "must_write" set is guaranteed to be written by the instruction).
+ * - The analysis is split into two phases:
+ *   - read and write marks accumulation;
+ *   - read and write marks propagation.
+ * - The propagation phase is a textbook live variable data flow analysis:
+ *
+ *     state[cc, i].live_after = U [state[cc, s].live_before for s in insn_successors(i)]
+ *     state[cc, i].live_before =
+ *       (state[cc, i].live_after / state[cc, i].must_write) U state[i].may_read
+ *
+ *   Where:
+ *   - `U`  stands for set union
+ *   - `/`  stands for set difference;
+ *   - `cc` stands for a call chain;
+ *   - `i` and `s` are instruction indexes;
+ *
+ *   The above equations are computed for each call chain and instruction
+ *   index until state stops changing.
+ * - Additionally, in order to transfer "must_write" information from a
+ *   subprogram to call instructions invoking this subprogram,
+ *   the "must_write_acc" set is tracked for each (cc, i) tuple.
+ *   A set of stack slots that are guaranteed to be written by this
+ *   instruction or any of its successors (within the subprogram).
+ *   The equation for "must_write_acc" propagation looks as follows:
+ *
+ *     state[cc, i].must_write_acc =
+ *       ∩ [state[cc, s].must_write_acc for s in insn_successors(i)]
+ *       U state[cc, i].must_write
+ *
+ *   (An intersection of all "must_write_acc" for instruction successors
+ *    plus all "must_write" slots for the instruction itself).
+ * - After the propagation phase completes for a subprogram, information from
+ *   (cc, 0) tuple (subprogram entry) is transferred to the caller's call chain:
+ *   - "must_write_acc" set is intersected with the call site's "must_write" set;
+ *   - "may_read" set is added to the call site's "may_read" set.
+ * - Any live stack queries must be taken after the propagation phase.
+ * - Accumulation and propagation phases can be entered multiple times,
+ *   at any point in time:
+ *   - "may_read" set only grows;
+ *   - "must_write" set only shrinks;
+ *   - for each visited verifier state with zero branches, all relevant
+ *     read and write marks are already recorded by the analysis instance.
+ *
+ * Technically, the analysis is facilitated by the following data structures:
+ * - Call chain: for given verifier state, the call chain is a tuple of call
+ *   instruction indexes leading to the current subprogram plus the subprogram
+ *   entry point index.
+ * - Function instance: for a given call chain, for each instruction in
+ *   the current subprogram, a mapping between instruction index and a
+ *   set of "may_read", "must_write" and other marks accumulated for this
+ *   instruction.
+ * - A hash table mapping call chains to function instances.
+ */
+
+struct callchain {
+	u32 callsites[MAX_CALL_FRAMES];	/* instruction pointer for each frame */
+	/* cached subprog_info[*].start for functions owning the frames:
+	 * - sp_starts[curframe] used to get insn relative index within current function;
+	 * - sp_starts[0..current-1] used for fast callchain_frame_up().
+	 */
+	u32 sp_starts[MAX_CALL_FRAMES];
+	u32 curframe;			/* depth of callsites and sp_starts arrays */
+};
+
+struct per_frame_masks {
+	u64 may_read;		/* stack slots that may be read by this instruction */
+	u64 must_write;		/* stack slots written by this instruction */
+	u64 must_write_acc;	/* stack slots written by this instruction and its successors */
+	u64 live_before;	/* stack slots that may be read by this insn and its successors */
+};
+
+/*
+ * A function instance created for a specific callchain.
+ * Encapsulates read and write marks for each instruction in the function.
+ * Marks are tracked for each frame in the callchain.
+ */
+struct func_instance {
+	struct hlist_node hl_node;
+	struct callchain callchain;
+	u32 insn_cnt;		/* cached number of insns in the function */
+	bool updated;
+	bool must_write_dropped;
+	/* Per frame, per instruction masks, frames allocated lazily. */
+	struct per_frame_masks *frames[MAX_CALL_FRAMES];
+	/* For each instruction a flag telling if "must_write" had been initialized for it. */
+	bool *must_write_set;
+};
+
+struct live_stack_query {
+	struct func_instance *instances[MAX_CALL_FRAMES]; /* valid in range [0..curframe] */
+	u32 curframe;
+	u32 insn_idx;
+};
+
+struct bpf_liveness {
+	DECLARE_HASHTABLE(func_instances, 8);		/* maps callchain to func_instance */
+	struct live_stack_query live_stack_query;	/* cache to avoid repetitive ht lookups */
+	/* Cached instance corresponding to env->cur_state, avoids per-instruction ht lookup */
+	struct func_instance *cur_instance;
+	/*
+	 * Below fields are used to accumulate stack write marks for instruction at
+	 * @write_insn_idx before submitting the marks to @cur_instance.
+	 */
+	u64 write_masks_acc[MAX_CALL_FRAMES];
+	u32 write_insn_idx;
+};
+
+/* Compute callchain corresponding to state @st at depth @frameno */
+static void compute_callchain(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
+			      struct callchain *callchain, u32 frameno)
+{
+	struct bpf_subprog_info *subprog_info = env->subprog_info;
+	u32 i;
+
+	memset(callchain, 0, sizeof(*callchain));
+	for (i = 0; i <= frameno; i++) {
+		callchain->sp_starts[i] = subprog_info[st->frame[i]->subprogno].start;
+		if (i < st->curframe)
+			callchain->callsites[i] = st->frame[i + 1]->callsite;
+	}
+	callchain->curframe = frameno;
+	callchain->callsites[callchain->curframe] = callchain->sp_starts[callchain->curframe];
+}
+
+static u32 hash_callchain(struct callchain *callchain)
+{
+	return jhash2(callchain->callsites, callchain->curframe, 0);
+}
+
+static bool same_callsites(struct callchain *a, struct callchain *b)
+{
+	int i;
+
+	if (a->curframe != b->curframe)
+		return false;
+	for (i = a->curframe; i >= 0; i--)
+		if (a->callsites[i] != b->callsites[i])
+			return false;
+	return true;
+}
+
+/*
+ * Find existing or allocate new function instance corresponding to @callchain.
+ * Instances are accumulated in env->liveness->func_instances and persist
+ * until the end of the verification process.
+ */
+static struct func_instance *__lookup_instance(struct bpf_verifier_env *env,
+					       struct callchain *callchain)
+{
+	struct bpf_liveness *liveness = env->liveness;
+	struct bpf_subprog_info *subprog;
+	struct func_instance *result;
+	u32 subprog_sz, size, key;
+
+	key = hash_callchain(callchain);
+	hash_for_each_possible(liveness->func_instances, result, hl_node, key)
+		if (same_callsites(&result->callchain, callchain))
+			return result;
+
+	subprog = bpf_find_containing_subprog(env, callchain->sp_starts[callchain->curframe]);
+	subprog_sz = (subprog + 1)->start - subprog->start;
+	size = sizeof(struct func_instance);
+	result = kvzalloc(size, GFP_KERNEL_ACCOUNT);
+	if (!result)
+		return ERR_PTR(-ENOMEM);
+	result->must_write_set = kvcalloc(subprog_sz, sizeof(*result->must_write_set),
+					  GFP_KERNEL_ACCOUNT);
+	if (!result->must_write_set)
+		return ERR_PTR(-ENOMEM);
+	memcpy(&result->callchain, callchain, sizeof(*callchain));
+	result->insn_cnt = subprog_sz;
+	hash_add(liveness->func_instances, &result->hl_node, key);
+	return result;
+}
+
+static struct func_instance *lookup_instance(struct bpf_verifier_env *env,
+					     struct bpf_verifier_state *st,
+					     u32 frameno)
+{
+	struct callchain callchain;
+
+	compute_callchain(env, st, &callchain, frameno);
+	return __lookup_instance(env, &callchain);
+}
+
+int bpf_stack_liveness_init(struct bpf_verifier_env *env)
+{
+	env->liveness = kvzalloc(sizeof(*env->liveness), GFP_KERNEL_ACCOUNT);
+	if (!env->liveness)
+		return -ENOMEM;
+	hash_init(env->liveness->func_instances);
+	return 0;
+}
+
+void bpf_stack_liveness_free(struct bpf_verifier_env *env)
+{
+	struct func_instance *instance;
+	struct hlist_node *tmp;
+	int bkt, i;
+
+	if (!env->liveness)
+		return;
+	hash_for_each_safe(env->liveness->func_instances, bkt, tmp, instance, hl_node) {
+		for (i = 0; i <= instance->callchain.curframe; i++)
+			kvfree(instance->frames[i]);
+		kvfree(instance->must_write_set);
+		kvfree(instance);
+	}
+	kvfree(env->liveness);
+}
+
+/*
+ * Convert absolute instruction index @insn_idx to an index relative
+ * to start of the function corresponding to @instance.
+ */
+static int relative_idx(struct func_instance *instance, u32 insn_idx)
+{
+	return insn_idx - instance->callchain.sp_starts[instance->callchain.curframe];
+}
+
+static struct per_frame_masks *get_frame_masks(struct func_instance *instance,
+					       u32 frame, u32 insn_idx)
+{
+	if (!instance->frames[frame])
+		return NULL;
+
+	return &instance->frames[frame][relative_idx(instance, insn_idx)];
+}
+
+static struct per_frame_masks *alloc_frame_masks(struct bpf_verifier_env *env,
+						 struct func_instance *instance,
+						 u32 frame, u32 insn_idx)
+{
+	struct per_frame_masks *arr;
+
+	if (!instance->frames[frame]) {
+		arr = kvcalloc(instance->insn_cnt, sizeof(*arr), GFP_KERNEL_ACCOUNT);
+		instance->frames[frame] = arr;
+		if (!arr)
+			return ERR_PTR(-ENOMEM);
+	}
+	return get_frame_masks(instance, frame, insn_idx);
+}
+
+void bpf_reset_live_stack_callchain(struct bpf_verifier_env *env)
+{
+	env->liveness->cur_instance = NULL;
+}
+
+/* If @env->liveness->cur_instance is null, set it to instance corresponding to @env->cur_state. */
+static int ensure_cur_instance(struct bpf_verifier_env *env)
+{
+	struct bpf_liveness *liveness = env->liveness;
+	struct func_instance *instance;
+
+	if (liveness->cur_instance)
+		return 0;
+
+	instance = lookup_instance(env, env->cur_state, env->cur_state->curframe);
+	if (IS_ERR(instance))
+		return PTR_ERR(instance);
+
+	liveness->cur_instance = instance;
+	return 0;
+}
+
+/* Accumulate may_read masks for @frame at @insn_idx */
+static int mark_stack_read(struct bpf_verifier_env *env,
+			   struct func_instance *instance, u32 frame, u32 insn_idx, u64 mask)
+{
+	struct per_frame_masks *masks;
+	u64 new_may_read;
+
+	masks = alloc_frame_masks(env, instance, frame, insn_idx);
+	if (IS_ERR(masks))
+		return PTR_ERR(masks);
+	new_may_read = masks->may_read | mask;
+	if (new_may_read != masks->may_read &&
+	    ((new_may_read | masks->live_before) != masks->live_before))
+		instance->updated = true;
+	masks->may_read |= mask;
+	return 0;
+}
+
+int bpf_mark_stack_read(struct bpf_verifier_env *env, u32 frame, u32 insn_idx, u64 mask)
+{
+	int err;
+
+	err = ensure_cur_instance(env);
+	err = err ?: mark_stack_read(env, env->liveness->cur_instance, frame, insn_idx, mask);
+	return err;
+}
+
+static void reset_stack_write_marks(struct bpf_verifier_env *env,
+				    struct func_instance *instance, u32 insn_idx)
+{
+	struct bpf_liveness *liveness = env->liveness;
+	int i;
+
+	liveness->write_insn_idx = insn_idx;
+	for (i = 0; i <= instance->callchain.curframe; i++)
+		liveness->write_masks_acc[i] = 0;
+}
+
+int bpf_reset_stack_write_marks(struct bpf_verifier_env *env, u32 insn_idx)
+{
+	struct bpf_liveness *liveness = env->liveness;
+	int err;
+
+	err = ensure_cur_instance(env);
+	if (err)
+		return err;
+
+	reset_stack_write_marks(env, liveness->cur_instance, insn_idx);
+	return 0;
+}
+
+void bpf_mark_stack_write(struct bpf_verifier_env *env, u32 frame, u64 mask)
+{
+	env->liveness->write_masks_acc[frame] |= mask;
+}
+
+static int commit_stack_write_marks(struct bpf_verifier_env *env,
+				    struct func_instance *instance)
+{
+	struct bpf_liveness *liveness = env->liveness;
+	u32 idx, frame, curframe, old_must_write;
+	struct per_frame_masks *masks;
+	u64 mask;
+
+	if (!instance)
+		return 0;
+
+	curframe = instance->callchain.curframe;
+	idx = relative_idx(instance, liveness->write_insn_idx);
+	for (frame = 0; frame <= curframe; frame++) {
+		mask = liveness->write_masks_acc[frame];
+		/* avoid allocating frames for zero masks */
+		if (mask == 0 && !instance->must_write_set[idx])
+			continue;
+		masks = alloc_frame_masks(env, instance, frame, liveness->write_insn_idx);
+		if (IS_ERR(masks))
+			return PTR_ERR(masks);
+		old_must_write = masks->must_write;
+		/*
+		 * If instruction at this callchain is seen for a first time, set must_write equal
+		 * to @mask. Otherwise take intersection with the previous value.
+		 */
+		if (instance->must_write_set[idx])
+			mask &= old_must_write;
+		if (old_must_write != mask) {
+			masks->must_write = mask;
+			instance->updated = true;
+		}
+		if (old_must_write & ~mask)
+			instance->must_write_dropped = true;
+	}
+	instance->must_write_set[idx] = true;
+	liveness->write_insn_idx = 0;
+	return 0;
+}
+
+/*
+ * Merge stack writes marks in @env->liveness->write_masks_acc
+ * with information already in @env->liveness->cur_instance.
+ */
+int bpf_commit_stack_write_marks(struct bpf_verifier_env *env)
+{
+	return commit_stack_write_marks(env, env->liveness->cur_instance);
+}
+
+static char *fmt_callchain(struct bpf_verifier_env *env, struct callchain *callchain)
+{
+	char *buf_end = env->tmp_str_buf + sizeof(env->tmp_str_buf);
+	char *buf = env->tmp_str_buf;
+	int i;
+
+	buf += snprintf(buf, buf_end - buf, "(");
+	for (i = 0; i <= callchain->curframe; i++)
+		buf += snprintf(buf, buf_end - buf, "%s%d", i ? "," : "", callchain->callsites[i]);
+	snprintf(buf, buf_end - buf, ")");
+	return env->tmp_str_buf;
+}
+
+static void log_mask_change(struct bpf_verifier_env *env, struct callchain *callchain,
+			    char *pfx, u32 frame, u32 insn_idx, u64 old, u64 new)
+{
+	u64 changed_bits = old ^ new;
+	u64 new_ones = new & changed_bits;
+	u64 new_zeros = ~new & changed_bits;
+
+	if (!changed_bits)
+		return;
+	bpf_log(&env->log, "%s frame %d insn %d ", fmt_callchain(env, callchain), frame, insn_idx);
+	if (new_ones) {
+		bpf_fmt_stack_mask(env->tmp_str_buf, sizeof(env->tmp_str_buf), new_ones);
+		bpf_log(&env->log, "+%s %s ", pfx, env->tmp_str_buf);
+	}
+	if (new_zeros) {
+		bpf_fmt_stack_mask(env->tmp_str_buf, sizeof(env->tmp_str_buf), new_zeros);
+		bpf_log(&env->log, "-%s %s", pfx, env->tmp_str_buf);
+	}
+	bpf_log(&env->log, "\n");
+}
+
+static struct func_instance *get_outer_instance(struct bpf_verifier_env *env,
+						struct func_instance *instance)
+{
+	struct callchain callchain = instance->callchain;
+
+	/* Adjust @callchain to represent callchain one frame up */
+	callchain.callsites[callchain.curframe] = 0;
+	callchain.sp_starts[callchain.curframe] = 0;
+	callchain.curframe--;
+	callchain.callsites[callchain.curframe] = callchain.sp_starts[callchain.curframe];
+	return __lookup_instance(env, &callchain);
+}
+
+static u32 callchain_subprog_start(struct callchain *callchain)
+{
+	return callchain->sp_starts[callchain->curframe];
+}
+
+/*
+ * Transfer @may_read and @must_write_acc marks from the first instruction of @instance,
+ * to the call instruction in function instance calling @instance.
+ */
+static int propagate_to_outer_instance(struct bpf_verifier_env *env,
+				       struct func_instance *instance)
+{
+	struct callchain *callchain = &instance->callchain;
+	u32 this_subprog_start, callsite, frame;
+	struct func_instance *outer_instance;
+	struct per_frame_masks *insn;
+	int err;
+
+	this_subprog_start = callchain_subprog_start(callchain);
+	outer_instance = get_outer_instance(env, instance);
+	callsite = callchain->callsites[callchain->curframe - 1];
+
+	reset_stack_write_marks(env, outer_instance, callsite);
+	for (frame = 0; frame < callchain->curframe; frame++) {
+		insn = get_frame_masks(instance, frame, this_subprog_start);
+		if (!insn)
+			continue;
+		bpf_mark_stack_write(env, frame, insn->must_write_acc);
+		err = mark_stack_read(env, outer_instance, frame, callsite, insn->live_before);
+		if (err)
+			return err;
+	}
+	commit_stack_write_marks(env, outer_instance);
+	return 0;
+}
+
+static inline bool update_insn(struct bpf_verifier_env *env,
+			       struct func_instance *instance, u32 frame, u32 insn_idx)
+{
+	struct bpf_insn_aux_data *aux = env->insn_aux_data;
+	u64 new_before, new_after, must_write_acc;
+	struct per_frame_masks *insn, *succ_insn;
+	u32 succ_num, s, succ[2];
+	bool changed;
+
+	succ_num = bpf_insn_successors(env->prog, insn_idx, succ);
+	if (unlikely(succ_num == 0))
+		return false;
+
+	changed = false;
+	insn = get_frame_masks(instance, frame, insn_idx);
+	new_before = 0;
+	new_after = 0;
+	/*
+	 * New "must_write_acc" is an intersection of all "must_write_acc"
+	 * of successors plus all "must_write" slots of instruction itself.
+	 */
+	must_write_acc = U64_MAX;
+	for (s = 0; s < succ_num; ++s) {
+		succ_insn = get_frame_masks(instance, frame, succ[s]);
+		new_after |= succ_insn->live_before;
+		must_write_acc &= succ_insn->must_write_acc;
+	}
+	must_write_acc |= insn->must_write;
+	/*
+	 * New "live_before" is a union of all "live_before" of successors
+	 * minus slots written by instruction plus slots read by instruction.
+	 */
+	new_before = (new_after & ~insn->must_write) | insn->may_read;
+	changed |= new_before != insn->live_before;
+	changed |= must_write_acc != insn->must_write_acc;
+	if (unlikely(env->log.level & BPF_LOG_LEVEL2) &&
+	    (insn->may_read || insn->must_write ||
+	     insn_idx == callchain_subprog_start(&instance->callchain) ||
+	     aux[insn_idx].prune_point)) {
+		log_mask_change(env, &instance->callchain, "live",
+				frame, insn_idx, insn->live_before, new_before);
+		log_mask_change(env, &instance->callchain, "written",
+				frame, insn_idx, insn->must_write_acc, must_write_acc);
+	}
+	insn->live_before = new_before;
+	insn->must_write_acc = must_write_acc;
+	return changed;
+}
+
+/* Fixed-point computation of @live_before and @must_write_acc marks */
+static int update_instance(struct bpf_verifier_env *env, struct func_instance *instance)
+{
+	u32 i, frame, po_start, po_end, cnt, this_subprog_start;
+	struct callchain *callchain = &instance->callchain;
+	int *insn_postorder = env->cfg.insn_postorder;
+	struct bpf_subprog_info *subprog;
+	struct per_frame_masks *insn;
+	bool changed;
+	int err;
+
+	this_subprog_start = callchain_subprog_start(callchain);
+	/*
+	 * If must_write marks were updated must_write_acc needs to be reset
+	 * (to account for the case when new must_write sets became smaller).
+	 */
+	if (instance->must_write_dropped) {
+		for (frame = 0; frame <= callchain->curframe; frame++) {
+			if (!instance->frames[frame])
+				continue;
+
+			for (i = 0; i < instance->insn_cnt; i++) {
+				insn = get_frame_masks(instance, frame, this_subprog_start + i);
+				insn->must_write_acc = 0;
+			}
+		}
+	}
+
+	subprog = bpf_find_containing_subprog(env, this_subprog_start);
+	po_start = subprog->postorder_start;
+	po_end = (subprog + 1)->postorder_start;
+	cnt = 0;
+	/* repeat until fixed point is reached */
+	do {
+		cnt++;
+		changed = false;
+		for (frame = 0; frame <= instance->callchain.curframe; frame++) {
+			if (!instance->frames[frame])
+				continue;
+
+			for (i = po_start; i < po_end; i++)
+				changed |= update_insn(env, instance, frame, insn_postorder[i]);
+		}
+	} while (changed);
+
+	if (env->log.level & BPF_LOG_LEVEL2)
+		bpf_log(&env->log, "%s live stack update done in %d iterations\n",
+			fmt_callchain(env, callchain), cnt);
+
+	/* transfer marks accumulated for outer frames to outer func instance (caller) */
+	if (callchain->curframe > 0) {
+		err = propagate_to_outer_instance(env, instance);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+/*
+ * Prepare all callchains within @env->cur_state for querying.
+ * This function should be called after each verifier.c:pop_stack()
+ * and whenever verifier.c:do_check_insn() processes subprogram exit.
+ * This would guarantee that visited verifier states with zero branches
+ * have their bpf_mark_stack_{read,write}() effects propagated in
+ * @env->liveness.
+ */
+int bpf_update_live_stack(struct bpf_verifier_env *env)
+{
+	struct func_instance *instance;
+	int err, frame;
+
+	bpf_reset_live_stack_callchain(env);
+	for (frame = env->cur_state->curframe; frame >= 0; --frame) {
+		instance = lookup_instance(env, env->cur_state, frame);
+		if (IS_ERR(instance))
+			return PTR_ERR(instance);
+
+		if (instance->updated) {
+			err = update_instance(env, instance);
+			if (err)
+				return err;
+			instance->updated = false;
+			instance->must_write_dropped = false;
+		}
+	}
+	return 0;
+}
+
+static bool is_live_before(struct func_instance *instance, u32 insn_idx, u32 frameno, u32 spi)
+{
+	struct per_frame_masks *masks;
+
+	masks = get_frame_masks(instance, frameno, insn_idx);
+	return masks && (masks->live_before & BIT(spi));
+}
+
+int bpf_live_stack_query_init(struct bpf_verifier_env *env, struct bpf_verifier_state *st)
+{
+	struct live_stack_query *q = &env->liveness->live_stack_query;
+	struct func_instance *instance;
+	u32 frame;
+
+	memset(q, 0, sizeof(*q));
+	for (frame = 0; frame <= st->curframe; frame++) {
+		instance = lookup_instance(env, st, frame);
+		if (IS_ERR(instance))
+			return PTR_ERR(instance);
+		q->instances[frame] = instance;
+	}
+	q->curframe = st->curframe;
+	q->insn_idx = st->insn_idx;
+	return 0;
+}
+
+bool bpf_stack_slot_alive(struct bpf_verifier_env *env, u32 frameno, u32 spi)
+{
+	/*
+	 * Slot is alive if it is read before q->st->insn_idx in current func instance,
+	 * or if for some outer func instance:
+	 * - alive before callsite if callsite calls callback, otherwise
+	 * - alive after callsite
+	 */
+	struct live_stack_query *q = &env->liveness->live_stack_query;
+	struct func_instance *instance, *curframe_instance;
+	u32 i, callsite;
+	bool alive;
+
+	curframe_instance = q->instances[q->curframe];
+	if (is_live_before(curframe_instance, q->insn_idx, frameno, spi))
+		return true;
+
+	for (i = frameno; i < q->curframe; i++) {
+		callsite = curframe_instance->callchain.callsites[i];
+		instance = q->instances[i];
+		alive = bpf_calls_callback(env, callsite)
+			? is_live_before(instance, callsite, frameno, spi)
+			: is_live_before(instance, callsite + 1, frameno, spi);
+		if (alive)
+			return true;
+	}
+
+	return false;
+}

-- 
2.51.0

