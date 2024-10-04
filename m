Return-Path: <bpf+bounces-40901-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9904D98FBDB
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 03:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE95B1C225FD
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 01:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3011E489;
	Fri,  4 Oct 2024 01:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="AzCX3ANN"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F58C8F70;
	Fri,  4 Oct 2024 01:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728004450; cv=none; b=HHJD4AavWPGkPsx9VJG2K3+2UkKO2JKTEvFKR33WWZ7JjFN8aar7Nk9rq7OWI+Rz6z6cfkiE1QmnN71hCtoMeRg7kFiBQ0UYhSDdu/AZ/8kJh99euRXRvPEwayBFAwZ0NVL9P9l/FlHB1ihSmtUh//ioiGYv9wVQ4kJpnF+DWuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728004450; c=relaxed/simple;
	bh=wHEQ4FHpQMaJpDPP/OV5VM71R775WxFx2P1YYsMxWC4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lZZP5pb0wSbV/FBTQSScOmvpfTQEDO0Td9/X9AfxcohMCDonWStTEO2Niq+Hq0pqY9HUbC/CSkYF3XRcUlasJ+xRviQfGZHdy1aeni8Cpg50uzT8FR64RV2lV0aDmgXnge9DLtKda26gO723CH/cNEsDAEhqkS9NOWURln5/hA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=AzCX3ANN; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1728004448;
	bh=wHEQ4FHpQMaJpDPP/OV5VM71R775WxFx2P1YYsMxWC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AzCX3ANNw4z1nkrn+wwU+dh2M8JgK/dgzsxDeVIe76dCVwqJwzejyp0TRmxX+EqrQ
	 Lj8tKGHhq+xAeuuJziOgEWGcfzW9LLwKJeYcNQ5FNFo1gq0GhMbovvbu9HiW8dIiFQ
	 491YgSaIL8LHnC1OKsZwaiOMFb4/G9oUEJbes6bABJaNuePGySnV7innVFkzuN4wph
	 ZUCekElxEkyCKplSXyQophd7kQaIHRw8XA4HL4D+sPkezSXGtVrQXEM+UBoDiZG69l
	 QYclOtGJuBf0Q2huo4BOcc5p7oVV92hpySZKapIRzV8hWuGN9GN5Lqy5wMzaX4YAdp
	 zsVKJrz+CXuuQ==
Received: from thinkos.internal.efficios.com (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XKVtl7382zByn;
	Thu,  3 Oct 2024 21:14:07 -0400 (EDT)
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
Subject: [PATCH v2 4/7] tracing: Allow system call tracepoints to handle page faults
Date: Thu,  3 Oct 2024 21:11:58 -0400
Message-Id: <20241004011201.1681962-5-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241004011201.1681962-1-mathieu.desnoyers@efficios.com>
References: <20241004011201.1681962-1-mathieu.desnoyers@efficios.com>
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
 include/linux/tracepoint.h | 18 +++++++++++++-----
 init/Kconfig               |  1 +
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 1a78c9bbece8..a09a97480f5a 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -17,6 +17,7 @@
 #include <linux/errno.h>
 #include <linux/types.h>
 #include <linux/rcupdate.h>
+#include <linux/rcupdate_trace.h>
 #include <linux/tracepoint-defs.h>
 #include <linux/static_call.h>
 
@@ -107,6 +108,7 @@ void for_each_tracepoint_in_module(struct module *mod,
 #ifdef CONFIG_TRACEPOINTS
 static inline void tracepoint_synchronize_unregister(void)
 {
+	synchronize_rcu_tasks_trace();
 	synchronize_rcu();
 }
 #else
@@ -197,18 +199,24 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
  * it_func[0] is never NULL because there is at least one element in the array
  * when the array itself is non NULL.
  */
-#define __DO_TRACE(name, args, cond)					\
+#define __DO_TRACE(name, args, cond, syscall)				\
 	do {								\
 		int __maybe_unused __idx = 0;				\
 									\
 		if (!(cond))						\
 			return;						\
 									\
-		preempt_disable_notrace();				\
+		if (syscall)						\
+			rcu_read_lock_trace();				\
+		else							\
+			preempt_disable_notrace();			\
 									\
 		__DO_TRACE_CALL(name, TP_ARGS(args));			\
 									\
-		preempt_enable_notrace();				\
+		if (syscall)						\
+			rcu_read_unlock_trace();			\
+		else							\
+			preempt_enable_notrace();			\
 	} while (0)
 
 /*
@@ -238,7 +246,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 		if (static_key_false(&__tracepoint_##name.key))		\
 			__DO_TRACE(name,				\
 				TP_ARGS(args),				\
-				TP_CONDITION(cond));			\
+				TP_CONDITION(cond), 0);			\
 		if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {		\
 			WARN_ONCE(!rcu_is_watching(),			\
 				  "RCU not watching for tracepoint");	\
@@ -276,7 +284,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 		if (static_key_false(&__tracepoint_##name.key))		\
 			__DO_TRACE(name,				\
 				TP_ARGS(args),				\
-				TP_CONDITION(cond), 0);			\
+				TP_CONDITION(cond), 1);			\
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


