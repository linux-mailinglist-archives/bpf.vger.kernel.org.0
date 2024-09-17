Return-Path: <bpf+bounces-40025-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD0497AD14
	for <lists+bpf@lfdr.de>; Tue, 17 Sep 2024 10:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 414D81C213AE
	for <lists+bpf@lfdr.de>; Tue, 17 Sep 2024 08:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57A7159583;
	Tue, 17 Sep 2024 08:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFfiV1Km"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37943150990;
	Tue, 17 Sep 2024 08:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726563058; cv=none; b=gukKoY+8kgMklYoXx2GEZXO3tn0pYkJxjr3ueVjG+EWS5+QIaLF14a59TwnCnqLj5j4Ef57HlpLzq9bS39gMlQ2JvCG45ALYUGuH1D6/ulqlsLaz1acAGdKz8x6/H3/GF5wAdtu8Ep8BI+kJM2Cjf1ejqQOtVUM18lhK8G9cu2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726563058; c=relaxed/simple;
	bh=JR4+PChEiP5sPKx8Jrd1JZbjHK18Fun69oiYo6JlQAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TYGTyGEIaVu8Yzj/p9cYIEFUa9wthO/LxpwrTmZornqeup5k3OmIrrZXhcEIURCWGM5c74TIcK1lbQlY2fdGF3oOA1CHAgwIh3a0dU0OTGiXv60SfYpy9SoCDFZ0vqQHKL8MxYXkH3DVKPUEYx/QVAvJdeNtbQiip+oO1i15dKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFfiV1Km; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 842C7C4CEC6;
	Tue, 17 Sep 2024 08:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726563057;
	bh=JR4+PChEiP5sPKx8Jrd1JZbjHK18Fun69oiYo6JlQAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mFfiV1KmeuR9oE8aESJwmV6d8u765QDEM4WZbbGJF/Z34HjwwL+V7KNu54jEbBSSC
	 nafZXsaIYONlnUEu44gfBSDyYXx6KA68I6QoV0t6S5baQffqQelCZodZqj5+u8O/TQ
	 v2JGDgqr9HNEZLjwwvL9gT9KVBwD0OYM6lv1HJmsEbcqvN4nyCTYIDy8cp9/eIr9UP
	 kKhQ2Ylig6t2dE9oqNdy0kBVfaYXxiog5O7397w1b+bvB/kyUaC0xjH/2/GTP5/p6V
	 O55hASNuN3nt6xNetTBBhwUU7FxC8kzuM23NtUznXfHZtuqi8HwNMpTjN+k1B1Bm3E
	 aCWWKtxUfHJHw==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv4 02/14] uprobe: Add support for session consumer
Date: Tue, 17 Sep 2024 10:50:12 +0200
Message-ID: <20240917085024.765883-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240917085024.765883-1-jolsa@kernel.org>
References: <20240917085024.765883-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change allows the uprobe consumer to behave as session which
means that 'handler' and 'ret_handler' callbacks are connected in
a way that allows to:

  - control execution of 'ret_handler' from 'handler' callback
  - share data between 'handler' and 'ret_handler' callbacks

The session concept fits to our common use case where we do filtering
on entry uprobe and based on the result we decide to run the return
uprobe (or not).

It's also convenient to share the data between session callbacks.

To achive this we are adding new return values the uprobe consumer
can return from 'handler' callback:

  UPROBE_HANDLER_IGNORE
  - Ignore 'ret_handler' callback for this consumer.

  UPROBE_HANDLER_IWANTMYCOOKIE
  - Store cookie and pass it to 'ret_handler' (if defined).

We store shared data in the return_consumer object array as part of
the return_instance object. This way the handle_uretprobe_chain can
find related return_consumer and its shared data.

We also store entry handler return value, for cases when there are
multiple consumers on single uprobe and some of them are ignored and
some of them not, in which case the return probe gets installed and
we need to have a way to find out which consumer needs to be ignored.

