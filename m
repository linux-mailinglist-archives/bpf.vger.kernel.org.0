Return-Path: <bpf+bounces-11226-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 017D37B5BFA
	for <lists+bpf@lfdr.de>; Mon,  2 Oct 2023 22:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 98942282838
	for <lists+bpf@lfdr.de>; Mon,  2 Oct 2023 20:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A0B20317;
	Mon,  2 Oct 2023 20:25:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D410200DD
	for <bpf@vger.kernel.org>; Mon,  2 Oct 2023 20:25:44 +0000 (UTC)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7680FE1;
	Mon,  2 Oct 2023 13:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1696278339;
	bh=b6ERRrNl/kqb2M6O3GhmbXA65CabxqVf2CotojnC7Fo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KNI3dT+peqCUIXNT5ZwTVNVJdhDl8eubopuNbBhrzm1ClvJ2YXIlR0zGk5eKe/dxi
	 qj0QIt6WrbLeKR8xPi7rO0yJu++/LvDKNj2+PX/13LzBsgOiR1PDZwALxV4bmrKbTB
	 jFdCVqeigtF6Du77u7zQDZSxJc8DdzJNQLUNgHCRz0QHN1Slw/ZYnidTNt7K6Bu7dh
	 wqWZjmkilsGP1UkXAcO9JF7AwJk+A0eFOFKv305W6YabuXnotf+Tr2/0GTwC1/BiPd
	 r5rxB4oXxuTAUHhY4G51+yeovsNsG+aEVadwmEvqugxaT44EXDXwAkhTMCcN/oxU0e
	 RB5/uS89Nh+iw==
Received: from localhost.localdomain (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4RzssH3R3Fz1VYf;
	Mon,  2 Oct 2023 16:25:39 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Michael Jeanson <mjeanson@efficios.com>,
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
	Joel Fernandes <joel@joelfernandes.org>
Subject: [RFC PATCH v3 2/5] tracing/ftrace: Add support for faultable tracepoints
Date: Mon,  2 Oct 2023 16:25:28 -0400
Message-Id: <20231002202531.3160-3-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231002202531.3160-1-mathieu.desnoyers@efficios.com>
References: <20231002202531.3160-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In preparation for converting system call enter/exit instrumentation
into faultable tracepoints, make sure that ftrace can handle registering
to such tracepoints by explicitly disabling preemption within the ftrace
tracepoint probes to respect the current expectations within ftrace ring
buffer code.

This change does not yet allow ftrace to take page faults per se within
its probe, but allows its existing probes to connect to faultable
tracepoints.

Co-developed-by: Michael Jeanson <mjeanson@efficios.com>
Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
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
 include/trace/trace_events.h | 69 +++++++++++++++++++++++++++++++++---
 kernel/trace/trace_events.c  | 26 ++++++++++----
 2 files changed, 84 insertions(+), 11 deletions(-)

diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index df590eea8ae4..558af4960157 100644
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
@@ -392,8 +427,13 @@ trace_event_raw_event_##call(void *__data, proto)			\
 	struct trace_event_raw_##call *entry;				\
 	int __data_size;						\
 									\
+	if ((tp_flags) & TRACEPOINT_MAY_FAULT) {			\
+		might_fault();						\
+		preempt_disable_notrace();				\
+	}								\
+									\
 	if (trace_trigger_soft_disabled(trace_file))			\
-		return;							\
+		goto end;						\
 									\
 	__data_size = trace_event_get_offsets_##call(&__data_offsets, args); \
 									\
@@ -401,14 +441,28 @@ trace_event_raw_event_##call(void *__data, proto)			\
 				 sizeof(*entry) + __data_size);		\
 									\
 	if (!entry)							\
-		return;							\
+		goto end;						\
 									\
 	tstruct								\
 									\
 	{ assign; }							\
 									\
 	trace_event_buffer_commit(&fbuffer);				\
+end:									\
+	if ((tp_flags) & TRACEPOINT_MAY_FAULT)				\
+		preempt_enable_notrace();				\
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
@@ -440,6 +494,11 @@ static struct trace_event_class __used __refdata event_class_##call = { \
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
index 0cf84a7449f5..7e5722cd00dd 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -532,9 +532,16 @@ int trace_event_reg(struct trace_event_call *call,
 	WARN_ON(!(call->flags & TRACE_EVENT_FL_TRACEPOINT));
 	switch (type) {
 	case TRACE_REG_REGISTER:
-		return tracepoint_probe_register(call->tp,
-						 call->class->probe,
-						 file);
+		if (call->tp->flags & TRACEPOINT_MAY_FAULT)
+			return tracepoint_probe_register_prio_flags(call->tp,
+								    call->class->probe,
+								    file,
+								    TRACEPOINT_DEFAULT_PRIO,
+								    TRACEPOINT_MAY_FAULT);
+		else
+			return tracepoint_probe_register(call->tp,
+							 call->class->probe,
+							 file);
 	case TRACE_REG_UNREGISTER:
 		tracepoint_probe_unregister(call->tp,
 					    call->class->probe,
@@ -543,9 +550,16 @@ int trace_event_reg(struct trace_event_call *call,
 
 #ifdef CONFIG_PERF_EVENTS
 	case TRACE_REG_PERF_REGISTER:
-		return tracepoint_probe_register(call->tp,
-						 call->class->perf_probe,
-						 call);
+		if (call->tp->flags & TRACEPOINT_MAY_FAULT)
+			return tracepoint_probe_register_prio_flags(call->tp,
+								    call->class->perf_probe,
+								    call,
+								    TRACEPOINT_DEFAULT_PRIO,
+								    TRACEPOINT_MAY_FAULT);
+		else
+			return tracepoint_probe_register(call->tp,
+							 call->class->perf_probe,
+							 call);
 	case TRACE_REG_PERF_UNREGISTER:
 		tracepoint_probe_unregister(call->tp,
 					    call->class->perf_probe,
-- 
2.25.1


