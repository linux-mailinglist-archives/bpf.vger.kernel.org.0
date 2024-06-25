Return-Path: <bpf+bounces-32968-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E441D915AF3
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 02:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CDC32830D9
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 00:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9B28821;
	Tue, 25 Jun 2024 00:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5AS1ZPX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2148184;
	Tue, 25 Jun 2024 00:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719274931; cv=none; b=asBWvARdyVD67CcnDnYMUdtM4o9a8YLet3cnTSDFnKksfCOj0ayhVDHiDPm03Ozgw0qK+RlrlUV7/1IIO6vnEBhKeGeigm3QmEDGoWuLlaR9uNo+wJYtIogNKSVilZsw4+meMR+cGcPtGmlEbVbW+oSKL9YZiyALRw0JbcvGpak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719274931; c=relaxed/simple;
	bh=apwry0zQrQhk10i4zrJSmGSjOMbNFiC87Jh8XNYC3mM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fmswMvP/NwBC/ynxhavMxUyEy5jwf6PRDMb3/KPEDxNFZmYAxp19Nx6Qi1wTzp+EjgQO72PxaRTSCoPQVWTK4iM+3tYiXNrQUn/6Z8TlR6PIe0EYJ/LmWk29cSCI91ejt/IuSJAK0Tq+joZZ8/U/fAUXs+NB8xSVnCucKchcqno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5AS1ZPX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E5AC2BBFC;
	Tue, 25 Jun 2024 00:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719274931;
	bh=apwry0zQrQhk10i4zrJSmGSjOMbNFiC87Jh8XNYC3mM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P5AS1ZPXorvLEBe85HDCQZWG76k8NgXQlfQUJSGV7rNqxKhIrMZXfFXwtkxd5vDUW
	 yJ/StczgQbGGt1TuBflalqFiULceIYsucgc5v+bEElAsUGWPYk7EegLI63a2OpsneI
	 m3QBL9TmgzjNcEKOrmX6YpNYl7jKGyiJeYFstNYOjHGn34U2u4sLhxn1Qz/PHY/6+m
	 Z2qnkAHqPEEyx/eY31jEfHZfbyb5+WVobku6DagvBih5Bd3ez5+cbqnNXpenpeSKSl
	 fK5kuKjUFBq5cnltzJZgpPv8VUlPIf3YpxFfsjzckHN299I3rkHO1Yp3MVKWKPmFii
	 I/CJklSpyZf6A==
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
Subject: [PATCH 06/12] uprobes: add batch uprobe register/unregister APIs
Date: Mon, 24 Jun 2024 17:21:38 -0700
Message-ID: <20240625002144.3485799-7-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240625002144.3485799-1-andrii@kernel.org>
References: <20240625002144.3485799-1-andrii@kernel.org>
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
 kernel/events/uprobes.c | 181 +++++++++++++++++++++++++++++-----------
 2 files changed, 147 insertions(+), 51 deletions(-)

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
index 2544e8b79bad..846efda614cb 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1194,6 +1194,41 @@ __uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
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
@@ -1201,84 +1236,128 @@ __uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
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
  *
- * Apart from the access refcount, __uprobe_register() takes a creation
- * refcount (thro alloc_uprobe) if and only if this @uprobe is getting
- * inserted into the rbtree (i.e first consumer for a @inode:@offset
- * tuple).  Creation refcount stops uprobe_unregister from freeing the
- * @uprobe even before the register operation is complete. Creation
- * refcount is released when the last @uc for the @uprobe
- * unregisters. Caller of __uprobe_register() is required to keep @inode
- * (and the containing mount) referenced.
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
+ *
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
+
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
+		if (ret) {
+			put_uprobe(uprobe);
+			goto cleanup_unreg;
+		}
+	}
+
+	return 0;
 
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
+	for (i = cnt - 1; i >= 0; i--) {
+		uc = get_uprobe_consumer(i, ctx);
+
+		put_uprobe(uc->uprobe);
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


