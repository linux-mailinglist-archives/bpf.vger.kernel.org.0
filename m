Return-Path: <bpf+bounces-39270-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C439971013
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 09:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8BDC282B80
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 07:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598671B1420;
	Mon,  9 Sep 2024 07:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gr/TFYwI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6EA1B140D;
	Mon,  9 Sep 2024 07:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725867972; cv=none; b=nH37quH+EASS32Qs8V6N0AjorEh9B2lMP0lXAae2wGoCCDWR5NUyRFGgk3PPQ9nKldQxMFU+ajUf+IVHR0cPfbYXNZ7msve3OK0/TER4SIgwSmL5c7iZJ/yucGuDJncJ2aFLtwZyWHNmAT3NHbbtgZDRzZT+EsSeAQkc8JeW5AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725867972; c=relaxed/simple;
	bh=jC2UKcAqriOc1B/CfeqJAZ75rwjnIUIWAZWKK2ISpck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HLzqv8lWNjHS/fyzDbWE9ICk9GyIY32JfXT1UhYdJa0LP0RiPSR4Cd8l04SxbCRpHIvcn/h8m1L2n/lcrzRqR/wQT2DlHr3qIIKyX2sjBj1SUKkebwhGfQq/FiQ558CARbdM7Bb+rMXm79zLK5Exb2JF17raiGLaFVRSZBgDmzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gr/TFYwI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B12AC4CEC8;
	Mon,  9 Sep 2024 07:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725867972;
	bh=jC2UKcAqriOc1B/CfeqJAZ75rwjnIUIWAZWKK2ISpck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gr/TFYwI2hnOL3k1ZKf41vVtIWh0Hj1NgMfVzCVNXF3BBjLSSuKARmScVQDSlL29Z
	 3URDvUhgyNuXC7ROv99wP3DlTFfnIKZfa9liujO9i/das+d0sSZKjqHHUIHPdLjIva
	 iIKrPfWap/bUl3MgzazEQBcjDK5oJYZXNQGDAs+RfSOeiaJR27bsp2wRqDVFzvCWNW
	 /U04Hc7Nk2IB8+ML/0zHbnuuXSIOPbatEzTpWfc4LgluKvAL+i23PFwnUc3dGj4QqO
	 RatvE6TSTliClwbLukEKDq94utglqDkgnX/quCaVE92khmXKmx5duEK/rd6k9scAD/
	 Se7Fs+T5wPyGA==
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
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv3 1/7] uprobe: Add support for session consumer
Date: Mon,  9 Sep 2024 09:45:48 +0200
Message-ID: <20240909074554.2339984-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240909074554.2339984-1-jolsa@kernel.org>
References: <20240909074554.2339984-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding support for uprobe consumer to be defined as session and have
new behaviour for consumer's 'handler' and 'ret_handler' callbacks.

The session means that 'handler' and 'ret_handler' callbacks are
connected in a way that allows to:

  - control execution of 'ret_handler' from 'handler' callback
  - share data between 'handler' and 'ret_handler' callbacks

The session is enabled by setting new 'session' bool field to true
in uprobe_consumer object.

We use return_consumer object to keep track of consumers with
'ret_handler'. This object also carries the shared data between
'handler' and and 'ret_handler' callbacks.

The control of 'ret_handler' callback execution is done via return
value of the 'handler' callback. This patch adds new 'ret_handler'
return value (2) which means to ignore ret_handler callback.

Actions on 'handler' callback return values are now:

  0 - execute ret_handler (if it's defined)
  1 - remove uprobe
  2 - do nothing (ignore ret_handler)

The session concept fits to our common use case where we do filtering
on entry uprobe and based on the result we decide to run the return
uprobe (or not).

It's also convenient to share the data between session callbacks.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/uprobes.h                       |  17 ++-
 kernel/events/uprobes.c                       | 132 ++++++++++++++----
 kernel/trace/bpf_trace.c                      |   6 +-
 kernel/trace/trace_uprobe.c                   |  12 +-
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |   2 +-
 5 files changed, 133 insertions(+), 36 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 2b294bf1881f..557901e04624 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -24,7 +24,7 @@ struct notifier_block;
 struct page;
 
 #define UPROBE_HANDLER_REMOVE		1
-#define UPROBE_HANDLER_MASK		1
+#define UPROBE_HANDLER_IGNORE		2
 
 #define MAX_URETPROBE_DEPTH		64
 
@@ -37,13 +37,16 @@ struct uprobe_consumer {
 	 * for the current process. If filter() is omitted or returns true,
 	 * UPROBE_HANDLER_REMOVE is effectively ignored.
 	 */
-	int (*handler)(struct uprobe_consumer *self, struct pt_regs *regs);
+	int (*handler)(struct uprobe_consumer *self, struct pt_regs *regs, __u64 *data);
 	int (*ret_handler)(struct uprobe_consumer *self,
 				unsigned long func,
-				struct pt_regs *regs);
+				struct pt_regs *regs, __u64 *data);
 	bool (*filter)(struct uprobe_consumer *self, struct mm_struct *mm);
 
 	struct list_head cons_node;
+	bool session;
+
+	__u64 id;	/* set when uprobe_consumer is registered */
 };
 
 #ifdef CONFIG_UPROBES
