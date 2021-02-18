Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBA031F23A
	for <lists+bpf@lfdr.de>; Thu, 18 Feb 2021 23:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhBRWWX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Feb 2021 17:22:23 -0500
Received: from mail.efficios.com ([167.114.26.124]:43604 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbhBRWWW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Feb 2021 17:22:22 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 5152D29F110;
        Thu, 18 Feb 2021 17:21:40 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 1K31Gqisp6kR; Thu, 18 Feb 2021 17:21:39 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 53EDC29F10F;
        Thu, 18 Feb 2021 17:21:39 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 53EDC29F10F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1613686899;
        bh=oXKK+BifGFKqJ9M5WUK9tYvuQMuha3slaZjhqDh21Kk=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=nza8EggeIAzUER9ywzq6vg93/QAKYwFQYBuys64Ri4oELKq1syJqagL97HskkkzXX
         p+gRwUZH3PORAeaZxiUtIVC74+wM9EpYFn33yARJVi0aiWj0bdwVhnRnnQqI812bBO
         5ykOTQB0feMOh0Yhd7V0342w4WcZo3UDdVHASszNKv12CzSJQfMaaoXx0ktBpj41oa
         XTZL6drDmavTNOmBceqa2Kg02MjNrhE/bYJGfa2weACQvRbijVdq2OFqs1yAyie+ln
         7DKP60bvTSEKOt5xeoQO5Ne2ch9QMA3x+fcYN+z3YsM8ewm36U54TRPYV7hggB7JFu
         rBUHc+ypoQB2g==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id McF7GAeHtoNo; Thu, 18 Feb 2021 17:21:39 -0500 (EST)
Received: from localhost.localdomain (96-127-212-112.qc.cable.ebox.net [96.127.212.112])
        by mail.efficios.com (Postfix) with ESMTPSA id 0408029EB5A;
        Thu, 18 Feb 2021 17:21:39 -0500 (EST)
From:   Michael Jeanson <mjeanson@efficios.com>
To:     linux-kernel@vger.kernel.org
Cc:     Michael Jeanson <mjeanson@efficios.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
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
Subject: [RFC PATCH 1/6] tracing: introduce faultable tracepoints (v2)
Date:   Thu, 18 Feb 2021 17:21:20 -0500
Message-Id: <20210218222125.46565-2-mjeanson@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210218222125.46565-1-mjeanson@efficios.com>
References: <20210218222125.46565-1-mjeanson@efficios.com>
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

Extend the tracepoint and trace event APIs to allow defining a faultable
tracepoint which invokes its callback with preemption enabled.

Also extend the tracepoint API to allow tracers to request specific
probes to be connected to those faultable tracepoints. When the
TRACEPOINT_MAYFAULT flag is provided on registration, the probe callback
will be called with preemption enabled, and is allowed to take page
faults. Faultable probes can only be registered on faultable
tracepoints and non-faultable probes on non-faultable tracepoints.

The tasks trace rcu mechanism is used to synchronize read-side
marshalling of the registered probes with respect to faultable probes
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
Cc: bpf@vger.kernel.org
Cc: Joel Fernandes <joel@joelfernandes.org>
---
Changes since v1:
- Cleanup __DO_TRACE() implementation.
- Rename "sleepable tracepoints" to "faultable tracepoints", MAYSLEEP to
  MAYFAULT, and use might_fault() rather than might_sleep(), to properly
  convey that the tracepoints are meant to be able to take a page fault,
  which requires to be able to sleep *and* to hold the mmap_sem.
---
 include/linux/tracepoint-defs.h |  11 ++++
 include/linux/tracepoint.h      |  91 ++++++++++++++++++++++------
 include/trace/define_trace.h    |   8 +++
 include/trace/trace_events.h    |   6 ++
 init/Kconfig                    |   1 +
 kernel/tracepoint.c             | 103 ++++++++++++++++++++++++++------
 6 files changed, 186 insertions(+), 34 deletions(-)

diff --git a/include/linux/tracepoint-defs.h b/include/linux/tracepoint-d=
efs.h
index e7c2276be33e..012f1ec6730c 100644
--- a/include/linux/tracepoint-defs.h
+++ b/include/linux/tracepoint-defs.h
@@ -29,6 +29,16 @@ struct tracepoint_func {
 	int prio;
 };
=20
+/**
+ * enum tracepoint_flags - Tracepoint flags
+ * @TRACEPOINT_MAYFAULT: The tracepoint probe callback will be called wi=
th
+ *                       preemption enabled, and is allowed to take page
+ *                       faults.
+ */
+enum tracepoint_flags {
+	TRACEPOINT_MAYFAULT =3D (1 << 0),
+};
+
 struct tracepoint {
 	const char *name;		/* Tracepoint name */
 	struct static_key key;
@@ -38,6 +48,7 @@ struct tracepoint {
 	int (*regfunc)(void);
 	void (*unregfunc)(void);
 	struct tracepoint_func __rcu *funcs;
+	unsigned int flags;
 };
=20
 #ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 966ed8980327..04079cbd2015 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -18,6 +18,7 @@
 #include <linux/types.h>
 #include <linux/cpumask.h>
 #include <linux/rcupdate.h>
+#include <linux/rcupdate_trace.h>
 #include <linux/tracepoint-defs.h>
 #include <linux/static_call.h>
=20
@@ -38,9 +39,14 @@ extern struct srcu_struct tracepoint_srcu;
 extern int
 tracepoint_probe_register(struct tracepoint *tp, void *probe, void *data=
);
 extern int
+tracepoint_probe_register_mayfault(struct tracepoint *tp, void *probe, v=
oid *data);
+extern int
 tracepoint_probe_register_prio(struct tracepoint *tp, void *probe, void =
*data,
 			       int prio);
 extern int
+tracepoint_probe_register_prio_mayfault(struct tracepoint *tp, void *pro=
be, void *data,
+			       int prio);
+extern int
 tracepoint_probe_unregister(struct tracepoint *tp, void *probe, void *da=
ta);
 extern void
 for_each_kernel_tracepoint(void (*fct)(struct tracepoint *tp, void *priv=
),
@@ -80,6 +86,7 @@ int unregister_tracepoint_module_notifier(struct notifi=
er_block *nb)
 #ifdef CONFIG_TRACEPOINTS
 static inline void tracepoint_synchronize_unregister(void)
 {
+	synchronize_rcu_tasks_trace();
 	synchronize_srcu(&tracepoint_srcu);
 	synchronize_rcu();
 }
@@ -166,11 +173,12 @@ static inline struct tracepoint *tracepoint_ptr_der=
ef(tracepoint_ptr_t *p)
  * has a "void" prototype, then it is invalid to declare a function
  * as "(void *, void)".
  */
-#define __DO_TRACE(name, proto, args, cond, rcuidle)			\
+#define __DO_TRACE(name, proto, args, cond, rcuidle, tp_flags)		\
 	do {								\
 		struct tracepoint_func *it_func_ptr;			\
 		int __maybe_unused __idx =3D 0;				\
 		void *__data;						\
+		bool mayfault =3D (tp_flags) & TRACEPOINT_MAYFAULT;	\
 									\
 		if (!(cond))						\
 			return;						\
@@ -178,9 +186,12 @@ static inline struct tracepoint *tracepoint_ptr_dere=
f(tracepoint_ptr_t *p)
 		/* srcu can't be used from NMI */			\
 		WARN_ON_ONCE(rcuidle && in_nmi());			\
 									\
-		/* keep srcu and sched-rcu usage consistent */		\
-		preempt_disable_notrace();				\
-									\
+		if (mayfault) {						\
+			rcu_read_lock_trace();				\
+		} else {						\
+			/* keep srcu and sched-rcu usage consistent */	\
+			preempt_disable_notrace();			\
+		}							\
 		/*							\
 		 * For rcuidle callers, use srcu since sched-rcu	\
 		 * doesn't work from the idle path.			\
@@ -192,6 +203,7 @@ static inline struct tracepoint *tracepoint_ptr_deref=
(tracepoint_ptr_t *p)
 									\
 		it_func_ptr =3D						\
 			rcu_dereference_raw((&__tracepoint_##name)->funcs); \
+									\
 		if (it_func_ptr) {					\
 			__data =3D (it_func_ptr)->data;			\
 			__DO_TRACE_CALL(name)(args);			\
@@ -202,21 +214,24 @@ static inline struct tracepoint *tracepoint_ptr_der=
ef(tracepoint_ptr_t *p)
 			srcu_read_unlock_notrace(&tracepoint_srcu, __idx);\
 		}							\
 									\
-		preempt_enable_notrace();				\
+		if (mayfault)						\
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
 			__DO_TRACE(name,				\
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
@@ -231,7 +246,7 @@ static inline struct tracepoint *tracepoint_ptr_deref=
(tracepoint_ptr_t *p)
  * even when this tracepoint is off. This code has no purpose other than
  * poking RCU a bit.
  */
-#define __DECLARE_TRACE(name, proto, args, cond, data_proto, data_args) =
\
+#define __DECLARE_TRACE(name, proto, args, cond, data_proto, data_args, =
tp_flags) \
 	extern int __traceiter_##name(data_proto);			\
 	DECLARE_STATIC_CALL(tp_func_##name, __traceiter_##name);	\
 	extern struct tracepoint __tracepoint_##name;			\
@@ -241,15 +256,17 @@ static inline struct tracepoint *tracepoint_ptr_der=
ef(tracepoint_ptr_t *p)
 			__DO_TRACE(name,				\
 				TP_PROTO(data_proto),			\
 				TP_ARGS(data_args),			\
-				TP_CONDITION(cond), 0);			\
+				TP_CONDITION(cond), 0, tp_flags);	\
 		if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {		\
 			rcu_read_lock_sched_notrace();			\
 			rcu_dereference_sched(__tracepoint_##name.funcs);\
 			rcu_read_unlock_sched_notrace();		\
 		}							\
+		if ((tp_flags) & TRACEPOINT_MAYFAULT)			\
+			might_fault();					\
 	}								\
 	__DECLARE_TRACE_RCU(name, PARAMS(proto), PARAMS(args),		\
-		PARAMS(cond), PARAMS(data_proto), PARAMS(data_args))	\
+		PARAMS(cond), PARAMS(data_proto), PARAMS(data_args), tp_flags)	\
 	static inline int						\
 	register_trace_##name(void (*probe)(data_proto), void *data)	\
 	{								\
@@ -257,6 +274,12 @@ static inline struct tracepoint *tracepoint_ptr_dere=
f(tracepoint_ptr_t *p)
 						(void *)probe, data);	\
 	}								\
 	static inline int						\
+	register_trace_mayfault_##name(void (*probe)(data_proto), void *data)	\
+	{								\
+		return tracepoint_probe_register_mayfault(&__tracepoint_##name,	\
+						(void *)probe, data);	\
+	}								\
+	static inline int						\
 	register_trace_prio_##name(void (*probe)(data_proto), void *data,\
 				   int prio)				\
 	{								\
@@ -264,6 +287,13 @@ static inline struct tracepoint *tracepoint_ptr_dere=
f(tracepoint_ptr_t *p)
 					      (void *)probe, data, prio); \
 	}								\
 	static inline int						\
