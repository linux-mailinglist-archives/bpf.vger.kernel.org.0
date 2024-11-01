Return-Path: <bpf+bounces-43718-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F75F9B8F61
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 11:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3AC41F2303D
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 10:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8681AA786;
	Fri,  1 Nov 2024 10:36:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655221A725A;
	Fri,  1 Nov 2024 10:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730457370; cv=none; b=oMEAmZDWTACRRO4uOWSALnjIHQJvHrDVKZainEW8FONMseTzv6CYcBBVhZHSgYsYSqYTy6/NLJX89B13VkZBjfqjWOrwvhtuCSYE8/HvRcAml5jDRluOA8FeAhxxibR3MmQgQonEM499L4pc548r+32ydOZ6oIaHXGyvQPWBuEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730457370; c=relaxed/simple;
	bh=ujP8lD5I+crem6/NpkOWLrztI+nFB968C4oWwq+i+0o=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=HDQqDf0RGC03L3luiSAln2jeJKDVjQ9SwyqpBF348gCGFdkLwm0PRK1RZK3exFIFvXVdnQI+IGSPLyiyApkrsUsellhJXxOtCA+FqChxi3ZTAH5YrLTwVqBtVhzFaSLovCeFkEpurqXyd/dDDajBeRxmVMFdykzh6Wszpgw1WZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0B55C4CEF9;
	Fri,  1 Nov 2024 10:36:09 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1t6p1g-00000005S81-0yeL;
	Fri, 01 Nov 2024 06:37:08 -0400
Message-ID: <20241101103708.089444209@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 01 Nov 2024 06:36:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Andrii Nakryiko <andrii@kernel.org>,
 Jordan Rife <jrife@google.com>,
 Michael Jeanson <mjeanson@efficios.com>,
 Thomas Gleixner <tglx@linutronix.de>,
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
 linux-trace-kernel@vger.kernel.org
Subject: [for-next][PATCH 08/11] tracing: Introduce tracepoint_is_faultable()
References: <20241101103647.011707614@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Introduce a "faultable" flag within the extended structure to know
whether a tracepoint needs rcu tasks trace grace period before reclaim.
This can be queried using tracepoint_is_faultable().

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Tested-by: Jordan Rife <jrife@google.com>
Cc: Michael Jeanson <mjeanson@efficios.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
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
Link: https://lore.kernel.org/20241031152056.744137-3-mathieu.desnoyers@efficios.com
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/tracepoint-defs.h |  2 ++
 include/linux/tracepoint.h      | 24 ++++++++++++++++++++++++
 include/trace/define_trace.h    |  2 +-
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/include/linux/tracepoint-defs.h b/include/linux/tracepoint-defs.h
index 967c08d9da84..aebf0571c736 100644
--- a/include/linux/tracepoint-defs.h
+++ b/include/linux/tracepoint-defs.h
@@ -32,6 +32,8 @@ struct tracepoint_func {
 struct tracepoint_ext {
 	int (*regfunc)(void);
 	void (*unregfunc)(void);
+	/* Flags. */
+	unsigned int faultable:1;
 };
 
 struct tracepoint {
diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 862ab49177a4..906f3091d23d 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -104,6 +104,12 @@ void for_each_tracepoint_in_module(struct module *mod,
  * tracepoint_synchronize_unregister must be called between the last tracepoint
  * probe unregistration and the end of module exit to make sure there is no
  * caller executing a probe when it is freed.
+ *
+ * An alternative is to use the following for batch reclaim associated
+ * with a given tracepoint:
+ *
+ * - tracepoint_is_faultable() == false: call_rcu()
+ * - tracepoint_is_faultable() == true:  call_rcu_tasks_trace()
  */
 #ifdef CONFIG_TRACEPOINTS
 static inline void tracepoint_synchronize_unregister(void)
@@ -111,9 +117,17 @@ static inline void tracepoint_synchronize_unregister(void)
 	synchronize_rcu_tasks_trace();
 	synchronize_rcu();
 }
+static inline bool tracepoint_is_faultable(struct tracepoint *tp)
+{
+	return tp->ext && tp->ext->faultable;
+}
 #else
 static inline void tracepoint_synchronize_unregister(void)
 { }
+static inline bool tracepoint_is_faultable(struct tracepoint *tp)
+{
+	return false;
+}
 #endif
 
 #ifdef CONFIG_HAVE_SYSCALL_TRACEPOINTS
@@ -345,6 +359,15 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 	static struct tracepoint_ext __tracepoint_ext_##_name = {	\
 		.regfunc = _reg,					\
 		.unregfunc = _unreg,					\
+		.faultable = false,					\
+	};								\
+	__DEFINE_TRACE_EXT(_name, &__tracepoint_ext_##_name, PARAMS(_proto), PARAMS(_args));
+
+#define DEFINE_TRACE_SYSCALL(_name, _reg, _unreg, _proto, _args)	\
+	static struct tracepoint_ext __tracepoint_ext_##_name = {	\
+		.regfunc = _reg,					\
+		.unregfunc = _unreg,					\
+		.faultable = true,					\
 	};								\
 	__DEFINE_TRACE_EXT(_name, &__tracepoint_ext_##_name, PARAMS(_proto), PARAMS(_args));
 
@@ -389,6 +412,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 #define __DECLARE_TRACE_SYSCALL	__DECLARE_TRACE
 
 #define DEFINE_TRACE_FN(name, reg, unreg, proto, args)
+#define DEFINE_TRACE_SYSCALL(name, reg, unreg, proto, args)
 #define DEFINE_TRACE(name, proto, args)
 #define EXPORT_TRACEPOINT_SYMBOL_GPL(name)
 #define EXPORT_TRACEPOINT_SYMBOL(name)
diff --git a/include/trace/define_trace.h b/include/trace/define_trace.h
index ff5fa17a6259..63fea2218afa 100644
--- a/include/trace/define_trace.h
+++ b/include/trace/define_trace.h
@@ -48,7 +48,7 @@
 
 #undef TRACE_EVENT_SYSCALL
 #define TRACE_EVENT_SYSCALL(name, proto, args, struct, assign, print, reg, unreg) \
-	DEFINE_TRACE_FN(name, reg, unreg, PARAMS(proto), PARAMS(args))
+	DEFINE_TRACE_SYSCALL(name, reg, unreg, PARAMS(proto), PARAMS(args))
 
 #undef TRACE_EVENT_NOP
 #define TRACE_EVENT_NOP(name, proto, args, struct, assign, print)
-- 
2.45.2



