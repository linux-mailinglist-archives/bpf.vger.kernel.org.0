Return-Path: <bpf+bounces-33772-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E7D9261F2
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 15:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50A9E1C218E0
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 13:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE1417B41D;
	Wed,  3 Jul 2024 13:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T2+2ohy1"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E8917B401;
	Wed,  3 Jul 2024 13:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720013782; cv=none; b=a1NoKvv293YDrFimYbTqhfYXdO3lihoGaZyzrZi1epQYMBh97SxAoWxoJ/afcFjOur4bwpg+6nmbvXrNrsrrbcaDz0W50QTEED5KkXKKqGQES4jP70wKp+WmckWMGC7G8QO7vGo+z24ctBXKJn2XTnEuD0PDk4RlUMQAImu1wZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720013782; c=relaxed/simple;
	bh=ubd10Xmqn+B/U10i4rpd4lwrkqkc7DlJhWW3Ljd4cf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t3Tu5eqTZF53AC44QRt2KT0PiPDvT+f6DsC2xoWEyeEcmHS8y8w5f1Qg1yZOsyWx4ncnzDpTG2nFOp/eQucFwpR5ErWPORJjKd0ykuO7HOBi6AXNm9UUnavD4+nPSZIVu1FdA2jbawmlMhrs3Zj9Jz5+KkumpwTWyXZHEB9tBl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=T2+2ohy1; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FFNv2HUaPJSggsHl4sd+qz6E+s5URO5szbam6s3Sxy0=; b=T2+2ohy1UEeGt9Uzw1UhIVzbkb
	scfDBrAYjKsgDEjuiKTtJSEq8ivGsfPrD8cY6Muz/lkLXEDP13LFPA5NuV4g2BkLS4zE4JSQiVuNE
	W+7CIMfyGrnFanZNqdpGWCcybT7RcOJkDP1Qbd23lSpATzfc2Uj0WK9XKHjxpA0mU+ecTbgstpPu8
	a+vt4gtJRDexwthlLTfz7pIz5LwvTm7ebrb7/GyOhQ1FXq/EWbxfKiIDbEx8T8NHa5772Z4Ynqdqp
	fl7FfGKwTD7h/G4f7NIr9WB2mo1yOzeAVzyLDVSHovmX6BIPReCJMchViGedbSPrYPM0XuD5Zl5IR
	t4vw2f+w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP09b-0000000A0oT-41II;
	Wed, 03 Jul 2024 13:36:12 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8D8333006B7; Wed,  3 Jul 2024 15:36:08 +0200 (CEST)
Date: Wed, 3 Jul 2024 15:36:08 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, oleg@redhat.com, mingo@redhat.com,
	bpf@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org,
	clm@meta.com
Subject: Re: [PATCH v2 04/12] uprobes: revamp uprobe refcounting and lifetime
 management
Message-ID: <20240703133608.GO11386@noisy.programming.kicks-ass.net>
References: <20240701223935.3783951-1-andrii@kernel.org>
 <20240701223935.3783951-5-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701223935.3783951-5-andrii@kernel.org>

On Mon, Jul 01, 2024 at 03:39:27PM -0700, Andrii Nakryiko wrote:

> One, attempted initially, way to solve this is through using
> atomic_inc_not_zero() approach, turning get_uprobe() into
> try_get_uprobe(),

This is the canonical thing to do. Everybody does this.

> which can fail to bump refcount if uprobe is already
> destined to be destroyed. This, unfortunately, turns out to be a rather
> expensive due to underlying cmpxchg() operation in
> atomic_inc_not_zero() and scales rather poorly with increased amount of
> parallel threads triggering uprobes.

Different archs different trade-offs. You'll not see this on LL/SC archs
for example.

> Furthermore, CPU profiling showed the following overall CPU usage:
>   - try_get_uprobe (19.3%) + put_uprobe (8.2%) = 27.5% CPU usage for
>     atomic_inc_not_zero approach;
>   - __get_uprobe (12.3%) + put_uprobe (9.9%) = 22.2% CPU usage for
>     atomic_add_and_return approach implemented by this patch.

I think those numbers suggest trying to not have a refcount in the first
place. Both are pretty terrible, yes one is less terrible than the
other, but still terrible.

