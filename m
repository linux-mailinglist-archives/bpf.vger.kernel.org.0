Return-Path: <bpf+bounces-43805-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F8C9B9C1A
	for <lists+bpf@lfdr.de>; Sat,  2 Nov 2024 03:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE1611C212DF
	for <lists+bpf@lfdr.de>; Sat,  2 Nov 2024 02:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33376130AC8;
	Sat,  2 Nov 2024 02:05:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFC54174A;
	Sat,  2 Nov 2024 02:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730513126; cv=none; b=HhPqFiLah5IZWHgjjTsY7iQ/od6LK0/f0MlimWshXRuurB1D0iu1fHxLlt92JeGIZlK3GC+oSAMPfSDd1OBqS8yLc4DSnwbgwBDrXC48POsxATY1SS7p7KWgCD3kX3I/clwG1axAQE3l8Kw7bL5JiZkgpPrX4PKHHtzJ1Bo6MuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730513126; c=relaxed/simple;
	bh=CzXMvhyapTgsYqMxRNlOJeYogkntoJO9Xs1tkQMypJs=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=VkFLtkcN+F7zK7dSEkowt1ErTxMPYeWjhLs2kmf+tmxwhbQyZ2CdnmPpPP5lnbYcHzG6o3nhhE99X8UQdxjdeW1jrI9mQwHMqY8LCcCE7XnrLU4QyTDwmjl8JKZRDoSdIxHHZ3gkn8LLntFKnmhj1rmXBpMzOoE18fuv6OhYfLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 908F2C4CED3;
	Sat,  2 Nov 2024 02:05:26 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1t73X0-00000005Zew-1YYp;
	Fri, 01 Nov 2024 22:06:26 -0400
Message-ID: <20241102020626.230444237@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 01 Nov 2024 22:05:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 bpf <bpf@vger.kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>,
 Jordan Rife <jrife@google.com>
Subject: [for-next][PATCH 2/3] bpf: decouple BPF link/attach hook and BPF program sleepable
 semantics
References: <20241102020553.444477901@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Andrii Nakryiko <andrii@kernel.org>

BPF link's lifecycle protection scheme depends on both BPF hook and BPF
program. If *either* of those require RCU Tasks Trace GP, then we need
to go through a chain of GPs before putting BPF program refcount and
deallocating BPF link memory.

This patch adds bpf_link-specific sleepable flag, which can be set to
true even if underlying BPF program is not sleepable itself. If either
link->sleepable or link->prog->sleepable is true, we'll go through
a chain of RCU Tasks Trace GP and RCU GP before putting BPF program and
freeing memory.

This will be used to protect BPF link for sleepable (faultable) raw
tracepoints in the next patch.

