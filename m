Return-Path: <bpf+bounces-36648-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DBF94B417
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 02:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A90BD1C213E7
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 00:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDF64A3F;
	Thu,  8 Aug 2024 00:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJBZ/+Kq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0134400;
	Thu,  8 Aug 2024 00:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723076485; cv=none; b=B2Ckf0aWojWgm1B5Oh7kzhyuzTMXcwYz+DJz2S/jqt6GHTzMvAfve7LCpAsPDZqjDC0M8RJXgWCFlOX6wZzvF46jaOmv5dRNAJYfTondUfJvff3U9uuSXsR4zz1ArsNshkHVrk+K6UTV59iG+lItnFkCqMNkCTE8GD6n2vEgk0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723076485; c=relaxed/simple;
	bh=VCy2CvhVgg07pSrkna9h9ap+YjHVCBghm0y6dLk+De8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xn4vIcUMfACHcaJpNjBl/WcYOg5CXJmUxvL57uqQWudkkEEFptBdSi58YFX+QN/iI0HUJRAZX4Lvz7dFRycSF8z0yiHtzkKo+Mt5gx/3Yd0u3Zbh266ZhDNQPrYjT/nfBVQUc9WgQwyZ/OKu+s6tB7DY+oskrJWhUekh5xP9/lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJBZ/+Kq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55E9DC32781;
	Thu,  8 Aug 2024 00:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723076484;
	bh=VCy2CvhVgg07pSrkna9h9ap+YjHVCBghm0y6dLk+De8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HJBZ/+Kq8PvEf7Ey1I575SPkUYU1EjPMOIFcEt1kRdWD5XEouZtVcD03sqGjeCXci
	 RMJXx9MD7Fg7Rhuf5mPe/htqcK2vd0wAMyS4dQo3N/XieF6JhhI3PoHd8NZpyc0CJc
	 oQFQJS9rSf4lgPlXHOQ8Da1sS+Ky8UyPL6Y430dVoDAG0FJMG2uwheHPXEuuGOzeVm
	 WYl4OSRDXUDjEeJq22TCm2uXN3e0S4/yotknDbjlnNqK5nJTDfEhFtAs1oGdITIXKI
	 Evbv0j6xNQJNvihmOLyYEwJQh9K22UyJl+0Iq2xtKrAqp6/e+U9dAdPZp7rJfY3Hl6
	 1I0ohJVzmsmNA==
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
Subject: [PATCH v2 1/6] uprobes: revamp uprobe refcounting and lifetime management
Date: Wed,  7 Aug 2024 17:21:13 -0700
Message-ID: <20240808002118.918105-2-andrii@kernel.org>
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

Revamp how struct uprobe is refcounted, and thus how its lifetime is
managed.

Right now, there are a few possible "owners" of uprobe refcount:
  - uprobes_tree RB tree assumes one refcount when uprobe is registered
    and added to the lookup tree;
  - while uprobe is triggered and kernel is handling it in the breakpoint
    handler code, temporary refcount bump is done to keep uprobe from
    being freed;
  - if we have uretprobe requested on a given struct uprobe instance, we
    take another refcount to keep uprobe alive until user space code
    returns from the function and triggers return handler.

The uprobe_tree's extra refcount of 1 is confusing and problematic. No
matter how many actual consumers are attached, they all share the same
refcount, and we have an extra logic to drop the "last" (which might not
really be last) refcount once uprobe's consumer list becomes empty.

This is unconventional and has to be kept in mind as a special case all
the time. Further, because of this design we have the situations where
find_uprobe() will find uprobe, bump refcount, return it to the caller,
but that uprobe will still need uprobe_is_active() check, after which
the caller is required to drop refcount and try again. This is just too
many details leaking to the higher level logic.

This patch changes refcounting scheme in such a way as to not have
uprobes_tree keeping extra refcount for struct uprobe. Instead, each
uprobe_consumer is assuming its own refcount, which will be dropped
when consumer is unregistered. Other than that, all the active users of
uprobe (entry and return uprobe handling code) keeps exactly the same
refcounting approach.

