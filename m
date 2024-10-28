Return-Path: <bpf+bounces-43324-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4109A9B3A38
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 20:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 006FA283801
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 19:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5B41E1A25;
	Mon, 28 Oct 2024 19:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="g6sZFsC5"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F391E00BD;
	Mon, 28 Oct 2024 19:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730142678; cv=none; b=CNGuB5u275fbAf08Ml6z8ycNBNNh7Mh2q9VsNHLl6cJ+9Xto4KQ8IIwHganTfZsF/H5oRPgX9eShPfCQBP+gKFFXjuEIDMJ4upec73OS7419tq4+cEPjVIJq0USRHr0/Xyp9NIi01nT77FdPIKlrs2W6soPXedwQw453gYy+nyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730142678; c=relaxed/simple;
	bh=adS58VZKpMyBhjeczUuBLAUJ2Kusr9Rs3Sub45oP7p0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tU+sGw9sYRuFVcvGMvL35DjNj9tjkjxShDX4bJYoUUFp8o+67jWNVRO8Tp31ZUt61hesO+2n3h5xIM4IaHtEeqlrIZS2H1lL9PGl/S7SeQKixSTJtMzvGz0d3/TGN2ezPk8QcgF/foIwgWPiAmngZEvNT5Va18ygbUHrTDrNJTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=g6sZFsC5; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1730142674;
	bh=adS58VZKpMyBhjeczUuBLAUJ2Kusr9Rs3Sub45oP7p0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g6sZFsC5pT/r2fXHG4MVsLNwZy9pXSuIgzAAh6KE4Mmg+5Q1rLSncWAsBRFO74KsW
	 fwimsUmtBreOT5gT1wofFXBxKMuSdaujOk9vVQZVZdmkkVfdNhxl0EbVImEtlUdAC+
	 Phtp2By4nqqApBjG/PrPBELmbRkALQA4WZg6ylMuwiJ3JgEJ0Kxu6SlDCSAfCPof5d
	 UEb5fFazfPQcLu3nCcfqcjwTieREyhUjc4GMhmxaYBjT0/lz0MyTiKuXxjwiXGOBwN
	 itb+PjP0g+JhJ6SwFzGIUmSJACA/LNMn3eXmDjZts6GYCMg8v3it1DLuqQSnzxuvhI
	 ClLGUi9b1PAjA==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XcjfT3R62zsN5;
	Mon, 28 Oct 2024 15:11:13 -0400 (EDT)
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
	Jordan Rife <jrife@google.com>
Subject: [RFC PATCH v4 2/4] tracing: Introduce tracepoint_is_faultable()
Date: Mon, 28 Oct 2024 15:09:25 -0400
Message-Id: <20241028190927.648953-3-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241028190927.648953-1-mathieu.desnoyers@efficios.com>
References: <20241028190927.648953-1-mathieu.desnoyers@efficios.com>
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
index 83dc24ee8b13..259f0ab4ece6 100644
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
 	struct tracepoint_ext __tracepoint_ext_##_name = {		\
 		.regfunc = _reg,					\
 		.unregfunc = _unreg,					\
+		.faultable = false,					\
+	};								\
+	__DEFINE_TRACE_EXT(_name, &__tracepoint_ext_##_name, PARAMS(_proto), PARAMS(_args));
+
+#define DEFINE_TRACE_SYSCALL(_name, _reg, _unreg, _proto, _args)	\
+	struct tracepoint_ext __tracepoint_ext_##_name = {		\
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


