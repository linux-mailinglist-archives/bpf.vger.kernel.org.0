Return-Path: <bpf+bounces-43754-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 610119B973E
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 19:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81BC21C20EAF
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 18:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140781CEAD4;
	Fri,  1 Nov 2024 18:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WkD25IvJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8437A1CEAC3;
	Fri,  1 Nov 2024 18:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730485080; cv=none; b=FSURcYCa02IvTeiseSgQnmzhttqVUWEiuXRYRVaQxL6I3OPeZKS7MAGlBST/8ASZJHXdra582hKnpxS0VTmInS7xkpxTJXGzP4DMoqwUK2hgZ386xRnVcrN7GL1QfT6fVVM4YZtsFV2F+kifmTNkr4jJ6Y09rmYySlUBnwVH+8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730485080; c=relaxed/simple;
	bh=CU1F2z3pE2aZNvIQtiXiS8GPpj45CDsD8vEkb5Fqim0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Chm6F/Q8JeNMxhMleAngnrjzSxh4VwZVkURL3lf2o2tonQZ1V6CKsLAmqSwm3Ja9uYx+GjMYzgY0ptkGnhoP50LkaERCKiefNPrDNqCg/YG8GYLmEuChjQGhtwnJcCRE/wZ1oLwfIv+Qr29jeZOaJRWhM1fo0rOCpq9ny/UnzDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WkD25IvJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC3B1C4CECF;
	Fri,  1 Nov 2024 18:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730485080;
	bh=CU1F2z3pE2aZNvIQtiXiS8GPpj45CDsD8vEkb5Fqim0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WkD25IvJhEOussaOAJkqWC0NvMpBnnERmB6m8HoKaJT3kAcU3X+UEglfC3xHHHia2
	 MOK+CtyHfyo7TCkeQXLuP/HpM/Ksp5Hi57DP0ruRjm+BQ1/6BxPg6zTw0AH3w4T5cU
	 V5hrNmI4J45RFhrldyrSJtkPUbFpQVAuAnWzyLuE3WqUFjRUo09YKevXqUNyzRbQAH
	 scMsJ70UUzJoRh9B4240JlbCzWHjHw5loqAkfAzS9wa4Jasr3Z+R6u5UaBAGjHwZZ1
	 d7I0BLmmDoxNb8VuyEZpYlcJflqwyp534/hw7FbEr6UxFBeIAfILK+lqRzTlNiyYR8
	 msewzhDMtd89A==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	rostedt@goodmis.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	mhiramat@kernel.org,
	peterz@infradead.org,
	paulmck@kernel.org,
	jrife@google.com,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v2 trace/for-next 2/3] bpf: decouple BPF link/attach hook and BPF program sleepable semantics
Date: Fri,  1 Nov 2024 11:17:53 -0700
Message-ID: <20241101181754.782341-2-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241101181754.782341-1-andrii@kernel.org>
References: <20241101181754.782341-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Tested-by: Jordan Rife <jrife@google.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
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
2.43.5


