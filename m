Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8A731F23C
	for <lists+bpf@lfdr.de>; Thu, 18 Feb 2021 23:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbhBRWW0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Feb 2021 17:22:26 -0500
Received: from mail.efficios.com ([167.114.26.124]:43634 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhBRWWX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Feb 2021 17:22:23 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 7EE3D29EB6B;
        Thu, 18 Feb 2021 17:21:41 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 0sxkd1Q1z6-t; Thu, 18 Feb 2021 17:21:41 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 0CC5E29EBC8;
        Thu, 18 Feb 2021 17:21:41 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 0CC5E29EBC8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1613686901;
        bh=b/tImsiFHKIA83RvVBBtFOlZLElt7JWgzez3MFpncDY=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=ismR514jxZdPkPLo4uxcO5/QVSxqyQkjgJ/gU6MQ1LsFj1dMC/a+B5QehiYZWem10
         sacwDd/mti6/oPMZyNVDYC0oLYHshG0ZlCh6V4Ib4Bdy7nerOAccrX9/awcK86LCpK
         fVALhtZB88c4pECEk4TvtLEB2qHMpmFeGJ8PC72QsQTuoCqEPkOfZbwejsDZPJSk9d
         cgbAsIYv1+zjviliD/+prgBJkZB4k946VAFeIVexpo+eSyQyhIldEViTQ7biTceNWZ
         dv/bkoNhoWLEkaf9AdHtnxgactDLhzxMFFXXzYlL1OqsqUmi0tSILH3qk+wmxT4YiR
         3WE2MK+LmJ5LA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id n6Fu7MKTR4v4; Thu, 18 Feb 2021 17:21:40 -0500 (EST)
Received: from localhost.localdomain (96-127-212-112.qc.cable.ebox.net [96.127.212.112])
        by mail.efficios.com (Postfix) with ESMTPSA id AF6A829EE91;
        Thu, 18 Feb 2021 17:21:40 -0500 (EST)
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
Subject: [RFC PATCH 2/6] tracing: ftrace: add support for faultable tracepoints
Date:   Thu, 18 Feb 2021 17:21:21 -0500
Message-Id: <20210218222125.46565-3-mjeanson@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210218222125.46565-1-mjeanson@efficios.com>
References: <20210218222125.46565-1-mjeanson@efficios.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In preparation for converting system call enter/exit instrumentation
into faultable tracepoints, make sure that ftrace can handle registering
to such tracepoints by explicitly disabling preemption within the ftrace
tracepoint probes to respect the current expectations within ftrace ring
buffer code.

This change does not yet allow ftrace to take page faults per se within
its probe, but allows its existing probes to connect to faultable
tracepoints.

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
 include/trace/trace_events.h | 75 +++++++++++++++++++++++++++++++++---
 kernel/trace/trace_events.c  | 15 +++++++-
 2 files changed, 83 insertions(+), 7 deletions(-)

diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index af9807251226..5125d3fcf963 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -80,6 +80,16 @@ TRACE_MAKE_SYSTEM_STR();
 			     PARAMS(print));		       \
 	DEFINE_EVENT(name, name, PARAMS(proto), PARAMS(args));
=20
+#undef TRACE_EVENT_MAYFAULT
+#define TRACE_EVENT_MAYFAULT(name, proto, args, tstruct, assign, print)	=
\
+	DECLARE_EVENT_CLASS_MAYFAULT(name,		       \
+			     PARAMS(proto),		       \
+			     PARAMS(args),		       \
+			     PARAMS(tstruct),		       \
+			     PARAMS(assign),		       \
+			     PARAMS(print));		       \
+	DEFINE_EVENT(name, name, PARAMS(proto), PARAMS(args));
+
=20
 #undef __field
 #define __field(type, item)		type	item;
@@ -118,6 +128,12 @@ TRACE_MAKE_SYSTEM_STR();
 									\
 	static struct trace_event_class event_class_##name;
