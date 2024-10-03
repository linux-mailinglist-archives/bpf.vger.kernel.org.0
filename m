Return-Path: <bpf+bounces-40836-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA9198F259
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 17:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF6891C21926
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 15:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E921A3AA5;
	Thu,  3 Oct 2024 15:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="NluCR9Uh"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC05DDA8;
	Thu,  3 Oct 2024 15:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727968729; cv=none; b=jZi1Rc2fUYc3UVME3Cn4Vf1VGevrpm/imT2REj7HbrgWqLJKV9UPa+yw54i/KZVKn8fSd88buQGEF5wjFMML2flMkUlwWtdXT7kLXvzpojIrcMFbmliYu0PJbeJqJTpANZwq00E96nTEl6JfGYfUx91Lnl6V+O8M6NSWY3F4ISc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727968729; c=relaxed/simple;
	bh=xLHuv9/61/GTu39f5ouDh6xzs97QFfjZjBVP9NGmNMs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gXk2c8i8cSyDwUlYYYsgYfsiSObHWp6yBqz8gh80DcjlRpRrcir/MGXf+RFSdugJz3Tb12PnjJLlo0M4j/Sdnr2dlG320hO8C3vPBbuimmipcuoCX3wdK8YJdnDecHqeiFcGyodEZiVhUOjeFMo8rZLxJJbSfMea5PYx2ZB626k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=NluCR9Uh; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1727968724;
	bh=xLHuv9/61/GTu39f5ouDh6xzs97QFfjZjBVP9NGmNMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NluCR9Uh9G9Clc/r3fRK9HTEIitLgkArB/6qMtTvPVSc3GHw7oxX5P0IE2kr3z4Eq
	 tqwsFv1YqobrcCEtJ52O2OcSqnYRjekWZokH1aSvncZlY5g2Vjz8A+MOXW59/bYpis
	 jLHWJcp7q5x45aZVT1ki7lrx/xXPlJaaQdlP4EeNASP4vM34ugQTJzWiUR3IyEB2ZR
	 q7zCOs5O1kIyCGKGaODQHnipQBHjx6NU8rxgycmX10P5n5VwC7gJrfrhY1EeCpY6CV
	 SCKroKQjwUwvlLrs7x6wx4SZ10oifdmilei2iArResKZn4ru/wC/PHXRjTCQ+Ipb8S
	 31w2sWtUyGoAQ==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XKFgl6Zjxz5t2;
	Thu,  3 Oct 2024 11:18:43 -0400 (EDT)
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
Subject: [PATCH v1 3/8] tracing/perf: guard syscall probe with preempt_notrace
Date: Thu,  3 Oct 2024 11:16:33 -0400
Message-Id: <20241003151638.1608537-4-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241003151638.1608537-1-mathieu.desnoyers@efficios.com>
References: <20241003151638.1608537-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for allowing system call enter/exit instrumentation to
handle page faults, make sure that perf can handle this change by
explicitly disabling preemption within the perf system call tracepoint
probes to respect the current expectations within perf ring buffer code.

This change does not yet allow perf to take page faults per se within
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
 include/trace/perf.h          | 41 +++++++++++++++++++++++++++++++----
 kernel/trace/trace_syscalls.c | 12 ++++++++++
 2 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/include/trace/perf.h b/include/trace/perf.h
index ded997af481e..5650c1bad088 100644
--- a/include/trace/perf.h
+++ b/include/trace/perf.h
@@ -12,10 +12,10 @@
 #undef __perf_task
 #define __perf_task(t)	(__task = (t))
 
-#undef DECLARE_EVENT_CLASS
-#define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
+#undef __DECLARE_EVENT_CLASS
+#define __DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print) \
 static notrace void							\
-perf_trace_##call(void *__data, proto)					\
+do_perf_trace_##call(void *__data, proto)				\
 {									\
 	struct trace_event_call *event_call = __data;			\
 	struct trace_event_data_offsets_##call __maybe_unused __data_offsets;\
@@ -55,8 +55,38 @@ perf_trace_##call(void *__data, proto)					\
 				  head, __task);			\
 }
 
+/*
+ * Define unused __count and __task variables to use @args to pass
+ * arguments to do_perf_trace_##call. This is needed because the
+ * macros __perf_count and __perf_task introduce the side-effect to
+ * store copies into those local variables.
+ */
+#undef DECLARE_EVENT_CLASS
+#define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
+__DECLARE_EVENT_CLASS(call, PARAMS(proto), PARAMS(args), PARAMS(tstruct), \
+		      PARAMS(assign), PARAMS(print))			\
+static notrace void							\
+perf_trace_##call(void *__data, proto)					\
+{									\
+	u64 __count __attribute__((unused));				\
+	struct task_struct *__task __attribute__((unused));		\
+									\
+	do_perf_trace_##call(__data, args);				\
+}
+
 #undef DECLARE_EVENT_SYSCALL_CLASS
-#define DECLARE_EVENT_SYSCALL_CLASS DECLARE_EVENT_CLASS
+#define DECLARE_EVENT_SYSCALL_CLASS(call, proto, args, tstruct, assign, print) \
+__DECLARE_EVENT_CLASS(call, PARAMS(proto), PARAMS(args), PARAMS(tstruct), \
+		      PARAMS(assign), PARAMS(print))			\
+static notrace void							\
+perf_trace_##call(void *__data, proto)					\
+{									\
+	u64 __count __attribute__((unused));				\
+	struct task_struct *__task __attribute__((unused));		\
+									\
+	guard(preempt_notrace)();					\
+	do_perf_trace_##call(__data, args);				\
+}
 
 /*
  * This part is compiled out, it is only here as a build time check
@@ -76,4 +106,7 @@ static inline void perf_test_probe_##call(void)				\
 	DEFINE_EVENT(template, name, PARAMS(proto), PARAMS(args))
 
 #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
+
+#undef __DECLARE_EVENT_CLASS
+
 #endif /* CONFIG_PERF_EVENTS */
diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index ab4db8c23f36..edcfa47446c7 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -596,6 +596,12 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
 	int rctx;
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
@@ -698,6 +704,12 @@ static void perf_syscall_exit(void *ignore, struct pt_regs *regs, long ret)
 	int rctx;
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
-- 
2.39.2


