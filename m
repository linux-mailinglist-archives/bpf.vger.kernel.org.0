Return-Path: <bpf+bounces-32966-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80256915AF1
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 02:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2C70B21AF5
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 00:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471A579F5;
	Tue, 25 Jun 2024 00:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPoKI0cA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB69823DE;
	Tue, 25 Jun 2024 00:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719274925; cv=none; b=HPKw/cNMFJLqD6/IkY3J1pTNBo++adQ9ax9G2pi0LmWn/9QCRWcxBoOERTEoqQ9s6CBtxAHZlrsoPtsDkJMMHudyw04xp44v7l23zQJb51O3Aip13PFAeUQARl1HRcrKpCzYW6REZpOUxMW06RDFi4wa1vvH+vHg4xCsmF1w4Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719274925; c=relaxed/simple;
	bh=u7yq854ZMDxLkGfqVgOAarfP4NZ3fr5q6kPwQkFd7Jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YGF9jbr9JhF3jwSZ3m5SRgJuOtYTsSVf7Dcc3HmEVzDsNBla6PPOpW419B0he9LREEJ1n+G5cVEF1lOgKHZ4Y4WWivUQG9hJEZ/0bgAgtgxPe6WRcZcVY82UmkVzP+pNtq+p2+xPdkRh+VjV4QjWfEmBltzRpvwSzqxOcMtXoMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPoKI0cA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A500C2BBFC;
	Tue, 25 Jun 2024 00:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719274925;
	bh=u7yq854ZMDxLkGfqVgOAarfP4NZ3fr5q6kPwQkFd7Jk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MPoKI0cAhsTSXQbLW8O9lYeGs0LPbMoM2/92ZoOoFXLY6pzzf7/Wo3+PyW007CH7f
	 CoXA3zjQGBLRkdDi6qNNCHmsK+DgWV34Km7sye1TLfI0eoje2ZroSnJywGHiELfAgx
	 y/yAx7p8lEFZMMxPbLGNnqP49zg5zF+ObHWsO82Zi/lZktl1KRith3wEz1AwIFhOeZ
	 GFCz8/fV+kmiSrM1qUxYh+ga5BXiAa9YLJKe2CuicYsEvxycDMZtSaYF93Q8J7x7X8
	 qQJA1K35ZOLkkWTzGQArSzQvbrhHmIPROTOboZYeNTsbeS0Dv9aTVUYs/rlLfLv6LK
	 v9Fc1WcCU7UQA==
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
Subject: [PATCH 04/12] uprobes: revamp uprobe refcounting and lifetime management
Date: Mon, 24 Jun 2024 17:21:36 -0700
Message-ID: <20240625002144.3485799-5-andrii@kernel.org>
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

The uprobe_tree's extra refcount of 1 is problematic and inconvenient.
Because of it, we have extra retry logic in uprobe_register(), and we
have an extra logic in __uprobe_unregister(), which checks that uprobe
has no more consumers, and if that's the case, it removes struct uprobe
from uprobes_tree (through delete_uprobe(), which takes writer lock on
uprobes_tree), decrementing refcount after that. The latter is the
source of unfortunate race with uprobe_register, necessitating retries.

All of the above is a complication that makes adding batched uprobe
registration/unregistration APIs hard, and generally makes following the
logic harder.

This patch changes refcounting scheme in such a way as to not have
uprobes_tree keeping extra refcount for struct uprobe. Instead,
uprobe_consumer is assuming this extra refcount, which will be dropped
when consumer is unregistered. Other than that, all the active users of
uprobe (entry and return uprobe handling code) keeps exactly the same
refcounting approach.

With the above setup, once uprobe's refcount drops to zero, we need to
make sure that uprobe's "destructor" removes uprobe from uprobes_tree,
of course. This, though, races with uprobe entry handling code in
handle_swbp(), which, though find_active_uprobe()->find_uprobe() lookup
can race with uprobe being destroyed after refcount drops to zero (e.g.,
due to uprobe_consumer unregistering). This is because
find_active_uprobe() bumps refcount without knowing for sure that
uprobe's refcount is already positive (and it has to be this way, there
is no way around that setup).

One, attempted initially, way to solve this is through using
atomic_inc_not_zero() approach, turning get_uprobe() into
try_get_uprobe(), which can fail to bump refcount if uprobe is already
destined to be destroyed. This, unfortunately, turns out to be a rather
expensive due to underlying cmpxchg() operation in
atomic_inc_not_zero() and scales rather poorly with increased amount of
parallel threads triggering uprobes.