+	register_trace_prio_mayfault_##name(void (*probe)(data_proto),	\
+			void *data, int prio)				\
+	{								\
+		return tracepoint_probe_register_prio_mayfault(&__tracepoint_##name, \
+					      (void *)probe, data, prio); \
+	}								\
+	static inline int						\
 	unregister_trace_##name(void (*probe)(data_proto), void *data)	\
 	{								\
 		return tracepoint_probe_unregister(&__tracepoint_##name,\
@@ -284,7 +314,7 @@ static inline struct tracepoint *tracepoint_ptr_deref=
(tracepoint_ptr_t *p)
  * structures, so we create an array of pointers that will be used for i=
teration
  * on the tracepoints.
  */
-#define DEFINE_TRACE_FN(_name, _reg, _unreg, proto, args)		\
+#define DEFINE_TRACE_FN_FLAGS(_name, _reg, _unreg, proto, args, tp_flags=
) \
 	static const char __tpstrtab_##_name[]				\
 	__section("__tracepoints_strings") =3D #_name;			\
 	extern struct static_call_key STATIC_CALL_KEY(tp_func_##_name);	\
@@ -298,7 +328,8 @@ static inline struct tracepoint *tracepoint_ptr_deref=
(tracepoint_ptr_t *p)
 		.iterator =3D &__traceiter_##_name,			\
 		.regfunc =3D _reg,					\
 		.unregfunc =3D _unreg,					\
-		.funcs =3D NULL };					\
+		.funcs =3D NULL,						\
+		.flags =3D tp_flags };					\
 	__TRACEPOINT_ENTRY(_name);					\
 	int __traceiter_##_name(void *__data, proto)			\
 	{								\
@@ -318,8 +349,11 @@ static inline struct tracepoint *tracepoint_ptr_dere=
f(tracepoint_ptr_t *p)
 	}								\
 	DEFINE_STATIC_CALL(tp_func_##_name, __traceiter_##_name);
=20
+#define DEFINE_TRACE_FN(_name, _reg, _unreg, proto, args)		\
+	DEFINE_TRACE_FN_FLAGS(_name, _reg, _unreg, PARAMS(proto), PARAMS(args),=
 0)
+
 #define DEFINE_TRACE(name, proto, args)		\
-	DEFINE_TRACE_FN(name, NULL, NULL, PARAMS(proto), PARAMS(args));
+	DEFINE_TRACE_FN(name, NULL, NULL, PARAMS(proto), PARAMS(args))
=20
 #define EXPORT_TRACEPOINT_SYMBOL_GPL(name)				\
 	EXPORT_SYMBOL_GPL(__tracepoint_##name);				\
@@ -332,7 +366,7 @@ static inline struct tracepoint *tracepoint_ptr_deref=
(tracepoint_ptr_t *p)
=20
=20
 #else /* !TRACEPOINTS_ENABLED */
-#define __DECLARE_TRACE(name, proto, args, cond, data_proto, data_args) =
\
+#define __DECLARE_TRACE(name, proto, args, cond, data_proto, data_args, =
tp_flags) \
 	static inline void trace_##name(proto)				\
 	{ }								\
 	static inline void trace_##name##_rcuidle(proto)		\
@@ -344,6 +378,18 @@ static inline struct tracepoint *tracepoint_ptr_dere=
f(tracepoint_ptr_t *p)
 		return -ENOSYS;						\
 	}								\
 	static inline int						\
