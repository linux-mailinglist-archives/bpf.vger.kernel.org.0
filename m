Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFC52977E7
	for <lists+bpf@lfdr.de>; Fri, 23 Oct 2020 21:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755127AbgJWTyi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Oct 2020 15:54:38 -0400
Received: from mail.efficios.com ([167.114.26.124]:45648 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750002AbgJWTyU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Oct 2020 15:54:20 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id CB24427927F;
        Fri, 23 Oct 2020 15:54:18 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 8LDav60Vv_2f; Fri, 23 Oct 2020 15:54:17 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id DAE9727933C;
        Fri, 23 Oct 2020 15:54:17 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com DAE9727933C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1603482857;
        bh=CTqY0O67DdCwwsbnyH1KFmTbS8QeXTEz6NpzJqawOzk=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=CzoZZTCoIl9i3DBlG7J33f8PYkDXxys0fCbIfXuR94oDORZ643o4/XUekijYz4pVT
         7AE2u/5VItv8ui/xU2Q/96BxWpJHrJLTAsNC0r+OVwrMxqufe4dwWiPuBL8WlAENV8
         l73SfNWw4gNKIRwzpccO0EOyzZPldbAlxg+/WtluOgnXuBr2LxmQtMerA0a7SevwmV
         M87Biofy3lc3DHrRyVLQ2NHBWROAGgR3TTjmyH6XOw9LG1f5ZGB+0ohr14c+RW1Uaq
         TeHpEoTpl7DyWHIfA+wOpdbmv1u5cB1HndLgBmIvNMW7ptoOMnWV5Z1tqkrcctTr1Q
         N8Q6DRRmzTMbg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9kKYRoZUQbxo; Fri, 23 Oct 2020 15:54:17 -0400 (EDT)
Received: from localhost.localdomain (96-127-212-112.qc.cable.ebox.net [96.127.212.112])
        by mail.efficios.com (Postfix) with ESMTPSA id 7B637279620;
        Fri, 23 Oct 2020 15:54:17 -0400 (EDT)
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
Subject: [RFC PATCH 1/6] tracing: introduce sleepable tracepoints
Date:   Fri, 23 Oct 2020 15:53:47 -0400
Message-Id: <20201023195352.26269-2-mjeanson@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201023195352.26269-1-mjeanson@efficios.com>
References: <20201023195352.26269-1-mjeanson@efficios.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When invoked from system call enter/exit instrumentation, accessing
user-space data is a common use-case for tracers. However, tracepoints
currently disable preemption around iteration on the registered
tracepoint probes and invocation of the probe callbacks, which prevents
tracers from handling page faults.

Extend the tracepoint and trace event APIs to allow defining a sleepable
tracepoint which invokes its callback with preemption enabled.

Also extend the tracepoint API to allow tracers to request specific
probes to be connected to those sleepable tracepoints. When the
TRACEPOINT_MAYSLEEP flag is provided on registration, the probe callback
will be called with preemption enabled, and is allowed to take page
faults. Sleepable probes can only be registered on sleepable
tracepoints and non-sleepable probes on non-sleepable tracepoints.

The tasks trace rcu mechanism is used to synchronize read-side
marshalling of the registered probes with respect to sleepable probes
unregistration and teardown.

Co-developed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
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
 include/linux/tracepoint-defs.h |  11 ++++
 include/linux/tracepoint.h      |  85 +++++++++++++++++++++-----
 include/trace/define_trace.h    |   7 +++
 include/trace/trace_events.h    |   6 ++
 init/Kconfig                    |   1 +
 kernel/tracepoint.c             | 103 ++++++++++++++++++++++++++------
 6 files changed, 181 insertions(+), 32 deletions(-)

diff --git a/include/linux/tracepoint-defs.h b/include/linux/tracepoint-d=
efs.h
index b29950a19205..87ff40cf343f 100644
--- a/include/linux/tracepoint-defs.h
+++ b/include/linux/tracepoint-defs.h
@@ -27,12 +27,23 @@ struct tracepoint_func {
 	int prio;
 };
=20
+/**
+ * enum tracepoint_flags - Tracepoint flags
+ * @TRACEPOINT_MAYSLEEP: The tracepoint probe callback will be called wi=
th
+ *                       preemption enabled, and is allowed to take page
+ *                       faults.
+ */
+enum tracepoint_flags {
+	TRACEPOINT_MAYSLEEP =3D (1 << 0),
+};
+
 struct tracepoint {
 	const char *name;		/* Tracepoint name */
 	struct static_key key;
 	int (*regfunc)(void);
 	void (*unregfunc)(void);
 	struct tracepoint_func __rcu *funcs;
+	unsigned int flags;
 };
=20
 #ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 598fec9f9dbf..0386b54cbcbb 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -18,6 +18,7 @@
 #include <linux/types.h>
 #include <linux/cpumask.h>
 #include <linux/rcupdate.h>
+#include <linux/rcupdate_trace.h>
 #include <linux/tracepoint-defs.h>
=20
 struct module;
@@ -37,9 +38,14 @@ extern struct srcu_struct tracepoint_srcu;
 extern int
 tracepoint_probe_register(struct tracepoint *tp, void *probe, void *data=
);
 extern int
+tracepoint_probe_register_maysleep(struct tracepoint *tp, void *probe, v=
oid *data);
+extern int
 tracepoint_probe_register_prio(struct tracepoint *tp, void *probe, void =
*data,
 			       int prio);
 extern int
+tracepoint_probe_register_prio_maysleep(struct tracepoint *tp, void *pro=
be, void *data,
+			       int prio);
+extern int
 tracepoint_probe_unregister(struct tracepoint *tp, void *probe, void *da=
ta);
 extern void
 for_each_kernel_tracepoint(void (*fct)(struct tracepoint *tp, void *priv=
),
@@ -79,6 +85,7 @@ int unregister_tracepoint_module_notifier(struct notifi=
er_block *nb)
 #ifdef CONFIG_TRACEPOINTS
 static inline void tracepoint_synchronize_unregister(void)
 {
+	synchronize_rcu_tasks_trace();
 	synchronize_srcu(&tracepoint_srcu);
 	synchronize_rcu();
 }
@@ -157,12 +164,13 @@ static inline struct tracepoint *tracepoint_ptr_der=
ef(tracepoint_ptr_t *p)
  * has a "void" prototype, then it is invalid to declare a function
  * as "(void *, void)".
  */
-#define __DO_TRACE(tp, proto, args, cond, rcuidle)			\
+#define __DO_TRACE(tp, proto, args, cond, rcuidle, tp_flags)		\
 	do {								\
 		struct tracepoint_func *it_func_ptr;			\
 		void *it_func;						\
 		void *__data;						\
 		int __maybe_unused __idx =3D 0;				\
+		bool maysleep =3D (tp_flags) & TRACEPOINT_MAYSLEEP;	\
 									\
 		if (!(cond))						\
 			return;						\
@@ -170,8 +178,13 @@ static inline struct tracepoint *tracepoint_ptr_dere=
f(tracepoint_ptr_t *p)
 		/* srcu can't be used from NMI */			\
 		WARN_ON_ONCE(rcuidle && in_nmi());			\
 									\
-		/* keep srcu and sched-rcu usage consistent */		\
-		preempt_disable_notrace();				\
+		if (maysleep) {						\
+			might_sleep();					\
+			rcu_read_lock_trace();				\
+		} else {						\
+			/* keep srcu and sched-rcu usage consistent */	\
+			preempt_disable_notrace();			\
+		}							\
 									\
 		/*							\
 		 * For rcuidle callers, use srcu since sched-rcu	\
@@ -197,21 +210,24 @@ static inline struct tracepoint *tracepoint_ptr_der=
ef(tracepoint_ptr_t *p)
 			srcu_read_unlock_notrace(&tracepoint_srcu, __idx);\
 		}							\
 									\
-		preempt_enable_notrace();				\
+		if (maysleep)						\
+			rcu_read_unlock_trace();			\
+		else							\
+			preempt_enable_notrace();			\
 	} while (0)
=20
 #ifndef MODULE
-#define __DECLARE_TRACE_RCU(name, proto, args, cond, data_proto, data_ar=
gs) \
+#define __DECLARE_TRACE_RCU(name, proto, args, cond, data_proto, data_ar=
gs, tp_flags) \
 	static inline void trace_##name##_rcuidle(proto)		\
 	{								\
 		if (static_key_false(&__tracepoint_##name.key))		\
 			__DO_TRACE(&__tracepoint_##name,		\
 				TP_PROTO(data_proto),			\
 				TP_ARGS(data_args),			\
-				TP_CONDITION(cond), 1);			\
+				TP_CONDITION(cond), 1, tp_flags);	\
 	}
 #else
-#define __DECLARE_TRACE_RCU(name, proto, args, cond, data_proto, data_ar=
gs)
+#define __DECLARE_TRACE_RCU(name, proto, args, cond, data_proto, data_ar=
gs, tp_flags)
 #endif
=20
 /*
@@ -226,7 +242,7 @@ static inline struct tracepoint *tracepoint_ptr_deref=
(tracepoint_ptr_t *p)
  * even when this tracepoint is off. This code has no purpose other than
  * poking RCU a bit.
  */
-#define __DECLARE_TRACE(name, proto, args, cond, data_proto, data_args) =
\
+#define __DECLARE_TRACE(name, proto, args, cond, data_proto, data_args, =
tp_flags) \
 	extern struct tracepoint __tracepoint_##name;			\
 	static inline void trace_##name(proto)				\
 	{								\
@@ -234,7 +250,7 @@ static inline struct tracepoint *tracepoint_ptr_deref=
(tracepoint_ptr_t *p)
 			__DO_TRACE(&__tracepoint_##name,		\
 				TP_PROTO(data_proto),			\
 				TP_ARGS(data_args),			\
-				TP_CONDITION(cond), 0);			\
+				TP_CONDITION(cond), 0, tp_flags);	\
 		if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {		\
 			rcu_read_lock_sched_notrace();			\
 			rcu_dereference_sched(__tracepoint_##name.funcs);\
@@ -242,7 +258,7 @@ static inline struct tracepoint *tracepoint_ptr_deref=
(tracepoint_ptr_t *p)
 		}							\
 	}								\
 	__DECLARE_TRACE_RCU(name, PARAMS(proto), PARAMS(args),		\
-		PARAMS(cond), PARAMS(data_proto), PARAMS(data_args))	\
+		PARAMS(cond), PARAMS(data_proto), PARAMS(data_args), tp_flags)	\
 	static inline int						\
 	register_trace_##name(void (*probe)(data_proto), void *data)	\
 	{								\
@@ -250,6 +266,12 @@ static inline struct tracepoint *tracepoint_ptr_dere=
f(tracepoint_ptr_t *p)
 						(void *)probe, data);	\
 	}								\
 	static inline int						\