With the above setup, once uprobe's refcount drops to zero, we need to
make sure that uprobe's "destructor" removes uprobe from uprobes_tree,
of course. This, though, races with uprobe entry handling code in
handle_swbp(), which, through find_active_uprobe()->find_uprobe() lookup,
can race with uprobe being destroyed after refcount drops to zero (e.g.,
due to uprobe_consumer unregistering). So we add try_get_uprobe(), which
will attempt to bump refcount, unless it already is zero. Caller needs
to guarantee that uprobe instance won't be freed in parallel, which is
the case while we keep uprobes_treelock (for read or write, doesn't
matter).

Note also, we now don't leak the race between registration and
unregistration, so we remove the retry logic completely. If
find_uprobe() returns valid uprobe, it's guaranteed to remain in
uprobes_tree with properly incremented refcount. The race is handled
inside __insert_uprobe() and put_uprobe() working together:
__insert_uprobe() will remove uprobe from RB-tree, if it can't bump
refcount and will retry to insert the new uprobe instance. put_uprobe()
won't attempt to remove uprobe from RB-tree, if it's already not there.
All that is protected by uprobes_treelock, which keeps things simple.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/events/uprobes.c | 179 +++++++++++++++++++++++-----------------
 1 file changed, 101 insertions(+), 78 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 30348f13d4a7..16bdfbb0900e 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -109,6 +109,11 @@ struct xol_area {
 	unsigned long 			vaddr;		/* Page(s) of instruction slots */
 };
 
+static void uprobe_warn(struct task_struct *t, const char *msg)
+{
+	pr_warn("uprobe: %s:%d failed to %s\n", current->comm, current->pid, msg);
+}
+
 /*
  * valid_vma: Verify if the specified vma is an executable vma
  * Relax restrictions while unregistering: vm_flags might have
@@ -587,25 +592,53 @@ set_orig_insn(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long v
 			*(uprobe_opcode_t *)&auprobe->insn);
 }
 
+/* uprobe should have guaranteed positive refcount */
 static struct uprobe *get_uprobe(struct uprobe *uprobe)
 {
 	refcount_inc(&uprobe->ref);
 	return uprobe;
 }
 
+/*
+ * uprobe should have guaranteed lifetime, which can be either of:
+ *   - caller already has refcount taken (and wants an extra one);
+ *   - uprobe is RCU protected and won't be freed until after grace period;
+ *   - we are holding uprobes_treelock (for read or write, doesn't matter).
+ */
+static struct uprobe *try_get_uprobe(struct uprobe *uprobe)
+{
+	if (refcount_inc_not_zero(&uprobe->ref))
+		return uprobe;
+	return NULL;
+}
+
+static inline bool uprobe_is_active(struct uprobe *uprobe)
+{
+	return !RB_EMPTY_NODE(&uprobe->rb_node);
+}
+
 static void put_uprobe(struct uprobe *uprobe)
 {
-	if (refcount_dec_and_test(&uprobe->ref)) {
-		/*
-		 * If application munmap(exec_vma) before uprobe_unregister()
-		 * gets called, we don't get a chance to remove uprobe from
-		 * delayed_uprobe_list from remove_breakpoint(). Do it here.
-		 */
-		mutex_lock(&delayed_uprobe_lock);
-		delayed_uprobe_remove(uprobe, NULL);
-		mutex_unlock(&delayed_uprobe_lock);
-		kfree(uprobe);
-	}
+	if (!refcount_dec_and_test(&uprobe->ref))
+		return;
+
+	write_lock(&uprobes_treelock);
+
+	if (uprobe_is_active(uprobe))
+		rb_erase(&uprobe->rb_node, &uprobes_tree);
+
+	write_unlock(&uprobes_treelock);
+
+	/*
+	 * If application munmap(exec_vma) before uprobe_unregister()
+	 * gets called, we don't get a chance to remove uprobe from
+	 * delayed_uprobe_list from remove_breakpoint(). Do it here.
+	 */
+	mutex_lock(&delayed_uprobe_lock);
+	delayed_uprobe_remove(uprobe, NULL);
+	mutex_unlock(&delayed_uprobe_lock);
+
+	kfree(uprobe);
 }
 
 static __always_inline
@@ -656,7 +689,7 @@ static struct uprobe *__find_uprobe(struct inode *inode, loff_t offset)
 	struct rb_node *node = rb_find(&key, &uprobes_tree, __uprobe_cmp_key);
 
 	if (node)
