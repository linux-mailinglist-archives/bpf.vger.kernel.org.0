Return-Path: <bpf+bounces-14843-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8117E8893
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 03:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B12F41C20A1D
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 02:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A03539C;
	Sat, 11 Nov 2023 02:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAuBOEeZ"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C968525B
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 02:50:24 +0000 (UTC)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6CD3C15;
	Fri, 10 Nov 2023 18:49:48 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3b3ec45d6e9so1492255b6e.0;
        Fri, 10 Nov 2023 18:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699670987; x=1700275787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=77L0bI9fxkI8ZhTwY7qIZtcnL0TGgwoSFdK6OvoRyZo=;
        b=ZAuBOEeZEi5aQrb8q7X835SSJKKyFI8A4hnuti7kyMSnxr8/Csc3QpuvySLkKySw+P
         /J/A9JVirgqdnNZPrAXxw74rMx4ntHXxW9VCM8k7LoMQT7FXIQ+kWGjFc2B6rpPxf50o
         LtIZrJQntf4o62gvElAwROjDcjmUk8YM0aDBURjWcQV7IvQE3BDG4Ffm2CnjxTpiHeva
         dxdaHgDTJKTDYdHjb2hqmsz0upSZNZoZmVp8NHYdpw/HB3Y3kLa7QUjCqWKHMLM9WRvW
         XcywbUoi37Cw+L2QIRwiocCnDONv+ONy38Ks+tllqV3XgQmvni7vffHOSzSNaTsnsgsY
         SA3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699670987; x=1700275787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=77L0bI9fxkI8ZhTwY7qIZtcnL0TGgwoSFdK6OvoRyZo=;
        b=gMpmPt1pb02LEvRllkoaGoQ1oFihotwvIkgpXlcgCAkU5pIXA/pMQ4n902EOxuYGo/
         UJ6dLT9Dt7wrs3WciJLK2uMF+zHuzLEfF/Qx/v/bn2WADevVJebNK8HpkY2JViggn8lh
         ywkV3LQH1GiwHh4OKWYFzt6hpkXGiC55J8S7+3iwmHGQZurv5r28H9CctY60AOV6870e
         nuqG/DaLzHHRJtCG2pPXIrx2kfpghbZXTYhyQEtp0ziZEAk/znDM7crc63uQmTISS8+8
         NU/aoQ1drLrexrXRrH6GPbpnJSRdtBLKhyANoWKlIl6ohq1boFIxV/tOsyyR1KE1iQBq
         z/qg==
X-Gm-Message-State: AOJu0YyiNlKqU63TUzTkhCvefzCXtBufogMokHDV9mnKBjFfZXuup/FI
	cwvo9WbYv8BJf98sfSw20r4=
X-Google-Smtp-Source: AGHT+IGajZRXpUgh6qNyRMtaT5EbPR5W/pwiFE5M3E/11vjDUF9Yzo8usLydO5M5fDRhtXBRQlEHgg==
X-Received: by 2002:a05:6808:2a6f:b0:3b5:6604:a8ba with SMTP id fu15-20020a0568082a6f00b003b56604a8bamr1178070oib.36.1699670987462;
        Fri, 10 Nov 2023 18:49:47 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:7384])
        by smtp.gmail.com with ESMTPSA id u9-20020a056a00124900b006c3467ae25asm385093pfi.206.2023.11.10.18.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 18:49:46 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: torvalds@linux-foundation.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	joshdon@google.com,
	brho@google.com,
	pjt@google.com,
	derkling@google.com,
	haoluo@google.com,
	dvernet@meta.com,
	dschatzberg@meta.com,
	dskarlat@cs.cmu.edu,
	riel@surriel.com,
	changwoo@igalia.com,
	himadrics@inria.fr,
	memxor@gmail.com
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 27/36] sched_ext: Add a cgroup scheduler which uses flattened hierarchy
Date: Fri, 10 Nov 2023 16:47:53 -1000
Message-ID: <20231111024835.2164816-28-tj@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231111024835.2164816-1-tj@kernel.org>
References: <20231111024835.2164816-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds scx_flatcg example scheduler which implements hierarchical
weight-based cgroup CPU control by flattening the cgroup hierarchy into a
single layer by compounding the active weight share at each level.

This flattening of hierarchy can bring a substantial performance gain when
the cgroup hierarchy is nested multiple levels. in a simple benchmark using
wrk[8] on apache serving a CGI script calculating sha1sum of a small file,
it outperforms CFS by ~3% with CPU controller disabled and by ~10% with two
apache instances competing with 2:1 weight ratio nested four level deep.

However, the gain comes at the cost of not being able to properly handle
thundering herd of cgroups. For example, if many cgroups which are nested
behind a low priority parent cgroup wake up around the same time, they may
be able to consume more CPU cycles than they are entitled to. In many use
cases, this isn't a real concern especially given the performance gain.
Also, there are ways to mitigate the problem further by e.g. introducing an
extra scheduling layer on cgroup delegation boundaries.

v2: * Use SCX_BUG[_ON]() to simplify error handling.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
---
 tools/sched_ext/.gitignore       |   1 +
 tools/sched_ext/Makefile         |   2 +-
 tools/sched_ext/scx_flatcg.bpf.c | 834 +++++++++++++++++++++++++++++++
 tools/sched_ext/scx_flatcg.c     | 217 ++++++++
 tools/sched_ext/scx_flatcg.h     |  49 ++
 5 files changed, 1102 insertions(+), 1 deletion(-)
 create mode 100644 tools/sched_ext/scx_flatcg.bpf.c
 create mode 100644 tools/sched_ext/scx_flatcg.c
 create mode 100644 tools/sched_ext/scx_flatcg.h

diff --git a/tools/sched_ext/.gitignore b/tools/sched_ext/.gitignore
index d9e607667426..894cf43ddacc 100644
--- a/tools/sched_ext/.gitignore
+++ b/tools/sched_ext/.gitignore
@@ -2,6 +2,7 @@ scx_simple
 scx_qmap
 scx_central
 scx_pair
