Return-Path: <bpf+bounces-33263-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D6591AB1A
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 17:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A0F61C228EB
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 15:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045C61991DD;
	Thu, 27 Jun 2024 15:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="mbxA+lR+"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB004198A09;
	Thu, 27 Jun 2024 15:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719501793; cv=none; b=kr52Nhnp8QFkKkzn5ucfR87NXviHSQI1YtskUTAmU+HbuCyQcuw1BYggWApVRrZfeNfWs3Ceg/ojzDWVkbt3EM0/NTAd0uLvB0Qs54sHgZUza7RYDet4j+PK31CDFQ6Ryul1qwGjGu9trLbQjzmtvGTjXZ0zRwDP1jZa7gxn058=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719501793; c=relaxed/simple;
	bh=dqQyq+JWny1Zk9kPrnxbdc4Bt8ivWO1bh2Qq0DoNRlQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UfcZIUR2lNzCw1hXOreJ5PLDZEnV/dHzByhTg1NFFSB4uE3Zfiw/1c2qAEz3v09/8y8xyINYSuEIKIZM+pAPBS+3lgOkAcLljuhVOwrsQQWKNIAuKm/XwMdv9XpXtzxeNQvybhGls4oHAPqMzh65kOHP8CaneM0hwPhpeKbVdWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=mbxA+lR+; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1719501789;
	bh=dqQyq+JWny1Zk9kPrnxbdc4Bt8ivWO1bh2Qq0DoNRlQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mbxA+lR+eHeyGIlYRTZQM5SaUPmmIqpg+vTNSWmhflWb/WNOosC3ZYZxs2Z2v8cil
	 6vwbO5AxgNGpdxlESyxd5BHOBSKSkkSfgcYxygNSmB8W/EdIU5GwbZ57eTHNTV11i7
	 71ySfkfQ04XyZJcTGVqpd9NLO9WfrkPZs6jBRYIQpu6UkgYiwaxvWZehljZn0cvDUc
	 dBn2/CCi6spv6BhYL54P3Dlf1n7U8Ov5Vye5N+7N+ryQ/iCnxvhO6XnftDQuSANuPM
	 x1r2uFkdnDd4suZzM3W0Pg4rz6WBCY+x5mgPvLl1Y0+yFN+sdH44nZGDkGOUW79gHp
	 C5PJFEcXj0oww==
Received: from thinkos.internal.efficios.com (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4W92Q53TPHz17lq;
	Thu, 27 Jun 2024 11:23:09 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
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
	bpf@vger.kernel.org,
	Joel Fernandes <joel@joelfernandes.org>,
	Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH v5 4/8] tracing: Introduce faultable tracepoints
Date: Thu, 27 Jun 2024 11:23:36 -0400
Message-Id: <20240627152340.82413-5-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240627152340.82413-1-mathieu.desnoyers@efficios.com>
References: <20240627152340.82413-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When invoked from system call enter/exit instrumentation, accessing
user-space data is a common use-case for tracers. However, tracepoints
currently disable preemption around iteration on the registered
tracepoint probes and invocation of the probe callbacks, which prevents
tracers from handling page faults.

Extend the tracepoint and trace event APIs to allow defining a faultable
tracepoint which invokes its callback with preemption enabled.

Also extend the tracepoint API to allow tracers to request specific
probes to be connected to those faultable tracepoints. When the
TRACEPOINT_MAY_FAULT flag is provided on registration, the probe
callback will be called with preemption enabled, and is allowed to take
page faults. Faultable probes can only be registered on faultable
tracepoints and non-faultable probes on non-faultable tracepoints.

The tasks trace rcu mechanism is used to synchronize read-side
marshalling of the registered probes with respect to faultable probes
unregistration and teardown.

Link: https://lore.kernel.org/lkml/20231002202531.3160-1-mathieu.desnoyers@efficios.com/
Co-developed-by: Michael Jeanson <mjeanson@efficios.com>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
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
Changes since v2:
- Rename MAYFAULT to MAY_FAULT.
- Rebased on 6.5.5.
- Introduce MAY_EXIST tracepoint flag.
Changes since v3:
- Rebased on 6.6.2.
Changes since v4:
- Rebased on 6.9.6.
- Simplify flag check in tracepoint_probe_register_prio_flags().
- Update MAY_EXIST flag description.
---
 include/linux/tracepoint-defs.h | 14 ++++++
 include/linux/tracepoint.h      | 88 +++++++++++++++++++++++----------
 include/trace/define_trace.h    |  7 +++
 include/trace/trace_events.h    |  6 +++
 init/Kconfig                    |  1 +
 kernel/trace/bpf_trace.c        |  5 +-
 kernel/trace/trace_fprobe.c     |  5 +-
 kernel/tracepoint.c             | 65 ++++++++++++++----------
 8 files changed, 136 insertions(+), 55 deletions(-)

