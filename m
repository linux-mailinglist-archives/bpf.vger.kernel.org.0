Return-Path: <bpf+bounces-73308-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A6EADC2A48E
	for <lists+bpf@lfdr.de>; Mon, 03 Nov 2025 08:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 100D94EE10A
	for <lists+bpf@lfdr.de>; Mon,  3 Nov 2025 07:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228EF2BE649;
	Mon,  3 Nov 2025 07:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHVgj5zF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD2929E116;
	Mon,  3 Nov 2025 07:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762154353; cv=none; b=jUWtVrF6RoiTxYt/zBzk8Tmp290FSWa0B/lGmRnaxO6smsvX0i0yOKNelwMvK/jGr9jgUFa/eTSUTgDehHfjssDJ7koVQHa3D7vvgLIJ/58bWqjCAum6L3B7LmBBEy3nQHnizOyrlDllm4s5f+0DFqtxk5wzvltwvr8fyFi1Xj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762154353; c=relaxed/simple;
	bh=UEUOz1qlBX8iOB8+YDcYnYkXsE6RqMBj2Rs+ohRJ0Ao=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HShZEvWMqXOoM7/g7z7AizQKpd2+XyZsDwgO/oVLzQEl07sQK1Zd7s/K8/BI7WunMCUzv+lNFXV5vUeY5n7nGuouKBVZZsKcUCBBHjrN3wTSk10pNAD5w7Th8pwdirvNMkaM1SBmBY3MlLJKpjD2euPtE0FPoaDw3rUabxYVnA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHVgj5zF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35510C19421;
	Mon,  3 Nov 2025 07:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762154353;
	bh=UEUOz1qlBX8iOB8+YDcYnYkXsE6RqMBj2Rs+ohRJ0Ao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RHVgj5zFzGhIwrBwdO8BYfK/Eoq9w18zMZr+chDWUlt59NC66bsbbbQ75kuKifJBM
	 kzaEfm9LfBNU90C1fcJRQNzaVbvTcmnrDAHdPhu161u9jLUfyaYiwC5wSceRUlJ+oN
	 p2NzL9ukhiuyu9G1TQFtcLSNyoC92ZbcpMx3O7hJ4rHqEfAYsw914dFUB3q0I+8gq/
	 NHDi8l4nUksIZRN4yb0Mkg2aMpN1kNC5Wze27isKs23KPeNL2xnwITXJfUO2lLT/vq
	 Fe6BDOkswuIV955qDNFWdMGEqbmvE73I/qfl7bPAjM+zPDCDISGqdTiMYPWOjvzykF
	 reVgSsyh0sXFA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BD25ACE176D; Sun,  2 Nov 2025 15:07:01 -0800 (PST)
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
Subject: [PATCH 4/9] rcu: Move rcu_tasks_trace_srcu_struct out of #ifdef CONFIG_TASKS_RCU_GENERIC
Date: Sun,  2 Nov 2025 15:06:54 -0800
Message-Id: <20251102230659.3906740-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <a1e505e4-931b-45cf-8ca7-337442aa598e@paulmck-laptop>
References: <a1e505e4-931b-45cf-8ca7-337442aa598e@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Moving the rcu_tasks_trace_srcu_struct structure instance out
from under the CONFIG_TASKS_RCU_GENERIC Kconfig option permits
the CONFIG_TASKS_TRACE_RCU Kconfig option to stop enabling this
CONFIG_TASKS_RCU_GENERIC Kconfig option.  This commit also therefore
makes it so.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: <bpf@vger.kernel.org>
---
 kernel/rcu/Kconfig |  2 +-
 kernel/rcu/tasks.h | 42 +++++++++++++-----------------------------
 2 files changed, 14 insertions(+), 30 deletions(-)

diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index 54b4c4aa553a..73a6cc364628 100644
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
index 1249b47f0a8d..76f952196a29 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1439,35 +1439,6 @@ EXPORT_SYMBOL_GPL(rcu_tasks_rude_get_gp_data);
 
 #endif /* #ifdef CONFIG_TASKS_RUDE_RCU */
 
-////////////////////////////////////////////////////////////////////////
-//
-// Tracing variant of Tasks RCU.  This variant is designed to be used
-// to protect tracing hooks, including those of BPF.  This variant
-// is implemented via a straightforward mapping onto SRCU-fast.
-
-#ifdef CONFIG_TASKS_TRACE_RCU
-
-DEFINE_SRCU_FAST(rcu_tasks_trace_srcu_struct);
-EXPORT_SYMBOL_GPL(rcu_tasks_trace_srcu_struct);
-
-// Placeholder to suppress build errors through transition period.
-void __init rcu_tasks_trace_suppress_unused(void)
-{
-#ifndef CONFIG_TINY_RCU
-	show_rcu_tasks_generic_gp_kthread(NULL, NULL);
-#endif // #ifndef CONFIG_TINY_RCU
-	rcu_spawn_tasks_kthread_generic(NULL);
-	synchronize_rcu_tasks_generic(NULL);
-	call_rcu_tasks_generic(NULL, NULL, NULL);
-	call_rcu_tasks_iw_wakeup(NULL);
-	cblist_init_generic(NULL);
-#ifndef CONFIG_TINY_RCU
-	rcu_tasks_torture_stats_print_generic(NULL, NULL, NULL, NULL);
-#endif // #ifndef CONFIG_TINY_RCU
-}
-
-#endif /* #else #ifdef CONFIG_TASKS_TRACE_RCU */
-
 #ifndef CONFIG_TINY_RCU
 void show_rcu_tasks_gp_kthreads(void)
 {
@@ -1621,3 +1592,16 @@ core_initcall(rcu_init_tasks_generic);
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
+DEFINE_SRCU_FAST(rcu_tasks_trace_srcu_struct);
+EXPORT_SYMBOL_GPL(rcu_tasks_trace_srcu_struct);
+
+#endif /* #else #ifdef CONFIG_TASKS_TRACE_RCU */
-- 
2.40.1


