Return-Path: <bpf+bounces-39356-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D05D97237A
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 22:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02861B23A3B
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 20:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0375118C03C;
	Mon,  9 Sep 2024 20:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="J1ieXpQQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F5418A943;
	Mon,  9 Sep 2024 20:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725913041; cv=none; b=eI6hxEKd9PitrQq12lfk52kp5wW6YJkxvw3GkUdzd6adDX4LQPUA45HtVxLTX6DiKByiyFkwNQvV8n+IF16tVfncy2PiNgpXok5kI2jaJTk+GvVgqozp/5wl+fxGurtFxoqhqIGQWxN5er81hH2fpl6p5jlV+kf0D8OoprlLR7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725913041; c=relaxed/simple;
	bh=hJcVhbeaj6k9ErC0FjHzdoTIbfw2Pys8nh2Pm8fssdY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eiCbWy8KnBcbgAJ++na2qD4DE7GU9cXs7/Rj82VcmECO1SQJRgrb7hNRP010uuibTmC9fY58d5SBHJvfdVwo73fy60562RWRZ0DTf/x/iQo1bxnmTzaHPB+Epvp7dv3InfYa8wC+GftBGlYt9EoiqpzGPFCD0upT5npYRLDB3s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=J1ieXpQQ; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1725913037;
	bh=hJcVhbeaj6k9ErC0FjHzdoTIbfw2Pys8nh2Pm8fssdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J1ieXpQQeBOEoneKLX7KmFdRWkXK5OfDwToyFYBCndPOzNulrNjI+c7oNUUuGMHdR
	 D+CzERgrauyAf2JFZULPIZOWiPRVEF/da0QwP/tVLDJm6kLojl/QgV/9GfVtNXKwe4
	 CBI7mNz71DMqlPK+jM7rhY1/fyW3TJMucrHrIarJ3toRiaTU6PrMHhLcDhVtPrU6nK
	 6bBVeRcvjE9NZOTht6KYkp6xfZwmRoRKi1nlGUHExA5UhNc9Y+25PApM9DzQus3fvu
	 umFXSrYlbxMurNFAXc6DumSfl+9U+LrZFQQm+FWB1SfDYp8HgtCUYwuIlcYccVOdjh
	 Ph/H1fVaBvHTQ==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4X2dRK0HzHz1KSc;
	Mon,  9 Sep 2024 16:17:17 -0400 (EDT)
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
Subject: [PATCH 5/8] tracing: Allow system call tracepoints to handle page faults
Date: Mon,  9 Sep 2024 16:16:49 -0400
Message-Id: <20240909201652.319406-6-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240909201652.319406-1-mathieu.desnoyers@efficios.com>
References: <20240909201652.319406-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use Tasks Trace RCU to protect iteration of system call enter/exit
tracepoint probes to allow those probes to handle page faults.

In preparation for this change, all tracers registering to system call
enter/exit tracepoints should expect those to be called with preemption
enabled.

This allows tracers to fault-in userspace system call arguments such as
path strings within their probe callbacks.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
 include/linux/tracepoint.h | 25 +++++++++++++++++--------
 init/Kconfig               |  1 +
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index b2cfe6a9097c..005ede3b1afa 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -18,6 +18,7 @@
 #include <linux/types.h>
 #include <linux/cpumask.h>
 #include <linux/rcupdate.h>
+#include <linux/rcupdate_trace.h>
 #include <linux/tracepoint-defs.h>
 #include <linux/static_call.h>
 
@@ -90,6 +91,7 @@ int unregister_tracepoint_module_notifier(struct notifier_block *nb)
 #ifdef CONFIG_TRACEPOINTS
 static inline void tracepoint_synchronize_unregister(void)
 {
+	synchronize_rcu_tasks_trace();
 	synchronize_srcu(&tracepoint_srcu);
 	synchronize_rcu();
 }
@@ -192,7 +194,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
  * it_func[0] is never NULL because there is at least one element in the array
  * when the array itself is non NULL.
  */
-#define __DO_TRACE(name, args, cond, rcuidle)				\
+#define __DO_TRACE(name, args, cond, rcuidle, syscall)			\
 	do {								\
 		int __maybe_unused __idx = 0;				\
 									\
@@ -203,8 +205,12 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 			      "Bad RCU usage for tracepoint"))		\
 			return;						\
 									\
-		/* keep srcu and sched-rcu usage consistent */		\
-		preempt_disable_notrace();				\
+		if (syscall) {						\
+			rcu_read_lock_trace();				\
+		} else {						\
+			/* keep srcu and sched-rcu usage consistent */	\
+			preempt_disable_notrace();			\
+		}							\
 									\
 		/*							\
 		 * For rcuidle callers, use srcu since sched-rcu	\
@@ -222,7 +228,10 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 			srcu_read_unlock_notrace(&tracepoint_srcu, __idx);\
 		}							\
 									\
-		preempt_enable_notrace();				\
+		if (syscall)						\
+			rcu_read_unlock_trace();			\
+		else							\
+			preempt_enable_notrace();			\
 	} while (0)
 
 #ifndef MODULE
@@ -232,7 +241,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 		if (static_key_false(&__tracepoint_##name.key))		\
 			__DO_TRACE(name,				\
 				TP_ARGS(args),				\
-				TP_CONDITION(cond), 1);			\
+				TP_CONDITION(cond), 1, 0);		\
 	}
 #else
 #define __DECLARE_TRACE_RCU(name, proto, args, cond)
@@ -276,7 +285,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 		if (static_key_false(&__tracepoint_##name.key))		\
 			__DO_TRACE(name,				\
 				TP_ARGS(args),				\
-				TP_CONDITION(cond), 0);			\
+				TP_CONDITION(cond), 0, 0);		\
 		if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {		\
 			WARN_ONCE(!rcu_is_watching(),			\
 				  "RCU not watching for tracepoint");	\
@@ -287,7 +296,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 		if (static_key_false(&__tracepoint_##name.key))		\
 			__DO_TRACE(name,				\
 				TP_ARGS(args),				\
-				TP_CONDITION(cond), 1);			\
+				TP_CONDITION(cond), 1, 0);		\
 	}								\
 	static inline int						\
 	register_trace_##name(void (*probe)(data_proto), void *data)	\
@@ -310,7 +319,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 		if (static_key_false(&__tracepoint_##name.key))		\
 			__DO_TRACE(name,				\
 				TP_ARGS(args),				\
-				TP_CONDITION(cond), 0);			\
+				TP_CONDITION(cond), 0, 1);		\
 		if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {		\
 			WARN_ONCE(!rcu_is_watching(),			\
 				  "RCU not watching for tracepoint");	\
diff --git a/init/Kconfig b/init/Kconfig
index d8a971b804d3..c854b2887e7f 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1937,6 +1937,7 @@ config BINDGEN_VERSION_TEXT
 #
 config TRACEPOINTS
 	bool
+	select TASKS_TRACE_RCU
 
 source "kernel/Kconfig.kexec"
 
-- 
2.39.2


