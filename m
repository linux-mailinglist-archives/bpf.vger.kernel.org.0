Return-Path: <bpf+bounces-39351-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40924972371
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 22:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9900C288564
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 20:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D514B18A948;
	Mon,  9 Sep 2024 20:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="tgLXp5RN"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDF416EB55;
	Mon,  9 Sep 2024 20:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725913039; cv=none; b=PhU8F8xW0IRmwCqUjCF4NVBVvmpXOyMQoC0rwxkrq9sNrbMIcC09IH3UVqoIBMTa0JMtLUVJaqogYKCMBZ70DQxRaWyTPCrmLCDHRBFqWS2N9B4u74GZVuKuQXo1n/aq1TDwbWzAZWWDAxfdIP+lgUkAb3AY+VusF2MOCswIjWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725913039; c=relaxed/simple;
	bh=MWuMSBa0wltjyl8Q6xHGNS8TrHMMgd8rkPqmN7QbQzs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sRpt3sy1btPMj6z/vzBBvPVCT9KwrtG7ra5tSjYGuHwCHP/Pu4i6egj7VJe3EIKsh582rJh0Az65bNvCPgRhb9XPLcXJe86JinTCml9huiQB7k2f60WTYbcxN27zUyeDaCiZicl256mGFygtSoQSm2ZJFfLPl+PJkTKxYiOEKpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=tgLXp5RN; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1725913036;
	bh=MWuMSBa0wltjyl8Q6xHGNS8TrHMMgd8rkPqmN7QbQzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tgLXp5RN8e3oKPyxKcUJVJvn95spYGTjLaPySxOBYjhob2svcxRQW7QbugmeXVMI0
	 tY2YTPeZrUNAsIoHgLjaNxjcot4xAupYjTuCN+JDYLNaPn7eXod2HZVGIfB8yW8oe8
	 4oMmbWBLWqxRip/JWoqRjwjEIxnz3IFZgTlf1NPczi88jcXSEstP/lu921OfJRz6hR
	 S4QCvJA6I3XCBVCZa0t2zVFG3270S/nRMbNq0UBPLuuGUSzEau6fCmxbGi//RTFItR
	 wg+d+EQ0su8EWmc6vZI6vI6faqcksE4vIubfYoCDKlIduT2aTnN4JqKVxwUJtwjmwY
	 LpoIEMx+P/Y2w==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4X2dRJ23Pbz1KQX;
	Mon,  9 Sep 2024 16:17:16 -0400 (EDT)
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
Subject: [PATCH 3/8] tracing/perf: guard syscall probe with preempt_notrace
Date: Mon,  9 Sep 2024 16:16:47 -0400
Message-Id: <20240909201652.319406-4-mathieu.desnoyers@efficios.com>
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
index abf0e0b7cd0b..a3d8ac00793e 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -594,6 +594,12 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
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
@@ -694,6 +700,12 @@ static void perf_syscall_exit(void *ignore, struct pt_regs *regs, long ret)
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