+	register_trace_mayfault_##name(void (*probe)(data_proto),	\
+			      void *data)				\
+	{								\
+		return -ENOSYS;						\
+	}								\
+	static inline int						\
+	register_trace_prio_mayfault_##name(void (*probe)(data_proto),	\
+			void *data, int prio)				\
+	{								\
+		return -ENOSYS;						\
+	}								\
+	static inline int						\
 	unregister_trace_##name(void (*probe)(data_proto),		\
 				void *data)				\
 	{								\
@@ -358,6 +404,7 @@ static inline struct tracepoint *tracepoint_ptr_deref=
(tracepoint_ptr_t *p)
 		return false;						\
 	}
=20
+#define DEFINE_TRACE_FN_FLAGS(name, reg, unreg, proto, args, tp_flags)
 #define DEFINE_TRACE_FN(name, reg, unreg, proto, args)
 #define DEFINE_TRACE(name, proto, args)
 #define EXPORT_TRACEPOINT_SYMBOL_GPL(name)
@@ -413,13 +460,20 @@ static inline struct tracepoint *tracepoint_ptr_der=
ef(tracepoint_ptr_t *p)
 	__DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),		\
 			cpu_online(raw_smp_processor_id()),		\
 			PARAMS(void *__data, proto),			\
-			PARAMS(__data, args))
+			PARAMS(__data, args), 0)
+
+#define DECLARE_TRACE_MAYFAULT(name, proto, args)			\
+	__DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),		\
+			cpu_online(raw_smp_processor_id()),		\
+			PARAMS(void *__data, proto),			\
+			PARAMS(__data, args),				\
+			TRACEPOINT_MAYFAULT)
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
@@ -550,6 +604,9 @@ static inline struct tracepoint *tracepoint_ptr_deref=
(tracepoint_ptr_t *p)
 #define TRACE_EVENT_FN(name, proto, args, struct,		\
 		assign, print, reg, unreg)			\
 	DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