+	register_trace_maysleep_##name(void (*probe)(data_proto), void *data)	\
+	{								\
+		return tracepoint_probe_register_maysleep(&__tracepoint_##name,	\
+						(void *)probe, data);	\
+	}								\
+	static inline int						\
 	register_trace_prio_##name(void (*probe)(data_proto), void *data,\
 				   int prio)				\
 	{								\
@@ -257,6 +279,13 @@ static inline struct tracepoint *tracepoint_ptr_dere=
f(tracepoint_ptr_t *p)
 					      (void *)probe, data, prio); \
 	}								\
 	static inline int						\
+	register_trace_prio_maysleep_##name(void (*probe)(data_proto),	\
+			void *data, int prio)				\
+	{								\
+		return tracepoint_probe_register_prio_maysleep(&__tracepoint_##name, \
+					      (void *)probe, data, prio); \
+	}								\
+	static inline int						\
 	unregister_trace_##name(void (*probe)(data_proto), void *data)	\
 	{								\
 		return tracepoint_probe_unregister(&__tracepoint_##name,\
@@ -277,14 +306,17 @@ static inline struct tracepoint *tracepoint_ptr_der=
ef(tracepoint_ptr_t *p)
  * structures, so we create an array of pointers that will be used for i=
teration
  * on the tracepoints.
  */
-#define DEFINE_TRACE_FN(name, reg, unreg)				 \
+#define DEFINE_TRACE_FN_FLAGS(name, reg, unreg, tp_flags)		 \
 	static const char __tpstrtab_##name[]				 \
 	__section(__tracepoints_strings) =3D #name;			 \
 	struct tracepoint __tracepoint_##name __used			 \
 	__section(__tracepoints) =3D					 \
-		{ __tpstrtab_##name, STATIC_KEY_INIT_FALSE, reg, unreg, NULL };\
+		{ __tpstrtab_##name, STATIC_KEY_INIT_FALSE, reg, unreg, NULL, tp_flags=
 };\
 	__TRACEPOINT_ENTRY(name);
=20
+#define DEFINE_TRACE_FN(name, reg, unreg)				\
+	DEFINE_TRACE_FN_FLAGS(name, reg, unreg, 0)
+
 #define DEFINE_TRACE(name)						\
 	DEFINE_TRACE_FN(name, NULL, NULL);
=20
@@ -294,7 +326,7 @@ static inline struct tracepoint *tracepoint_ptr_deref=
(tracepoint_ptr_t *p)
 	EXPORT_SYMBOL(__tracepoint_##name)
=20
 #else /* !TRACEPOINTS_ENABLED */
-#define __DECLARE_TRACE(name, proto, args, cond, data_proto, data_args) =
\
+#define __DECLARE_TRACE(name, proto, args, cond, data_proto, data_args, =
tp_flags) \
 	static inline void trace_##name(proto)				\
 	{ }								\
 	static inline void trace_##name##_rcuidle(proto)		\
@@ -306,6 +338,18 @@ static inline struct tracepoint *tracepoint_ptr_dere=
f(tracepoint_ptr_t *p)
 		return -ENOSYS;						\
 	}								\
 	static inline int						\
+	register_trace_maysleep_##name(void (*probe)(data_proto),	\
+			      void *data)				\
+	{								\
+		return -ENOSYS;						\
+	}								\
+	static inline int						\
+	register_trace_prio_maysleep_##name(void (*probe)(data_proto),	\
+			void *data, int prio)				\
+	{								\
+		return -ENOSYS;						\
+	}								\
+	static inline int						\
 	unregister_trace_##name(void (*probe)(data_proto),		\
 				void *data)				\
 	{								\
@@ -320,6 +364,7 @@ static inline struct tracepoint *tracepoint_ptr_deref=
(tracepoint_ptr_t *p)
 		return false;						\
 	}
