Return-Path: <bpf+bounces-33268-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C2A91AB22
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 17:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58BA9B26793
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 15:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B49F199E8D;
	Thu, 27 Jun 2024 15:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="ZrFUC3wY"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A561991BE;
	Thu, 27 Jun 2024 15:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719501795; cv=none; b=rj9RQEkbNOA8dOqCfKv2JgQqV36tMG9ZPo4WdwniyR/ssVl3kmj81m07967MGycb7pnyvB1dmuruUAAzSumiz3zRpyfn8Sv/5uKD8Vu6YgqJ0ZOqt26zJ9dsYlTuHfWn8LLUGRtr9QNNp9fu9R5wjG5bf411OJZovlDlaPqf6/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719501795; c=relaxed/simple;
	bh=xzEpoi/822I96WwOObd/AuRtvCVbCJ5NC2CjyIj3490=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K+B5hvF1x43b8pwhNc6/Zk2p58gie9Hy4GcPbeT7lHsV5Rpa4vvM05vIgE782TCwvkXEFnefyHbT+ID6+sNYF6DqJi6Ho+NT7KefMAZP8R565NL90b59WCBEyxq5STuRO6DoDKJD6C46LjZYoHMWBrEsOP7PAh4HqChiKL6I6J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=ZrFUC3wY; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1719501791;
	bh=xzEpoi/822I96WwOObd/AuRtvCVbCJ5NC2CjyIj3490=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZrFUC3wYccQqgud2Y9p29g8IH+WTFREkfmcV6tD4SLwV8Sf2HhhKcmlQ3cwndtbqQ
	 9ofSt6RsovSy1+0clZdLDngAVDMnanVrR942pZPOU5ke44IUOZxS9VrYSwhGxOS++P
	 MlwYTgNHv+AsFz6nEc/GEp0CKu4qU+qQYkujotWQUEIajWXY2tIUmphMSFE7jUNXJ1
	 BrmR3qsiqM1s8JElzqShDiHz4hpqie2tTzAvBEKfIbGXfoxChJwZqgoh4aLrCOjv1H
	 IM51DO0Tyvjy6XczZviKD6qMAcAl6cERS51mUfLuWflQdCHWZ24A8B3OB+RX2FUJv+
	 EG+wxV7fiCCYQ==
Received: from thinkos.internal.efficios.com (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4W92Q72ftJz17lr;
	Thu, 27 Jun 2024 11:23:11 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
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
	Joel Fernandes <joel@joelfernandes.org>,
	Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH v5 8/8] tracing: Convert sys_enter/exit to faultable tracepoints
Date: Thu, 27 Jun 2024 11:23:40 -0400
Message-Id: <20240627152340.82413-9-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240627152340.82413-1-mathieu.desnoyers@efficios.com>
References: <20240627152340.82413-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the definition of the system call enter/exit tracepoints to
faultable tracepoints now that all upstream tracers handle it.

This allows tracers to fault-in userspace system call arguments such as
path strings within their probe callbacks.

Link: https://lore.kernel.org/lkml/20231002202531.3160-1-mathieu.desnoyers@efficios.com/
Co-developed-by: Michael Jeanson <mjeanson@efficios.com>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
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
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: bpf@vger.kernel.org
Cc: Joel Fernandes <joel@joelfernandes.org>
---
Since v4:
- Use 'guard(preempt_notrace)'.
- Add brackets to multiline 'if' statements.
---
 include/trace/events/syscalls.h |  4 +--
 kernel/trace/trace_syscalls.c   | 52 ++++++++++++++++++++++++++++-----
 2 files changed, 46 insertions(+), 10 deletions(-)

diff --git a/include/trace/events/syscalls.h b/include/trace/events/syscalls.h
index b6e0cbc2c71f..dc30e3004818 100644
--- a/include/trace/events/syscalls.h
+++ b/include/trace/events/syscalls.h
@@ -15,7 +15,7 @@
 
 #ifdef CONFIG_HAVE_SYSCALL_TRACEPOINTS
 
