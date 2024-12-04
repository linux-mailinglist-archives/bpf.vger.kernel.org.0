Return-Path: <bpf+bounces-46090-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 150439E4107
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 18:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B15201660A8
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 17:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE442144CB;
	Wed,  4 Dec 2024 17:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rKyF9JyN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C299B2144B7;
	Wed,  4 Dec 2024 17:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733331686; cv=none; b=QWNuRMAtrC6shHQ7ADk5k03oxNF7RkDzEp+MCRmYjiYSI5SoW5BWDw0U+/pdWivJ9WBewscMa+Q3co7nry0bwIC3ihM76wePLZhvDvIXdUccLfm91loQGbkvUeBvS+dCP606XAM3/3bXpI50NcXmaK/JCZGPjDGcW8DQRHFK5F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733331686; c=relaxed/simple;
	bh=sqBdNa8t5nLUyQ3KChbLy9m2qJB438JQ/Fx3k/AoHU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LIbrHq2fBDWPiogA4hqU9OlNj4HSaLe3uod3kggEt8WDQYmCLL4+iu7DFg4RJlXg9+AT5yLRL667lx3JvVF1Fs7KbXWsWi4YK9c3w2EJhm8r57t6dpABpiWL2QqxeAUaEACRy0g5CD6/VZyDSgQiwpcSDnqeQSHwG/EZQ/fxRV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rKyF9JyN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 901FBC4CEDF;
	Wed,  4 Dec 2024 17:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733331686;
	bh=sqBdNa8t5nLUyQ3KChbLy9m2qJB438JQ/Fx3k/AoHU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rKyF9JyNp6R9gh/p56GPXopNoJb/XHnUIn5smQ6zjsv/H5oSB1d169XfCsfbL3Nkw
	 OyXZTvUa3clfIuI/crbGTF4GFzCQVh5i+15ZR3CEgd2kcEQ73pKMb3ieuuSU/XDMXf
	 bfu4dsgx4+bu7SEVwJLbCanB9aUlPRWYmqGKeX6Hv6rqy5626dHotUDlwgfilQGM0Z
	 lNjHjHWNi75mjO7EWgWVU5CvGPRUeDfsC8g26X1F52lXgPzQqSn+FAYTzLojEHT4Dj
	 JBX7qFrCflBrCWDgvN8zQCjmJV47pSIPaVyJ1K7WJqOj+fQWfI/gFu3mL0Y7/2i9+C
	 TqSFlOwS3Sjhg==
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
Subject: [PATCH AUTOSEL 6.6 02/24] tracing/ftrace: disable preemption in syscall probe
Date: Wed,  4 Dec 2024 10:49:22 -0500
Message-ID: <20241204155003.2213733-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204155003.2213733-1-sashal@kernel.org>
References: <20241204155003.2213733-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
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
index de753403cdafb..9508d9022940f 100644
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