diff --git a/include/linux/tracepoint-defs.h b/include/linux/tracepoint-defs.h
index 4dc4955f0fbf..94e39c86b49f 100644
--- a/include/linux/tracepoint-defs.h
+++ b/include/linux/tracepoint-defs.h
@@ -29,6 +29,19 @@ struct tracepoint_func {
 	int prio;
 };
 
+/**
+ * enum tracepoint_flags - Tracepoint flags
+ * @TRACEPOINT_MAY_EXIST: On registration, don't warn if the tracepoint is
+ *                        already registered.
+ * @TRACEPOINT_MAY_FAULT: The tracepoint probe callback will be called with
+ *                        preemption enabled, and is allowed to take page
+ *                        faults.
+ */
+enum tracepoint_flags {
+	TRACEPOINT_MAY_EXIST = (1 << 0),
+	TRACEPOINT_MAY_FAULT = (1 << 1),
+};
+
 struct tracepoint {
 	const char *name;		/* Tracepoint name */
 	struct static_key key;
@@ -39,6 +52,7 @@ struct tracepoint {
 	int (*regfunc)(void);
 	void (*unregfunc)(void);
 	struct tracepoint_func __rcu *funcs;
+	unsigned int flags;
 };
 
 #ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 689b6d71590e..eaf8c00b30a3 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -18,6 +18,7 @@
 #include <linux/types.h>
 #include <linux/cpumask.h>
 #include <linux/rcupdate.h>
+#include <linux/rcupdate_trace.h>
 #include <linux/tracepoint-defs.h>
 #include <linux/static_call.h>
 
@@ -41,17 +42,10 @@ extern int
 tracepoint_probe_register_prio(struct tracepoint *tp, void *probe, void *data,
 			       int prio);
 extern int
-tracepoint_probe_register_prio_may_exist(struct tracepoint *tp, void *probe, void *data,
-					 int prio);
+tracepoint_probe_register_prio_flags(struct tracepoint *tp, void *probe, void *data,
+			       int prio, unsigned int flags);
 extern int
 tracepoint_probe_unregister(struct tracepoint *tp, void *probe, void *data);
-static inline int
-tracepoint_probe_register_may_exist(struct tracepoint *tp, void *probe,
-				    void *data)
-{
-	return tracepoint_probe_register_prio_may_exist(tp, probe, data,
-							TRACEPOINT_DEFAULT_PRIO);
-}
 extern void
 for_each_kernel_tracepoint(void (*fct)(struct tracepoint *tp, void *priv),
 		void *priv);
@@ -90,6 +84,7 @@ int unregister_tracepoint_module_notifier(struct notifier_block *nb)
 #ifdef CONFIG_TRACEPOINTS
 static inline void tracepoint_synchronize_unregister(void)
 {
+	synchronize_rcu_tasks_trace();
 	synchronize_srcu(&tracepoint_srcu);
 	synchronize_rcu();
 }
@@ -192,9 +187,10 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
  * it_func[0] is never NULL because there is at least one element in the array
  * when the array itself is non NULL.
  */
-#define __DO_TRACE(name, args, cond, rcuidle)				\
+#define __DO_TRACE(name, args, cond, rcuidle, tp_flags)			\
 	do {								\
 		int __maybe_unused __idx = 0;				\
+		bool mayfault = (tp_flags) & TRACEPOINT_MAY_FAULT;	\
 									\
 		if (!(cond))						\
 			return;						\
@@ -203,8 +199,12 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 			      "Bad RCU usage for tracepoint"))		\
 			return;						\
 									\
