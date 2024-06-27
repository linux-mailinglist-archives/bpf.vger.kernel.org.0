Return-Path: <bpf+bounces-33265-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC8391AB1C
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 17:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 135CB287943
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 15:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13C0199385;
	Thu, 27 Jun 2024 15:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="AHE8/1jC"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD76198E96;
	Thu, 27 Jun 2024 15:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719501794; cv=none; b=Kkz6n6yRWR0xUZopHcoknnK4KwGGaXWpBJFLS31Tb+OuPBj2USSOOb5ie2we7EVlLsOGkeWc8ODt5hBxyGsNnYqgcsLYUOAQvjpnWLIovP3SUe05nilzCiKBdWwe9n2u7IBhhk9h+rzXZFgX7AQqN6k0qH4yKTgiVreraOjCrvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719501794; c=relaxed/simple;
	bh=Ii+cxjz0MLUIaEg5tcYbEKz1AeI5UWrbwUMe27azAqI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kqe/xkHr9aXKBQPHIedckraTEAVHHeD3tadg882XmGoi3XbAUDV1CZa+NuaF9qL0WZj6+KbPp9WSO4Wgx/q6AkeVvdP0GeiSD3aVhaa90IZOGZ6S/bv0gkmV8ghCTtQzO65E9WN20mwI1IeQ4R0njMq4S1ylvV2GcCst098zQb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=AHE8/1jC; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1719501790;
	bh=Ii+cxjz0MLUIaEg5tcYbEKz1AeI5UWrbwUMe27azAqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AHE8/1jCzBX/zcC/WTATZx87w4d2KYhk0D6hXpzkWDJW2Ioa8dTzc0Zy9PaO6hzpT
	 3RpCXw6/s8Ux0qbErahEIlIwO+6NR+t0+Q2QuvduOyhp6OBdBPWOkuGZ2sLIJay6xR
	 oqANUa09gBULBLWTi0Lwncbk28/bGExSoCQtHk4MuWmas8GGOw5UDgLyKN1G/kO2Pj
	 1Pt2Bu1Il/sECk2fCdEveBM0OPEU+ioWD7JqIaBnE3JKpGtmo3PIUshSlesgQJQySj
	 gHY6M3n7AxUx3Ugq2+/xhnpd5ia3qYUYiFNx8wU7TjUdhGuc1VFMG4I9GXno2k5s1f
	 hACtg6uRkofjw==
Received: from thinkos.internal.efficios.com (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4W92Q61sZNz183P;
	Thu, 27 Jun 2024 11:23:10 -0400 (EDT)
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
Subject: [PATCH v5 6/8] tracing/bpf-trace: Add support for faultable tracepoints
Date: Thu, 27 Jun 2024 11:23:38 -0400
Message-Id: <20240627152340.82413-7-mathieu.desnoyers@efficios.com>
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

In preparation for converting system call enter/exit instrumentation
into faultable tracepoints, make sure that bpf can handle registering to
such tracepoints by explicitly disabling preemption within the bpf
tracepoint probes to respect the current expectations within bpf tracing
code.

This change does not yet allow bpf to take page faults per se within its
probe, but allows its existing probes to connect to faultable
tracepoints.

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
Changes since v4:
- Use DEFINE_INACTIVE_GUARD.
- Add brackets to multiline 'if' statements.
---
 include/trace/bpf_probe.h | 20 ++++++++++++++++----
 kernel/trace/bpf_trace.c  | 12 +++++++++---
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
index e609cd7da47e..96c1269dd88c 100644
--- a/include/trace/bpf_probe.h
+++ b/include/trace/bpf_probe.h
@@ -42,17 +42,29 @@
 /* tracepoints with more than 12 arguments will hit build error */
 #define CAST_TO_U64(...) CONCATENATE(__CAST, COUNT_ARGS(__VA_ARGS__))(__VA_ARGS__)
 
-#define __BPF_DECLARE_TRACE(call, proto, args)				\
+#define __BPF_DECLARE_TRACE(call, proto, args, tp_flags)		\
 static notrace void							\
 __bpf_trace_##call(void *__data, proto)					\
 {									\
 	struct bpf_prog *prog = __data;					\
+									\
+	DEFINE_INACTIVE_GUARD(preempt_notrace, bpf_trace_guard);	\
+									\
+	if ((tp_flags) & TRACEPOINT_MAY_FAULT) {			\
+		might_fault();						\
+		activate_guard(preempt_notrace, bpf_trace_guard)();	\
+	}								\
+									\
 	CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(prog, CAST_TO_U64(args));	\
 }
 
 #undef DECLARE_EVENT_CLASS
 #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
-	__BPF_DECLARE_TRACE(call, PARAMS(proto), PARAMS(args))
+	__BPF_DECLARE_TRACE(call, PARAMS(proto), PARAMS(args), 0)
+
+#undef DECLARE_EVENT_CLASS_MAY_FAULT
+#define DECLARE_EVENT_CLASS_MAY_FAULT(call, proto, args, tstruct, assign, print) \
+	__BPF_DECLARE_TRACE(call, PARAMS(proto), PARAMS(args), TRACEPOINT_MAY_FAULT)
 
 /*
  * This part is compiled out, it is only here as a build time check
@@ -106,13 +118,13 @@ static inline void bpf_test_buffer_##call(void)				\
 
 #undef DECLARE_TRACE
 #define DECLARE_TRACE(call, proto, args)				\
-	__BPF_DECLARE_TRACE(call, PARAMS(proto), PARAMS(args))		\
+	__BPF_DECLARE_TRACE(call, PARAMS(proto), PARAMS(args), 0)	\
 	__DEFINE_EVENT(call, call, PARAMS(proto), PARAMS(args), 0)
 
 #undef DECLARE_TRACE_WRITABLE
 #define DECLARE_TRACE_WRITABLE(call, proto, args, size) \
 	__CHECK_WRITABLE_BUF_SIZE(call, PARAMS(proto), PARAMS(args), size) \
-	__BPF_DECLARE_TRACE(call, PARAMS(proto), PARAMS(args)) \
+	__BPF_DECLARE_TRACE(call, PARAMS(proto), PARAMS(args), 0) \
 	__DEFINE_EVENT(call, call, PARAMS(proto), PARAMS(args), size)
 
 #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 192de33d961f..873b0e885677 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2443,9 +2443,15 @@ static int __bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *
 	if (prog->aux->max_tp_access > btp->writable_size)
 		return -EINVAL;
 
-	return tracepoint_probe_register_prio_flags(tp, (void *)btp->bpf_func,
-						    prog, TRACEPOINT_DEFAULT_PRIO,
-						    TRACEPOINT_MAY_EXIST);
+	if (tp->flags & TRACEPOINT_MAY_FAULT) {
+		return tracepoint_probe_register_prio_flags(tp, (void *)btp->bpf_func,
+							    prog, TRACEPOINT_DEFAULT_PRIO,
+							    TRACEPOINT_MAY_EXIST | TRACEPOINT_MAY_FAULT);
+	} else {
+		return tracepoint_probe_register_prio_flags(tp, (void *)btp->bpf_func,
+							    prog, TRACEPOINT_DEFAULT_PRIO,
+							    TRACEPOINT_MAY_EXIST);
+	}
 }
 
 int bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *prog)
-- 
2.39.2


