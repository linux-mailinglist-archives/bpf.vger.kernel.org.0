Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5AD12977E6
	for <lists+bpf@lfdr.de>; Fri, 23 Oct 2020 21:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755133AbgJWTyi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Oct 2020 15:54:38 -0400
Received: from mail.efficios.com ([167.114.26.124]:45706 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755017AbgJWTyU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Oct 2020 15:54:20 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 586B9279698;
        Fri, 23 Oct 2020 15:54:19 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id vjAf7EqbJBQA; Fri, 23 Oct 2020 15:54:19 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 0281527980B;
        Fri, 23 Oct 2020 15:54:19 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 0281527980B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1603482859;
        bh=cS+Z1yDAr8AcUOGEKTdn+TykhKh9gdu61RHiIBpE4YY=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=ihNsa3SbR1l2R43+9+NDhCMNB43YLX0ygwo3FZ1pFBE1AzV2iYbrNn12Wtm0+bnFD
         Eb0OeNoOm8MnsJzswTiVqY7gy4Cc6Ly+NcCrRozLmbzmfPXxGr8tau3ojDamU5hy3R
         P8NsNGGEcjjNkF1QxvFL9cqGW6lKHOlrwIj3LsDB99BbE34gJ3hdyG16STgv8krrZ6
         v9Onu77Rq5TzawrIsPdtYZdNx86STB6iEn26qUllgN//WyQ5py38IDVfTcK6McLD8r
         //3WqkMVLCq7ZUGskbypyKAuY4noQPIkLCha1B98EDB8y7vm28HXrzaPyD7uZxV+LX
         rbYix1ymFsjpA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id cwRlg_YJ-FoS; Fri, 23 Oct 2020 15:54:18 -0400 (EDT)
Received: from localhost.localdomain (96-127-212-112.qc.cable.ebox.net [96.127.212.112])
        by mail.efficios.com (Postfix) with ESMTPSA id 96F7427979B;
        Fri, 23 Oct 2020 15:54:18 -0400 (EDT)
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
Subject: [RFC PATCH 4/6] tracing: perf: add support for sleepable tracepoints
Date:   Fri, 23 Oct 2020 15:53:50 -0400
Message-Id: <20201023195352.26269-5-mjeanson@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201023195352.26269-1-mjeanson@efficios.com>
References: <20201023195352.26269-1-mjeanson@efficios.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In preparation for converting system call enter/exit instrumentation
into sleepable tracepoints, make sure that perf can handle registering
to such tracepoints by explicitly disabling preemption within the perf
tracepoint probes to respect the current expectations within perf ring
buffer code.

This change does not yet allow perf to take page faults per se within
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
 include/trace/perf.h | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/include/trace/perf.h b/include/trace/perf.h
index dbc6c74defc3..e1d866c3a076 100644
--- a/include/trace/perf.h
+++ b/include/trace/perf.h
@@ -27,8 +27,8 @@
 #undef __perf_task
 #define __perf_task(t)	(__task =3D (t))
=20
-#undef DECLARE_EVENT_CLASS
-#define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
+#undef _DECLARE_EVENT_CLASS
+#define _DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print, =
tp_flags)	\
 static notrace void							\
 perf_trace_##call(void *__data, proto)					\
 {									\
@@ -43,13 +43,16 @@ perf_trace_##call(void *__data, proto)					\
 	int __data_size;						\
 	int rctx;							\
 									\
+	if ((tp_flags) & TRACEPOINT_MAYSLEEP)				\
+		preempt_disable_notrace();				\
+									\
 	__data_size =3D trace_event_get_offsets_##call(&__data_offsets, args); =
\
 									\
 	head =3D this_cpu_ptr(event_call->perf_events);			\
 	if (!bpf_prog_array_valid(event_call) &&			\
 	    __builtin_constant_p(!__task) && !__task &&			\
 	    hlist_empty(head))						\
-		return;							\
+		goto end;						\
 									\
 	__entry_size =3D ALIGN(__data_size + sizeof(*entry) + sizeof(u32),\
 			     sizeof(u64));				\
@@ -57,7 +60,7 @@ perf_trace_##call(void *__data, proto)					\
 									\
 	entry =3D perf_trace_buf_alloc(__entry_size, &__regs, &rctx);	\
 	if (!entry)							\
-		return;							\
+		goto end;						\
 									\
 	perf_fetch_caller_regs(__regs);					\
 									\
@@ -68,8 +71,23 @@ perf_trace_##call(void *__data, proto)					\
 	perf_trace_run_bpf_submit(entry, __entry_size, rctx,		\
 				  event_call, __count, __regs,		\
 				  head, __task);			\
+end:									\
+	if ((tp_flags) & TRACEPOINT_MAYSLEEP)				\
+		preempt_enable_notrace();				\
 }
=20
+#undef DECLARE_EVENT_CLASS
+#define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
+	_DECLARE_EVENT_CLASS(call, PARAMS(proto), PARAMS(args),		\
+		PARAMS(tstruct), PARAMS(assign), PARAMS(print), 0)
+
+#undef DECLARE_EVENT_CLASS_MAYSLEEP
+#define DECLARE_EVENT_CLASS_MAYSLEEP(call, proto, args, tstruct,	\
+		assign, print)						\
+	_DECLARE_EVENT_CLASS(call, PARAMS(proto), PARAMS(args),		\
+		PARAMS(tstruct), PARAMS(assign), PARAMS(print),		\
+		TRACEPOINT_MAYSLEEP)
+
 /*
  * This part is compiled out, it is only here as a build time check
  * to make sure that if the tracepoint handling changes, the
--=20
2.25.1