Specifically, I'm thinking it is the refcounting in handlw_swbp() that
is actually the problem, all the other stuff is noise. 

So if you have SRCU protected consumers, what is the reason for still
having a refcount in handlw_swbp() ? Simply have the whole of it inside
a single SRCU critical section, then all consumers you find get a hit.

Hmm, return probes are a pain, they require the uprobe to stay extant
between handle_swbp() and handle_trampoline(). I'm thinking we can do
that with SRCU as well.

When I cobble all that together (it really shouldn't be one patch, but
you get the idea I hope) it looks a little something like the below.

I *think* it should work, but perhaps I've missed something?

TL;DR replace treelock with seqcount+SRCU
      replace register_rwsem with SRCU
      replace handle_swbp() refcount with SRCU
      replace return_instance refcount with a second SRCU

Paul, I had to do something vile with SRCU. The basic problem is that we
want to keep a SRCU critical section across fork(), which leads to both
parent and child doing srcu_read_unlock(&srcu, idx). As such, I need an
extra increment on the @idx ssp counter to even things out, see
__srcu_read_clone_lock().

---
 include/linux/rbtree.h  |  45 +++++++++++++
 include/linux/srcu.h    |   2 +
 include/linux/uprobes.h |   2 +
 kernel/events/uprobes.c | 166 +++++++++++++++++++++++++++++++-----------------
 kernel/rcu/srcutree.c   |   5 ++
 5 files changed, 161 insertions(+), 59 deletions(-)

diff --git a/include/linux/rbtree.h b/include/linux/rbtree.h
index f7edca369eda..9847fa58a287 100644
--- a/include/linux/rbtree.h
+++ b/include/linux/rbtree.h
@@ -244,6 +244,31 @@ rb_find_add(struct rb_node *node, struct rb_root *tree,
 	return NULL;
 }
 
+static __always_inline struct rb_node *
+rb_find_add_rcu(struct rb_node *node, struct rb_root *tree,
+		int (*cmp)(struct rb_node *, const struct rb_node *))
+{
+	struct rb_node **link = &tree->rb_node;
+	struct rb_node *parent = NULL;
+	int c;
+
+	while (*link) {
+		parent = *link;
+		c = cmp(node, parent);
+
+		if (c < 0)
+			link = &parent->rb_left;
+		else if (c > 0)
+			link = &parent->rb_right;
+		else
+			return parent;
+	}
+
+	rb_link_node_rcu(node, parent, link);
+	rb_insert_color(node, tree);
+	return NULL;
+}
+
 /**
  * rb_find() - find @key in tree @tree
  * @key: key to match
@@ -272,6 +297,26 @@ rb_find(const void *key, const struct rb_root *tree,
 	return NULL;
 }
 
+static __always_inline struct rb_node *
+rb_find_rcu(const void *key, const struct rb_root *tree,
+	    int (*cmp)(const void *key, const struct rb_node *))
+{
+	struct rb_node *node = tree->rb_node;
+
+	while (node) {
+		int c = cmp(key, node);
+
+		if (c < 0)
+			node = rcu_dereference_raw(node->rb_left);
+		else if (c > 0)
+			node = rcu_dereference_raw(node->rb_right);
+		else
+			return node;
+	}
+
+	return NULL;
+}
+
 /**
  * rb_find_first() - find the first @key in @tree
  * @key: key to match
diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 236610e4a8fa..9b14acecbb9d 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -55,7 +55,9 @@ void call_srcu(struct srcu_struct *ssp, struct rcu_head *head,
 		void (*func)(struct rcu_head *head));
 void cleanup_srcu_struct(struct srcu_struct *ssp);
 int __srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp);
+void __srcu_read_clone_lock(struct srcu_struct *ssp, int idx);
 void __srcu_read_unlock(struct srcu_struct *ssp, int idx) __releases(ssp);
+
 void synchronize_srcu(struct srcu_struct *ssp);
 unsigned long get_state_synchronize_srcu(struct srcu_struct *ssp);
 unsigned long start_poll_synchronize_srcu(struct srcu_struct *ssp);
diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index f46e0ca0169c..354cab634341 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -78,6 +78,7 @@ struct uprobe_task {
 
 	struct return_instance		*return_instances;
 	unsigned int			depth;
+	unsigned int			active_srcu_idx;
 };
 
 struct return_instance {
@@ -86,6 +87,7 @@ struct return_instance {
 	unsigned long		stack;		/* stack pointer */
 	unsigned long		orig_ret_vaddr; /* original return address */
 	bool			chained;	/* true, if instance is nested */
