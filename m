Return-Path: <bpf+bounces-36993-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFF794FCB1
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 06:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28F0E282F50
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 04:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C2239FDD;
	Tue, 13 Aug 2024 04:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QET3Aid1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0504A39AFD;
	Tue, 13 Aug 2024 04:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723523394; cv=none; b=Puj5JhW4FpUiY2j4y+ZepVpJHdeVRPk8jYO3ABSFYFHDMOlAhlMqdcODUE1AzPzb6hjv/+mFERWjuOuMoZSfc6h2bD5PtIpMw9wMiBT1ldDBjgZjJb2E7e0m+EAmdOjQ3l+BGTFHQquzLlxubUQYKn1cPQ1vV8AZWGbeEgo+OxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723523394; c=relaxed/simple;
	bh=r8TSvo2hmymFmaW8DnSgb8eLExbQzyutP7wrmtQjB9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e4IHDvJb+wKBljo0/20oJzwKbP3DJXj8olxQASRXjRzeLwr4Le7CEahm71/puhP6t133RSLLmYxkZY4RI6bXacbcOCI7IHpjaU7q7yvojnjtuhfV1AzEk/N/w5rAxsOB/8LdXs2wPwc/astGgfugTPlriSAWrNvc1rTrF7Rzvp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QET3Aid1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C265C4AF09;
	Tue, 13 Aug 2024 04:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723523393;
	bh=r8TSvo2hmymFmaW8DnSgb8eLExbQzyutP7wrmtQjB9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QET3Aid1p3p6zpbI/vyekDIH/TA9WuthMBXBmzg7W4mSZtM8Vmh4lkfnzmfJQ5NND
	 gntDwNcRBBdIjXNVMkTJe+A3FxGjgBYoRHrEh+9h3qL9x9jneOpnkXPJtc9iOjFZPD
	 j0G/XjhV5+ut0qELpIr8c1iHbFHeR0KW2/n3j1d63eQyFq3vTT9UTXb3BRIvg8FeAU
	 k+BspMbFsMmt4gX1M5cr0Y9QP1tpXhj6KoJgVQoXRK4QIxcJ7ge9QGsqA+sRVBDtrk
	 s5cwCL0chEsEh9f0Q1mlx7mAS8E3EjWr7cSMTPD+l6fPwueUKKMjmgBFCnG8oW1dWC
	 Kieji6bsnHBDw==
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
Subject: [PATCH v3 04/13] uprobes: travers uprobe's consumer list locklessly under SRCU protection
Date: Mon, 12 Aug 2024 21:29:08 -0700
Message-ID: <20240813042917.506057-5-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240813042917.506057-1-andrii@kernel.org>
References: <20240813042917.506057-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

uprobe->register_rwsem is one of a few big bottlenecks to scalability of
uprobes, so we need to get rid of it to improve uprobe performance and
multi-CPU scalability.

First, we turn uprobe's consumer list to a typical doubly-linked list
and utilize existing RCU-aware helpers for traversing such lists, as
well as adding and removing elements from it.

For entry uprobes we already have SRCU protection active since before
uprobe lookup. For uretprobe we keep refcount, guaranteeing that uprobe
won't go away from under us, but we add SRCU protection around consumer
list traversal.

Lastly, to keep handler_chain()'s UPROBE_HANDLER_REMOVE handling simple,
we remember whether any removal was requested during handler calls, but
then we double-check the decision under a proper register_rwsem using
consumers' filter callbacks. Handler removal is very rare, so this extra
lock won't hurt performance, overall, but we also avoid the need for any
extra protection (e.g., seqcount locks).

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/uprobes.h |   2 +-
 kernel/events/uprobes.c | 111 ++++++++++++++++++++++------------------
 2 files changed, 61 insertions(+), 52 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 9cf0dce62e4c..29c935b0d504 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -35,7 +35,7 @@ struct uprobe_consumer {
 				struct pt_regs *regs);
 	bool (*filter)(struct uprobe_consumer *self, struct mm_struct *mm);
 