So, we devise a refcounting scheme that doesn't require cmpxchg(),
instead relying only on atomic additions, which scale better and are
faster. While the solution has a bit of a trick to it, all the logic is
nicely compartmentalized in __get_uprobe() and put_uprobe() helpers and
doesn't leak outside of those low-level helpers.

We, effectively, structure uprobe's destruction (i.e., put_uprobe() logic)
in such a way that we support "resurrecting" uprobe by bumping its
refcount from zero back to one, and pretending like it never dropped to
zero in the first place. This is done in a race-free way under
exclusive writer uprobes_treelock. Crucially, we take lock only once
refcount drops to zero. If we had to take lock before decrementing
refcount, the approach would be prohibitively expensive.

Anyways, under exclusive writer lock, we double-check that refcount
didn't change and is still zero. If it is, we proceed with destruction,
because at that point we have a guarantee that find_active_uprobe()
can't successfully look up this uprobe instance, as it's going to be
removed in destructor under writer lock. If, on the other hand,
find_active_uprobe() managed to bump refcount from zero to one in
between put_uprobe()'s atomic_dec_and_test(&uprobe->ref) and
write_lock(&uprobes_treelock), we'll deterministically detect this with
extra atomic_read(&uprobe->ref) check, and if it doesn't hold, we
pretend like atomic_dec_and_test() never returned true. There is no
resource freeing or any other irreversible action taken up till this
point, so we just exit early.

One tricky part in the above is actually two CPUs racing and dropping
refcnt to zero, and then attempting to free resources. This can happen
as follows:
  - CPU #0 drops refcnt from 1 to 0, and proceeds to grab uprobes_treelock;
  - before CPU #0 grabs a lock, CPU #1 updates refcnt as 0 -> 1 -> 0, at
    which point it decides that it needs to free uprobe as well.

At this point both CPU #0 and CPU #1 will believe they need to destroy
uprobe, which is obviously wrong. To prevent this situations, we augment
refcount with epoch counter, which is always incremented by 1 on either
get or put operation. This allows those two CPUs above to disambiguate
who should actually free uprobe (it's the CPU #1, because it has
up-to-date epoch). See comments in the code and note the specific values
of UPROBE_REFCNT_GET and UPROBE_REFCNT_PUT constants. Keep in mind that
a single atomi64_t is actually a two sort-of-independent 32-bit counters
that are incremented/decremented with a single atomic_add_and_return()
operation. Note also a small and extremely rare (and thus having no
effect on performance) need to clear the highest bit every 2 billion
get/put operations to prevent high 32-bit counter from "bleeding over"
into lower 32-bit counter.

All the above contained trickery aside, we end up with a nice semantics
for get and put operations, where get always succeeds and put handles
all the races properly and transparently to the caller.