+	int			srcu_idx;
 
 	struct return_instance	*next;		/* keep as stack */
 };
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 2c83ba776fc7..0b7574a54093 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -26,6 +26,7 @@
 #include <linux/task_work.h>
 #include <linux/shmem_fs.h>
 #include <linux/khugepaged.h>
+#include <linux/srcu.h>
 
 #include <linux/uprobes.h>
 
@@ -40,6 +41,17 @@ static struct rb_root uprobes_tree = RB_ROOT;
 #define no_uprobe_events()	RB_EMPTY_ROOT(&uprobes_tree)
 
 static DEFINE_RWLOCK(uprobes_treelock);	/* serialize rbtree access */
+static seqcount_rwlock_t uprobes_seqcount = SEQCNT_RWLOCK_ZERO(uprobes_seqcount, &uprobes_treelock);
+
+/*
+ * Used for both the uprobes_tree and the uprobe->consumer list.
+ */
+DEFINE_STATIC_SRCU(uprobe_srcu);
+/*
+ * Used for return_instance and single-step uprobe lifetime. Separate from
+ * uprobe_srcu in order to minimize the synchronize_srcu() cost at unregister.
+ */
+DEFINE_STATIC_SRCU(uretprobe_srcu);
 
 #define UPROBES_HASH_SZ	13
 /* serialize uprobe->pending_list */
@@ -54,7 +66,8 @@ DEFINE_STATIC_PERCPU_RWSEM(dup_mmap_sem);
 struct uprobe {
 	struct rb_node		rb_node;	/* node in the rb tree */
 	refcount_t		ref;
-	struct rw_semaphore	register_rwsem;
+	struct rcu_head		rcu;
+	struct mutex		register_mutex;
 	struct rw_semaphore	consumer_rwsem;
 	struct list_head	pending_list;
 	struct uprobe_consumer	*consumers;
@@ -67,7 +80,7 @@ struct uprobe {
 	 * The generic code assumes that it has two members of unknown type
 	 * owned by the arch-specific code:
 	 *
-	 * 	insn -	copy_insn() saves the original instruction here for
+	 *	insn -	copy_insn() saves the original instruction here for
 	 *		arch_uprobe_analyze_insn().
 	 *
 	 *	ixol -	potentially modified instruction to execute out of
@@ -205,7 +218,7 @@ static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
 	folio_put(old_folio);
 
 	err = 0;
- unlock:
+unlock:
 	mmu_notifier_invalidate_range_end(&range);
 	folio_unlock(old_folio);
 	return err;
@@ -593,6 +606,22 @@ static struct uprobe *get_uprobe(struct uprobe *uprobe)
 	return uprobe;
 }
 
+static void uprobe_free_stage2(struct rcu_head *rcu)
+{
+	struct uprobe *uprobe = container_of(rcu, struct uprobe, rcu);
+	kfree(uprobe);
+}
+
+static void uprobe_free_stage1(struct rcu_head *rcu)
+{
+	struct uprobe *uprobe = container_of(rcu, struct uprobe, rcu);
+	/*
+	 * At this point all the consumers are complete and gone, but retprobe
+	 * and single-step might still reference the uprobe itself.
+	 */
+	call_srcu(&uretprobe_srcu, &uprobe->rcu, uprobe_free_stage2);
+}
+
 static void put_uprobe(struct uprobe *uprobe)
 {
 	if (refcount_dec_and_test(&uprobe->ref)) {
@@ -604,7 +633,8 @@ static void put_uprobe(struct uprobe *uprobe)
 		mutex_lock(&delayed_uprobe_lock);
 		delayed_uprobe_remove(uprobe, NULL);
 		mutex_unlock(&delayed_uprobe_lock);
-		kfree(uprobe);
+
+		call_srcu(&uprobe_srcu, &uprobe->rcu, uprobe_free_stage1);
 	}
 }
 
@@ -653,10 +683,10 @@ static struct uprobe *__find_uprobe(struct inode *inode, loff_t offset)
 		.inode = inode,
 		.offset = offset,
 	};
