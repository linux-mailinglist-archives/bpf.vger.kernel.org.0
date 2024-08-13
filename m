Return-Path: <bpf+bounces-36997-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3E194FCBA
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 06:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B7DBB2220F
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 04:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC5A59147;
	Tue, 13 Aug 2024 04:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2qy7pu5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3804D8A3;
	Tue, 13 Aug 2024 04:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723523407; cv=none; b=T0QfdKCMYyrHMSLjn041FRXO3yRZyXBLRIi5fItieLEJl3tyjB0xoeaAEGGaqO2YmMixke8RYsutft+GM4uLCH/7byt4RIiynW3wyxtcufL4TRixWyzO+CH/WOxQWafNZkERo0QhaouOVulKayIBE87g8ajMuQs8mKOhV2/Cy/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723523407; c=relaxed/simple;
	bh=/A8ty9vSHeed+/Tmg8mjROrsgzuVWuvPWZwEBfeENiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HjVH/VjxgZHn/GCzwQAG5mZUmdOdMXxA32VH7vSG1esmJmNEtYmbLRY87v0MMJAXCCo009bbE/c1lTvDSsAafD8WbklsxFSCpLngWatH5IyXjTDt3y8Hnpr7wPSjjbmVEj+seOVEtE4Zdc2E3NRJvPm4dLtC+j7NOaPyNDIIzGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2qy7pu5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79525C4AF09;
	Tue, 13 Aug 2024 04:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723523406;
	bh=/A8ty9vSHeed+/Tmg8mjROrsgzuVWuvPWZwEBfeENiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d2qy7pu5HAsPWWumRq01aZd6gxWYz+LakPOyZo1KSVcUIbFFAOKnY0fvLJCCcMz3n
	 S7FW8vDRhrRhV6WuTOlFVnLitf9+sX914g7iwpYCEgly8XpAk2bnpn/VMtVeT9h9hO
	 xtxGG3ZUFpy9p1rzB7+skRPDxCUGK5WO28qdfrpCE6ehDS17O08zwhNcEzOK8r2hDR
	 QHdPqa3PjFW8zXOvH7umQpEDoECxWeIc0GAmqMQtPgUWLpuz4xiyPC9UwQ/+U9H5HM
	 zsTNPSHwveyM5xApxsr0P5qr5fTmgTQSoxAXIROeV8CxolMdeU6vqZLTk6JPSjd4aa
	 Y2So+16jdHo8g==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	peterz@infradead.org,
	oleg@redhat.com
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jolsa@kernel.org,
	paulmck@kernel.org,
	willy@infradead.org,
	surenb@google.com,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v3 08/13] uprobes: switch to RCU Tasks Trace flavor for better performance
Date: Mon, 12 Aug 2024 21:29:12 -0700
Message-ID: <20240813042917.506057-9-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240813042917.506057-1-andrii@kernel.org>
References: <20240813042917.506057-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch switches uprobes SRCU usage to RCU Tasks Trace flavor, which
is optimized for more lightweight and quick readers (at the expense of
slower writers, which for uprobes is a fine tradeof) and has better
performance and scalability with number of CPUs.

Similarly to baseline vs SRCU, we've benchmarked SRCU-based
implementation vs RCU Tasks Trace implementation.

SRCU
====
uprobe-nop      ( 1 cpus):    3.276 ± 0.005M/s  (  3.276M/s/cpu)
uprobe-nop      ( 2 cpus):    4.125 ± 0.002M/s  (  2.063M/s/cpu)
uprobe-nop      ( 4 cpus):    7.713 ± 0.002M/s  (  1.928M/s/cpu)
uprobe-nop      ( 8 cpus):    8.097 ± 0.006M/s  (  1.012M/s/cpu)
uprobe-nop      (16 cpus):    6.501 ± 0.056M/s  (  0.406M/s/cpu)
uprobe-nop      (32 cpus):    4.398 ± 0.084M/s  (  0.137M/s/cpu)
uprobe-nop      (64 cpus):    6.452 ± 0.000M/s  (  0.101M/s/cpu)

