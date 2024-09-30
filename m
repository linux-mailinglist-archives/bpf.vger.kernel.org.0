Return-Path: <bpf+bounces-40599-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D16FA98ACDC
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 21:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0911D1C210B1
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 19:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E7619C568;
	Mon, 30 Sep 2024 19:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="LWz5TE/u"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFC919A281;
	Mon, 30 Sep 2024 19:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727724396; cv=none; b=EiSds36MVR3/yuwBHzKXPqzRxypRjvuKWY7jkalurM0eeSB96+WBW9PqQHQHvSY88vviZCYe79hagJvzwvg1ylRIEO+2QfyUwFZb4LPYc6JI8D4+UbfPYGv6OhbeQWh3ILfPwCbvoS/j5JAfhjiB6jzsmC2Eb4Mn6eiZHhRwIWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727724396; c=relaxed/simple;
	bh=jzrIYZ+NCfJJx2hpaA2hpfIcWE+lBCRlUE3pqnCzPys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oLK6nvZfhK1hWMF2Ykh06dxCu9BJaU5UsoPwSkHqWQxPmObJa67iBtb/LTqpMpXMDylnIEOMJ5wXwi5fH2NW+2efAVWV+khXXo8cl3oykFBNILIdVz1Kdk9zIyq1pDBehOVaHvwn8aEn67SPXtQNLtLtCW5TEszqql5SfrmZmJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=LWz5TE/u; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1727724392;
	bh=jzrIYZ+NCfJJx2hpaA2hpfIcWE+lBCRlUE3pqnCzPys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LWz5TE/uu1joLZFDkBoIS/ae2dUCXUzkKUPIX8yb4SwVsNnHJ2auB+5CLun7Ys3sl
	 XV8MzJhRMar1LDpt8HCrnmZOnxCbzuayb8cE0JStneltc4I+3SQxb25g3dKEvi6nED
	 uELjXD5DjrzLNYBi7BKkgQLa4bjMw/EdmTRW65IVvwHUTTMH2XapDIiUiemP9iVTiC
	 EYPO1+8ERzz3ES1pcUoryYO1h7WlnDOryJM7iOIeJK4O+TSqgMtuxetxlSgZE5m8MZ
	 MbTsPGTHvTs3ERDhC3dYsytqtkE6KQJ8waTQYoA4YnF5WrxleHJIR0wjoNSNTzh5Mb
	 oJiAXgdN+4cIA==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XHWK44Wv4zQgH;
	Mon, 30 Sep 2024 15:26:32 -0400 (EDT)
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
Subject: [PATCH resend 6/8] tracing/ftrace: Add might_fault check to syscall probes
Date: Mon, 30 Sep 2024 15:23:55 -0400
Message-Id: <20240930192357.1154417-7-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240930192357.1154417-1-mathieu.desnoyers@efficios.com>
References: <20240930192357.1154417-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a might_fault() check to validate that the ftrace sys_enter/sys_exit
probe callbacks are indeed called from a context where page faults can
be handled.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
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
 include/trace/trace_events.h  | 1 +
 kernel/trace/trace_syscalls.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index 0228d9ed94a3..e0d4850b0d77 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -446,6 +446,7 @@ __DECLARE_EVENT_CLASS(call, PARAMS(proto), PARAMS(args), PARAMS(tstruct), \
 static notrace void							\
 trace_event_raw_event_##call(void *__data, proto)			\
 {									\
+	might_fault();							\
 	guard(preempt_notrace)();					\
 	do_trace_event_raw_event_##call(__data, args);			\
 }
diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index a3d8ac00793e..0430890cbb42 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -303,6 +303,7 @@ static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
 	 * Syscall probe called with preemption enabled, but the ring
 	 * buffer and per-cpu data require preemption to be disabled.
 	 */
+	might_fault();
 	guard(preempt_notrace)();
 
 	syscall_nr = trace_get_syscall_nr(current, regs);
@@ -348,6 +349,7 @@ static void ftrace_syscall_exit(void *data, struct pt_regs *regs, long ret)
 	 * Syscall probe called with preemption enabled, but the ring
 	 * buffer and per-cpu data require preemption to be disabled.
 	 */
+	might_fault();
 	guard(preempt_notrace)();
 
 	syscall_nr = trace_get_syscall_nr(current, regs);
-- 
2.39.2