+#define TRACE_EVENT_FN_MAYFAULT(name, proto, args, struct,	\
+		assign, print, reg, unreg)			\
+	DECLARE_TRACE_MAYFAULT(name, PARAMS(proto), PARAMS(args))
 #define TRACE_EVENT_FN_COND(name, proto, args, cond, struct,		\
 		assign, print, reg, unreg)			\
 	DECLARE_TRACE_CONDITION(name, PARAMS(proto),	\
diff --git a/include/trace/define_trace.h b/include/trace/define_trace.h
index 00723935dcc7..e08fd5b9a2ac 100644
--- a/include/trace/define_trace.h
+++ b/include/trace/define_trace.h
@@ -41,6 +41,13 @@
 		assign, print, reg, unreg)			\
 	DEFINE_TRACE_FN(name, reg, unreg, PARAMS(proto), PARAMS(args))
=20
+/* Define a trace event with the MAYFAULT flag set */
+#undef TRACE_EVENT_FN_MAYFAULT
+#define TRACE_EVENT_FN_MAYFAULT(name, proto, args, tstruct,		\
+		assign, print, reg, unreg)			\
+	DEFINE_TRACE_FN_FLAGS(name, reg, unreg, PARAMS(proto), PARAMS(args), \
+		TRACEPOINT_MAYFAULT)
+
 #undef TRACE_EVENT_FN_COND
 #define TRACE_EVENT_FN_COND(name, proto, args, cond, tstruct,		\
 		assign, print, reg, unreg)			\
