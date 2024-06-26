Return-Path: <bpf+bounces-33190-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D86B89193F5
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 21:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01D6E1C23368
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 19:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FA5192B71;
	Wed, 26 Jun 2024 18:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="mfZOrYGx"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9EB191480;
	Wed, 26 Jun 2024 18:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719428364; cv=none; b=s+Z+pOcZCI/td2mXwqTZYA/fy2zDIFnbz39P4VRQRF038mew5yFlszDhFl1IIgfGtFvSwyv5I+QThyErmqCkRdVgIYVa7iVwZ4BwWcV5jwN0r3CT7NLBd25jJENH5YRC5Kav/Czhg1f8j0CWu9zYXS3Qv49kMd3GwPBbalj91mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719428364; c=relaxed/simple;
	bh=5KxhwtYs0VwKO6/mQqYE9U67KELGGajoSLZw7rpHpkU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VJE1NwTwweeNw3GmjqhNkLEGb1ZQ/IiKHTLZz6wXleLQ4kabHKgIXfqgFrIB0EdChjXQcrJqHGpdDDUw9ph5oPpXTsosq9MZG6dZ8o7RXOUkebjs9rBEYccJW4XZrlRoNNnqm3yJ3Lvh3YoQ04DgglcpsVYy3jKEjDUdZKBU1qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=mfZOrYGx; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1719428354;
	bh=5KxhwtYs0VwKO6/mQqYE9U67KELGGajoSLZw7rpHpkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mfZOrYGxuy1EQl1nIfOuKPC6eLyJ6wT3XhdWA3Y4BHOUZejRtR3tjnvtErNBjS1az
	 LyjyJw5ye+vV0SoM/n2hoN+KjFbxdKlebmCdUA+Wm267fcvM2vCWWSa6RrZXv1Z+Kg
	 MZqaO1mawL5d9o4v5L5J8JnchaRvZASFPmoQfUb1kpDSaM/PbeRny893s/BekA/BdV
	 R+ucTmfYn9B7uFGHvHuPOyZqwj1/3IzaJ9JM7aayfRhcssNXPWHy6QdEZE9XnigpiG
	 J+qJ0Zhec8ItKUv6MIWzIlLHhn166JLP16S3iw0oHhbsRkEOA36DV88rzaF6IqkXqB
	 kIgeKSW6lammQ==
Received: from thinkos.internal.efficios.com (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4W8WFt3GHlz17r2;
	Wed, 26 Jun 2024 14:59:14 -0400 (EDT)
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
	Jiri Olsa <jolsa@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	bpf@vger.kernel.org,
	Joel Fernandes <joel@joelfernandes.org>,
	Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH v5 5/8] tracing/ftrace: Add support for faultable tracepoints
Date: Wed, 26 Jun 2024 14:59:38 -0400
Message-Id: <20240626185941.68420-6-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240626185941.68420-1-mathieu.desnoyers@efficios.com>
References: <20240626185941.68420-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for converting system call enter/exit instrumentation
into faultable tracepoints, make sure that ftrace can handle registering
to such tracepoints by explicitly disabling preemption within the ftrace
tracepoint probes to respect the current expectations within ftrace ring
buffer code.

This change does not yet allow ftrace to take page faults per se within
its probe, but allows its existing probes to connect to faultable
tracepoints.

Link: https://lore.kernel.org/lkml/20231002202531.3160-1-mathieu.desnoyers@efficios.com/
Co-developed-by: Michael Jeanson <mjeanson@efficios.com>
Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
Changes since v4:
- Use DEFINE_INACTIVE_GUARD.
- Add brackets to multiline 'if' statements.
---
 include/trace/trace_events.h | 64 ++++++++++++++++++++++++++++++++++--
 kernel/trace/trace_events.c  | 28 ++++++++++++----
 2 files changed, 83 insertions(+), 9 deletions(-)

diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index df590eea8ae4..c887f7b6fbe9 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -45,6 +45,16 @@
 			     PARAMS(print));		       \
 	DEFINE_EVENT(name, name, PARAMS(proto), PARAMS(args));
 
