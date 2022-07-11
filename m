Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154E457066A
	for <lists+bpf@lfdr.de>; Mon, 11 Jul 2022 16:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbiGKO7W (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Jul 2022 10:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbiGKO7V (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Jul 2022 10:59:21 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4EE5C973;
        Mon, 11 Jul 2022 07:59:19 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LhRnh2ZK6zlVvr;
        Mon, 11 Jul 2022 22:57:44 +0800 (CST)
Received: from huawei.com (10.67.174.197) by kwepemi500013.china.huawei.com
 (7.221.188.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 11 Jul
 2022 22:59:16 +0800
From:   Xu Kuohai <xukuohai@huawei.com>
To:     <bpf@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Will Deacon <will@kernel.org>, KP Singh <kpsingh@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Zi Shen Lim <zlim.lnx@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        James Morse <james.morse@arm.com>,
        Hou Tao <houtao1@huawei.com>,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH bpf-next v9 4/4] bpf, arm64: bpf trampoline for arm64
Date:   Mon, 11 Jul 2022 11:08:23 -0400
Message-ID: <20220711150823.2128542-5-xukuohai@huawei.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220711150823.2128542-1-xukuohai@huawei.com>
References: <20220711150823.2128542-1-xukuohai@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.197]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is arm64 version of commit fec56f5890d9 ("bpf: Introduce BPF
trampoline"). A bpf trampoline converts native calling convention to bpf
calling convention and is used to implement various bpf features, such
as fentry, fexit, fmod_ret and struct_ops.

This patch does essentially the same thing that bpf trampoline does on x86.

Tested on raspberry pi 4b and qemu:

 #18 /1     bpf_tcp_ca/dctcp:OK
 #18 /2     bpf_tcp_ca/cubic:OK
 #18 /3     bpf_tcp_ca/invalid_license:OK
 #18 /4     bpf_tcp_ca/dctcp_fallback:OK
 #18 /5     bpf_tcp_ca/rel_setsockopt:OK
 #18        bpf_tcp_ca:OK
 #51 /1     dummy_st_ops/dummy_st_ops_attach:OK
 #51 /2     dummy_st_ops/dummy_init_ret_value:OK
 #51 /3     dummy_st_ops/dummy_init_ptr_arg:OK
 #51 /4     dummy_st_ops/dummy_multiple_args:OK
 #51        dummy_st_ops:OK
 #57 /1     fexit_bpf2bpf/target_no_callees:OK
 #57 /2     fexit_bpf2bpf/target_yes_callees:OK
 #57 /3     fexit_bpf2bpf/func_replace:OK
 #57 /4     fexit_bpf2bpf/func_replace_verify:OK
 #57 /5     fexit_bpf2bpf/func_sockmap_update:OK
 #57 /6     fexit_bpf2bpf/func_replace_return_code:OK
 #57 /7     fexit_bpf2bpf/func_map_prog_compatibility:OK
 #57 /8     fexit_bpf2bpf/func_replace_multi:OK
 #57 /9     fexit_bpf2bpf/fmod_ret_freplace:OK
 #57        fexit_bpf2bpf:OK
 #237       xdp_bpf2bpf:OK

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
Acked-by: Song Liu <songliubraving@fb.com>
Acked-by: KP Singh <kpsingh@kernel.org>
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 arch/arm64/net/bpf_jit_comp.c | 385 +++++++++++++++++++++++++++++++++-
 1 file changed, 382 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 0ef35ec30d4e..fd1cb0d2aaa6 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -176,6 +176,14 @@ static inline void emit_addr_mov_i64(const int reg, const u64 val,
 	}
 }
 
+static inline void emit_call(u64 target, struct jit_ctx *ctx)
+{
+	u8 tmp = bpf2a64[TMP_REG_1];
+
+	emit_addr_mov_i64(tmp, target, ctx);
+	emit(A64_BLR(tmp), ctx);
+}
+
 static inline int bpf2a64_offset(int bpf_insn, int off,
 				 const struct jit_ctx *ctx)
 {
@@ -1072,8 +1080,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 					    &func_addr, &func_addr_fixed);
 		if (ret < 0)
 			return ret;
-		emit_addr_mov_i64(tmp, func_addr, ctx);
-		emit(A64_BLR(tmp), ctx);
+		emit_call(func_addr, ctx);
 		emit(A64_MOV(1, r0, A64_R(0)), ctx);
 		break;
 	}
