Return-Path: <bpf+bounces-45504-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3478E9D69A1
	for <lists+bpf@lfdr.de>; Sat, 23 Nov 2024 16:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0FEE281C22
	for <lists+bpf@lfdr.de>; Sat, 23 Nov 2024 15:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00D05336E;
	Sat, 23 Nov 2024 15:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="nNIcDKl+"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE60F9DF;
	Sat, 23 Nov 2024 15:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732375875; cv=none; b=LiGc4VF370vihpXOlDif3Z6mmaSAufsyM7a0/VdBYqgy4yeRXeYKmfkUNmookRwZC2s3wsErzQTWpE9gZKljNJ6/xW/VFzFDQOmqFd4sEaykfc7npd2QUhJt3XXGoym8HHXrcaOfIwvk2OHzpEiBnWDectEAQ0U9NhrA7BCBZlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732375875; c=relaxed/simple;
	bh=8jblhN/FV/L6rT20bCyXuKRLQDU8WA4Wt7+yUoOxRA0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IEXtDhyMG6CzotW2yqZZI4VdTxEQIjAIOBa3wr1M8LHtzkO5iPqi1/CW+VcvBSrVGKeMqrUwKPNVSZ242CzZIJOT6PyYdhtTKhmtUVhNY0c5o8PKzFeirfSGml+CZp0esr6KClylApfqB1fJqtIjse7TbNrryKUhPNAXh5him2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=nNIcDKl+; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1732375871;
	bh=8jblhN/FV/L6rT20bCyXuKRLQDU8WA4Wt7+yUoOxRA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nNIcDKl+4ookxxk22i3u6/IGmfMQS54ZsyL6z6Yul4MFehJM+Me0lcrMOpFL87MuH
	 lz6eXZvB04NV/vF7N9u7wJ/xFcBBnUDNhEfdaddi5nq3GqM3W2V2Kdnrd/fmTprv2L
	 QYLPFK5RFHnxOigBrwzaVBne2iJGukLjo0zLImi8JK1RC5ktch8EdS4NhmhIPuXcKM
	 MZU96FUIh59xiMuNdc20+xhc8/wOQ4p2W5fY7hzt0Qg3Po0rLtNReY4f+0qtJnym34
	 5LjvlGBUDXJdbMFJbgEUQ1bWJ9mjNena/7t16Ou3V5U8FUqj9mkFfkrSF6/p4bp6go
	 isM8IvbhLg2bw==
Received: from thinkos.internal.efficios.com (unknown [IPv6:2605:8d80:581:d239:b14d:eb44:5229:ce95])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XwbXZ3f1GzWqN;
	Sat, 23 Nov 2024 10:31:10 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
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
	Jordan Rife <jrife@google.com>,
	linux-trace-kernel@vger.kernel.org
Subject: [RFC PATCH 4/5] tracing: Remove conditional locking from __DO_TRACE()
Date: Sat, 23 Nov 2024 10:30:30 -0500
Message-Id: <20241123153031.2884933-5-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241123153031.2884933-1-mathieu.desnoyers@efficios.com>
References: <20241123153031.2884933-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
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
2.39.5