-		return get_uprobe(__node_2_uprobe(node));
+		return try_get_uprobe(__node_2_uprobe(node));
 
 	return NULL;
 }
@@ -676,26 +709,44 @@ static struct uprobe *find_uprobe(struct inode *inode, loff_t offset)
 	return uprobe;
 }
 
+/*
+ * Attempt to insert a new uprobe into uprobes_tree.
+ *
+ * If uprobe already exists (for given inode+offset), we just increment
+ * refcount of previously existing uprobe.
+ *
+ * If not, a provided new instance of uprobe is inserted into the tree (with
+ * assumed initial refcount == 1).
+ *
+ * In any case, we return a uprobe instance that ends up being in uprobes_tree.
+ * Caller has to clean up new uprobe instance, if it ended up not being
+ * inserted into the tree.
+ *
+ * We assume that uprobes_treelock is held for writing.
+ */
 static struct uprobe *__insert_uprobe(struct uprobe *uprobe)
 {
 	struct rb_node *node;
-
+again:
 	node = rb_find_add(&uprobe->rb_node, &uprobes_tree, __uprobe_cmp);
-	if (node)
-		return get_uprobe(__node_2_uprobe(node));
+	if (node) {
+		struct uprobe *u = __node_2_uprobe(node);
 
-	/* get access + creation ref */
-	refcount_set(&uprobe->ref, 2);
-	return NULL;
+		if (!try_get_uprobe(u)) {
+			rb_erase(node, &uprobes_tree);
+			RB_CLEAR_NODE(&u->rb_node);
+			goto again;
+		}
+
+		return u;
+	}
+
+	return uprobe;
 }
 
 /*
- * Acquire uprobes_treelock.
- * Matching uprobe already exists in rbtree;
- *	increment (access refcount) and return the matching uprobe.
- *
- * No matching uprobe; insert the uprobe in rb_tree;
- *	get a double refcount (access + creation) and return NULL.
+ * Acquire uprobes_treelock and insert uprobe into uprobes_tree
+ * (or reuse existing one, see __insert_uprobe() comments above).
  */
 static struct uprobe *insert_uprobe(struct uprobe *uprobe)
 {
@@ -732,11 +783,13 @@ static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset,
 	uprobe->ref_ctr_offset = ref_ctr_offset;
 	init_rwsem(&uprobe->register_rwsem);
 	init_rwsem(&uprobe->consumer_rwsem);
+	RB_CLEAR_NODE(&uprobe->rb_node);
+	refcount_set(&uprobe->ref, 1);
 
 	/* add to uprobes_tree, sorted on inode:offset */
 	cur_uprobe = insert_uprobe(uprobe);
 	/* a uprobe exists for this inode:offset combination */
-	if (cur_uprobe) {
+	if (cur_uprobe != uprobe) {
 		if (cur_uprobe->ref_ctr_offset != uprobe->ref_ctr_offset) {
 			ref_ctr_mismatch_warn(cur_uprobe, uprobe);
 			put_uprobe(cur_uprobe);
@@ -921,26 +974,6 @@ remove_breakpoint(struct uprobe *uprobe, struct mm_struct *mm, unsigned long vad
 	return set_orig_insn(&uprobe->arch, mm, vaddr);
 }
 
-static inline bool uprobe_is_active(struct uprobe *uprobe)
-{
-	return !RB_EMPTY_NODE(&uprobe->rb_node);
-}
-/*
- * There could be threads that have already hit the breakpoint. They
- * will recheck the current insn and restart if find_uprobe() fails.
- * See find_active_uprobe().
- */
-static void delete_uprobe(struct uprobe *uprobe)
-{
-	if (WARN_ON(!uprobe_is_active(uprobe)))
-		return;
-
-	write_lock(&uprobes_treelock);
-	rb_erase(&uprobe->rb_node, &uprobes_tree);
-	write_unlock(&uprobes_treelock);
-	RB_CLEAR_NODE(&uprobe->rb_node); /* for uprobe_is_active() */
-}
-
 struct map_info {
 	struct map_info *next;
 	struct mm_struct *mm;
@@ -1094,17 +1127,13 @@ void uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
 	int err;
 
 	down_write(&uprobe->register_rwsem);
-	if (WARN_ON(!consumer_del(uprobe, uc)))
+	if (WARN_ON(!consumer_del(uprobe, uc))) {
 		err = -ENOENT;
-	else
+	} else {
 		err = register_for_each_vma(uprobe, NULL);
-
-	/* TODO : cant unregister? schedule a worker thread */
-	if (!err) {
-		if (!uprobe->consumers)
-			delete_uprobe(uprobe);
-		else
-			err = -EBUSY;
+		/* TODO : cant unregister? schedule a worker thread */
+		if (unlikely(err))
+			uprobe_warn(current, "unregister, leaking uprobe");
 	}
 	up_write(&uprobe->register_rwsem);
 
@@ -1159,27 +1188,16 @@ struct uprobe *uprobe_register(struct inode *inode,
 	if (!IS_ALIGNED(ref_ctr_offset, sizeof(short)))
 		return ERR_PTR(-EINVAL);
 
- retry:
 	uprobe = alloc_uprobe(inode, offset, ref_ctr_offset);
 	if (IS_ERR(uprobe))
 		return uprobe;
 
-	/*
-	 * We can race with uprobe_unregister()->delete_uprobe().
-	 * Check uprobe_is_active() and retry if it is false.
-	 */
 	down_write(&uprobe->register_rwsem);
-	ret = -EAGAIN;
-	if (likely(uprobe_is_active(uprobe))) {
-		consumer_add(uprobe, uc);
-		ret = register_for_each_vma(uprobe, uc);
-	}
+	consumer_add(uprobe, uc);
+	ret = register_for_each_vma(uprobe, uc);
 	up_write(&uprobe->register_rwsem);
-	put_uprobe(uprobe);
 
 	if (ret) {
-		if (unlikely(ret == -EAGAIN))
-			goto retry;
 		uprobe_unregister(uprobe, uc);
 		return ERR_PTR(ret);
 	}
@@ -1286,15 +1304,17 @@ static void build_probe_list(struct inode *inode,
 			u = rb_entry(t, struct uprobe, rb_node);
 			if (u->inode != inode || u->offset < min)
 				break;
-			list_add(&u->pending_list, head);
-			get_uprobe(u);
+			/* if uprobe went away, it's safe to ignore it */
+			if (try_get_uprobe(u))
+				list_add(&u->pending_list, head);
 		}
 		for (t = n; (t = rb_next(t)); ) {
 			u = rb_entry(t, struct uprobe, rb_node);
 			if (u->inode != inode || u->offset > max)
 				break;
-			list_add(&u->pending_list, head);
-			get_uprobe(u);
+			/* if uprobe went away, it's safe to ignore it */
+			if (try_get_uprobe(u))
+				list_add(&u->pending_list, head);
 		}
 	}
 	read_unlock(&uprobes_treelock);
@@ -1752,6 +1772,12 @@ static int dup_utask(struct task_struct *t, struct uprobe_task *o_utask)
 			return -ENOMEM;
 
 		*n = *o;
+		/*
+		 * uprobe's refcnt has to be positive at this point, kept by
+		 * utask->return_instances items; return_instances can't be
+		 * removed right now, as task is blocked due to duping; so
+		 * get_uprobe() is safe to use here.
+		 */
 		get_uprobe(n->uprobe);
 		n->next = NULL;
 
@@ -1763,12 +1789,6 @@ static int dup_utask(struct task_struct *t, struct uprobe_task *o_utask)
 	return 0;
 }
 
-static void uprobe_warn(struct task_struct *t, const char *msg)
-{
-	pr_warn("uprobe: %s:%d failed to %s\n",
-			current->comm, current->pid, msg);
-}
-
 static void dup_xol_work(struct callback_head *work)
 {
 	if (current->flags & PF_EXITING)
@@ -1894,7 +1914,10 @@ static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs)
 		}
 		orig_ret_vaddr = utask->return_instances->orig_ret_vaddr;
 	}
-
+	/*
+	 * uprobe's refcnt is positive, held by caller, so it's safe to
+	 * unconditionally bump it one more time here
+	 */
 	ri->uprobe = get_uprobe(uprobe);
 	ri->func = instruction_pointer(regs);
 	ri->stack = user_stack_pointer(regs);
-- 
2.43.5


