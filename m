Return-Path: <bpf+bounces-31030-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDAF8D644E
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 16:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C11BA1C24B36
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 14:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C8C1CD3D;
	Fri, 31 May 2024 14:19:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0255223;
	Fri, 31 May 2024 14:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717165143; cv=none; b=PADkoaJ5jTX7LZT3crtv1M5z1xlgQLMYqBTPgjRyiFNHmqdR22JYCRzttYar4Fgg0QQQ4Fc8ikYpiBlTysCuQscouzVZ6uO8igymP7M2s7RkO9rui5hWq+aKTo6Fs/8ZzLxiOCpaxVfBYJDPIDoY4Kqwiadnxdxwh2WjivHWqTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717165143; c=relaxed/simple;
	bh=JT+k5vBla9pCvA+88JA8M/bvAVz/OQ3maxqsiTzy9I8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QDz7FToI/d7vCRxPbU+zcEXMavFJeY5gThula4sv491MqzlOCf+VoruX8ZNuxhqeIydNuJojS6dFlX+BgmzZhqxS7ByxxqYsE0tCbwwv7triyVubCKj0pvGKpmWOx6QG5f6vtYJAo18sHUh51vl1+XJPN+q+cJWTRjGtj4g+Tf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 8C0192F20243; Fri, 31 May 2024 14:18:52 +0000 (UTC)
X-Spam-Level: 
Received: from altlinux.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
	by air.basealt.ru (Postfix) with ESMTPSA id 2C79E2F2023F;
	Fri, 31 May 2024 14:18:52 +0000 (UTC)
From: kovalev@altlinux.org
To: stable@vger.kernel.org
Cc: bpf@vger.kernel.org,
	kovalev@altlinux.org,
	dutyrok@altlinux.org,
	oficerovas@altlinux.org
Subject: [PATCH v2 5.15.y 1/2] bpf: Convert BPF_DISPATCHER to use static_call() (not ftrace)
Date: Fri, 31 May 2024 17:18:45 +0300
Message-Id: <20240531141846.50821-2-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
In-Reply-To: <20240531141846.50821-1-kovalev@altlinux.org>
References: <20240531141846.50821-1-kovalev@altlinux.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit c86df29d11dfba27c0a1f5039cd6fe387fbf4239 ]

The dispatcher function is currently abusing the ftrace __fentry__
call location for its own purposes -- this obviously gives trouble
when the dispatcher and ftrace are both in use.

A previous solution tried using __attribute__((patchable_function_entry()))
which works, except it is GCC-8+ only, breaking the build on the
earlier still supported compilers. Instead use static_call() -- which
has its own annotations and does not conflict with ftrace -- to
rewrite the dispatch function.

By using: return static_call()(ctx, insni, bpf_func) you get a perfect
forwarding tail call as function body (iow a single jmp instruction).
By having the default static_call() target be bpf_dispatcher_nop_func()
it retains the default behaviour (an indirect call to the argument
function). Only once a dispatcher program is attached is the target
rewritten to directly call the JIT'ed image.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Tested-by: Björn Töpel <bjorn@kernel.org>
Tested-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Björn Töpel <bjorn@kernel.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: https://lkml.kernel.org/r/Y1/oBlK0yFk5c/Im@hirez.programming.kicks-ass.net
Link: https://lore.kernel.org/bpf/20221103120647.796772565@infradead.org
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 include/linux/bpf.h     | 39 ++++++++++++++++++++++++++++++++++++++-
 kernel/bpf/dispatcher.c | 22 ++++++++--------------
 2 files changed, 46 insertions(+), 15 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4236de05a8e70..ea75e8ac40a24 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -23,6 +23,7 @@
 #include <linux/slab.h>
 #include <linux/percpu-refcount.h>
 #include <linux/bpfptr.h>
+#include <linux/static_call.h>
 
 struct bpf_verifier_env;
 struct bpf_verifier_log;