=20
+#define DEFINE_TRACE_FN_FLAGS(name, reg, unreg, tp_flags)
 #define DEFINE_TRACE_FN(name, reg, unreg)
 #define DEFINE_TRACE(name)
 #define EXPORT_TRACEPOINT_SYMBOL_GPL(name)
@@ -375,13 +420,20 @@ static inline struct tracepoint *tracepoint_ptr_der=
ef(tracepoint_ptr_t *p)
 	__DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),		\
 			cpu_online(raw_smp_processor_id()),		\
 			PARAMS(void *__data, proto),			\
-			PARAMS(__data, args))
+			PARAMS(__data, args), 0)
+
+#define DECLARE_TRACE_MAYSLEEP(name, proto, args)			\
+	__DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),		\
+			cpu_online(raw_smp_processor_id()),		\
+			PARAMS(void *__data, proto),			\
+			PARAMS(__data, args),				\
+			TRACEPOINT_MAYSLEEP)
=20
 #define DECLARE_TRACE_CONDITION(name, proto, args, cond)		\
 	__DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),		\
 			cpu_online(raw_smp_processor_id()) && (PARAMS(cond)), \
 			PARAMS(void *__data, proto),			\
-			PARAMS(__data, args))
+			PARAMS(__data, args), 0)
=20
 #define TRACE_EVENT_FLAGS(event, flag)