+scx_flatcg
 *.skel.h
 *.subskel.h
 /tools/
diff --git a/tools/sched_ext/Makefile b/tools/sched_ext/Makefile
index a91ef4e34cd3..484803ea65b5 100644
--- a/tools/sched_ext/Makefile
+++ b/tools/sched_ext/Makefile
@@ -179,7 +179,7 @@ SCX_COMMON_DEPS := scx_common.h user_exit_info.h | $(BINDIR)
 ################
 # C schedulers #
 ################
-c-sched-targets = scx_simple scx_qmap scx_central scx_pair
+c-sched-targets = scx_simple scx_qmap scx_central scx_pair scx_flatcg
 
 $(addprefix $(BINDIR)/,$(c-sched-targets)): \
 	$(BINDIR)/%: \
diff --git a/tools/sched_ext/scx_flatcg.bpf.c b/tools/sched_ext/scx_flatcg.bpf.c
new file mode 100644
index 000000000000..ab7cff4da7da
--- /dev/null
+++ b/tools/sched_ext/scx_flatcg.bpf.c
@@ -0,0 +1,834 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * A demo sched_ext flattened cgroup hierarchy scheduler. It implements
+ * hierarchical weight-based cgroup CPU control by flattening the cgroup
+ * hierarchy into a single layer by compounding the active weight share at each
+ * level. Consider the following hierarchy with weights in parentheses:
+ *
+ * R + A (100) + B (100)
+ *   |         \ C (100)
+ *   \ D (200)
+ *
+ * Ignoring the root and threaded cgroups, only B, C and D can contain tasks.
+ * Let's say all three have runnable tasks. The total share that each of these
+ * three cgroups is entitled to can be calculated by compounding its share at
+ * each level.
+ *
+ * For example, B is competing against C and in that competition its share is
+ * 100/(100+100) == 1/2. At its parent level, A is competing against D and A's
+ * share in that competition is 200/(200+100) == 1/3. B's eventual share in the
+ * system can be calculated by multiplying the two shares, 1/2 * 1/3 == 1/6. C's
+ * eventual shaer is the same at 1/6. D is only competing at the top level and
+ * its share is 200/(100+200) == 2/3.
+ *
+ * So, instead of hierarchically scheduling level-by-level, we can consider it
+ * as B, C and D competing each other with respective share of 1/6, 1/6 and 2/3
+ * and keep updating the eventual shares as the cgroups' runnable states change.
+ *
+ * This flattening of hierarchy can bring a substantial performance gain when
+ * the cgroup hierarchy is nested multiple levels. in a simple benchmark using
+ * wrk[8] on apache serving a CGI script calculating sha1sum of a small file, it
+ * outperforms CFS by ~3% with CPU controller disabled and by ~10% with two
+ * apache instances competing with 2:1 weight ratio nested four level deep.
+ *
+ * However, the gain comes at the cost of not being able to properly handle
+ * thundering herd of cgroups. For example, if many cgroups which are nested
+ * behind a low priority parent cgroup wake up around the same time, they may be
+ * able to consume more CPU cycles than they are entitled to. In many use cases,
+ * this isn't a real concern especially given the performance gain. Also, there
+ * are ways to mitigate the problem further by e.g. introducing an extra
+ * scheduling layer on cgroup delegation boundaries.
+ */
+#include "scx_common.bpf.h"
+#include "user_exit_info.h"
+#include "scx_flatcg.h"
+
+char _license[] SEC("license") = "GPL";
+
+const volatile u32 nr_cpus = 32;	/* !0 for veristat, set during init */
+const volatile u64 cgrp_slice_ns = SCX_SLICE_DFL;
+const volatile bool switch_partial;
+
+u64 cvtime_now;
+struct user_exit_info uei;
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__type(key, u32);
+	__type(value, u64);
+	__uint(max_entries, FCG_NR_STATS);
+} stats SEC(".maps");
+
+static void stat_inc(enum fcg_stat_idx idx)
+{
+	u32 idx_v = idx;
+
+	u64 *cnt_p = bpf_map_lookup_elem(&stats, &idx_v);
+	if (cnt_p)
+		(*cnt_p)++;
+}
+
+struct fcg_cpu_ctx {
+	u64			cur_cgid;
+	u64			cur_at;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__type(key, u32);
+	__type(value, struct fcg_cpu_ctx);
+	__uint(max_entries, 1);
+} cpu_ctx SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_CGRP_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct fcg_cgrp_ctx);
+} cgrp_ctx SEC(".maps");
+
+struct cgv_node {
+	struct bpf_rb_node	rb_node;
+	__u64			cvtime;
+	__u64			cgid;
+};
+
+private(CGV_TREE) struct bpf_spin_lock cgv_tree_lock;
+private(CGV_TREE) struct bpf_rb_root cgv_tree __contains(cgv_node, rb_node);
+
+struct cgv_node_stash {
+	struct cgv_node __kptr *node;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 16384);
+	__type(key, __u64);
+	__type(value, struct cgv_node_stash);
+} cgv_node_stash SEC(".maps");
+
+struct fcg_task_ctx {
+	u64		bypassed_at;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct fcg_task_ctx);
+} task_ctx SEC(".maps");
+
+/* gets inc'd on weight tree changes to expire the cached hweights */
+unsigned long hweight_gen = 1;
+
+static u64 div_round_up(u64 dividend, u64 divisor)
+{
+	return (dividend + divisor - 1) / divisor;
+}
+
+static bool vtime_before(u64 a, u64 b)
+{
+	return (s64)(a - b) < 0;
+}
+
+static bool cgv_node_less(struct bpf_rb_node *a, const struct bpf_rb_node *b)
+{
+	struct cgv_node *cgc_a, *cgc_b;
+
+	cgc_a = container_of(a, struct cgv_node, rb_node);
+	cgc_b = container_of(b, struct cgv_node, rb_node);
+
+	return cgc_a->cvtime < cgc_b->cvtime;
+}
+
+static struct fcg_cpu_ctx *find_cpu_ctx(void)
+{
+	struct fcg_cpu_ctx *cpuc;
+	u32 idx = 0;
+
+	cpuc = bpf_map_lookup_elem(&cpu_ctx, &idx);
+	if (!cpuc) {
+		scx_bpf_error("cpu_ctx lookup failed");
+		return NULL;
+	}
+	return cpuc;
+}
+
+static struct fcg_cgrp_ctx *find_cgrp_ctx(struct cgroup *cgrp)
+{
+	struct fcg_cgrp_ctx *cgc;
+
+	cgc = bpf_cgrp_storage_get(&cgrp_ctx, cgrp, 0, 0);
+	if (!cgc) {
+		scx_bpf_error("cgrp_ctx lookup failed for cgid %llu", cgrp->kn->id);
+		return NULL;
+	}
+	return cgc;
+}
+
+static struct fcg_cgrp_ctx *find_ancestor_cgrp_ctx(struct cgroup *cgrp, int level)
+{
+	struct fcg_cgrp_ctx *cgc;
+
+	cgrp = bpf_cgroup_ancestor(cgrp, level);
+	if (!cgrp) {
+		scx_bpf_error("ancestor cgroup lookup failed");
+		return NULL;
+	}
+
+	cgc = find_cgrp_ctx(cgrp);
+	if (!cgc)
+		scx_bpf_error("ancestor cgrp_ctx lookup failed");
+	bpf_cgroup_release(cgrp);
+	return cgc;
+}
+
+static void cgrp_refresh_hweight(struct cgroup *cgrp, struct fcg_cgrp_ctx *cgc)
+{
+	int level;
+
+	if (!cgc->nr_active) {
+		stat_inc(FCG_STAT_HWT_SKIP);
+		return;
+	}
+
+	if (cgc->hweight_gen == hweight_gen) {
+		stat_inc(FCG_STAT_HWT_CACHE);
+		return;
+	}
+
+	stat_inc(FCG_STAT_HWT_UPDATES);
+	bpf_for(level, 0, cgrp->level + 1) {
+		struct fcg_cgrp_ctx *cgc;
+		bool is_active;
+
+		cgc = find_ancestor_cgrp_ctx(cgrp, level);
+		if (!cgc)
+			break;
+
+		if (!level) {
+			cgc->hweight = FCG_HWEIGHT_ONE;
+			cgc->hweight_gen = hweight_gen;
+		} else {
+			struct fcg_cgrp_ctx *pcgc;
+
+			pcgc = find_ancestor_cgrp_ctx(cgrp, level - 1);
+			if (!pcgc)
+				break;
+
+			/*
+			 * We can be oppotunistic here and not grab the
+			 * cgv_tree_lock and deal with the occasional races.
+			 * However, hweight updates are already cached and
+			 * relatively low-frequency. Let's just do the
+			 * straightforward thing.
+			 */
+			bpf_spin_lock(&cgv_tree_lock);
+			is_active = cgc->nr_active;
+			if (is_active) {
+				cgc->hweight_gen = pcgc->hweight_gen;
+				cgc->hweight =
+					div_round_up(pcgc->hweight * cgc->weight,
+						     pcgc->child_weight_sum);
+			}
+			bpf_spin_unlock(&cgv_tree_lock);
+
+			if (!is_active) {
+				stat_inc(FCG_STAT_HWT_RACE);
+				break;
+			}
+		}
+	}
+}
+
+static void cgrp_cap_budget(struct cgv_node *cgv_node, struct fcg_cgrp_ctx *cgc)
+{
+	u64 delta, cvtime, max_budget;
+
+	/*
+	 * A node which is on the rbtree can't be pointed to from elsewhere yet
+	 * and thus can't be updated and repositioned. Instead, we collect the
+	 * vtime deltas separately and apply it asynchronously here.
+	 */
+	delta = cgc->cvtime_delta;
+	__sync_fetch_and_sub(&cgc->cvtime_delta, delta);
+	cvtime = cgv_node->cvtime + delta;
+
+	/*
+	 * Allow a cgroup to carry the maximum budget proportional to its
+	 * hweight such that a full-hweight cgroup can immediately take up half
+	 * of the CPUs at the most while staying at the front of the rbtree.
+	 */
+	max_budget = (cgrp_slice_ns * nr_cpus * cgc->hweight) /
+		(2 * FCG_HWEIGHT_ONE);
+	if (vtime_before(cvtime, cvtime_now - max_budget))
+		cvtime = cvtime_now - max_budget;
+
+	cgv_node->cvtime = cvtime;
+}
+
+static void cgrp_enqueued(struct cgroup *cgrp, struct fcg_cgrp_ctx *cgc)
+{
+	struct cgv_node_stash *stash;
+	struct cgv_node *cgv_node;
+	u64 cgid = cgrp->kn->id;
+
+	/* paired with cmpxchg in try_pick_next_cgroup() */
+	if (__sync_val_compare_and_swap(&cgc->queued, 0, 1)) {
+		stat_inc(FCG_STAT_ENQ_SKIP);
+		return;
+	}
+
+	stash = bpf_map_lookup_elem(&cgv_node_stash, &cgid);
+	if (!stash) {
+		scx_bpf_error("cgv_node lookup failed for cgid %llu", cgid);
+		return;
+	}
+
+	/* NULL if the node is already on the rbtree */
+	cgv_node = bpf_kptr_xchg(&stash->node, NULL);
+	if (!cgv_node) {
+		stat_inc(FCG_STAT_ENQ_RACE);
+		return;
+	}
+
+	bpf_spin_lock(&cgv_tree_lock);
+	cgrp_cap_budget(cgv_node, cgc);
+	bpf_rbtree_add(&cgv_tree, &cgv_node->rb_node, cgv_node_less);
+	bpf_spin_unlock(&cgv_tree_lock);
+}
+
+void BPF_STRUCT_OPS(fcg_enqueue, struct task_struct *p, u64 enq_flags)
+{
+	struct fcg_task_ctx *taskc;
+	struct cgroup *cgrp;
+	struct fcg_cgrp_ctx *cgc;
+
+	taskc = bpf_task_storage_get(&task_ctx, p, 0, 0);
+	if (!taskc) {
+		scx_bpf_error("task_ctx lookup failed");
+		return;
+	}
+
+	/*
+	 * If select_cpu_dfl() is recommending local enqueue, the target CPU is
+	 * idle. Follow it and charge the cgroup later in fcg_stopping() after
+	 * the fact. Use the same mechanism to deal with tasks with custom
+	 * affinities so that we don't have to worry about per-cgroup dq's
+	 * containing tasks that can't be executed from some CPUs.
+	 */
+	if ((enq_flags & SCX_ENQ_LOCAL) || p->nr_cpus_allowed != nr_cpus) {
+		/*
+		 * Tell fcg_stopping() that this bypassed the regular scheduling
+		 * path and should be force charged to the cgroup. 0 is used to
+		 * indicate that the task isn't bypassing, so if the current
+		 * runtime is 0, go back by one nanosecond.
+		 */
+		taskc->bypassed_at = p->se.sum_exec_runtime ?: (u64)-1;
+
+		/*
+		 * The global dq is deprioritized as we don't want to let tasks
+		 * to boost themselves by constraining its cpumask. The
+		 * deprioritization is rather severe, so let's not apply that to
+		 * per-cpu kernel threads. This is ham-fisted. We probably wanna
+		 * implement per-cgroup fallback dq's instead so that we have
+		 * more control over when tasks with custom cpumask get issued.
+		 */
+		if ((enq_flags & SCX_ENQ_LOCAL) ||
+		    (p->nr_cpus_allowed == 1 && (p->flags & PF_KTHREAD))) {
+			stat_inc(FCG_STAT_LOCAL);
+			scx_bpf_dispatch(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, enq_flags);
+		} else {
+			stat_inc(FCG_STAT_GLOBAL);
+			scx_bpf_dispatch(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
+		}
+		return;
+	}
+
+	cgrp = scx_bpf_task_cgroup(p);
+	cgc = find_cgrp_ctx(cgrp);
+	if (!cgc)
+		goto out_release;
+
+	scx_bpf_dispatch(p, cgrp->kn->id, SCX_SLICE_DFL, enq_flags);
+
+	cgrp_enqueued(cgrp, cgc);
+out_release:
+	bpf_cgroup_release(cgrp);
+}
+
+/*
+ * Walk the cgroup tree to update the active weight sums as tasks wake up and
+ * sleep. The weight sums are used as the base when calculating the proportion a
+ * given cgroup or task is entitled to at each level.
+ */
+static void update_active_weight_sums(struct cgroup *cgrp, bool runnable)
+{
+	struct fcg_cgrp_ctx *cgc;
+	bool updated = false;
+	int idx;
+
+	cgc = find_cgrp_ctx(cgrp);
+	if (!cgc)
+		return;
+
+	/*
+	 * In most cases, a hot cgroup would have multiple threads going to
+	 * sleep and waking up while the whole cgroup stays active. In leaf
+	 * cgroups, ->nr_runnable which is updated with __sync operations gates
+	 * ->nr_active updates, so that we don't have to grab the cgv_tree_lock
+	 * repeatedly for a busy cgroup which is staying active.
+	 */
+	if (runnable) {
+		if (__sync_fetch_and_add(&cgc->nr_runnable, 1))
+			return;
+		stat_inc(FCG_STAT_ACT);
+	} else {
+		if (__sync_sub_and_fetch(&cgc->nr_runnable, 1))
+			return;
+		stat_inc(FCG_STAT_DEACT);
+	}
+
+	/*
+	 * If @cgrp is becoming runnable, its hweight should be refreshed after
+	 * it's added to the weight tree so that enqueue has the up-to-date
+	 * value. If @cgrp is becoming quiescent, the hweight should be
+	 * refreshed before it's removed from the weight tree so that the usage
+	 * charging which happens afterwards has access to the latest value.
+	 */
+	if (!runnable)
+		cgrp_refresh_hweight(cgrp, cgc);
+
+	/* propagate upwards */
+	bpf_for(idx, 0, cgrp->level) {
+		int level = cgrp->level - idx;
+		struct fcg_cgrp_ctx *cgc, *pcgc = NULL;
+		bool propagate = false;
+
+		cgc = find_ancestor_cgrp_ctx(cgrp, level);
+		if (!cgc)
+			break;
+		if (level) {
+			pcgc = find_ancestor_cgrp_ctx(cgrp, level - 1);
+			if (!pcgc)
+				break;
+		}
+
+		/*
+		 * We need the propagation protected by a lock to synchronize
+		 * against weight changes. There's no reason to drop the lock at
+		 * each level but bpf_spin_lock() doesn't want any function
+		 * calls while locked.
+		 */
+		bpf_spin_lock(&cgv_tree_lock);
+
+		if (runnable) {
+			if (!cgc->nr_active++) {
+				updated = true;
+				if (pcgc) {
+					propagate = true;
+					pcgc->child_weight_sum += cgc->weight;
+				}
+			}
+		} else {
+			if (!--cgc->nr_active) {
+				updated = true;
+				if (pcgc) {
+					propagate = true;
+					pcgc->child_weight_sum -= cgc->weight;
+				}
+			}
+		}
+
+		bpf_spin_unlock(&cgv_tree_lock);
+
+		if (!propagate)
+			break;
+	}
+
+	if (updated)
+		__sync_fetch_and_add(&hweight_gen, 1);
+
+	if (runnable)
+		cgrp_refresh_hweight(cgrp, cgc);
+}
+
+void BPF_STRUCT_OPS(fcg_runnable, struct task_struct *p, u64 enq_flags)
+{
+	struct cgroup *cgrp;
+
+	cgrp = scx_bpf_task_cgroup(p);
+	update_active_weight_sums(cgrp, true);
+	bpf_cgroup_release(cgrp);
+}
+
+void BPF_STRUCT_OPS(fcg_stopping, struct task_struct *p, bool runnable)
+{
+	struct fcg_task_ctx *taskc;
+	struct cgroup *cgrp;
+	struct fcg_cgrp_ctx *cgc;
+
+	taskc = bpf_task_storage_get(&task_ctx, p, 0, 0);
+	if (!taskc) {
+		scx_bpf_error("task_ctx lookup failed");
+		return;
+	}
+
+	if (!taskc->bypassed_at)
+		return;
+
+	cgrp = scx_bpf_task_cgroup(p);
+	cgc = find_cgrp_ctx(cgrp);
+	if (cgc) {
+		__sync_fetch_and_add(&cgc->cvtime_delta,
+				     p->se.sum_exec_runtime - taskc->bypassed_at);
+		taskc->bypassed_at = 0;
+	}
+	bpf_cgroup_release(cgrp);
+}
+
+void BPF_STRUCT_OPS(fcg_quiescent, struct task_struct *p, u64 deq_flags)
+{
+	struct cgroup *cgrp;
+
+	cgrp = scx_bpf_task_cgroup(p);
+	update_active_weight_sums(cgrp, false);
+	bpf_cgroup_release(cgrp);
+}
+
+void BPF_STRUCT_OPS(fcg_cgroup_set_weight, struct cgroup *cgrp, u32 weight)
+{
+	struct fcg_cgrp_ctx *cgc, *pcgc = NULL;
+
+	cgc = find_cgrp_ctx(cgrp);
+	if (!cgc)
+		return;
+
+	if (cgrp->level) {
+		pcgc = find_ancestor_cgrp_ctx(cgrp, cgrp->level - 1);
+		if (!pcgc)
+			return;
+	}
+
+	bpf_spin_lock(&cgv_tree_lock);
+	if (pcgc && cgc->nr_active)
+		pcgc->child_weight_sum += (s64)weight - cgc->weight;
+	cgc->weight = weight;
+	bpf_spin_unlock(&cgv_tree_lock);
+}
+
+static bool try_pick_next_cgroup(u64 *cgidp)
+{
+	struct bpf_rb_node *rb_node;
+	struct cgv_node_stash *stash;
+	struct cgv_node *cgv_node;
+	struct fcg_cgrp_ctx *cgc;
+	struct cgroup *cgrp;
+	u64 cgid;
+
+	/* pop the front cgroup and wind cvtime_now accordingly */
+	bpf_spin_lock(&cgv_tree_lock);
+
+	rb_node = bpf_rbtree_first(&cgv_tree);
+	if (!rb_node) {
+		bpf_spin_unlock(&cgv_tree_lock);
+		stat_inc(FCG_STAT_PNC_NO_CGRP);
+		*cgidp = 0;
+		return true;
+	}
+
+	rb_node = bpf_rbtree_remove(&cgv_tree, rb_node);
+	bpf_spin_unlock(&cgv_tree_lock);
+
+	if (!rb_node) {
+		/*
+		 * This should never happen. bpf_rbtree_first() was called
+		 * above while the tree lock was held, so the node should
+		 * always be present.
+		 */
+		scx_bpf_error("node could not be removed");
+		return true;
+	}
+
+	cgv_node = container_of(rb_node, struct cgv_node, rb_node);
+	cgid = cgv_node->cgid;
+
+	if (vtime_before(cvtime_now, cgv_node->cvtime))
+		cvtime_now = cgv_node->cvtime;
+
+	/*
+	 * If lookup fails, the cgroup's gone. Free and move on. See
+	 * fcg_cgroup_exit().
+	 */
+	cgrp = bpf_cgroup_from_id(cgid);
+	if (!cgrp) {
+		stat_inc(FCG_STAT_PNC_GONE);
+		goto out_free;
+	}
+
+	cgc = bpf_cgrp_storage_get(&cgrp_ctx, cgrp, 0, 0);
+	if (!cgc) {
+		bpf_cgroup_release(cgrp);
+		stat_inc(FCG_STAT_PNC_GONE);
+		goto out_free;
+	}
+
+	if (!scx_bpf_consume(cgid)) {
+		bpf_cgroup_release(cgrp);
+		stat_inc(FCG_STAT_PNC_EMPTY);
+		goto out_stash;
+	}
+
+	/*
+	 * Successfully consumed from the cgroup. This will be our current
+	 * cgroup for the new slice. Refresh its hweight.
+	 */
+	cgrp_refresh_hweight(cgrp, cgc);
+
+	bpf_cgroup_release(cgrp);
+
+	/*
+	 * As the cgroup may have more tasks, add it back to the rbtree. Note
+	 * that here we charge the full slice upfront and then exact later
+	 * according to the actual consumption. This prevents lowpri thundering
+	 * herd from saturating the machine.
+	 */
+	bpf_spin_lock(&cgv_tree_lock);
+	cgv_node->cvtime += cgrp_slice_ns * FCG_HWEIGHT_ONE / (cgc->hweight ?: 1);
+	cgrp_cap_budget(cgv_node, cgc);
+	bpf_rbtree_add(&cgv_tree, &cgv_node->rb_node, cgv_node_less);
+	bpf_spin_unlock(&cgv_tree_lock);
+
+	*cgidp = cgid;
+	stat_inc(FCG_STAT_PNC_NEXT);
+	return true;
+
+out_stash:
+	stash = bpf_map_lookup_elem(&cgv_node_stash, &cgid);
+	if (!stash) {
+		stat_inc(FCG_STAT_PNC_GONE);
+		goto out_free;
+	}
+
+	/*
+	 * Paired with cmpxchg in cgrp_enqueued(). If they see the following
+	 * transition, they'll enqueue the cgroup. If they are earlier, we'll
+	 * see their task in the dq below and requeue the cgroup.
+	 */
+	__sync_val_compare_and_swap(&cgc->queued, 1, 0);
+
+	if (scx_bpf_dsq_nr_queued(cgid)) {
+		bpf_spin_lock(&cgv_tree_lock);
+		bpf_rbtree_add(&cgv_tree, &cgv_node->rb_node, cgv_node_less);
+		bpf_spin_unlock(&cgv_tree_lock);
+	} else {
+		cgv_node = bpf_kptr_xchg(&stash->node, cgv_node);
+		if (cgv_node) {
+			scx_bpf_error("unexpected !NULL cgv_node stash");
+			goto out_free;
+		}
+	}
+
+	return false;
+
+out_free:
+	bpf_obj_drop(cgv_node);
+	return false;
+}
+
+void BPF_STRUCT_OPS(fcg_dispatch, s32 cpu, struct task_struct *prev)
+{
+	struct fcg_cpu_ctx *cpuc;
+	struct fcg_cgrp_ctx *cgc;
+	struct cgroup *cgrp;
+	u64 now = bpf_ktime_get_ns();
+
+	cpuc = find_cpu_ctx();
+	if (!cpuc)
+		return;
+
+	if (!cpuc->cur_cgid)
+		goto pick_next_cgroup;
+
+	if (vtime_before(now, cpuc->cur_at + cgrp_slice_ns)) {
+		if (scx_bpf_consume(cpuc->cur_cgid)) {
+			stat_inc(FCG_STAT_CNS_KEEP);
+			return;
+		}
+		stat_inc(FCG_STAT_CNS_EMPTY);
+	} else {
+		stat_inc(FCG_STAT_CNS_EXPIRE);
+	}
+
+	/*
+	 * The current cgroup is expiring. It was already charged a full slice.
+	 * Calculate the actual usage and accumulate the delta.
+	 */
+	cgrp = bpf_cgroup_from_id(cpuc->cur_cgid);
+	if (!cgrp) {
+		stat_inc(FCG_STAT_CNS_GONE);
+		goto pick_next_cgroup;
+	}
+
+	cgc = bpf_cgrp_storage_get(&cgrp_ctx, cgrp, 0, 0);
+	if (cgc) {
+		/*
+		 * We want to update the vtime delta and then look for the next
+		 * cgroup to execute but the latter needs to be done in a loop
+		 * and we can't keep the lock held. Oh well...
+		 */
+		bpf_spin_lock(&cgv_tree_lock);
+		__sync_fetch_and_add(&cgc->cvtime_delta,
+				     (cpuc->cur_at + cgrp_slice_ns - now) *
+				     FCG_HWEIGHT_ONE / (cgc->hweight ?: 1));
+		bpf_spin_unlock(&cgv_tree_lock);
+	} else {
+		stat_inc(FCG_STAT_CNS_GONE);
+	}
+
+	bpf_cgroup_release(cgrp);
+
+pick_next_cgroup:
+	cpuc->cur_at = now;
+
+	if (scx_bpf_consume(SCX_DSQ_GLOBAL)) {
+		cpuc->cur_cgid = 0;
+		return;
+	}
+
+	bpf_repeat(BPF_MAX_LOOPS) {
+		if (try_pick_next_cgroup(&cpuc->cur_cgid))
+			break;
+	}
+}
+
+s32 BPF_STRUCT_OPS(fcg_prep_enable, struct task_struct *p,
+		   struct scx_enable_args *args)
+{
+	struct fcg_task_ctx *taskc;
+
+	/*
+	 * @p is new. Let's ensure that its task_ctx is available. We can sleep
+	 * in this function and the following will automatically use GFP_KERNEL.
+	 */
+	taskc = bpf_task_storage_get(&task_ctx, p, 0,
+				     BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (!taskc)
+		return -ENOMEM;
+
+	taskc->bypassed_at = 0;
+	return 0;
+}
+
+int BPF_STRUCT_OPS_SLEEPABLE(fcg_cgroup_init, struct cgroup *cgrp,
+			     struct scx_cgroup_init_args *args)
+{
+	struct fcg_cgrp_ctx *cgc;
+	struct cgv_node *cgv_node;
+	struct cgv_node_stash empty_stash = {}, *stash;
+	u64 cgid = cgrp->kn->id;
+	int ret;
+
+	/*
+	 * Technically incorrect as cgroup ID is full 64bit while dq ID is
+	 * 63bit. Should not be a problem in practice and easy to spot in the
+	 * unlikely case that it breaks.
+	 */
+	ret = scx_bpf_create_dsq(cgid, -1);
+	if (ret)
+		return ret;
+
+	cgc = bpf_cgrp_storage_get(&cgrp_ctx, cgrp, 0,
+				   BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (!cgc) {
+		ret = -ENOMEM;
+		goto err_destroy_dsq;
+	}
+
+	cgc->weight = args->weight;
+	cgc->hweight = FCG_HWEIGHT_ONE;
+
+	ret = bpf_map_update_elem(&cgv_node_stash, &cgid, &empty_stash,
+				  BPF_NOEXIST);
+	if (ret) {
+		if (ret != -ENOMEM)
+			scx_bpf_error("unexpected stash creation error (%d)",
+				      ret);
+		goto err_destroy_dsq;
+	}
+
+	stash = bpf_map_lookup_elem(&cgv_node_stash, &cgid);
+	if (!stash) {
+		scx_bpf_error("unexpected cgv_node stash lookup failure");
+		ret = -ENOENT;
+		goto err_destroy_dsq;
+	}
+
+	cgv_node = bpf_obj_new(struct cgv_node);
+	if (!cgv_node) {
+		ret = -ENOMEM;
+		goto err_del_cgv_node;
+	}
+
+	cgv_node->cgid = cgid;
+	cgv_node->cvtime = cvtime_now;
+
+	cgv_node = bpf_kptr_xchg(&stash->node, cgv_node);
+	if (cgv_node) {
+		scx_bpf_error("unexpected !NULL cgv_node stash");
+		ret = -EBUSY;
+		goto err_drop;
+	}
+
+	return 0;
+
+err_drop:
+	bpf_obj_drop(cgv_node);
+err_del_cgv_node:
+	bpf_map_delete_elem(&cgv_node_stash, &cgid);
+err_destroy_dsq:
+	scx_bpf_destroy_dsq(cgid);
+	return ret;
+}
+
+void BPF_STRUCT_OPS(fcg_cgroup_exit, struct cgroup *cgrp)
+{
+	u64 cgid = cgrp->kn->id;
+
+	/*
+	 * For now, there's no way find and remove the cgv_node if it's on the
+	 * cgv_tree. Let's drain them in the dispatch path as they get popped
+	 * off the front of the tree.
+	 */
+	bpf_map_delete_elem(&cgv_node_stash, &cgid);
+	scx_bpf_destroy_dsq(cgid);
+}
+
+s32 BPF_STRUCT_OPS(fcg_init)
+{
+	if (!switch_partial)
+		scx_bpf_switch_all();
+	return 0;
+}
+
+void BPF_STRUCT_OPS(fcg_exit, struct scx_exit_info *ei)
+{
+	uei_record(&uei, ei);
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops flatcg_ops = {
+	.enqueue		= (void *)fcg_enqueue,
+	.dispatch		= (void *)fcg_dispatch,
+	.runnable		= (void *)fcg_runnable,
+	.stopping		= (void *)fcg_stopping,
+	.quiescent		= (void *)fcg_quiescent,
+	.prep_enable		= (void *)fcg_prep_enable,
+	.cgroup_set_weight	= (void *)fcg_cgroup_set_weight,
+	.cgroup_init		= (void *)fcg_cgroup_init,
+	.cgroup_exit		= (void *)fcg_cgroup_exit,
+	.init			= (void *)fcg_init,
+	.exit			= (void *)fcg_exit,
+	.flags			= SCX_OPS_CGROUP_KNOB_WEIGHT | SCX_OPS_ENQ_EXITING,
+	.name			= "flatcg",
+};
diff --git a/tools/sched_ext/scx_flatcg.c b/tools/sched_ext/scx_flatcg.c
new file mode 100644
index 000000000000..f771b14b4e2a
--- /dev/null
+++ b/tools/sched_ext/scx_flatcg.c
@@ -0,0 +1,217 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2023 Tejun Heo <tj@kernel.org>
+ * Copyright (c) 2023 David Vernet <dvernet@meta.com>
+ */
+#include <stdio.h>
+#include <signal.h>
+#include <unistd.h>
+#include <libgen.h>
+#include <limits.h>
+#include <fcntl.h>
+#include <time.h>
+#include <bpf/bpf.h>
+#include "scx_common.h"
+#include "scx_flatcg.h"
+#include "scx_flatcg.skel.h"
+
+#ifndef FILEID_KERNFS
+#define FILEID_KERNFS		0xfe
+#endif
+
+const char help_fmt[] =
+"A flattened cgroup hierarchy sched_ext scheduler.\n"
+"\n"
+"See the top-level comment in .bpf.c for more details.\n"
+"\n"
+"Usage: %s [-s SLICE_US] [-i INTERVAL] [-p]\n"
+"\n"
+"  -s SLICE_US   Override slice duration\n"
+"  -i INTERVAL   Report interval\n"
+"  -p            Switch only tasks on SCHED_EXT policy intead of all\n"
+"  -h            Display this help and exit\n";
+
+static volatile int exit_req;
+
+static void sigint_handler(int dummy)
+{
+	exit_req = 1;
+}
+
+static float read_cpu_util(__u64 *last_sum, __u64 *last_idle)
+{
+	FILE *fp;
+	char buf[4096];
+	char *line, *cur = NULL, *tok;
+	__u64 sum = 0, idle = 0;
+	__u64 delta_sum, delta_idle;
+	int idx;
+
+	fp = fopen("/proc/stat", "r");
+	if (!fp) {
+		perror("fopen(\"/proc/stat\")");
+		return 0.0;
+	}
+
+	if (!fgets(buf, sizeof(buf), fp)) {
+		perror("fgets(\"/proc/stat\")");
+		fclose(fp);
+		return 0.0;
+	}
+	fclose(fp);
+
+	line = buf;
+	for (idx = 0; (tok = strtok_r(line, " \n", &cur)); idx++) {
+		char *endp = NULL;
+		__u64 v;
+
+		if (idx == 0) {
+			line = NULL;
+			continue;
+		}
+		v = strtoull(tok, &endp, 0);
+		if (!endp || *endp != '\0') {
+			fprintf(stderr, "failed to parse %dth field of /proc/stat (\"%s\")\n",
+				idx, tok);
+			continue;
+		}
+		sum += v;
+		if (idx == 4)
+			idle = v;
+	}
+
+	delta_sum = sum - *last_sum;
+	delta_idle = idle - *last_idle;
+	*last_sum = sum;
+	*last_idle = idle;
+
+	return delta_sum ? (float)(delta_sum - delta_idle) / delta_sum : 0.0;
+}
+
+static void fcg_read_stats(struct scx_flatcg *skel, __u64 *stats)
+{
+	__u64 cnts[FCG_NR_STATS][skel->rodata->nr_cpus];
+	__u32 idx;
+
+	memset(stats, 0, sizeof(stats[0]) * FCG_NR_STATS);
+
+	for (idx = 0; idx < FCG_NR_STATS; idx++) {
+		int ret, cpu;
+
+		ret = bpf_map_lookup_elem(bpf_map__fd(skel->maps.stats),
+					  &idx, cnts[idx]);
+		if (ret < 0)
+			continue;
+		for (cpu = 0; cpu < skel->rodata->nr_cpus; cpu++)
+			stats[idx] += cnts[idx][cpu];
+	}
+}
+
+int main(int argc, char **argv)
+{
+	struct scx_flatcg *skel;
+	struct bpf_link *link;
+	struct timespec intv_ts = { .tv_sec = 2, .tv_nsec = 0 };
+	bool dump_cgrps = false;
+	__u64 last_cpu_sum = 0, last_cpu_idle = 0;
+	__u64 last_stats[FCG_NR_STATS] = {};
+	unsigned long seq = 0;
+	__s32 opt;
+
+	signal(SIGINT, sigint_handler);
+	signal(SIGTERM, sigint_handler);
+
+	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
+
+	skel = scx_flatcg__open();
+	SCX_BUG_ON(!skel, "Failed to open skel");
+
+	skel->rodata->nr_cpus = libbpf_num_possible_cpus();
+
+	while ((opt = getopt(argc, argv, "s:i:dfph")) != -1) {
+		double v;
+
+		switch (opt) {
+		case 's':
+			v = strtod(optarg, NULL);
+			skel->rodata->cgrp_slice_ns = v * 1000;
+			break;
+		case 'i':
+			v = strtod(optarg, NULL);
+			intv_ts.tv_sec = v;
+			intv_ts.tv_nsec = (v - (float)intv_ts.tv_sec) * 1000000000;
+			break;
+		case 'd':
+			dump_cgrps = true;
+			break;
+		case 'p':
+			skel->rodata->switch_partial = true;
+			break;
+		case 'h':
+		default:
+			fprintf(stderr, help_fmt, basename(argv[0]));
+			return opt != 'h';
+		}
+	}
+
+	printf("slice=%.1lfms intv=%.1lfs dump_cgrps=%d",
+	       (double)skel->rodata->cgrp_slice_ns / 1000000.0,
+	       (double)intv_ts.tv_sec + (double)intv_ts.tv_nsec / 1000000000.0,
+	       dump_cgrps);
+
+	SCX_BUG_ON(scx_flatcg__load(skel), "Failed to load skel");
+
+	link = bpf_map__attach_struct_ops(skel->maps.flatcg_ops);
+	SCX_BUG_ON(!link, "Failed to attach struct_ops");
+
+	while (!exit_req && !uei_exited(&skel->bss->uei)) {
+		__u64 acc_stats[FCG_NR_STATS];
+		__u64 stats[FCG_NR_STATS];
+		float cpu_util;
+		int i;
+
+		cpu_util = read_cpu_util(&last_cpu_sum, &last_cpu_idle);
+
+		fcg_read_stats(skel, acc_stats);
+		for (i = 0; i < FCG_NR_STATS; i++)
+			stats[i] = acc_stats[i] - last_stats[i];
+
+		memcpy(last_stats, acc_stats, sizeof(acc_stats));
+
+		printf("\n[SEQ %6lu cpu=%5.1lf hweight_gen=%lu]\n",
+		       seq++, cpu_util * 100.0, skel->data->hweight_gen);
+		printf("       act:%6llu  deact:%6llu local:%6llu global:%6llu\n",
+		       stats[FCG_STAT_ACT],
+		       stats[FCG_STAT_DEACT],
+		       stats[FCG_STAT_LOCAL],
+		       stats[FCG_STAT_GLOBAL]);
+		printf("HWT   skip:%6llu   race:%6llu cache:%6llu update:%6llu\n",
+		       stats[FCG_STAT_HWT_SKIP],
+		       stats[FCG_STAT_HWT_RACE],
+		       stats[FCG_STAT_HWT_CACHE],
+		       stats[FCG_STAT_HWT_UPDATES]);
+		printf("ENQ   skip:%6llu   race:%6llu\n",
+		       stats[FCG_STAT_ENQ_SKIP],
+		       stats[FCG_STAT_ENQ_RACE]);
+		printf("CNS   keep:%6llu expire:%6llu empty:%6llu   gone:%6llu\n",
+		       stats[FCG_STAT_CNS_KEEP],
+		       stats[FCG_STAT_CNS_EXPIRE],
+		       stats[FCG_STAT_CNS_EMPTY],
+		       stats[FCG_STAT_CNS_GONE]);
+		printf("PNC nocgrp:%6llu   next:%6llu empty:%6llu   gone:%6llu\n",
+		       stats[FCG_STAT_PNC_NO_CGRP],
+		       stats[FCG_STAT_PNC_NEXT],
+		       stats[FCG_STAT_PNC_EMPTY],
+		       stats[FCG_STAT_PNC_GONE]);
+		printf("BAD remove:%6llu\n",
+		       acc_stats[FCG_STAT_BAD_REMOVAL]);
+
+		nanosleep(&intv_ts, NULL);
+	}
+
+	bpf_link__destroy(link);
+	uei_print(&skel->bss->uei);
+	scx_flatcg__destroy(skel);
+	return 0;
+}
diff --git a/tools/sched_ext/scx_flatcg.h b/tools/sched_ext/scx_flatcg.h
new file mode 100644
index 000000000000..490758ed41f0
--- /dev/null
+++ b/tools/sched_ext/scx_flatcg.h
@@ -0,0 +1,49 @@
+#ifndef __SCX_EXAMPLE_FLATCG_H
+#define __SCX_EXAMPLE_FLATCG_H
+
+enum {
+	FCG_HWEIGHT_ONE		= 1LLU << 16,
+};
+
+enum fcg_stat_idx {
+	FCG_STAT_ACT,
+	FCG_STAT_DEACT,
+	FCG_STAT_LOCAL,
+	FCG_STAT_GLOBAL,
+
+	FCG_STAT_HWT_UPDATES,
+	FCG_STAT_HWT_CACHE,
+	FCG_STAT_HWT_SKIP,
+	FCG_STAT_HWT_RACE,
+
+	FCG_STAT_ENQ_SKIP,
+	FCG_STAT_ENQ_RACE,
+
+	FCG_STAT_CNS_KEEP,
+	FCG_STAT_CNS_EXPIRE,
+	FCG_STAT_CNS_EMPTY,
+	FCG_STAT_CNS_GONE,
+
+	FCG_STAT_PNC_NO_CGRP,
+	FCG_STAT_PNC_NEXT,
+	FCG_STAT_PNC_EMPTY,
+	FCG_STAT_PNC_GONE,
+
+	FCG_STAT_BAD_REMOVAL,
+
+	FCG_NR_STATS,
+};
+
+struct fcg_cgrp_ctx {
+	u32			nr_active;
+	u32			nr_runnable;
+	u32			queued;
+	u32			weight;
+	u32			hweight;
+	u64			child_weight_sum;
+	u64			hweight_gen;
+	s64			cvtime_delta;
+	u64			tvtime_now;
+};
+
+#endif /* __SCX_EXAMPLE_FLATCG_H */
-- 
2.42.0