@@ -1417,6 +1424,13 @@ static int validate_code(struct jit_ctx *ctx)
 		if (a64_insn == AARCH64_BREAK_FAULT)
 			return -1;
 	}
+	return 0;
+}
+
+static int validate_ctx(struct jit_ctx *ctx)
+{
+	if (validate_code(ctx))
+		return -1;
 
 	if (WARN_ON_ONCE(ctx->exentry_idx != ctx->prog->aux->num_exentries))
 		return -1;
@@ -1546,7 +1560,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	build_plt(&ctx);
 
 	/* 3. Extra pass to validate JITed code. */
-	if (validate_code(&ctx)) {
+	if (validate_ctx(&ctx)) {
 		bpf_jit_binary_free(header);
 		prog = orig_prog;
 		goto out_off;
@@ -1624,6 +1638,371 @@ bool bpf_jit_supports_subprog_tailcalls(void)
 	return true;
 }
 
+static void invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_link *l,
+			    int args_off, int retval_off, int run_ctx_off,
+			    bool save_ret)
+{
+	u32 *branch;
+	u64 enter_prog;
+	u64 exit_prog;
+	struct bpf_prog *p = l->link.prog;
+	int cookie_off = offsetof(struct bpf_tramp_run_ctx, bpf_cookie);
+
+	if (p->aux->sleepable) {
+		enter_prog = (u64)__bpf_prog_enter_sleepable;
+		exit_prog = (u64)__bpf_prog_exit_sleepable;
+	} else {
+		enter_prog = (u64)__bpf_prog_enter;
+		exit_prog = (u64)__bpf_prog_exit;
+	}
+
+	if (l->cookie == 0) {
+		/* if cookie is zero, one instruction is enough to store it */
+		emit(A64_STR64I(A64_ZR, A64_SP, run_ctx_off + cookie_off), ctx);
+	} else {
+		emit_a64_mov_i64(A64_R(10), l->cookie, ctx);
+		emit(A64_STR64I(A64_R(10), A64_SP, run_ctx_off + cookie_off),
+		     ctx);
+	}
+
+	/* save p to callee saved register x19 to avoid loading p with mov_i64
+	 * each time.
+	 */
+	emit_addr_mov_i64(A64_R(19), (const u64)p, ctx);
+
+	/* arg1: prog */
+	emit(A64_MOV(1, A64_R(0), A64_R(19)), ctx);
+	/* arg2: &run_ctx */
+	emit(A64_ADD_I(1, A64_R(1), A64_SP, run_ctx_off), ctx);
+
+	emit_call(enter_prog, ctx);
+
+	/* if (__bpf_prog_enter(prog) == 0)
+	 *         goto skip_exec_of_prog;
+	 */
+	branch = ctx->image + ctx->idx;
+	emit(A64_NOP, ctx);
+
+	/* save return value to callee saved register x20 */
+	emit(A64_MOV(1, A64_R(20), A64_R(0)), ctx);
+
+	emit(A64_ADD_I(1, A64_R(0), A64_SP, args_off), ctx);
+	if (!p->jited)
+		emit_addr_mov_i64(A64_R(1), (const u64)p->insnsi, ctx);
+
+	emit_call((const u64)p->bpf_func, ctx);
+
+	if (save_ret)
+		emit(A64_STR64I(A64_R(0), A64_SP, retval_off), ctx);
+
+	if (ctx->image) {
+		int offset = &ctx->image[ctx->idx] - branch;
+		*branch = A64_CBZ(1, A64_R(0), offset);
+	}
+
+	/* arg1: prog */
+	emit(A64_MOV(1, A64_R(0), A64_R(19)), ctx);
+	/* arg2: start time */
+	emit(A64_MOV(1, A64_R(1), A64_R(20)), ctx);
+	/* arg3: &run_ctx */
+	emit(A64_ADD_I(1, A64_R(2), A64_SP, run_ctx_off), ctx);
+
+	emit_call(exit_prog, ctx);
+}
+
+static void invoke_bpf_mod_ret(struct jit_ctx *ctx, struct bpf_tramp_links *tl,
+			       int args_off, int retval_off, int run_ctx_off,
+			       u32 **branches)
+{
+	int i;
+
+	/* The first fmod_ret program will receive a garbage return value.
+	 * Set this to 0 to avoid confusing the program.
+	 */
+	emit(A64_STR64I(A64_ZR, A64_SP, retval_off), ctx);
+	for (i = 0; i < tl->nr_links; i++) {
+		invoke_bpf_prog(ctx, tl->links[i], args_off, retval_off,
+				run_ctx_off, true);
+		/* if (*(u64 *)(sp + retval_off) !=  0)
+		 *	goto do_fexit;
+		 */
+		emit(A64_LDR64I(A64_R(10), A64_SP, retval_off), ctx);
+		/* Save the location of branch, and generate a nop.
+		 * This nop will be replaced with a cbnz later.
+		 */
+		branches[i] = ctx->image + ctx->idx;
+		emit(A64_NOP, ctx);
+	}
+}
+
+static void save_args(struct jit_ctx *ctx, int args_off, int nargs)
+{
+	int i;
+
+	for (i = 0; i < nargs; i++) {
+		emit(A64_STR64I(i, A64_SP, args_off), ctx);
+		args_off += 8;
+	}
+}
+
+static void restore_args(struct jit_ctx *ctx, int args_off, int nargs)
+{
+	int i;
+
+	for (i = 0; i < nargs; i++) {
+		emit(A64_LDR64I(i, A64_SP, args_off), ctx);
+		args_off += 8;
+	}
+}
+
+/* Based on the x86's implementation of arch_prepare_bpf_trampoline().
+ *
+ * bpf prog and function entry before bpf trampoline hooked:
+ *   mov x9, lr
+ *   nop
+ *
+ * bpf prog and function entry after bpf trampoline hooked:
+ *   mov x9, lr
+ *   bl  <bpf_trampoline or plt>
+ *
+ */
+static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
+			      struct bpf_tramp_links *tlinks, void *orig_call,
+			      int nargs, u32 flags)
+{
+	int i;
+	int stack_size;
+	int retaddr_off;
+	int regs_off;
+	int retval_off;
+	int args_off;
+	int nargs_off;
+	int ip_off;
+	int run_ctx_off;
+	struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
+	struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
+	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
+	bool save_ret;
+	u32 **branches = NULL;
+
+	/* trampoline stack layout:
+	 *                  [ parent ip         ]
+	 *                  [ FP                ]
+	 * SP + retaddr_off [ self ip           ]
+	 *                  [ FP                ]
+	 *
+	 *                  [ padding           ] align SP to multiples of 16
+	 *
+	 *                  [ x20               ] callee saved reg x20
+	 * SP + regs_off    [ x19               ] callee saved reg x19
+	 *
+	 * SP + retval_off  [ return value      ] BPF_TRAMP_F_CALL_ORIG or
+	 *                                        BPF_TRAMP_F_RET_FENTRY_RET
+	 *
+	 *                  [ argN              ]
+	 *                  [ ...               ]
+	 * SP + args_off    [ arg1              ]
+	 *
+	 * SP + nargs_off   [ args count        ]
+	 *
+	 * SP + ip_off      [ traced function   ] BPF_TRAMP_F_IP_ARG flag
+	 *
+	 * SP + run_ctx_off [ bpf_tramp_run_ctx ]
+	 */
+
+	stack_size = 0;
+	run_ctx_off = stack_size;
+	/* room for bpf_tramp_run_ctx */
+	stack_size += round_up(sizeof(struct bpf_tramp_run_ctx), 8);
+
+	ip_off = stack_size;
+	/* room for IP address argument */
+	if (flags & BPF_TRAMP_F_IP_ARG)
+		stack_size += 8;
+
+	nargs_off = stack_size;
+	/* room for args count */
+	stack_size += 8;
+
+	args_off = stack_size;
+	/* room for args */
+	stack_size += nargs * 8;
+
+	/* room for return value */
+	retval_off = stack_size;
+	save_ret = flags & (BPF_TRAMP_F_CALL_ORIG | BPF_TRAMP_F_RET_FENTRY_RET);
+	if (save_ret)
+		stack_size += 8;
+
+	/* room for callee saved registers, currently x19 and x20 are used */
+	regs_off = stack_size;
+	stack_size += 16;
+
+	/* round up to multiples of 16 to avoid SPAlignmentFault */
+	stack_size = round_up(stack_size, 16);
+
+	/* return address locates above FP */
+	retaddr_off = stack_size + 8;
+
+	/* bpf trampoline may be invoked by 3 instruction types:
+	 * 1. bl, attached to bpf prog or kernel function via short jump
+	 * 2. br, attached to bpf prog or kernel function via long jump
+	 * 3. blr, working as a function pointer, used by struct_ops.
+	 * So BTI_JC should used here to support both br and blr.
+	 */
+	emit_bti(A64_BTI_JC, ctx);
+
+	/* frame for parent function */
+	emit(A64_PUSH(A64_FP, A64_R(9), A64_SP), ctx);
+	emit(A64_MOV(1, A64_FP, A64_SP), ctx);
+
+	/* frame for patched function */
+	emit(A64_PUSH(A64_FP, A64_LR, A64_SP), ctx);
+	emit(A64_MOV(1, A64_FP, A64_SP), ctx);
+
+	/* allocate stack space */
+	emit(A64_SUB_I(1, A64_SP, A64_SP, stack_size), ctx);
+
+	if (flags & BPF_TRAMP_F_IP_ARG) {
+		/* save ip address of the traced function */
+		emit_addr_mov_i64(A64_R(10), (const u64)orig_call, ctx);
+		emit(A64_STR64I(A64_R(10), A64_SP, ip_off), ctx);
+	}
+
+	/* save args count*/
+	emit(A64_MOVZ(1, A64_R(10), nargs, 0), ctx);
+	emit(A64_STR64I(A64_R(10), A64_SP, nargs_off), ctx);
+
+	/* save args */
+	save_args(ctx, args_off, nargs);
+
+	/* save callee saved registers */
+	emit(A64_STR64I(A64_R(19), A64_SP, regs_off), ctx);
+	emit(A64_STR64I(A64_R(20), A64_SP, regs_off + 8), ctx);
+
+	if (flags & BPF_TRAMP_F_CALL_ORIG) {
+		emit_addr_mov_i64(A64_R(0), (const u64)im, ctx);
+		emit_call((const u64)__bpf_tramp_enter, ctx);
+	}
+
+	for (i = 0; i < fentry->nr_links; i++)
+		invoke_bpf_prog(ctx, fentry->links[i], args_off,
+				retval_off, run_ctx_off,
+				flags & BPF_TRAMP_F_RET_FENTRY_RET);
+
+	if (fmod_ret->nr_links) {
+		branches = kcalloc(fmod_ret->nr_links, sizeof(u32 *),
+				   GFP_KERNEL);
+		if (!branches)
+			return -ENOMEM;
+
+		invoke_bpf_mod_ret(ctx, fmod_ret, args_off, retval_off,
+				   run_ctx_off, branches);
+	}
+
+	if (flags & BPF_TRAMP_F_CALL_ORIG) {
+		restore_args(ctx, args_off, nargs);
+		/* call original func */
+		emit(A64_LDR64I(A64_R(10), A64_SP, retaddr_off), ctx);
+		emit(A64_BLR(A64_R(10)), ctx);
+		/* store return value */
+		emit(A64_STR64I(A64_R(0), A64_SP, retval_off), ctx);
+		/* reserve a nop for bpf_tramp_image_put */
+		im->ip_after_call = ctx->image + ctx->idx;
+		emit(A64_NOP, ctx);
+	}
+
+	/* update the branches saved in invoke_bpf_mod_ret with cbnz */
+	for (i = 0; i < fmod_ret->nr_links && ctx->image != NULL; i++) {
+		int offset = &ctx->image[ctx->idx] - branches[i];
+		*branches[i] = A64_CBNZ(1, A64_R(10), offset);
+	}
+
+	for (i = 0; i < fexit->nr_links; i++)
+		invoke_bpf_prog(ctx, fexit->links[i], args_off, retval_off,
+				run_ctx_off, false);
+
+	if (flags & BPF_TRAMP_F_CALL_ORIG) {
+		im->ip_epilogue = ctx->image + ctx->idx;
+		emit_addr_mov_i64(A64_R(0), (const u64)im, ctx);
+		emit_call((const u64)__bpf_tramp_exit, ctx);
+	}
+
+	if (flags & BPF_TRAMP_F_RESTORE_REGS)
+		restore_args(ctx, args_off, nargs);
+
+	/* restore callee saved register x19 and x20 */
+	emit(A64_LDR64I(A64_R(19), A64_SP, regs_off), ctx);
+	emit(A64_LDR64I(A64_R(20), A64_SP, regs_off + 8), ctx);
+
+	if (save_ret)
+		emit(A64_LDR64I(A64_R(0), A64_SP, retval_off), ctx);
+
+	/* reset SP  */
+	emit(A64_MOV(1, A64_SP, A64_FP), ctx);
+
+	/* pop frames  */
+	emit(A64_POP(A64_FP, A64_LR, A64_SP), ctx);
+	emit(A64_POP(A64_FP, A64_R(9), A64_SP), ctx);
+
+	if (flags & BPF_TRAMP_F_SKIP_FRAME) {
+		/* skip patched function, return to parent */
+		emit(A64_MOV(1, A64_LR, A64_R(9)), ctx);
+		emit(A64_RET(A64_R(9)), ctx);
+	} else {
+		/* return to patched function */
+		emit(A64_MOV(1, A64_R(10), A64_LR), ctx);
+		emit(A64_MOV(1, A64_LR, A64_R(9)), ctx);
+		emit(A64_RET(A64_R(10)), ctx);
+	}
+
+	if (ctx->image)
+		bpf_flush_icache(ctx->image, ctx->image + ctx->idx);
+
+	kfree(branches);
+
+	return ctx->idx;
+}
+
+int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,
+				void *image_end, const struct btf_func_model *m,
+				u32 flags, struct bpf_tramp_links *tlinks,
+				void *orig_call)
+{
+	int ret;
+	int nargs = m->nr_args;
+	int max_insns = ((long)image_end - (long)image) / AARCH64_INSN_SIZE;
+	struct jit_ctx ctx = {
+		.image = NULL,
+		.idx = 0,
+	};
+
+	/* the first 8 arguments are passed by registers */
+	if (nargs > 8)
+		return -ENOTSUPP;
+
+	ret = prepare_trampoline(&ctx, im, tlinks, orig_call, nargs, flags);
+	if (ret < 0)
+		return ret;
+
+	if (ret > max_insns)
+		return -EFBIG;
+
+	ctx.image = image;
+	ctx.idx = 0;
+
+	jit_fill_hole(image, (unsigned int)(image_end - image));
+	ret = prepare_trampoline(&ctx, im, tlinks, orig_call, nargs, flags);
+
+	if (ret > 0 && validate_code(&ctx) < 0)
+		ret = -EINVAL;
+
+	if (ret > 0)
+		ret *= AARCH64_INSN_SIZE;
+
+	return ret;
+}
+
 static bool is_long_jump(void *ip, void *target)
 {
 	long offset;
-- 
2.30.2

