Return-Path: <bpf+bounces-46218-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DEC69E6228
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 01:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1E6218845B0
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 00:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4000712C499;
	Fri,  6 Dec 2024 00:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TMJNYpA4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3568126C04;
	Fri,  6 Dec 2024 00:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733444675; cv=none; b=JCOIJYTfQpr6idnIAhK2A92XuuWJwjbQuBvNCAgPJVO/fL6sAVRwRkFhYr+lZDWJpKtLJgJ7HwyZ8MsFdQRqwUW/STSSF3rtFvacTgp/0ccri9fordB2wadIqxCHUr+XWHIu23od38ldK8WakCnC8D6NSUUKKIVZpbIGhu4UjlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733444675; c=relaxed/simple;
	bh=2NHAC/ucuHOP+dlhjMOWq5m414F5Fa63pCr8kcoZANw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ApMCF5uUgc8YMg0HUjmnQKNGH7xV06ka7VYFqMqONN/ObNxxwdXqiqpJ/Fem5DttIsvoiUTt7uIGLDxgx1gNSA4ltPy8kUAlJS7Gvl1JYb7yo71ElSzLrchgaMNYJhtQoDqCOUo7LVrSyHCQNHJ5hYgIvnSf7J+OGjdoKQcy2QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TMJNYpA4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A5D1C4CEDE;
	Fri,  6 Dec 2024 00:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733444675;
	bh=2NHAC/ucuHOP+dlhjMOWq5m414F5Fa63pCr8kcoZANw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TMJNYpA4TY1sa/yhPNmOTItnOBduRdjmQn1Z539woQX3k+TyNkP1nGqZ8s8vdzUHP
	 TZrhBS/0XZprMR3u0/AeRfD6FbDciXQZaai26J4OvEdGbp8baa3ZRaoJThNy7ntgnH
	 1USoJA9pDHeYCZKhkmfXVNVEP8n+fXou3+reJatRwAtd+y7tFSeSDwRqOpw8Sh4FaT
	 7pZpqrpcJV3JwaCaDLORFxSxMelgvoLpHF4BOQBPQilymqUxLXeFiMAJvGwkO5PJPr
	 bh06hxn4bkjGRScpVfVwNAdc9xpi0z9ERW1zpm4D4Ab0HUI4KUfdHhQz3JmbiOQodg
	 s8RH9I0mAQb6g==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	peterz@infradead.org,
	mingo@kernel.org
Cc: oleg@redhat.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jolsa@kernel.org,
	liaochang1@huawei.com,
	kernel-team@meta.com,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH perf/core 4/4] uprobes: reuse return_instances between multiple uretprobes within task
Date: Thu,  5 Dec 2024 16:24:17 -0800
Message-ID: <20241206002417.3295533-5-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241206002417.3295533-1-andrii@kernel.org>
References: <20241206002417.3295533-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Instead of constantly allocating and freeing very short-lived
struct return_instance, reuse it as much as possible within current
task. For that, store a linked list of reusable return_instances within
current->utask.

The only complication is that ri_timer() might be still processing such
return_instance. And so while the main uretprobe processing logic might
be already done with return_instance and would be OK to immediately
reuse it for the next uretprobe instance, it's not correct to
unconditionally reuse it just like that.

Instead we make sure that ri_timer() can't possibly be processing it by
using seqcount_t, with ri_timer() being "a writer", while
free_ret_instance() being "a reader". If, after we unlink return
instance from utask->return_instances list, we know that ri_timer()
hasn't gotten to processing utask->return_instances yet, then we can be
sure that immediate return_instance reuse is OK, and so we put it
onto utask->ri_pool for future (potentially, almost immediate) reuse.

This change shows improvements both in single CPU performance (by
avoiding relatively expensive kmalloc/free combon) and in terms of
multi-CPU scalability, where you can see that per-CPU throughput doesn't
decline as steeply with increased number of CPUs (which were previously
attributed to kmalloc()/free() through profiling):

