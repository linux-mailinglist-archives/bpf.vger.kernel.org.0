Return-Path: <bpf+bounces-33546-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C4691EAE4
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 00:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBD8A1F22720
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 22:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D73A171E4F;
	Mon,  1 Jul 2024 22:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="esWxtTJH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E489E171079;
	Mon,  1 Jul 2024 22:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719873599; cv=none; b=h7sFj7SQrejzKwHXw74qZghJ6vkh8uCcesCug8fc/I+qQXvMXNoR/hkaxsx2LrUBiEydy1uY3T//TxOJNN/vO4gmTGFjMiEK7wOqzp/F74hnsw8Tui3ucGAl9nix893/M2ekagLxO4uu3bP1cq+sv2WE4Cq/zRqLER1pqXkYrrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719873599; c=relaxed/simple;
	bh=+2+gITtXkEAXg7My0n7+SUTY0w3SFHja5M39f7EvZVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wek5m0OnY4xjLmbUDLvoVKxx2BrHuGtPevDywRieyy6PnuQeV29xz4HnJWO3nqG7Zsdl+5ZsNYAA1jRHXn9XM6DXHZapn358M9hcAlce7PTdU0TWjgsUXYXByY5ZO+flyMk5xl0sx7GMy2I5PQvAIWVbvzmGGZ4so8eBaeb9E0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=esWxtTJH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96673C116B1;
	Mon,  1 Jul 2024 22:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719873598;
	bh=+2+gITtXkEAXg7My0n7+SUTY0w3SFHja5M39f7EvZVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=esWxtTJH1Roj4NkN41i+RxVdXE4gH72XXsYkTDw6BcZu5MIYS+JMooT40S6bi/yNZ
	 dtgXotaB32wB6mESjLLNAoePzfwShGBUl7Du2NJdrnTDeV+Kep67zq6dJKZNYSEPnR
	 Tvyp9ttCk5K2XVnQ8jhiixi27//r9z1Sp009O8pi7OXoVI9vD0etGAivFgLBCgued+
	 YET/4BILqJxeyX9W1etNK4CsYCeaVlGmmbMkSTR4HE+1jKukkODsPjMXOaZ7HMmS4J
	 Q3aj+jjxtiZXR28EgN7jO+J+c1D0AtEGMPMCmEgLt2l0DB15Ema0S89LrmFX7SAM8M
	 W3aIIWnlX+8AQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	oleg@redhat.com
Cc: peterz@infradead.org,
	mingo@redhat.com,
	bpf@vger.kernel.org,
	jolsa@kernel.org,
	paulmck@kernel.org,
	clm@meta.com,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v2 06/12] uprobes: add batch uprobe register/unregister APIs
Date: Mon,  1 Jul 2024 15:39:29 -0700
Message-ID: <20240701223935.3783951-7-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240701223935.3783951-1-andrii@kernel.org>
References: <20240701223935.3783951-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce batch versions of uprobe registration (attachment) and
unregistration (detachment) APIs.

Unregistration is presumed to never fail, so that's easy.

Batch registration can fail, and so the semantics of
uprobe_register_batch() is such that either all uprobe_consumers are
successfully attached or none of them remain attached after the return.

There is no guarantee of atomicity of attachment, though, and so while
batch attachment is proceeding, some uprobes might start firing before
others are completely attached. Even if overall attachment eventually
fails, some successfully attached uprobes might fire and callers have to
be prepared to handle that. This is in no way a regression compared to
current approach of attaching uprobes one-by-one, though.

One crucial implementation detail is the addition of `struct uprobe
*uprobe` field to `struct uprobe_consumer` which is meant for internal
uprobe subsystem usage only. We use this field both as temporary storage
(to avoid unnecessary allocations) and as a back link to associated
uprobe to simplify and speed up uprobe unregistration, as we now can
avoid yet another tree lookup when unregistering uprobe_consumer.

The general direction with uprobe registration implementation is to do
batch attachment in distinct steps, each step performing some set of
checks or actions on all uprobe_consumers before proceeding to the next
phase. This, after some more changes in next patches, allows to batch
locking for each phase and in such a way amortize any long delays that
might be added by writer locks (especially once we switch
uprobes_treelock to per-CPU R/W semaphore later).

