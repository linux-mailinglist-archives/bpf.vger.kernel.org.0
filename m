Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5DF52977E4
	for <lists+bpf@lfdr.de>; Fri, 23 Oct 2020 21:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755093AbgJWTyd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Oct 2020 15:54:33 -0400
Received: from mail.efficios.com ([167.114.26.124]:45766 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755006AbgJWTyV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Oct 2020 15:54:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 6EDFC27969A;
        Fri, 23 Oct 2020 15:54:20 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id jXavxSd7PtMQ; Fri, 23 Oct 2020 15:54:20 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 0072727979E;
        Fri, 23 Oct 2020 15:54:20 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 0072727979E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1603482860;
        bh=j9UnACLjaWXUFo/av68UOdzNoWRf/HE9TVrjkJrsWRU=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=FER/C7w270ug+KSJHcCBfyo3oaJ8nz40XK6yMAvydFSXmhZk5/rKseIWmdYqcExqc
         j0FPC4yoUENNueuIIPRaSKl61V7H1aSFVuWaWNaXC20VEDQtW7UBJzbAYHNoiJtg2p
         buuRbfMOpL9HwiBdPiLYmgifvfzyrAx/8uSXEhm72vNIQ2lWQkSpPf7DQP0/SWSUDZ
         lq5wzhJQua3SZliRAyxnsueizOM5GJk7HZbjAfLAPkHZkswgJS+IkD9BjLMuceQI6K
         9gIZbbLKji17dvAgR2jdGW6cc9AzHIPuW+UMvg7+aSuGG6Z40mW0yj2ODkkGluBWHL
         09PZcurWVIBtQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id oNOK1vXrZYpn; Fri, 23 Oct 2020 15:54:19 -0400 (EDT)
Received: from localhost.localdomain (96-127-212-112.qc.cable.ebox.net [96.127.212.112])
        by mail.efficios.com (Postfix) with ESMTPSA id 618C027971A;
        Fri, 23 Oct 2020 15:54:19 -0400 (EDT)
From:   Michael Jeanson <mjeanson@efficios.com>
To:     linux-kernel@vger.kernel.org
Cc:     mathieu.desnoyers@efficios.com,
        Michael Jeanson <mjeanson@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>, bpf@vger.kernel.org
Subject: [RFC PATCH 6/6] tracing: use sched-RCU instead of SRCU for rcuidle tracepoints
Date:   Fri, 23 Oct 2020 15:53:52 -0400
Message-Id: <20201023195352.26269-7-mjeanson@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201023195352.26269-1-mjeanson@efficios.com>
References: <20201023195352.26269-1-mjeanson@efficios.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Considering that tracer callbacks expect RCU to be watching (for
instance, perf uses rcu_read_lock), we need rcuidle tracepoints to issue
rcu_irq_{enter,exit}_irqson around calls to the callbacks. So there is
no point in using SRCU anymore given that rcuidle tracepoints need to
ensure RCU is watching. Therefore, simply use sched-RCU like normal
tracepoints for rcuidle tracepoints.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Michael Jeanson <mjeanson@efficios.com>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Yonghong Song <yhs@fb.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Cc: bpf@vger.kernel.org
---
 include/linux/tracepoint.h | 33 +++++++--------------------------
 kernel/tracepoint.c        | 25 +++++++++----------------
 2 files changed, 16 insertions(+), 42 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 0386b54cbcbb..1414b11f864b 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -13,7 +13,6 @@
  */
=20
 #include <linux/smp.h>
-#include <linux/srcu.h>
 #include <linux/errno.h>
 #include <linux/types.h>
 #include <linux/cpumask.h>
@@ -33,8 +32,6 @@ struct trace_eval_map {
=20
 #define TRACEPOINT_DEFAULT_PRIO	10
=20
-extern struct srcu_struct tracepoint_srcu;
-
 extern int
 tracepoint_probe_register(struct tracepoint *tp, void *probe, void *data=
);
 extern int
@@ -86,7 +83,6 @@ int unregister_tracepoint_module_notifier(struct notifi=
er_block *nb)
 static inline void tracepoint_synchronize_unregister(void)
 {
 	synchronize_rcu_tasks_trace();
-	synchronize_srcu(&tracepoint_srcu);
 	synchronize_rcu();
 }
 #else
@@ -175,25 +171,13 @@ static inline struct tracepoint *tracepoint_ptr_der=
ef(tracepoint_ptr_t *p)
 		if (!(cond))						\
 			return;						\
 									\
-		/* srcu can't be used from NMI */			\
-		WARN_ON_ONCE(rcuidle && in_nmi());			\
-									\
-		if (maysleep) {						\
-			might_sleep();					\
+		might_sleep_if(maysleep);				\
+		if (rcuidle)						\
+			rcu_irq_enter_irqson();				\
+		if (maysleep)						\
 			rcu_read_lock_trace();				\
-		} else {						\
-			/* keep srcu and sched-rcu usage consistent */	\
+		else							\
 			preempt_disable_notrace();			\
-		}							\
-									\
-		/*							\
-		 * For rcuidle callers, use srcu since sched-rcu	\
-		 * doesn't work from the idle path.			\
-		 */							\
-		if (rcuidle) {						\
-			__idx =3D srcu_read_lock_notrace(&tracepoint_srcu);\
-			rcu_irq_enter_irqson();				\
-		}							\
 									\
 		it_func_ptr =3D rcu_dereference_raw((tp)->funcs);		\
 									\
@@ -205,15 +189,12 @@ static inline struct tracepoint *tracepoint_ptr_der=
ef(tracepoint_ptr_t *p)
 			} while ((++it_func_ptr)->func);		\
 		}							\
 									\
