Return-Path: <bpf+bounces-10225-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D127A360F
	for <lists+bpf@lfdr.de>; Sun, 17 Sep 2023 17:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 070D428148B
	for <lists+bpf@lfdr.de>; Sun, 17 Sep 2023 15:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536014C6E;
	Sun, 17 Sep 2023 15:09:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D025A4C60
	for <bpf@vger.kernel.org>; Sun, 17 Sep 2023 15:08:59 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B979B6
	for <bpf@vger.kernel.org>; Sun, 17 Sep 2023 08:08:56 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RpWXg2DGmz4f3lDK
	for <bpf@vger.kernel.org>; Sun, 17 Sep 2023 23:08:51 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
	by APP3 (Coremail) with SMTP id _Ch0CgBHoE+DFgdlr6CoAg--.39324S2;
	Sun, 17 Sep 2023 23:08:53 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Florent Revest <revest@chromium.org>,
	Will Deacon <will@kernel.org>,
	Zi Shen Lim <zlim.lnx@gmail.com>
Subject: [PATCH bpf-next] bpf, arm64: Support up to 12 function arguments
Date: Sun, 17 Sep 2023 23:07:52 +0800
Message-Id: <20230917150752.69612-1-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgBHoE+DFgdlr6CoAg--.39324S2
X-Coremail-Antispam: 1UD129KBjvAXoW3KrWxGw1DGw4DJw13CrWDXFb_yoW8Jr1DAo
	ZFg3WkXF1xKryrXrZ3KrykJry7Zan7tr15XFWrJrs8uF97XrW5tr4fuws3J3W5ZF4j9F1U
	uF1Uta4Fka1fAr4kn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUU5l7kC6x804xWl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
	AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF
	7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
	c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
	CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
	MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJV
	Cq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBI
	daVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Xu Kuohai <xukuohai@huawei.com>

Currently arm64 bpf trampoline supports up to 8 function arguments.
According to the statistics from commit
473e3150e30a ("bpf, x86: allow function arguments up to 12 for TRACING"),
there are about 200 functions accept 9 to 12 arguments, so adding support
for up to 12 function arguments.

Due to bpf only supports function arguments up to 16 bytes, according to
AAPCS64, starting from the first argument, each argument is first
attempted to be loaded to 1 or 2 smallest registers from x0-x7, if there
are no enough registers to hold the entire argument, then all remaining
arguments starting from this one are pushed to the stack for passing.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 arch/arm64/net/bpf_jit_comp.c                | 171 ++++++++++++++-----
 tools/testing/selftests/bpf/DENYLIST.aarch64 |   2 -
 2 files changed, 131 insertions(+), 42 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 7d4af64e3982..a0cf526b07ea 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1705,7 +1705,7 @@ bool bpf_jit_supports_subprog_tailcalls(void)
 }
 
 static void invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_link *l,
