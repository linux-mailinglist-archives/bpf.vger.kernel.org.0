Return-Path: <bpf+bounces-46087-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E18699E409B
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 18:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81D0F280FC5
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 17:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192C920D507;
	Wed,  4 Dec 2024 16:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pn3pyqC3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F68420E31E;
	Wed,  4 Dec 2024 16:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733331584; cv=none; b=CVB6pysYrmlcrS04CVk8NG0JwR4mdRthuUS5/Hn0slTbmK2+/5y1HomzkxCsBLPAYmfJq2rPHr/jZEIXnj2hqsB4Hozs/5VHXJgFhH/BHHYpnxfrIdIfFv72jGqcNyTSEuvPi1Mc380lQeLnDBQREwUlJRd5gMPbtJQaG3PNwVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733331584; c=relaxed/simple;
	bh=xA4hv32S/aRiQr/YRkoltWGnKXMJn6y03OnFDfjppRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ED6qcdVUqnCl5JVPYT6XZ77Im5/WJFzZNwzStILH4B7b6hU240YRYsWqg269xFOqtx7WGYGGackXHqohhagUvVTNCgkFLhBrNs0biPALx9iOO2ngNDVmNfXnTc4AhGjkGFXGV/SxSGIkF4F/VdqqLKWs43JXhFmq3vqBeSsTjio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pn3pyqC3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5553CC4CECD;
	Wed,  4 Dec 2024 16:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733331584;
	bh=xA4hv32S/aRiQr/YRkoltWGnKXMJn6y03OnFDfjppRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pn3pyqC3axWOuN1Z9MbGrVkX2675wfylIGH2zMgSzC9iDCGrCkT130MLLwbxKsgL9
	 AL+Cucge21TDXFG9Be00ff7hkYgQRJPRU9FqxGF3uiev3VQB/1KyfmsrjeXpjxv2W+
	 8mJBF9tsxtr8iboqnLb4vB5qh9ch4HPmC7vopr2MPn138eKOzlwWH0/ZOYblBiVhMs
	 0LUgWGnrtfzIrvoAUCmxKNQA0cbZpm8RmIQUIk/sVLP8rDG+w9NJoFAmfqNFG07oUJ
	 mU4fpU2zhRtDhMyHvZXqwEKAbGyMd+n6FHpnvuqXbbY5d3TvoCrJvqv1OfqaMnkwL9
	 Guxd2RyIy4jaQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Michael Jeanson <mjeanson@efficios.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
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
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 03/33] tracing/ftrace: disable preemption in syscall probe
Date: Wed,  4 Dec 2024 10:47:16 -0500
Message-ID: <20241204154817.2212455-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204154817.2212455-1-sashal@kernel.org>
References: <20241204154817.2212455-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
Content-Transfer-Encoding: 8bit

From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

[ Upstream commit 13d750c2c03e9861e15268574ed2c239cca9c9d5 ]

In preparation for allowing system call enter/exit instrumentation to
handle page faults, make sure that ftrace can handle this change by
explicitly disabling preemption within the ftrace system call tracepoint
probes to respect the current expectations within ftrace ring buffer
code.

This change does not yet allow ftrace to take page faults per se within
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
Link: https://lore.kernel.org/20241009010718.2050182-3-mathieu.desnoyers@efficios.com
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/trace/trace_events.h  | 36 +++++++++++++++++++++++++++++++----
 kernel/trace/trace_syscalls.c | 12 ++++++++++++
 2 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index c2f9cabf154d1..fa0d51cad57a8 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -244,6 +244,9 @@ static struct trace_event_fields trace_event_fields_##call[] = {	\
 	tstruct								\
 	{} };
 
+#undef DECLARE_EVENT_SYSCALL_CLASS
+#define DECLARE_EVENT_SYSCALL_CLASS DECLARE_EVENT_CLASS
+
 #undef DEFINE_EVENT_PRINT
 #define DEFINE_EVENT_PRINT(template, name, proto, args, print)
 
@@ -374,11 +377,11 @@ static inline notrace int trace_event_get_offsets_##call(		\
 
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
@@ -403,6 +406,29 @@ trace_event_raw_event_##call(void *__data, proto)			\
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
+	preempt_disable_notrace();					\
+	do_trace_event_raw_event_##call(__data, args);			\
+	preempt_enable_notrace();					\
+}
+
 /*
  * The ftrace_test_probe is compiled out, it is only here as a build time check
  * to make sure that if the tracepoint handling changes, the ftrace probe will
@@ -418,6 +444,8 @@ static inline void ftrace_test_probe_##call(void)			\
 
 #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
 
+#undef __DECLARE_EVENT_CLASS
+
 #include "stages/stage7_class_define.h"
 
 #undef DECLARE_EVENT_CLASS
diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index 9c581d6da843a..f76efcb6336aa 100644
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
2.43.0


