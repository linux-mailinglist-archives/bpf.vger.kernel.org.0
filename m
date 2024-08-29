Return-Path: <bpf+bounces-38444-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0E6964DD3
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 20:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F2EA1F21CF3
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 18:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33C91BA28D;
	Thu, 29 Aug 2024 18:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1RTkwN6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7BF1BA282;
	Thu, 29 Aug 2024 18:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724956680; cv=none; b=jCuayBVGNgT+flZ241GBLsgpuSGwRJj9hfTF8cg64/30YKPB96heDtmWm5Z5koL2HmickgWX+2lEc+fPg7UsNtxhP0lfGdpf8a2MQBOHN5NsRnrXgVkg72iXQ4BvOEQQMYoNMBeRJwWaflKC7yXlpHmHLn4W7gTgalda6yflIks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724956680; c=relaxed/simple;
	bh=F7UsqMhK02VGjTw6o3bhys9hh68g9/OujJofPiFpMS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BmC9FWou/NH1yKAOAqCp3ULWt+x/ii0z3HBOF5vZc+YPdgCZLh0HXiwPbGoG3HF6dqtXH3QEjGMjOiBDUPaeX7kGnp5l6NAFV4J9Bfr6UNX3AuJtFK3vsIHKZgnpWnuzmntJPw6DM1qRLeNb7L5yHvOom9qPqw3Z2B3VRAR5odM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W1RTkwN6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB9FC4CEC7;
	Thu, 29 Aug 2024 18:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724956679;
	bh=F7UsqMhK02VGjTw6o3bhys9hh68g9/OujJofPiFpMS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W1RTkwN6Rbj5HoYk9B2TAHsY06cg4q4HSn9uT472zc6E48u/a4M15I9RyHUKAVCnb
	 fFbx0cHQm+lyb/Yz4zeCGwqYzGijtLJkzX9o3qB9oqn4tDYfKwypX+yKqhjVUlorO2
	 EnT+sqPdXaXGyiKnvq2PDMpo5/HAEgc67hCg1LE/S5qREVOunnxZ2spYN6PVBPJGI8
	 BEiFWZJ9tpBuIWCq0ffuUGVAu4laXHbmHtuv9Pg7SN2yAMWvBfxZCDuRT1HrCx2YzB
	 6qwZ0Fu8zJ8qSGQtcAOVcFbX5gzAUiXZMsmQ9uyrI5u8z7a5iSxf7RKfB7G+o8Patn
	 lq0HQFjJxo9zA==
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
Subject: [PATCH v4 4/8] uprobes: travers uprobe's consumer list locklessly under SRCU protection
Date: Thu, 29 Aug 2024 11:37:37 -0700
Message-ID: <20240829183741.3331213-5-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240829183741.3331213-1-andrii@kernel.org>
References: <20240829183741.3331213-1-andrii@kernel.org>
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
 kernel/events/uprobes.c | 104 +++++++++++++++++++++++-----------------
 2 files changed, 62 insertions(+), 44 deletions(-)

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