-		/* keep srcu and sched-rcu usage consistent */		\
-		preempt_disable_notrace();				\
+		if (mayfault) {						\
+			rcu_read_lock_trace();				\
+		} else {						\
+			/* keep srcu and sched-rcu usage consistent */	\
+			preempt_disable_notrace();			\
+		}							\
 									\
 		/*							\
 		 * For rcuidle callers, use srcu since sched-rcu	\
@@ -222,20 +222,23 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 			srcu_read_unlock_notrace(&tracepoint_srcu, __idx);\
 		}							\
 									\
-		preempt_enable_notrace();				\
+		if (mayfault)						\
+			rcu_read_unlock_trace();			\
+		else							\
+			preempt_enable_notrace();			\
 	} while (0)
 
 #ifndef MODULE
-#define __DECLARE_TRACE_RCU(name, proto, args, cond)			\
+#define __DECLARE_TRACE_RCU(name, proto, args, cond, tp_flags)		\
 	static inline void trace_##name##_rcuidle(proto)		\
 	{								\
 		if (static_key_false(&__tracepoint_##name.key))		\
 			__DO_TRACE(name,				\
 				TP_ARGS(args),				\
-				TP_CONDITION(cond), 1);			\
+				TP_CONDITION(cond), 1, tp_flags);	\
 	}
 #else
-#define __DECLARE_TRACE_RCU(name, proto, args, cond)
+#define __DECLARE_TRACE_RCU(name, proto, args, cond, tp_flags)
 #endif
 
 /*
@@ -249,7 +252,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
  * site if it is not watching, as it will need to be active when the
  * tracepoint is enabled.
  */
-#define __DECLARE_TRACE(name, proto, args, cond, data_proto)		\
+#define __DECLARE_TRACE(name, proto, args, cond, data_proto, tp_flags)	\
 	extern int __traceiter_##name(data_proto);			\
 	DECLARE_STATIC_CALL(tp_func_##name, __traceiter_##name);	\
 	extern struct tracepoint __tracepoint_##name;			\
@@ -258,14 +261,16 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 		if (static_key_false(&__tracepoint_##name.key))		\
 			__DO_TRACE(name,				\
 				TP_ARGS(args),				\
-				TP_CONDITION(cond), 0);			\
+				TP_CONDITION(cond), 0, tp_flags);	\
 		if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {		\
 			WARN_ONCE(!rcu_is_watching(),			\
 				  "RCU not watching for tracepoint");	\
 		}							\
+		if ((tp_flags) & TRACEPOINT_MAY_FAULT)			\
+			might_fault();					\
 	}								\
 	__DECLARE_TRACE_RCU(name, PARAMS(proto), PARAMS(args),		\
-			    PARAMS(cond))				\
+			    PARAMS(cond), tp_flags)			\
 	static inline int						\
 	register_trace_##name(void (*probe)(data_proto), void *data)	\
 	{								\
@@ -280,6 +285,13 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 					      (void *)probe, data, prio); \
 	}								\
 	static inline int						\
+	register_trace_prio_flags_##name(void (*probe)(data_proto), void *data, \
+				   int prio, unsigned int flags)	\
+	{								\
+		return tracepoint_probe_register_prio_flags(&__tracepoint_##name, \
+					      (void *)probe, data, prio, flags); \
+	}								\
+	static inline int						\
 	unregister_trace_##name(void (*probe)(data_proto), void *data)	\
 	{								\
 		return tracepoint_probe_unregister(&__tracepoint_##name,\
@@ -300,7 +312,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
  * structures, so we create an array of pointers that will be used for iteration
  * on the tracepoints.
  */
-#define DEFINE_TRACE_FN(_name, _reg, _unreg, proto, args)		\
+#define DEFINE_TRACE_FN_FLAGS(_name, _reg, _unreg, proto, args, tp_flags) \
 	static const char __tpstrtab_##_name[]				\
 	__section("__tracepoints_strings") = #_name;			\
 	extern struct static_call_key STATIC_CALL_KEY(tp_func_##_name);	\
@@ -316,7 +328,9 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 		.probestub = &__probestub_##_name,			\
 		.regfunc = _reg,					\
 		.unregfunc = _unreg,					\
-		.funcs = NULL };					\
+		.funcs = NULL,						\
+		.flags = (tp_flags),					\
+	};								\
 	__TRACEPOINT_ENTRY(_name);					\
 	int __traceiter_##_name(void *__data, proto)			\
 	{								\
@@ -339,8 +353,11 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 	}								\
 	DEFINE_STATIC_CALL(tp_func_##_name, __traceiter_##_name);
 
+#define DEFINE_TRACE_FN(_name, _reg, _unreg, proto, args)		\
+	DEFINE_TRACE_FN_FLAGS(_name, _reg, _unreg, PARAMS(proto), PARAMS(args), 0)
+
 #define DEFINE_TRACE(name, proto, args)		\
-	DEFINE_TRACE_FN(name, NULL, NULL, PARAMS(proto), PARAMS(args));
+	DEFINE_TRACE_FN(name, NULL, NULL, PARAMS(proto), PARAMS(args))
 
 #define EXPORT_TRACEPOINT_SYMBOL_GPL(name)				\
 	EXPORT_SYMBOL_GPL(__tracepoint_##name);				\
@@ -353,7 +370,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 
 
 #else /* !TRACEPOINTS_ENABLED */
-#define __DECLARE_TRACE(name, proto, args, cond, data_proto)		\
+#define __DECLARE_TRACE(name, proto, args, cond, data_proto, tp_flags)	\
 	static inline void trace_##name(proto)				\
 	{ }								\
 	static inline void trace_##name##_rcuidle(proto)		\
@@ -365,6 +382,18 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 		return -ENOSYS;						\
 	}								\
 	static inline int						\
+	register_trace_prio_##name(void (*probe)(data_proto),		\
+			      void *data, int prio)			\
+	{								\
+		return -ENOSYS;						\
+	}								\
+	static inline int						\
+	register_trace_prio_flags_##name(void (*probe)(data_proto),	\
+			      void *data, int prio, unsigned int flags)	\
+	{								\
+		return -ENOSYS;						\
+	}								\
+	static inline int						\
 	unregister_trace_##name(void (*probe)(data_proto),		\
 				void *data)				\
 	{								\
@@ -379,6 +408,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 		return false;						\
 	}
 