-	struct rb_node *node = rb_find(&key, &uprobes_tree, __uprobe_cmp_key);
+	struct rb_node *node = rb_find_rcu(&key, &uprobes_tree, __uprobe_cmp_key);
 
 	if (node)
-		return get_uprobe(__node_2_uprobe(node));
+		return __node_2_uprobe(node);
 
 	return NULL;
 }
@@ -667,20 +697,32 @@ static struct uprobe *__find_uprobe(struct inode *inode, loff_t offset)
  */
 static struct uprobe *find_uprobe(struct inode *inode, loff_t offset)
 {
-	struct uprobe *uprobe;
+	unsigned seq;
 
-	read_lock(&uprobes_treelock);
-	uprobe = __find_uprobe(inode, offset);
-	read_unlock(&uprobes_treelock);
+	lockdep_assert(srcu_read_lock_held(&uprobe_srcu));
 
-	return uprobe;
+	do {
+		seq = read_seqcount_begin(&uprobes_seqcount);
+		struct uprobe *uprobe = __find_uprobe(inode, offset);
+		if (uprobe) {
+			/*
+			 * Lockless RB-tree lookups are prone to false-negatives.
+			 * If they find something, it's good. If they do not find,
+			 * it needs to be validated.
+			 */
+			return uprobe;
+		}
+	} while (read_seqcount_retry(&uprobes_seqcount, seq));
+
+	/* Really didn't find anything. */
+	return NULL;
 }
 
 static struct uprobe *__insert_uprobe(struct uprobe *uprobe)
 {
 	struct rb_node *node;
 
-	node = rb_find_add(&uprobe->rb_node, &uprobes_tree, __uprobe_cmp);
+	node = rb_find_add_rcu(&uprobe->rb_node, &uprobes_tree, __uprobe_cmp);
 	if (node)
 		return get_uprobe(__node_2_uprobe(node));
 
@@ -702,7 +744,9 @@ static struct uprobe *insert_uprobe(struct uprobe *uprobe)
 	struct uprobe *u;
 
 	write_lock(&uprobes_treelock);
+	write_seqcount_begin(&uprobes_seqcount);
 	u = __insert_uprobe(uprobe);
+	write_seqcount_end(&uprobes_seqcount);
 	write_unlock(&uprobes_treelock);
 
 	return u;
@@ -730,7 +774,7 @@ static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset,
 	uprobe->inode = inode;
 	uprobe->offset = offset;
 	uprobe->ref_ctr_offset = ref_ctr_offset;
-	init_rwsem(&uprobe->register_rwsem);
+	mutex_init(&uprobe->register_mutex);
 	init_rwsem(&uprobe->consumer_rwsem);
 
 	/* add to uprobes_tree, sorted on inode:offset */
@@ -754,7 +798,7 @@ static void consumer_add(struct uprobe *uprobe, struct uprobe_consumer *uc)
 {
 	down_write(&uprobe->consumer_rwsem);
 	uc->next = uprobe->consumers;
-	uprobe->consumers = uc;
+	rcu_assign_pointer(uprobe->consumers, uc);
 	up_write(&uprobe->consumer_rwsem);
 }
 
@@ -771,7 +815,7 @@ static bool consumer_del(struct uprobe *uprobe, struct uprobe_consumer *uc)
 	down_write(&uprobe->consumer_rwsem);
 	for (con = &uprobe->consumers; *con; con = &(*con)->next) {
 		if (*con == uc) {
-			*con = uc->next;
+			rcu_assign_pointer(*con, uc->next);
 			ret = true;
 			break;
 		}
@@ -857,7 +901,7 @@ static int prepare_uprobe(struct uprobe *uprobe, struct file *file,
 	smp_wmb(); /* pairs with the smp_rmb() in handle_swbp() */
 	set_bit(UPROBE_COPY_INSN, &uprobe->flags);
 
- out:
+out:
 	up_write(&uprobe->consumer_rwsem);
 
 	return ret;
@@ -936,7 +980,9 @@ static void delete_uprobe(struct uprobe *uprobe)
 		return;
 
 	write_lock(&uprobes_treelock);
+	write_seqcount_begin(&uprobes_seqcount);
 	rb_erase(&uprobe->rb_node, &uprobes_tree);
+	write_seqcount_end(&uprobes_seqcount);
 	write_unlock(&uprobes_treelock);
 	RB_CLEAR_NODE(&uprobe->rb_node); /* for uprobe_is_active() */
 	put_uprobe(uprobe);
@@ -965,7 +1011,7 @@ build_map_info(struct address_space *mapping, loff_t offset, bool is_register)
 	struct map_info *info;
 	int more = 0;
 
- again:
+again:
 	i_mmap_lock_read(mapping);
 	vma_interval_tree_foreach(vma, &mapping->i_mmap, pgoff, pgoff) {
 		if (!valid_vma(vma, is_register))
@@ -1019,7 +1065,7 @@ build_map_info(struct address_space *mapping, loff_t offset, bool is_register)
 	} while (--more);
 
 	goto again;
- out:
+out:
 	while (prev)
 		prev = free_map_info(prev);
 	return curr;
@@ -1068,13 +1114,13 @@ register_for_each_vma(struct uprobe *uprobe, struct uprobe_consumer *new)
 				err |= remove_breakpoint(uprobe, mm, info->vaddr);
 		}
 
- unlock:
+unlock:
 		mmap_write_unlock(mm);
- free:
+free:
 		mmput(mm);
 		info = free_map_info(info);
 	}
- out:
+out:
 	percpu_up_write(&dup_mmap_sem);
 	return err;
 }