The tricky part is when consumer is registered 'after' the uprobe
entry handler is hit. In such case this consumer's 'ret_handler' gets
executed as well, but it won't have the proper data pointer set,
so we can filter it out.

Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/uprobes.h |  25 ++++++-
 kernel/events/uprobes.c | 150 ++++++++++++++++++++++++++++++++--------
 2 files changed, 144 insertions(+), 31 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index bb265a632b91..751b1dd4abe9 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -23,8 +23,20 @@ struct inode;
 struct notifier_block;
 struct page;
 
+/*
+ * Allowed return values from uprobe consumer's handler callback
+ * with following meaning:
+ *
+ * UPROBE_HANDLER_REMOVE
+ * - Remove the uprobe breakpoint from current->mm.
+ * UPROBE_HANDLER_IGNORE
+ * - Ignore ret_handler callback for this consumer.
+ * UPROBE_HANDLER_IWANTMYCOOKIE
+ * - Store cookie and pass it to ret_handler (if defined).
+ */
 #define UPROBE_HANDLER_REMOVE		1
-#define UPROBE_HANDLER_MASK		1
+#define UPROBE_HANDLER_IGNORE		2
+#define UPROBE_HANDLER_IWANTMYCOOKIE	3
 
 #define MAX_URETPROBE_DEPTH		64
 
@@ -44,6 +56,8 @@ struct uprobe_consumer {
 	bool (*filter)(struct uprobe_consumer *self, struct mm_struct *mm);
 
 	struct list_head cons_node;
+
+	__u64 id;	/* set when uprobe_consumer is registered */
 };
 
 #ifdef CONFIG_UPROBES
@@ -83,14 +97,23 @@ struct uprobe_task {
 	unsigned int			depth;
 };
 
