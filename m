Return-Path: <bpf+bounces-38806-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4C696A5C0
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 19:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D76A287238
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 17:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192BA193438;
	Tue,  3 Sep 2024 17:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dyMZEzMe"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837461917D0;
	Tue,  3 Sep 2024 17:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725385581; cv=none; b=oS+uPLs+DCfhasqydfEvEAdFbQu99eepoLlxN07jpFIfHwenJuI9s/J36h2hVofBkXVm0X7b2Z+Os0v3rRv4en6Oyh8qqGUKwttEqNcNyAp3huff48niZJOtpCsNqX+bdmsN1F1PGegdCgd8muBndVc9r86VUUyivOygUbfv9KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725385581; c=relaxed/simple;
	bh=Od2hK7f+p9OrwoA3Etz1Ku5j7OT1LnL7qqTaMaUPv3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uEFaCgiavJBAADClCeR73bmAAJTvlZqPghiRlsTlOzOJmlzBkWDQ8gUWnc2hUyTgBTj7jcaow+FrIjEDw1PpHLYAWcsiHIpGXU4Mg3oYyLn6IJhS7Y9kbg0jH0J9trrDfTgbOD1eKe/taeokEMTYtfocMP5zQbcggQXSOnfcpsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dyMZEzMe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E96DCC4CEC6;
	Tue,  3 Sep 2024 17:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725385581;
	bh=Od2hK7f+p9OrwoA3Etz1Ku5j7OT1LnL7qqTaMaUPv3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dyMZEzMek0Ld2KoDhCgr9p7DhtmlN1ri51XVG/IozrLDGoLIQYhnEjcivG9aWHQF6
	 NN0wRc1HbxeLkoueLBgPSZYFhgiz5Z9bV6GN3vodOwHjAhh6Lpcv8mSxkoLv66ywYg
	 YfYle/qNJBPZ/wiABePhe8WWeXsZGMdX9szPW1u6oZw06MFkf4bZEb/580LlmtZURp
	 fkUdYci5Bvf+2jnoR2FbpL8KtMSYjWM5MagMwYc0ZrJg5dMYY9ZcMU0z91nNc6kjjw
	 ZP4LAKWEBiAa2B5bbfQd8hLZNt2losVQ/ySslU/QmGtKC1S2MIuHVksmmViBRynSLt
	 w/7/QfGnSlh6g==
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
Subject: [PATCH v5 4/8] uprobes: travers uprobe's consumer list locklessly under SRCU protection
Date: Tue,  3 Sep 2024 10:45:59 -0700
Message-ID: <20240903174603.3554182-5-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240903174603.3554182-1-andrii@kernel.org>
References: <20240903174603.3554182-1-andrii@kernel.org>
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

Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/uprobes.h |  10 +++-
 kernel/events/uprobes.c | 104 +++++++++++++++++++++++-----------------
 2 files changed, 70 insertions(+), 44 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 9cf0dce62e4c..2785d1bedb74 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -29,13 +29,21 @@ struct page;
 #define MAX_URETPROBE_DEPTH		64
 
 struct uprobe_consumer {
+	/*
+	 * handler() can return UPROBE_HANDLER_REMOVE to signal the need to
+	 * unregister uprobe for current process. If UPROBE_HANDLER_REMOVE is
+	 * returned, filter() callback has to be implemented as well and it
+	 * should return false to "confirm" the decision to uninstall uprobe
+	 * for the current process. If filter() is omitted or returns true,
+	 * UPROBE_HANDLER_REMOVE is effectively ignored.
+	 */
 	int (*handler)(struct uprobe_consumer *self, struct pt_regs *regs);
 	int (*ret_handler)(struct uprobe_consumer *self,
 				unsigned long func,
 				struct pt_regs *regs);
 	bool (*filter)(struct uprobe_consumer *self, struct mm_struct *mm);
 
-	struct uprobe_consumer *next;
+	struct list_head cons_node;
 };
 
 #ifdef CONFIG_UPROBES
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 8bdcdc6901b2..97e58d160647 100644
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
@@ -808,32 +809,19 @@ static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset,
 static void consumer_add(struct uprobe *uprobe, struct uprobe_consumer *uc)
 {
 	down_write(&uprobe->consumer_rwsem);
-	uc->next = uprobe->consumers;
-	uprobe->consumers = uc;
+	list_add_rcu(&uc->cons_node, &uprobe->consumers);
 	up_write(&uprobe->consumer_rwsem);
 }
 
 /*
  * For uprobe @uprobe, delete the consumer @uc.
- * Return true if the @uc is deleted successfully
- * or return false.
+ * Should never be called with consumer that's not part of @uprobe->consumers.
  */
-static bool consumer_del(struct uprobe *uprobe, struct uprobe_consumer *uc)
+static void consumer_del(struct uprobe *uprobe, struct uprobe_consumer *uc)
 {
-	struct uprobe_consumer **con;
-	bool ret = false;
-
 	down_write(&uprobe->consumer_rwsem);
-	for (con = &uprobe->consumers; *con; con = &(*con)->next) {
-		if (*con == uc) {
-			*con = uc->next;
-			ret = true;
-			break;
-		}
-	}
+	list_del_rcu(&uc->cons_node);
 	up_write(&uprobe->consumer_rwsem);
-
-	return ret;
 }
 
 static int __copy_insn(struct address_space *mapping, struct file *filp,
@@ -929,7 +917,8 @@ static bool filter_chain(struct uprobe *uprobe, struct mm_struct *mm)
 	bool ret = false;
 
 	down_read(&uprobe->consumer_rwsem);
-	for (uc = uprobe->consumers; uc; uc = uc->next) {
+	list_for_each_entry_srcu(uc, &uprobe->consumers, cons_node,
+				 srcu_read_lock_held(&uprobes_srcu)) {
 		ret = consumer_filter(uc, mm);
 		if (ret)
 			break;
@@ -1125,18 +1114,29 @@ void uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
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
+	consumer_del(uprobe, uc);
+	err = register_for_each_vma(uprobe, NULL);
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
 
@@ -1214,13 +1214,20 @@ EXPORT_SYMBOL_GPL(uprobe_register);
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
@@ -2085,10 +2092,12 @@ static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
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
@@ -2101,17 +2110,24 @@ static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
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
@@ -2119,13 +2135,15 @@ handle_uretprobe_chain(struct return_instance *ri, struct pt_regs *regs)
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


