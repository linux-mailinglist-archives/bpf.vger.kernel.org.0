Return-Path: <bpf+bounces-69076-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94144B8BC75
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 03:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64A93188721A
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 01:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767D4154BE2;
	Sat, 20 Sep 2025 01:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GaL5xlCV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC16D213E9F;
	Sat, 20 Sep 2025 01:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758330019; cv=none; b=QKoexoKVt0axIlWBsdpwrCnv4lFEKTBBL0QDUIZJgZ714tesmGyzpGcpDudA/XHU5OLVVSV++yYxVpfDELOEqCSrDuF+dt4h9qaLyi0k80P3z8i+RnUqD3nknlPwRCVW8VMZxjjpvgCBpd6shJa2G9qlInZeE4/ujARaK4wZbEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758330019; c=relaxed/simple;
	bh=sb1myuJPbjXLD17UAMGbP7/cYQi73LX/+Q6LZZ/4pGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VmZJxo+twyzc+DYPoImCTyJkywozD5qPdTY2pmmnbvK5dB0YpHLhoTg/4JGbF3M8r+cgbR63hYowjbTPGl8N758bjnGwcVpezrepZWI1eQzhZezks49p20MXJYOInIHeFL4cEZrt74lZYKckQTI2CFAsGqHKmf7QsBV36zFbpos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GaL5xlCV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ABD1C4CEF5;
	Sat, 20 Sep 2025 01:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758330019;
	bh=sb1myuJPbjXLD17UAMGbP7/cYQi73LX/+Q6LZZ/4pGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GaL5xlCVkP51PLvNpqjqUTO8G4ZCkbY67vS1svpSj5ZTkqEOcTQuzg0/3F5mQ25lM
	 c6X4pRt/zd43EBh9p8LE/5xqeNY60tOOROjYiI0Kq3FzqfC6EGYCXgf0RXt3mn/p5q
	 LGEQh8yrnLnxDoXVvKRsDVE4fAHa/OgD+m0R+v/p/DOT+1Aut44hFEOTvepzv7SuI4
	 qs+kPcKWmcR9wQPa9Nx0H5uonG1TwoibedDUZuy5hMqpGHAKEw6izlgBNbMHXnj6m/
	 pVi7xXmpyoE3eRh+DY8rZnfM7wulDBoJMk8GNDudJbkGoW3xccFR7Jxa72CQUde2kt
	 lkEPnghE+H+yQ==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	multics69@gmail.com
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	memxor@gmail.com,
	bpf@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 42/46] sched_ext: Wrap global DSQs in per-node structure
Date: Fri, 19 Sep 2025 14:59:05 -1000
Message-ID: <20250920005931.2753828-43-tj@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250920005931.2753828-1-tj@kernel.org>
References: <20250920005931.2753828-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, global DSQs are stored as an array of pointers to
scx_dispatch_q structs, one per NUMA node. This is limiting for future
enhancements that may require additional per-node data structures.

Introduce scx_sched_pnode structure to wrap the global DSQ. This change
replaces the global_dsqs array with a pnode array of scx_sched_pnode
structs and updates all references to access global_dsq through the
pnode wrapper.

This refactoring maintains NUMA-aware allocation and provides foundation
for adding more per-node data structures with no functional impact.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c          | 33 ++++++++++++++++-----------------
 kernel/sched/ext_internal.h |  6 +++++-
 2 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index eff5f6894f14..a74ae955c489 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -274,7 +274,7 @@ static bool scx_is_descendant(struct scx_sched *sch, struct scx_sched *ancestor)
 static struct scx_dispatch_q *find_global_dsq(struct scx_sched *sch,
 					      struct task_struct *p)
 {
-	return sch->global_dsqs[cpu_to_node(task_cpu(p))];
+	return &sch->pnode[cpu_to_node(task_cpu(p))]->global_dsq;
 }
 
 static struct scx_dispatch_q *find_user_dsq(struct scx_sched *sch, u64 dsq_id)