BASELINE (latest perf/core)
===========================
uretprobe-nop         ( 1 cpus):    1.898 ± 0.002M/s  (  1.898M/s/cpu)
uretprobe-nop         ( 2 cpus):    3.574 ± 0.011M/s  (  1.787M/s/cpu)
uretprobe-nop         ( 3 cpus):    5.279 ± 0.066M/s  (  1.760M/s/cpu)
uretprobe-nop         ( 4 cpus):    6.824 ± 0.047M/s  (  1.706M/s/cpu)
uretprobe-nop         ( 5 cpus):    8.339 ± 0.060M/s  (  1.668M/s/cpu)
uretprobe-nop         ( 6 cpus):    9.812 ± 0.047M/s  (  1.635M/s/cpu)
uretprobe-nop         ( 7 cpus):   11.030 ± 0.048M/s  (  1.576M/s/cpu)
uretprobe-nop         ( 8 cpus):   12.453 ± 0.126M/s  (  1.557M/s/cpu)
uretprobe-nop         (10 cpus):   14.838 ± 0.044M/s  (  1.484M/s/cpu)
uretprobe-nop         (12 cpus):   17.092 ± 0.115M/s  (  1.424M/s/cpu)
uretprobe-nop         (14 cpus):   19.576 ± 0.022M/s  (  1.398M/s/cpu)
uretprobe-nop         (16 cpus):   22.264 ± 0.015M/s  (  1.391M/s/cpu)
uretprobe-nop         (24 cpus):   33.534 ± 0.078M/s  (  1.397M/s/cpu)
uretprobe-nop         (32 cpus):   43.262 ± 0.127M/s  (  1.352M/s/cpu)
uretprobe-nop         (40 cpus):   53.252 ± 0.080M/s  (  1.331M/s/cpu)
uretprobe-nop         (48 cpus):   55.778 ± 0.045M/s  (  1.162M/s/cpu)
uretprobe-nop         (56 cpus):   56.850 ± 0.227M/s  (  1.015M/s/cpu)
uretprobe-nop         (64 cpus):   62.005 ± 0.077M/s  (  0.969M/s/cpu)
uretprobe-nop         (72 cpus):   66.445 ± 0.236M/s  (  0.923M/s/cpu)
uretprobe-nop         (80 cpus):   68.353 ± 0.180M/s  (  0.854M/s/cpu)

THIS PATCHSET (on top of latest perf/core)
==========================================
uretprobe-nop         ( 1 cpus):    2.253 ± 0.004M/s  (  2.253M/s/cpu)
uretprobe-nop         ( 2 cpus):    4.281 ± 0.003M/s  (  2.140M/s/cpu)
uretprobe-nop         ( 3 cpus):    6.389 ± 0.027M/s  (  2.130M/s/cpu)
uretprobe-nop         ( 4 cpus):    8.328 ± 0.005M/s  (  2.082M/s/cpu)
uretprobe-nop         ( 5 cpus):   10.353 ± 0.001M/s  (  2.071M/s/cpu)
uretprobe-nop         ( 6 cpus):   12.513 ± 0.010M/s  (  2.086M/s/cpu)
uretprobe-nop         ( 7 cpus):   14.525 ± 0.017M/s  (  2.075M/s/cpu)
uretprobe-nop         ( 8 cpus):   15.633 ± 0.013M/s  (  1.954M/s/cpu)
uretprobe-nop         (10 cpus):   19.532 ± 0.011M/s  (  1.953M/s/cpu)
uretprobe-nop         (12 cpus):   21.405 ± 0.009M/s  (  1.784M/s/cpu)
uretprobe-nop         (14 cpus):   24.857 ± 0.020M/s  (  1.776M/s/cpu)
uretprobe-nop         (16 cpus):   26.466 ± 0.018M/s  (  1.654M/s/cpu)
uretprobe-nop         (24 cpus):   40.513 ± 0.222M/s  (  1.688M/s/cpu)
uretprobe-nop         (32 cpus):   54.180 ± 0.074M/s  (  1.693M/s/cpu)
uretprobe-nop         (40 cpus):   66.100 ± 0.082M/s  (  1.652M/s/cpu)
uretprobe-nop         (48 cpus):   70.544 ± 0.068M/s  (  1.470M/s/cpu)
uretprobe-nop         (56 cpus):   74.494 ± 0.055M/s  (  1.330M/s/cpu)
uretprobe-nop         (64 cpus):   79.317 ± 0.029M/s  (  1.239M/s/cpu)
uretprobe-nop         (72 cpus):   84.875 ± 0.020M/s  (  1.179M/s/cpu)
uretprobe-nop         (80 cpus):   92.318 ± 0.224M/s  (  1.154M/s/cpu)