+#define DEFINE_TRACE_FN_FLAGS(name, reg, unreg, proto, args, tp_flags)
 #define DEFINE_TRACE_FN(name, reg, unreg, proto, args)
 #define DEFINE_TRACE(name, proto, args)
 #define EXPORT_TRACEPOINT_SYMBOL_GPL(name)
@@ -433,12 +463,17 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 #define DECLARE_TRACE(name, proto, args)				\
 	__DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),		\
 			cpu_online(raw_smp_processor_id()),		\
-			PARAMS(void *__data, proto))
+			PARAMS(void *__data, proto), 0)
+
+#define DECLARE_TRACE_MAY_FAULT(name, proto, args)			\
+	__DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),		\
+			cpu_online(raw_smp_processor_id()),		\
+			PARAMS(void *__data, proto), TRACEPOINT_MAY_FAULT)
 
 #define DECLARE_TRACE_CONDITION(name, proto, args, cond)		\
 	__DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),		\
 			cpu_online(raw_smp_processor_id()) && (PARAMS(cond)), \
-			PARAMS(void *__data, proto))
+			PARAMS(void *__data, proto), 0)
 
 #define TRACE_EVENT_FLAGS(event, flag)
 
@@ -569,6 +604,9 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 #define TRACE_EVENT_FN(name, proto, args, struct,		\
 		assign, print, reg, unreg)			\
 	DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
+#define TRACE_EVENT_FN_MAY_FAULT(name, proto, args, struct,	\
+		assign, print, reg, unreg)			\
+	DECLARE_TRACE_MAY_FAULT(name, PARAMS(proto), PARAMS(args))
 #define TRACE_EVENT_FN_COND(name, proto, args, cond, struct,		\
 		assign, print, reg, unreg)			\
 	DECLARE_TRACE_CONDITION(name, PARAMS(proto),	\
diff --git a/include/trace/define_trace.h b/include/trace/define_trace.h
index 00723935dcc7..1b8ca143724a 100644
--- a/include/trace/define_trace.h
+++ b/include/trace/define_trace.h
@@ -41,6 +41,12 @@
 		assign, print, reg, unreg)			\
 	DEFINE_TRACE_FN(name, reg, unreg, PARAMS(proto), PARAMS(args))
 
+#undef TRACE_EVENT_FN_MAY_FAULT
+#define TRACE_EVENT_FN_MAY_FAULT(name, proto, args, tstruct,	\
+		assign, print, reg, unreg)			\
+	DEFINE_TRACE_FN_FLAGS(name, reg, unreg, PARAMS(proto),	\
+			      PARAMS(args), TRACEPOINT_MAY_FAULT)
+
 #undef TRACE_EVENT_FN_COND
 #define TRACE_EVENT_FN_COND(name, proto, args, cond, tstruct,		\
 		assign, print, reg, unreg)			\