@@ -779,6 +780,10 @@ struct bpf_dispatcher {
 	void *image;
 	u32 image_off;
 	struct bpf_ksym ksym;
+#ifdef CONFIG_HAVE_STATIC_CALL
+	struct static_call_key *sc_key;
+	void *sc_tramp;
+#endif
 };
 
 static __always_inline __nocfi unsigned int bpf_dispatcher_nop_func(
@@ -796,6 +801,34 @@ struct bpf_trampoline *bpf_trampoline_get(u64 key,
 					  struct bpf_attach_target_info *tgt_info);
 void bpf_trampoline_put(struct bpf_trampoline *tr);
 int arch_prepare_bpf_dispatcher(void *image, s64 *funcs, int num_funcs);
+
+/*
+ * When the architecture supports STATIC_CALL replace the bpf_dispatcher_fn
+ * indirection with a direct call to the bpf program. If the architecture does
+ * not have STATIC_CALL, avoid a double-indirection.
+ */
+#ifdef CONFIG_HAVE_STATIC_CALL
+
+#define __BPF_DISPATCHER_SC_INIT(_name)				\
+	.sc_key = &STATIC_CALL_KEY(_name),			\
+	.sc_tramp = STATIC_CALL_TRAMP_ADDR(_name),
+
+#define __BPF_DISPATCHER_SC(name)				\
+	DEFINE_STATIC_CALL(bpf_dispatcher_##name##_call, bpf_dispatcher_nop_func)
+
+#define __BPF_DISPATCHER_CALL(name)				\
+	static_call(bpf_dispatcher_##name##_call)(ctx, insnsi, bpf_func)
+
+#define __BPF_DISPATCHER_UPDATE(_d, _new)			\
+	__static_call_update((_d)->sc_key, (_d)->sc_tramp, (_new))
+
+#else
+#define __BPF_DISPATCHER_SC_INIT(name)
+#define __BPF_DISPATCHER_SC(name)
+#define __BPF_DISPATCHER_CALL(name)		bpf_func(ctx, insnsi)
+#define __BPF_DISPATCHER_UPDATE(_d, _new)
+#endif
+
 #define BPF_DISPATCHER_INIT(_name) {				\
 	.mutex = __MUTEX_INITIALIZER(_name.mutex),		\
 	.func = &_name##_func,					\
@@ -807,20 +840,23 @@ int arch_prepare_bpf_dispatcher(void *image, s64 *funcs, int num_funcs);
 		.name  = #_name,				\
 		.lnode = LIST_HEAD_INIT(_name.ksym.lnode),	\
 	},							\
+	__BPF_DISPATCHER_SC_INIT(_name##_call)			\
 }
 
 #define DEFINE_BPF_DISPATCHER(name)					\
+	__BPF_DISPATCHER_SC(name);					\
 	noinline __nocfi unsigned int bpf_dispatcher_##name##_func(	\
 		const void *ctx,					\
 		const struct bpf_insn *insnsi,				\
 		unsigned int (*bpf_func)(const void *,			\
 					 const struct bpf_insn *))	\
 	{								\
-		return bpf_func(ctx, insnsi);				\
+		return __BPF_DISPATCHER_CALL(name);			\
 	}								\
 	EXPORT_SYMBOL(bpf_dispatcher_##name##_func);			\
 	struct bpf_dispatcher bpf_dispatcher_##name =			\
 		BPF_DISPATCHER_INIT(bpf_dispatcher_##name);
+
 #define DECLARE_BPF_DISPATCHER(name)					\
 	unsigned int bpf_dispatcher_##name##_func(			\
 		const void *ctx,					\
@@ -828,6 +864,7 @@ int arch_prepare_bpf_dispatcher(void *image, s64 *funcs, int num_funcs);
 		unsigned int (*bpf_func)(const void *,			\
 					 const struct bpf_insn *));	\
 	extern struct bpf_dispatcher bpf_dispatcher_##name;
+
 #define BPF_DISPATCHER_FUNC(name) bpf_dispatcher_##name##_func
 #define BPF_DISPATCHER_PTR(name) (&bpf_dispatcher_##name)
 void bpf_dispatcher_change_prog(struct bpf_dispatcher *d, struct bpf_prog *from,
diff --git a/kernel/bpf/dispatcher.c b/kernel/bpf/dispatcher.c
index 2444bd15cc2d0..23042cfb5e809 100644
--- a/kernel/bpf/dispatcher.c
+++ b/kernel/bpf/dispatcher.c
@@ -4,6 +4,7 @@
 #include <linux/hash.h>
 #include <linux/bpf.h>
 #include <linux/filter.h>
+#include <linux/static_call.h>
 
 /* The BPF dispatcher is a multiway branch code generator. The
  * dispatcher is a mechanism to avoid the performance penalty of an
@@ -104,17 +105,11 @@ static int bpf_dispatcher_prepare(struct bpf_dispatcher *d, void *image)
 
 static void bpf_dispatcher_update(struct bpf_dispatcher *d, int prev_num_progs)
 {
-	void *old, *new;
-	u32 noff;
-	int err;
-
-	if (!prev_num_progs) {
-		old = NULL;
-		noff = 0;
-	} else {
-		old = d->image + d->image_off;
+	void *new;
+	u32 noff = 0;
+
+	if (prev_num_progs)
 		noff = d->image_off ^ (PAGE_SIZE / 2);
-	}
 
 	new = d->num_progs ? d->image + noff : NULL;
 	if (new) {
@@ -122,11 +117,10 @@ static void bpf_dispatcher_update(struct bpf_dispatcher *d, int prev_num_progs)
 			return;
 	}
 
-	err = bpf_arch_text_poke(d->func, BPF_MOD_JUMP, old, new);
-	if (err || !new)
-		return;
+	__BPF_DISPATCHER_UPDATE(d, new ?: &bpf_dispatcher_nop_func);
 
-	d->image_off = noff;
+	if (new)
+		d->image_off = noff;
 }
 
 void bpf_dispatcher_change_prog(struct bpf_dispatcher *d, struct bpf_prog *from,
-- 
2.33.8


