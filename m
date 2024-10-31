Return-Path: <bpf+bounces-43651-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 288A19B7E48
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 16:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E1CCB22BA8
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 15:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5FE1B5328;
	Thu, 31 Oct 2024 15:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="IBH7L0QS"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9600F19E99C;
	Thu, 31 Oct 2024 15:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730388161; cv=none; b=QQkQ57hr71f/tCadpNJxNt5UyaISXluclQ9AMTyOxhFHJgl6A2GgOm2tKWrJkl8/RfyEksVtBhXCEuxUsF3+F8N6OY80iE5lRQ8J1FxeiTZH+FM2ZNVrcjPNwDnc2QmDI05uEaoalkQ1MRpHL5kg6iuX/8+mbvcc57+5gB3jx14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730388161; c=relaxed/simple;
	bh=ZqpK2Tzlh2NaO9S+TPcvuIa3DNo8WQ0Kp8dlvt/m/dM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SDsEDUWeif/Ngsbk5l5gRZeyeeXWvCKHomYymj1L9EwrrVbSdLlpsa5aLgbjIzcZSMlBi04SkmUEl/Wvg5oFGcS7+dns8cLI4+bd6krhP2Uj36wgnTi4ei7lHzyEgWZsuROj+4GtxOjCm2PKzEN5qNU4m9SM+sQdYABCIbcIXCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=IBH7L0QS; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1730388157;
	bh=ZqpK2Tzlh2NaO9S+TPcvuIa3DNo8WQ0Kp8dlvt/m/dM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IBH7L0QSqdcbSyQWoYgEmlDWEPdg1dDtCIR+iRKeGkj8m3ydPWgAWAmP04uUzARTn
	 Zd7k6lMoFXP3QkmZbNsrZOuD1k7XHFZ0tAuVwlyI1r9cyqr0a3yhK58fP+IX7WXEau
	 2rB5X+G8Jjn2hLkzGpmZ0uGGpjkH1it79xJzYm5EI64QnOA5QPyGbPpr6bKqq+IibE
	 ydljVJp3e5Il/POnZjhrXKsufKzkPLAmnkoxZDy535bCE8bLvLgGKe2cLpk2qgeSF9
	 ThqsrjcctIJGnCL8nGlmeSnTl5PAFdQeH6TkgX8dpwP8FHn0wa66y0lRqvc5tTtu+Q
	 0mD09lDz8LedQ==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XfSRK188CzYqT;
	Thu, 31 Oct 2024 11:22:37 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
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
	linux-trace-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v5 resend 2/4] tracing: Introduce tracepoint_is_faultable()
Date: Thu, 31 Oct 2024 11:20:54 -0400
Message-Id: <20241031152056.744137-3-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241031152056.744137-1-mathieu.desnoyers@efficios.com>
References: <20241031152056.744137-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a "faultable" flag within the extended structure to know
whether a tracepoint needs rcu tasks trace grace period before reclaim.
This can be queried using tracepoint_is_faultable().

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Tested-by: Jordan Rife <jrife@google.com>
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
Cc: linux-trace-kernel@vger.kernel.org
---
Changes since v4:
- Add static to DEFINE_TRACE_SYSCALL.
---
 include/linux/tracepoint-defs.h |  2 ++
 include/linux/tracepoint.h      | 24 ++++++++++++++++++++++++
 include/trace/define_trace.h    |  2 +-
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/include/linux/tracepoint-defs.h b/include/linux/tracepoint-defs.h
index 967c08d9da84..aebf0571c736 100644
--- a/include/linux/tracepoint-defs.h
+++ b/include/linux/tracepoint-defs.h
@@ -32,6 +32,8 @@ struct tracepoint_func {
 struct tracepoint_ext {
 	int (*regfunc)(void);
 	void (*unregfunc)(void);
+	/* Flags. */
+	unsigned int faultable:1;
 };
 
 struct tracepoint {
diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 862ab49177a4..906f3091d23d 100644
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
+ * - tracepoint_is_faultable() == false: call_rcu()
+ * - tracepoint_is_faultable() == true:  call_rcu_tasks_trace()
  */
 #ifdef CONFIG_TRACEPOINTS
 static inline void tracepoint_synchronize_unregister(void)
@@ -111,9 +117,17 @@ static inline void tracepoint_synchronize_unregister(void)
 	synchronize_rcu_tasks_trace();
 	synchronize_rcu();
 }
+static inline bool tracepoint_is_faultable(struct tracepoint *tp)
+{
+	return tp->ext && tp->ext->faultable;
+}
 #else
 static inline void tracepoint_synchronize_unregister(void)
 { }
+static inline bool tracepoint_is_faultable(struct tracepoint *tp)
+{
+	return false;
+}
 #endif
 
 #ifdef CONFIG_HAVE_SYSCALL_TRACEPOINTS
@@ -345,6 +359,15 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 	static struct tracepoint_ext __tracepoint_ext_##_name = {	\
 		.regfunc = _reg,					\
 		.unregfunc = _unreg,					\
+		.faultable = false,					\
+	};								\
+	__DEFINE_TRACE_EXT(_name, &__tracepoint_ext_##_name, PARAMS(_proto), PARAMS(_args));
+
+#define DEFINE_TRACE_SYSCALL(_name, _reg, _unreg, _proto, _args)	\
+	static struct tracepoint_ext __tracepoint_ext_##_name = {	\
+		.regfunc = _reg,					\
+		.unregfunc = _unreg,					\
+		.faultable = true,					\
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


