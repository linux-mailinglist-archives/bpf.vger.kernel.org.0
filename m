Return-Path: <bpf+bounces-31375-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B62258FBCE9
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 22:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23606B247E6
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 20:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CDE14B07D;
	Tue,  4 Jun 2024 20:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HbfnaHg1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E66A14A0AD;
	Tue,  4 Jun 2024 20:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717531368; cv=none; b=rtPQkkupOM5fj6YCIiYuei4D8NEv/EbYFp987YAR7SvfIK+H9bogLtLpGPHWqAsG2Rj+BgJJVZcYSVAFqZ7osbWFyTzMIhktscxuyxpBieUiZj5EFs2IZ5bphljMrDE9+niNaNUyFvx/piaBZPMHM3hCq9axh2BYrr62/NMR9K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717531368; c=relaxed/simple;
	bh=DhP26xmiCYD8Xa0bAOGtxlXv9XJ/IAF50228gAf7JVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QDgZYpVYeSjuuFBQBXNHp8FN8GrGO2tRbFZ2igrJ75JE0qfqB34omwis8iC1bW0WVkr8HVIGJ/WVjJqadRif1hZCZkvC9Gj5bZexkFQKGsh6nSFdk8Okt3OZ6rnsL7h5c5x9cgSQ67X/KNDBHfu/z9d2QPgntlOrDduNwfbWZy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HbfnaHg1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C91D1C2BBFC;
	Tue,  4 Jun 2024 20:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717531368;
	bh=DhP26xmiCYD8Xa0bAOGtxlXv9XJ/IAF50228gAf7JVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HbfnaHg1p545hbvJbRJ0bfSqI36OKWuf/E+KolY5pCHfMofgY5CgLouZ4izkgDfAz
	 CSLW5Fu1ziUyA7ySapYWU5ErtvL5Acfv8n8yYLnIskSxlEjJt3BEOPfVPVlG9IgDaI
	 bjlcfpIFiVhr7hlNAwEYlavevUbdcoYuhtE9z1mDyYj6bATIyxes8F+oX9v4ALE0Ny
	 dIyYQiZl1U2bQksmzS3au+IktCaSXUrt4xxZPzThdWKwBYbuuslLRjZMyXITrRhFDB
	 KyMnu43r3sZxgBF8m7O+ST9VYyMW3GrUlOCJkcKA6qNVXdJiCVUIuzQyqxFwCeic2n
	 brN4aV7VHqBIg==
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
Subject: [RFC bpf-next 01/10] uprobe: Add session callbacks to uprobe_consumer
Date: Tue,  4 Jun 2024 22:02:12 +0200
Message-ID: <20240604200221.377848-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604200221.377848-1-jolsa@kernel.org>
References: <20240604200221.377848-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding new set of callbacks that are triggered on entry and return
uprobe execution for the attached function.

The session means that those callbacks are 'connected' in a way
that allows to:
  - control execution of return callback from entry callback
  - share data between entry and return callbacks

The session concept fits to our common use case where we do filtering
on entry uprobe and based on the result we decide to run the return
uprobe (or not).

It's also convenient to share the data between session callbacks.

The control of return uprobe execution is done via return value of the
entry session callback, where 0 means to install and execute return
uprobe, 1 means to not install.

Current implementation has a restriction that allows to register only
single consumer with session callbacks for a uprobe and also restricting
standard callbacks consumers.

Which means that there can be only single user of a uprobe (inode +
offset) when session consumer is registered to it.

This is because all registered consumers are executed when uprobe or
return uprobe is hit and wihout additional layer (like fgraph's shadow
stack) that would keep the state of the return callback, we have no
way to find out which consumer should be executed.

I'm not sure how big limitation this is for people, our current use
case seems to be ok with that. Fixing this would be more complex/bigger
change to uprobes, thoughts?

