Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315C160D3D9
	for <lists+bpf@lfdr.de>; Tue, 25 Oct 2022 20:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbiJYSqL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Oct 2022 14:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232870AbiJYSpr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Oct 2022 14:45:47 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8060A5C9EF
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 11:45:40 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1666723539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9FuhshwQrTqxMwkQTOqpwJ/CB7AkoBoJ9v0bD91EobM=;
        b=rrJR68WW2eRYKLMZf1fIloQaeNdiUEFHydbMNH38OslZUPdGKFBsIZkQqGO/8WqW+GqKtm
        TZDphra6yvRRT/XK34E2JTe7KzZkoqIKhcFXOLPo2/fhQGvH2FOOD6wPjXAA6fHb0HdXwL
        KUUKBdq/RsnTSJrZ/PGmjskPnpzmwr0=
From:   Martin KaFai Lau <martin.lau@linux.dev>
To:     bpf@vger.kernel.org
Cc:     'Alexei Starovoitov ' <ast@kernel.org>,
        'Andrii Nakryiko ' <andrii@kernel.org>,
        'Daniel Borkmann ' <daniel@iogearbox.net>,
        'Song Liu ' <songliubraving@meta.com>, kernel-team@meta.com
Subject: [PATCH bpf-next 1/9] bpf: Remove prog->active check for bpf_lsm and bpf_iter
Date:   Tue, 25 Oct 2022 11:45:16 -0700
Message-Id: <20221025184524.3526117-2-martin.lau@linux.dev>
In-Reply-To: <20221025184524.3526117-1-martin.lau@linux.dev>
References: <20221025184524.3526117-1-martin.lau@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Martin KaFai Lau <martin.lau@kernel.org>

The commit 64696c40d03c ("bpf: Add __bpf_prog_{enter,exit}_struct_ops for struct_ops trampoline")
removed prog->active check for struct_ops prog.  The bpf_lsm
and bpf_iter is also using trampoline.  Like struct_ops, the bpf_lsm
and bpf_iter have fixed hooks for the prog to attach.  The
kernel does not call the same hook in a recursive way.
This patch also removes the prog->active check for
bpf_lsm and bpf_iter.

A later patch has a test to reproduce the recursion issue
for a sleepable bpf_lsm program.

This patch appends the '_recur' naming to the existing
enter and exit functions that track the prog->active counter.
New __bpf_prog_{enter,exit}[_sleepable] function are
added to skip the prog->active tracking. The '_struct_ops'
version is also removed.

It also moves the decision on picking the enter and exit function to
the new bpf_trampoline_{enter,exit}().  It returns the '_recur' ones
for all tracing progs to use.  For bpf_lsm, bpf_iter,
struct_ops (no prog->active tracking after 64696c40d03c), and
bpf_lsm_cgroup (no prog->active tracking after 69fd337a975c7),
it will return the functions that don't track the prog->active.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 arch/arm64/net/bpf_jit_comp.c |  9 +---
 arch/x86/net/bpf_jit_comp.c   | 19 +--------
 include/linux/bpf.h           | 24 +++++------
 include/linux/bpf_verifier.h  | 15 ++++++-
 kernel/bpf/syscall.c          |  5 ++-
 kernel/bpf/trampoline.c       | 80 +++++++++++++++++++++++++++++------
 6 files changed, 98 insertions(+), 54 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 30f76178608b..62f805f427b7 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1649,13 +1649,8 @@ static void invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_link *l,
 	struct bpf_prog *p = l->link.prog;
 	int cookie_off = offsetof(struct bpf_tramp_run_ctx, bpf_cookie);
 
-	if (p->aux->sleepable) {
-		enter_prog = (u64)__bpf_prog_enter_sleepable;
-		exit_prog = (u64)__bpf_prog_exit_sleepable;
-	} else {
-		enter_prog = (u64)__bpf_prog_enter;
-		exit_prog = (u64)__bpf_prog_exit;
-	}
+	enter_prog = (u64)bpf_trampoline_enter(p);
+	exit_prog = (u64)bpf_trampoline_exit(p);
 
 	if (l->cookie == 0) {
 		/* if cookie is zero, one instruction is enough to store it */
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index d7dd8e0db8da..36ffe67ad6e5 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1894,10 +1894,6 @@ static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
 			   struct bpf_tramp_link *l, int stack_size,
 			   int run_ctx_off, bool save_ret)
 {
-	void (*exit)(struct bpf_prog *prog, u64 start,
-		     struct bpf_tramp_run_ctx *run_ctx) = __bpf_prog_exit;
-	u64 (*enter)(struct bpf_prog *prog,
-		     struct bpf_tramp_run_ctx *run_ctx) = __bpf_prog_enter;
 	u8 *prog = *pprog;
 	u8 *jmp_insn;
 	int ctx_cookie_off = offsetof(struct bpf_tramp_run_ctx, bpf_cookie);
@@ -1916,23 +1912,12 @@ static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
 	 */
 	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_1, -run_ctx_off + ctx_cookie_off);
 