-			    int args_off, int retval_off, int run_ctx_off,
+			    int bargs_off, int retval_off, int run_ctx_off,
 			    bool save_ret)
 {
 	__le32 *branch;
@@ -1747,7 +1747,7 @@ static void invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_link *l,
 	/* save return value to callee saved register x20 */
 	emit(A64_MOV(1, A64_R(20), A64_R(0)), ctx);
 
-	emit(A64_ADD_I(1, A64_R(0), A64_SP, args_off), ctx);
+	emit(A64_ADD_I(1, A64_R(0), A64_SP, bargs_off), ctx);
 	if (!p->jited)
 		emit_addr_mov_i64(A64_R(1), (const u64)p->insnsi, ctx);
 
@@ -1772,7 +1772,7 @@ static void invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_link *l,
 }
 
 static void invoke_bpf_mod_ret(struct jit_ctx *ctx, struct bpf_tramp_links *tl,
-			       int args_off, int retval_off, int run_ctx_off,
+			       int bargs_off, int retval_off, int run_ctx_off,
 			       __le32 **branches)
 {
 	int i;
@@ -1782,7 +1782,7 @@ static void invoke_bpf_mod_ret(struct jit_ctx *ctx, struct bpf_tramp_links *tl,
 	 */
 	emit(A64_STR64I(A64_ZR, A64_SP, retval_off), ctx);
 	for (i = 0; i < tl->nr_links; i++) {
-		invoke_bpf_prog(ctx, tl->links[i], args_off, retval_off,
+		invoke_bpf_prog(ctx, tl->links[i], bargs_off, retval_off,
 				run_ctx_off, true);
 		/* if (*(u64 *)(sp + retval_off) !=  0)
 		 *	goto do_fexit;
@@ -1796,23 +1796,111 @@ static void invoke_bpf_mod_ret(struct jit_ctx *ctx, struct bpf_tramp_links *tl,
 	}
 }
 
-static void save_args(struct jit_ctx *ctx, int args_off, int nregs)
+struct arg_aux {
+	/* how many args are passed through registers, the rest args are
+	 * passed through stack
+	 */
+	int args_in_reg;
+	/* how many registers used for passing arguments */
+	int regs_for_arg;
+	/* how many stack slots used for arguments, each slot is 8 bytes */
+	int stack_slots_for_arg;
+};
+
+static void calc_arg_aux(const struct btf_func_model *m,
+			 struct arg_aux *a)
 {
 	int i;
+	int nregs;
+	int slots;
+	int stack_slots;
+
+	/* verifier ensures m->nr_args <= MAX_BPF_FUNC_ARGS */
+	for (i = 0, nregs = 0; i < m->nr_args; i++) {
+		slots = (m->arg_size[i] + 7) / 8;
+		if (nregs + slots <= 8) /* passed through register ? */
+			nregs += slots;
+		else
+			break;
+	}
+
+	a->args_in_reg = i;
+	a->regs_for_arg = nregs;
 
-	for (i = 0; i < nregs; i++) {
-		emit(A64_STR64I(i, A64_SP, args_off), ctx);
-		args_off += 8;
+	/* the rest arguments are passed through stack */
+	for (stack_slots = 0; i < m->nr_args; i++)
+		stack_slots += (m->arg_size[i] + 7) / 8;
+
+	a->stack_slots_for_arg = stack_slots;
+}
+
+static void clear_garbage(struct jit_ctx *ctx, int reg, int effective_bytes)
+{
+	if (effective_bytes) {
+		int garbage_bits = 64 - 8 * effective_bytes;
+#ifdef CONFIG_CPU_BIG_ENDIAN
+		/* garbage bits are at the right end */
+		emit(A64_LSR(1, reg, reg, garbage_bits), ctx);
+		emit(A64_LSL(1, reg, reg, garbage_bits), ctx);
+#else
+		/* garbage bits are at the left end */
+		emit(A64_LSL(1, reg, reg, garbage_bits), ctx);
+		emit(A64_LSR(1, reg, reg, garbage_bits), ctx);
+#endif
 	}
 }
 
-static void restore_args(struct jit_ctx *ctx, int args_off, int nregs)
+static void save_args(struct jit_ctx *ctx, int bargs_off, int oargs_off,
+		      const struct btf_func_model *m,
+		      const struct arg_aux *a,
+		      bool for_call_origin)
 {
 	int i;
+	int reg;
+	int doff;
+	int soff;
+	int slots;
+	u8 tmp = bpf2a64[TMP_REG_1];
+
+	/* store argument registers to stack for call bpf, or restore argument
+	 * registers from stack for the original function
+	 */
+	for (reg = 0; reg < a->regs_for_arg; reg++) {
+		emit(for_call_origin ?
+		     A64_LDR64I(reg, A64_SP, bargs_off) :
+		     A64_STR64I(reg, A64_SP, bargs_off),
+		     ctx);
+		bargs_off += 8;
+	}
 
-	for (i = 0; i < nregs; i++) {
-		emit(A64_LDR64I(i, A64_SP, args_off), ctx);
-		args_off += 8;
+	soff = 32; /* on stack arguments start from FP + 32 */
+	doff = (for_call_origin ? oargs_off : bargs_off);
+
+	/* save on stack arguments */
+	for (i = a->args_in_reg; i < m->nr_args; i++) {
+		slots = (m->arg_size[i] + 7) / 8;
+		/* verifier ensures arg_size <= 16, so slots equals 1 or 2 */
+		while (slots-- > 0) {
+			emit(A64_LDR64I(tmp, A64_FP, soff), ctx);
+			/* if there is unused space in the last slot, clear
+			 * the garbage contained in the space.
+			 */
+			if (slots == 0 && !for_call_origin)
+				clear_garbage(ctx, tmp, m->arg_size[i] % 8);
+			emit(A64_STR64I(tmp, A64_SP, doff), ctx);
+			soff += 8;
+			doff += 8;
+		}
+	}
+}
+
+static void restore_args(struct jit_ctx *ctx, int bargs_off, int nregs)
+{
+	int reg;
+
+	for (reg = 0; reg < nregs; reg++) {
+		emit(A64_LDR64I(reg, A64_SP, bargs_off), ctx);
+		bargs_off += 8;
 	}
 }
 
@@ -1829,17 +1917,21 @@ static void restore_args(struct jit_ctx *ctx, int args_off, int nregs)
  */
 static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 			      struct bpf_tramp_links *tlinks, void *orig_call,
-			      int nregs, u32 flags)
+			      const struct btf_func_model *m,
+			      const struct arg_aux *a,
+			      u32 flags)
 {
 	int i;
 	int stack_size;
 	int retaddr_off;
 	int regs_off;
 	int retval_off;
-	int args_off;
+	int bargs_off;
 	int nregs_off;
 	int ip_off;
 	int run_ctx_off;
+	int oargs_off;
+	int nregs;
 	struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
 	struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
 	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
@@ -1859,19 +1951,26 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	 *
 	 * SP + retval_off  [ return value      ] BPF_TRAMP_F_CALL_ORIG or
 	 *                                        BPF_TRAMP_F_RET_FENTRY_RET
-	 *
 	 *                  [ arg reg N         ]
 	 *                  [ ...               ]
-	 * SP + args_off    [ arg reg 1         ]
+	 * SP + bargs_off   [ arg reg 1         ] for bpf
 	 *
 	 * SP + nregs_off   [ arg regs count    ]
 	 *
 	 * SP + ip_off      [ traced function   ] BPF_TRAMP_F_IP_ARG flag
 	 *
 	 * SP + run_ctx_off [ bpf_tramp_run_ctx ]
+	 *
+	 *                  [ stack arg N       ]
+	 *                  [ ...               ]
+	 * SP + oargs_off   [ stack arg 1       ] for original func
 	 */
 
 	stack_size = 0;
+	oargs_off = stack_size;
+	if (flags & BPF_TRAMP_F_CALL_ORIG)
+		stack_size += 8 * a->stack_slots_for_arg;
+
 	run_ctx_off = stack_size;
 	/* room for bpf_tramp_run_ctx */
 	stack_size += round_up(sizeof(struct bpf_tramp_run_ctx), 8);
@@ -1885,9 +1984,10 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	/* room for args count */
 	stack_size += 8;
 
-	args_off = stack_size;
+	bargs_off = stack_size;
 	/* room for args */
-	stack_size += nregs * 8;
+	nregs = a->regs_for_arg + a->stack_slots_for_arg;
+	stack_size += 8 * nregs;
 
 	/* room for return value */
 	retval_off = stack_size;
@@ -1934,8 +2034,8 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	emit(A64_MOVZ(1, A64_R(10), nregs, 0), ctx);
 	emit(A64_STR64I(A64_R(10), A64_SP, nregs_off), ctx);
 
-	/* save arg regs */
-	save_args(ctx, args_off, nregs);
+	/* save args for bpf */
+	save_args(ctx, bargs_off, oargs_off, m, a, false);
 
 	/* save callee saved registers */
 	emit(A64_STR64I(A64_R(19), A64_SP, regs_off), ctx);
@@ -1947,7 +2047,7 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	}
 
 	for (i = 0; i < fentry->nr_links; i++)
-		invoke_bpf_prog(ctx, fentry->links[i], args_off,
+		invoke_bpf_prog(ctx, fentry->links[i], bargs_off,
 				retval_off, run_ctx_off,
 				flags & BPF_TRAMP_F_RET_FENTRY_RET);
 
@@ -1957,12 +2057,13 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 		if (!branches)
 			return -ENOMEM;
 
-		invoke_bpf_mod_ret(ctx, fmod_ret, args_off, retval_off,
+		invoke_bpf_mod_ret(ctx, fmod_ret, bargs_off, retval_off,
 				   run_ctx_off, branches);
 	}
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
-		restore_args(ctx, args_off, nregs);
+		/* save args for original func */
+		save_args(ctx, bargs_off, oargs_off, m, a, true);
 		/* call original func */
 		emit(A64_LDR64I(A64_R(10), A64_SP, retaddr_off), ctx);
 		emit(A64_ADR(A64_LR, AARCH64_INSN_SIZE * 2), ctx);
@@ -1981,7 +2082,7 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	}
 
 	for (i = 0; i < fexit->nr_links; i++)
-		invoke_bpf_prog(ctx, fexit->links[i], args_off, retval_off,
+		invoke_bpf_prog(ctx, fexit->links[i], bargs_off, retval_off,
 				run_ctx_off, false);
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
@@ -1991,7 +2092,7 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	}
 
 	if (flags & BPF_TRAMP_F_RESTORE_REGS)
-		restore_args(ctx, args_off, nregs);
+		restore_args(ctx, bargs_off, a->regs_for_arg);
 
 	/* restore callee saved register x19 and x20 */
 	emit(A64_LDR64I(A64_R(19), A64_SP, regs_off), ctx);
@@ -2031,26 +2132,16 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,
 				u32 flags, struct bpf_tramp_links *tlinks,
 				void *orig_call)
 {
-	int i, ret;
-	int nregs = m->nr_args;
+	int ret;
 	int max_insns = ((long)image_end - (long)image) / AARCH64_INSN_SIZE;
 	struct jit_ctx ctx = {
 		.image = NULL,
 		.idx = 0,
 	};
+	struct arg_aux aaux;
 
-	/* extra registers needed for struct argument */
-	for (i = 0; i < MAX_BPF_FUNC_ARGS; i++) {
-		/* The arg_size is at most 16 bytes, enforced by the verifier. */
-		if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG)
-			nregs += (m->arg_size[i] + 7) / 8 - 1;
-	}
-
-	/* the first 8 registers are used for arguments */
-	if (nregs > 8)
-		return -ENOTSUPP;
-
-	ret = prepare_trampoline(&ctx, im, tlinks, orig_call, nregs, flags);
+	calc_arg_aux(m, &aaux);
+	ret = prepare_trampoline(&ctx, im, tlinks, orig_call, m, &aaux, flags);
 	if (ret < 0)
 		return ret;
 
@@ -2061,7 +2152,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,
 	ctx.idx = 0;
 
 	jit_fill_hole(image, (unsigned int)(image_end - image));
-	ret = prepare_trampoline(&ctx, im, tlinks, orig_call, nregs, flags);
+	ret = prepare_trampoline(&ctx, im, tlinks, orig_call, m, &aaux, flags);
 
 	if (ret > 0 && validate_code(&ctx) < 0)
 		ret = -EINVAL;
diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testing/selftests/bpf/DENYLIST.aarch64
index f5065576cae9..35a297a3c92f 100644
--- a/tools/testing/selftests/bpf/DENYLIST.aarch64
+++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
@@ -11,8 +11,6 @@ kprobe_multi_test/link_api_addrs                 # link_fd unexpected link_fd: a
 kprobe_multi_test/link_api_syms                  # link_fd unexpected link_fd: actual -95 < expected 0
 kprobe_multi_test/skel_api                       # libbpf: failed to load BPF skeleton 'kprobe_multi': -3
 module_attach                                    # prog 'kprobe_multi': failed to auto-attach: -95
-fentry_test/fentry_many_args                     # fentry_many_args:FAIL:fentry_many_args_attach unexpected error: -524
-fexit_test/fexit_many_args                       # fexit_many_args:FAIL:fexit_many_args_attach unexpected error: -524
 fill_link_info/kprobe_multi_link_info            # bpf_program__attach_kprobe_multi_opts unexpected error: -95
 fill_link_info/kretprobe_multi_link_info         # bpf_program__attach_kprobe_multi_opts unexpected error: -95
 fill_link_info/kprobe_multi_invalid_ubuff        # bpf_program__attach_kprobe_multi_opts unexpected error: -95
-- 
2.30.2