-TRACE_EVENT_FN(sys_enter,
+TRACE_EVENT_FN_MAY_FAULT(sys_enter,
 
 	TP_PROTO(struct pt_regs *regs, long id),
 
@@ -41,7 +41,7 @@ TRACE_EVENT_FN(sys_enter,
 
 TRACE_EVENT_FLAGS(sys_enter, TRACE_EVENT_FL_CAP_ANY)
 
-TRACE_EVENT_FN(sys_exit,
+TRACE_EVENT_FN_MAY_FAULT(sys_exit,
 
 	TP_PROTO(struct pt_regs *regs, long ret),
 
diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index 9c581d6da843..314666d663b6 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -299,6 +299,12 @@ static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
 	int syscall_nr;
 	int size;
 
+	/*
+	 * Probe called with preemption enabled (may_fault), but ring buffer and
+	 * per-cpu data require preemption to be disabled.
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
+	 * Probe called with preemption enabled (may_fault), but ring buffer and
+	 * per-cpu data require preemption to be disabled.
+	 */
+	guard(preempt_notrace)();
+
 	syscall_nr = trace_get_syscall_nr(current, regs);
 	if (syscall_nr < 0 || syscall_nr >= NR_syscalls)
 		return;
@@ -376,8 +388,11 @@ static int reg_event_syscall_enter(struct trace_event_file *file,
 	if (WARN_ON_ONCE(num < 0 || num >= NR_syscalls))
 		return -ENOSYS;
 	mutex_lock(&syscall_trace_lock);
-	if (!tr->sys_refcount_enter)
-		ret = register_trace_sys_enter(ftrace_syscall_enter, tr);
+	if (!tr->sys_refcount_enter) {
+		ret = register_trace_prio_flags_sys_enter(ftrace_syscall_enter, tr,
+							  TRACEPOINT_DEFAULT_PRIO,
+							  TRACEPOINT_MAY_FAULT);
+	}
 	if (!ret) {
 		rcu_assign_pointer(tr->enter_syscall_files[num], file);
 		tr->sys_refcount_enter++;
@@ -414,8 +429,11 @@ static int reg_event_syscall_exit(struct trace_event_file *file,
 	if (WARN_ON_ONCE(num < 0 || num >= NR_syscalls))
 		return -ENOSYS;
 	mutex_lock(&syscall_trace_lock);
-	if (!tr->sys_refcount_exit)
-		ret = register_trace_sys_exit(ftrace_syscall_exit, tr);
+	if (!tr->sys_refcount_exit) {
+		ret = register_trace_prio_flags_sys_exit(ftrace_syscall_exit, tr,
+							 TRACEPOINT_DEFAULT_PRIO,
+							 TRACEPOINT_MAY_FAULT);
+	}
 	if (!ret) {
 		rcu_assign_pointer(tr->exit_syscall_files[num], file);
 		tr->sys_refcount_exit++;
@@ -582,6 +600,12 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
 	int rctx;
 	int size;
 
+	/*
+	 * Probe called with preemption enabled (may_fault), but ring buffer and
+	 * per-cpu data require preemption to be disabled.
+	 */
+	guard(preempt_notrace)();
+
 	syscall_nr = trace_get_syscall_nr(current, regs);
 	if (syscall_nr < 0 || syscall_nr >= NR_syscalls)
 		return;
@@ -630,8 +654,11 @@ static int perf_sysenter_enable(struct trace_event_call *call)
 	num = ((struct syscall_metadata *)call->data)->syscall_nr;
 
 	mutex_lock(&syscall_trace_lock);
-	if (!sys_perf_refcount_enter)
-		ret = register_trace_sys_enter(perf_syscall_enter, NULL);
+	if (!sys_perf_refcount_enter) {
+		ret = register_trace_prio_flags_sys_enter(perf_syscall_enter, NULL,
+							  TRACEPOINT_DEFAULT_PRIO,
+							  TRACEPOINT_MAY_FAULT);
+	}
 	if (ret) {
 		pr_info("event trace: Could not activate syscall entry trace point");
 	} else {
@@ -682,6 +709,12 @@ static void perf_syscall_exit(void *ignore, struct pt_regs *regs, long ret)
 	int rctx;
 	int size;
 
+	/*
+	 * Probe called with preemption enabled (may_fault), but ring buffer and
+	 * per-cpu data require preemption to be disabled.
+	 */
+	guard(preempt_notrace)();
+
 	syscall_nr = trace_get_syscall_nr(current, regs);
 	if (syscall_nr < 0 || syscall_nr >= NR_syscalls)
 		return;
@@ -727,8 +760,11 @@ static int perf_sysexit_enable(struct trace_event_call *call)
 	num = ((struct syscall_metadata *)call->data)->syscall_nr;
 
 	mutex_lock(&syscall_trace_lock);
-	if (!sys_perf_refcount_exit)
-		ret = register_trace_sys_exit(perf_syscall_exit, NULL);
+	if (!sys_perf_refcount_exit) {
+		ret = register_trace_prio_flags_sys_exit(perf_syscall_exit, NULL,
+							 TRACEPOINT_DEFAULT_PRIO,
+							 TRACEPOINT_MAY_FAULT);
+	}
 	if (ret) {
 		pr_info("event trace: Could not activate syscall exit trace point");
 	} else {
-- 
2.39.2


