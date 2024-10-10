Return-Path: <bpf+bounces-41578-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDEA9989EA
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 16:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24B2CB266E7
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 14:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C87F1CF7B2;
	Thu, 10 Oct 2024 14:25:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B654E1CF2A0;
	Thu, 10 Oct 2024 14:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728570342; cv=none; b=Oy5/sQux8wrn0yuBrZrD/mnVwNYSbyRaSH/28/Sr/zvgKE3CvKA3vqctzcYr5x5iwW3lxafvnPu2Fs5AM7rt1P38cuFscyFz9T1eOyavgEeWG+IvGVD4yYvTmZhN9TfcP3CURmGohJqTIg2QveFiom2cXXY/u055As0Z3Bh477A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728570342; c=relaxed/simple;
	bh=/rfeRyd0gT8Xa1W8QOIINMrKE3pZNo6+Yz00uQTkrFs=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=LBjWOvZIttERxAqbPbJLHNSGFb7HZ2f+Iw52U4+1mk1hMILXL0q/BWHFbBREZqS1V+GGfS1+IGqV70K/y1jZoqycgjR66B0zRj3aCwZFAxUqET5IU8/Uyr+V4vhzuC/tNb8fC0jzn+mQzsipj8+zxE3bXHlZ0A5/T2cnka7Fv3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0CCEC4CEDB;
	Thu, 10 Oct 2024 14:25:42 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1syu6w-00000001HIp-23Zf;
	Thu, 10 Oct 2024 10:25:50 -0400
Message-ID: <20241010142550.357602926@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 10 Oct 2024 10:25:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
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
 Joel Fernandes <joel@joelfernandes.org>
Subject: [for-next][PATCH 05/10] tracing: Allow system call tracepoints to handle page faults
References: <20241010142537.255433162@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Use Tasks Trace RCU to protect iteration of system call enter/exit
tracepoint probes to allow those probes to handle page faults.

In preparation for this change, all tracers registering to system call
enter/exit tracepoints should expect those to be called with preemption
enabled.

This allows tracers to fault-in userspace system call arguments such as
path strings within their probe callbacks.

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
Link: https://lore.kernel.org/20241009010718.2050182-6-mathieu.desnoyers@efficios.com
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
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
2.45.2



