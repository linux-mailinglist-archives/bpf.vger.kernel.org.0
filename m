Return-Path: <bpf+bounces-39350-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 789D197236E
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 22:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDFE8B22B02
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 20:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4C918A6CA;
	Mon,  9 Sep 2024 20:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="jKHrHzdw"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA1A13B2B0;
	Mon,  9 Sep 2024 20:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725913039; cv=none; b=FAI/Qod+cyisxosoHZy6qf2JJwgxrCpvbaD/4QKRNjKlUwbhciO97dvZcBKxcvCgTOoG+e9KOIH6XUf6frcrOWS08ElTYepLjYhR7HL5BCBF2W5tpW2RieV/qFnRtV5s8SmcNzV45eyGrDk6DFHnTamA6LYD8QBKwjD2SmmBNcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725913039; c=relaxed/simple;
	bh=L37e79fW1nnCbz9UeSvSJbvkQXXomU2axg08VtYxoxM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L7OCzeOTinDn12yAnUs1peqJ3qXyG5WMIoW/gehFjNxV0Gli0vHe2PTkLYjOGkqapZSC+N+iOG7cT1+jtn7BrAuwFgn/VygSYKCH+n/sYf5oRIFtSs7rzvGFqnp/oZIbZoB4LoPBJNcAuFfAYdFcAYuCqVXCtk/LKhwPdRdw+zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=jKHrHzdw; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1725913036;
	bh=L37e79fW1nnCbz9UeSvSJbvkQXXomU2axg08VtYxoxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jKHrHzdwGa3ovEllgxT42j052GD5O3KKyIdpKwu9v5VjrJ1R4hXwzsoQ4EgAzmWEv
	 JlUHBiR9Vf22xx7w1o/KaN6FMo9QPOKXEVasYZLtB/SHFKJxgsJpGGxtbQY52T7PK0
	 Nas6395QhbGqu+bCjaqMW35sZXRhRsIrAFI+kOcaj0hjDDaA5f4TSfdDWDltPgk7oU
	 excMBgg17dytQXt/jayw4ejiXWMPpkNN+RsCsIFtzBrTf4opPeTiN+nDUvY5HzifGN
	 y2GXN4bqpffPOxzr9gpWrQYzj9HmuHEPoicNosB2ZmV969aXfAQFtzsnyXudc/hziT
	 NPl8Z1r8x55ZQ==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4X2dRH6VQCz1Ksw;
	Mon,  9 Sep 2024 16:17:15 -0400 (EDT)
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
Subject: [PATCH 2/8] tracing/ftrace: guard syscall probe with preempt_notrace
Date: Mon,  9 Sep 2024 16:16:46 -0400
Message-Id: <20240909201652.319406-3-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240909201652.319406-1-mathieu.desnoyers@efficios.com>
References: <20240909201652.319406-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for allowing system call enter/exit instrumentation to
handle page faults, make sure that ftrace can handle this change by
explicitly disabling preemption within the ftrace system call tracepoint
probes to respect the current expectations within ftrace ring buffer
code.

This change does not yet allow ftrace to take page faults per se within
its probe, but allows its existing probes to adapt to the upcoming
change.

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
 include/trace/trace_events.h  | 38 ++++++++++++++++++++++++++++-------
 kernel/trace/trace_syscalls.c | 12 +++++++++++
 2 files changed, 43 insertions(+), 7 deletions(-)

diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index 8bcbb9ee44de..0228d9ed94a3 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -263,6 +263,9 @@ static struct trace_event_fields trace_event_fields_##call[] = {	\
 	tstruct								\
 	{} };
 
+#undef DECLARE_EVENT_SYSCALL_CLASS
+#define DECLARE_EVENT_SYSCALL_CLASS DECLARE_EVENT_CLASS
+
 #undef DEFINE_EVENT_PRINT
 #define DEFINE_EVENT_PRINT(template, name, proto, args, print)
 
@@ -396,11 +399,11 @@ static inline notrace int trace_event_get_offsets_##call(		\
 
 #include "stages/stage6_event_callback.h"
 
-#undef DECLARE_EVENT_CLASS
-#define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
-									\
+
+#undef __DECLARE_EVENT_CLASS
+#define __DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print) \
 static notrace void							\
-trace_event_raw_event_##call(void *__data, proto)			\
+do_trace_event_raw_event_##call(void *__data, proto)			\
 {									\
 	struct trace_event_file *trace_file = __data;			\
 	struct trace_event_data_offsets_##call __maybe_unused __data_offsets;\
@@ -425,15 +428,34 @@ trace_event_raw_event_##call(void *__data, proto)			\
 									\
 	trace_event_buffer_commit(&fbuffer);				\
 }
+
+#undef DECLARE_EVENT_CLASS
+#define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
+__DECLARE_EVENT_CLASS(call, PARAMS(proto), PARAMS(args), PARAMS(tstruct), \
+		      PARAMS(assign), PARAMS(print))			\
+static notrace void							\
+trace_event_raw_event_##call(void *__data, proto)			\
+{									\
+	do_trace_event_raw_event_##call(__data, args);			\
+}
+
+#undef DECLARE_EVENT_SYSCALL_CLASS
+#define DECLARE_EVENT_SYSCALL_CLASS(call, proto, args, tstruct, assign, print) \
+__DECLARE_EVENT_CLASS(call, PARAMS(proto), PARAMS(args), PARAMS(tstruct), \
+		      PARAMS(assign), PARAMS(print))			\
+static notrace void							\
+trace_event_raw_event_##call(void *__data, proto)			\
+{									\
+	guard(preempt_notrace)();					\
+	do_trace_event_raw_event_##call(__data, args);			\
+}
+
 /*
  * The ftrace_test_probe is compiled out, it is only here as a build time check
  * to make sure that if the tracepoint handling changes, the ftrace probe will
  * fail to compile unless it too is updated.
  */
 
-#undef DECLARE_EVENT_SYSCALL_CLASS
-#define DECLARE_EVENT_SYSCALL_CLASS DECLARE_EVENT_CLASS
-
 #undef DEFINE_EVENT
 #define DEFINE_EVENT(template, call, proto, args)			\
 static inline void ftrace_test_probe_##call(void)			\
@@ -443,6 +465,8 @@ static inline void ftrace_test_probe_##call(void)			\
 
 #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
 
+#undef __DECLARE_EVENT_CLASS
+
 #include "stages/stage7_class_define.h"
 
 #undef DECLARE_EVENT_CLASS
diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index 067f8e2b930f..abf0e0b7cd0b 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -299,6 +299,12 @@ static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
 	int syscall_nr;
 	int size;
 
+	/*
+	 * Syscall probe called with preemption enabled, but the ring
+	 * buffer and per-cpu data require preemption to be disabled.
+	 */
+	guard(preempt_notrace)();
+
 	syscall_nr = trace_get_syscall_nr(current, regs);
 	if (syscall_nr < 0 || syscall_nr >= NR_syscalls)
 		return;
@@ -338,6 +344,12 @@ static void ftrace_syscall_exit(void *data, struct pt_regs *regs, long ret)
 	struct trace_event_buffer fbuffer;
 	int syscall_nr;
 
+	/*
+	 * Syscall probe called with preemption enabled, but the ring
+	 * buffer and per-cpu data require preemption to be disabled.
+	 */
+	guard(preempt_notrace)();
+
 	syscall_nr = trace_get_syscall_nr(current, regs);
 	if (syscall_nr < 0 || syscall_nr >= NR_syscalls)
 		return;
-- 
2.39.2


