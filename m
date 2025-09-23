Return-Path: <bpf+bounces-69432-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DD2B96462
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 16:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C69CC19C743E
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 14:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA6D32CF9F;
	Tue, 23 Sep 2025 14:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OX4sPfBT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE6632951D;
	Tue, 23 Sep 2025 14:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758637324; cv=none; b=lTMqZDnvSxqpEWsHuoxabftxRytPOn+M+ByPuNp2IOrzYV33rirnW7CJSCQ6pvpNld8M5HBSHzQVwgpAL6LaZ9Nbx7lSYagKEZRha/l5a8Kr/CYXVo3KpYLDc6hH9CP3mf7BnNnbvFtFaY42LWv7NC4lfpo1krB82nkKRMv5zYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758637324; c=relaxed/simple;
	bh=/tPpaG65gLbvD7rU4GOXgMQxivskQwWOEjt2Xk9cxII=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vCAeDdFLoJSU9rO7oIIM4A4xu8xgTQd3F9bnSuNgcXyuGaX7cjn60AN3S9QJR/88NIgXUhHu8Dy2su/pzIEPOU+CMnlYIWRR+tlBO+EuZQgklJlrfCZZNiE7glse9GFiLzS0gpGUqqtwjN2rnkPLYmsWhkVWaRQLNECH7gfDoW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OX4sPfBT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C42CC113CF;
	Tue, 23 Sep 2025 14:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758637324;
	bh=/tPpaG65gLbvD7rU4GOXgMQxivskQwWOEjt2Xk9cxII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OX4sPfBTV+8CTfM3Idwl5WTLtfiK3ifO9ACtJgyVxrM7e2gOYrUIx3tS530p53tCo
	 eHbOhfLYa0wD4/XLppz7b8P/IO4ZmcDXmPdjr6dXnykEBmegczWtE3f7WmZy94Hsf5
	 yjGF1ERZsszXvrweaN0nrai25TX026nu7REBV57ZV9hRT5Nb2VanXW7Nrp4OAuI98E
	 Cny0yfPgiuHskPSoJNJ4kQ6YrVTxUuCx1UmZbxZLxLkf4bTVD6lM0EMCMCzErlUUA1
	 NKTxfRm+05U+96+v1DGmk+IJPcdSnZDjkwAPGe9ezY7Pj+3twSy60TdP1ahVq1CeN0
	 9kzS/QTm1YKpA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id DF8EECE14C5; Tue, 23 Sep 2025 07:20:37 -0700 (PDT)
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
Subject: [PATCH 16/34] rcu: Remove now-unused rcu_task_ipi_delay and TASKS_TRACE_RCU_READ_MB
Date: Tue, 23 Sep 2025 07:20:18 -0700
Message-Id: <20250923142036.112290-16-paulmck@kernel.org>
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

Now that RCU Tasks Trace being defined in terms of SRCU-fast,
the rcupdate.rcu_task_ipi_delay kernel boot parameter and the
TASKS_TRACE_RCU_READ_MB Kconfig option are no longer used.  This commit
therefore removes them.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: <bpf@vger.kernel.org>
---
 .../admin-guide/kernel-parameters.txt          |  7 -------
 kernel/rcu/Kconfig                             | 18 ------------------
 kernel/rcu/tasks.h                             |  5 -----
 .../selftests/rcutorture/configs/rcu/TRACE01   |  1 -
 .../selftests/rcutorture/configs/rcu/TRACE02   |  1 -
 5 files changed, 32 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 54d31a5e46e1cf..40fc198bed4db9 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6078,13 +6078,6 @@
 			dynamically) adjusted.	This parameter is intended
 			for use in testing.
 
-	rcupdate.rcu_task_ipi_delay= [KNL]
-			Set time in jiffies during which RCU tasks will
-			avoid sending IPIs, starting with the beginning
-			of a given grace period.  Setting a large
-			number avoids disturbing real-time workloads,
-			but lengthens grace periods.
-
 	rcupdate.rcu_task_lazy_lim= [KNL]
 			Number of callbacks on a given CPU that will
 			cancel laziness on that CPU.  Use -1 to disable
diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index eeaa1cd47c6c4c..73a6cc364628b5 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -313,24 +313,6 @@ config RCU_NOCB_CPU_CB_BOOST
 	  Say Y here if you want to set RT priority for offloading kthreads.
 	  Say N here if you are building a !PREEMPT_RT kernel and are unsure.
 
-config TASKS_TRACE_RCU_READ_MB
-	bool "Tasks Trace RCU readers use memory barriers in user and idle"
-	depends on RCU_EXPERT && TASKS_TRACE_RCU
-	default PREEMPT_RT || NR_CPUS < 8
-	help
-	  Use this option to further reduce the number of IPIs sent
-	  to CPUs executing in userspace or idle during tasks trace
-	  RCU grace periods.  Given that a reasonable setting of
-	  the rcupdate.rcu_task_ipi_delay kernel boot parameter
-	  eliminates such IPIs for many workloads, proper setting
-	  of this Kconfig option is important mostly for aggressive
-	  real-time installations and for battery-powered devices,
-	  hence the default chosen above.
-
-	  Say Y here if you hate IPIs.
-	  Say N here if you hate read-side memory barriers.
-	  Take the default if you are unsure.
-
 config RCU_LAZY
 	bool "RCU callback lazy invocation functionality"
 	depends on RCU_NOCB_CPU
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index a3c16e65e16812..833e180db744f2 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -161,11 +161,6 @@ static void tasks_rcu_exit_srcu_stall(struct timer_list *unused);
 static DEFINE_TIMER(tasks_rcu_exit_srcu_stall_timer, tasks_rcu_exit_srcu_stall);
 #endif
 
-/* Avoid IPIing CPUs early in the grace period. */
-#define RCU_TASK_IPI_DELAY (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB) ? HZ / 2 : 0)
-static int rcu_task_ipi_delay __read_mostly = RCU_TASK_IPI_DELAY;
-module_param(rcu_task_ipi_delay, int, 0644);
-
 /* Control stall timeouts.  Disable with <= 0, otherwise jiffies till stall. */
 #define RCU_TASK_BOOT_STALL_TIMEOUT (HZ * 30)
 #define RCU_TASK_STALL_TIMEOUT (HZ * 60 * 10)
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TRACE01 b/tools/testing/selftests/rcutorture/configs/rcu/TRACE01
index 85b407467454a2..18efab346381a4 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TRACE01
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TRACE01
@@ -10,5 +10,4 @@ CONFIG_PROVE_LOCKING=n
 #CHECK#CONFIG_PROVE_RCU=n
 CONFIG_FORCE_TASKS_TRACE_RCU=y
 #CHECK#CONFIG_TASKS_TRACE_RCU=y
-CONFIG_TASKS_TRACE_RCU_READ_MB=y
 CONFIG_RCU_EXPERT=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TRACE02 b/tools/testing/selftests/rcutorture/configs/rcu/TRACE02
index 9003c56cd76484..8da390e8282977 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TRACE02
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TRACE02
@@ -9,6 +9,5 @@ CONFIG_PROVE_LOCKING=y
 #CHECK#CONFIG_PROVE_RCU=y
 CONFIG_FORCE_TASKS_TRACE_RCU=y
 #CHECK#CONFIG_TASKS_TRACE_RCU=y
-CONFIG_TASKS_TRACE_RCU_READ_MB=n
 CONFIG_RCU_EXPERT=y
 CONFIG_DEBUG_OBJECTS=y
-- 
2.40.1


