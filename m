Return-Path: <bpf+bounces-40953-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F99E9906EE
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 17:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F045FB24FE7
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 15:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2783F1AA7B2;
	Fri,  4 Oct 2024 15:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="LnMebwhB"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E761D9A7C;
	Fri,  4 Oct 2024 15:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728054026; cv=none; b=aTTUzOquAl5NhG5CWCNSxYWUtYpbfv2YcMJSO3lPdnlRSy9VzJcIfJMy9k/OUa8gwLVrliJwVDqmJJXWFhUAJngzQV8om/s+orbrUDCGlhHFBBuwi28Mpt7dKE2dDqh8TUwzsjWEc/J1HoqGLbNdwyu27xLw4aXlFx3SUPR/yMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728054026; c=relaxed/simple;
	bh=n0xTgIcf3WB4DTg1fsCLN/AqtvjT7LxEa+LElIn+6p0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qCSu9Qau/dFc2Q6nVMFEKknjCjm6piyjY/TMAfnPurRhGsri7FSmGS9QCFVA80oNKS2nVB44C/k5cVn1NhC7gn1oBOIiCU5GO6IzLChR+7zeeo3FUCwYodbQa8ao/tWT9sW1q7+yi6fNWjH3c99MTQxHL9j9iAkMTHmDAYA+XAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=LnMebwhB; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1728054023;
	bh=n0xTgIcf3WB4DTg1fsCLN/AqtvjT7LxEa+LElIn+6p0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LnMebwhBBzmvCeOgWIGvrsS44MHyJQito1tJGxr9DTGhxak9u8v+S+BEhERQH3aNt
	 nBGeBB1bzEEOy0KVjFn3rpk8IsBbD+c3n6F+53QuePPLC8A2zaG0AgRuxdqV1M806c
	 8CWR1MO8e013lfqg62r+7IwictuWKXg8CcZHfuOzk0h73NQJ+ofvap+PA7uSlsDerU
	 KdLImPqmRxRfGoBDzEh9/Gk56rV+/pJcwhwf5UN2+kFcCMm7HqUi4BKdph3DoDfVnU
	 aZCnLqr+g3UKs0PQobMqtFEKDosgSlWd6R9BVLSOIgNyyTwkB9u6vx2PLACNynNzIi
	 L1AjIT5RQseAA==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XKsD73BSbzLN4;
	Fri,  4 Oct 2024 11:00:23 -0400 (EDT)
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
Subject: [PATCH v3 1/8] tracing: Declare system call tracepoints with TRACE_EVENT_SYSCALL
Date: Fri,  4 Oct 2024 10:58:11 -0400
Message-Id: <20241004145818.1726671-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241004145818.1726671-1-mathieu.desnoyers@efficios.com>
References: <20241004145818.1726671-1-mathieu.desnoyers@efficios.com>
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
Changes since v0:
- Fix allnoconfig build by adding __DECLARE_TRACE_SYSCALL define in
  CONFIG_TRACEPOINTS=n case.
- Rename unregister_trace_sys_{enter,exit} to
  unregister_trace_syscall_sys_{enter,exit} for symmetry with
  register.
- Add emit trace_syscall_##name##_enabled for syscall tracepoints
  rather than trace_##name##_enabled, so it is in sync with the
  rest of the naming.
Changes since v1:
- Rebase on top of Steven's tracepoint patches removing
  rcuidle variant and srcu protection.
Changes since v2:
- Remove introduction of trace_syscall_ prefix to minimize code churn.
---
 include/linux/tracepoint.h      | 53 +++++++++++++++++++++++++--------
 include/trace/bpf_probe.h       |  3 ++
 include/trace/define_trace.h    |  5 ++++
 include/trace/events/syscalls.h |  4 +--
 include/trace/perf.h            |  3 ++
 include/trace/trace_events.h    | 28 +++++++++++++++++
 6 files changed, 81 insertions(+), 15 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index fa130c360179..014790495ad8 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -197,7 +197,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
  * it_func[0] is never NULL because there is at least one element in the array
  * when the array itself is non NULL.
  */