@@ -1101,16 +1147,17 @@ __uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
  */
 void uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consumer *uc)
 {
-	struct uprobe *uprobe;
+	scoped_guard (srcu, &uprobe_srcu) {
+		struct uprobe *uprobe = find_uprobe(inode, offset);
+		if (WARN_ON(!uprobe))
+			return;
 
-	uprobe = find_uprobe(inode, offset);
-	if (WARN_ON(!uprobe))
-		return;
+		mutex_lock(&uprobe->register_mutex);
+		__uprobe_unregister(uprobe, uc);
+		mutex_unlock(&uprobe->register_mutex);
+	}
 
-	down_write(&uprobe->register_rwsem);
-	__uprobe_unregister(uprobe, uc);
-	up_write(&uprobe->register_rwsem);
-	put_uprobe(uprobe);
+	synchronize_srcu(&uprobe_srcu); // XXX amortize / batch
 }
 EXPORT_SYMBOL_GPL(uprobe_unregister);
 
@@ -1159,7 +1206,7 @@ static int __uprobe_register(struct inode *inode, loff_t offset,
 	if (!IS_ALIGNED(ref_ctr_offset, sizeof(short)))
 		return -EINVAL;
 
- retry:
+retry:
 	uprobe = alloc_uprobe(inode, offset, ref_ctr_offset);
 	if (!uprobe)
 		return -ENOMEM;
@@ -1170,7 +1217,7 @@ static int __uprobe_register(struct inode *inode, loff_t offset,
 	 * We can race with uprobe_unregister()->delete_uprobe().
 	 * Check uprobe_is_active() and retry if it is false.
 	 */
-	down_write(&uprobe->register_rwsem);
+	mutex_lock(&uprobe->register_mutex);
 	ret = -EAGAIN;
 	if (likely(uprobe_is_active(uprobe))) {
 		consumer_add(uprobe, uc);
@@ -1178,7 +1225,7 @@ static int __uprobe_register(struct inode *inode, loff_t offset,
 		if (ret)
 			__uprobe_unregister(uprobe, uc);
 	}
-	up_write(&uprobe->register_rwsem);
+	mutex_unlock(&uprobe->register_mutex);
 	put_uprobe(uprobe);
 
 	if (unlikely(ret == -EAGAIN))
@@ -1214,17 +1261,18 @@ int uprobe_apply(struct inode *inode, loff_t offset,
 	struct uprobe_consumer *con;
 	int ret = -ENOENT;
 
+	guard(srcu)(&uprobe_srcu);
+
 	uprobe = find_uprobe(inode, offset);
 	if (WARN_ON(!uprobe))
 		return ret;
 
-	down_write(&uprobe->register_rwsem);
+	mutex_lock(&uprobe->register_mutex);
 	for (con = uprobe->consumers; con && con != uc ; con = con->next)
 		;
 	if (con)
 		ret = register_for_each_vma(uprobe, add ? uc : NULL);
-	up_write(&uprobe->register_rwsem);
-	put_uprobe(uprobe);
+	mutex_unlock(&uprobe->register_mutex);
 
 	return ret;
 }
@@ -1468,7 +1516,7 @@ static int xol_add_vma(struct mm_struct *mm, struct xol_area *area)
 	ret = 0;
 	/* pairs with get_xol_area() */
 	smp_store_release(&mm->uprobes_state.xol_area, area); /* ^^^ */
- fail:
+fail:
 	mmap_write_unlock(mm);
 
 	return ret;
@@ -1512,7 +1560,7 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
 	kfree(area->bitmap);
  free_area:
 	kfree(area);
- out:
+out:
 	return NULL;
 }
 
@@ -1700,7 +1748,7 @@ unsigned long uprobe_get_trap_addr(struct pt_regs *regs)
 static struct return_instance *free_ret_instance(struct return_instance *ri)
 {
 	struct return_instance *next = ri->next;
-	put_uprobe(ri->uprobe);
+	srcu_read_unlock(&uretprobe_srcu, ri->srcu_idx);
 	kfree(ri);
 	return next;
 }
@@ -1718,7 +1766,7 @@ void uprobe_free_utask(struct task_struct *t)
 		return;
 
 	if (utask->active_uprobe)
-		put_uprobe(utask->active_uprobe);
+		srcu_read_unlock(&uretprobe_srcu, utask->active_srcu_idx);
 
 	ri = utask->return_instances;
 	while (ri)
@@ -1761,7 +1809,7 @@ static int dup_utask(struct task_struct *t, struct uprobe_task *o_utask)
 			return -ENOMEM;
 
 		*n = *o;
-		get_uprobe(n->uprobe);
+		__srcu_read_clone_lock(&uretprobe_srcu, n->srcu_idx);
 		n->next = NULL;
 
 		*p = n;
@@ -1904,7 +1952,8 @@ static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs)
 		orig_ret_vaddr = utask->return_instances->orig_ret_vaddr;
 	}
 
