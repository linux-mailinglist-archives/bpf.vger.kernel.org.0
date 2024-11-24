Return-Path: <bpf+bounces-45555-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F429D7937
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 00:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BBD4B233EF
	for <lists+bpf@lfdr.de>; Sun, 24 Nov 2024 23:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDB618C93C;
	Sun, 24 Nov 2024 23:49:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D46188704;
	Sun, 24 Nov 2024 23:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732492173; cv=none; b=ASuxBGO2IjJwIhEVZyiL1akUrn9cu5Up4RQ17W0PUMNnt8CFgMrPubQWTDV2L7JphlEHhoQZZPUC+AdldaPczXnmxAbHJ7JQs6NNPLSdctL4P6qzfoSF9pOdgCKMtezKMY1isnruIVcYOb6+mywCXwbfp84AS64lmLMpmSa3hxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732492173; c=relaxed/simple;
	bh=rVl59srqCL8+wmOTj6ciPu2sqqN4TSM7onriJ55rBgQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=JLkViFRmv35d/bNS1v6AqAZOkodVetuzlh1MFHMoRnm204+kX5MLYHKDLcYobnh7rCigb+k9LtHkd6RIBBGsqnhp6eLuzHeP7+YTvYv7G5BUfwbn3x9cBhV+fQrUDWcenOcZsKQAp9wU/IDoc7kOMgBYRQbNrm022ZNmq+mJO74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FA1CC4CECC;
	Sun, 24 Nov 2024 23:49:33 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tFMMt-00000006vl8-1mBI;
	Sun, 24 Nov 2024 18:50:19 -0500
Message-ID: <20241124235019.274562787@goodmis.org>
User-Agent: quilt/0.68
Date: Sun, 24 Nov 2024 18:49:45 -0500
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
Subject: [for-next][PATCH 5/6] tracing: Remove conditional locking from __DO_TRACE()
References: <20241124234940.017394686@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Remove conditional locking by moving the __DO_TRACE() code into
trace_##name().

When the faultable syscall tracepoints were implemented, __DO_TRACE()
had a rcuidle argument which selected between SRCU and preempt disable.
Therefore, the RCU tasks trace protection for faultable syscall
tracepoints was introduced using the same pattern.

At that point, it did not appear obvious that this feedback from Linus [1]
applied here as well, because the __DO_TRACE() modification was
extending a pre-existing pattern.

Shortly before pulling the faultable syscall tracepoints modifications,
Steven removed the rcuidle argument and SRCU protection scheme entirely
from tracepoint.h:

commit 48bcda684823 ("tracing: Remove definition of trace_*_rcuidle()")

This required a rebase of the faultable syscall tracepoints series,
which missed a perfect opportunity to integrate the prior recommendation
from Linus.

In response to the pull request, Linus pointed out [2] that he was not
pleased by the implementation, expecting this to be fixed in a follow up
patch series.

Move __DO_TRACE() code into trace_##name() within each of
__DECLARE_TRACE() and __DECLARE_TRACE_SYSCALL(). Use a scoped guard
to guard the preempt disable notrace and RCU tasks trace critical
sections.

Link: https://lore.kernel.org/all/CAHk-=wggDLDeTKbhb5hh--x=-DQd69v41137M72m6NOTmbD-cw@mail.gmail.com/ [1]
Link: https://lore.kernel.org/lkml/CAHk-=witPrLcu22dZ93VCyRQonS7+-dFYhQbna=KBa-TAhayMw@mail.gmail.com/ [2]

Fixes: a363d27cdbc2 ("tracing: Allow system call tracepoints to handle page faults")
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
Link: https://lore.kernel.org/20241123153031.2884933-5-mathieu.desnoyers@efficios.com
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/tracepoint.h | 45 ++++++++++----------------------------
 1 file changed, 12 insertions(+), 33 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 867f3c1ac7dc..832f49b56b1f 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -209,31 +209,6 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 #define __DO_TRACE_CALL(name, args)	__traceiter_##name(NULL, args)
 #endif /* CONFIG_HAVE_STATIC_CALL */
 
-/*
- * With @syscall=0, the tracepoint callback array dereference is
- * protected by disabling preemption.
- * With @syscall=1, the tracepoint callback array dereference is
- * protected by Tasks Trace RCU, which allows probes to handle page
- * faults.
- */
-#define __DO_TRACE(name, args, cond, syscall)				\
-	do {								\
-		if (!(cond))						\
-			return;						\
-									\
-		if (syscall)						\
-			rcu_read_lock_trace();				\
-		else							\
-			preempt_disable_notrace();			\
-									\
-		__DO_TRACE_CALL(name, TP_ARGS(args));			\
-									\
-		if (syscall)						\
-			rcu_read_unlock_trace();			\
-		else							\
-			preempt_enable_notrace();			\
-	} while (0)
-
 /*
  * Make sure the alignment of the structure in the __tracepoints section will
  * not add unwanted padding between the beginning of the section and the
@@ -282,10 +257,12 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 	__DECLARE_TRACE_COMMON(name, PARAMS(proto), PARAMS(args), cond, PARAMS(data_proto)) \
 	static inline void trace_##name(proto)				\
 	{								\
-		if (static_branch_unlikely(&__tracepoint_##name.key))	\
-			__DO_TRACE(name,				\
-				TP_ARGS(args),				\
-				TP_CONDITION(cond), 0);			\
+		if (static_branch_unlikely(&__tracepoint_##name.key)) { \
+			if (cond) {					\
+				scoped_guard(preempt_notrace)		\
+					__DO_TRACE_CALL(name, TP_ARGS(args)); \
+			}						\
+		}							\
 		if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {		\
 			WARN_ONCE(!rcu_is_watching(),			\
 				  "RCU not watching for tracepoint");	\
@@ -297,10 +274,12 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 	static inline void trace_##name(proto)				\
 	{								\
 		might_fault();						\
-		if (static_branch_unlikely(&__tracepoint_##name.key))	\
-			__DO_TRACE(name,				\
-				TP_ARGS(args),				\
-				TP_CONDITION(cond), 1);			\
+		if (static_branch_unlikely(&__tracepoint_##name.key)) {	\
+			if (cond) {					\
+				scoped_guard(rcu_tasks_trace)		\
+					__DO_TRACE_CALL(name, TP_ARGS(args)); \
+			}						\
+		}							\
 		if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {		\
 			WARN_ONCE(!rcu_is_watching(),			\
 				  "RCU not watching for tracepoint");	\
-- 
2.45.2