-#define __DO_TRACE(name, args, cond)					\
+#define __DO_TRACE(name, args, cond, syscall)				\
 	do {								\
 		int __maybe_unused __idx = 0;				\
 									\
@@ -222,21 +222,10 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
  * site if it is not watching, as it will need to be active when the
  * tracepoint is enabled.
  */
-#define __DECLARE_TRACE(name, proto, args, cond, data_proto)		\
+#define __DECLARE_TRACE_COMMON(name, proto, args, cond, data_proto)	\
 	extern int __traceiter_##name(data_proto);			\
 	DECLARE_STATIC_CALL(tp_func_##name, __traceiter_##name);	\
 	extern struct tracepoint __tracepoint_##name;			\
-	static inline void trace_##name(proto)				\
-	{								\
-		if (static_key_false(&__tracepoint_##name.key))		\
-			__DO_TRACE(name,				\
-				TP_ARGS(args),				\
-				TP_CONDITION(cond));			\
-		if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {		\
-			WARN_ONCE(!rcu_is_watching(),			\
-				  "RCU not watching for tracepoint");	\
-		}							\
-	}								\
 	static inline int						\
 	register_trace_##name(void (*probe)(data_proto), void *data)	\
 	{								\
@@ -266,6 +255,34 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 		return static_key_false(&__tracepoint_##name.key);	\
 	}
 
+#define __DECLARE_TRACE(name, proto, args, cond, data_proto)		\
+	__DECLARE_TRACE_COMMON(name, PARAMS(proto), PARAMS(args), cond, PARAMS(data_proto)) \
+	static inline void trace_##name(proto)				\
+	{								\
+		if (static_key_false(&__tracepoint_##name.key))		\
+			__DO_TRACE(name,				\
+				TP_ARGS(args),				\
+				TP_CONDITION(cond), 0);			\
+		if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {		\
+			WARN_ONCE(!rcu_is_watching(),			\
+				  "RCU not watching for tracepoint");	\
+		}							\
+	}
+
+#define __DECLARE_TRACE_SYSCALL(name, proto, args, cond, data_proto)	\
+	__DECLARE_TRACE_COMMON(name, PARAMS(proto), PARAMS(args), cond, PARAMS(data_proto)) \
+	static inline void trace_##name(proto)				\
+	{								\
+		if (static_key_false(&__tracepoint_##name.key))		\
+			__DO_TRACE(name,				\
+				TP_ARGS(args),				\
+				TP_CONDITION(cond), 1);			\
+		if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {		\
+			WARN_ONCE(!rcu_is_watching(),			\
+				  "RCU not watching for tracepoint");	\
+		}							\
+	}
+
 /*
  * We have no guarantee that gcc and the linker won't up-align the tracepoint
  * structures, so we create an array of pointers that will be used for iteration
@@ -348,6 +365,8 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 		return false;						\
 	}
 
+#define __DECLARE_TRACE_SYSCALL	__DECLARE_TRACE
+
 #define DEFINE_TRACE_FN(name, reg, unreg, proto, args)
 #define DEFINE_TRACE(name, proto, args)
 #define EXPORT_TRACEPOINT_SYMBOL_GPL(name)
@@ -409,6 +428,11 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 			cpu_online(raw_smp_processor_id()) && (PARAMS(cond)), \
 			PARAMS(void *__data, proto))
 
+#define DECLARE_TRACE_SYSCALL(name, proto, args)			\
+	__DECLARE_TRACE_SYSCALL(name, PARAMS(proto), PARAMS(args),	\
+				cpu_online(raw_smp_processor_id()),	\
+				PARAMS(void *__data, proto))
+
 #define TRACE_EVENT_FLAGS(event, flag)
 
 #define TRACE_EVENT_PERF_PERM(event, expr...)
@@ -546,6 +570,9 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
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
-- 
2.39.2


