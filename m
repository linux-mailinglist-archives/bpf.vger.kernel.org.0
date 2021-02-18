Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EADF31F242
	for <lists+bpf@lfdr.de>; Thu, 18 Feb 2021 23:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbhBRWXR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Feb 2021 17:23:17 -0500
Received: from mail.efficios.com ([167.114.26.124]:43958 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbhBRWXD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Feb 2021 17:23:03 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id B0FB429ED44;
        Thu, 18 Feb 2021 17:21:45 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id VxfNbi00qwin; Thu, 18 Feb 2021 17:21:45 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 46DC429EBEB;
        Thu, 18 Feb 2021 17:21:45 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 46DC429EBEB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1613686905;
        bh=DvJvmhd1XT6WR+DvpZp73GnRZszI247Bf2pufI3BR/c=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=de6iV955n35cHvAakiJWghlEwKPvLBkld+/DJsnVzGBZaGn1+lqKEohguGQuKA0hQ
         rENvusv5CzIY2ehOMJXbvojcJIuSgRWIEapPQEnDubNFhgE7Wg/Y4G9U0IArZZRjg4
         OcvpsmyDHN7GUkPs1S7roICdOCONQ+GxiAGb4Yv0m32t0tiR4OV3D4LJnacA2n9QYy
         oITjDVxL3ISRnNfiKU9Rpz2p4XhwSkrbhAMM/pvMrJhiCWlIEe7HKTnhk0RoishQAN
         1Dgwb+5Anc8WBCOPifW0fro+WUJwEqP0m7mfVkfboN7Lh382yxwao0xXHqCA7p0YJv
         s+od7RCJN9qEQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Z31q3WAFJDCQ; Thu, 18 Feb 2021 17:21:45 -0500 (EST)
Received: from localhost.localdomain (96-127-212-112.qc.cable.ebox.net [96.127.212.112])
        by mail.efficios.com (Postfix) with ESMTPSA id E273029EBEA;
        Thu, 18 Feb 2021 17:21:44 -0500 (EST)
From:   Michael Jeanson <mjeanson@efficios.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
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
        Namhyung Kim <namhyung@kernel.org>, bpf@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [RFC PATCH 6/6] tracing: use Tasks Trace RCU instead of SRCU for rcuidle tracepoints
Date:   Thu, 18 Feb 2021 17:21:25 -0500
Message-Id: <20210218222125.46565-7-mjeanson@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210218222125.46565-1-mjeanson@efficios.com>
References: <20210218222125.46565-1-mjeanson@efficios.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Similarly to SRCU, Tasks Trace RCU can be used for rcuidle tracepoints.
It has the advantage to provide faster RCU read-side. Similarly to
SRCU, Tasks Trace RCU grace periods are ready after core_initcall.

Now that Tasks Trace RCU is used for faultable tracepoints, using it for
rcuidle tracepoints is an overall simplification.

Some distinctions between SRCU and Tasks Trace RCU:

- Tasks Trace RCU can be used from NMI context, which was not possible
  with SRCU,
- Tree SRCU has more scalable grace periods than Tasks Trace RCU, but it
  should not matter for tracing use-cases,
- Tasks Trace RCU has slower grace periods than SRCU (similar to those
  of RCU in upcoming kernels, but similar to Tasks RCU in current
  kernels). This should also be OK for tracing,
- SRCU readers can be used in places where Tasks Trace RCU readers cannot=
,
  but these places are also all places where tracing is prohibited.

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
Cc: bpf@vger.kernel.org
Cc: Joel Fernandes <joel@joelfernandes.org>
---
 include/linux/tracepoint.h | 34 ++++++++--------------------------
 kernel/tracepoint.c        | 25 +++++++++----------------
 2 files changed, 17 insertions(+), 42 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 04079cbd2015..c22a87c34a22 100644
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
@@ -34,8 +33,6 @@ struct trace_eval_map {
=20
 #define TRACEPOINT_DEFAULT_PRIO	10
=20
-extern struct srcu_struct tracepoint_srcu;
-
 extern int
 tracepoint_probe_register(struct tracepoint *tp, void *probe, void *data=
);
 extern int
@@ -87,7 +84,6 @@ int unregister_tracepoint_module_notifier(struct notifi=
er_block *nb)
 static inline void tracepoint_synchronize_unregister(void)
 {
 	synchronize_rcu_tasks_trace();
-	synchronize_srcu(&tracepoint_srcu);
 	synchronize_rcu();
 }
 #else
@@ -176,30 +172,19 @@ static inline struct tracepoint *tracepoint_ptr_der=
ef(tracepoint_ptr_t *p)
 #define __DO_TRACE(name, proto, args, cond, rcuidle, tp_flags)		\
 	do {								\
 		struct tracepoint_func *it_func_ptr;			\
-		int __maybe_unused __idx =3D 0;				\
 		void *__data;						\
 		bool mayfault =3D (tp_flags) & TRACEPOINT_MAYFAULT;	\
+		bool tasks_trace_rcu =3D mayfault || (rcuidle);		\
 									\
 		if (!(cond))						\
 			return;						\
 									\
-		/* srcu can't be used from NMI */			\
-		WARN_ON_ONCE(rcuidle && in_nmi());			\
-									\
-		if (mayfault) {						\
-			rcu_read_lock_trace();				\
-		} else {						\
-			/* keep srcu and sched-rcu usage consistent */	\
+		if (!mayfault)						\
 			preempt_disable_notrace();			\
-		}							\
-		/*							\
-		 * For rcuidle callers, use srcu since sched-rcu	\
-		 * doesn't work from the idle path.			\
-		 */							\
-		if (rcuidle) {						\
-			__idx =3D srcu_read_lock_notrace(&tracepoint_srcu);\
+		if (tasks_trace_rcu)					\
+			rcu_read_lock_trace();				\
+		if (rcuidle)						\
 			rcu_irq_enter_irqson();				\
-		}							\
 									\
 		it_func_ptr =3D						\
 			rcu_dereference_raw((&__tracepoint_##name)->funcs); \
@@ -209,14 +194,11 @@ static inline struct tracepoint *tracepoint_ptr_der=
ef(tracepoint_ptr_t *p)
 			__DO_TRACE_CALL(name)(args);			\
 		}							\
 									\
-		if (rcuidle) {						\
+		if (rcuidle)						\
 			rcu_irq_exit_irqson();				\
-			srcu_read_unlock_notrace(&tracepoint_srcu, __idx);\
-		}							\
-									\
-		if (mayfault)						\
+		if (tasks_trace_rcu)					\
 			rcu_read_unlock_trace();			\
-		else							\
+		if (!mayfault)						\
 			preempt_enable_notrace();			\
 	} while (0)
=20
diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 41fc9c6e17f6..efa49f22d435 100644
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