+#undef TRACE_EVENT_MAY_FAULT
+#define TRACE_EVENT_MAY_FAULT(name, proto, args, tstruct, assign, print) \
+	DECLARE_EVENT_CLASS_MAY_FAULT(name,		       \
+			     PARAMS(proto),		       \
+			     PARAMS(args),		       \
+			     PARAMS(tstruct),		       \
+			     PARAMS(assign),		       \
+			     PARAMS(print));		       \
+	DEFINE_EVENT(name, name, PARAMS(proto), PARAMS(args));
+
 #include "stages/stage1_struct_define.h"
 
 #undef DECLARE_EVENT_CLASS
@@ -57,6 +67,11 @@
 									\
 	static struct trace_event_class event_class_##name;
 
+#undef DECLARE_EVENT_CLASS_MAY_FAULT
+#define DECLARE_EVENT_CLASS_MAY_FAULT(name, proto, args, tstruct, assign, print) \
+	DECLARE_EVENT_CLASS(name, PARAMS(proto), PARAMS(args),		\
+			    PARAMS(tstruct), PARAMS(assign), PARAMS(print))
+
 #undef DEFINE_EVENT
 #define DEFINE_EVENT(template, name, proto, args)	\
 	static struct trace_event_call	__used		\
@@ -80,7 +95,7 @@
 #undef TRACE_EVENT_FN_MAY_FAULT
 #define TRACE_EVENT_FN_MAY_FAULT(name, proto, args, tstruct,		\
 		assign, print, reg, unreg)				\
-	TRACE_EVENT(name, PARAMS(proto), PARAMS(args),			\
+	TRACE_EVENT_MAY_FAULT(name, PARAMS(proto), PARAMS(args),	\
 		PARAMS(tstruct), PARAMS(assign), PARAMS(print))		\
 
 #undef TRACE_EVENT_FN_COND
@@ -123,6 +138,11 @@
 		tstruct;						\
 	};
 
+#undef DECLARE_EVENT_CLASS_MAY_FAULT
+#define DECLARE_EVENT_CLASS_MAY_FAULT(call, proto, args, tstruct, assign, print) \
+	DECLARE_EVENT_CLASS(call, PARAMS(proto), PARAMS(args),		\
+			    PARAMS(tstruct), PARAMS(assign), PARAMS(print))
+
 #undef DEFINE_EVENT
 #define DEFINE_EVENT(template, name, proto, args)
 
@@ -214,6 +234,11 @@ static struct trace_event_functions trace_event_type_funcs_##call = {	\
 	.trace			= trace_raw_output_##call,		\
 };
 
+#undef DECLARE_EVENT_CLASS_MAY_FAULT
+#define DECLARE_EVENT_CLASS_MAY_FAULT(call, proto, args, tstruct, assign, print) \
+	DECLARE_EVENT_CLASS(call, PARAMS(proto), PARAMS(args),		\
+			    PARAMS(tstruct), PARAMS(assign), PARAMS(print))
+
 #undef DEFINE_EVENT_PRINT
 #define DEFINE_EVENT_PRINT(template, call, proto, args, print)		\
 static notrace enum print_line_t					\
@@ -250,6 +275,11 @@ static struct trace_event_fields trace_event_fields_##call[] = {	\
 	tstruct								\
 	{} };
 
+#undef DECLARE_EVENT_CLASS_MAY_FAULT
+#define DECLARE_EVENT_CLASS_MAY_FAULT(call, proto, args, tstruct, assign, print) \
+	DECLARE_EVENT_CLASS(call, PARAMS(proto), PARAMS(args),		\
+			    PARAMS(tstruct), PARAMS(assign), PARAMS(print))
+
 #undef DEFINE_EVENT_PRINT
 #define DEFINE_EVENT_PRINT(template, name, proto, args, print)
 
@@ -271,6 +301,11 @@ static inline notrace int trace_event_get_offsets_##call(		\
 	return __data_size;						\
 }
 