@@ -106,6 +112,7 @@
 
 #undef TRACE_EVENT
 #undef TRACE_EVENT_FN
+#undef TRACE_EVENT_FN_MAY_FAULT
 #undef TRACE_EVENT_FN_COND
 #undef TRACE_EVENT_CONDITION
 #undef TRACE_EVENT_NOP
diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index c2f9cabf154d..df590eea8ae4 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -77,6 +77,12 @@
 	TRACE_EVENT(name, PARAMS(proto), PARAMS(args),			\
 		PARAMS(tstruct), PARAMS(assign), PARAMS(print))		\
 
+#undef TRACE_EVENT_FN_MAY_FAULT
+#define TRACE_EVENT_FN_MAY_FAULT(name, proto, args, tstruct,		\
+		assign, print, reg, unreg)				\
+	TRACE_EVENT(name, PARAMS(proto), PARAMS(args),			\
+		PARAMS(tstruct), PARAMS(assign), PARAMS(print))		\
+
 #undef TRACE_EVENT_FN_COND
 #define TRACE_EVENT_FN_COND(name, proto, args, cond, tstruct,	\
 		assign, print, reg, unreg)				\
diff --git a/init/Kconfig b/init/Kconfig
index 459f44ef7cc9..3d726f2edfe1 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1933,6 +1933,7 @@ config BINDGEN_VERSION_TEXT
 #
 config TRACEPOINTS
 	bool
+	select TASKS_TRACE_RCU
 
 source "kernel/Kconfig.kexec"
 
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 5d8f918c9825..192de33d961f 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2443,8 +2443,9 @@ static int __bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *
 	if (prog->aux->max_tp_access > btp->writable_size)
 		return -EINVAL;
 
-	return tracepoint_probe_register_may_exist(tp, (void *)btp->bpf_func,
-						   prog);
+	return tracepoint_probe_register_prio_flags(tp, (void *)btp->bpf_func,
+						    prog, TRACEPOINT_DEFAULT_PRIO,
+						    TRACEPOINT_MAY_EXIST);
 }
 
 int bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *prog)
diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index 4f4280815522..06d2ebbd381d 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -705,8 +705,9 @@ static int __register_trace_fprobe(struct trace_fprobe *tf)
 		 * At first, put __probestub_##TP function on the tracepoint
 		 * and put a fprobe on the stub function.
 		 */
-		ret = tracepoint_probe_register_prio_may_exist(tpoint,
-					tpoint->probestub, NULL, 0);
+		ret = tracepoint_probe_register_prio_flags(tpoint,
+					tpoint->probestub, NULL, 0,
+					TRACEPOINT_MAY_EXIST);
 		if (ret < 0)
 			return ret;
 		return register_fprobe_ips(&tf->fp, &ip, 1);
diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 8d1507dd0724..cc5e71383c4d 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -111,11 +111,16 @@ static inline void *allocate_probes(int count)
 	return p == NULL ? NULL : p->probes;
 }
 
-static void srcu_free_old_probes(struct rcu_head *head)
+static void rcu_tasks_trace_free_old_probes(struct rcu_head *head)
 {
 	kfree(container_of(head, struct tp_probes, rcu));
 }
 
+static void srcu_free_old_probes(struct rcu_head *head)
+{
+	call_rcu_tasks_trace(head, rcu_tasks_trace_free_old_probes);
+}
+
 static void rcu_free_old_probes(struct rcu_head *head)
 {
 	call_srcu(&tracepoint_srcu, head, srcu_free_old_probes);
@@ -136,7 +141,7 @@ static __init int release_early_probes(void)
 	return 0;
 }
 
-/* SRCU is initialized at core_initcall */
+/* SRCU and Tasks Trace RCU are initialized at core_initcall */
 postcore_initcall(release_early_probes);
 
 static inline void release_probes(struct tracepoint_func *old)
