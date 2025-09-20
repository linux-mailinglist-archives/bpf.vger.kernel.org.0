Return-Path: <bpf+bounces-69070-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 595BEB8BC50
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 03:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F26A71C229C2
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 01:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71E22E22BD;
	Sat, 20 Sep 2025 01:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rgS6rguN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEBF214A8B;
	Sat, 20 Sep 2025 01:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758330013; cv=none; b=JCzzhrEx7RpCK1/AnAYFE6wReLXEv+FKWB81/i//s/E4/br2JZlJRsZpB87oHCYALeBEsW/OTaB+fsa6uDIAexbPg6o5FAUqIrufE/S6MFH5StWBK0bSxqPekp0AO4pFgvMT6743Wl+BDvmcs0bZkY7Hic8L00LSz5kJ9v7hee8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758330013; c=relaxed/simple;
	bh=KhZEaKrzCoNIAslMx2Ja7V5abKuFCwhlOTy0RlzRlzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AtMOeWbr8QJwnjt/8uJMkwbMAKo/25NJZ99F9ADwlAU6xI05JgfMFokJ493AhOU+AHOKagC+p4LmIZHgXD43iJd14uMOt9v6yCuhDwjI/COtoLwbG8o/hsu/Dr7gWSPUpKzxHUdB/BpDpQ1pUswmh1tXwCNHbO9rbpEy2ltkWkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rgS6rguN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E838CC4CEF0;
	Sat, 20 Sep 2025 01:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758330013;
	bh=KhZEaKrzCoNIAslMx2Ja7V5abKuFCwhlOTy0RlzRlzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rgS6rguN3BPXTW+l/mST0hCkuocpifnk7YdfPT13Faii/8QGZ2BAtZ97TBNaZLVzK
	 fdAPdYtmZ8D20J/j+JtgU3ccZe1qmJJ1QcDsyx1iDam3jEz/MpBJwgu2hQMK/5YxNA
	 ky7SRy0TwEb1ikhVBqPx+0n0EpnQQZBMIa0GL1p8zS1Z9iMKRivWB1I/hEOgWVkVa3
	 C3bdoBdnon9/ZSDlbFKAbjlv58CLWzQl6yoyJyWwQuZ9McIEVhk0hyMWSvPuSCOaAV
	 f5EsmSXJOtMXc2h7XL9FUxOIHk1RVHLYPptFGYPMMquGC4q6VkLk8lDBz1Bmtsr/81
	 WvCUI1we/5W+Q==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	multics69@gmail.com
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	memxor@gmail.com,
	bpf@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 36/46] sched_ext: Move scx_dsp_ctx and scx_dsp_max_batch into scx_sched
Date: Fri, 19 Sep 2025 14:58:59 -1000
Message-ID: <20250920005931.2753828-37-tj@kernel.org>
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