For reference, with uprobe-nop we hit the following throughput:

uprobe-nop            (80 cpus):  143.485 ± 0.035M/s  (  1.794M/s/cpu)

So now uretprobe stays a bit closer to that performance.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/uprobes.h |  6 ++-
 kernel/events/uprobes.c | 83 ++++++++++++++++++++++++++++++++++-------
 2 files changed, 75 insertions(+), 14 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 1d449978558d..b1df7d792fa1 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -16,6 +16,7 @@
 #include <linux/types.h>
 #include <linux/wait.h>
 #include <linux/timer.h>
+#include <linux/seqlock.h>
 
 struct uprobe;
 struct vm_area_struct;
@@ -124,6 +125,10 @@ struct uprobe_task {
 	unsigned int			depth;
 	struct return_instance		*return_instances;
 
+	struct return_instance		*ri_pool;
+	struct timer_list		ri_timer;
+	seqcount_t			ri_seqcount;
+
 	union {
 		struct {
 			struct arch_uprobe_task	autask;
@@ -137,7 +142,6 @@ struct uprobe_task {
 	};
 
 	struct uprobe			*active_uprobe;
-	struct timer_list		ri_timer;
 	unsigned long			xol_vaddr;
 
 	struct arch_uprobe              *auprobe;
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 2345aeb63d3b..1af950208c2b 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1888,8 +1888,34 @@ unsigned long uprobe_get_trap_addr(struct pt_regs *regs)
 	return instruction_pointer(regs);
 }
 
-static void free_ret_instance(struct return_instance *ri, bool cleanup_hprobe)
+static void ri_pool_push(struct uprobe_task *utask, struct return_instance *ri)
 {
+	ri->cons_cnt = 0;
+	ri->next = utask->ri_pool;
+	utask->ri_pool = ri;
+}
+
+static struct return_instance *ri_pool_pop(struct uprobe_task *utask)
+{
+	struct return_instance *ri = utask->ri_pool;
+
+	if (likely(ri))
+		utask->ri_pool = ri->next;
+
+	return ri;
+}
+
+static void ri_free(struct return_instance *ri)
+{
+	kfree(ri->extra_consumers);
+	kfree_rcu(ri, rcu);
+}
+
+static void free_ret_instance(struct uprobe_task *utask,
+			      struct return_instance *ri, bool cleanup_hprobe)
+{
+	unsigned seq;
+
 	if (cleanup_hprobe) {
 		enum hprobe_state hstate;
 
@@ -1897,8 +1923,22 @@ static void free_ret_instance(struct return_instance *ri, bool cleanup_hprobe)
 		hprobe_finalize(&ri->hprobe, hstate);
 	}
 
-	kfree(ri->extra_consumers);
-	kfree_rcu(ri, rcu);
+	/*
+	 * At this point return_instance is unlinked from utask's
+	 * return_instances list and this has become visible to ri_timer().
+	 * If seqcount now indicates that ri_timer's return instance
+	 * processing loop isn't active, we can return ri into the pool of
+	 * to-be-reused return instances for future uretprobes. If ri_timer()
+	 * happens to be running right now, though, we fallback to safety and
+	 * just perform RCU-delated freeing of ri.
+	 */
+	if (raw_seqcount_try_begin(&utask->ri_seqcount, seq)) {
+		/* immediate reuse of ri without RCU GP is OK */
+		ri_pool_push(utask, ri);
+	} else {
+		/* we might be racing with ri_timer(), so play it safe */
+		ri_free(ri);
+	}
 }
 
 /*
@@ -1920,7 +1960,15 @@ void uprobe_free_utask(struct task_struct *t)
 	ri = utask->return_instances;
 	while (ri) {
 		ri_next = ri->next;
-		free_ret_instance(ri, true /* cleanup_hprobe */);
+		free_ret_instance(utask, ri, true /* cleanup_hprobe */);
+		ri = ri_next;
+	}
+
+	/* free_ret_instance() above might add to ri_pool, so this loop should come last */
+	ri = utask->ri_pool;
+	while (ri) {
+		ri_next = ri->next;
+		ri_free(ri);
 		ri = ri_next;
 	}
 