@@ -106,6 +113,7 @@
=20
 #undef TRACE_EVENT
 #undef TRACE_EVENT_FN
+#undef TRACE_EVENT_FN_MAYFAULT
 #undef TRACE_EVENT_FN_COND
 #undef TRACE_EVENT_CONDITION
 #undef TRACE_EVENT_NOP
diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index 7785961d82ba..af9807251226 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -138,6 +138,12 @@ TRACE_MAKE_SYSTEM_STR();
 	TRACE_EVENT(name, PARAMS(proto), PARAMS(args),			\
 		PARAMS(tstruct), PARAMS(assign), PARAMS(print))		\
=20
+#undef TRACE_EVENT_FN_MAYFAULT
+#define TRACE_EVENT_FN_MAYFAULT(name, proto, args, tstruct,		\
+		assign, print, reg, unreg)				\
+	TRACE_EVENT(name, PARAMS(proto), PARAMS(args),			\
+		PARAMS(tstruct), PARAMS(assign), PARAMS(print))		\
+
 #undef TRACE_EVENT_FN_COND
 #define TRACE_EVENT_FN_COND(name, proto, args, cond, tstruct,	\
 		assign, print, reg, unreg)				\
diff --git a/init/Kconfig b/init/Kconfig
index 0872a5a2e759..d3b88f3cdaca 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2032,6 +2032,7 @@ config PROFILING
 #
 config TRACEPOINTS
 	bool
+	select TASKS_TRACE_RCU
=20
 endmenu		# General setup