-	if (p->aux->sleepable) {
-		enter = __bpf_prog_enter_sleepable;
-		exit = __bpf_prog_exit_sleepable;
-	} else if (p->type == BPF_PROG_TYPE_STRUCT_OPS) {
-		enter = __bpf_prog_enter_struct_ops;
-		exit = __bpf_prog_exit_struct_ops;
-	} else if (p->expected_attach_type == BPF_LSM_CGROUP) {
-		enter = __bpf_prog_enter_lsm_cgroup;
-		exit = __bpf_prog_exit_lsm_cgroup;
-	}
-
 	/* arg1: mov rdi, progs[i] */
 	emit_mov_imm64(&prog, BPF_REG_1, (long) p >> 32, (u32) (long) p);
 	/* arg2: lea rsi, [rbp - ctx_cookie_off] */
 	EMIT4(0x48, 0x8D, 0x75, -run_ctx_off);
 
-	if (emit_call(&prog, enter, prog))
+	if (emit_call(&prog, bpf_trampoline_enter(p), prog))
 		return -EINVAL;
 	/* remember prog start time returned by __bpf_prog_enter */
 	emit_mov_reg(&prog, true, BPF_REG_6, BPF_REG_0);
@@ -1977,7 +1962,7 @@ static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
 	emit_mov_reg(&prog, true, BPF_REG_2, BPF_REG_6);
 	/* arg3: lea rdx, [rbp - run_ctx_off] */
 	EMIT4(0x48, 0x8D, 0x55, -run_ctx_off);
-	if (emit_call(&prog, exit, prog))
+	if (emit_call(&prog, bpf_trampoline_exit(p), prog))
 		return -EINVAL;
 
 	*pprog = prog;
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 9e7d46d16032..1279e699dc98 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -854,22 +854,18 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *tr, void *image, void *i
 				const struct btf_func_model *m, u32 flags,
 				struct bpf_tramp_links *tlinks,
 				void *orig_call);
-/* these two functions are called from generated trampoline */
-u64 notrace __bpf_prog_enter(struct bpf_prog *prog, struct bpf_tramp_run_ctx *run_ctx);
-void notrace __bpf_prog_exit(struct bpf_prog *prog, u64 start, struct bpf_tramp_run_ctx *run_ctx);
-u64 notrace __bpf_prog_enter_sleepable(struct bpf_prog *prog, struct bpf_tramp_run_ctx *run_ctx);
-void notrace __bpf_prog_exit_sleepable(struct bpf_prog *prog, u64 start,
-				       struct bpf_tramp_run_ctx *run_ctx);
-u64 notrace __bpf_prog_enter_lsm_cgroup(struct bpf_prog *prog,
-					struct bpf_tramp_run_ctx *run_ctx);
-void notrace __bpf_prog_exit_lsm_cgroup(struct bpf_prog *prog, u64 start,
-					struct bpf_tramp_run_ctx *run_ctx);
-u64 notrace __bpf_prog_enter_struct_ops(struct bpf_prog *prog,
-					struct bpf_tramp_run_ctx *run_ctx);
-void notrace __bpf_prog_exit_struct_ops(struct bpf_prog *prog, u64 start,
-					struct bpf_tramp_run_ctx *run_ctx);
+u64 notrace __bpf_prog_enter_sleepable_recur(struct bpf_prog *prog,
+					     struct bpf_tramp_run_ctx *run_ctx);
+void notrace __bpf_prog_exit_sleepable_recur(struct bpf_prog *prog, u64 start,
+					     struct bpf_tramp_run_ctx *run_ctx);
 void notrace __bpf_tramp_enter(struct bpf_tramp_image *tr);
 void notrace __bpf_tramp_exit(struct bpf_tramp_image *tr);
+typedef u64 (*bpf_trampoline_enter_t)(struct bpf_prog *prog,
+				      struct bpf_tramp_run_ctx *run_ctx);
+typedef void (*bpf_trampoline_exit_t)(struct bpf_prog *prog, u64 start,
+				      struct bpf_tramp_run_ctx *run_ctx);
+bpf_trampoline_enter_t bpf_trampoline_enter(const struct bpf_prog *prog);
+bpf_trampoline_exit_t bpf_trampoline_exit(const struct bpf_prog *prog);
 
 struct bpf_ksym {
 	unsigned long		 start;
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 9e1e6965f407..1a32baa78ce2 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -642,10 +642,23 @@ static inline u32 type_flag(u32 type)
 }
 
 /* only use after check_attach_btf_id() */