Link: https://lore.kernel.org/20241101181754.782341-2-andrii@kernel.org
Tested-by: Jordan Rife <jrife@google.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/bpf.h  | 20 ++++++++++++++++++--
 kernel/bpf/syscall.c | 39 ++++++++++++++++++++++++++++-----------
 2 files changed, 46 insertions(+), 13 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 19d8ca8ac960..e7236facadd4 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1598,6 +1598,11 @@ struct bpf_link {
 	enum bpf_link_type type;
 	const struct bpf_link_ops *ops;
 	struct bpf_prog *prog;
+	/* whether BPF link itself has "sleepable" semantics, which can differ
+	 * from underlying BPF program having a "sleepable" semantics, as BPF
+	 * link's semantics is determined by target attach hook
+	 */
+	bool sleepable;
 	/* rcu is used before freeing, work can be used to schedule that
 	 * RCU-based freeing before that, so they never overlap
 	 */
@@ -1614,8 +1619,10 @@ struct bpf_link_ops {
 	 */
 	void (*dealloc)(struct bpf_link *link);
 	/* deallocate link resources callback, called after RCU grace period;
-	 * if underlying BPF program is sleepable we go through tasks trace
-	 * RCU GP and then "classic" RCU GP
+	 * if either the underlying BPF program is sleepable or BPF link's
+	 * target hook is sleepable, we'll go through tasks trace RCU GP and
+	 * then "classic" RCU GP; this need for chaining tasks trace and
+	 * classic RCU GPs is designated by setting bpf_link->sleepable flag
 	 */
 	void (*dealloc_deferred)(struct bpf_link *link);
 	int (*detach)(struct bpf_link *link);
@@ -2362,6 +2369,9 @@ int bpf_prog_new_fd(struct bpf_prog *prog);
 
 void bpf_link_init(struct bpf_link *link, enum bpf_link_type type,
 		   const struct bpf_link_ops *ops, struct bpf_prog *prog);
+void bpf_link_init_sleepable(struct bpf_link *link, enum bpf_link_type type,
+			     const struct bpf_link_ops *ops, struct bpf_prog *prog,
+			     bool sleepable);
 int bpf_link_prime(struct bpf_link *link, struct bpf_link_primer *primer);
 int bpf_link_settle(struct bpf_link_primer *primer);
 void bpf_link_cleanup(struct bpf_link_primer *primer);
@@ -2717,6 +2727,12 @@ static inline void bpf_link_init(struct bpf_link *link, enum bpf_link_type type,
 {
 }
 
+static inline void bpf_link_init_sleepable(struct bpf_link *link, enum bpf_link_type type,
+					   const struct bpf_link_ops *ops, struct bpf_prog *prog,
+					   bool sleepable)
+{
+}
+
 static inline int bpf_link_prime(struct bpf_link *link,
 				 struct bpf_link_primer *primer)
 {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index aa7246a399f3..0f5540627911 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2933,17 +2933,33 @@ static int bpf_obj_get(const union bpf_attr *attr)
 				attr->file_flags);
 }
 
-void bpf_link_init(struct bpf_link *link, enum bpf_link_type type,
-		   const struct bpf_link_ops *ops, struct bpf_prog *prog)
+/* bpf_link_init_sleepable() allows to specify whether BPF link itself has
+ * "sleepable" semantics, which normally would mean that BPF link's attach
+ * hook can dereference link or link's underlying program for some time after
+ * detachment due to RCU Tasks Trace-based lifetime protection scheme.
+ * BPF program itself can be non-sleepable, yet, because it's transitively
+ * reachable through BPF link, its freeing has to be delayed until after RCU
+ * Tasks Trace GP.
+ */
+void bpf_link_init_sleepable(struct bpf_link *link, enum bpf_link_type type,
+			     const struct bpf_link_ops *ops, struct bpf_prog *prog,
+			     bool sleepable)
 {
 	WARN_ON(ops->dealloc && ops->dealloc_deferred);
 	atomic64_set(&link->refcnt, 1);
 	link->type = type;
+	link->sleepable = sleepable;
 	link->id = 0;
 	link->ops = ops;
 	link->prog = prog;
 }
 
+void bpf_link_init(struct bpf_link *link, enum bpf_link_type type,
+		   const struct bpf_link_ops *ops, struct bpf_prog *prog)
+{
+	bpf_link_init_sleepable(link, type, ops, prog, false);
+}
+
 static void bpf_link_free_id(int id)
 {
 	if (!id)
@@ -3008,20 +3024,21 @@ static void bpf_link_defer_dealloc_mult_rcu_gp(struct rcu_head *rcu)
 static void bpf_link_free(struct bpf_link *link)
 {
 	const struct bpf_link_ops *ops = link->ops;
-	bool sleepable = false;
 
 	bpf_link_free_id(link->id);
-	if (link->prog) {
-		sleepable = link->prog->sleepable;
-		/* detach BPF program, clean up used resources */
+	/* detach BPF program, clean up used resources */
+	if (link->prog)
 		ops->release(link);
-	}
 	if (ops->dealloc_deferred) {
-		/* schedule BPF link deallocation; if underlying BPF program
-		 * is sleepable, we need to first wait for RCU tasks trace
-		 * sync, then go through "classic" RCU grace period
+		/* Schedule BPF link deallocation, which will only then
+		 * trigger putting BPF program refcount.
+		 * If underlying BPF program is sleepable or BPF link's target
+		 * attach hookpoint is sleepable or otherwise requires RCU GPs
+		 * to ensure link and its underlying BPF program is not
+		 * reachable anymore, we need to first wait for RCU tasks
+		 * trace sync, and then go through "classic" RCU grace period
 		 */
-		if (sleepable)
+		if (link->sleepable || (link->prog && link->prog->sleepable))
 			call_rcu_tasks_trace(&link->rcu, bpf_link_defer_dealloc_mult_rcu_gp);
 		else
 			call_rcu(&link->rcu, bpf_link_defer_dealloc_rcu_gp);
-- 
2.45.2



