Return-Path: <bpf+bounces-45506-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF4A9D69A5
	for <lists+bpf@lfdr.de>; Sat, 23 Nov 2024 16:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70B97161960
	for <lists+bpf@lfdr.de>; Sat, 23 Nov 2024 15:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCE713A265;
	Sat, 23 Nov 2024 15:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="tMeNQEeL"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F243BBC9;
	Sat, 23 Nov 2024 15:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732375877; cv=none; b=YhJIZ2SSDUONyrCJr6g99DaCsr3r97bGBW+4gODSyrbpQmMn3dn+50B0dTxa4x3iu8yGJ0XP6+HcyHoP/wSYwC1kT6clm094ASU4b+LlNFUFf+6Vi/4WCxUrzWjGdCdfLuhbW41s3ziY8EV17O+ZmRAP1dtwMp7rq+5OYxWceak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732375877; c=relaxed/simple;
	bh=8zvUDCCFQ5gsSAH8tNdTqIHJ9Nunn5c2a5KE7JzSb68=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g5T4++yuxz3170yZHSIOTLrEBvcwLBIK8UWpNFpyDE8Y9Mln4djcv5l05nYpNzHZsn1Dc0UNUKbMjkLnuzF/vgFQdej7SUf4b0o+tFoK+A83yKu7scpG1ti2y7i2lWCJR42p6Xt2n09qZt9T5JoMqXugEGq0knyVTKoX/nrwu4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=tMeNQEeL; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1732375872;
	bh=8zvUDCCFQ5gsSAH8tNdTqIHJ9Nunn5c2a5KE7JzSb68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tMeNQEeLEVejdktOXqGzY9IgsooX7qbv7G38hiRUZj4/QuEE5HsGrI4C8hDa9Ar7l
	 Su1IWdi5vqVipvnh0KH667qNyPegBuEXebJr4f+Bqg3gtw4EVbBRRdrTXKOReoKlid
	 qC5gW/AKTPs0NnsVQqk9Wq17AMF3BDO74+M7z2FcyMknqtRq3VqhNGLtTS338Wlb6U
	 VIPS3fRXyIHMNIymDdxfirFSIdu/PcdxDReZeyEsvkWW+RzUpdpIxl8Ff8zvsWqM+P
	 YoFCJSOeA7DukvwpSuvOMIEthEILArmMSRXpwZYjJLYjjKB3NGikCxAkOqFawwkoK6
	 3Ixu1h6KATiNQ==
Received: from thinkos.internal.efficios.com (unknown [IPv6:2605:8d80:581:d239:b14d:eb44:5229:ce95])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XwbXb5vDBzWdR;
	Sat, 23 Nov 2024 10:31:11 -0500 (EST)
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
Subject: [RFC PATCH 5/5] tracing: Remove cond argument from __DECLARE_TRACE_SYSCALL
Date: Sat, 23 Nov 2024 10:30:31 -0500
Message-Id: <20241123153031.2884933-6-mathieu.desnoyers@efficios.com>
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

Syscall tracepoints do not require a "cond" argument, because they are
meant to be used only for sys_enter and sys_exit instrumentation, which
don't require condition evaluation.

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
2.39.5


