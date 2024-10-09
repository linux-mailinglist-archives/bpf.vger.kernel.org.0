Return-Path: <bpf+bounces-41324-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5EE6995CAC
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 03:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C05A91C2162E
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 01:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE5F2BD04;
	Wed,  9 Oct 2024 01:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="w7NeLC/1"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2D418EBF;
	Wed,  9 Oct 2024 01:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728436169; cv=none; b=kekc03+KbOT04/+v+cknTMA3Mtab9JFqgA8qKuUoY6lOst+Ruluk44yKBafsOnszdzfOYzCPV0U6kLeojuKROIUI0H7F2ErefKoWO5xIVqroiL+jKa/3UsxBuUefGOBAdkCz2k/Atcw9eCBWCkYlk6FCWMHPaFRYDQ3Evh5UpJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728436169; c=relaxed/simple;
	bh=2fdr6hEP0qJ7sbWkbV4sHu74VTAO9QOULSRlKfYFyjU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oY+QSGDNWr1zvr7nX2v5pRMmm+4htMDQpWCnsTDkfm24l4aE9TLaf/29TE8HLI2vnRMx02ZwYVAi9Vc/jrCiTYRVdAvdt5Uhdhm2aBmHUhFE8u9/s90l+gJw+9xA2Lnkx2I5zQibrF9YrfxBlPYFcrPIwXsByOE0ctPuCPlBS0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=w7NeLC/1; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1728436166;
	bh=2fdr6hEP0qJ7sbWkbV4sHu74VTAO9QOULSRlKfYFyjU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=w7NeLC/1eiIbwPFIkTrmH8EdQWA1/GlEJDdQIXJyxqsn+G4jEcOKpOf+xcwJWe9UA
	 TFyAq481nk2kgg+Ehvxyn+O5P88E82tAhonyUI7H66MCNB+5p5HaGlsLJEcBqA8666
	 lcNT+BvfnMsRJ7qfLMyhdohDVFTGTqpy+RvW4UqntF6OtK63ovmgzuOe/0yMz7u6SP
	 mEoDHe+q3eNgFK3n4asodog2lkxwgpRs4O5A+Lzhea+z+olpRqgU8cJvlTJMsi+Ims
	 zvCesaQJKLW8umL2BQXEDXdOVHMTU2h3rJ2C+EPH3znaWnO8tsNwvrUvliMxjw4TQg
	 +TZpeI6v4HUmQ==
Received: from thinkos.internal.efficios.com (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XNZY20xlWzS0P;
	Tue,  8 Oct 2024 21:09:26 -0400 (EDT)
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
Subject: [PATCH v4 3/8] tracing/perf: disable preemption in syscall probe
Date: Tue,  8 Oct 2024 21:07:13 -0400
Message-Id: <20241009010718.2050182-4-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241009010718.2050182-1-mathieu.desnoyers@efficios.com>
References: <20241009010718.2050182-1-mathieu.desnoyers@efficios.com>
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
Changes since v3:
- Do not use guard() for single line function, based on
  feedback from Steven.
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
2.39.2


