Return-Path: <bpf+bounces-36651-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E492D94B41F
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 02:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EF95283373
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 00:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3D2208C4;
	Thu,  8 Aug 2024 00:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lze4Azdl"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F401CD25;
	Thu,  8 Aug 2024 00:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723076495; cv=none; b=ciraE//7FKI9ifAQQ/u2pCoZ70xoZ18QOIFKv0bgDv+ChfpxvZrQTP61nSRN5TvPpkXgwuQ8Li00xua+Gh+Qi/dA8JuQwK9jB+D24P1Ah/GAHKp4vkpiuBvOmCoFhB0aGVsSQ+TUvNWMaj5biphsXz2vHltwZFHCQV+8RWzmvCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723076495; c=relaxed/simple;
	bh=25rzVBFFGVWhKMCA/An5seQDqlhaiCoNKLcoSqhHXGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ipaJreTR4SipS7R7RLB1tk6Im2fIkVxFLna6aTFA8DGiT13c7ANFT2006NL78wb28LDOZB71vHu4iU1mdMfUFMUh/wuCT1RyxTh+FUesgWWBShjoJXmEybpGe7D3ZHPDgwepePbS28zCNUdpUlGdYNSlJtN+1pEvxsNtElGhxcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lze4Azdl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D082C32781;
	Thu,  8 Aug 2024 00:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723076494;
	bh=25rzVBFFGVWhKMCA/An5seQDqlhaiCoNKLcoSqhHXGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lze4Azdl1G5etotJHRPNWP7nsEoi6txR3CTY2Od9fgPz+ERWoODma5jE0tqGg7//Y
	 yry0ZoGDNZvoXJSzBMmV90if6d3zb9NlxdlSIuWIvN1R5KHSBb2BIOfLo8V6ILjKV/
	 4Bg7s+PQGkyPtlXlJCUINEaWfyWUs6/2sMCA648Kg12jIr86zGXAUdq9gpvPFIbg9g
	 GnQxBnJf/MP6wFWUzFwOtMKcPApkfzfJX7347Zn57P55nncyMMPFVQ2EIt8QStuTOd
	 U8lHZwih1iry1mrQfJkG5fotNq4LC5kV7sEBTqO+WJgphf9sUnVSi7FhLzv743zIHY
	 T6+1vTfnWTfKw==
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
Subject: [PATCH v2 4/6] uprobes: travers uprobe's consumer list locklessly under SRCU protection
Date: Wed,  7 Aug 2024 17:21:16 -0700
Message-ID: <20240808002118.918105-5-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240808002118.918105-1-andrii@kernel.org>
References: <20240808002118.918105-1-andrii@kernel.org>
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
 kernel/events/uprobes.c | 110 +++++++++++++++++++++-------------------
 2 files changed, 60 insertions(+), 52 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 63ae2ade3487..f67f8d98c3c6 100644
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
index 9b31235bc177..5bddd20b7053 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -62,7 +62,7 @@ struct uprobe {
 	struct rw_semaphore	register_rwsem;
 	struct rw_semaphore	consumer_rwsem;
 	struct list_head	pending_list;
-	struct uprobe_consumer	*consumers;
+	struct list_head	consumers;
 	struct inode		*inode;		/* Also hold a ref to inode */
 	loff_t			offset;
 	loff_t			ref_ctr_offset;
@@ -785,6 +785,7 @@ static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset,
 	uprobe->inode = inode;
 	uprobe->offset = offset;
 	uprobe->ref_ctr_offset = ref_ctr_offset;
+	INIT_LIST_HEAD(&uprobe->consumers);
 	init_rwsem(&uprobe->register_rwsem);
 	init_rwsem(&uprobe->consumer_rwsem);
 	RB_CLEAR_NODE(&uprobe->rb_node);
@@ -810,34 +811,10 @@ static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset,
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
@@ -931,7 +908,8 @@ static bool filter_chain(struct uprobe *uprobe, struct mm_struct *mm)
 	bool ret = false;
 
 	down_read(&uprobe->consumer_rwsem);
-	for (uc = uprobe->consumers; uc; uc = uc->next) {
+	list_for_each_entry_srcu(uc, &uprobe->consumers, cons_node,
+				 srcu_read_lock_held(&uprobes_srcu)) {
 		ret = consumer_filter(uc, mm);
 		if (ret)
 			break;
@@ -1127,18 +1105,30 @@ void uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
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
+		return;
+	}
+
+	put_uprobe(uprobe);
+
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
 
@@ -1216,13 +1206,20 @@ EXPORT_SYMBOL_GPL(uprobe_register);
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
@@ -2088,10 +2085,12 @@ static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
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
@@ -2104,17 +2103,24 @@ static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
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
@@ -2122,13 +2128,15 @@ handle_uretprobe_chain(struct return_instance *ri, struct pt_regs *regs)
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