@@ -146,8 +151,9 @@ static inline void release_probes(struct tracepoint_func *old)
 			struct tp_probes, probes[0]);
 
 		/*
-		 * We can't free probes if SRCU is not initialized yet.
-		 * Postpone the freeing till after SRCU is initialized.
+		 * We can't free probes if SRCU and Tasks Trace RCU are not
+		 * initialized yet. Postpone the freeing till after both are
+		 * initialized.
 		 */
 		if (unlikely(!ok_to_free_tracepoints)) {
 			tp_probes->rcu.next = early_probes;
@@ -156,10 +162,9 @@ static inline void release_probes(struct tracepoint_func *old)
 		}
 
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
@@ -460,30 +465,45 @@ static int tracepoint_remove_func(struct tracepoint *tp,
 }
 
 /**
- * tracepoint_probe_register_prio_may_exist -  Connect a probe to a tracepoint with priority
+ * tracepoint_probe_register_prio_flags -  Connect a probe to a tracepoint with priority and flags
  * @tp: tracepoint
  * @probe: probe handler
  * @data: tracepoint data
  * @prio: priority of this function over other registered functions
+ * @flags: tracepoint flags argument (enum tracepoint_flags bits)
  *
- * Same as tracepoint_probe_register_prio() except that it will not warn
- * if the tracepoint is already registered.
+ * Returns 0 if ok, error value on error.
+ * Note: if @tp is within a module, the caller is responsible for
+ * unregistering the probe before the module is gone. This can be
+ * performed either with a tracepoint module going notifier, or from
+ * within module exit functions.
  */
-int tracepoint_probe_register_prio_may_exist(struct tracepoint *tp, void *probe,
-					     void *data, int prio)
+int tracepoint_probe_register_prio_flags(struct tracepoint *tp, void *probe,
+				   void *data, int prio, unsigned int flags)
 {
 	struct tracepoint_func tp_func;
 	int ret;
 
+	/*
+	 * For a probe to be registered to a tracepoint they must share the
+	 * same MAY_FAULT flag value.
+	 */
+	if ((tp->flags & TRACEPOINT_MAY_FAULT) != (flags & TRACEPOINT_MAY_FAULT))
+		return -EINVAL;
+
 	mutex_lock(&tracepoints_mutex);
 	tp_func.func = probe;
 	tp_func.data = data;
 	tp_func.prio = prio;
-	ret = tracepoint_add_func(tp, &tp_func, prio, false);
+	/*
+	 * When the MAY_EXIST flag is set, don't warn if the tracepoint is
+	 * already registered.
+	 */
+	ret = tracepoint_add_func(tp, &tp_func, prio, flags & TRACEPOINT_MAY_EXIST);
 	mutex_unlock(&tracepoints_mutex);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(tracepoint_probe_register_prio_may_exist);
+EXPORT_SYMBOL_GPL(tracepoint_probe_register_prio_flags);
 
 /**
  * tracepoint_probe_register_prio -  Connect a probe to a tracepoint with priority
@@ -501,16 +521,7 @@ EXPORT_SYMBOL_GPL(tracepoint_probe_register_prio_may_exist);
 int tracepoint_probe_register_prio(struct tracepoint *tp, void *probe,
 				   void *data, int prio)
 {
-	struct tracepoint_func tp_func;
-	int ret;
-
-	mutex_lock(&tracepoints_mutex);
-	tp_func.func = probe;
-	tp_func.data = data;
-	tp_func.prio = prio;
-	ret = tracepoint_add_func(tp, &tp_func, prio, true);
-	mutex_unlock(&tracepoints_mutex);
-	return ret;
+	return tracepoint_probe_register_prio_flags(tp, probe, data, prio, 0);
 }
 EXPORT_SYMBOL_GPL(tracepoint_probe_register_prio);
 
@@ -520,6 +531,8 @@ EXPORT_SYMBOL_GPL(tracepoint_probe_register_prio);
  * @probe: probe handler
  * @data: tracepoint data
  *
+ * Non-faultable probes can only be registered on non-faultable tracepoints.
+ *
  * Returns 0 if ok, error value on error.
  * Note: if @tp is within a module, the caller is responsible for
  * unregistering the probe before the module is gone. This can be
@@ -528,7 +541,7 @@ EXPORT_SYMBOL_GPL(tracepoint_probe_register_prio);
  */
 int tracepoint_probe_register(struct tracepoint *tp, void *probe, void *data)
 {
-	return tracepoint_probe_register_prio(tp, probe, data, TRACEPOINT_DEFAULT_PRIO);
+	return tracepoint_probe_register_prio_flags(tp, probe, data, TRACEPOINT_DEFAULT_PRIO, 0);
 }
 EXPORT_SYMBOL_GPL(tracepoint_probe_register);
 
-- 
2.39.2


