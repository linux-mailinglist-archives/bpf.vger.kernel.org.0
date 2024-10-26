Return-Path: <bpf+bounces-43240-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D76899B1991
	for <lists+bpf@lfdr.de>; Sat, 26 Oct 2024 17:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 018101C20E8C
	for <lists+bpf@lfdr.de>; Sat, 26 Oct 2024 15:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D57D1D5AC2;
	Sat, 26 Oct 2024 15:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="FFZVl9wN"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC8C7EEFD;
	Sat, 26 Oct 2024 15:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729957697; cv=none; b=g50HEFcGb2/KKSrM5wp2otFkwEa/mpDwXY1lqO33l2kbRuzks8fOkPzRk5jfZ63F+BRi5Zoqoz+KA6+xkwns+GRGIL3ofNhJvhq0Egg8mC7K5GjBlJaqXGzZZ5Q3zG1+/GdkwoNi/4UjUZ7nPWm9HlDLtfc2+mIJ+D7cVi/KiXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729957697; c=relaxed/simple;
	bh=Yt3JqGyHnlN/PMXwaeZS2HWMIxiUalPTFf0y/3FdW84=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZNHut40AyaahukWP82601PrcFvE9r8R78Qult7IYB/hNfEwgFzlWmclYQY9MJzzCsmlmWl/wj2NPF869iFZmIpsmPhsDo785aiZRxfOFQH4FzEmhZDfcGJK6c7ezztTGNFKcZQINT5sWwUssrtTHZStER0tU5VzMRtrLZ7AhNIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=FFZVl9wN; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1729957694;
	bh=Yt3JqGyHnlN/PMXwaeZS2HWMIxiUalPTFf0y/3FdW84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FFZVl9wN5VzrK90vBTebnKJw5b3b/ESDnfk20WGExNH2v41mnlXXXmLCnBZkG7cv9
	 kmXuB4jQcni/zWcHiegRcLe/niCAds0jRt4xHDzEWl00IO4jVdj05YszBcBex/MIfe
	 w95WP6J4S4YwU7HMl/Ke848MB+wm5OKApGxlGDq9kq3BRRkth8ceshQRGyGkFn69oG
	 P23PrflB04Lv9SHP+Kjbx1n+v6pjAqeeEPy15ytfo4LKFcM6Tdg2oAaOdL/KTuT81R
	 pmAXUsW1uIXzHIHY7x9Wl8td7vHuB3FxtwWVWqKvb5EMhXbxC7VsGTooMhpIdMq2Je
	 4cnbZlrvhOyaQ==
Received: from thinkos.internal.efficios.com (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XbPF96SvszNmN;
	Sat, 26 Oct 2024 11:48:13 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
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
	Jordan Rife <jrife@google.com>
Subject: [RFC PATCH v3 2/3] tracing: Introduce tracepoint_is_syscall()
Date: Sat, 26 Oct 2024 11:46:28 -0400
Message-Id: <20241026154629.593041-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241026154629.593041-1-mathieu.desnoyers@efficios.com>
References: <20241026154629.593041-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a "syscall" flag within the extended structure to know whether
a tracepoint needs rcu tasks trace grace period before reclaim.
This can be queried using tracepoint_is_syscall().

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
Cc: Jordan Rife <jrife@google.com>
---
 include/linux/tracepoint-defs.h |  2 ++
 include/linux/tracepoint.h      | 24 ++++++++++++++++++++++++
 include/trace/define_trace.h    |  2 +-
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/include/linux/tracepoint-defs.h b/include/linux/tracepoint-defs.h
index 967c08d9da84..53119e074c87 100644
--- a/include/linux/tracepoint-defs.h
+++ b/include/linux/tracepoint-defs.h
@@ -32,6 +32,8 @@ struct tracepoint_func {
 struct tracepoint_ext {
 	int (*regfunc)(void);
 	void (*unregfunc)(void);
+	/* Flags. */
+	unsigned int syscall:1;
 };
 
 struct tracepoint {
diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 83dc24ee8b13..93e70bc64533 100644
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
+ * - tracepoint_is_syscall() == false: call_rcu()
+ * - tracepoint_is_syscall() == true:  call_rcu_tasks_trace()
  */
 #ifdef CONFIG_TRACEPOINTS
 static inline void tracepoint_synchronize_unregister(void)
@@ -111,9 +117,17 @@ static inline void tracepoint_synchronize_unregister(void)
 	synchronize_rcu_tasks_trace();
 	synchronize_rcu();
 }
+static inline bool tracepoint_is_syscall(struct tracepoint *tp)
+{
+	return tp->ext && tp->ext->syscall;
+}
 #else
 static inline void tracepoint_synchronize_unregister(void)
 { }
+static inline bool tracepoint_is_syscall(struct tracepoint *tp)
+{
+	return false;
+}
 #endif
 
 #ifdef CONFIG_HAVE_SYSCALL_TRACEPOINTS
@@ -345,6 +359,15 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 	struct tracepoint_ext __tracepoint_ext_##_name = {		\
 		.regfunc = _reg,					\
 		.unregfunc = _unreg,					\
+		.syscall = false,					\
+	};								\
+	__DEFINE_TRACE_EXT(_name, &__tracepoint_ext_##_name, PARAMS(_proto), PARAMS(_args));
+
+#define DEFINE_TRACE_SYSCALL(_name, _reg, _unreg, _proto, _args)	\
+	struct tracepoint_ext __tracepoint_ext_##_name = {		\
+		.regfunc = _reg,					\
+		.unregfunc = _unreg,					\
+		.syscall = true,					\
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
2.39.5