uretprobe-nop   ( 1 cpus):    2.055 ± 0.001M/s  (  2.055M/s/cpu)
uretprobe-nop   ( 2 cpus):    2.677 ± 0.000M/s  (  1.339M/s/cpu)
uretprobe-nop   ( 4 cpus):    4.561 ± 0.003M/s  (  1.140M/s/cpu)
uretprobe-nop   ( 8 cpus):    5.291 ± 0.002M/s  (  0.661M/s/cpu)
uretprobe-nop   (16 cpus):    5.065 ± 0.019M/s  (  0.317M/s/cpu)
uretprobe-nop   (32 cpus):    3.622 ± 0.003M/s  (  0.113M/s/cpu)
uretprobe-nop   (64 cpus):    3.723 ± 0.002M/s  (  0.058M/s/cpu)

RCU Tasks Trace
===============
uprobe-nop      ( 1 cpus):    3.396 ± 0.002M/s  (  3.396M/s/cpu)
uprobe-nop      ( 2 cpus):    4.271 ± 0.006M/s  (  2.135M/s/cpu)
uprobe-nop      ( 4 cpus):    8.499 ± 0.015M/s  (  2.125M/s/cpu)
uprobe-nop      ( 8 cpus):   10.355 ± 0.028M/s  (  1.294M/s/cpu)
uprobe-nop      (16 cpus):    7.615 ± 0.099M/s  (  0.476M/s/cpu)
uprobe-nop      (32 cpus):    4.430 ± 0.007M/s  (  0.138M/s/cpu)
uprobe-nop      (64 cpus):    6.887 ± 0.020M/s  (  0.108M/s/cpu)

uretprobe-nop   ( 1 cpus):    2.174 ± 0.001M/s  (  2.174M/s/cpu)
uretprobe-nop   ( 2 cpus):    2.853 ± 0.001M/s  (  1.426M/s/cpu)
uretprobe-nop   ( 4 cpus):    4.913 ± 0.002M/s  (  1.228M/s/cpu)
uretprobe-nop   ( 8 cpus):    5.883 ± 0.002M/s  (  0.735M/s/cpu)
uretprobe-nop   (16 cpus):    5.147 ± 0.001M/s  (  0.322M/s/cpu)
uretprobe-nop   (32 cpus):    3.738 ± 0.008M/s  (  0.117M/s/cpu)
uretprobe-nop   (64 cpus):    4.397 ± 0.002M/s  (  0.069M/s/cpu)

Peak throughput for uprobes increases from 8 mln/s to 10.3 mln/s
(+28%!), and for uretprobes from 5.3 mln/s to 5.8 mln/s (+11%), as we
have more work to do on uretprobes side.

Even single-thread (no contention) performance is slightly better: 3.276
mln/s to 3.396 mln/s (+3.5%) for uprobes, and 2.055 mln/s to 2.174 mln/s
(+5.8%) for uretprobes.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/events/uprobes.c | 37 +++++++++++++++----------------------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 8559ca365679..0480ad841942 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -42,8 +42,6 @@ static struct rb_root uprobes_tree = RB_ROOT;
 static DEFINE_RWLOCK(uprobes_treelock);	/* serialize rbtree access */
 static seqcount_rwlock_t uprobes_seqcount = SEQCNT_RWLOCK_ZERO(uprobes_seqcount, &uprobes_treelock);
 
-DEFINE_STATIC_SRCU(uprobes_srcu);
-
 #define UPROBES_HASH_SZ	13
 /* serialize uprobe->pending_list */
 static struct mutex uprobes_mmap_mutex[UPROBES_HASH_SZ];
@@ -652,7 +650,7 @@ static void put_uprobe(struct uprobe *uprobe)
 	delayed_uprobe_remove(uprobe, NULL);
 	mutex_unlock(&delayed_uprobe_lock);
 
-	call_srcu(&uprobes_srcu, &uprobe->rcu, uprobe_free_rcu);
+	call_rcu_tasks_trace(&uprobe->rcu, uprobe_free_rcu);
 }
 
 static __always_inline
@@ -707,7 +705,7 @@ static struct uprobe *find_uprobe_rcu(struct inode *inode, loff_t offset)
 	struct rb_node *node;
 	unsigned int seq;
 
