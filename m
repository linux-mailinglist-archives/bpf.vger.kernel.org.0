Return-Path: <bpf+bounces-45556-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 631C59D7939
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 00:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29171282736
	for <lists+bpf@lfdr.de>; Sun, 24 Nov 2024 23:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB7018E743;
	Sun, 24 Nov 2024 23:49:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F58418C031;
	Sun, 24 Nov 2024 23:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732492173; cv=none; b=qwem52Jl8M/MpBxNagThwKNa76zmNZdFfLjq8/uRNaJ6c13bE4CyOBtbms+Cjg1LGXki7LifzrOIipdj8jI48GiVmTz0joiPvvjSwVCeEY2mlaYNdemxOfdUB/nOeBUsRlzQmuj9TchhkM8koyzinmgNGUKH+obCW/7i/eyVPKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732492173; c=relaxed/simple;
	bh=BlBwOL/w3gx0AUldIPoarft+PBQzsa3kJ+PTEt5vlKs=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=OJy0JfOW37emKdp6FUBhcrP669S2z7NVCiUGz4rI5TsTv/Y97nDYTkMteXqLxejopv4YpYS15O2BdPeNkzk/s8nrtt7aphIHqvtSJ4Dv8/qeiKhg1O1QzjGdiHUUCCxCDDLzUBiv8L3hObzpP1pxhsYVNqrh6ga0mSCqggGDm/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF72C4CED9;
	Sun, 24 Nov 2024 23:49:33 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tFMMt-00000006vlc-2UW9;
	Sun, 24 Nov 2024 18:50:19 -0500
Message-ID: <20241124235019.444613315@goodmis.org>
User-Agent: quilt/0.68
Date: Sun, 24 Nov 2024 18:49:46 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
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
 Joel Fernandes <joel@joelfernandes.org>,
 Jordan Rife <jrife@google.com>,
 linux-trace-kernel@vger.kernel.org
Subject: [for-next][PATCH 6/6] tracing: Remove cond argument from __DECLARE_TRACE_SYSCALL
References: <20241124234940.017394686@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Syscall tracepoints do not require a "cond" argument, because they are
meant to be used only for sys_enter and sys_exit instrumentation, which
don't require condition evaluation.

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
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
Cc: Jordan Rife <jrife@google.com>
Cc: linux-trace-kernel@vger.kernel.org
Link: https://lore.kernel.org/20241123153031.2884933-6-mathieu.desnoyers@efficios.com
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/tracepoint.h | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 832f49b56b1f..b2633a72e871 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -220,7 +220,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
  * site if it is not watching, as it will need to be active when the
  * tracepoint is enabled.
  */
-#define __DECLARE_TRACE_COMMON(name, proto, args, cond, data_proto)	\
+#define __DECLARE_TRACE_COMMON(name, proto, args, data_proto)		\
 	extern int __traceiter_##name(data_proto);			\
 	DECLARE_STATIC_CALL(tp_func_##name, __traceiter_##name);	\
 	extern struct tracepoint __tracepoint_##name;			\
@@ -254,7 +254,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 	}
 
 #define __DECLARE_TRACE(name, proto, args, cond, data_proto)		\
-	__DECLARE_TRACE_COMMON(name, PARAMS(proto), PARAMS(args), cond, PARAMS(data_proto)) \
+	__DECLARE_TRACE_COMMON(name, PARAMS(proto), PARAMS(args), PARAMS(data_proto)) \
 	static inline void trace_##name(proto)				\
 	{								\
 		if (static_branch_unlikely(&__tracepoint_##name.key)) { \
@@ -269,18 +269,16 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 		}							\
 	}
 
-#define __DECLARE_TRACE_SYSCALL(name, proto, args, cond, data_proto)	\
-	__DECLARE_TRACE_COMMON(name, PARAMS(proto), PARAMS(args), cond, PARAMS(data_proto)) \
+#define __DECLARE_TRACE_SYSCALL(name, proto, args, data_proto)		\
+	__DECLARE_TRACE_COMMON(name, PARAMS(proto), PARAMS(args), PARAMS(data_proto)) \
 	static inline void trace_##name(proto)				\
 	{								\
 		might_fault();						\
 		if (static_branch_unlikely(&__tracepoint_##name.key)) {	\
-			if (cond) {					\
-				scoped_guard(rcu_tasks_trace)		\
-					__DO_TRACE_CALL(name, TP_ARGS(args)); \
-			}						\
+			scoped_guard(rcu_tasks_trace)			\
+				__DO_TRACE_CALL(name, TP_ARGS(args));	\
 		}							\
-		if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {		\
+		if (IS_ENABLED(CONFIG_LOCKDEP)) {			\
 			WARN_ONCE(!rcu_is_watching(),			\
 				  "RCU not watching for tracepoint");	\
 		}							\
@@ -363,7 +361,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 
 
 #else /* !TRACEPOINTS_ENABLED */
-#define __DECLARE_TRACE(name, proto, args, cond, data_proto)		\
+#define __DECLARE_TRACE_COMMON(name, proto, args, data_proto)		\
 	static inline void trace_##name(proto)				\
 	{ }								\
 	static inline int						\
@@ -387,7 +385,11 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 		return false;						\
 	}
 
-#define __DECLARE_TRACE_SYSCALL	__DECLARE_TRACE
+#define __DECLARE_TRACE(name, proto, args, cond, data_proto)		\
+	__DECLARE_TRACE_COMMON(name, PARAMS(proto), PARAMS(args), PARAMS(data_proto))
+
+#define __DECLARE_TRACE_SYSCALL(name, proto, args, data_proto)		\
+	__DECLARE_TRACE_COMMON(name, PARAMS(proto), PARAMS(args), PARAMS(data_proto))
 
 #define DEFINE_TRACE_FN(name, reg, unreg, proto, args)
 #define DEFINE_TRACE_SYSCALL(name, reg, unreg, proto, args)
@@ -453,7 +455,6 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 
 #define DECLARE_TRACE_SYSCALL(name, proto, args)			\
 	__DECLARE_TRACE_SYSCALL(name, PARAMS(proto), PARAMS(args),	\
-				cpu_online(raw_smp_processor_id()),	\
 				PARAMS(void *__data, proto))
 
 #define TRACE_EVENT_FLAGS(event, flag)
-- 
2.45.2