=20
@@ -512,6 +564,9 @@ static inline struct tracepoint *tracepoint_ptr_deref=
(tracepoint_ptr_t *p)
 #define TRACE_EVENT_FN(name, proto, args, struct,		\
 		assign, print, reg, unreg)			\
 	DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
+#define TRACE_EVENT_FN_MAYSLEEP(name, proto, args, struct,	\
+		assign, print, reg, unreg)			\
+	DECLARE_TRACE_MAYSLEEP(name, PARAMS(proto), PARAMS(args))
 #define TRACE_EVENT_FN_COND(name, proto, args, cond, struct,		\
 		assign, print, reg, unreg)			\
 	DECLARE_TRACE_CONDITION(name, PARAMS(proto),	\
diff --git a/include/trace/define_trace.h b/include/trace/define_trace.h
index bd75f97867b9..2b6ae7c978b3 100644
--- a/include/trace/define_trace.h
+++ b/include/trace/define_trace.h
@@ -41,6 +41,12 @@
 		assign, print, reg, unreg)			\
 	DEFINE_TRACE_FN(name, reg, unreg)
=20
+/* Define a trace event with the MAYSLEEP flag set */
+#undef TRACE_EVENT_FN_MAYSLEEP
+#define TRACE_EVENT_FN_MAYSLEEP(name, proto, args, tstruct,		\
+		assign, print, reg, unreg)			\
+	DEFINE_TRACE_FN_FLAGS(name, reg, unreg, TRACEPOINT_MAYSLEEP)
+
 #undef TRACE_EVENT_FN_COND
 #define TRACE_EVENT_FN_COND(name, proto, args, cond, tstruct,		\
 		assign, print, reg, unreg)			\
@@ -106,6 +112,7 @@
=20
 #undef TRACE_EVENT
 #undef TRACE_EVENT_FN