=20
+#undef DECLARE_EVENT_CLASS_MAYFAULT
+#define DECLARE_EVENT_CLASS_MAYFAULT(name, proto, args,			\
+		tstruct, assign, print)					\
+	DECLARE_EVENT_CLASS(name, PARAMS(proto), PARAMS(args),		\
+		PARAMS(tstruct), PARAMS(assign), PARAMS(print))
+
 #undef DEFINE_EVENT
 #define DEFINE_EVENT(template, name, proto, args)	\
 	static struct trace_event_call	__used		\
@@ -141,7 +157,7 @@ TRACE_MAKE_SYSTEM_STR();
 #undef TRACE_EVENT_FN_MAYFAULT
 #define TRACE_EVENT_FN_MAYFAULT(name, proto, args, tstruct,		\
 		assign, print, reg, unreg)				\
-	TRACE_EVENT(name, PARAMS(proto), PARAMS(args),			\
+	TRACE_EVENT_MAYFAULT(name, PARAMS(proto), PARAMS(args),		\
 		PARAMS(tstruct), PARAMS(assign), PARAMS(print))		\
=20
 #undef TRACE_EVENT_FN_COND
@@ -212,6 +228,12 @@ TRACE_MAKE_SYSTEM_STR();
 		tstruct;						\
 	};
=20
+#undef DECLARE_EVENT_CLASS_MAYFAULT
+#define DECLARE_EVENT_CLASS_MAYFAULT(call, proto, args,			\
+		tstruct, assign, print)					\
+	DECLARE_EVENT_CLASS(call, PARAMS(proto), PARAMS(args),		\
+		PARAMS(tstruct), PARAMS(assign), PARAMS(print))
+
 #undef DEFINE_EVENT
 #define DEFINE_EVENT(template, name, proto, args)
=20
@@ -378,6 +400,12 @@ static struct trace_event_functions trace_event_type=
_funcs_##call =3D {	\
 	.trace			=3D trace_raw_output_##call,		\
 };
=20
+#undef DECLARE_EVENT_CLASS_MAYFAULT
+#define DECLARE_EVENT_CLASS_MAYFAULT(call, proto, args,			\
+		tstruct, assign, print)					\
+	DECLARE_EVENT_CLASS(call, PARAMS(proto), PARAMS(args),		\
+		PARAMS(tstruct), PARAMS(assign), PARAMS(print))
+
 #undef DEFINE_EVENT_PRINT
 #define DEFINE_EVENT_PRINT(template, call, proto, args, print)		\
 static notrace enum print_line_t					\
@@ -448,6 +476,12 @@ static struct trace_event_fields trace_event_fields_=
##call[] =3D {	\
 	tstruct								\
 	{} };
=20
+#undef DECLARE_EVENT_CLASS_MAYFAULT
+#define DECLARE_EVENT_CLASS_MAYFAULT(call, proto, args,			\
+		tstruct, func, print)					\
+	DECLARE_EVENT_CLASS(call, PARAMS(proto), PARAMS(args),		\
+		PARAMS(tstruct), PARAMS(func), PARAMS(print))
+
 #undef DEFINE_EVENT_PRINT
 #define DEFINE_EVENT_PRINT(template, name, proto, args, print)
=20
@@ -524,6 +558,12 @@ static inline notrace int trace_event_get_offsets_##=
call(		\
 	return __data_size;						\
 }
=20
+#undef DECLARE_EVENT_CLASS_MAYFAULT
+#define DECLARE_EVENT_CLASS_MAYFAULT(call, proto, args,			\
+		tstruct, assign, print)					\
+	DECLARE_EVENT_CLASS(call, PARAMS(proto), PARAMS(args),		\
+		PARAMS(tstruct), PARAMS(assign), PARAMS(print))
+
 #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