+struct return_consumer {
+	__u64	cookie;
+	__u64	id;
+	int	rc;
+};
+
 struct return_instance {
 	struct uprobe		*uprobe;
 	unsigned long		func;
 	unsigned long		stack;		/* stack pointer */
 	unsigned long		orig_ret_vaddr; /* original return address */
 	bool			chained;	/* true, if instance is nested */
+	int			consumers_cnt;
 
 	struct return_instance	*next;		/* keep as stack */
+
+	struct return_consumer	consumers[] __counted_by(consumers_cnt);
 };
 
 enum rp_check {
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 4b7e590dc428..5d376cc9a983 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -65,7 +65,7 @@ struct uprobe {
 	struct rcu_head		rcu;
 	loff_t			offset;
 	loff_t			ref_ctr_offset;
-	unsigned long		flags;
+	unsigned long		flags;		/* "unsigned long" so bitops work */
 
 	/*
 	 * The generic code assumes that it has two members of unknown type
@@ -826,8 +826,11 @@ static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset,
 
 static void consumer_add(struct uprobe *uprobe, struct uprobe_consumer *uc)
 {
+	static atomic64_t id;
+
 	down_write(&uprobe->consumer_rwsem);
 	list_add_rcu(&uc->cons_node, &uprobe->consumers);
+	uc->id = (__u64) atomic64_inc_return(&id);
 	up_write(&uprobe->consumer_rwsem);
 }
 
@@ -1786,6 +1789,34 @@ static struct uprobe_task *get_utask(void)
 	return current->utask;
 }
 
+static size_t ri_size(int consumers_cnt)
+{
+	struct return_instance *ri;
+
+	return sizeof(*ri) + sizeof(ri->consumers[0]) * consumers_cnt;
+}
+
+#define DEF_CNT 4
+
+static struct return_instance *alloc_return_instance(void)
+{
+	struct return_instance *ri;
+
+	ri = kzalloc(ri_size(DEF_CNT), GFP_KERNEL);
+	if (!ri)
+		return ZERO_SIZE_PTR;
+
+	ri->consumers_cnt = DEF_CNT;
+	return ri;
+}
+
+static struct return_instance *dup_return_instance(struct return_instance *old)
+{
+	size_t size = ri_size(old->consumers_cnt);
+
+	return kmemdup(old, size, GFP_KERNEL);
+}
+
 static int dup_utask(struct task_struct *t, struct uprobe_task *o_utask)
 {
 	struct uprobe_task *n_utask;
@@ -1798,11 +1829,10 @@ static int dup_utask(struct task_struct *t, struct uprobe_task *o_utask)
 
 	p = &n_utask->return_instances;
 	for (o = o_utask->return_instances; o; o = o->next) {
-		n = kmalloc(sizeof(struct return_instance), GFP_KERNEL);
+		n = dup_return_instance(o);
 		if (!n)
 			return -ENOMEM;
 
-		*n = *o;
 		/*
 		 * uprobe's refcnt has to be positive at this point, kept by
 		 * utask->return_instances items; return_instances can't be
@@ -1895,39 +1925,35 @@ static void cleanup_return_instances(struct uprobe_task *utask, bool chained,
 	utask->return_instances = ri;
 }
 
-static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs)
+static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs,
+			      struct return_instance *ri)
 {
-	struct return_instance *ri;
 	struct uprobe_task *utask;
 	unsigned long orig_ret_vaddr, trampoline_vaddr;
 	bool chained;
 
 	if (!get_xol_area())
-		return;
+		goto free;
 
 	utask = get_utask();
 	if (!utask)
-		return;
+		goto free;
 
 	if (utask->depth >= MAX_URETPROBE_DEPTH) {
 		printk_ratelimited(KERN_INFO "uprobe: omit uretprobe due to"
 				" nestedness limit pid/tgid=%d/%d\n",
 				current->pid, current->tgid);
-		return;
+		goto free;
 	}
 
 	/* we need to bump refcount to store uprobe in utask */
 	if (!try_get_uprobe(uprobe))
-		return;
-
-	ri = kmalloc(sizeof(struct return_instance), GFP_KERNEL);
-	if (!ri)
-		goto fail;
+		goto free;
 
 	trampoline_vaddr = uprobe_get_trampoline_vaddr();
 	orig_ret_vaddr = arch_uretprobe_hijack_return_addr(trampoline_vaddr, regs);
 	if (orig_ret_vaddr == -1)
-		goto fail;
+		goto put;
 
 	/* drop the entries invalidated by longjmp() */
 	chained = (orig_ret_vaddr == trampoline_vaddr);
@@ -1945,7 +1971,7 @@ static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs)
 			 * attack from user-space.
 			 */
 			uprobe_warn(current, "handle tail call");
-			goto fail;
+			goto put;
 		}
 		orig_ret_vaddr = utask->return_instances->orig_ret_vaddr;
 	}
@@ -1960,9 +1986,10 @@ static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs)
 	utask->return_instances = ri;
 
 	return;
-fail:
-	kfree(ri);
+put:
 	put_uprobe(uprobe);
+free:
+	kfree(ri);
 }
 
 /* Prepare to single-step probed instruction out of line. */
@@ -2114,35 +2141,94 @@ static struct uprobe *find_active_uprobe_rcu(unsigned long bp_vaddr, int *is_swb
 	return uprobe;
 }
 