+#undef DECLARE_EVENT_CLASS_MAY_FAULT
+#define DECLARE_EVENT_CLASS_MAY_FAULT(call, proto, args, tstruct, assign, print) \
+	DECLARE_EVENT_CLASS(call, PARAMS(proto), PARAMS(args),		\
+			    PARAMS(tstruct), PARAMS(assign), PARAMS(print))
+
 #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
 
 /*
@@ -380,8 +415,8 @@ static inline notrace int trace_event_get_offsets_##call(		\
 
 #include "stages/stage6_event_callback.h"
 
-#undef DECLARE_EVENT_CLASS
-#define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
+#undef _DECLARE_EVENT_CLASS
+#define _DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print, tp_flags) \
 									\
 static notrace void							\
 trace_event_raw_event_##call(void *__data, proto)			\
@@ -392,6 +427,13 @@ trace_event_raw_event_##call(void *__data, proto)			\
 	struct trace_event_raw_##call *entry;				\
 	int __data_size;						\
 									\
+	DEFINE_INACTIVE_GUARD(preempt_notrace, trace_event_guard);	\
+									\
+	if ((tp_flags) & TRACEPOINT_MAY_FAULT) {			\
+		might_fault();						\
+		activate_guard(preempt_notrace, trace_event_guard)();	\
+	}								\
+									\
 	if (trace_trigger_soft_disabled(trace_file))			\
 		return;							\
 									\
@@ -409,6 +451,17 @@ trace_event_raw_event_##call(void *__data, proto)			\
 									\
 	trace_event_buffer_commit(&fbuffer);				\
 }
+
+#undef DECLARE_EVENT_CLASS
+#define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
+	_DECLARE_EVENT_CLASS(call, PARAMS(proto), PARAMS(args),		\
+			    PARAMS(tstruct), PARAMS(assign), PARAMS(print), 0)
+
+#undef DECLARE_EVENT_CLASS_MAY_FAULT
+#define DECLARE_EVENT_CLASS_MAY_FAULT(call, proto, args, tstruct, assign, print) \
+	_DECLARE_EVENT_CLASS(call, PARAMS(proto), PARAMS(args),		\
+			    PARAMS(tstruct), PARAMS(assign), PARAMS(print), TRACEPOINT_MAY_FAULT)
+
 /*
  * The ftrace_test_probe is compiled out, it is only here as a build time check
  * to make sure that if the tracepoint handling changes, the ftrace probe will
@@ -440,6 +493,11 @@ static struct trace_event_class __used __refdata event_class_##call = { \
 	_TRACE_PERF_INIT(call)						\
 };
 
+#undef DECLARE_EVENT_CLASS_MAY_FAULT
+#define DECLARE_EVENT_CLASS_MAY_FAULT(call, proto, args, tstruct, assign, print) \
+	DECLARE_EVENT_CLASS(call, PARAMS(proto), PARAMS(args),		\
+			    PARAMS(tstruct), PARAMS(assign), PARAMS(print))
+
 #undef DEFINE_EVENT
 #define DEFINE_EVENT(template, call, proto, args)			\
 									\
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 6ef29eba90ce..7a0a9197a01b 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -532,9 +532,17 @@ int trace_event_reg(struct trace_event_call *call,
 	WARN_ON(!(call->flags & TRACE_EVENT_FL_TRACEPOINT));
 	switch (type) {
 	case TRACE_REG_REGISTER:
-		return tracepoint_probe_register(call->tp,
-						 call->class->probe,
-						 file);
+		if (call->tp->flags & TRACEPOINT_MAY_FAULT) {
+			return tracepoint_probe_register_prio_flags(call->tp,
+								    call->class->probe,
+								    file,
+								    TRACEPOINT_DEFAULT_PRIO,
+								    TRACEPOINT_MAY_FAULT);
+		} else {
+			return tracepoint_probe_register(call->tp,
+							 call->class->probe,
+							 file);
+		}
 	case TRACE_REG_UNREGISTER:
 		tracepoint_probe_unregister(call->tp,
 					    call->class->probe,
@@ -543,9 +551,17 @@ int trace_event_reg(struct trace_event_call *call,
 
 #ifdef CONFIG_PERF_EVENTS
 	case TRACE_REG_PERF_REGISTER:
-		return tracepoint_probe_register(call->tp,
-						 call->class->perf_probe,
-						 call);
+		if (call->tp->flags & TRACEPOINT_MAY_FAULT) {
+			return tracepoint_probe_register_prio_flags(call->tp,
+								    call->class->perf_probe,
+								    call,
+								    TRACEPOINT_DEFAULT_PRIO,
+								    TRACEPOINT_MAY_FAULT);
+		} else {
+			return tracepoint_probe_register(call->tp,
+							 call->class->perf_probe,
+							 call);
+		}
 	case TRACE_REG_PERF_UNREGISTER:
 		tracepoint_probe_unregister(call->tp,
 					    call->class->perf_probe,
-- 
2.39.2