scx_dsp_ctx and scx_dsp_max_batch are global variables used in the dispatch
path. In prepration for multiple scheduler support, move the former into
scx_sched_pcpu and the latter into scx_sched. No user-visible behavior
changes intended.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c          | 56 ++++++++++---------------------------
 kernel/sched/ext_internal.h | 18 ++++++++++++
 2 files changed, 33 insertions(+), 41 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 75a4b05fced4..3fcf6cd7fa00 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -102,25 +102,6 @@ static const struct rhashtable_params dsq_hash_params = {
 
 static LLIST_HEAD(dsqs_to_free);
 
-/* dispatch buf */
-struct scx_dsp_buf_ent {
-	struct task_struct	*task;
-	unsigned long		qseq;
-	u64			dsq_id;
-	u64			enq_flags;
-};
-
-static u32 scx_dsp_max_batch;
-
-struct scx_dsp_ctx {
-	struct rq		*rq;
-	u32			cursor;
-	u32			nr_tasks;
-	struct scx_dsp_buf_ent	buf[];
-};
-
-static struct scx_dsp_ctx __percpu *scx_dsp_ctx;
-
 /* string formatting from BPF */
 struct scx_bstr_buf {
 	u64			data[MAX_BPRINTF_VARARGS];
@@ -2164,7 +2145,7 @@ static void finish_dispatch(struct scx_sched *sch, struct rq *rq,
 
 static void flush_dispatch_buf(struct scx_sched *sch, struct rq *rq)
 {
-	struct scx_dsp_ctx *dspc = this_cpu_ptr(scx_dsp_ctx);
+	struct scx_dsp_ctx *dspc = &this_cpu_ptr(sch->pcpu)->dsp_ctx;
 	u32 u;
 
 	for (u = 0; u < dspc->cursor; u++) {
@@ -2181,7 +2162,7 @@ static void flush_dispatch_buf(struct scx_sched *sch, struct rq *rq)
 static bool scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
 			       struct task_struct *prev)
 {
-	struct scx_dsp_ctx *dspc = this_cpu_ptr(scx_dsp_ctx);
+	struct scx_dsp_ctx *dspc = &this_cpu_ptr(sch->pcpu)->dsp_ctx;
 	int nr_loops = SCX_DSP_MAX_LOOPS;
 	bool prev_on_sch = (prev->sched_class == &ext_sched_class) &&
 		sch == rcu_access_pointer(prev->scx.sched);
@@ -4356,10 +4337,6 @@ static void scx_root_disable(struct scx_sched *sch)
 	 */
 	kobject_del(&sch->kobj);
 
-	free_percpu(scx_dsp_ctx);
-	scx_dsp_ctx = NULL;
-	scx_dsp_max_batch = 0;
-
 	mutex_unlock(&scx_enable_mutex);
 
 	WARN_ON_ONCE(scx_set_enable_state(SCX_DISABLED) != SCX_DISABLING);
@@ -4785,7 +4762,10 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
 		sch->global_dsqs[node] = dsq;
 	}
 
-	sch->pcpu = alloc_percpu(struct scx_sched_pcpu);
+	sch->dsp_max_batch = ops->dispatch_max_batch ?: SCX_DSP_DFL_MAX_BATCH;
+	sch->pcpu = __alloc_percpu(struct_size_t(struct scx_sched_pcpu,
+						 dsp_ctx.buf, sch->dsp_max_batch),
+				   __alignof__(struct scx_sched_pcpu));
 	if (!sch->pcpu)
 		goto err_free_gdsqs;
 
@@ -4999,16 +4979,6 @@ static int scx_root_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	if (ret)
 		goto err_disable;
 
-	WARN_ON_ONCE(scx_dsp_ctx);
-	scx_dsp_max_batch = ops->dispatch_max_batch ?: SCX_DSP_DFL_MAX_BATCH;
-	scx_dsp_ctx = __alloc_percpu(struct_size_t(struct scx_dsp_ctx, buf,
-						   scx_dsp_max_batch),
-				     __alignof__(struct scx_dsp_ctx));
-	if (!scx_dsp_ctx) {
-		ret = -ENOMEM;
-		goto err_disable;
-	}
-
 	if (ops->timeout_ms)
 		timeout = msecs_to_jiffies(ops->timeout_ms);
 	else
@@ -5947,7 +5917,7 @@ static bool scx_dsq_insert_preamble(struct scx_sched *sch, struct task_struct *p
 static void scx_dsq_insert_commit(struct scx_sched *sch, struct task_struct *p,
 				  u64 dsq_id, u64 enq_flags)
 {
-	struct scx_dsp_ctx *dspc = this_cpu_ptr(scx_dsp_ctx);
+	struct scx_dsp_ctx *dspc = &this_cpu_ptr(sch->pcpu)->dsp_ctx;
 	struct task_struct *ddsp_task;
 
 	ddsp_task = __this_cpu_read(direct_dispatch_task);
@@ -5956,7 +5926,7 @@ static void scx_dsq_insert_commit(struct scx_sched *sch, struct task_struct *p,
 		return;
 	}
 
-	if (unlikely(dspc->cursor >= scx_dsp_max_batch)) {
+	if (unlikely(dspc->cursor >= sch->dsp_max_batch)) {
 		scx_error(sch, "dispatch buffer overflow");
 		return;
 	}
@@ -6204,7 +6174,7 @@ __bpf_kfunc u32 scx_bpf_dispatch_nr_slots(const struct bpf_prog_aux *aux__prog)
 	if (!scx_kf_allowed(sch, SCX_KF_DISPATCH))
 		return 0;
 
-	return scx_dsp_max_batch - __this_cpu_read(scx_dsp_ctx->cursor);
+	return sch->dsp_max_batch - __this_cpu_read(sch->pcpu->dsp_ctx.cursor);
 }
 
 /**
@@ -6216,8 +6186,8 @@ __bpf_kfunc u32 scx_bpf_dispatch_nr_slots(const struct bpf_prog_aux *aux__prog)
  */
 __bpf_kfunc void scx_bpf_dispatch_cancel(const struct bpf_prog_aux *aux__prog)
 {
-	struct scx_dsp_ctx *dspc = this_cpu_ptr(scx_dsp_ctx);
 	struct scx_sched *sch;
+	struct scx_dsp_ctx *dspc;
 
 	guard(rcu)();
 
@@ -6228,6 +6198,8 @@ __bpf_kfunc void scx_bpf_dispatch_cancel(const struct bpf_prog_aux *aux__prog)
 	if (!scx_kf_allowed(sch, SCX_KF_DISPATCH))
 		return;
 
+	dspc = &this_cpu_ptr(sch->pcpu)->dsp_ctx;
+
 	if (dspc->cursor > 0)
 		dspc->cursor--;
 	else
@@ -6252,9 +6224,9 @@ __bpf_kfunc void scx_bpf_dispatch_cancel(const struct bpf_prog_aux *aux__prog)
 __bpf_kfunc bool scx_bpf_dsq_move_to_local(u64 dsq_id,
 					   const struct bpf_prog_aux *aux__prog)
 {
-	struct scx_dsp_ctx *dspc = this_cpu_ptr(scx_dsp_ctx);
 	struct scx_dispatch_q *dsq;
 	struct scx_sched *sch;
+	struct scx_dsp_ctx *dspc;
 
 	guard(rcu)();
 
@@ -6265,6 +6237,8 @@ __bpf_kfunc bool scx_bpf_dsq_move_to_local(u64 dsq_id,
 	if (!scx_kf_allowed(sch, SCX_KF_DISPATCH))
 		return false;
 
+	dspc = &this_cpu_ptr(sch->pcpu)->dsp_ctx;
+
 	flush_dispatch_buf(sch, dspc->rq);
 
 	dsq = find_user_dsq(sch, dsq_id);
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index 083ca14f03e2..8dbdae910564 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -913,6 +913,21 @@ enum scx_sched_pcpu_flags {
 	SCX_SCHED_PCPU_BYPASSING	= 1LLU << 0,
 };
 
+/* dispatch buf */
+struct scx_dsp_buf_ent {
+	struct task_struct	*task;
+	unsigned long		qseq;
+	u64			dsq_id;
+	u64			enq_flags;
+};
+
+struct scx_dsp_ctx {
+	struct rq		*rq;
+	u32			cursor;
+	u32			nr_tasks;
+	struct scx_dsp_buf_ent	buf[];
+};
+
 struct scx_sched_pcpu {
 	u64			flags;	/* protected by rq lock */
 
@@ -922,6 +937,8 @@ struct scx_sched_pcpu {
 	 * constructed when requested by scx_bpf_events().
 	 */
 	struct scx_event_stats	event_stats;
+
+	struct scx_dsp_ctx	dsp_ctx;
 };
 
 struct scx_sched {
@@ -941,6 +958,7 @@ struct scx_sched {
 	struct scx_sched_pcpu __percpu *pcpu;
 
 	s32			bypass_depth;
+	u32			dsp_max_batch;
 	s32			level;
 	bool			warned_zero_slice:1;
 	bool			warned_deprecated_rq:1;
-- 
2.51.0