+#undef TRACE_EVENT_FN_MAYSLEEP
 #undef TRACE_EVENT_FN_COND
 #undef TRACE_EVENT_CONDITION
 #undef TRACE_EVENT_NOP
diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index 1bc3e7bba9a4..8b3f4068a702 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -138,6 +138,12 @@ TRACE_MAKE_SYSTEM_STR();
 	TRACE_EVENT(name, PARAMS(proto), PARAMS(args),			\
 		PARAMS(tstruct), PARAMS(assign), PARAMS(print))		\
=20
+#undef TRACE_EVENT_FN_MAYSLEEP
+#define TRACE_EVENT_FN_MAYSLEEP(name, proto, args, tstruct,		\
+		assign, print, reg, unreg)				\
+	TRACE_EVENT(name, PARAMS(proto), PARAMS(args),			\
+		PARAMS(tstruct), PARAMS(assign), PARAMS(print))		\
+
 #undef TRACE_EVENT_FN_COND
 #define TRACE_EVENT_FN_COND(name, proto, args, cond, tstruct,	\
 		assign, print, reg, unreg)				\
diff --git a/init/Kconfig b/init/Kconfig
index d6a0b31b13dc..857f57562490 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2018,6 +2018,7 @@ config PROFILING
 #
 config TRACEPOINTS
 	bool
+	select TASKS_TRACE_RCU
=20
 endmenu		# General setup
=20
diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 73956eaff8a9..8d8e41c5d8a5 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -60,11 +60,16 @@ static inline void *allocate_probes(int count)
 	return p =3D=3D NULL ? NULL : p->probes;
 }
=20
-static void srcu_free_old_probes(struct rcu_head *head)
+static void rcu_tasks_trace_free_old_probes(struct rcu_head *head)
 {
 	kfree(container_of(head, struct tp_probes, rcu));
 }
=20
+static void srcu_free_old_probes(struct rcu_head *head)
+{
+	call_rcu_tasks_trace(head, rcu_tasks_trace_free_old_probes);
+}
+
 static void rcu_free_old_probes(struct rcu_head *head)
 {
 	call_srcu(&tracepoint_srcu, head, srcu_free_old_probes);
@@ -85,7 +90,7 @@ static __init int release_early_probes(void)
 	return 0;
 }
=20
-/* SRCU is initialized at core_initcall */
+/* SRCU and Tasks Trace RCU are initialized at core_initcall */
 postcore_initcall(release_early_probes);
=20
 static inline void release_probes(struct tracepoint_func *old)
@@ -95,8 +100,9 @@ static inline void release_probes(struct tracepoint_fu=
nc *old)
 			struct tp_probes, probes[0]);
=20
 		/*
-		 * We can't free probes if SRCU is not initialized yet.
-		 * Postpone the freeing till after SRCU is initialized.
+		 * We can't free probes if SRCU and Tasks Trace RCU are not
+		 * initialized yet. Postpone the freeing till after both are
+		 * initialized.
 		 */
 		if (unlikely(!ok_to_free_tracepoints)) {
 			tp_probes->rcu.next =3D early_probes;
@@ -105,10 +111,9 @@ static inline void release_probes(struct tracepoint_=
func *old)
 		}
=20
 		/*
-		 * Tracepoint probes are protected by both sched RCU and SRCU,
-		 * by calling the SRCU callback in the sched RCU callback we
-		 * cover both cases. So let us chain the SRCU and sched RCU
-		 * callbacks to wait for both grace periods.
+		 * Tracepoint probes are protected by sched RCU, SRCU and
+		 * Tasks Trace RCU by chaining the callbacks we cover all three
+		 * cases and wait for all three grace periods.
 		 */
 		call_rcu(&tp_probes->rcu, rcu_free_old_probes);
 	}
@@ -289,6 +294,21 @@ static int tracepoint_remove_func(struct tracepoint =
*tp,
 	return 0;
 }
