Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80796635D29
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 13:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237076AbiKWMmm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 07:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236736AbiKWMlz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 07:41:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62376A753;
        Wed, 23 Nov 2022 04:41:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E90BB81F40;
        Wed, 23 Nov 2022 12:41:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3554BC433B5;
        Wed, 23 Nov 2022 12:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669207289;
        bh=w3ngGpxStBi/7HEA93UBxPea0xJCi3aEJB67Ef7ELqk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jMJGr+iWt5XqwRTY7cCPGVlMDqIG31uuE8B5FF7elBiK8zpRZmlviPcbyOImxLfup
         zH7aSWWfvPyAKBlIArnV+teORrhOjXcE/x9O9CuhnbgUqU9AU9wqqpjmM16B8TiYRh
         OApzL2Lr0wQunfUaq3+rNUlfCM3T/XoTSa3B+JTA4Z5J0uI+pl5yjNGfWiuhideUul
         AoVmeRdZGO5qFWjVdbg1o+u+2ASlorOqt7QBAc+G2goQSOe98ckMSDHEpYUlOLBKGK
         ixxOalxhLXIucQQy6YQuVgiQesvfyLkXSzJ3sZYU4834xkRIZAso+Ajbeu0YCk0dZV
         wHThU9ohzSD6w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Sasha Levin <sashal@kernel.org>,
        ast@kernel.org, andrii@kernel.org, bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.0 13/44] bpf: Convert BPF_DISPATCHER to use static_call() (not ftrace)
Date:   Wed, 23 Nov 2022 07:40:22 -0500
Message-Id: <20221123124057.264822-13-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221123124057.264822-1-sashal@kernel.org>
References: <20221123124057.264822-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/bpf.h     | 39 ++++++++++++++++++++++++++++++++++++++-
 kernel/bpf/dispatcher.c | 22 ++++++++--------------
 2 files changed, 46 insertions(+), 15 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 80fc8a88c610..0466aa9cd46c 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -27,6 +27,7 @@
 #include <linux/bpfptr.h>
 #include <linux/btf.h>
 #include <linux/rcupdate_trace.h>
+#include <linux/static_call.h>
 
 struct bpf_verifier_env;
 struct bpf_verifier_log;
@@ -894,6 +895,10 @@ struct bpf_dispatcher {
 	void *rw_image;
 	u32 image_off;
 	struct bpf_ksym ksym;
+#ifdef CONFIG_HAVE_STATIC_CALL
+	struct static_call_key *sc_key;
+	void *sc_tramp;
+#endif
 };
 
 static __always_inline __nocfi unsigned int bpf_dispatcher_nop_func(
@@ -911,6 +916,34 @@ struct bpf_trampoline *bpf_trampoline_get(u64 key,
 					  struct bpf_attach_target_info *tgt_info);
 void bpf_trampoline_put(struct bpf_trampoline *tr);
 int arch_prepare_bpf_dispatcher(void *image, void *buf, s64 *funcs, int num_funcs);
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
@@ -922,25 +955,29 @@ int arch_prepare_bpf_dispatcher(void *image, void *buf, s64 *funcs, int num_func
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
 		bpf_func_t bpf_func)					\
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
 		const struct bpf_insn *insnsi,				\
 		bpf_func_t bpf_func);					\
 	extern struct bpf_dispatcher bpf_dispatcher_##name;
+
 #define BPF_DISPATCHER_FUNC(name) bpf_dispatcher_##name##_func
 #define BPF_DISPATCHER_PTR(name) (&bpf_dispatcher_##name)
 void bpf_dispatcher_change_prog(struct bpf_dispatcher *d, struct bpf_prog *from,
diff --git a/kernel/bpf/dispatcher.c b/kernel/bpf/dispatcher.c
index fa64b80b8bca..7dfb8d0d5202 100644
--- a/kernel/bpf/dispatcher.c
+++ b/kernel/bpf/dispatcher.c
@@ -4,6 +4,7 @@
 #include <linux/hash.h>
 #include <linux/bpf.h>
 #include <linux/filter.h>
+#include <linux/static_call.h>
 
 /* The BPF dispatcher is a multiway branch code generator. The
  * dispatcher is a mechanism to avoid the performance penalty of an
@@ -104,17 +105,11 @@ static int bpf_dispatcher_prepare(struct bpf_dispatcher *d, void *image, void *b
 
 static void bpf_dispatcher_update(struct bpf_dispatcher *d, int prev_num_progs)
 {
-	void *old, *new, *tmp;
-	u32 noff;
-	int err;
-
-	if (!prev_num_progs) {
-		old = NULL;
-		noff = 0;
-	} else {
-		old = d->image + d->image_off;
+	void *new, *tmp;
+	u32 noff = 0;
+
+	if (prev_num_progs)
 		noff = d->image_off ^ (PAGE_SIZE / 2);
-	}
 
 	new = d->num_progs ? d->image + noff : NULL;
 	tmp = d->num_progs ? d->rw_image + noff : NULL;
@@ -128,11 +123,10 @@ static void bpf_dispatcher_update(struct bpf_dispatcher *d, int prev_num_progs)
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
2.35.1