+static struct return_instance*
+push_consumer(struct return_instance *ri, int idx, __u64 id, __u64 cookie, int rc)
+{
+	if (unlikely(ri == ZERO_SIZE_PTR))
+		return ri;
+
+	if (unlikely(idx >= ri->consumers_cnt)) {
+		struct return_instance *old_ri = ri;
+
+		ri->consumers_cnt += DEF_CNT;
+		ri = krealloc(old_ri, ri_size(old_ri->consumers_cnt), GFP_KERNEL);
+		if (!ri) {
+			kfree(old_ri);
+			return ZERO_SIZE_PTR;
+		}
+	}
+
+	ri->consumers[idx].id = id;
+	ri->consumers[idx].cookie = cookie;
+	ri->consumers[idx].rc = rc;
+	return ri;
+}
+
+static struct return_consumer *
+return_consumer_find(struct return_instance *ri, int *iter, int id)
+{
+	struct return_consumer *ric;
+	int idx = *iter;
+
+	for (ric = &ri->consumers[idx]; idx < ri->consumers_cnt; idx++, ric++) {
+		if (ric->id == id) {
+			*iter = idx + 1;
+			return ric;
+		}
+	}
+	return NULL;
+}
+
 static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
 {
 	struct uprobe_consumer *uc;
-	int remove = UPROBE_HANDLER_REMOVE;
-	bool need_prep = false; /* prepare return uprobe, when needed */
-	bool has_consumers = false;
+	bool has_consumers = false, remove = true, ignore = true;
+	struct return_instance *ri = NULL;
+	int push_idx = 0;
 
 	current->utask->auprobe = &uprobe->arch;
 
 	list_for_each_entry_srcu(uc, &uprobe->consumers, cons_node,
 				 srcu_read_lock_held(&uprobes_srcu)) {
+		__u64 cookie = 0;
 		int rc = 0;
 
 		if (uc->handler) {
-			rc = uc->handler(uc, regs);
-			WARN(rc & ~UPROBE_HANDLER_MASK,
+			rc = uc->handler(uc, regs, &cookie);
+			WARN(rc < 0 || rc > 3,
 				"bad rc=0x%x from %ps()\n", rc, uc->handler);
 		}
 
-		if (uc->ret_handler)
-			need_prep = true;
-
-		remove &= rc;
+		remove &= rc == UPROBE_HANDLER_REMOVE;
+		ignore &= rc == UPROBE_HANDLER_IGNORE;
 		has_consumers = true;
+
+		if (!uc->ret_handler || rc == UPROBE_HANDLER_REMOVE)
+			continue;
+
+		/*
+		 * If alloc_return_instance and push_consumer fail, the return probe
+		 * won't be prepared, but we'll finish to execute all entry handlers.
+		 *
+		 * We need to store handler's return value in case the return uprobe
+		 * gets installed and contains consumers that need to be ignored.
+		 */
+		if (!ri)
+			ri = alloc_return_instance();
+
+		if (rc == UPROBE_HANDLER_IWANTMYCOOKIE || rc == UPROBE_HANDLER_IGNORE)
+			ri = push_consumer(ri, push_idx++, uc->id, cookie, rc);
 	}
 	current->utask->auprobe = NULL;
 
-	if (need_prep && !remove)
-		prepare_uretprobe(uprobe, regs); /* put bp at return */
+	if (!ignore && !ZERO_OR_NULL_PTR(ri)) {
+		/*
+		 * The push_idx value has the final number of return consumers,
+		 * and ri->consumers_cnt has number of allocated consumers.
+		 */
+		ri->consumers_cnt = push_idx;
+		prepare_uretprobe(uprobe, regs, ri);
+	}
 
 	if (remove && has_consumers) {
 		down_read(&uprobe->register_rwsem);
@@ -2161,14 +2247,18 @@ static void
 handle_uretprobe_chain(struct return_instance *ri, struct pt_regs *regs)
 {
 	struct uprobe *uprobe = ri->uprobe;
+	struct return_consumer *ric;
 	struct uprobe_consumer *uc;
-	int srcu_idx;
+	int srcu_idx, ric_idx = 0;
 
 	srcu_idx = srcu_read_lock(&uprobes_srcu);
 	list_for_each_entry_srcu(uc, &uprobe->consumers, cons_node,
 				 srcu_read_lock_held(&uprobes_srcu)) {
+		ric = return_consumer_find(ri, &ric_idx, uc->id);
+		if (ric && ric->rc == UPROBE_HANDLER_IGNORE)
+			continue;
 		if (uc->ret_handler)
-			uc->ret_handler(uc, ri->func, regs);
+			uc->ret_handler(uc, ri->func, regs, ric ? &ric->cookie : NULL);
 	}
 	srcu_read_unlock(&uprobes_srcu, srcu_idx);
 }
-- 
2.46.0


