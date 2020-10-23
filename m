Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2EAB2977E0
	for <lists+bpf@lfdr.de>; Fri, 23 Oct 2020 21:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755030AbgJWTyV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Oct 2020 15:54:21 -0400
Received: from mail.efficios.com ([167.114.26.124]:45624 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S463938AbgJWTyU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Oct 2020 15:54:20 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id AD11F279340;
        Fri, 23 Oct 2020 15:54:18 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id cKe7_8r-O1NN; Fri, 23 Oct 2020 15:54:18 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 346D027933E;
        Fri, 23 Oct 2020 15:54:18 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 346D027933E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1603482858;
        bh=1k/Fc6f/EyimtcvTtfhKUy5m5XKDGsU8/p129kdRdMk=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=lqOvpsjNrK+U7UDmHkZo6G452BqjZToR85K9/hQTONiQ6/BeA38C0iV/ku+XoxeZE
         rszC+1fC7hje2jSmE5VuRJhnNdyUiZPsePzfsI4OM4aPE+i9LATq3s86hlxABHMsYv
         to6oIXUMKRr5pdxtPHom6R7l0KCERWYFFlZle4FlJONBCpK+UQHW1JTPpDEhnZga81
         w47eVFOCgG0UMNjq9QJCxCul0GjCYzNRP39gm1T5WVa/8J+V+m3St+ZC+0RU20ahg/
         I5EJREVbijO4+4EkQZQXF34DOQcXFUwrcuTrZfhDod1bfCirDYBEnCINilg9725s9i
         vVvhTjxUXKOHQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Hv855XeYaNej; Fri, 23 Oct 2020 15:54:18 -0400 (EDT)
Received: from localhost.localdomain (96-127-212-112.qc.cable.ebox.net [96.127.212.112])
        by mail.efficios.com (Postfix) with ESMTPSA id D7AA9279622;
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
Subject: [RFC PATCH 2/6] tracing: ftrace: add support for sleepable tracepoints
Date:   Fri, 23 Oct 2020 15:53:48 -0400
Message-Id: <20201023195352.26269-3-mjeanson@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201023195352.26269-1-mjeanson@efficios.com>
References: <20201023195352.26269-1-mjeanson@efficios.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In preparation for converting system call enter/exit instrumentation
into sleepable tracepoints, make sure that ftrace can handle registering
to such tracepoints by explicitly disabling preemption within the ftrace
tracepoint probes to respect the current expectations within ftrace ring
buffer code.

This change does not yet allow ftrace to take page faults per se within
its probe, but allows its existing probes to connect to sleepable
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
Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Cc: bpf@vger.kernel.org
---
 include/trace/trace_events.h | 75 +++++++++++++++++++++++++++++++++---
 kernel/trace/trace_events.c  | 15 +++++++-
 2 files changed, 83 insertions(+), 7 deletions(-)

diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index 8b3f4068a702..b95a9c3d9405 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -80,6 +80,16 @@ TRACE_MAKE_SYSTEM_STR();
 			     PARAMS(print));		       \
 	DEFINE_EVENT(name, name, PARAMS(proto), PARAMS(args));
=20
+#undef TRACE_EVENT_MAYSLEEP
+#define TRACE_EVENT_MAYSLEEP(name, proto, args, tstruct, assign, print)	=
\
+	DECLARE_EVENT_CLASS_MAYSLEEP(name,		       \
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
+#undef DECLARE_EVENT_CLASS_MAYSLEEP
+#define DECLARE_EVENT_CLASS_MAYSLEEP(name, proto, args,			\
+		tstruct, assign, print)					\
+	DECLARE_EVENT_CLASS(name, PARAMS(proto), PARAMS(args),		\
+		PARAMS(tstruct), PARAMS(assign), PARAMS(print))
+
 #undef DEFINE_EVENT
 #define DEFINE_EVENT(template, name, proto, args)	\
 	static struct trace_event_call	__used		\
