Return-Path: <bpf+bounces-69415-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 698B5B96381
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 16:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CC6C4A57C3
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 14:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144FF2E6105;
	Tue, 23 Sep 2025 14:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJL4QXit"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B5F267B02;
	Tue, 23 Sep 2025 14:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758637303; cv=none; b=qxKshdvlg7CqLwJ8JxN8TOKRGlbEegYgItzmfSaR/8xHEQ/owY2nXbQxc3zJtSc06LFSXwkyQvO+RMPBduo/2igqkIHt9Ea4a+rExswRafhiBERWZRrZsw8WNMFLpgfA3ZZLuMMx6T/UmToe2cQLVvP1aP1rwpG2FnREWFyWRNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758637303; c=relaxed/simple;
	bh=egf5O4384GKLj9kiAAW/t23M4cxF514rK1fhEiB3mLc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p1Ck8vq5biFk/JSsjBWFFnQoTldtcXVEq2uDoa6AUn2BEoLFMmJw1rTkv/6NGkaKQYlURzHxFGG783NEyub24za4sAAWr+1llzsx1yZWeywPWi7uCczyCpLBXw5MsTK8MPG63oeI17Q70wFhlErQukN3WvFaBDF0fsvM4EzE6go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJL4QXit; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE43DC19421;
	Tue, 23 Sep 2025 14:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758637302;
	bh=egf5O4384GKLj9kiAAW/t23M4cxF514rK1fhEiB3mLc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DJL4QXit1l6Kem2Ql0r3Nj2CJr1/6HBINjQfcxUij3p95z5OeQPdF8L4ApeXNXmwt
	 oihJA1dQTbk4l1fBCHQnpjaXYW4A7RC0BF/JnJexJ81rP3iivrs8zKxAHyCtw0I/mb
	 IaXv2HmiQ7uToiHvAaPRd4fOgRbiq+scr7Rz1OWXYq0aoBjaCrdG9LELiMXhB8Wd9t
	 SCjsAjP+zhtRDA14e9SC9W9wQcFfniq+vUrUSLGl+TMzgoUf0O40V8PwN5yQi4lGVI
	 oqIIdvHezL9Kf4l2dpLBR2zHw2N66DFUUc3IDCWmpkAldbUcDWKaPmwAd0b/Wu8Ak7
	 T5ALFd/ruQh4Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D9E99CE1427; Tue, 23 Sep 2025 07:20:37 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	bpf@vger.kernel.org
Subject: [PATCH 14/34] rcu: Move rcu_tasks_trace_srcu_struct out of #ifdef CONFIG_TASKS_RCU_GENERIC
Date: Tue, 23 Sep 2025 07:20:16 -0700
Message-Id: <20250923142036.112290-14-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <580ea2de-799a-4ddc-bde9-c16f3fb1e6e7@paulmck-laptop>
References: <580ea2de-799a-4ddc-bde9-c16f3fb1e6e7@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Moving rcu_tasks_trace_srcu_struct out the CONFIG_TASKS_RCU_GENERIC
removed, and also permits the CONFIG_TASKS_TRACE_RCU Kconfig option to
stop enabling the CONFIG_TASKS_RCU_GENERIC Kconfig option.  This commit
therefore makes it so.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: <bpf@vger.kernel.org>
---
 kernel/rcu/Kconfig |  2 +-
 kernel/rcu/tasks.h | 38 +++++++++++++-------------------------
 2 files changed, 14 insertions(+), 26 deletions(-)

diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index ceaf6594f634cd..eeaa1cd47c6c4c 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -82,7 +82,7 @@ config NEED_SRCU_NMI_SAFE
 	def_bool HAVE_NMI && !ARCH_HAS_NMI_SAFE_THIS_CPU_OPS && !TINY_SRCU
 
 config TASKS_RCU_GENERIC
-	def_bool TASKS_RCU || TASKS_RUDE_RCU || TASKS_TRACE_RCU
+	def_bool TASKS_RCU || TASKS_RUDE_RCU
 	help
 	  This option enables generic infrastructure code supporting
 	  task-based RCU implementations.  Not for manual selection.
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index e70609c85ece5d..a3c16e65e16812 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1444,31 +1444,6 @@ EXPORT_SYMBOL_GPL(rcu_tasks_rude_get_gp_data);
 
 #endif /* #ifdef CONFIG_TASKS_RUDE_RCU */
 
-////////////////////////////////////////////////////////////////////////
-//
-// Tracing variant of Tasks RCU.  This variant is designed to be used
-// to protect tracing hooks, including those of BPF.  This variant
-// is implemented via a straightforward mapping onto SRCU-fast.
-
-#ifdef CONFIG_TASKS_TRACE_RCU
-
-DEFINE_SRCU(rcu_tasks_trace_srcu_struct);
-EXPORT_SYMBOL_GPL(rcu_tasks_trace_srcu_struct);
-
-// Placeholder to suppress build errors through transition period.
-void __init rcu_tasks_trace_suppress_unused(void)
-{
-	show_rcu_tasks_generic_gp_kthread(NULL, NULL);
-	rcu_spawn_tasks_kthread_generic(NULL);
-	synchronize_rcu_tasks_generic(NULL);
-	call_rcu_tasks_generic(NULL, NULL, NULL);
-	call_rcu_tasks_iw_wakeup(NULL);
-	cblist_init_generic(NULL);
-	rcu_tasks_torture_stats_print_generic(NULL, NULL, NULL, NULL);
-}
-
-#endif /* #else #ifdef CONFIG_TASKS_TRACE_RCU */
-
 #ifndef CONFIG_TINY_RCU
 void show_rcu_tasks_gp_kthreads(void)
 {
@@ -1622,3 +1597,16 @@ core_initcall(rcu_init_tasks_generic);
 #else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
 static inline void rcu_tasks_bootup_oddness(void) {}
 #endif /* #else #ifdef CONFIG_TASKS_RCU_GENERIC */
+
+#ifdef CONFIG_TASKS_TRACE_RCU
+
+////////////////////////////////////////////////////////////////////////
+//
+// Tracing variant of Tasks RCU.  This variant is designed to be used
+// to protect tracing hooks, including those of BPF.  This variant
+// is implemented via a straightforward mapping onto SRCU-fast.
+
+DEFINE_SRCU(rcu_tasks_trace_srcu_struct);
+EXPORT_SYMBOL_GPL(rcu_tasks_trace_srcu_struct);
+
+#endif /* #else #ifdef CONFIG_TASKS_TRACE_RCU */
-- 
2.40.1