=20
+static int __tracepoint_probe_register_prio(struct tracepoint *tp, void =
*probe,
+				   void *data, int prio)
+{
+	struct tracepoint_func tp_func;
+	int ret;
+
+	mutex_lock(&tracepoints_mutex);
+	tp_func.func =3D probe;
+	tp_func.data =3D data;
+	tp_func.prio =3D prio;
+	ret =3D tracepoint_add_func(tp, &tp_func, prio);
+	mutex_unlock(&tracepoints_mutex);
+	return ret;
+}
+
 /**
  * tracepoint_probe_register_prio -  Connect a probe to a tracepoint wit=
h priority
  * @tp: tracepoint
@@ -296,6 +316,8 @@ static int tracepoint_remove_func(struct tracepoint *=
tp,
  * @data: tracepoint data
  * @prio: priority of this function over other registered functions
  *
+ * Non-sleepable probes can only be registered on non-sleepable tracepoi=
nts.
+ *
  * Returns 0 if ok, error value on error.
  * Note: if @tp is within a module, the caller is responsible for
  * unregistering the probe before the module is gone. This can be
@@ -305,25 +327,49 @@ static int tracepoint_remove_func(struct tracepoint=
 *tp,
 int tracepoint_probe_register_prio(struct tracepoint *tp, void *probe,
 				   void *data, int prio)
 {
-	struct tracepoint_func tp_func;
-	int ret;
+	if (tp->flags & TRACEPOINT_MAYSLEEP)
+		return -EINVAL;
=20
-	mutex_lock(&tracepoints_mutex);
-	tp_func.func =3D probe;
-	tp_func.data =3D data;
-	tp_func.prio =3D prio;
-	ret =3D tracepoint_add_func(tp, &tp_func, prio);
-	mutex_unlock(&tracepoints_mutex);
-	return ret;
+	return __tracepoint_probe_register_prio(tp, probe, data, prio);
 }
 EXPORT_SYMBOL_GPL(tracepoint_probe_register_prio);
=20
+/**
+ * tracepoint_probe_register_prio_maysleep - Connect a sleepable probe t=
o a tracepoint with priority
+ * @tp: tracepoint
+ * @probe: probe handler
+ * @data: tracepoint data
+ * @prio: priority of this function over other registered functions
+ *
+ * When the TRACEPOINT_MAYSLEEP flag is provided on registration, the pr=
obe
+ * callback will be called with preemption enabled, and is allowed to ta=
ke
+ * page faults. Sleepable probes can only be registered on sleepable
+ * tracepoints.
+ *
+ * Returns 0 if ok, error value on error.
+ * Note: if @tp is within a module, the caller is responsible for
+ * unregistering the probe before the module is gone. This can be
+ * performed either with a tracepoint module going notifier, or from
+ * within module exit functions.
+ */
+int tracepoint_probe_register_prio_maysleep(struct tracepoint *tp, void =
*probe,
+				   void *data, int prio)
+{
+	if (!(tp->flags & TRACEPOINT_MAYSLEEP))
+		return -EINVAL;
+
+	return __tracepoint_probe_register_prio(tp, probe, data, prio);
+}
+EXPORT_SYMBOL_GPL(tracepoint_probe_register_prio_maysleep);
+
 /**
  * tracepoint_probe_register -  Connect a probe to a tracepoint
  * @tp: tracepoint
  * @probe: probe handler
  * @data: tracepoint data
  *
+ * Non-sleepable probes can only be registered on non-sleepable tracepoi=
nts.
+ *
  * Returns 0 if ok, error value on error.
  * Note: if @tp is within a module, the caller is responsible for
  * unregistering the probe before the module is gone. This can be
@@ -336,6 +382,29 @@ int tracepoint_probe_register(struct tracepoint *tp,=
 void *probe, void *data)
 }
 EXPORT_SYMBOL_GPL(tracepoint_probe_register);
=20
+/**
+ * tracepoint_probe_register_maysleep - Connect a sleepable probe to a t=
racepoint
+ * @tp: tracepoint
+ * @probe: probe handler
+ * @data: tracepoint data
+ *
+ * When the TRACEPOINT_MAYSLEEP flag is provided on registration, the pr=
obe
+ * callback will be called with preemption enabled, and is allowed to ta=
ke
+ * page faults. Sleepable probes can only be registered on sleepable
+ * tracepoints.
+ *
+ * Returns 0 if ok, error value on error.
+ * Note: if @tp is within a module, the caller is responsible for
+ * unregistering the probe before the module is gone. This can be
+ * performed either with a tracepoint module going notifier, or from
+ * within module exit functions.
+ */
+int tracepoint_probe_register_maysleep(struct tracepoint *tp, void *prob=
e, void *data)
+{
+	return tracepoint_probe_register_prio_maysleep(tp, probe, data, TRACEPO=
INT_DEFAULT_PRIO);
+}
+EXPORT_SYMBOL_GPL(tracepoint_probe_register_maysleep);
+
 /**
  * tracepoint_probe_unregister -  Disconnect a probe from a tracepoint
  * @tp: tracepoint
--=20
2.25.1