-	lockdep_assert(srcu_read_lock_held(&uprobes_srcu));
+	lockdep_assert(rcu_read_lock_trace_held());
 
 	do {
 		seq = read_seqcount_begin(&uprobes_seqcount);
@@ -924,8 +922,7 @@ static bool filter_chain(struct uprobe *uprobe, struct mm_struct *mm)
 	bool ret = false;
 
 	down_read(&uprobe->consumer_rwsem);
-	list_for_each_entry_srcu(uc, &uprobe->consumers, cons_node,
-				 srcu_read_lock_held(&uprobes_srcu)) {
+	list_for_each_entry_rcu(uc, &uprobe->consumers, cons_node, rcu_read_lock_trace_held()) {
 		ret = consumer_filter(uc, mm);
 		if (ret)
 			break;
@@ -1148,7 +1145,7 @@ void uprobe_unregister_sync(void)
 	 * unlucky enough caller can free consumer's memory and cause
 	 * handler_chain() or handle_uretprobe_chain() to do an use-after-free.
 	 */
-	synchronize_srcu(&uprobes_srcu);
+	synchronize_rcu_tasks_trace();
 }
 EXPORT_SYMBOL_GPL(uprobe_unregister_sync);
 
@@ -1232,19 +1229,18 @@ EXPORT_SYMBOL_GPL(uprobe_register);
 int uprobe_apply(struct uprobe *uprobe, struct uprobe_consumer *uc, bool add)
 {
 	struct uprobe_consumer *con;
-	int ret = -ENOENT, srcu_idx;
+	int ret = -ENOENT;
 
 	down_write(&uprobe->register_rwsem);
 
-	srcu_idx = srcu_read_lock(&uprobes_srcu);
-	list_for_each_entry_srcu(con, &uprobe->consumers, cons_node,
-				 srcu_read_lock_held(&uprobes_srcu)) {
+	rcu_read_lock_trace();
+	list_for_each_entry_rcu(con, &uprobe->consumers, cons_node, rcu_read_lock_trace_held()) {
 		if (con == uc) {
 			ret = register_for_each_vma(uprobe, add ? uc : NULL);
 			break;
 		}
 	}
-	srcu_read_unlock(&uprobes_srcu, srcu_idx);
+	rcu_read_unlock_trace();
 
 	up_write(&uprobe->register_rwsem);
 
@@ -2114,8 +2110,7 @@ static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
 
 	current->utask->auprobe = &uprobe->arch;
 
-	list_for_each_entry_srcu(uc, &uprobe->consumers, cons_node,
-				 srcu_read_lock_held(&uprobes_srcu)) {
+	list_for_each_entry_rcu(uc, &uprobe->consumers, cons_node, rcu_read_lock_trace_held()) {
 		int rc = 0;
 
 		if (uc->handler) {
@@ -2153,15 +2148,13 @@ handle_uretprobe_chain(struct return_instance *ri, struct pt_regs *regs)
 {
 	struct uprobe *uprobe = ri->uprobe;
 	struct uprobe_consumer *uc;
-	int srcu_idx;
 
-	srcu_idx = srcu_read_lock(&uprobes_srcu);
-	list_for_each_entry_srcu(uc, &uprobe->consumers, cons_node,
-				 srcu_read_lock_held(&uprobes_srcu)) {
+	rcu_read_lock_trace();
+	list_for_each_entry_rcu(uc, &uprobe->consumers, cons_node, rcu_read_lock_trace_held()) {
 		if (uc->ret_handler)
 			uc->ret_handler(uc, ri->func, regs);
 	}
-	srcu_read_unlock(&uprobes_srcu, srcu_idx);
+	rcu_read_unlock_trace();
 }
 
 static struct return_instance *find_next_ret_chain(struct return_instance *ri)
@@ -2246,13 +2239,13 @@ static void handle_swbp(struct pt_regs *regs)
 {
 	struct uprobe *uprobe;
 	unsigned long bp_vaddr;
-	int is_swbp, srcu_idx;
+	int is_swbp;
 
 	bp_vaddr = uprobe_get_swbp_addr(regs);
 	if (bp_vaddr == uprobe_get_trampoline_vaddr())
 		return uprobe_handle_trampoline(regs);
 
-	srcu_idx = srcu_read_lock(&uprobes_srcu);
+	rcu_read_lock_trace();
 
 	uprobe = find_active_uprobe_rcu(bp_vaddr, &is_swbp);
 	if (!uprobe) {
@@ -2310,7 +2303,7 @@ static void handle_swbp(struct pt_regs *regs)
 
 out:
 	/* arch_uprobe_skip_sstep() succeeded, or restart if can't singlestep */
-	srcu_read_unlock(&uprobes_srcu, srcu_idx);
+	rcu_read_unlock_trace();
 }
 
 /*
-- 
2.43.5