@@ -1965,7 +1965,7 @@ static bool consume_global_dsq(struct scx_sched *sch, struct rq *rq)
 {
 	int node = cpu_to_node(cpu_of(rq));
 
-	return consume_dispatch_q(sch, rq, sch->global_dsqs[node]);
+	return consume_dispatch_q(sch, rq, &sch->pnode[node]->global_dsq);
 }
 
 /**
@@ -3733,8 +3733,8 @@ static void scx_sched_free_rcu_work(struct work_struct *work)
 	free_percpu(sch->pcpu);
 
 	for_each_node_state(node, N_POSSIBLE)
-		kfree(sch->global_dsqs[node]);
-	kfree(sch->global_dsqs);
+		kfree(sch->pnode[node]);
+	kfree(sch->pnode);
 
 	rhashtable_walk_enter(&sch->dsq_hash, &rht_iter);
 	do {
@@ -4935,24 +4935,23 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
 	if (ret < 0)
 		goto err_free_ei;
 
-	sch->global_dsqs = kcalloc(nr_node_ids, sizeof(sch->global_dsqs[0]),
-				   GFP_KERNEL);
-	if (!sch->global_dsqs) {
+	sch->pnode = kcalloc(nr_node_ids, sizeof(sch->pnode[0]), GFP_KERNEL);
+	if (!sch->pnode) {
 		ret = -ENOMEM;
 		goto err_free_hash;
 	}
 
 	for_each_node_state(node, N_POSSIBLE) {
-		struct scx_dispatch_q *dsq;
+		struct scx_sched_pnode *pnode;
 
-		dsq = kzalloc_node(sizeof(*dsq), GFP_KERNEL, node);
-		if (!dsq) {
+		pnode = kzalloc_node(sizeof(*pnode), GFP_KERNEL, node);
+		if (!pnode) {
 			ret = -ENOMEM;
-			goto err_free_gdsqs;
+			goto err_free_pnode;
 		}
 
-		init_dsq(dsq, SCX_DSQ_GLOBAL, sch);
-		sch->global_dsqs[node] = dsq;
+		init_dsq(&pnode->global_dsq, SCX_DSQ_GLOBAL, sch);
+		sch->pnode[node] = pnode;
 	}
 
 	sch->dsp_max_batch = ops->dispatch_max_batch ?: SCX_DSP_DFL_MAX_BATCH;
@@ -4960,7 +4959,7 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
 						 dsp_ctx.buf, sch->dsp_max_batch),
 				   __alignof__(struct scx_sched_pcpu));
 	if (!sch->pcpu)
-		goto err_free_gdsqs;
+		goto err_free_pnode;
 
 	sch->helper = kthread_run_worker(0, "sched_ext_helper");
 	if (!sch->helper)
@@ -5031,10 +5030,10 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
 	kthread_stop(sch->helper->task);
 err_free_pcpu:
 	free_percpu(sch->pcpu);
-err_free_gdsqs:
+err_free_pnode:
 	for_each_node_state(node, N_POSSIBLE)
-		kfree(sch->global_dsqs[node]);
-	kfree(sch->global_dsqs);
+		kfree(sch->pnode[node]);
+	kfree(sch->pnode);
 err_free_hash:
 	rhashtable_free_and_destroy(&sch->dsq_hash, NULL, NULL);
 err_free_ei:
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index 4399c003c15f..846855ea5948 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -941,6 +941,10 @@ struct scx_sched_pcpu {
 	struct scx_dsp_ctx	dsp_ctx;
 };
 
+struct scx_sched_pnode {
+	struct scx_dispatch_q	global_dsq;
+};
+
 struct scx_sched {
 	struct sched_ext_ops	ops;
 	DECLARE_BITMAP(has_op, SCX_OPI_END);
@@ -954,7 +958,7 @@ struct scx_sched {
 	 * per-node split isn't sufficient, it can be further split.
 	 */
 	struct rhashtable	dsq_hash;
-	struct scx_dispatch_q	**global_dsqs;
+	struct scx_sched_pnode	**pnode;
 	struct scx_sched_pcpu __percpu *pcpu;
 
 	s32			bypass_depth;
-- 
2.51.0