@@ -141,7 +157,7 @@ TRACE_MAKE_SYSTEM_STR();
 #undef TRACE_EVENT_FN_MAYSLEEP
 #define TRACE_EVENT_FN_MAYSLEEP(name, proto, args, tstruct,		\
 		assign, print, reg, unreg)				\
-	TRACE_EVENT(name, PARAMS(proto), PARAMS(args),			\
+	TRACE_EVENT_MAYSLEEP(name, PARAMS(proto), PARAMS(args),		\
 		PARAMS(tstruct), PARAMS(assign), PARAMS(print))		\
=20
 #undef TRACE_EVENT_FN_COND
@@ -212,6 +228,12 @@ TRACE_MAKE_SYSTEM_STR();
 		tstruct;						\
 	};
=20
+#undef DECLARE_EVENT_CLASS_MAYSLEEP
+#define DECLARE_EVENT_CLASS_MAYSLEEP(call, proto, args,			\
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
+#undef DECLARE_EVENT_CLASS_MAYSLEEP
+#define DECLARE_EVENT_CLASS_MAYSLEEP(call, proto, args,			\
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
+#undef DECLARE_EVENT_CLASS_MAYSLEEP
+#define DECLARE_EVENT_CLASS_MAYSLEEP(call, proto, args,			\
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
+#undef DECLARE_EVENT_CLASS_MAYSLEEP
+#define DECLARE_EVENT_CLASS_MAYSLEEP(call, proto, args,			\
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
+	if ((tp_flags) & TRACEPOINT_MAYSLEEP)				\
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
+	if ((tp_flags) & TRACEPOINT_MAYSLEEP)				\
+		preempt_enable_notrace();				\
 }
+
+#undef DECLARE_EVENT_CLASS
+#define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
+	_DECLARE_EVENT_CLASS(call, PARAMS(proto), PARAMS(args),		\
+			PARAMS(tstruct), PARAMS(assign),		\
+			PARAMS(print), 0)
+
+#undef DECLARE_EVENT_CLASS_MAYSLEEP
+#define DECLARE_EVENT_CLASS_MAYSLEEP(call, proto, args, tstruct, assign,=
 print)	\
+	_DECLARE_EVENT_CLASS(call, PARAMS(proto), PARAMS(args),			\
+			PARAMS(tstruct), PARAMS(assign),			\
+			PARAMS(print), TRACEPOINT_MAYSLEEP)
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
+#undef DECLARE_EVENT_CLASS_MAYSLEEP
+#define DECLARE_EVENT_CLASS_MAYSLEEP(call, proto, args,			\
+		tstruct, assign, print)					\
+	DECLARE_EVENT_CLASS(call, PARAMS(proto), PARAMS(args),		\
+		PARAMS(tstruct), PARAMS(assign), PARAMS(print))
+
 #undef DEFINE_EVENT
 #define DEFINE_EVENT(template, call, proto, args)			\
 									\
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index a85effb2373b..058fe2834f14 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -290,9 +290,15 @@ int trace_event_reg(struct trace_event_call *call,
 	WARN_ON(!(call->flags & TRACE_EVENT_FL_TRACEPOINT));
 	switch (type) {
 	case TRACE_REG_REGISTER:
-		return tracepoint_probe_register(call->tp,
+		if (call->tp->flags & TRACEPOINT_MAYSLEEP)
+			return tracepoint_probe_register_maysleep(call->tp,
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
@@ -301,7 +307,12 @@ int trace_event_reg(struct trace_event_call *call,
=20
 #ifdef CONFIG_PERF_EVENTS
 	case TRACE_REG_PERF_REGISTER:
-		return tracepoint_probe_register(call->tp,
+		if (call->tp->flags & TRACEPOINT_MAYSLEEP)
+			return tracepoint_probe_register_maysleep(call->tp,
+						 call->class->perf_probe,
+						 call);
+		else
+			return tracepoint_probe_register(call->tp,
 						 call->class->perf_probe,
 						 call);
 	case TRACE_REG_PERF_UNREGISTER:
--=20
2.25.1

