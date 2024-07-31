Return-Path: <bpf+bounces-36179-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D3D94382C
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 23:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68132285C9B
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 21:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2F616DC11;
	Wed, 31 Jul 2024 21:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BINXIkyA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E17016CD39;
	Wed, 31 Jul 2024 21:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722462197; cv=none; b=sbiCN1RkYrNU3mARdOyMjTHo8S3LqeN8Myc8MzJTMST3FjePtwHsbqDg9nkh7PSakK1IDuqzmIPZuuKqYxiJld6QV481BNblpgYVFAhLjDbapvYSL3E8e9tNI0QeB7isGRRfNXld2gkxKH00F7aL54UOxNVMg8VGgq1CQQo/Svk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722462197; c=relaxed/simple;
	bh=oGWle7bmT095reHuNgun1nf/usZBPegKP5bQjDz7AHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sLe19v1wqla7u0u+Qbqci7maWjNkctTZDg3XmIej1IZDedEdqUlbKrmet+x02X+UQ2tDtjrJHFlOECxJ2AzOhbZkBc2grVTUfl+1MsOHWfMkxE3gZxghSOskaca69oIIrkhw9gX+8S1qaMbgBaVBJWXVr75WtGMQ+BcGeXUGDw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BINXIkyA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9D31C116B1;
	Wed, 31 Jul 2024 21:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722462197;
	bh=oGWle7bmT095reHuNgun1nf/usZBPegKP5bQjDz7AHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BINXIkyAXsJHqtNGIJ05nx8VoZQ+drdeHGVHf9MS87OzuJA8jne1T/jMfLPgTkXu/
	 TU7kDrYMQzPnUZY4jN8rxZN/tKJg6FULpl1KMtZLFabBlTY/PORxzC9PB5wFMOcw+M
	 rEvkvhIdpa8vKtFwTPkhInHUuFLouZxFGf0VQsL3ZAP6VCIoAANN64pzhZTDUWCT2H
	 1JlrYtCn4GM4zq3NqPSQOhctKu+sA1byQ2CDmB2dL2iGieOYCoYzNIjOiIWxn8ctkS
	 /NzM/rnJ37VBsv4NKKtqWNSVGKY4e+kakFuyGZGIQ0KP+BlCItgDfqqEYBi1m9I+Cd
	 Zs3z6fqYLpOGg==
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
Subject: [PATCH 5/8] uprobes: travers uprobe's consumer list locklessly under SRCU protection
Date: Wed, 31 Jul 2024 14:42:53 -0700
Message-ID: <20240731214256.3588718-6-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240731214256.3588718-1-andrii@kernel.org>
References: <20240731214256.3588718-1-andrii@kernel.org>
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
 include/linux/uprobes.h |  2 +-
 kernel/events/uprobes.c | 97 ++++++++++++++++++++---------------------
 2 files changed, 48 insertions(+), 51 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 8d5bbad2048c..a1686c1ebcb6 100644
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
index 71a8886608b1..3b42fd355256 100644
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
@@ -778,6 +778,7 @@ static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset,
 	uprobe->inode = inode;
 	uprobe->offset = offset;
 	uprobe->ref_ctr_offset = ref_ctr_offset;
+	INIT_LIST_HEAD(&uprobe->consumers);
 	init_rwsem(&uprobe->register_rwsem);
 	init_rwsem(&uprobe->consumer_rwsem);
 	RB_CLEAR_NODE(&uprobe->rb_node);
@@ -803,34 +804,10 @@ static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset,
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
@@ -924,7 +901,8 @@ static bool filter_chain(struct uprobe *uprobe, struct mm_struct *mm)
 	bool ret = false;
 
 	down_read(&uprobe->consumer_rwsem);
-	for (uc = uprobe->consumers; uc; uc = uc->next) {
+	list_for_each_entry_srcu(uc, &uprobe->consumers, cons_node,
+				 srcu_read_lock_held(&uprobes_srcu)) {
 		ret = consumer_filter(uc, mm);
 		if (ret)
 			break;
@@ -1120,17 +1098,19 @@ void uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
 	int err;
 
 	down_write(&uprobe->register_rwsem);
-	if (WARN_ON(!consumer_del(uprobe, uc))) {
-		err = -ENOENT;
-	} else {
-		err = register_for_each_vma(uprobe, NULL);
-		/* TODO : cant unregister? schedule a worker thread */
-		WARN(err, "leaking uprobe due to failed unregistration");
-	}
+
+	list_del_rcu(&uc->cons_node);
+	err = register_for_each_vma(uprobe, NULL);
+
 	up_write(&uprobe->register_rwsem);
 
-	if (!err)
-		put_uprobe(uprobe);
+	/* TODO : cant unregister? schedule a worker thread */
+	if (WARN(err, "leaking uprobe due to failed unregistration"))
+		return;
+
+	put_uprobe(uprobe);
+
+	synchronize_srcu(&uprobes_srcu);
 }
 EXPORT_SYMBOL_GPL(uprobe_unregister);
 
@@ -1208,13 +1188,20 @@ EXPORT_SYMBOL_GPL(uprobe_register);
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
@@ -2088,9 +2075,10 @@ static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
 	struct uprobe_consumer *uc;
 	int remove = UPROBE_HANDLER_REMOVE;
 	bool need_prep = false; /* prepare return uprobe, when needed */
+	bool has_consumers = false;
 
-	down_read(&uprobe->register_rwsem);
-	for (uc = uprobe->consumers; uc; uc = uc->next) {
+	list_for_each_entry_srcu(uc, &uprobe->consumers, cons_node,
+				 srcu_read_lock_held(&uprobes_srcu)) {
 		int rc = 0;
 
 		if (uc->handler) {
@@ -2103,16 +2091,23 @@ static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
 			need_prep = true;
 
 		remove &= rc;
+		has_consumers = true;
 	}
 
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
@@ -2120,13 +2115,15 @@ handle_uretprobe_chain(struct return_instance *ri, struct pt_regs *regs)
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
2.43.0


