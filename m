Return-Path: <bpf+bounces-41329-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D3A995CB5
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 03:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 209A5286272
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 01:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C72558BB;
	Wed,  9 Oct 2024 01:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="xlwJzY2z"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330F4210FB;
	Wed,  9 Oct 2024 01:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728436170; cv=none; b=oXLMRH/qdpPWINC55itX+3SlSdromOKvb4i4N1U/cJbBeOor/Tp1RcJUF/j0WzDSJ9O04usElQYkRA15iZRGq5yy/H+yOeo1Dx4wA/qBke0Y1tGbLqHpAsj5QAPPsE4XDvTxqeplJFkwuqpMVEOFqwAxv/Gi2DSm8WwiRB2Z1T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728436170; c=relaxed/simple;
	bh=1mOKEbciFJb9rPglGELW2LAK6FZ88FFDOt+9NpyFU4I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YgXvO6ww9JGJcQkkCa+B8lVHIF98t/rBm4foJcIqMv4R+lis9n9ZvKe7kxzsXHhmRFLTEVB0lqxEFXu/LgKK7wGz0gytIAKoNHwYzarYyaup66fdgl87XjJphlWW/XpK8HWTXpwD+qTe6zxD6JL5+PM+dGuRhLfihV08eRwWA/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=xlwJzY2z; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1728436167;
	bh=1mOKEbciFJb9rPglGELW2LAK6FZ88FFDOt+9NpyFU4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xlwJzY2ztG+s1107HMTyMBhiwDxKDuYNOvWZQgIiDjtayco8PKMmjV5bRs/WQq9tz
	 4O/m7XDVNH6oRTAxKxg6Y1iZ0wv9l3Nw5D8zvMNVBzwsoISXEiQm5C+viV9/etYuKO
	 6RnViH25wW4240pH2RSz3CQaUgFrLWRuh+3xlNach45mLuJTJlRD3lzHSa8G/ePGvY
	 ITSAnGRz1bSFQ6eOWeKzIDNn5iyb2l4s535lwoJiZBFe38vuPUOaV/leugAkA08MzN
	 odrr59Ush6PgHzvjN9x2Du4YRwFiLJB0oBcGn1xw75o/+wiBXQ26ISjNbTAHHb14jR
	 WSFAEyz34mTCg==
Received: from thinkos.internal.efficios.com (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XNZY31l2zzS0R;
	Tue,  8 Oct 2024 21:09:27 -0400 (EDT)
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
Subject: [PATCH v4 5/8] tracing: Allow system call tracepoints to handle page faults
Date: Tue,  8 Oct 2024 21:07:15 -0400
Message-Id: <20241009010718.2050182-6-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241009010718.2050182-1-mathieu.desnoyers@efficios.com>
References: <20241009010718.2050182-1-mathieu.desnoyers@efficios.com>
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
Changes since v3:
- Add comment above __DO_TRACE() which describes the preempt off
  vs Tasks Trace RCU for syscall=0 vs syscall=1.
---
 include/linux/tracepoint.h | 18 ++++++++++++++++--
 init/Kconfig               |  1 +
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 76e441b39a96..0dc67fad706c 100644
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
@@ -196,6 +198,12 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 /*
  * it_func[0] is never NULL because there is at least one element in the array
  * when the array itself is non NULL.
+ *
+ * With @syscall=0, the tracepoint callback array dereference is
+ * protected by disabling preemption.
+ * With @syscall=1, the tracepoint callback array dereference is
+ * protected by Tasks Trace RCU, which allows probes to handle page
+ * faults.
  */
 #define __DO_TRACE(name, args, cond, syscall)				\
 	do {								\
@@ -204,11 +212,17 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
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
diff --git a/init/Kconfig b/init/Kconfig
index 530a382ee0fe..4ac3d1b48278 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1985,6 +1985,7 @@ config BINDGEN_VERSION_TEXT
 #
 config TRACEPOINTS
 	bool
+	select TASKS_TRACE_RCU
 
 source "kernel/Kconfig.kexec"
 
-- 
2.39.2


