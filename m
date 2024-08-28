Return-Path: <bpf+bounces-38287-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 834FD962A93
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 16:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 890A91C20D69
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 14:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE041A38D7;
	Wed, 28 Aug 2024 14:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="qlqYUGFc"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643CB1A2548;
	Wed, 28 Aug 2024 14:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724856154; cv=none; b=NqnGdm5bGgl24Ag02nVkpKpt3P/4X1CaPhBoUyJygraSw0hsPTx18zi3Xa/OBJr86vtqcu2ujdLZ64gh1P1oRBUNB8cky4fuxME8dwEpfPJk3hSrN0QkMKQC7pApGZH4AgVAd5bfIso+yn/XiL0LioG6+Cv0jleCDrA75v2bDcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724856154; c=relaxed/simple;
	bh=cQBpL+pu8rPQAQ6DXfp1ZyC9FAqqvXyCZd6oDYKg2MM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CtGezAW6nrD9Y+uIgDh9iBk0+dLy2KJNHYIyXUtQMvJqgtpOqP18USP6Zq6DSifc2KMS2xnhY/8TNJ/I9s74Z4MAarHFsQf4UNkjmMRFA67LKSCtz78h6NF0hUWkPc1Wr6NARmSaH2G5mrTnbh+dz5oopWrzNxq4xvbah4l91q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=qlqYUGFc; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1724856150;
	bh=cQBpL+pu8rPQAQ6DXfp1ZyC9FAqqvXyCZd6oDYKg2MM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qlqYUGFcp8QcHwKPnmP+i2C8vgLZ/61hFePQTq4/8i2knKK+zYXO7GuY+rk4qRlt/
	 38ycS64IYYRRWyDxLma8PsiXNbPDYMlbkK3Lhy90m32WcEvKQTFEKZZQAOd6NcKkPU
	 xRX3OmhLU0lXIr+DgOsObVZXADXohW9CTkY7AxZHMePAyi/QkMxOv5gm8RMuqpKoOc
	 4JWeZU7nt2xIRM8IjddaCmEDwsdpZONeG0yVlVJcp3XFwZkCTMUx8Ysy0AO4LQayk/
	 zMLNfYmV82oiOS2BDi+cAWjczjrrBBZ/1B4op3bxiDzC+9hQWEhiwc8zx2Kgjx5PsK
	 DHgG7E+7hT2Gg==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Wv6ZY61dHz1JFV;
	Wed, 28 Aug 2024 10:42:29 -0400 (EDT)
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
Subject: [PATCH v6 5/5] tracing: Convert sys_enter/exit to faultable tracepoints
Date: Wed, 28 Aug 2024 10:41:52 -0400
Message-Id: <20240828144153.829582-6-mathieu.desnoyers@efficios.com>
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

Convert the definition of the system call enter/exit tracepoints to
faultable tracepoints now that all upstream tracers handle it.

This allows tracers to fault-in userspace system call arguments such as
path strings within their probe callbacks.

Link: https://lore.kernel.org/lkml/20231002202531.3160-1-mathieu.desnoyers@efficios.com/
Co-developed-by: Michael Jeanson <mjeanson@efficios.com>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
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


