Return-Path: <bpf+bounces-41576-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F94699898B
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 16:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31B871F260A3
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 14:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFA21CF5C9;
	Thu, 10 Oct 2024 14:25:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825A11CF285;
	Thu, 10 Oct 2024 14:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728570342; cv=none; b=oY4a2StqhRvTO0eZvU2Vo5677t74Hs9X0RFR4uVcxXLhyoN1zbaVgDV8QbSWapknmFeVkQoI8cA54nGblvCKZ3YKWMvbzmP9qGJsqKfSFfiEAheBhfEZlX+ioAql4faWugSbwOBjsecyeUg2cMTc3RL2ch0hSDEKvcHIcgMf8/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728570342; c=relaxed/simple;
	bh=eQHhke5k4i9JBpnAN/Ni0RSJhYVX9qXVOjWd7DhqfsI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=nbvkn+D/bpI6w0D8S6+Fp6oZ8DEwV5kaZpQAJ5RB18MtwJrmtzN1h8F9MMTO3kjX6MEI1jKknMafrjznXDpANdx68T1Mb2p3t+RIY3dOdKjapYbaCNlZB1JC+Ule48g2DAXjPDBQWgXU8ISweaUREdTBESBZ15xRaaCIDEJfDdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 429B5C4CED5;
	Thu, 10 Oct 2024 14:25:42 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1syu6w-00000001HHq-0hvW;
	Thu, 10 Oct 2024 10:25:50 -0400
Message-ID: <20241010142550.028515414@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 10 Oct 2024 10:25:40 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Michael Jeanson <mjeanson@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Alexei Starovoitov <ast@kernel.org>,
 Yonghong Song <yhs@fb.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Namhyung Kim <namhyung@kernel.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 bpf@vger.kernel.org,
 Joel Fernandes <joel@joelfernandes.org>
Subject: [for-next][PATCH 03/10] tracing/perf: disable preemption in syscall probe
References: <20241010142537.255433162@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

In preparation for allowing system call enter/exit instrumentation to
handle page faults, make sure that perf can handle this change by
explicitly disabling preemption within the perf system call tracepoint
probes to respect the current expectations within perf ring buffer code.

This change does not yet allow perf to take page faults per se within
its probe, but allows its existing probes to adapt to the upcoming
change.

Cc: Michael Jeanson <mjeanson@efficios.com>
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
Link: https://lore.kernel.org/20241009010718.2050182-4-mathieu.desnoyers@efficios.com
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/trace/perf.h          | 42 +++++++++++++++++++++++++++++++----
 kernel/trace/trace_syscalls.c | 12 ++++++++++
 2 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/include/trace/perf.h b/include/trace/perf.h
index ded997af481e..15cde7eac8b4 100644
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
@@ -55,8 +55,39 @@ perf_trace_##call(void *__data, proto)					\
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
+	preempt_disable_notrace();					\
+	do_perf_trace_##call(__data, args);				\
+	preempt_enable_notrace();					\
+}
 
 /*
  * This part is compiled out, it is only here as a build time check
@@ -76,4 +107,7 @@ static inline void perf_test_probe_##call(void)				\
 	DEFINE_EVENT(template, name, PARAMS(proto), PARAMS(args))
 
 #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
+
+#undef __DECLARE_EVENT_CLASS
+
 #endif /* CONFIG_PERF_EVENTS */
diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index f9b21bac9d45..b1cc19806f3d 100644
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
2.45.2