-		if (rcuidle) {						\
-			rcu_irq_exit_irqson();				\
-			srcu_read_unlock_notrace(&tracepoint_srcu, __idx);\
-		}							\
-									\
 		if (maysleep)						\
 			rcu_read_unlock_trace();			\
 		else							\
 			preempt_enable_notrace();			\
+		if (rcuidle)						\
+			rcu_irq_exit_irqson();				\
 	} while (0)
=20
 #ifndef MODULE
diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 8d8e41c5d8a5..68b4e50798b1 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -18,9 +18,6 @@
 extern tracepoint_ptr_t __start___tracepoints_ptrs[];
 extern tracepoint_ptr_t __stop___tracepoints_ptrs[];
=20
-DEFINE_SRCU(tracepoint_srcu);
-EXPORT_SYMBOL_GPL(tracepoint_srcu);
-
 /* Set to 1 to enable tracepoint debug output */
 static const int tracepoint_debug;
=20
@@ -65,14 +62,9 @@ static void rcu_tasks_trace_free_old_probes(struct rcu=
_head *head)
 	kfree(container_of(head, struct tp_probes, rcu));
 }
=20
-static void srcu_free_old_probes(struct rcu_head *head)
-{
-	call_rcu_tasks_trace(head, rcu_tasks_trace_free_old_probes);
-}
-
 static void rcu_free_old_probes(struct rcu_head *head)
 {
-	call_srcu(&tracepoint_srcu, head, srcu_free_old_probes);
+	call_rcu_tasks_trace(head, rcu_tasks_trace_free_old_probes);
 }
=20
 static __init int release_early_probes(void)
@@ -90,7 +82,7 @@ static __init int release_early_probes(void)
 	return 0;
 }
=20
-/* SRCU and Tasks Trace RCU are initialized at core_initcall */
+/* Tasks Trace RCU is initialized at core_initcall */
 postcore_initcall(release_early_probes);
=20
 static inline void release_probes(struct tracepoint_func *old)
@@ -100,9 +92,8 @@ static inline void release_probes(struct tracepoint_fu=
nc *old)
 			struct tp_probes, probes[0]);
=20
 		/*
-		 * We can't free probes if SRCU and Tasks Trace RCU are not
-		 * initialized yet. Postpone the freeing till after both are
-		 * initialized.
+		 * We can't free probes if Tasks Trace RCU is not initialized yet.
+		 * Postpone the freeing till after Tasks Trace RCU is initialized.
 		 */
 		if (unlikely(!ok_to_free_tracepoints)) {
 			tp_probes->rcu.next =3D early_probes;
@@ -111,9 +102,11 @@ static inline void release_probes(struct tracepoint_=
func *old)
 		}
=20
 		/*
-		 * Tracepoint probes are protected by sched RCU, SRCU and
-		 * Tasks Trace RCU by chaining the callbacks we cover all three
-		 * cases and wait for all three grace periods.
+		 * Tracepoint probes are protected by both sched RCU and
+		 * Tasks Trace RCU, by calling the Tasks Trace RCU callback in
+		 * the sched RCU callback we cover both cases. So let us chain
+		 * the Tasks Trace RCU and sched RCU callbacks to wait for both
+		 * grace periods.
 		 */
 		call_rcu(&tp_probes->rcu, rcu_free_old_probes);
 	}
--=20
2.25.1