-	ri->uprobe = get_uprobe(uprobe);
+	ri->srcu_idx = srcu_read_lock(&uretprobe_srcu);
+	ri->uprobe = uprobe;
 	ri->func = instruction_pointer(regs);
 	ri->stack = user_stack_pointer(regs);
 	ri->orig_ret_vaddr = orig_ret_vaddr;
@@ -1915,7 +1964,7 @@ static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs)
 	utask->return_instances = ri;
 
 	return;
- fail:
+fail:
 	kfree(ri);
 }
 
@@ -1944,6 +1993,7 @@ pre_ssout(struct uprobe *uprobe, struct pt_regs *regs, unsigned long bp_vaddr)
 		return err;
 	}
 
+	utask->active_srcu_idx = srcu_read_lock(&uretprobe_srcu);
 	utask->active_uprobe = uprobe;
 	utask->state = UTASK_SSTEP;
 	return 0;
@@ -2031,7 +2081,7 @@ static int is_trap_at_addr(struct mm_struct *mm, unsigned long vaddr)
 
 	copy_from_page(page, vaddr, &opcode, UPROBE_SWBP_INSN_SIZE);
 	put_page(page);
- out:
+out:
 	/* This needs to return true for any variant of the trap insn */
 	return is_trap_insn(&opcode);
 }
@@ -2071,8 +2121,9 @@ static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
 	int remove = UPROBE_HANDLER_REMOVE;
 	bool need_prep = false; /* prepare return uprobe, when needed */
 
