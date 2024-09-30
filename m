Return-Path: <bpf+bounces-40595-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8253098ACD2
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 21:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A64891C2117D
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 19:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946B1199FD7;
	Mon, 30 Sep 2024 19:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="P2DE+IFL"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DCE199930;
	Mon, 30 Sep 2024 19:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727724394; cv=none; b=bwfmEc3SSVNCcZayxpZ+m4j+RuCNCu9dTYJdoGczCr78MhfYGx4EcY0ycsdB0Lw6lWqYX4aSfmoRBUmrytgOjFgLQXaxm0YqJjDdxwPiNRIgsPjsj3yIUrJ5FJjVxDuX14v4zYyzRfpoZvkC7beLKTsCgMMDhPTFRhLZlMuPguU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727724394; c=relaxed/simple;
	bh=BtUdvfoGNYu9/1n2UYHiEotu2NVSo7k7uUSWVyyG0zs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tpNv/kgB/7dOPJ6iSv53CAHzPOuQ6nXkdNLd3T9Z5XuWYKSd40xIPTRNytSX6BY/QFOtyDZ2wVi5CukRCu5EN68oAXXVYUD/YGEbnAW/UIoSz6DgsZTbfLiMRoxbk5Zg38y9iQs96rxjGIt2v5gF5ywRol59qanqe/xi+4H6IA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=P2DE+IFL; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1727724390;
	bh=BtUdvfoGNYu9/1n2UYHiEotu2NVSo7k7uUSWVyyG0zs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P2DE+IFLzFWRnAIZVJVNyBfXmIBcCimaW9Ebda9UPtL7PFmN1YHo0vOymCor7VpN9
	 Nr5ZWgnMCH5ZHlsrC63KT0kDxFjRA7BCYV1GhXtT9CzdYWb5sxW39pawBzY8eyEQkR
	 aesVCcdlQg83CbEpVmUyCIq4VcLvVCCDgm7aSkq71Ed8XCykehzmjRF5DBb/HY5YK8
	 32SAhh3DWRliDifM6Gafg3khjIMDscGB/q+wNZHNsCbBUtDdMYVnLwmK6Ibc5f/D4l
	 xKjK8pk6yT6hKM/Ra6w//DhwA1Yn99xQJ2YrU/94p8Yalcvk703jI9q4gPfPzuVC+g
	 rqC1cI7NzOV4Q==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XHWK255lSzQk1;
	Mon, 30 Sep 2024 15:26:30 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	bpf@vger.kernel.org,
	Joel Fernandes <joel@joelfernandes.org>,
	linux-trace-kernel@vger.kernel.org,
	Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH resend 1/8] tracing: Declare system call tracepoints with TRACE_EVENT_SYSCALL
Date: Mon, 30 Sep 2024 15:23:50 -0400
Message-Id: <20240930192357.1154417-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240930192357.1154417-1-mathieu.desnoyers@efficios.com>
References: <20240930192357.1154417-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for allowing system call tracepoints to handle page
faults, introduce TRACE_EVENT_SYSCALL to declare the sys_enter/sys_exit
tracepoints.

Emit the static inlines register_trace_syscall_##name for events
declared with TRACE_EVENT_SYSCALL, allowing source-level validation
that only probes meant to handle system call entry/exit events are
registered to them.

Move the common code between __DECLARE_TRACE and __DECLARE_TRACE_SYSCALL
into __DECLARE_TRACE_COMMON.

This change is not meant to alter the generated code, and only prepares
the following modifications.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Michael Jeanson <mjeanson@efficios.com>
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
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org
Cc: Joel Fernandes <joel@joelfernandes.org>
---
 include/linux/tracepoint.h      | 66 +++++++++++++++++++++++++--------
 include/trace/bpf_probe.h       |  3 ++
 include/trace/define_trace.h    |  5 +++
 include/trace/events/syscalls.h |  4 +-
 include/trace/perf.h            |  3 ++
 include/trace/trace_events.h    | 28 ++++++++++++++
 kernel/entry/common.c           |  4 +-
 kernel/trace/trace_syscalls.c   |  8 ++--
 8 files changed, 98 insertions(+), 23 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 6be396bb4297..2e4b4952bba2 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -248,10 +248,28 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
  * site if it is not watching, as it will need to be active when the
  * tracepoint is enabled.
  */
