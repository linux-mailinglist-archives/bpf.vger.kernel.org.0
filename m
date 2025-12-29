Return-Path: <bpf+bounces-77480-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BFDCE8012
	for <lists+bpf@lfdr.de>; Mon, 29 Dec 2025 20:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C098A3003118
	for <lists+bpf@lfdr.de>; Mon, 29 Dec 2025 19:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04168299AB1;
	Mon, 29 Dec 2025 19:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZoEfqpC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E4823AB88;
	Mon, 29 Dec 2025 19:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767035467; cv=none; b=qhiBegbwvJmO9qKYC8lk3PXHghg5cHDaQHygJrLukJRLAJBfgmjUg8VZrIVIok/vg/dNBHKyEIqvRerfCXCNHb9INcxlJqkEhRghGWrdkJAkfiL5GDBsFWEQT8LTmhreLLN7o6Yj4uqq3r/RGYoFfLu/oE+nepLXMHljKl6gT1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767035467; c=relaxed/simple;
	bh=GZhDAA9ezGZPzDeUVwifsh1ekjSX48vKF1A/9IzvzwI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OOiTakowj8gV2IE8MCgYRJIhR7MdSXQpcDrj5YX6x1E9TCdVXQhySC/a4cb5oc79bO6IbT5B5KU7gjTtUa2lNkGeDO1CoP5D3yNKoTJalbaT9Jd6HY1WqJHUlmlDoE/SJkY/l7igIoVtfq4syJgcsimZPNapOqqfk/6uz/giyEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZoEfqpC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1443C2BC86;
	Mon, 29 Dec 2025 19:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767035466;
	bh=GZhDAA9ezGZPzDeUVwifsh1ekjSX48vKF1A/9IzvzwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eZoEfqpC7Dob5fwQik8Ed/0klyOSPTCosLIQ3e8gzMO0L+4m6169dwsf+ebP5sNsd
	 g9vThapp7kyXwAb6qP7t16p/xDJhQkCh47vguTo1bd2r/RGqJTrgzRSs9G918ENwvx
	 xxgaWFVnEMuEw3fkInGfRIC+DJi1vxWimUttKCuCBKTvLEe62RS4j1BIBp5mpLCaZT
	 vYDBRr6re8XfPsBgtwwj2DohYjSUISiPPbMuZQxBCaILoij4W160JQfKUY9p9WOje8
	 i3zSYUpsfVoGv4RbT3XpDKi3ckfgRepCuXXKH28W7B+RJeNxd9uvHCNqdvViYDOckk
	 dVfg9vVUKnNvQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7331CCE1078; Mon, 29 Dec 2025 11:11:06 -0800 (PST)
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
Subject: [PATCH v4 4/9] rcu: Move rcu_tasks_trace_srcu_struct out of #ifdef CONFIG_TASKS_RCU_GENERIC
Date: Mon, 29 Dec 2025 11:10:59 -0800
Message-Id: <20251229191104.693447-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <b206b083-f611-43b6-993f-78ddbe315813@paulmck-laptop>
References: <b206b083-f611-43b6-993f-78ddbe315813@paulmck-laptop>
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
index 8d5a1ecb7d56c..c381a31301168 100644
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
index 1249b47f0a8da..76f952196a292 100644
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


