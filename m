Return-Path: <bpf+bounces-15790-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCBD7F6A00
	for <lists+bpf@lfdr.de>; Fri, 24 Nov 2023 02:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5E0C1C20A4C
	for <lists+bpf@lfdr.de>; Fri, 24 Nov 2023 01:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3220621;
	Fri, 24 Nov 2023 01:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DuOxk/DR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B5D639;
	Fri, 24 Nov 2023 01:03:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7454C433C8;
	Fri, 24 Nov 2023 01:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700787791;
	bh=MK5tjkjB52MplO5zrLGX/U/QKetESX/No8t7aMgG+PE=;
	h=From:To:Cc:Subject:Date:From;
	b=DuOxk/DRRLcNBbp2QjtM0XWSEBjeNGb3i/iSFwfdsRhmFFcZ4J/kMkEAlTVwMA5wc
	 IWAg2Iux0WS3sJAnKFWuet3UQsfQt0/WxY3MXcSRqk2IIUnBY9/zKNVgj89K6mWPsy
	 6TFrUBPY3bMsYNwqxySVEdx0OT1OGnBwQ9KLfGGuvc++4zjT84wGAf3Tx2PEa7HjIx
	 eCjSJd0Ls67dDcSR8FhPlJ+6CLYNYClJCSmdjixCWA5gYEs1kGTScRoqWLncyYwKqO
	 no//WB50pWt1jwcGPjIR3gd7dNKQMXE6GJZMrnYcm66XwlxHMbJky32mNDIlgcre3E
	 DcM+dZO8WQYcw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: JP Kobryn <inwardvessel@gmail.com>,
	bpf@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	peterz@infradead.org
Subject: [PATCH] rethook: Use __rcu pointer for rethook::handler
Date: Fri, 24 Nov 2023 10:03:06 +0900
Message-Id: <170078778632.209874.7893551840863388753.stgit@devnote2>
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
will use appropriate memory barrier when accessing it. OTOH, rethook::data
is never changed, so we don't need to check it in get_kretprobe().

Fixes: 54ecbe6f1ed5 ("rethook: Add a generic return hook")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 include/linux/kprobes.h |    6 ++----
 include/linux/rethook.h |    2 +-
 kernel/trace/rethook.c  |   21 ++++++++++++---------
 3 files changed, 15 insertions(+), 14 deletions(-)

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
index ce69b2b7bc35..164cd32c25cd 100644
--- a/include/linux/rethook.h
+++ b/include/linux/rethook.h
@@ -28,7 +28,7 @@ typedef void (*rethook_handler_t) (struct rethook_node *, void *, unsigned long,
  */
 struct rethook {
 	void			*data;
-	rethook_handler_t	handler;
+	rethook_handler_t __rcu handler;
 	struct objpool_head	pool;
 	struct rcu_head		rcu;
 };
diff --git a/kernel/trace/rethook.c b/kernel/trace/rethook.c
index 6fd7d4ecbbc6..77f0e987bbff 100644
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
+	rcu_assign_pointer(rh->handler, NULL);
 
 	call_rcu(&rh->rcu, rethook_free_rcu);
 }
@@ -107,7 +107,7 @@ struct rethook *rethook_alloc(void *data, rethook_handler_t handler,
 		return ERR_PTR(-ENOMEM);
 
 	rh->data = data;
-	rh->handler = handler;
+	rcu_assign_pointer(rh->handler, handler);
 
 	/* initialize the objpool for rethook nodes */
 	if (objpool_init(&rh->pool, num, size, GFP_KERNEL, rh,
@@ -135,9 +135,12 @@ static void free_rethook_node_rcu(struct rcu_head *head)
  */
 void rethook_recycle(struct rethook_node *node)
 {
-	lockdep_assert_preemption_disabled();
+	rethook_handler_t handler;
+
+	handler = rcu_dereference_check(node->rethook->handler,
+					rcu_read_lock_any_held());
 
-	if (likely(READ_ONCE(node->rethook->handler)))
+	if (likely(handler))
 		objpool_push(node, &node->rethook->pool);
 	else
 		call_rcu(&node->rcu, free_rethook_node_rcu);
@@ -153,10 +156,9 @@ NOKPROBE_SYMBOL(rethook_recycle);
  */
 struct rethook_node *rethook_try_get(struct rethook *rh)
 {
-	rethook_handler_t handler = READ_ONCE(rh->handler);
-
-	lockdep_assert_preemption_disabled();
+	rethook_handler_t handler;
 
+	handler = rcu_dereference_check(rh->handler, rcu_read_lock_any_held());
 	/* Check whether @rh is going to be freed. */
 	if (unlikely(!handler))
 		return NULL;
@@ -300,7 +302,8 @@ unsigned long rethook_trampoline_handler(struct pt_regs *regs,
 		rhn = container_of(first, struct rethook_node, llist);
 		if (WARN_ON_ONCE(rhn->frame != frame))
 			break;
-		handler = READ_ONCE(rhn->rethook->handler);
+		handler = rcu_dereference_check(rhn->rethook->handler,
+						rcu_read_lock_any_held());
 		if (handler)
 			handler(rhn, rhn->rethook->data,
 				correct_ret_addr, regs);


