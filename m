Return-Path: <bpf+bounces-40842-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FBA98F266
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 17:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D31591C21A99
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 15:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA541A76CB;
	Thu,  3 Oct 2024 15:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="ba7jj/3k"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDEE1A2C32;
	Thu,  3 Oct 2024 15:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727968733; cv=none; b=uIzWSrPFltPa7DLTk136GhoAZs/+w4TmAeG6kpwUkKXY69stX23i/HUfIEeWuEkjiAcaA/zhEyB89H07L29bS4flGOFKuzpWW6yo5L0tDKRgaViMOoBa+XDgSXhqXUS9gzBz/bOSoXZ0BtKj7yozIdwKmGi3ffy+UqJO6rwaHSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727968733; c=relaxed/simple;
	bh=cFKaryhx8iL3A0KR0AkdZdd7ZsIGBNvmJeXwPGSJJBE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AZNaTIhD6sKF65IP68xMEdZ6Syz5O0BN/aJavqHwkCo+bmzBwwE9758ycMtzSNy7Tm59zFewafmsJMwJ/CV5sZEOv063fgrtt3X1u2xfrkdeNMg4W2tiuzgQ2kykp4FzddtsazcWJ6YwIrCMzxKFZacUjZnXN1CtCsf+wSddVCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=ba7jj/3k; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1727968725;
	bh=cFKaryhx8iL3A0KR0AkdZdd7ZsIGBNvmJeXwPGSJJBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ba7jj/3kHWelvv8zFIa0KiKXxkHJoQSR8ucgpInmUSXf1Ddq3iHqFe/ylEeBA2B59
	 JL0juShEwPw7iLpsYPQQCEAoohnReLjCelQ0mAjOQ/jUn0x9kK5Re3ZHZmD0n5uhGG
	 ELM1iqbb+lAcDIzUnS+IAgewwdMMU8v3Lpy27Q23gIgEc1VnprQDoyhzEz7jM2iu7Y
	 LbuYDIhqyOa88gen751+RbBgYY/fMX5W3mLE8uUeGaXyTyoX2RJcpKD08OCmoU51/z
	 gZ3jjipHklwwbED1/hkxcL13lQ52HCkMrEOIhTJCoxUz8mHPAPRoQqr3Dxm4j2eSTY
	 wTrIvxv706lKQ==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XKFgm5G4rz5pT;
	Thu,  3 Oct 2024 11:18:44 -0400 (EDT)
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
Subject: [PATCH v1 5/8] tracing: Allow system call tracepoints to handle page faults
Date: Thu,  3 Oct 2024 11:16:35 -0400
Message-Id: <20241003151638.1608537-6-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241003151638.1608537-1-mathieu.desnoyers@efficios.com>
References: <20241003151638.1608537-1-mathieu.desnoyers@efficios.com>
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
index 666499b9f3be..6faf34e5efc9 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -17,6 +17,7 @@
 #include <linux/errno.h>
 #include <linux/types.h>
 #include <linux/rcupdate.h>
+#include <linux/rcupdate_trace.h>
 #include <linux/tracepoint-defs.h>
 #include <linux/static_call.h>
 
@@ -109,6 +110,7 @@ void for_each_tracepoint_in_module(struct module *mod,
 #ifdef CONFIG_TRACEPOINTS
 static inline void tracepoint_synchronize_unregister(void)
 {
+	synchronize_rcu_tasks_trace();
 	synchronize_srcu(&tracepoint_srcu);
 	synchronize_rcu();
 }
@@ -211,7 +213,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
  * it_func[0] is never NULL because there is at least one element in the array
  * when the array itself is non NULL.
  */
-#define __DO_TRACE(name, args, cond, rcuidle)				\
+#define __DO_TRACE(name, args, cond, rcuidle, syscall)			\
 	do {								\
 		int __maybe_unused __idx = 0;				\
 									\
@@ -222,8 +224,12 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
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
@@ -241,7 +247,10 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
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
@@ -251,7 +260,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 		if (static_key_false(&__tracepoint_##name.key))		\
 			__DO_TRACE(name,				\
 				TP_ARGS(args),				\
-				TP_CONDITION(cond), 1);			\
+				TP_CONDITION(cond), 1, 0);		\
 	}
 #else
 #define __DECLARE_TRACE_RCU(name, proto, args, cond)
@@ -284,7 +293,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 		if (static_key_false(&__tracepoint_##name.key))		\
 			__DO_TRACE(name,				\
 				TP_ARGS(args),				\
-				TP_CONDITION(cond), 0);			\
+				TP_CONDITION(cond), 0, 0);		\
 		if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {		\
 			WARN_ONCE(!rcu_is_watching(),			\
 				  "RCU not watching for tracepoint");	\
@@ -295,7 +304,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 		if (static_key_false(&__tracepoint_##name.key))		\
 			__DO_TRACE(name,				\
 				TP_ARGS(args),				\
-				TP_CONDITION(cond), 1);			\
+				TP_CONDITION(cond), 1, 0);		\
 	}								\
 	static inline int						\
 	register_trace_##name(void (*probe)(data_proto), void *data)	\
@@ -330,7 +339,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 		if (static_key_false(&__tracepoint_##name.key))		\
 			__DO_TRACE(name,				\
 				TP_ARGS(args),				\
-				TP_CONDITION(cond), 0);			\
+				TP_CONDITION(cond), 0, 1);		\
 		if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {		\
 			WARN_ONCE(!rcu_is_watching(),			\
 				  "RCU not watching for tracepoint");	\
diff --git a/init/Kconfig b/init/Kconfig
index fbd0cb06a50a..eedd0064fb36 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1984,6 +1984,7 @@ config BINDGEN_VERSION_TEXT
 #
 config TRACEPOINTS
 	bool
+	select TASKS_TRACE_RCU
 
 source "kernel/Kconfig.kexec"
 
-- 
2.39.2


