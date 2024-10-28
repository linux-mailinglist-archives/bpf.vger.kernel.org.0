Return-Path: <bpf+bounces-43323-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9B59B3A30
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 20:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69210282D77
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 19:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E781E0DA7;
	Mon, 28 Oct 2024 19:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Z35fHnfR"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727A71DED5D;
	Mon, 28 Oct 2024 19:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730142677; cv=none; b=k0dF7ZiuYHAIxi6rueHh3LWxa8OKmsUdhMNjZ0KjfJzYFP/KC2GbEVOEu/4uMrhUOMLfx8eq+bJr/eesHIXlhe5neSy8nuu9lhNAoopt0iiduUXe7Q+W5HGUmFEr34wvC75iaGNWbVvzVLWwBhkP8cDeTxNud7tvENhEu15kVA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730142677; c=relaxed/simple;
	bh=Vl+dJW1dLHWdx44iF4qkzr4xppHjV8IF1v86QpLfsa4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D6CA0HFzhbXmqZQKY0jYl5n6zxV2i3+vAylzXHxfwmdLMVv0thRozfWmet38mRwTA2Ay+sHDmQ2jI14aLcjCbjHj4Dj7V/ADiK+QwDbWHRkoxHfwQltl83GElo+nE4EV8oRopG9U6spG871qQd0mwY9SBleLMWrVDvsg0ETfwhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Z35fHnfR; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1730142673;
	bh=Vl+dJW1dLHWdx44iF4qkzr4xppHjV8IF1v86QpLfsa4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z35fHnfR6Jpwz5ma/weSFzXpLqbOyazbXw45RAlxAtyBAql1nIDl5HbNKGzKcBzP2
	 6S3tSo3uFolDRCNtBwkuW57mTqiA5ApfC0OUlxuAkzIlUqpD60SQpXZw1eAfmAbqIK
	 9aR0hOYVJrhiA6ZcHws1f4/5IR9zQ0K6kOViFu/nGV58V5Q+LV6CXEmWrYWRYDeOz4
	 H2Xxan9fWoqs4VcIon7GLMpPGMxTz0CbyJ6o8xWcPRL4Z49UcLMWxF6o5RoJcywoP4
	 gmUpIeGznWcwN6TPpkabbCVkZv+qg/8lRR0X79O8t06SC/2QXyArFYX5HbrB2IeQfK
	 yaZlhg7v6/F9g==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XcjfS2p2Zzs19;
	Mon, 28 Oct 2024 15:11:12 -0400 (EDT)
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
Subject: [RFC PATCH v4 1/4] tracing: Introduce tracepoint extended structure
Date: Mon, 28 Oct 2024 15:09:24 -0400
Message-Id: <20241028190927.648953-2-mathieu.desnoyers@efficios.com>
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

Shrink the struct tracepoint size from 80 bytes to 72 bytes on x86-64 by
moving the (typically NULL) regfunc/unregfunc pointers to an extended
structure.

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
index 0dc67fad706c..83dc24ee8b13 100644
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
+	struct tracepoint_ext __tracepoint_ext_##_name = {		\
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