=20
 /*
@@ -673,8 +713,8 @@ static inline notrace int trace_event_get_offsets_##c=
all(		\
 #undef __perf_task
 #define __perf_task(t)	(t)
=20
-#undef DECLARE_EVENT_CLASS
-#define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
+#undef _DECLARE_EVENT_CLASS
+#define _DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print, =
tp_flags)	\
 									\
 static notrace void							\
 trace_event_raw_event_##call(void *__data, proto)			\
@@ -685,8 +725,11 @@ trace_event_raw_event_##call(void *__data, proto)			=
\
 	struct trace_event_raw_##call *entry;				\
 	int __data_size;						\
 									\
+	if ((tp_flags) & TRACEPOINT_MAYFAULT)				\
+		preempt_disable_notrace();				\
+									\
 	if (trace_trigger_soft_disabled(trace_file))			\
-		return;							\
+		goto end;						\
 									\
 	__data_size =3D trace_event_get_offsets_##call(&__data_offsets, args); =
\
 									\
@@ -694,14 +737,30 @@ trace_event_raw_event_##call(void *__data, proto)		=
	\
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
+	if ((tp_flags) & TRACEPOINT_MAYFAULT)				\
+		preempt_enable_notrace();				\
 }
+
+#undef DECLARE_EVENT_CLASS
+#define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
+	_DECLARE_EVENT_CLASS(call, PARAMS(proto), PARAMS(args),		\
+			PARAMS(tstruct), PARAMS(assign),		\
+			PARAMS(print), 0)
+
+#undef DECLARE_EVENT_CLASS_MAYFAULT
+#define DECLARE_EVENT_CLASS_MAYFAULT(call, proto, args, tstruct, assign,=
 print)	\
+	_DECLARE_EVENT_CLASS(call, PARAMS(proto), PARAMS(args),			\
+			PARAMS(tstruct), PARAMS(assign),			\
+			PARAMS(print), TRACEPOINT_MAYFAULT)
+
 /*
  * The ftrace_test_probe is compiled out, it is only here as a build tim=
e check
  * to make sure that if the tracepoint handling changes, the ftrace prob=
e will
@@ -748,6 +807,12 @@ static struct trace_event_class __used __refdata eve=
nt_class_##call =3D { \
 	_TRACE_PERF_INIT(call)						\
 };
=20
+#undef DECLARE_EVENT_CLASS_MAYFAULT
+#define DECLARE_EVENT_CLASS_MAYFAULT(call, proto, args,			\
+		tstruct, assign, print)					\
+	DECLARE_EVENT_CLASS(call, PARAMS(proto), PARAMS(args),		\
+		PARAMS(tstruct), PARAMS(assign), PARAMS(print))
+
 #undef DEFINE_EVENT
 #define DEFINE_EVENT(template, call, proto, args)			\
 									\
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 802f3e7d8b8b..ed2ca828311a 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -291,9 +291,15 @@ int trace_event_reg(struct trace_event_call *call,
 	WARN_ON(!(call->flags & TRACE_EVENT_FL_TRACEPOINT));
 	switch (type) {
 	case TRACE_REG_REGISTER:
-		return tracepoint_probe_register(call->tp,
+		if (call->tp->flags & TRACEPOINT_MAYFAULT)
+			return tracepoint_probe_register_mayfault(call->tp,
 						 call->class->probe,
 						 file);
+		else
+			return tracepoint_probe_register(call->tp,
+						 call->class->probe,
+						 file);
+
 	case TRACE_REG_UNREGISTER:
 		tracepoint_probe_unregister(call->tp,
 					    call->class->probe,
@@ -302,7 +308,12 @@ int trace_event_reg(struct trace_event_call *call,
=20
 #ifdef CONFIG_PERF_EVENTS
 	case TRACE_REG_PERF_REGISTER:
-		return tracepoint_probe_register(call->tp,
+		if (call->tp->flags & TRACEPOINT_MAYFAULT)
+			return tracepoint_probe_register_mayfault(call->tp,
+						 call->class->perf_probe,
+						 call);
+		else
+			return tracepoint_probe_register(call->tp,
 						 call->class->perf_probe,
 						 call);
 	case TRACE_REG_PERF_UNREGISTER:
--=20
2.25.1

