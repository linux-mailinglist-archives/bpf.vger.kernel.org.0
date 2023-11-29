Return-Path: <bpf+bounces-16143-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C1B7FD6AB
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 13:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFDA1B21A45
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 12:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23D21DA58;
	Wed, 29 Nov 2023 12:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AlWI7sd4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BE5199B9;
	Wed, 29 Nov 2023 12:24:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17CC2C433C7;
	Wed, 29 Nov 2023 12:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701260666;
	bh=pVxX22NcIZDiGGyTbgEa33EVYfiXBcfDYNXnVa+7dGc=;
	h=From:To:Cc:Subject:Date:From;
	b=AlWI7sd4vmwOo8FmdPCGDYirpxABK+7KUbEJLQung3kr0McXo6UnqnuMY6NtocJch
	 6NyJvRyL88RgRazKLcDwbP+f9Higl00DECJ/TIFKr4MqIggXvpEJRl+uhEJ/FxtZ4u
	 RvnDbuXn39pEbnylQnlddcGjAI8+3hxdt/IzPM9WJySYMezXZhdq/z7zVLRphojM0N
	 2sRHFjLcQmiPhLEKpKhXjckbAvfV2wgWkbvYl4irf7utQpeX6ZA6vxcH9BKrgybFH3
	 /zxTXvxy6a2zSN8/Jy48XK8OVrC5RgtC5aWkyxGLCfTahW3U2IX4g57ZvyQnPLOKtG
	 4xrDqsiFirpqw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: JP Kobryn <inwardvessel@gmail.com>,
	bpf@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	peterz@infradead.org
Subject: [PATCH v2] rethook: Use __rcu pointer for rethook::handler
Date: Wed, 29 Nov 2023 21:24:22 +0900
Message-Id: <170126066201.398836.837498688669005979.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Since the rethook::handler is an RCU-maganged pointer so that it will
notice readers the rethook is stopped (unregistered) or not, it should
be an __rcu pointer and use appropriate functions to be accessed. This
will use appropriate memory barrier when accessing it. OTOH,
rethook::data is never changed, so we don't need to check it in
get_kretprobe().

NOTE: To avoid sparse warning, rethook::handler is defined by a raw
function pointer type with __rcu instead of rethook_handler_t.

Fixes: 54ecbe6f1ed5 ("rethook: Add a generic return hook")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202311241808.rv9ceuAh-lkp@intel.com/
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 include/linux/kprobes.h |    6 ++----
 include/linux/rethook.h |    7 ++++++-
 kernel/trace/rethook.c  |   23 ++++++++++++++---------
 3 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 64672bace560..0ff44d6633e3 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -197,10 +197,8 @@ extern int arch_trampoline_kprobe(struct kprobe *p);
 #ifdef CONFIG_KRETPROBE_ON_RETHOOK
 static nokprobe_inline struct kretprobe *get_kretprobe(struct kretprobe_instance *ri)
 {
-	RCU_LOCKDEP_WARN(!rcu_read_lock_any_held(),
-		"Kretprobe is accessed from instance under preemptive context");
-
-	return (struct kretprobe *)READ_ONCE(ri->node.rethook->data);
+	/* rethook::data is non-changed field, so that you can access it freely. */
+	return (struct kretprobe *)ri->node.rethook->data;
 }
 static nokprobe_inline unsigned long get_kretprobe_retaddr(struct kretprobe_instance *ri)
 {
diff --git a/include/linux/rethook.h b/include/linux/rethook.h
index ce69b2b7bc35..ba60962805f6 100644
--- a/include/linux/rethook.h
+++ b/include/linux/rethook.h
@@ -28,7 +28,12 @@ typedef void (*rethook_handler_t) (struct rethook_node *, void *, unsigned long,
  */
 struct rethook {
 	void			*data;
-	rethook_handler_t	handler;
+	/*
+	 * To avoid sparse warnings, this uses a raw function pointer with
+	 * __rcu, instead of rethook_handler_t. But this must be same as
+	 * rethook_handler_t.
+	 */
+	void (__rcu *handler) (struct rethook_node *, void *, unsigned long, struct pt_regs *);
 	struct objpool_head	pool;
 	struct rcu_head		rcu;
 };
diff --git a/kernel/trace/rethook.c b/kernel/trace/rethook.c
index 6fd7d4ecbbc6..fa03094e9e69 100644
--- a/kernel/trace/rethook.c
+++ b/kernel/trace/rethook.c
@@ -48,7 +48,7 @@ static void rethook_free_rcu(struct rcu_head *head)
  */
 void rethook_stop(struct rethook *rh)
 {
-	WRITE_ONCE(rh->handler, NULL);
+	rcu_assign_pointer(rh->handler, NULL);
 }
 
 /**
@@ -63,7 +63,7 @@ void rethook_stop(struct rethook *rh)
  */
 void rethook_free(struct rethook *rh)
 {
-	WRITE_ONCE(rh->handler, NULL);
+	rethook_stop(rh);
 
 	call_rcu(&rh->rcu, rethook_free_rcu);
 }
@@ -82,6 +82,12 @@ static int rethook_fini_pool(struct objpool_head *head, void *context)
 	return 0;
 }
 
+static inline rethook_handler_t rethook_get_handler(struct rethook *rh)
+{
+	return (rethook_handler_t)rcu_dereference_check(rh->handler,
+							rcu_read_lock_any_held());
+}
+
 /**
  * rethook_alloc() - Allocate struct rethook.
  * @data: a data to pass the @handler when hooking the return.
@@ -107,7 +113,7 @@ struct rethook *rethook_alloc(void *data, rethook_handler_t handler,
 		return ERR_PTR(-ENOMEM);
 
 	rh->data = data;
-	rh->handler = handler;
+	rcu_assign_pointer(rh->handler, handler);
 
 	/* initialize the objpool for rethook nodes */
 	if (objpool_init(&rh->pool, num, size, GFP_KERNEL, rh,
@@ -135,9 +141,10 @@ static void free_rethook_node_rcu(struct rcu_head *head)
  */
 void rethook_recycle(struct rethook_node *node)
 {
-	lockdep_assert_preemption_disabled();
+	rethook_handler_t handler;
 
-	if (likely(READ_ONCE(node->rethook->handler)))
+	handler = rethook_get_handler(node->rethook);
+	if (likely(handler))
 		objpool_push(node, &node->rethook->pool);
 	else
 		call_rcu(&node->rcu, free_rethook_node_rcu);
@@ -153,9 +160,7 @@ NOKPROBE_SYMBOL(rethook_recycle);
  */
 struct rethook_node *rethook_try_get(struct rethook *rh)
 {
-	rethook_handler_t handler = READ_ONCE(rh->handler);
-
-	lockdep_assert_preemption_disabled();
+	rethook_handler_t handler = rethook_get_handler(rh);
 
 	/* Check whether @rh is going to be freed. */
 	if (unlikely(!handler))
@@ -300,7 +305,7 @@ unsigned long rethook_trampoline_handler(struct pt_regs *regs,
 		rhn = container_of(first, struct rethook_node, llist);
 		if (WARN_ON_ONCE(rhn->frame != frame))
 			break;
-		handler = READ_ONCE(rhn->rethook->handler);
+		handler = rethook_get_handler(rhn->rethook);
 		if (handler)
 			handler(rhn, rhn->rethook->data,
 				correct_ret_addr, regs);


