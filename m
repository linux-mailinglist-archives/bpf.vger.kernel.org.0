Return-Path: <bpf+bounces-40600-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3808598ACDD
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 21:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BC6E1C211A8
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 19:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D3119C56F;
	Mon, 30 Sep 2024 19:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="u6Ekf46q"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD01919A288;
	Mon, 30 Sep 2024 19:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727724396; cv=none; b=g3SzjAtV9I7lEYVwtEVxSvyGHpz6T/J7wEv1Q3KCZqb/v4ywIrlf3oNQub0gHrdL6EX9AIDqPRyUUqOBLjawgPyL+/cxKQJZJ/xi92gdx2SYL8FxOUfxDcDka9fMJG9APXrWKCWG2OGkTH1H1JwL3867GItXz7o/aE+g0ROQVlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727724396; c=relaxed/simple;
	bh=YAvfsUVzkdfENSEXcdox6M3fVrWGL98jFGGUdZ3uQlo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hh+9y4ywSXXaDWaf65QD38WJAyPyys94+SB6OqB0dqBuT/k8Aq9QsY/M5I4HvwHvNvYpZIuTMDyke/Nn/1Hn96eFwHIBmDnhgxsBCja/5Q1wrUojcUL7cbf09f2GyAcStSidu1DonxGrkJXSBlNF6ffafAkKei08/iEuxf/3Bw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=u6Ekf46q; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1727724392;
	bh=YAvfsUVzkdfENSEXcdox6M3fVrWGL98jFGGUdZ3uQlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u6Ekf46qlP8Twrz9HI8S9JwYn0vP6FGn3guxZNAp5YoGh1deUucH86mPWQriTIfPC
	 3TxQkudaY4TwWja926DGvuaPSOLk6pXCis3uX1dNCxNtKwRFAIal9ZjSP/jfbwkKtc
	 L6UiCnn5qLXSPhTZrdcZee+WfRBbxgucGiYkroACYKMzqAUYlN+Nr80mKofaXknFwt
	 EWy02iiuXbUv2EVxNpOJqxbPG0HXGs7yvymIVBsakk32ugKxixOo77KXyjqK3sfIBu
	 lO2ocXBxRlQix8MD/W8zRjSw7FZpXzCkSYzreqobA5/lQaLdM05qSx1mSCVp0QSkau
	 0PwR+5IpE0+pA==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XHWK41kL0zQPl;
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
Subject: [PATCH resend 5/8] tracing: Allow system call tracepoints to handle page faults
Date: Mon, 30 Sep 2024 15:23:54 -0400
Message-Id: <20240930192357.1154417-6-mathieu.desnoyers@efficios.com>
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
index 2e4b4952bba2..106e951896c2 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -17,6 +17,7 @@
 #include <linux/errno.h>
 #include <linux/types.h>
 #include <linux/rcupdate.h>
+#include <linux/rcupdate_trace.h>
 #include <linux/tracepoint-defs.h>
 #include <linux/static_call.h>
 
@@ -89,6 +90,7 @@ int unregister_tracepoint_module_notifier(struct notifier_block *nb)
 #ifdef CONFIG_TRACEPOINTS
 static inline void tracepoint_synchronize_unregister(void)
 {
+	synchronize_rcu_tasks_trace();
 	synchronize_srcu(&tracepoint_srcu);
 	synchronize_rcu();
 }
@@ -191,7 +193,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
  * it_func[0] is never NULL because there is at least one element in the array
  * when the array itself is non NULL.
  */
-#define __DO_TRACE(name, args, cond, rcuidle)				\
+#define __DO_TRACE(name, args, cond, rcuidle, syscall)			\
 	do {								\
 		int __maybe_unused __idx = 0;				\
 									\
@@ -202,8 +204,12 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
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
@@ -221,7 +227,10 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
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
@@ -231,7 +240,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 		if (static_key_false(&__tracepoint_##name.key))		\
 			__DO_TRACE(name,				\
 				TP_ARGS(args),				\
-				TP_CONDITION(cond), 1);			\
+				TP_CONDITION(cond), 1, 0);		\
 	}
 #else
 #define __DECLARE_TRACE_RCU(name, proto, args, cond)
@@ -275,7 +284,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 		if (static_key_false(&__tracepoint_##name.key))		\
 			__DO_TRACE(name,				\
 				TP_ARGS(args),				\
-				TP_CONDITION(cond), 0);			\
+				TP_CONDITION(cond), 0, 0);		\
 		if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {		\
 			WARN_ONCE(!rcu_is_watching(),			\
 				  "RCU not watching for tracepoint");	\
@@ -286,7 +295,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 		if (static_key_false(&__tracepoint_##name.key))		\
 			__DO_TRACE(name,				\
 				TP_ARGS(args),				\
-				TP_CONDITION(cond), 1);			\
+				TP_CONDITION(cond), 1, 0);		\
 	}								\
 	static inline int						\
 	register_trace_##name(void (*probe)(data_proto), void *data)	\
@@ -309,7 +318,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 		if (static_key_false(&__tracepoint_##name.key))		\
 			__DO_TRACE(name,				\
 				TP_ARGS(args),				\
-				TP_CONDITION(cond), 0);			\
+				TP_CONDITION(cond), 0, 1);		\
 		if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {		\
 			WARN_ONCE(!rcu_is_watching(),			\
 				  "RCU not watching for tracepoint");	\
diff --git a/init/Kconfig b/init/Kconfig
index 5783a0b87517..72e13ee73c43 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1936,6 +1936,7 @@ config BINDGEN_VERSION_TEXT
 #
 config TRACEPOINTS
 	bool
+	select TASKS_TRACE_RCU
 
 source "kernel/Kconfig.kexec"
 
-- 
2.39.2