@@ -1943,8 +1991,12 @@ static void ri_timer(struct timer_list *timer)
 	/* RCU protects return_instance from freeing. */
 	guard(rcu)();
 
+	write_seqcount_begin(&utask->ri_seqcount);
+
 	for_each_ret_instance_rcu(ri, utask->return_instances)
 		hprobe_expire(&ri->hprobe, false);
+
+	write_seqcount_end(&utask->ri_seqcount);
 }
 
 static struct uprobe_task *alloc_utask(void)
@@ -1956,6 +2008,7 @@ static struct uprobe_task *alloc_utask(void)
 		return NULL;
 
 	timer_setup(&utask->ri_timer, ri_timer, 0);
+	seqcount_init(&utask->ri_seqcount);
 
 	return utask;
 }
@@ -1975,10 +2028,14 @@ static struct uprobe_task *get_utask(void)
 	return current->utask;
 }
 
-static struct return_instance *alloc_return_instance(void)
+static struct return_instance *alloc_return_instance(struct uprobe_task *utask)
 {
 	struct return_instance *ri;
 
+	ri = ri_pool_pop(utask);
+	if (ri)
+		return ri;
+
 	ri = kzalloc(sizeof(*ri), GFP_KERNEL);
 	if (!ri)
 		return ZERO_SIZE_PTR;
@@ -2119,7 +2176,7 @@ static void cleanup_return_instances(struct uprobe_task *utask, bool chained,
 		rcu_assign_pointer(utask->return_instances, ri_next);
 		utask->depth--;
 
-		free_ret_instance(ri, true /* cleanup_hprobe */);
+		free_ret_instance(utask, ri, true /* cleanup_hprobe */);
 		ri = ri_next;
 	}
 }
@@ -2186,7 +2243,7 @@ static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs,
 
 	return;
 free:
-	kfree(ri);
+	ri_free(ri);
 }
 
 /* Prepare to single-step probed instruction out of line. */
@@ -2385,8 +2442,7 @@ static struct return_instance *push_consumer(struct return_instance *ri, __u64 i
 	if (unlikely(ri->cons_cnt > 0)) {
 		ric = krealloc(ri->extra_consumers, sizeof(*ric) * ri->cons_cnt, GFP_KERNEL);
 		if (!ric) {
-			kfree(ri->extra_consumers);
-			kfree_rcu(ri, rcu);
+			ri_free(ri);
 			return ZERO_SIZE_PTR;
 		}
 		ri->extra_consumers = ric;
@@ -2428,8 +2484,9 @@ static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
 	struct uprobe_consumer *uc;
 	bool has_consumers = false, remove = true;
 	struct return_instance *ri = NULL;
+	struct uprobe_task *utask = current->utask;
 
-	current->utask->auprobe = &uprobe->arch;
+	utask->auprobe = &uprobe->arch;
 
 	list_for_each_entry_rcu(uc, &uprobe->consumers, cons_node, rcu_read_lock_trace_held()) {
 		bool session = uc->handler && uc->ret_handler;
@@ -2449,12 +2506,12 @@ static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
 			continue;
 
 		if (!ri)
-			ri = alloc_return_instance();
+			ri = alloc_return_instance(utask);
 
 		if (session)
 			ri = push_consumer(ri, uc->id, cookie);
 	}
-	current->utask->auprobe = NULL;
+	utask->auprobe = NULL;
 
 	if (!ZERO_OR_NULL_PTR(ri))
 		prepare_uretprobe(uprobe, regs, ri);
@@ -2554,7 +2611,7 @@ void uprobe_handle_trampoline(struct pt_regs *regs)
 			hprobe_finalize(&ri->hprobe, hstate);
 
 			/* We already took care of hprobe, no need to waste more time on that. */
-			free_ret_instance(ri, false /* !cleanup_hprobe */);
+			free_ret_instance(utask, ri, false /* !cleanup_hprobe */);
 			ri = ri_next;
 		} while (ri != next_chain);
 	} while (!valid);
-- 
2.43.5