And just to justify this a bit unorthodox refcounting approach, under
uprobe triggering micro-benchmark (using BPF selftests' bench tool) with
8 triggering threads, atomic_inc_not_zero() approach was producing about
3.3 millions/sec total uprobe triggerings across all threads. While the
final atomic_add_and_return()-based approach managed to get 3.6 millions/sec
throughput under the same 8 competing threads.

Furthermore, CPU profiling showed the following overall CPU usage:
  - try_get_uprobe (19.3%) + put_uprobe (8.2%) = 27.5% CPU usage for
    atomic_inc_not_zero approach;
  - __get_uprobe (12.3%) + put_uprobe (9.9%) = 22.2% CPU usage for
    atomic_add_and_return approach implemented by this patch.

So, CPU is spending relatively more CPU time in get/put operations while
delivering less total throughput if using atomic_inc_not_zero(). And
this will be even more prominent once we optimize away uprobe->register_rwsem
in the subsequent patch sets. So while slightly less straightforward,
current approach seems to be clearly winning and justified.

We also rename get_uprobe() to __get_uprobe() to indicate it's
a delicate internal helper that is only safe to call under valid
circumstances:
  - while holding uprobes_treelock (to synchronize with exclusive write
    lock in put_uprobe(), as described above);
  - or if we have a guarantee that uprobe's refcount is already positive
    through caller holding at least one refcount (in this case there is
    no risk of refcount dropping to zero by any other CPU).

We also document why it's safe to do unconditional __get_uprobe() at all
call sites, to make it clear that we maintain the above invariants.

Note also, we now don't have a race between registration and
unregistration, so we remove the retry logic completely.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/events/uprobes.c | 231 +++++++++++++++++++++++++++++-----------
 1 file changed, 167 insertions(+), 64 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index aa59fa53ae67..8ce669bc6474 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -53,7 +53,7 @@ DEFINE_STATIC_PERCPU_RWSEM(dup_mmap_sem);
 
 struct uprobe {
 	struct rb_node		rb_node;	/* node in the rb tree */
-	refcount_t		ref;
+	atomic64_t		ref;		/* see UPROBE_REFCNT_GET below */
 	struct rw_semaphore	register_rwsem;
 	struct rw_semaphore	consumer_rwsem;
 	struct list_head	pending_list;
@@ -587,15 +587,114 @@ set_orig_insn(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long v
 			*(uprobe_opcode_t *)&auprobe->insn);
 }
 
-static struct uprobe *get_uprobe(struct uprobe *uprobe)
+/*
+ * Uprobe's 64-bit refcount is actually two independent counters co-located in
+ * a single u64 value:
+ *   - lower 32 bits are just a normal refcount with is increment and
+ *   decremented on get and put, respectively, just like normal refcount
+ *   would;
+ *   - upper 32 bits are a tag (or epoch, if you will), which is always
+ *   incremented by one, no matter whether get or put operation is done.
+ *
+ * This upper counter is meant to distinguish between:
+ *   - one CPU dropping refcnt from 1 -> 0 and proceeding with "destruction",
+ *   - while another CPU continuing further meanwhile with 0 -> 1 -> 0 refcnt
+ *   sequence, also proceeding to "destruction".
+ *
+ * In both cases refcount drops to zero, but in one case it will have epoch N,
+ * while the second drop to zero will have a different epoch N + 2, allowing
+ * first destructor to bail out because epoch changed between refcount going
+ * to zero and put_uprobe() taking uprobes_treelock (under which overall
+ * 64-bit refcount is double-checked, see put_uprobe() for details).
+ *
+ * Lower 32-bit counter is not meant to over overflow, while it's expected
+ * that upper 32-bit counter will overflow occasionally. Note, though, that we
+ * can't allow upper 32-bit counter to "bleed over" into lower 32-bit counter,
+ * so whenever epoch counter gets highest bit set to 1, __get_uprobe() and
+ * put_uprobe() will attempt to clear upper bit with cmpxchg(). This makes
+ * epoch effectively a 31-bit counter with highest bit used as a flag to
+ * perform a fix-up. This ensures epoch and refcnt parts do not "interfere".
+ *
+ * UPROBE_REFCNT_GET constant is chosen such that it will *increment both*
+ * epoch and refcnt parts atomically with one atomic_add().
+ * UPROBE_REFCNT_PUT is chosen such that it will *decrement* refcnt part and
+ * *increment* epoch part.
+ */
+#define UPROBE_REFCNT_GET ((1LL << 32) | 1LL)
+#define UPROBE_REFCNT_PUT (0xffffffffLL)
+
+/**
+ * Caller has to make sure that:
+ *   a) either uprobe's refcnt is positive before this call;
+ *   b) or uprobes_treelock is held (doesn't matter if for read or write),
+ *      preventing uprobe's destructor from removing it from uprobes_tree.
+ *
+ * In the latter case, uprobe's destructor will "resurrect" uprobe instance if
+ * it detects that its refcount went back to being positive again inbetween it
+ * dropping to zero at some point and (potentially delayed) destructor
+ * callback actually running.
+ */
+static struct uprobe *__get_uprobe(struct uprobe *uprobe)
 {
-	refcount_inc(&uprobe->ref);
+	s64 v;
+
+	v = atomic64_add_return(UPROBE_REFCNT_GET, &uprobe->ref);
+
+	/*
+	 * If the highest bit is set, we need to clear it. If cmpxchg() fails,
+	 * we don't retry because there is another CPU that just managed to
+	 * update refcnt and will attempt the same "fix up". Eventually one of
+	 * them will succeed to clear highset bit.
+	 */
+	if (unlikely(v < 0))
+		(void)atomic64_cmpxchg(&uprobe->ref, v, v & ~(1ULL << 63));
+
 	return uprobe;
 }
 
+static inline bool uprobe_is_active(struct uprobe *uprobe)
+{
+	return !RB_EMPTY_NODE(&uprobe->rb_node);
+}
+
 static void put_uprobe(struct uprobe *uprobe)
 {
-	if (refcount_dec_and_test(&uprobe->ref)) {
+	s64 v;
+
+	v = atomic64_add_return(UPROBE_REFCNT_PUT, &uprobe->ref);
+
+	if (unlikely((u32)v == 0)) {
+		bool destroy;
+
+		write_lock(&uprobes_treelock);
+		/*
+		 * We might race with find_uprobe()->__get_uprobe() executed
+		 * from inside read-locked uprobes_treelock, which can bump
+		 * refcount from zero back to one, after we got here. Even
+		 * worse, it's possible for another CPU to do 0 -> 1 -> 0
+		 * transition between this CPU doing atomic_add() and taking
+		 * uprobes_treelock. In either case this CPU should bail out
+		 * and not proceed with destruction.
+		 *
+		 * So now that we have exclusive write lock, we double check
+		 * the total 64-bit refcount value, which includes the epoch.
+		 * If nothing changed (i.e., epoch is the same and refcnt is
+		 * still zero), we are good and we proceed with the clean up.
+		 *
+		 * But if it managed to be updated back at least once, we just
+		 * pretend it never went to zero. If lower 32-bit refcnt part
+		 * drops to zero again, another CPU will proceed with
+		 * destruction, due to more up to date epoch.
+		 */
+		destroy = atomic64_read(&uprobe->ref) == v;
+		if (destroy && uprobe_is_active(uprobe))
+			rb_erase(&uprobe->rb_node, &uprobes_tree);
+		write_unlock(&uprobes_treelock);
+
+		/* uprobe got resurrected, pretend we never tried to free it */
+		if (!destroy)
+			return;
+
 		/*
 		 * If application munmap(exec_vma) before uprobe_unregister()
 		 * gets called, we don't get a chance to remove uprobe from
@@ -604,8 +703,19 @@ static void put_uprobe(struct uprobe *uprobe)
 		mutex_lock(&delayed_uprobe_lock);
 		delayed_uprobe_remove(uprobe, NULL);
 		mutex_unlock(&delayed_uprobe_lock);
+
 		kfree(uprobe);
+		return;
 	}
+
+	/*
+	 * If the highest bit is set, we need to clear it. If cmpxchg() fails,
+	 * we don't retry because there is another CPU that just managed to
+	 * update refcnt and will attempt the same "fix up". Eventually one of
+	 * them will succeed to clear highset bit.
+	 */
+	if (unlikely(v < 0))
+		(void)atomic64_cmpxchg(&uprobe->ref, v, v & ~(1ULL << 63));
 }
 
 static __always_inline
@@ -653,12 +763,15 @@ static struct uprobe *__find_uprobe(struct inode *inode, loff_t offset)
 		.inode = inode,
 		.offset = offset,
 	};
-	struct rb_node *node = rb_find(&key, &uprobes_tree, __uprobe_cmp_key);
+	struct rb_node *node;
+	struct uprobe *u = NULL;
 
+	node = rb_find(&key, &uprobes_tree, __uprobe_cmp_key);
 	if (node)
-		return get_uprobe(__node_2_uprobe(node));
+		/* we hold uprobes_treelock, so it's safe to __get_uprobe() */
+		u = __get_uprobe(__node_2_uprobe(node));
 
-	return NULL;
+	return u;
 }
 
 /*
@@ -676,26 +789,37 @@ static struct uprobe *find_uprobe(struct inode *inode, loff_t offset)
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
+	struct uprobe *u = uprobe;
 
 	node = rb_find_add(&uprobe->rb_node, &uprobes_tree, __uprobe_cmp);
 	if (node)
-		return get_uprobe(__node_2_uprobe(node));
+		/* we hold uprobes_treelock, so it's safe to __get_uprobe() */
+		u = __get_uprobe(__node_2_uprobe(node));
 
-	/* get access + creation ref */
-	refcount_set(&uprobe->ref, 2);
-	return NULL;
+	return u;
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
@@ -732,11 +856,13 @@ static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset,
 	uprobe->ref_ctr_offset = ref_ctr_offset;
 	init_rwsem(&uprobe->register_rwsem);
 	init_rwsem(&uprobe->consumer_rwsem);
+	RB_CLEAR_NODE(&uprobe->rb_node);
+	atomic64_set(&uprobe->ref, 1);
 
 	/* add to uprobes_tree, sorted on inode:offset */
 	cur_uprobe = insert_uprobe(uprobe);
 	/* a uprobe exists for this inode:offset combination */
-	if (cur_uprobe) {
+	if (cur_uprobe != uprobe) {
 		if (cur_uprobe->ref_ctr_offset != uprobe->ref_ctr_offset) {
 			ref_ctr_mismatch_warn(cur_uprobe, uprobe);
 			put_uprobe(cur_uprobe);
@@ -921,27 +1047,6 @@ remove_breakpoint(struct uprobe *uprobe, struct mm_struct *mm, unsigned long vad
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
-	put_uprobe(uprobe);
-}
-
 struct map_info {
 	struct map_info *next;
 	struct mm_struct *mm;
@@ -1082,15 +1187,11 @@ register_for_each_vma(struct uprobe *uprobe, struct uprobe_consumer *new)
 static void
 __uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
 {
-	int err;
-
 	if (WARN_ON(!consumer_del(uprobe, uc)))
 		return;
 
-	err = register_for_each_vma(uprobe, NULL);
 	/* TODO : cant unregister? schedule a worker thread */
-	if (!uprobe->consumers && !err)
-		delete_uprobe(uprobe);
+	(void)register_for_each_vma(uprobe, NULL);
 }
 
 /*
@@ -1159,28 +1260,20 @@ static int __uprobe_register(struct inode *inode, loff_t offset,
 	if (!IS_ALIGNED(ref_ctr_offset, sizeof(short)))
 		return -EINVAL;
 
- retry:
 	uprobe = alloc_uprobe(inode, offset, ref_ctr_offset);
 	if (IS_ERR(uprobe))
 		return PTR_ERR(uprobe);
 
-	/*
-	 * We can race with uprobe_unregister()->delete_uprobe().
-	 * Check uprobe_is_active() and retry if it is false.
-	 */
 	down_write(&uprobe->register_rwsem);
-	ret = -EAGAIN;
-	if (likely(uprobe_is_active(uprobe))) {
-		consumer_add(uprobe, uc);
-		ret = register_for_each_vma(uprobe, uc);
-		if (ret)
-			__uprobe_unregister(uprobe, uc);
-	}
+	consumer_add(uprobe, uc);
+	ret = register_for_each_vma(uprobe, uc);
+	if (ret)
+		__uprobe_unregister(uprobe, uc);
 	up_write(&uprobe->register_rwsem);
-	put_uprobe(uprobe);
 
-	if (unlikely(ret == -EAGAIN))
-		goto retry;
+	if (ret)
+		put_uprobe(uprobe);
+
 	return ret;
 }
 
@@ -1303,15 +1396,15 @@ static void build_probe_list(struct inode *inode,
 			u = rb_entry(t, struct uprobe, rb_node);
 			if (u->inode != inode || u->offset < min)
 				break;
+			__get_uprobe(u); /* uprobes_treelock is held */
 			list_add(&u->pending_list, head);
-			get_uprobe(u);
 		}
 		for (t = n; (t = rb_next(t)); ) {
 			u = rb_entry(t, struct uprobe, rb_node);
 			if (u->inode != inode || u->offset > max)
 				break;
+			__get_uprobe(u); /* uprobes_treelock is held */
 			list_add(&u->pending_list, head);
-			get_uprobe(u);
 		}
 	}
 	read_unlock(&uprobes_treelock);
@@ -1769,7 +1862,14 @@ static int dup_utask(struct task_struct *t, struct uprobe_task *o_utask)
 			return -ENOMEM;
 
 		*n = *o;
-		get_uprobe(n->uprobe);
+		/*
+		 * uprobe's refcnt has to be positive at this point, kept by
+		 * utask->return_instances items; return_instances can't be
+		 * removed right now, as task is blocked due to duping; so
+		 * __get_uprobe() is safe to use here without holding
+		 * uprobes_treelock.
+		 */
+		__get_uprobe(n->uprobe);
 		n->next = NULL;
 
 		*p = n;
@@ -1911,8 +2011,11 @@ static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs)
 		}
 		orig_ret_vaddr = utask->return_instances->orig_ret_vaddr;
 	}
-
-	ri->uprobe = get_uprobe(uprobe);
+	 /*
+	  * uprobe's refcnt is positive, held by caller, so it's safe to
+	  * unconditionally bump it one more time here
+	  */
+	ri->uprobe = __get_uprobe(uprobe);
 	ri->func = instruction_pointer(regs);
 	ri->stack = user_stack_pointer(regs);
 	ri->orig_ret_vaddr = orig_ret_vaddr;
-- 
2.43.0