-static inline enum bpf_prog_type resolve_prog_type(struct bpf_prog *prog)
+static inline enum bpf_prog_type resolve_prog_type(const struct bpf_prog *prog)
 {
 	return prog->type == BPF_PROG_TYPE_EXT ?
 		prog->aux->dst_prog->type : prog->type;
 }
 
+static inline bool bpf_prog_check_recur(const struct bpf_prog *prog)
+{
+	switch (resolve_prog_type(prog)) {
+	case BPF_PROG_TYPE_TRACING:
+		return prog->expected_attach_type != BPF_TRACE_ITER;
+	case BPF_PROG_TYPE_STRUCT_OPS:
+	case BPF_PROG_TYPE_LSM:
+		return false;
+	default:
+		return true;
+	}
+}
+
 #endif /* _LINUX_BPF_VERIFIER_H */
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 7b373a5e861f..a0b4266196a8 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5133,13 +5133,14 @@ int kern_sys_bpf(int cmd, union bpf_attr *attr, unsigned int size)
 
 		run_ctx.bpf_cookie = 0;
 		run_ctx.saved_run_ctx = NULL;
-		if (!__bpf_prog_enter_sleepable(prog, &run_ctx)) {
+		if (!__bpf_prog_enter_sleepable_recur(prog, &run_ctx)) {
 			/* recursion detected */
 			bpf_prog_put(prog);
 			return -EBUSY;
 		}
 		attr->test.retval = bpf_prog_run(prog, (void *) (long) attr->test.ctx_in);
-		__bpf_prog_exit_sleepable(prog, 0 /* bpf_prog_run does runtime stats */, &run_ctx);
+		__bpf_prog_exit_sleepable_recur(prog, 0 /* bpf_prog_run does runtime stats */,
+						&run_ctx);
 		bpf_prog_put(prog);
 		return 0;
 #endif
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index bf0906e1e2b9..d6395215b849 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -864,7 +864,7 @@ static __always_inline u64 notrace bpf_prog_start_time(void)
  * [2..MAX_U64] - execute bpf prog and record execution time.
  *     This is start time.
  */
-u64 notrace __bpf_prog_enter(struct bpf_prog *prog, struct bpf_tramp_run_ctx *run_ctx)
+static u64 notrace __bpf_prog_enter_recur(struct bpf_prog *prog, struct bpf_tramp_run_ctx *run_ctx)
 	__acquires(RCU)
 {
 	rcu_read_lock();
@@ -901,7 +901,8 @@ static void notrace update_prog_stats(struct bpf_prog *prog,
 	}
 }
 
-void notrace __bpf_prog_exit(struct bpf_prog *prog, u64 start, struct bpf_tramp_run_ctx *run_ctx)
+static void notrace __bpf_prog_exit_recur(struct bpf_prog *prog, u64 start,
+					  struct bpf_tramp_run_ctx *run_ctx)
 	__releases(RCU)
 {
 	bpf_reset_run_ctx(run_ctx->saved_run_ctx);
@@ -912,8 +913,8 @@ void notrace __bpf_prog_exit(struct bpf_prog *prog, u64 start, struct bpf_tramp_
 	rcu_read_unlock();
 }
 
-u64 notrace __bpf_prog_enter_lsm_cgroup(struct bpf_prog *prog,
-					struct bpf_tramp_run_ctx *run_ctx)
+static u64 notrace __bpf_prog_enter_lsm_cgroup(struct bpf_prog *prog,
+					       struct bpf_tramp_run_ctx *run_ctx)
 	__acquires(RCU)
 {
 	/* Runtime stats are exported via actual BPF_LSM_CGROUP
@@ -927,8 +928,8 @@ u64 notrace __bpf_prog_enter_lsm_cgroup(struct bpf_prog *prog,
 	return NO_START_TIME;
 }
 
-void notrace __bpf_prog_exit_lsm_cgroup(struct bpf_prog *prog, u64 start,
-					struct bpf_tramp_run_ctx *run_ctx)
+static void notrace __bpf_prog_exit_lsm_cgroup(struct bpf_prog *prog, u64 start,
+					       struct bpf_tramp_run_ctx *run_ctx)
 	__releases(RCU)
 {
 	bpf_reset_run_ctx(run_ctx->saved_run_ctx);
@@ -937,7 +938,8 @@ void notrace __bpf_prog_exit_lsm_cgroup(struct bpf_prog *prog, u64 start,
 	rcu_read_unlock();
 }
 
-u64 notrace __bpf_prog_enter_sleepable(struct bpf_prog *prog, struct bpf_tramp_run_ctx *run_ctx)
+u64 notrace __bpf_prog_enter_sleepable_recur(struct bpf_prog *prog,
+					     struct bpf_tramp_run_ctx *run_ctx)
 {
 	rcu_read_lock_trace();
 	migrate_disable();
@@ -953,8 +955,8 @@ u64 notrace __bpf_prog_enter_sleepable(struct bpf_prog *prog, struct bpf_tramp_r
 	return bpf_prog_start_time();
 }
 
-void notrace __bpf_prog_exit_sleepable(struct bpf_prog *prog, u64 start,
-				       struct bpf_tramp_run_ctx *run_ctx)
+void notrace __bpf_prog_exit_sleepable_recur(struct bpf_prog *prog, u64 start,
+					     struct bpf_tramp_run_ctx *run_ctx)
 {
 	bpf_reset_run_ctx(run_ctx->saved_run_ctx);
 
@@ -964,8 +966,30 @@ void notrace __bpf_prog_exit_sleepable(struct bpf_prog *prog, u64 start,
 	rcu_read_unlock_trace();
 }
 
-u64 notrace __bpf_prog_enter_struct_ops(struct bpf_prog *prog,
-					struct bpf_tramp_run_ctx *run_ctx)
+static u64 notrace __bpf_prog_enter_sleepable(struct bpf_prog *prog,
+					      struct bpf_tramp_run_ctx *run_ctx)
+{
+	rcu_read_lock_trace();
+	migrate_disable();
+	might_fault();
+
+	run_ctx->saved_run_ctx = bpf_set_run_ctx(&run_ctx->run_ctx);
+
+	return bpf_prog_start_time();
+}
+
+static void notrace __bpf_prog_exit_sleepable(struct bpf_prog *prog, u64 start,
+					      struct bpf_tramp_run_ctx *run_ctx)
+{
+	bpf_reset_run_ctx(run_ctx->saved_run_ctx);
+
+	update_prog_stats(prog, start);
+	migrate_enable();
+	rcu_read_unlock_trace();
+}
+
+static u64 notrace __bpf_prog_enter(struct bpf_prog *prog,
+				    struct bpf_tramp_run_ctx *run_ctx)
 	__acquires(RCU)
 {
 	rcu_read_lock();
@@ -976,8 +1000,8 @@ u64 notrace __bpf_prog_enter_struct_ops(struct bpf_prog *prog,
 	return bpf_prog_start_time();
 }
 
-void notrace __bpf_prog_exit_struct_ops(struct bpf_prog *prog, u64 start,
-					struct bpf_tramp_run_ctx *run_ctx)
+static void notrace __bpf_prog_exit(struct bpf_prog *prog, u64 start,
+				    struct bpf_tramp_run_ctx *run_ctx)
 	__releases(RCU)
 {
 	bpf_reset_run_ctx(run_ctx->saved_run_ctx);
@@ -997,6 +1021,36 @@ void notrace __bpf_tramp_exit(struct bpf_tramp_image *tr)
 	percpu_ref_put(&tr->pcref);
 }
 
+bpf_trampoline_enter_t bpf_trampoline_enter(const struct bpf_prog *prog)
+{
+	bool sleepable = prog->aux->sleepable;
+
+	if (bpf_prog_check_recur(prog))
+		return sleepable ? __bpf_prog_enter_sleepable_recur :
+			__bpf_prog_enter_recur;
+
+	if (resolve_prog_type(prog) == BPF_PROG_TYPE_LSM &&
+	    prog->expected_attach_type == BPF_LSM_CGROUP)
+		return __bpf_prog_enter_lsm_cgroup;
+
+	return sleepable ? __bpf_prog_enter_sleepable : __bpf_prog_enter;
+}
+
+bpf_trampoline_exit_t bpf_trampoline_exit(const struct bpf_prog *prog)
+{
+	bool sleepable = prog->aux->sleepable;
+
+	if (bpf_prog_check_recur(prog))
+		return sleepable ? __bpf_prog_exit_sleepable_recur :
+			__bpf_prog_exit_recur;
+
+	if (resolve_prog_type(prog) == BPF_PROG_TYPE_LSM &&
+	    prog->expected_attach_type == BPF_LSM_CGROUP)
+		return __bpf_prog_exit_lsm_cgroup;
+
+	return sleepable ? __bpf_prog_exit_sleepable : __bpf_prog_exit;
+}
+
 int __weak
 arch_prepare_bpf_trampoline(struct bpf_tramp_image *tr, void *image, void *image_end,
 			    const struct btf_func_model *m, u32 flags,
-- 
2.30.2