-	down_read(&uprobe->register_rwsem);
-	for (uc = uprobe->consumers; uc; uc = uc->next) {
+	lockdep_assert(srcu_read_lock_held(&uprobe_srcu));
+
+	for (uc = rcu_dereference_raw(uprobe->consumers); uc; uc = rcu_dereference(uc->next)) {
 		int rc = 0;
 
 		if (uc->handler) {
@@ -2094,7 +2145,6 @@ static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
 		WARN_ON(!uprobe_is_active(uprobe));
 		unapply_uprobe(uprobe, current->mm);
 	}
-	up_read(&uprobe->register_rwsem);
 }
 
 static void
@@ -2103,12 +2153,12 @@ handle_uretprobe_chain(struct return_instance *ri, struct pt_regs *regs)
 	struct uprobe *uprobe = ri->uprobe;
 	struct uprobe_consumer *uc;
 
-	down_read(&uprobe->register_rwsem);
-	for (uc = uprobe->consumers; uc; uc = uc->next) {
+	guard(srcu)(&uprobe_srcu);
+
+	for (uc = rcu_dereference_raw(uprobe->consumers); uc; uc = rcu_dereference_raw(uc->next)) {
 		if (uc->ret_handler)
 			uc->ret_handler(uc, ri->func, regs);
 	}
-	up_read(&uprobe->register_rwsem);
 }
 
 static struct return_instance *find_next_ret_chain(struct return_instance *ri)
@@ -2159,7 +2209,7 @@ static void handle_trampoline(struct pt_regs *regs)
 	utask->return_instances = ri;
 	return;
 
- sigill:
+sigill:
 	uprobe_warn(current, "handle uretprobe, sending SIGILL.");
 	force_sig(SIGILL);
 
@@ -2190,6 +2240,8 @@ static void handle_swbp(struct pt_regs *regs)
 	if (bp_vaddr == get_trampoline_vaddr())
 		return handle_trampoline(regs);
 
+	guard(srcu)(&uprobe_srcu);
+
 	uprobe = find_active_uprobe(bp_vaddr, &is_swbp);
 	if (!uprobe) {
 		if (is_swbp > 0) {
@@ -2218,7 +2270,7 @@ static void handle_swbp(struct pt_regs *regs)
 	 * new and not-yet-analyzed uprobe at the same address, restart.
 	 */
 	if (unlikely(!test_bit(UPROBE_COPY_INSN, &uprobe->flags)))
-		goto out;
+		return;
 
 	/*
 	 * Pairs with the smp_wmb() in prepare_uprobe().
@@ -2231,22 +2283,18 @@ static void handle_swbp(struct pt_regs *regs)
 
 	/* Tracing handlers use ->utask to communicate with fetch methods */
 	if (!get_utask())
-		goto out;
+		return;
 
 	if (arch_uprobe_ignore(&uprobe->arch, regs))
-		goto out;
+		return;
 
 	handler_chain(uprobe, regs);
 
 	if (arch_uprobe_skip_sstep(&uprobe->arch, regs))
-		goto out;
+		return;
 
 	if (!pre_ssout(uprobe, regs, bp_vaddr))
 		return;
-
-	/* arch_uprobe_skip_sstep() succeeded, or restart if can't singlestep */
-out:
-	put_uprobe(uprobe);
 }
 
 /*
@@ -2266,7 +2314,7 @@ static void handle_singlestep(struct uprobe_task *utask, struct pt_regs *regs)
 	else
 		WARN_ON_ONCE(1);
 
-	put_uprobe(uprobe);
+	srcu_read_unlock(&uretprobe_srcu, utask->active_srcu_idx);
 	utask->active_uprobe = NULL;
 	utask->state = UTASK_RUNNING;
 	xol_free_insn_slot(current);
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index bc4b58b0204e..d8cda9003da4 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -720,6 +720,11 @@ int __srcu_read_lock(struct srcu_struct *ssp)
 }
 EXPORT_SYMBOL_GPL(__srcu_read_lock);
 
+int __srcu_read_clone_lock(struct srcu_struct *ssp, int idx)
+{
+	this_cpu_inc(ssp->sda->srcu_lock_count[idx].counter);
+}
+
 /*
  * Removes the count for the old reader from the appropriate per-CPU
  * element of the srcu_struct.  Note that this may well be a different