-#define __DECLARE_TRACE(name, proto, args, cond, data_proto)		\
+#define __DECLARE_TRACE_COMMON(name, proto, args, cond, data_proto)	\
 	extern int __traceiter_##name(data_proto);			\
 	DECLARE_STATIC_CALL(tp_func_##name, __traceiter_##name);	\
 	extern struct tracepoint __tracepoint_##name;			\
+	static inline int						\
+	unregister_trace_##name(void (*probe)(data_proto), void *data)	\
+	{								\
+		return tracepoint_probe_unregister(&__tracepoint_##name,\
+						(void *)probe, data);	\
+	}								\
+	static inline void						\
+	check_trace_callback_type_##name(void (*cb)(data_proto))	\
+	{								\
+	}								\
+	static inline bool						\
+	trace_##name##_enabled(void)					\
+	{								\
+		return static_key_false(&__tracepoint_##name.key);	\
+	}
+
+#define __DECLARE_TRACE(name, proto, args, cond, data_proto)		\
+	__DECLARE_TRACE_COMMON(name, PARAMS(proto), PARAMS(args), cond, PARAMS(data_proto)) \
 	static inline void trace_##name(proto)				\
 	{								\
 		if (static_key_false(&__tracepoint_##name.key))		\
@@ -263,8 +281,13 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 				  "RCU not watching for tracepoint");	\
 		}							\
 	}								\
-	__DECLARE_TRACE_RCU(name, PARAMS(proto), PARAMS(args),		\
-			    PARAMS(cond))				\
+	static inline void trace_##name##_rcuidle(proto)		\
+	{								\
+		if (static_key_false(&__tracepoint_##name.key))		\
+			__DO_TRACE(name,				\
+				TP_ARGS(args),				\
+				TP_CONDITION(cond), 1);			\
+	}								\
 	static inline int						\
 	register_trace_##name(void (*probe)(data_proto), void *data)	\
 	{								\
@@ -277,21 +300,26 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 	{								\
 		return tracepoint_probe_register_prio(&__tracepoint_##name, \
 					      (void *)probe, data, prio); \
-	}								\
-	static inline int						\
-	unregister_trace_##name(void (*probe)(data_proto), void *data)	\
-	{								\
-		return tracepoint_probe_unregister(&__tracepoint_##name,\
-						(void *)probe, data);	\
-	}								\
-	static inline void						\
-	check_trace_callback_type_##name(void (*cb)(data_proto))	\
+	}
+
+#define __DECLARE_TRACE_SYSCALL(name, proto, args, cond, data_proto)	\
+	__DECLARE_TRACE_COMMON(name, PARAMS(proto), PARAMS(args), cond, PARAMS(data_proto)) \
+	static inline void trace_syscall_##name(proto)			\
 	{								\
+		if (static_key_false(&__tracepoint_##name.key))		\
+			__DO_TRACE(name,				\
+				TP_ARGS(args),				\
+				TP_CONDITION(cond), 0);			\
+		if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {		\
+			WARN_ONCE(!rcu_is_watching(),			\
+				  "RCU not watching for tracepoint");	\
+		}							\
 	}								\
-	static inline bool						\
-	trace_##name##_enabled(void)					\
+	static inline int						\
+	register_trace_syscall_##name(void (*probe)(data_proto), void *data) \
 	{								\
-		return static_key_false(&__tracepoint_##name.key);	\
+		return tracepoint_probe_register(&__tracepoint_##name,	\
+						 (void *)probe, data);	\
 	}
 
 /*
@@ -439,6 +467,11 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 			cpu_online(raw_smp_processor_id()) && (PARAMS(cond)), \
 			PARAMS(void *__data, proto))
 
+#define DECLARE_TRACE_SYSCALL(name, proto, args)			\
+	__DECLARE_TRACE_SYSCALL(name, PARAMS(proto), PARAMS(args),	\
+				cpu_online(raw_smp_processor_id()),	\
+				PARAMS(void *__data, proto))
+
 #define TRACE_EVENT_FLAGS(event, flag)
 
 #define TRACE_EVENT_PERF_PERM(event, expr...)
@@ -576,6 +609,9 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 			      struct, assign, print)		\
 	DECLARE_TRACE_CONDITION(name, PARAMS(proto),		\
 				PARAMS(args), PARAMS(cond))
+#define TRACE_EVENT_SYSCALL(name, proto, args, struct, assign,	\
+			    print, reg, unreg)			\
+	DECLARE_TRACE_SYSCALL(name, PARAMS(proto), PARAMS(args))
 
 #define TRACE_EVENT_FLAGS(event, flag)
 
diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
index a2ea11cc912e..c85bbce5aaa5 100644
--- a/include/trace/bpf_probe.h
+++ b/include/trace/bpf_probe.h
@@ -53,6 +53,9 @@ __bpf_trace_##call(void *__data, proto)					\
 #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
 	__BPF_DECLARE_TRACE(call, PARAMS(proto), PARAMS(args))
 
+#undef DECLARE_EVENT_SYSCALL_CLASS
+#define DECLARE_EVENT_SYSCALL_CLASS DECLARE_EVENT_CLASS
+
 /*
  * This part is compiled out, it is only here as a build time check
  * to make sure that if the tracepoint handling changes, the
diff --git a/include/trace/define_trace.h b/include/trace/define_trace.h
index 00723935dcc7..ff5fa17a6259 100644
--- a/include/trace/define_trace.h
+++ b/include/trace/define_trace.h
@@ -46,6 +46,10 @@
 		assign, print, reg, unreg)			\
 	DEFINE_TRACE_FN(name, reg, unreg, PARAMS(proto), PARAMS(args))
 
+#undef TRACE_EVENT_SYSCALL
+#define TRACE_EVENT_SYSCALL(name, proto, args, struct, assign, print, reg, unreg) \
+	DEFINE_TRACE_FN(name, reg, unreg, PARAMS(proto), PARAMS(args))
+
 #undef TRACE_EVENT_NOP
 #define TRACE_EVENT_NOP(name, proto, args, struct, assign, print)
 
@@ -107,6 +111,7 @@
 #undef TRACE_EVENT
 #undef TRACE_EVENT_FN
 #undef TRACE_EVENT_FN_COND
+#undef TRACE_EVENT_SYSCALL
 #undef TRACE_EVENT_CONDITION
 #undef TRACE_EVENT_NOP
 #undef DEFINE_EVENT_NOP
diff --git a/include/trace/events/syscalls.h b/include/trace/events/syscalls.h
index b6e0cbc2c71f..f31ff446b468 100644
--- a/include/trace/events/syscalls.h
+++ b/include/trace/events/syscalls.h
@@ -15,7 +15,7 @@
 
 #ifdef CONFIG_HAVE_SYSCALL_TRACEPOINTS
 
-TRACE_EVENT_FN(sys_enter,
+TRACE_EVENT_SYSCALL(sys_enter,
 
 	TP_PROTO(struct pt_regs *regs, long id),
 
@@ -41,7 +41,7 @@ TRACE_EVENT_FN(sys_enter,
 
 TRACE_EVENT_FLAGS(sys_enter, TRACE_EVENT_FL_CAP_ANY)
 
-TRACE_EVENT_FN(sys_exit,
+TRACE_EVENT_SYSCALL(sys_exit,
 
 	TP_PROTO(struct pt_regs *regs, long ret),
 
diff --git a/include/trace/perf.h b/include/trace/perf.h
index 2c11181c82e0..ded997af481e 100644
--- a/include/trace/perf.h
+++ b/include/trace/perf.h
@@ -55,6 +55,9 @@ perf_trace_##call(void *__data, proto)					\
 				  head, __task);			\
 }
 
+#undef DECLARE_EVENT_SYSCALL_CLASS
+#define DECLARE_EVENT_SYSCALL_CLASS DECLARE_EVENT_CLASS
+
 /*
  * This part is compiled out, it is only here as a build time check
  * to make sure that if the tracepoint handling changes, the
diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index c2f9cabf154d..8bcbb9ee44de 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -45,6 +45,16 @@
 			     PARAMS(print));		       \
 	DEFINE_EVENT(name, name, PARAMS(proto), PARAMS(args));
 
+#undef TRACE_EVENT_SYSCALL
+#define TRACE_EVENT_SYSCALL(name, proto, args, tstruct, assign, print, reg, unreg) \
+	DECLARE_EVENT_SYSCALL_CLASS(name,		       \
+			     PARAMS(proto),		       \
+			     PARAMS(args),		       \
+			     PARAMS(tstruct),		       \
+			     PARAMS(assign),		       \
+			     PARAMS(print));		       \
+	DEFINE_EVENT(name, name, PARAMS(proto), PARAMS(args));
+
 #include "stages/stage1_struct_define.h"
 
 #undef DECLARE_EVENT_CLASS
@@ -57,6 +67,9 @@
 									\
 	static struct trace_event_class event_class_##name;
 
+#undef DECLARE_EVENT_SYSCALL_CLASS
+#define DECLARE_EVENT_SYSCALL_CLASS DECLARE_EVENT_CLASS
+
 #undef DEFINE_EVENT
 #define DEFINE_EVENT(template, name, proto, args)	\
 	static struct trace_event_call	__used		\
@@ -117,6 +130,9 @@
 		tstruct;						\
 	};
 
+#undef DECLARE_EVENT_SYSCALL_CLASS
+#define DECLARE_EVENT_SYSCALL_CLASS DECLARE_EVENT_CLASS
+
 #undef DEFINE_EVENT
 #define DEFINE_EVENT(template, name, proto, args)
 
@@ -208,6 +224,9 @@ static struct trace_event_functions trace_event_type_funcs_##call = {	\
 	.trace			= trace_raw_output_##call,		\
 };
 
+#undef DECLARE_EVENT_SYSCALL_CLASS
+#define DECLARE_EVENT_SYSCALL_CLASS DECLARE_EVENT_CLASS
+
 #undef DEFINE_EVENT_PRINT
 #define DEFINE_EVENT_PRINT(template, call, proto, args, print)		\
 static notrace enum print_line_t					\
@@ -265,6 +284,9 @@ static inline notrace int trace_event_get_offsets_##call(		\
 	return __data_size;						\
 }
 
+#undef DECLARE_EVENT_SYSCALL_CLASS
+#define DECLARE_EVENT_SYSCALL_CLASS DECLARE_EVENT_CLASS
+
 #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
 
 /*
@@ -409,6 +431,9 @@ trace_event_raw_event_##call(void *__data, proto)			\
  * fail to compile unless it too is updated.
  */
 
+#undef DECLARE_EVENT_SYSCALL_CLASS
+#define DECLARE_EVENT_SYSCALL_CLASS DECLARE_EVENT_CLASS
+
 #undef DEFINE_EVENT
 #define DEFINE_EVENT(template, call, proto, args)			\
 static inline void ftrace_test_probe_##call(void)			\
@@ -434,6 +459,9 @@ static struct trace_event_class __used __refdata event_class_##call = { \
 	_TRACE_PERF_INIT(call)						\
 };
 
+#undef DECLARE_EVENT_SYSCALL_CLASS
+#define DECLARE_EVENT_SYSCALL_CLASS DECLARE_EVENT_CLASS
+
 #undef DEFINE_EVENT
 #define DEFINE_EVENT(template, call, proto, args)			\
 									\
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 90843cc38588..d08472421d0e 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -58,7 +58,7 @@ long syscall_trace_enter(struct pt_regs *regs, long syscall,
 	syscall = syscall_get_nr(current, regs);
 
 	if (unlikely(work & SYSCALL_WORK_SYSCALL_TRACEPOINT)) {
-		trace_sys_enter(regs, syscall);
+		trace_syscall_sys_enter(regs, syscall);
 		/*
 		 * Probes or BPF hooks in the tracepoint may have changed the
 		 * system call number as well.
@@ -166,7 +166,7 @@ static void syscall_exit_work(struct pt_regs *regs, unsigned long work)
 	audit_syscall_exit(regs);
 
 	if (work & SYSCALL_WORK_SYSCALL_TRACEPOINT)
-		trace_sys_exit(regs, syscall_get_return_value(current, regs));
+		trace_syscall_sys_exit(regs, syscall_get_return_value(current, regs));
 
 	step = report_single_step(work);
 	if (step || work & SYSCALL_WORK_SYSCALL_TRACE)
diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index 9c581d6da843..067f8e2b930f 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -377,7 +377,7 @@ static int reg_event_syscall_enter(struct trace_event_file *file,
 		return -ENOSYS;
 	mutex_lock(&syscall_trace_lock);
 	if (!tr->sys_refcount_enter)
-		ret = register_trace_sys_enter(ftrace_syscall_enter, tr);
+		ret = register_trace_syscall_sys_enter(ftrace_syscall_enter, tr);
 	if (!ret) {
 		rcu_assign_pointer(tr->enter_syscall_files[num], file);
 		tr->sys_refcount_enter++;
@@ -415,7 +415,7 @@ static int reg_event_syscall_exit(struct trace_event_file *file,
 		return -ENOSYS;
 	mutex_lock(&syscall_trace_lock);
 	if (!tr->sys_refcount_exit)
-		ret = register_trace_sys_exit(ftrace_syscall_exit, tr);
+		ret = register_trace_syscall_sys_exit(ftrace_syscall_exit, tr);
 	if (!ret) {
 		rcu_assign_pointer(tr->exit_syscall_files[num], file);
 		tr->sys_refcount_exit++;
@@ -631,7 +631,7 @@ static int perf_sysenter_enable(struct trace_event_call *call)
 
 	mutex_lock(&syscall_trace_lock);
 	if (!sys_perf_refcount_enter)
-		ret = register_trace_sys_enter(perf_syscall_enter, NULL);
+		ret = register_trace_syscall_sys_enter(perf_syscall_enter, NULL);
 	if (ret) {
 		pr_info("event trace: Could not activate syscall entry trace point");
 	} else {
@@ -728,7 +728,7 @@ static int perf_sysexit_enable(struct trace_event_call *call)
 
 	mutex_lock(&syscall_trace_lock);
 	if (!sys_perf_refcount_exit)
-		ret = register_trace_sys_exit(perf_syscall_exit, NULL);
+		ret = register_trace_syscall_sys_exit(perf_syscall_exit, NULL);
 	if (ret) {
 		pr_info("event trace: Could not activate syscall exit trace point");
 	} else {
-- 
2.39.2