Currently, uprobe_register_batch() performs all the sanity checks first.
Then proceeds to allocate-and-insert (we'll split this up further later
on) uprobe instances, as necessary. And then the last step is actual
uprobe registration for all affected VMAs.

We take care to undo all the actions in the event of an error at any
point in this lengthy process, so end result is all-or-nothing, as
described above.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/uprobes.h |  17 ++++
 kernel/events/uprobes.c | 180 ++++++++++++++++++++++++++++------------
 2 files changed, 146 insertions(+), 51 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index a75ba37ce3c8..a6e6eb70539d 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -33,6 +33,8 @@ enum uprobe_filter_ctx {
 	UPROBE_FILTER_MMAP,
 };
 
+typedef struct uprobe_consumer *(*uprobe_consumer_fn)(size_t idx, void *ctx);
+
 struct uprobe_consumer {
 	int (*handler)(struct uprobe_consumer *self, struct pt_regs *regs);
 	int (*ret_handler)(struct uprobe_consumer *self,
@@ -48,6 +50,8 @@ struct uprobe_consumer {
 	loff_t ref_ctr_offset;
 	/* for internal uprobe infra use, consumers shouldn't touch fields below */
 	struct uprobe_consumer *next;
+	/* associated uprobe instance (or NULL if consumer isn't attached) */
+	struct uprobe *uprobe;
 };
 
 #ifdef CONFIG_UPROBES
@@ -116,8 +120,12 @@ extern unsigned long uprobe_get_swbp_addr(struct pt_regs *regs);
 extern unsigned long uprobe_get_trap_addr(struct pt_regs *regs);
 extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr, uprobe_opcode_t);
 extern int uprobe_register(struct inode *inode, struct uprobe_consumer *uc);
+extern int uprobe_register_batch(struct inode *inode, int cnt,
+				 uprobe_consumer_fn get_uprobe_consumer, void *ctx);
 extern int uprobe_apply(struct inode *inode, loff_t offset, struct uprobe_consumer *uc, bool);
 extern void uprobe_unregister(struct inode *inode, struct uprobe_consumer *uc);
+extern void uprobe_unregister_batch(struct inode *inode, int cnt,
+				    uprobe_consumer_fn get_uprobe_consumer, void *ctx);
 extern int uprobe_mmap(struct vm_area_struct *vma);
 extern void uprobe_munmap(struct vm_area_struct *vma, unsigned long start, unsigned long end);
 extern void uprobe_start_dup_mmap(void);
@@ -160,6 +168,11 @@ uprobe_register(struct inode *inode, struct uprobe_consumer *uc)
 {
 	return -ENOSYS;
 }
+static inline int uprobe_register_batch(struct inode *inode, int cnt,
+					uprobe_consumer_fn get_uprobe_consumer, void *ctx)
+{
+	return -ENOSYS;
+}
 static inline int
 uprobe_apply(struct inode *inode, loff_t offset, struct uprobe_consumer *uc, bool add)
 {
@@ -169,6 +182,10 @@ static inline void
 uprobe_unregister(struct inode *inode, struct uprobe_consumer *uc)
 {
 }
+static inline void uprobe_unregister_batch(struct inode *inode, int cnt,
+					     uprobe_consumer_fn get_uprobe_consumer, void *ctx)
+{
+}
 static inline int uprobe_mmap(struct vm_area_struct *vma)
 {
 	return 0;
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 8759c6d0683e..68fdf1b8e4bf 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1221,6 +1221,41 @@ __uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
 	(void)register_for_each_vma(uprobe, NULL);
 }
 
+/*
+ * uprobe_unregister_batch - unregister a batch of already registered uprobe
+ * consumers.
+ * @inode: the file in which the probes have to be removed.
+ * @cnt: number of consumers to unregister
+ * @get_uprobe_consumer: a callback that returns Nth uprobe_consumer to attach
+ * @ctx: an arbitrary context passed through into get_uprobe_consumer callback
+ */
+void uprobe_unregister_batch(struct inode *inode, int cnt, uprobe_consumer_fn get_uprobe_consumer, void *ctx)
+{
+	struct uprobe *uprobe;
+	struct uprobe_consumer *uc;
+	int i;
+
+	for (i = 0; i < cnt; i++) {
+		uc = get_uprobe_consumer(i, ctx);
+		uprobe = uc->uprobe;
+
+		if (WARN_ON(!uprobe))
+			continue;
+
+		down_write(&uprobe->register_rwsem);
+		__uprobe_unregister(uprobe, uc);
+		up_write(&uprobe->register_rwsem);
+		put_uprobe(uprobe);
+
+		uc->uprobe = NULL;
+	}
+}
+
+static struct uprobe_consumer *uprobe_consumer_identity(size_t idx, void *ctx)
+{
+	return (struct uprobe_consumer *)ctx;
+}
+
 /*
  * uprobe_unregister - unregister an already registered probe.
  * @inode: the file in which the probe has to be removed.
@@ -1228,84 +1263,127 @@ __uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
  */
 void uprobe_unregister(struct inode *inode, struct uprobe_consumer *uc)
 {
-	struct uprobe *uprobe;
-
-	uprobe = find_uprobe(inode, uc->offset);
-	if (WARN_ON(!uprobe))
-		return;
-
-	down_write(&uprobe->register_rwsem);
-	__uprobe_unregister(uprobe, uc);
-	up_write(&uprobe->register_rwsem);
-	put_uprobe(uprobe);
+	uprobe_unregister_batch(inode, 1, uprobe_consumer_identity, uc);
 }
 EXPORT_SYMBOL_GPL(uprobe_unregister);
 
 /*
- * __uprobe_register - register a probe
- * @inode: the file in which the probe has to be placed.
- * @offset: offset from the start of the file.
- * @uc: information on howto handle the probe..
+ * uprobe_register_batch - register a batch of probes for a given inode
+ * @inode: the file in which the probes have to be placed.
+ * @cnt: number of probes to register
+ * @get_uprobe_consumer: a callback that returns Nth uprobe_consumer
+ * @ctx: an arbitrary context passed through into get_uprobe_consumer callback
+ *
+ * uprobe_consumer instance itself contains offset and (optional)
+ * ref_ctr_offset within inode to attach to.
+ *
+ * On success, each attached uprobe_consumer assumes one refcount taken for
+ * respective uprobe instance (uniquely identified by inode+offset
+ * combination). Each uprobe_consumer is expected to eventually be detached
+ * through uprobe_unregister() or uprobe_unregister_batch() call, dropping
+ * their owning refcount.
+ *
+ * Caller of uprobe_register()/uprobe_register_batch() is required to keep
+ * @inode (and the containing mount) referenced.
  *
- * Apart from the access refcount, __uprobe_register() takes a creation
- * refcount (thro alloc_uprobe) if and only if this @uprobe is getting
- * inserted into the rbtree (i.e first consumer for a @inode:@offset
- * tuple).  Creation refcount stops uprobe_unregister from freeing the
- * @uprobe even before the register operation is complete. Creation
- * refcount is released when the last @uc for the @uprobe
- * unregisters. Caller of __uprobe_register() is required to keep @inode
- * (and the containing mount) referenced.
+ * If not all probes are successfully installed, then all the successfully
+ * installed ones are rolled back. Note, there is no atomicity guarantees
+ * w.r.t. batch attachment. Some probes might start firing before batch
+ * attachment is completed. Even more so, some consumers might fire even if
+ * overall batch attachment ultimately fails.
  *
  * Return errno if it cannot successully install probes
  * else return 0 (success)
  */
-static int __uprobe_register(struct inode *inode, loff_t offset,
-			     loff_t ref_ctr_offset, struct uprobe_consumer *uc)
+int uprobe_register_batch(struct inode *inode, int cnt,
+			  uprobe_consumer_fn get_uprobe_consumer, void *ctx)
 {
 	struct uprobe *uprobe;
-	int ret;
-
-	/* Uprobe must have at least one set consumer */
-	if (!uc->handler && !uc->ret_handler)
-		return -EINVAL;
+	struct uprobe_consumer *uc;
+	int ret, i;
 
 	/* copy_insn() uses read_mapping_page() or shmem_read_mapping_page() */
 	if (!inode->i_mapping->a_ops->read_folio &&
 	    !shmem_mapping(inode->i_mapping))
 		return -EIO;
-	/* Racy, just to catch the obvious mistakes */
-	if (offset > i_size_read(inode))
-		return -EINVAL;
 
-	/*
-	 * This ensures that copy_from_page(), copy_to_page() and
-	 * __update_ref_ctr() can't cross page boundary.
-	 */
-	if (!IS_ALIGNED(offset, UPROBE_SWBP_INSN_SIZE))
-		return -EINVAL;
-	if (!IS_ALIGNED(ref_ctr_offset, sizeof(short)))
+	if (cnt <= 0 || !get_uprobe_consumer)
 		return -EINVAL;
 
-	uprobe = alloc_uprobe(inode, offset, ref_ctr_offset);
-	if (IS_ERR(uprobe))
-		return PTR_ERR(uprobe);
+	for (i = 0; i < cnt; i++) {
+		uc = get_uprobe_consumer(i, ctx);
+
+		/* Each consumer must have at least one set consumer */
+		if (!uc || (!uc->handler && !uc->ret_handler))
+			return -EINVAL;
+		/* Racy, just to catch the obvious mistakes */
+		if (uc->offset > i_size_read(inode))
+			return -EINVAL;
+		if (uc->uprobe)
+			return -EINVAL;
+		/*
+		 * This ensures that copy_from_page(), copy_to_page() and
+		 * __update_ref_ctr() can't cross page boundary.
+		 */
+		if (!IS_ALIGNED(uc->offset, UPROBE_SWBP_INSN_SIZE))
+			return -EINVAL;
+		if (!IS_ALIGNED(uc->ref_ctr_offset, sizeof(short)))
+			return -EINVAL;
+	}
 
-	down_write(&uprobe->register_rwsem);
-	consumer_add(uprobe, uc);
-	ret = register_for_each_vma(uprobe, uc);
-	if (ret)
-		__uprobe_unregister(uprobe, uc);
-	up_write(&uprobe->register_rwsem);
+	for (i = 0; i < cnt; i++) {
+		uc = get_uprobe_consumer(i, ctx);
 
-	if (ret)
-		put_uprobe(uprobe);
+		uprobe = alloc_uprobe(inode, uc->offset, uc->ref_ctr_offset);
+		if (IS_ERR(uprobe)) {
+			ret = PTR_ERR(uprobe);
+			goto cleanup_uprobes;
+		}
+
+		uc->uprobe = uprobe;
+	}
 
+	for (i = 0; i < cnt; i++) {
+		uc = get_uprobe_consumer(i, ctx);
+		uprobe = uc->uprobe;
+
+		down_write(&uprobe->register_rwsem);
+		consumer_add(uprobe, uc);
+		ret = register_for_each_vma(uprobe, uc);
+		if (ret)
+			__uprobe_unregister(uprobe, uc);
+		up_write(&uprobe->register_rwsem);
+
+		if (ret)
+			goto cleanup_unreg;
+	}
+
+	return 0;
+
+cleanup_unreg:
+	/* unregister all uprobes we managed to register until failure */
+	for (i--; i >= 0; i--) {
+		uc = get_uprobe_consumer(i, ctx);
+
+		down_write(&uprobe->register_rwsem);
+		__uprobe_unregister(uc->uprobe, uc);
+		up_write(&uprobe->register_rwsem);
+	}
+cleanup_uprobes:
+	/* put all the successfully allocated/reused uprobes */
+	for (i = 0; i < cnt; i++) {
+		uc = get_uprobe_consumer(i, ctx);
+
+		if (uc->uprobe)
+			put_uprobe(uc->uprobe);
+		uc->uprobe = NULL;
+	}
 	return ret;
 }
 
 int uprobe_register(struct inode *inode, struct uprobe_consumer *uc)
 {
-	return __uprobe_register(inode, uc->offset, uc->ref_ctr_offset, uc);
+	return uprobe_register_batch(inode, 1, uprobe_consumer_identity, uc);
 }
 EXPORT_SYMBOL_GPL(uprobe_register);
 
-- 
2.43.0