@@ -83,14 +86,22 @@ struct uprobe_task {
 	unsigned int			depth;
 };
 
+struct return_consumer {
+	__u64	cookie;
+	__u64	id;
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
index 4b7e590dc428..9e971f86afdf 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -67,6 +67,8 @@ struct uprobe {
 	loff_t			ref_ctr_offset;
 	unsigned long		flags;
 
+	unsigned int		consumers_cnt;
+
 	/*
 	 * The generic code assumes that it has two members of unknown type
 	 * owned by the arch-specific code:
@@ -826,8 +828,12 @@ static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset,
 
 static void consumer_add(struct uprobe *uprobe, struct uprobe_consumer *uc)
 {
+	static atomic64_t id;
+
 	down_write(&uprobe->consumer_rwsem);
 	list_add_rcu(&uc->cons_node, &uprobe->consumers);
+	uc->id = (__u64) atomic64_inc_return(&id);
+	uprobe->consumers_cnt++;
 	up_write(&uprobe->consumer_rwsem);
 }
 
@@ -839,6 +845,7 @@ static void consumer_del(struct uprobe *uprobe, struct uprobe_consumer *uc)
 {
 	down_write(&uprobe->consumer_rwsem);
 	list_del_rcu(&uc->cons_node);
+	uprobe->consumers_cnt--;
 	up_write(&uprobe->consumer_rwsem);
 }
 
@@ -1786,6 +1793,30 @@ static struct uprobe_task *get_utask(void)
 	return current->utask;
 }
 
+static size_t ri_size(int consumers_cnt)
+{
+	struct return_instance *ri;
+
+	return sizeof(*ri) + sizeof(ri->consumers[0]) * consumers_cnt;
+}
+
+static struct return_instance *alloc_return_instance(int consumers_cnt)
+{
+	struct return_instance *ri;
+
+	ri = kzalloc(ri_size(consumers_cnt), GFP_KERNEL);
+	if (ri)
+		ri->consumers_cnt = consumers_cnt;
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
@@ -2114,35 +2141,78 @@ static struct uprobe *find_active_uprobe_rcu(unsigned long bp_vaddr, int *is_swb
 	return uprobe;
 }
 
+static struct return_consumer *
+return_consumer_next(struct return_instance *ri, struct return_consumer *ric)
+{
+	return ric ? ric + 1 : &ri->consumers[0];
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
 	int remove = UPROBE_HANDLER_REMOVE;
-	bool need_prep = false; /* prepare return uprobe, when needed */
+	struct return_consumer *ric = NULL;
+	struct return_instance *ri = NULL;
 	bool has_consumers = false;
 
 	current->utask->auprobe = &uprobe->arch;
 
 	list_for_each_entry_srcu(uc, &uprobe->consumers, cons_node,
 				 srcu_read_lock_held(&uprobes_srcu)) {
+		__u64 cookie = 0;
 		int rc = 0;
 
 		if (uc->handler) {
-			rc = uc->handler(uc, regs);
-			WARN(rc & ~UPROBE_HANDLER_MASK,
+			rc = uc->handler(uc, regs, &cookie);
+			WARN(rc < 0 || rc > 2,
 				"bad rc=0x%x from %ps()\n", rc, uc->handler);
 		}
 
-		if (uc->ret_handler)
-			need_prep = true;
-
+		/*
+		 * The handler can return following values:
+		 * 0 - execute ret_handler (if it's defined)
+		 * 1 - remove uprobe
+		 * 2 - do nothing (ignore ret_handler)
+		 */
 		remove &= rc;
 		has_consumers = true;
+
+		if (rc == 0 && uc->ret_handler) {
+			/*
+			 * Preallocate return_instance object optimistically with
+			 * all possible consumers, so we allocate just once.
+			 */
+			if (!ri) {
+				ri = alloc_return_instance(uprobe->consumers_cnt);
+				if (!ri)
+					return;
+			}
+			ric = return_consumer_next(ri, ric);
+			ric->cookie = cookie;
+			ric->id = uc->id;
+		}
 	}
 	current->utask->auprobe = NULL;
 
-	if (need_prep && !remove)
-		prepare_uretprobe(uprobe, regs); /* put bp at return */
+	if (ri && !remove)
+		prepare_uretprobe(uprobe, regs, ri); /* put bp at return */
+	else
+		kfree(ri);
 
 	if (remove && has_consumers) {
 		down_read(&uprobe->register_rwsem);
@@ -2160,15 +2230,25 @@ static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
 static void
 handle_uretprobe_chain(struct return_instance *ri, struct pt_regs *regs)
 {
+	struct return_consumer *ric = NULL;
 	struct uprobe *uprobe = ri->uprobe;
 	struct uprobe_consumer *uc;
-	int srcu_idx;
+	int srcu_idx, iter = 0;
 
 	srcu_idx = srcu_read_lock(&uprobes_srcu);
 	list_for_each_entry_srcu(uc, &uprobe->consumers, cons_node,
 				 srcu_read_lock_held(&uprobes_srcu)) {
+		/*
+		 * If we don't find return consumer, it means uprobe consumer
+		 * was added after we hit uprobe and return consumer did not
+		 * get registered in which case we call the ret_handler only
+		 * if it's not session consumer.
+		 */
+		ric = return_consumer_find(ri, &iter, uc->id);
+		if (!ric && uc->session)
+			continue;
 		if (uc->ret_handler)
-			uc->ret_handler(uc, ri->func, regs);
+			uc->ret_handler(uc, ri->func, regs, ric ? &ric->cookie : NULL);
 	}
 	srcu_read_unlock(&uprobes_srcu, srcu_idx);
 }
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index ac0a01cc8634..de241503c8fb 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3332,7 +3332,8 @@ uprobe_multi_link_filter(struct uprobe_consumer *con, struct mm_struct *mm)
 }
 
 static int
-uprobe_multi_link_handler(struct uprobe_consumer *con, struct pt_regs *regs)
+uprobe_multi_link_handler(struct uprobe_consumer *con, struct pt_regs *regs,
+			  __u64 *data)
 {
 	struct bpf_uprobe *uprobe;
 
@@ -3341,7 +3342,8 @@ uprobe_multi_link_handler(struct uprobe_consumer *con, struct pt_regs *regs)
 }
 
 static int
-uprobe_multi_link_ret_handler(struct uprobe_consumer *con, unsigned long func, struct pt_regs *regs)
+uprobe_multi_link_ret_handler(struct uprobe_consumer *con, unsigned long func, struct pt_regs *regs,
+			      __u64 *data)
 {
 	struct bpf_uprobe *uprobe;
 
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index f7443e996b1b..11103dde897b 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -88,9 +88,11 @@ static struct trace_uprobe *to_trace_uprobe(struct dyn_event *ev)
 static int register_uprobe_event(struct trace_uprobe *tu);
 static int unregister_uprobe_event(struct trace_uprobe *tu);
 
-static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs);
+static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs,
+			     __u64 *data);
 static int uretprobe_dispatcher(struct uprobe_consumer *con,
-				unsigned long func, struct pt_regs *regs);
+				unsigned long func, struct pt_regs *regs,
+				__u64 *data);
 
 #ifdef CONFIG_STACK_GROWSUP
 static unsigned long adjust_stack_addr(unsigned long addr, unsigned int n)
@@ -1500,7 +1502,8 @@ trace_uprobe_register(struct trace_event_call *event, enum trace_reg type,
 	}
 }
 
-static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs)
+static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs,
+			     __u64 *data)
 {
 	struct trace_uprobe *tu;
 	struct uprobe_dispatch_data udd;
@@ -1530,7 +1533,8 @@ static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs)
 }
 
 static int uretprobe_dispatcher(struct uprobe_consumer *con,
-				unsigned long func, struct pt_regs *regs)
+				unsigned long func, struct pt_regs *regs,
+				__u64 *data)
 {
 	struct trace_uprobe *tu;
 	struct uprobe_dispatch_data udd;
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 1fc16657cf42..e91ff5b285f0 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -421,7 +421,7 @@ static struct bin_attribute bin_attr_bpf_testmod_file __ro_after_init = {
 
 static int
 uprobe_ret_handler(struct uprobe_consumer *self, unsigned long func,
-		   struct pt_regs *regs)
+		   struct pt_regs *regs, __u64 *data)
 
 {
 	regs->ax  = 0x12345678deadbeef;
-- 
2.46.0


