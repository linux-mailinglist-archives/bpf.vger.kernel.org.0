Return-Path: <bpf+bounces-43717-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBBA9B8F5F
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 11:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2A171C20A86
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 10:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327BD1A4F22;
	Fri,  1 Nov 2024 10:36:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A3419CC3D;
	Fri,  1 Nov 2024 10:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730457369; cv=none; b=Q2dCEUDDdm/lC00ZDm1cs8Lh4QN2HW8eK6NS6PQTY/bN0dg5yPMQZcBjZ3KZqusI22L9nA51U5RhrUSLC+zjp9JS4M3h21nsFX8fKcpD7NQ+x2b+X3immdxLwCzS/nd6898iaSgdalkUKX1QW/OcSbthISE8AfD4g4UMOD6hDLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730457369; c=relaxed/simple;
	bh=drjD33H1A93Y9HA2C7fqgn5h3eLkonWWJtgOmnbJrAg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=M16EG1bCyU+9EOcA19qWG6cqzmADP9HabnDuyhsSfvZX5HigngYK/+QTe7Y1vezj7eAMra1dbZ2VlVpeWaFsFTlue/bLLmzQK1osLv1GTqI7hKhGmsrDUaV2fxqSg9fIB/Yo5aOYTQwPJ4f4dOfWUmHni24yRebv2Ll3m7wF2nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6409C4CED8;
	Fri,  1 Nov 2024 10:36:09 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1t6p1g-00000005S7X-0Hpo;
	Fri, 01 Nov 2024 06:37:08 -0400
Message-ID: <20241101103707.928299599@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 01 Nov 2024 06:36:54 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jordan Rife <jrife@google.com>,
 Michael Jeanson <mjeanson@efficios.com>,
 Thomas Gleixner <tglx@linutronix.de>,
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
 Joel Fernandes <joel@joelfernandes.org>,
 linux-trace-kernel@vger.kernel.org
Subject: [for-next][PATCH 07/11] tracing: Introduce tracepoint extended structure
References: <20241101103647.011707614@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Shrink the struct tracepoint size from 80 bytes to 72 bytes on x86-64 by
moving the (typically NULL) regfunc/unregfunc pointers to an extended
structure.

Tested-by: Jordan Rife <jrife@google.com>
Cc: Michael Jeanson <mjeanson@efficios.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
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
Link: https://lore.kernel.org/20241031152056.744137-2-mathieu.desnoyers@efficios.com
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/tracepoint-defs.h |  8 ++++++--
 include/linux/tracepoint.h      | 19 +++++++++++++------
 kernel/tracepoint.c             |  9 ++++-----
 3 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/include/linux/tracepoint-defs.h b/include/linux/tracepoint-defs.h
index 60a6e8314d4c..967c08d9da84 100644
--- a/include/linux/tracepoint-defs.h
+++ b/include/linux/tracepoint-defs.h
@@ -29,6 +29,11 @@ struct tracepoint_func {
 	int prio;
 };
 
+struct tracepoint_ext {
+	int (*regfunc)(void);
+	void (*unregfunc)(void);
+};
+
 struct tracepoint {
 	const char *name;		/* Tracepoint name */
 	struct static_key_false key;
@@ -36,9 +41,8 @@ struct tracepoint {
 	void *static_call_tramp;
 	void *iterator;
 	void *probestub;
-	int (*regfunc)(void);
-	void (*unregfunc)(void);
 	struct tracepoint_func __rcu *funcs;
+	struct tracepoint_ext *ext;
 };
 
 #ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 0dc67fad706c..862ab49177a4 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -302,7 +302,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
  * structures, so we create an array of pointers that will be used for iteration
  * on the tracepoints.
  */
-#define DEFINE_TRACE_FN(_name, _reg, _unreg, proto, args)		\
+#define __DEFINE_TRACE_EXT(_name, _ext, proto, args)			\
 	static const char __tpstrtab_##_name[]				\
 	__section("__tracepoints_strings") = #_name;			\
 	extern struct static_call_key STATIC_CALL_KEY(tp_func_##_name);	\
@@ -316,9 +316,9 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 		.static_call_tramp = STATIC_CALL_TRAMP_ADDR(tp_func_##_name), \
 		.iterator = &__traceiter_##_name,			\
 		.probestub = &__probestub_##_name,			\
-		.regfunc = _reg,					\
-		.unregfunc = _unreg,					\
-		.funcs = NULL };					\
+		.funcs = NULL,						\
+		.ext = _ext,						\
+	};								\
 	__TRACEPOINT_ENTRY(_name);					\
 	int __traceiter_##_name(void *__data, proto)			\
 	{								\
@@ -341,8 +341,15 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 	}								\
 	DEFINE_STATIC_CALL(tp_func_##_name, __traceiter_##_name);
 
-#define DEFINE_TRACE(name, proto, args)		\
-	DEFINE_TRACE_FN(name, NULL, NULL, PARAMS(proto), PARAMS(args));
+#define DEFINE_TRACE_FN(_name, _reg, _unreg, _proto, _args)		\
+	static struct tracepoint_ext __tracepoint_ext_##_name = {	\
+		.regfunc = _reg,					\
+		.unregfunc = _unreg,					\
+	};								\
+	__DEFINE_TRACE_EXT(_name, &__tracepoint_ext_##_name, PARAMS(_proto), PARAMS(_args));
+
+#define DEFINE_TRACE(_name, _proto, _args)				\
+	__DEFINE_TRACE_EXT(_name, NULL, PARAMS(_proto), PARAMS(_args));
 
 #define EXPORT_TRACEPOINT_SYMBOL_GPL(name)				\
 	EXPORT_SYMBOL_GPL(__tracepoint_##name);				\
diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 6474e2cf22c9..5658dc92f5b5 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -278,8 +278,8 @@ static int tracepoint_add_func(struct tracepoint *tp,
 	struct tracepoint_func *old, *tp_funcs;
 	int ret;
 
-	if (tp->regfunc && !static_key_enabled(&tp->key)) {
-		ret = tp->regfunc();
+	if (tp->ext && tp->ext->regfunc && !static_key_enabled(&tp->key)) {
+		ret = tp->ext->regfunc();
 		if (ret < 0)
 			return ret;
 	}
@@ -362,9 +362,8 @@ static int tracepoint_remove_func(struct tracepoint *tp,
 	switch (nr_func_state(tp_funcs)) {
 	case TP_FUNC_0:		/* 1->0 */
 		/* Removed last function */
-		if (tp->unregfunc && static_key_enabled(&tp->key))
-			tp->unregfunc();
-
+		if (tp->ext && tp->ext->unregfunc && static_key_enabled(&tp->key))
+			tp->ext->unregfunc();
 		static_branch_disable(&tp->key);
 		/* Set iterator static call */
 		tracepoint_update_call(tp, tp_funcs);
-- 
2.45.2