Hence sending this as RFC to gather more opinions and feedback.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/uprobes.h | 18 +++++++++++
 kernel/events/uprobes.c | 69 +++++++++++++++++++++++++++++++++++------
 2 files changed, 78 insertions(+), 9 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index f46e0ca0169c..a2f2d5ac3cee 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -34,6 +34,12 @@ enum uprobe_filter_ctx {
 };
 
 struct uprobe_consumer {
+	/*
+	 * The handler callback return value controls removal of the uprobe.
+	 *  0 on success, uprobe stays
+	 *  1 on failure, remove the uprobe
+	 *    console warning for anything else
+	 */
 	int (*handler)(struct uprobe_consumer *self, struct pt_regs *regs);
 	int (*ret_handler)(struct uprobe_consumer *self,
 				unsigned long func,
@@ -42,6 +48,17 @@ struct uprobe_consumer {
 				enum uprobe_filter_ctx ctx,
 				struct mm_struct *mm);
 
+	/* The handler_session callback return value controls execution of
+	 * the return uprobe and ret_handler_session callback.
+	 *  0 on success
+	 *  1 on failure, DO NOT install/execute the return uprobe
+	 *    console warning for anything else
+	 */
+	int (*handler_session)(struct uprobe_consumer *self, struct pt_regs *regs,
+			       unsigned long *data);
+	int (*ret_handler_session)(struct uprobe_consumer *self, unsigned long func,
+				   struct pt_regs *regs, unsigned long *data);
+
 	struct uprobe_consumer *next;
 };
 
@@ -85,6 +102,7 @@ struct return_instance {
 	unsigned long		func;
 	unsigned long		stack;		/* stack pointer */
 	unsigned long		orig_ret_vaddr; /* original return address */
+	unsigned long		data;
 	bool			chained;	/* true, if instance is nested */
 
 	struct return_instance	*next;		/* keep as stack */
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 2c83ba776fc7..17b0771272a6 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -750,12 +750,32 @@ static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset,
 	return uprobe;
 }
 
-static void consumer_add(struct uprobe *uprobe, struct uprobe_consumer *uc)
+/*
+ * Make sure all the uprobe consumers have only one type of entry
+ * callback registered (either handler or handler_session) due to
+ * different return value actions.
+ */
+static int consumer_check(struct uprobe_consumer *curr, struct uprobe_consumer *uc)
+{
+	if (!curr)
+		return 0;
+	if (curr->handler_session || uc->handler_session)
+		return -EBUSY;
+	return 0;
+}
+
+static int consumer_add(struct uprobe *uprobe, struct uprobe_consumer *uc)
 {
+	int err;
+
 	down_write(&uprobe->consumer_rwsem);
-	uc->next = uprobe->consumers;
-	uprobe->consumers = uc;
+	err = consumer_check(uprobe->consumers, uc);
+	if (!err) {
+		uc->next = uprobe->consumers;
+		uprobe->consumers = uc;
+	}
 	up_write(&uprobe->consumer_rwsem);
+	return err;
 }
 
 /*
@@ -1114,6 +1134,21 @@ void uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consume
 }
 EXPORT_SYMBOL_GPL(uprobe_unregister);
 
+static int check_handler(struct uprobe_consumer *uc)
+{
+	/* Uprobe must have at least one set consumer. */
+	if (!uc->handler && !uc->ret_handler &&
+	    !uc->handler_session && !uc->ret_handler_session)
+		return -1;
+	/* Session consumer is exclusive. */
+	if (uc->handler && uc->handler_session)
+		return -1;
+	/* Session consumer must have both entry and return handler. */
+	if (!!uc->handler_session != !!uc->ret_handler_session)
+		return -1;
+	return 0;
+}
+
 /*
  * __uprobe_register - register a probe
  * @inode: the file in which the probe has to be placed.
@@ -1138,8 +1173,7 @@ static int __uprobe_register(struct inode *inode, loff_t offset,
 	struct uprobe *uprobe;
 	int ret;
 
-	/* Uprobe must have at least one set consumer */
-	if (!uc->handler && !uc->ret_handler)
+	if (check_handler(uc))
 		return -EINVAL;
 
 	/* copy_insn() uses read_mapping_page() or shmem_read_mapping_page() */
@@ -1173,11 +1207,14 @@ static int __uprobe_register(struct inode *inode, loff_t offset,
 	down_write(&uprobe->register_rwsem);
 	ret = -EAGAIN;
 	if (likely(uprobe_is_active(uprobe))) {
-		consumer_add(uprobe, uc);
+		ret = consumer_add(uprobe, uc);
+		if (ret)
+			goto fail;
 		ret = register_for_each_vma(uprobe, uc);
 		if (ret)
 			__uprobe_unregister(uprobe, uc);
 	}
+ fail:
 	up_write(&uprobe->register_rwsem);
 	put_uprobe(uprobe);
 
@@ -1853,7 +1890,7 @@ static void cleanup_return_instances(struct uprobe_task *utask, bool chained,
 	utask->return_instances = ri;
 }
 
-static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs)
+static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs, unsigned long data)
 {
 	struct return_instance *ri;
 	struct uprobe_task *utask;
@@ -1909,6 +1946,7 @@ static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs)
 	ri->stack = user_stack_pointer(regs);
 	ri->orig_ret_vaddr = orig_ret_vaddr;
 	ri->chained = chained;
+	ri->data = data;
 
 	utask->depth++;
 	ri->next = utask->return_instances;
@@ -2070,6 +2108,7 @@ static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
 	struct uprobe_consumer *uc;
 	int remove = UPROBE_HANDLER_REMOVE;
 	bool need_prep = false; /* prepare return uprobe, when needed */
+	unsigned long data = 0;
 
 	down_read(&uprobe->register_rwsem);
 	for (uc = uprobe->consumers; uc; uc = uc->next) {
@@ -2081,14 +2120,24 @@ static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
 				"bad rc=0x%x from %ps()\n", rc, uc->handler);
 		}
 
-		if (uc->ret_handler)
+		if (uc->handler_session) {
+			rc = uc->handler_session(uc, regs, &data);
+			WARN(rc & ~UPROBE_HANDLER_MASK,
+				"bad rc=0x%x from %ps()\n", rc, uc->handler_session);
+		}
+
+		if (uc->ret_handler || uc->ret_handler_session)
 			need_prep = true;
 
 		remove &= rc;
 	}
 
 	if (need_prep && !remove)
-		prepare_uretprobe(uprobe, regs); /* put bp at return */
+		prepare_uretprobe(uprobe, regs, data); /* put bp at return */
+
+	/* remove uprobe only for non-session consumers */
+	if (uprobe->consumers && remove)
+		remove &= !!uprobe->consumers->handler;
 
 	if (remove && uprobe->consumers) {
 		WARN_ON(!uprobe_is_active(uprobe));
@@ -2107,6 +2156,8 @@ handle_uretprobe_chain(struct return_instance *ri, struct pt_regs *regs)
 	for (uc = uprobe->consumers; uc; uc = uc->next) {
 		if (uc->ret_handler)
 			uc->ret_handler(uc, ri->func, regs);
+		if (uc->ret_handler_session)
+			uc->ret_handler_session(uc, ri->func, regs, &ri->data);
 	}
 	up_read(&uprobe->register_rwsem);
 }
-- 
2.45.1


