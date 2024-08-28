Return-Path: <bpf+bounces-38283-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 676EC962A8A
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 16:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EF8428197A
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 14:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D685C1A01CC;
	Wed, 28 Aug 2024 14:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="BjqE+mIo"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B66189505;
	Wed, 28 Aug 2024 14:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724856151; cv=none; b=q+J3rh8hM6CY7zfwlBZupmTbl0ljlwb8GmTO0RREkKcTR1Vai9iiqmDf3UT4CLyj8ix87GCkO33jurqo6FAyE75BPvBq1ql+kBNLqwdgcLTjCj9BAsi7UZQn1EdY7nV5kDo1onq+t8EAgahP2l1Uu1p3/CJDz3N3ytu9FMPxQ4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724856151; c=relaxed/simple;
	bh=nIWHmNh21LNhWalKnly2O+Moa6z7+iGW/VJoYGdBemo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J10qpkuIrfG7uj+5tHV6doSVmGBwuQoCtY4B/xhGEAw+p/1G9iYpRYZD/Uo0uz2xmleZsAtE+B74eb+tmeT6CgM/txjp8dvE2etT2w6gIAa+E6cG8fv77uH1ZpLyMbQKbLha/j4hKUCzVW9/YvZZ0p+osaPW7C0Iu/qm5li3/3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=BjqE+mIo; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1724856148;
	bh=nIWHmNh21LNhWalKnly2O+Moa6z7+iGW/VJoYGdBemo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BjqE+mIoEc4ip4cS/evjhYBVM4GGy6zzaJP1kiEe3xU5Qdhf6mBtWzV8sla/KmNYE
	 FaI6PWstwqActMdVP7zhaaLYvUwJ9w0+MdsvyBZ8gNL82A/E1AfUT1xwLi5r5Cvsxx
	 PRhvPaEjrSrx/z83hpxUYsFxtyqUo50kNVEoOtmy7VrhdA7haKI7GPOS7yfLJZBhQj
	 eH1UHMFeY/6dUW/f0j3fcWVl6bSNgj+bstL+BmVPLAeTS0Jtbh5h3niPTMdFBFyLyg
	 zH3naY9o5oaDzmG9jlarYx2NSBpz+FVZgftdF549VTB8BVl1r61PtPUn4lDTznysyw
	 A11XZ7LcPIwVA==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Wv6ZX32wRz1JFR;
	Wed, 28 Aug 2024 10:42:28 -0400 (EDT)
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
	bpf@vger.kernel.org,
	Joel Fernandes <joel@joelfernandes.org>,
	linux-trace-kernel@vger.kernel.org,
	Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH v6 2/5] tracing/ftrace: Add support for faultable tracepoints
Date: Wed, 28 Aug 2024 10:41:49 -0400
Message-Id: <20240828144153.829582-3-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240828144153.829582-1-mathieu.desnoyers@efficios.com>
References: <20240828144153.829582-1-mathieu.desnoyers@efficios.com>
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
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
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
Cc: bpf@vger.kernel.org
Cc: Joel Fernandes <joel@joelfernandes.org>
---
Changes since v4:
- Use DEFINE_INACTIVE_GUARD.
- Add brackets to multiline 'if' statements.
Changes since v5:
- Pass the TRACEPOINT_MAY_FAULT flag directly to tracepoint_probe_register_prio_flags.
---
 include/trace/trace_events.h | 64 ++++++++++++++++++++++++++++++++++--
 kernel/trace/trace_events.c  | 16 +++++----
 2 files changed, 71 insertions(+), 9 deletions(-)

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
index 7266ec2a4eea..5722e426143d 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -532,9 +532,11 @@ int trace_event_reg(struct trace_event_call *call,
 	WARN_ON(!(call->flags & TRACE_EVENT_FL_TRACEPOINT));
 	switch (type) {
 	case TRACE_REG_REGISTER:
-		return tracepoint_probe_register(call->tp,
-						 call->class->probe,
-						 file);
+		return tracepoint_probe_register_prio_flags(call->tp,
+							    call->class->probe,
+							    file,
+							    TRACEPOINT_DEFAULT_PRIO,
+							    call->tp->flags & TRACEPOINT_MAY_FAULT);
 	case TRACE_REG_UNREGISTER:
 		tracepoint_probe_unregister(call->tp,
 					    call->class->probe,
@@ -543,9 +545,11 @@ int trace_event_reg(struct trace_event_call *call,
 
 #ifdef CONFIG_PERF_EVENTS
 	case TRACE_REG_PERF_REGISTER:
-		return tracepoint_probe_register(call->tp,
-						 call->class->perf_probe,
-						 call);
+		return tracepoint_probe_register_prio_flags(call->tp,
+							    call->class->perf_probe,
+							    call,
+							    TRACEPOINT_DEFAULT_PRIO,
+							    call->tp->flags & TRACEPOINT_MAY_FAULT);
 	case TRACE_REG_PERF_UNREGISTER:
 		tracepoint_probe_unregister(call->tp,
 					    call->class->perf_probe,
-- 
2.39.2