-	struct uprobe_consumer *next;
+	struct list_head cons_node;
 };
 
 #ifdef CONFIG_UPROBES
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 8bdcdc6901b2..7de1aaf50394 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -59,7 +59,7 @@ struct uprobe {
 	struct rw_semaphore	register_rwsem;
 	struct rw_semaphore	consumer_rwsem;
 	struct list_head	pending_list;
-	struct uprobe_consumer	*consumers;
+	struct list_head	consumers;
 	struct inode		*inode;		/* Also hold a ref to inode */
 	struct rcu_head		rcu;
 	loff_t			offset;
@@ -783,6 +783,7 @@ static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset,
 	uprobe->inode = inode;
 	uprobe->offset = offset;
 	uprobe->ref_ctr_offset = ref_ctr_offset;
+	INIT_LIST_HEAD(&uprobe->consumers);
 	init_rwsem(&uprobe->register_rwsem);
 	init_rwsem(&uprobe->consumer_rwsem);
 	RB_CLEAR_NODE(&uprobe->rb_node);
@@ -808,34 +809,10 @@ static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset,
 static void consumer_add(struct uprobe *uprobe, struct uprobe_consumer *uc)
 {
 	down_write(&uprobe->consumer_rwsem);
-	uc->next = uprobe->consumers;
-	uprobe->consumers = uc;
+	list_add_rcu(&uc->cons_node, &uprobe->consumers);
 	up_write(&uprobe->consumer_rwsem);
 }
 
-/*
- * For uprobe @uprobe, delete the consumer @uc.
- * Return true if the @uc is deleted successfully
- * or return false.
- */
-static bool consumer_del(struct uprobe *uprobe, struct uprobe_consumer *uc)
-{
-	struct uprobe_consumer **con;
-	bool ret = false;
-
-	down_write(&uprobe->consumer_rwsem);
-	for (con = &uprobe->consumers; *con; con = &(*con)->next) {
-		if (*con == uc) {
-			*con = uc->next;
-			ret = true;
-			break;
-		}
-	}
-	up_write(&uprobe->consumer_rwsem);
-
-	return ret;
-}
-
 static int __copy_insn(struct address_space *mapping, struct file *filp,
 			void *insn, int nbytes, loff_t offset)
 {
@@ -929,7 +906,8 @@ static bool filter_chain(struct uprobe *uprobe, struct mm_struct *mm)
 	bool ret = false;
 
 	down_read(&uprobe->consumer_rwsem);
-	for (uc = uprobe->consumers; uc; uc = uc->next) {
+	list_for_each_entry_srcu(uc, &uprobe->consumers, cons_node,
+				 srcu_read_lock_held(&uprobes_srcu)) {
 		ret = consumer_filter(uc, mm);
 		if (ret)
 			break;
@@ -1125,18 +1103,31 @@ void uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
 	int err;
 
 	down_write(&uprobe->register_rwsem);
-	if (WARN_ON(!consumer_del(uprobe, uc))) {
-		err = -ENOENT;
-	} else {
-		err = register_for_each_vma(uprobe, NULL);
-		/* TODO : cant unregister? schedule a worker thread */
-		if (unlikely(err))
-			uprobe_warn(current, "unregister, leaking uprobe");
-	}
+
+	list_del_rcu(&uc->cons_node);
+	err = register_for_each_vma(uprobe, NULL);
+
 	up_write(&uprobe->register_rwsem);
 
-	if (!err)
-		put_uprobe(uprobe);
+	/* TODO : cant unregister? schedule a worker thread */
+	if (unlikely(err)) {
+		uprobe_warn(current, "unregister, leaking uprobe");
+		goto out_sync;
+	}
+
+	put_uprobe(uprobe);
+
+out_sync:
+	/*
+	 * Now that handler_chain() and handle_uretprobe_chain() iterate over
+	 * uprobe->consumers list under RCU protection without holding
+	 * uprobe->register_rwsem, we need to wait for RCU grace period to
+	 * make sure that we can't call into just unregistered
+	 * uprobe_consumer's callbacks anymore. If we don't do that, fast and
+	 * unlucky enough caller can free consumer's memory and cause
+	 * handler_chain() or handle_uretprobe_chain() to do an use-after-free.
+	 */
+	synchronize_srcu(&uprobes_srcu);
 }
 EXPORT_SYMBOL_GPL(uprobe_unregister);
 
@@ -1214,13 +1205,20 @@ EXPORT_SYMBOL_GPL(uprobe_register);
 int uprobe_apply(struct uprobe *uprobe, struct uprobe_consumer *uc, bool add)
 {
 	struct uprobe_consumer *con;
-	int ret = -ENOENT;
+	int ret = -ENOENT, srcu_idx;
 
 	down_write(&uprobe->register_rwsem);
-	for (con = uprobe->consumers; con && con != uc ; con = con->next)
-		;
-	if (con)
-		ret = register_for_each_vma(uprobe, add ? uc : NULL);
+
+	srcu_idx = srcu_read_lock(&uprobes_srcu);
+	list_for_each_entry_srcu(con, &uprobe->consumers, cons_node,
+				 srcu_read_lock_held(&uprobes_srcu)) {
+		if (con == uc) {
+			ret = register_for_each_vma(uprobe, add ? uc : NULL);
+			break;
+		}
+	}
+	srcu_read_unlock(&uprobes_srcu, srcu_idx);
+
 	up_write(&uprobe->register_rwsem);
 
 	return ret;
@@ -2085,10 +2083,12 @@ static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
 	struct uprobe_consumer *uc;
 	int remove = UPROBE_HANDLER_REMOVE;
 	bool need_prep = false; /* prepare return uprobe, when needed */
+	bool has_consumers = false;
 
-	down_read(&uprobe->register_rwsem);
 	current->utask->auprobe = &uprobe->arch;
-	for (uc = uprobe->consumers; uc; uc = uc->next) {
+
+	list_for_each_entry_srcu(uc, &uprobe->consumers, cons_node,
+				 srcu_read_lock_held(&uprobes_srcu)) {
 		int rc = 0;
 
 		if (uc->handler) {
@@ -2101,17 +2101,24 @@ static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
 			need_prep = true;
 
 		remove &= rc;
+		has_consumers = true;
 	}
 	current->utask->auprobe = NULL;
 
 	if (need_prep && !remove)
 		prepare_uretprobe(uprobe, regs); /* put bp at return */
 
-	if (remove && uprobe->consumers) {
-		WARN_ON(!uprobe_is_active(uprobe));
-		unapply_uprobe(uprobe, current->mm);
+	if (remove && has_consumers) {
+		down_read(&uprobe->register_rwsem);
+
+		/* re-check that removal is still required, this time under lock */
+		if (!filter_chain(uprobe, current->mm)) {
+			WARN_ON(!uprobe_is_active(uprobe));
+			unapply_uprobe(uprobe, current->mm);
+		}
+
+		up_read(&uprobe->register_rwsem);
 	}
-	up_read(&uprobe->register_rwsem);
 }
 
 static void
@@ -2119,13 +2126,15 @@ handle_uretprobe_chain(struct return_instance *ri, struct pt_regs *regs)
 {
 	struct uprobe *uprobe = ri->uprobe;
 	struct uprobe_consumer *uc;
+	int srcu_idx;
 
-	down_read(&uprobe->register_rwsem);
-	for (uc = uprobe->consumers; uc; uc = uc->next) {
+	srcu_idx = srcu_read_lock(&uprobes_srcu);
+	list_for_each_entry_srcu(uc, &uprobe->consumers, cons_node,
+				 srcu_read_lock_held(&uprobes_srcu)) {
 		if (uc->ret_handler)
 			uc->ret_handler(uc, ri->func, regs);
 	}
-	up_read(&uprobe->register_rwsem);
+	srcu_read_unlock(&uprobes_srcu, srcu_idx);
 }
 
 static struct return_instance *find_next_ret_chain(struct return_instance *ri)
-- 
2.43.5


