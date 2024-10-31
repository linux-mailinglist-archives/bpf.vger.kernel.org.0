Return-Path: <bpf+bounces-43648-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 585E69B7E42
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 16:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17650284284
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 15:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415511A3BD7;
	Thu, 31 Oct 2024 15:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="FEgOVD4I"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF4819D88D;
	Thu, 31 Oct 2024 15:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730388160; cv=none; b=I7W5QJg3jMPNniVmcNIrp6ZMoLbvAhdgSWuYOASc9qp27nSTXC7wnbP2LbpAD1zfl3qrlnAz+pgBWzkxIh+0pTAcMfJMmEI8k2xxKoQLWGcIc2jOJVfUaG8FgCe7KWtIhzsdrt5MwB5lpoBe49jPBNNRKexHXmKajrXm3dqajKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730388160; c=relaxed/simple;
	bh=8naxjRh54yOwprdFdMeqgDqAH4UaeTJCrDg/IGHwGN0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Unhov3oL6ZRPzjqLy+KCKYBxzfV7GAW3J8vjMKXo4FonguNbfzYNCe0c7xL7SGTuN/diH3mXRJN4Lsi5zi/cUDUrbgIq8/nPEFUMd2m5XTZBxPac56DeLnIgLG+ZhVTzdZoemif5HoJ2zqQ6F0XTzGPSLDsqpb+Kfc2O4dcmOUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=FEgOVD4I; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1730388157;
	bh=8naxjRh54yOwprdFdMeqgDqAH4UaeTJCrDg/IGHwGN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FEgOVD4IxljO0igYKYLWVQl0e1OAvF7JNzYa8qBR6YuvPO2YCxmc3gccru1Wg+1Wg
	 4pZYreX7icrJ+928CEa1lPuC36+b3/f3/QYGyjM/5dfbn4Wi+4GCiWMWepmmotJlYu
	 8BRDz4jIwx/mGBNglS75S3VsUwejPENx70TJaau4UrFs38ul3UW8CjUKOSXCSYCjuW
	 ljYpqz9QHCfCnEMJppQzxItZR9lu+Q/YbzIZreQo32KXuM+oGX67yDZa4BVK7LfzpI
	 e9BPjoRu4Veg1c2Eq6TanRT9Ilz2k+w7lF644+Vw3BP+z5CubSixl7b2s8K/rp8wRs
	 h+TwiudHEt4zw==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XfSRJ5FxpzYqS;
	Thu, 31 Oct 2024 11:22:36 -0400 (EDT)
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
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v5 resend 1/4] tracing: Introduce tracepoint extended structure
Date: Thu, 31 Oct 2024 11:20:53 -0400
Message-Id: <20241031152056.744137-2-mathieu.desnoyers@efficios.com>
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

Shrink the struct tracepoint size from 80 bytes to 72 bytes on x86-64 by
moving the (typically NULL) regfunc/unregfunc pointers to an extended
structure.

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
- Add static to DEFINE_TRACE_FN.
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
2.39.5


