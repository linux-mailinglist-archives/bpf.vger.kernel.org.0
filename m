Return-Path: <bpf+bounces-36182-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF736943833
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 23:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB794285CCE
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 21:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F6D16EB76;
	Wed, 31 Jul 2024 21:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KpSCwLNN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AAE16EB5E;
	Wed, 31 Jul 2024 21:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722462207; cv=none; b=nDnH6QyI6oafQAH2CWjp5/BuU7RaxZCMsvtgx2KCzTB0THQLpG69JuxgRztBc2Tbft9I9qKVAeJ9ksPMMSYUyE0tXqlABnj7wSe2A1asFNDSsfMUDngH70fTh3wBiz5D3MuZvcLFvhuigE1WbmwJDA+zQp0f5e/X6k7pYWNtWt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722462207; c=relaxed/simple;
	bh=3Up2x3Nsu059ngkFWBfnfc1N6oPXYNPJasw54szZ3LA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sVRS8vqxl6pcEqe3KvW/gedXLg8IxKpyA5Oj+wD9648gXuRRCHQQVD9Wd45cdN7cvHbLIuU5IBW+UXKx7hhRvC4e8Eifxh8fDRRXxdQcyuopdqXZHT/nfPlHuAiRE7lgdJcy15GpMJN/piXCVwJaoAc/QQtETupx3VqLxFSF66c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KpSCwLNN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3242C116B1;
	Wed, 31 Jul 2024 21:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722462207;
	bh=3Up2x3Nsu059ngkFWBfnfc1N6oPXYNPJasw54szZ3LA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KpSCwLNNZ0CvRYwYHiEcmBcn8uMYIhjR3l1zqeq7eXDrWtL2NtpOg7ub0BO5tVqK2
	 qY3u74GVN/fOlNbBRcQ+C1IY00Ng0cFIvgitr1kS5PeQYtLuRpLuiQAYu/nWhvNayh
	 LCUBJQACUfeD6z5HbJc2oEZrR45hPnUqLcfggBmeiybCYyme3UKImL6N6nw4oM2RcS
	 noMXmC8ZiZh9pG7Z4kGo1A0cd9/5mJrtTGqVfxCHX6s+GQsloQy4FaWgpKqfa9/Mup
	 hZ1vErQQdcODQNCisZzoV7vrVtYeddIOsLuK1kJhXZsc7L653EdR+Zo8nNjVUtrKGG
	 ziLn6VgFekMhQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	peterz@infradead.org,
	oleg@redhat.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jolsa@kernel.org,
	paulmck@kernel.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH 8/8] uprobes: switch to RCU Tasks Trace flavor for better performance
Date: Wed, 31 Jul 2024 14:42:56 -0700
Message-ID: <20240731214256.3588718-9-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240731214256.3588718-1-andrii@kernel.org>
References: <20240731214256.3588718-1-andrii@kernel.org>
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
 kernel/events/uprobes.c | 40 +++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index d03962cc96de..ef915f87d27f 100644
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
@@ -647,7 +645,7 @@ static void put_uprobe(struct uprobe *uprobe)
 	delayed_uprobe_remove(uprobe, NULL);
 	mutex_unlock(&delayed_uprobe_lock);
 
-	call_srcu(&uprobes_srcu, &uprobe->rcu, uprobe_free_rcu);
+	call_rcu_tasks_trace(&uprobe->rcu, uprobe_free_rcu);
 }
 
 static __always_inline
@@ -702,7 +700,7 @@ static struct uprobe *find_uprobe_rcu(struct inode *inode, loff_t offset)
 	struct rb_node *node;
 	unsigned int seq;
 
-	lockdep_assert(srcu_read_lock_held(&uprobes_srcu));
+	lockdep_assert(rcu_read_lock_trace_held());
 
 	do {
 		seq = read_seqcount_begin(&uprobes_seqcount);
@@ -919,8 +917,7 @@ static bool filter_chain(struct uprobe *uprobe, struct mm_struct *mm)
 	bool ret = false;
 
 	down_read(&uprobe->consumer_rwsem);
-	list_for_each_entry_srcu(uc, &uprobe->consumers, cons_node,
-				 srcu_read_lock_held(&uprobes_srcu)) {
+	list_for_each_entry_rcu(uc, &uprobe->consumers, cons_node, rcu_read_lock_trace_held()) {
 		ret = consumer_filter(uc, mm);
 		if (ret)
 			break;
@@ -1132,7 +1129,7 @@ EXPORT_SYMBOL_GPL(uprobe_unregister_nosync);
 
 void uprobe_unregister_sync(void)
 {
-	synchronize_srcu(&uprobes_srcu);
+	synchronize_rcu_tasks_trace();
 }
 EXPORT_SYMBOL_GPL(uprobe_unregister_sync);
 
@@ -1216,19 +1213,18 @@ EXPORT_SYMBOL_GPL(uprobe_register);
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
 
@@ -2105,8 +2101,7 @@ static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
 	bool need_prep = false; /* prepare return uprobe, when needed */
 	bool has_consumers = false;
 
-	list_for_each_entry_srcu(uc, &uprobe->consumers, cons_node,
-				 srcu_read_lock_held(&uprobes_srcu)) {
+	list_for_each_entry_rcu(uc, &uprobe->consumers, cons_node, rcu_read_lock_trace_held()) {
 		int rc = 0;
 
 		if (uc->handler) {
@@ -2143,15 +2138,14 @@ handle_uretprobe_chain(struct return_instance *ri, struct pt_regs *regs)
 {
 	struct uprobe *uprobe = ri->uprobe;
 	struct uprobe_consumer *uc;
-	int srcu_idx;
 
-	srcu_idx = srcu_read_lock(&uprobes_srcu);
-	list_for_each_entry_srcu(uc, &uprobe->consumers, cons_node,
-				 srcu_read_lock_held(&uprobes_srcu)) {
+	rcu_read_lock_trace();
+	list_for_each_entry_rcu(uc, &uprobe->consumers, cons_node,
+				 rcu_read_lock_trace_held()) {
 		if (uc->ret_handler)
 			uc->ret_handler(uc, ri->func, regs);
 	}
-	srcu_read_unlock(&uprobes_srcu, srcu_idx);
+	rcu_read_unlock_trace();
 }
 
 static struct return_instance *find_next_ret_chain(struct return_instance *ri)
@@ -2236,13 +2230,13 @@ static void handle_swbp(struct pt_regs *regs)
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
@@ -2260,7 +2254,7 @@ static void handle_swbp(struct pt_regs *regs)
 			 */
 			instruction_pointer_set(regs, bp_vaddr);
 		}
-		srcu_read_unlock(&uprobes_srcu, srcu_idx);
+		rcu_read_unlock_trace();
 		return;
 	}
 
@@ -2301,7 +2295,7 @@ static void handle_swbp(struct pt_regs *regs)
 
 out:
 	/* arch_uprobe_skip_sstep() succeeded, or restart if can't singlestep */
-	srcu_read_unlock(&uprobes_srcu, srcu_idx);
+	rcu_read_unlock_trace();
 }
 
 /*
-- 
2.43.0