=20
diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 3f659f855074..41fc9c6e17f6 100644
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
@@ -316,6 +321,21 @@ static int tracepoint_remove_func(struct tracepoint =
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
@@ -323,6 +343,8 @@ static int tracepoint_remove_func(struct tracepoint *=
tp,
  * @data: tracepoint data
  * @prio: priority of this function over other registered functions
  *
+ * Non-faultable probes can only be registered on non-faultable tracepoi=
nts.
+ *
  * Returns 0 if ok, error value on error.
  * Note: if @tp is within a module, the caller is responsible for
  * unregistering the probe before the module is gone. This can be
@@ -332,25 +354,49 @@ static int tracepoint_remove_func(struct tracepoint=
 *tp,
 int tracepoint_probe_register_prio(struct tracepoint *tp, void *probe,
 				   void *data, int prio)
 {
-	struct tracepoint_func tp_func;
-	int ret;
+	if (tp->flags & TRACEPOINT_MAYFAULT)
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
+ * tracepoint_probe_register_prio_mayfault - Connect a faultable probe t=
o a tracepoint with priority
+ * @tp: tracepoint
+ * @probe: probe handler
+ * @data: tracepoint data
+ * @prio: priority of this function over other registered functions
+ *
+ * When the TRACEPOINT_MAYFAULT flag is provided on registration, the pr=
obe
+ * callback will be called with preemption enabled, and is allowed to ta=
ke
+ * page faults. Faultable probes can only be registered on faultable
+ * tracepoints.
+ *
+ * Returns 0 if ok, error value on error.
+ * Note: if @tp is within a module, the caller is responsible for
+ * unregistering the probe before the module is gone. This can be
+ * performed either with a tracepoint module going notifier, or from
+ * within module exit functions.
+ */
+int tracepoint_probe_register_prio_mayfault(struct tracepoint *tp, void =
*probe,
+				   void *data, int prio)
+{
+	if (!(tp->flags & TRACEPOINT_MAYFAULT))
+		return -EINVAL;
+
+	return __tracepoint_probe_register_prio(tp, probe, data, prio);
+}
+EXPORT_SYMBOL_GPL(tracepoint_probe_register_prio_mayfault);
+
 /**
  * tracepoint_probe_register -  Connect a probe to a tracepoint
  * @tp: tracepoint
  * @probe: probe handler
  * @data: tracepoint data
  *
+ * Non-faultable probes can only be registered on non-faultable tracepoi=
nts.
+ *
  * Returns 0 if ok, error value on error.
  * Note: if @tp is within a module, the caller is responsible for
  * unregistering the probe before the module is gone. This can be
@@ -363,6 +409,29 @@ int tracepoint_probe_register(struct tracepoint *tp,=
 void *probe, void *data)
 }
 EXPORT_SYMBOL_GPL(tracepoint_probe_register);
=20
+/**
+ * tracepoint_probe_register_mayfault - Connect a faultable probe to a t=
racepoint
+ * @tp: tracepoint
+ * @probe: probe handler
+ * @data: tracepoint data
+ *
+ * When the TRACEPOINT_MAYFAULT flag is provided on registration, the pr=
obe
+ * callback will be called with preemption enabled, and is allowed to ta=
ke
+ * page faults. Faultable probes can only be registered on faultable
+ * tracepoints.
+ *
+ * Returns 0 if ok, error value on error.
+ * Note: if @tp is within a module, the caller is responsible for
+ * unregistering the probe before the module is gone. This can be
+ * performed either with a tracepoint module going notifier, or from
+ * within module exit functions.
+ */
+int tracepoint_probe_register_mayfault(struct tracepoint *tp, void *prob=
e, void *data)
+{
+	return tracepoint_probe_register_prio_mayfault(tp, probe, data, TRACEPO=
INT_DEFAULT_PRIO);
+}
+EXPORT_SYMBOL_GPL(tracepoint_probe_register_mayfault);
+
 /**
  * tracepoint_probe_unregister -  Disconnect a probe from a tracepoint
  * @tp: tracepoint
--=20
2.25.1

