Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D7B650CB9
	for <lists+bpf@lfdr.de>; Mon, 19 Dec 2022 14:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbiLSNgk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Dec 2022 08:36:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbiLSNgg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Dec 2022 08:36:36 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2A825ED;
        Mon, 19 Dec 2022 05:36:34 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NbLMc3CMzz4f3mL8;
        Mon, 19 Dec 2022 21:36:28 +0800 (CST)
Received: from localhost.localdomain (unknown [10.67.175.61])
        by APP2 (Coremail) with SMTP id Syh0CgAH++jcaKBjpueTAA--.19298S6;
        Mon, 19 Dec 2022 21:36:31 +0800 (CST)
From:   Pu Lehui <pulehui@huaweicloud.com>
To:     bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Pu Lehui <pulehui@huawei.com>,
        Pu Lehui <pulehui@huaweicloud.com>
Subject: [RFC PATCH bpf-next 4/4] riscv, bpf: Add bpf trampoline support for RV64
Date:   Mon, 19 Dec 2022 21:37:36 +0800
Message-Id: <20221219133736.1387008-5-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221219133736.1387008-1-pulehui@huaweicloud.com>
References: <20221219133736.1387008-1-pulehui@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgAH++jcaKBjpueTAA--.19298S6
X-Coremail-Antispam: 1UD129KBjvJXoWfGw1xJw18GrW3Xr18Gr1Utrb_yoWDWr43pa
        nrKrW3AFW0qF4FqaykXF1UXF4aya1qvFnIkFy3Grnayr45XrZakw1rKF4Yvr98Crn5Ar13
        JFs0ya90kF17WFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUP214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
        4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
        3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
        IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
        M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
        kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
        14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
        W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbmZ
        X7UUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Pu Lehui <pulehui@huawei.com>

BPF trampoline is the critical infrastructure of the bpf
subsystem, acting as a mediator between kernel functions
and BPF programs. Numerous important features, such as
using ebpf program for zero overhead kernel introspection,
rely on this key component. We can't wait to support bpf
trampoline on RV64. The implementation of bpf trampoline
was closely to x86 and arm64 for future development. The
related tests have passed, as well as the test_verifier
with no new failure ceses.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 arch/riscv/net/bpf_jit_comp64.c | 323 ++++++++++++++++++++++++++++++++
 1 file changed, 323 insertions(+)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index fa8b03c52463..128059e6d744 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -738,6 +738,329 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type poke_type,
 	       bpf_text_poke_jump(ip, old_addr, new_addr);
 }
 
+static void store_args(int nregs, int args_off, struct rv_jit_context *ctx)
+{
+	int i;
+
+	for (i = 0; i < nregs; i++) {
+		emit_sd(RV_REG_FP, -args_off, RV_REG_A0 + i, ctx);
+		args_off -= 8;
+	}
+}
+
+static void restore_args(int nregs, int args_off, struct rv_jit_context *ctx)
+{
+	int i;
+
+	for (i = 0; i < nregs; i++) {
+		emit_ld(RV_REG_A0 + i, -args_off, RV_REG_FP, ctx);
+		args_off -= 8;
+	}
+}
+
+static int invoke_bpf_prog(struct bpf_tramp_link *l, int args_off, int retval_off,
+			   int run_ctx_off, bool save_ret, struct rv_jit_context *ctx)
+{
+	u32 insn;
+	int ret, branch_off, offset;
+	struct bpf_prog *p = l->link.prog;
+	int cookie_off = offsetof(struct bpf_tramp_run_ctx, bpf_cookie);
+
+	if (l->cookie) {
+		emit_imm(RV_REG_T1, l->cookie, ctx);
+		emit_sd(RV_REG_FP, -run_ctx_off + cookie_off, RV_REG_T1, ctx);
+	} else {
+		emit_sd(RV_REG_FP, -run_ctx_off + cookie_off, RV_REG_ZERO, ctx);
+	}
+
+	/* arg1: prog */
+	emit_imm(RV_REG_A0, (const s64)p, ctx);
+	/* arg2: &run_ctx */
+	emit_addi(RV_REG_A1, RV_REG_FP, -run_ctx_off, ctx);
+	ret = emit_call((const u64)bpf_trampoline_enter(p), true, ctx);
+	if (ret)
+		return ret;
+
+	/* if (__bpf_prog_enter(prog) == 0)
+	 *	goto skip_exec_of_prog;
+	 */
+	branch_off = ctx->ninsns;
+	/* nop reserved for conditional jump */
+	emit(rv_nop(), ctx);
+
+	/* store prog start time */
+	emit_mv(RV_REG_S1, RV_REG_A0, ctx);
+
+	/* arg1: &args_off */
+	emit_addi(RV_REG_A0, RV_REG_FP, -args_off, ctx);
+	if (!p->jited)
+		/* arg2: progs[i]->insnsi for interpreter */
+		emit_imm(RV_REG_A1, (const s64)p->insnsi, ctx);
+	ret = emit_call((const u64)p->bpf_func, true, ctx);
+	if (ret)
+		return ret;
+
+	if (save_ret)
+		emit_sd(RV_REG_FP, -retval_off, regmap[BPF_REG_0], ctx);
+
+	/* update branch with beqz */
+	offset = ninsns_rvoff(ctx->ninsns - branch_off);
+	insn = rv_beq(RV_REG_A0, RV_REG_ZERO, offset >> 1);
+	*(u32 *)(ctx->insns + branch_off) = insn;
+
+	/* arg1: prog */
+	emit_imm(RV_REG_A0, (const s64)p, ctx);
+	/* arg2: prog start time */
+	emit_mv(RV_REG_A1, RV_REG_S1, ctx);
+	/* arg3: &run_ctx */
+	emit_addi(RV_REG_A2, RV_REG_FP, -run_ctx_off, ctx);
+	ret = emit_call((const u64)bpf_trampoline_exit(p), true, ctx);
+
+	return ret;
+}
+
+static int invoke_bpf_mod_ret(struct bpf_tramp_links *tl, int args_off, int retval_off,
+			      int run_ctx_off, int *branches_off, struct rv_jit_context *ctx)
+{
+	int i, ret;
+
+	/* cleanup to avoid garbage return value confusion */
+	emit_sd(RV_REG_FP, -retval_off, RV_REG_ZERO, ctx);
+	for (i = 0; i < tl->nr_links; i++) {
+		ret = invoke_bpf_prog(tl->links[i], args_off, retval_off,
+				run_ctx_off, true, ctx);
+		if (ret)
+			return ret;
+		emit_ld(RV_REG_T1, -retval_off, RV_REG_FP, ctx);
+		branches_off[i] = ctx->ninsns;
+		This nop will be replaced with a cbnz later
+		/* nop reserved for conditional jump */
+		emit(rv_nop(), ctx);
+	}
+
+	return 0;
+}
+
+static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
+					 const struct btf_func_model *m,
+					 struct bpf_tramp_links *tlinks,
+					 void *func_addr, u32 flags,
+					 struct rv_jit_context *ctx)
+{
+	int i, ret, offset;
+	int *branches_off = NULL;
+	int stack_size = 0, nregs = m->nr_args;
+	int retaddr_off, fp_off, retval_off, args_off;
+	int nregs_off, ip_off, run_ctx_off, sreg_off;
+	struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
+	struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
+	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
+	void *orig_call = func_addr;
+	bool save_ret;
+	u32 insn;
+
+	/* Generated trampoline stack layout:
+	 *
+	 * FP - 8	    [ RA of parent func	] return address of parent
+	 *					  function
+	 * FP - retaddr_off [ RA of traced func	] return address of traced
+	 *					  function
+	 * FP - fp_off	    [ FP of parent func ]
+	 *
+	 * FP - retval_off  [ return value      ] BPF_TRAMP_F_CALL_ORIG or
+	 *					  BPF_TRAMP_F_RET_FENTRY_RET
+	 *                  [ argN              ]
+	 *                  [ ...               ]
+	 * FP - args_off    [ arg1              ]
+	 *
+	 * FP - nregs_off   [ regs count        ]
+	 *
+	 * FP - ip_off      [ traced func	] BPF_TRAMP_F_IP_ARG
+	 *
+	 * FP - run_ctx_off [ bpf_tramp_run_ctx ]
+	 *
+	 * FP - sreg_off    [ callee saved reg	]
+	 *
+	 *		    [ pads              ] pads for 16 bytes alignment
+	 */
+
+	if (flags & (BPF_TRAMP_F_ORIG_STACK | BPF_TRAMP_F_SHARE_IPMODIFY))
+		return -ENOTSUPP;
+
+	/* extra regiters for struct arguments */
+	for (i = 0; i < m->nr_args; i++)
+		if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG)
+			nregs += round_up(m->arg_size[i], 8) / 8 - 1;
+
+	/* 8 arguments passed by registers */
+	if (nregs > 8)
+		return -ENOTSUPP;
+
+	/* room for parent function return address */
+	stack_size += 8;
+
+	stack_size += 8;
+	retaddr_off = stack_size;
+
+	stack_size += 8;
+	fp_off = stack_size;
+
+	save_ret = flags & (BPF_TRAMP_F_CALL_ORIG | BPF_TRAMP_F_RET_FENTRY_RET);
+	if (save_ret) {
+		stack_size += 8;
+		retval_off = stack_size;
+	}
+
+	stack_size += nregs * 8;
+	args_off = stack_size;
+
+	stack_size += 8;
+	nregs_off = stack_size;
+
+	if (flags & BPF_TRAMP_F_IP_ARG) {
+		stack_size += 8;
+		ip_off = stack_size;
+	}
+
+	stack_size += round_up(sizeof(struct bpf_tramp_run_ctx), 8);
+	run_ctx_off = stack_size;
+
+	stack_size += 8;
+	sreg_off = stack_size;
+
+	stack_size = round_up(stack_size, 16);
+
+	emit_addi(RV_REG_SP, RV_REG_SP, -stack_size, ctx);
+
+	emit_sd(RV_REG_SP, stack_size - retaddr_off, RV_REG_RA, ctx);
+	emit_sd(RV_REG_SP, stack_size - fp_off, RV_REG_FP, ctx);
+
+	emit_addi(RV_REG_FP, RV_REG_SP, stack_size, ctx);
+
+	/* callee saved register S1 to pass start time */
+	emit_sd(RV_REG_FP, -sreg_off, RV_REG_S1, ctx);
+
+	/* store ip address of the traced function */
+	if (flags & BPF_TRAMP_F_IP_ARG) {
+		emit_imm(RV_REG_T1, (const s64)func_addr, ctx);
+		emit_sd(RV_REG_FP, -ip_off, RV_REG_T1, ctx);
+	}
+
+	emit_li(RV_REG_T1, nregs, ctx);
+	emit_sd(RV_REG_FP, -nregs_off, RV_REG_T1, ctx);
+
+	store_args(nregs, args_off, ctx);
+
+	/* skip to actual body of traced function */
+	if (flags & BPF_TRAMP_F_SKIP_FRAME)
+		orig_call += 16;
+
+	if (flags & BPF_TRAMP_F_CALL_ORIG) {
+		emit_imm(RV_REG_A0, (const s64)im, ctx);
+		ret = emit_call((const u64)__bpf_tramp_enter, true, ctx);
+		if (ret)
+			return ret;
+	}
+
+	for (i = 0; i < fentry->nr_links; i++) {
+		ret = invoke_bpf_prog(fentry->links[i], args_off, retval_off, run_ctx_off,
+				      flags & BPF_TRAMP_F_RET_FENTRY_RET, ctx);
+		if (ret)
+			return ret;
+	}
+
+	if (fmod_ret->nr_links) {
+		branches_off = kcalloc(fmod_ret->nr_links, sizeof(int), GFP_KERNEL);
+		if (!branches_off)
+			return -ENOMEM;
+
+		ret = invoke_bpf_mod_ret(fmod_ret, args_off, retval_off, run_ctx_off,
+					 branches_off, ctx);
+		if (ret)
+			return ret;
+	}
+
+	if (flags & BPF_TRAMP_F_CALL_ORIG) {
+		restore_args(nregs, args_off, ctx);
+		ret = emit_call((const u64)orig_call, true, ctx);
+		if (ret)
+			return ret;
+		emit_sd(RV_REG_FP, -retval_off, RV_REG_A0, ctx);
+		/* nop reserved for bpf_tramp_image_put */
+		im->ip_after_call = ctx->insns + ctx->ninsns;
+		emit(rv_nop(), ctx);
+	}
+
+	/* update branches saved in invoke_bpf_mod_ret with bnez */
+	for (i = 0; i < fmod_ret->nr_links; i++) {
+		offset = ninsns_rvoff(ctx->ninsns - branches_off[i]);
+		insn = rv_bne(RV_REG_T1, RV_REG_ZERO, offset >> 1);
+		*(u32 *)(ctx->insns + branches_off[i]) = insn;
+	}
+
+	for (i = 0; i < fexit->nr_links; i++) {
+		ret = invoke_bpf_prog(fexit->links[i], args_off, retval_off,
+				      run_ctx_off, false, ctx);
+		if (ret)
+			return ret;
+	}
+
+	if (flags & BPF_TRAMP_F_CALL_ORIG) {
+		im->ip_epilogue = ctx->insns + ctx->ninsns;
+		emit_imm(RV_REG_A0, (const s64)im, ctx);
+		ret = emit_call((const u64)__bpf_tramp_exit, true, ctx);
+		if (ret)
+			return ret;
+	}
+
+	if (flags & BPF_TRAMP_F_RESTORE_REGS)
+		restore_args(nregs, args_off, ctx);
+
+	if (save_ret)
+		emit_ld(RV_REG_A0, -retval_off, RV_REG_FP, ctx);
+
+	emit_ld(RV_REG_S1, -sreg_off, RV_REG_FP, ctx);
+
+	if (flags & BPF_TRAMP_F_SKIP_FRAME)
+		/* return address of parent function */
+		emit_ld(RV_REG_RA, stack_size - 8, RV_REG_SP, ctx);
+	else
+		/* return address of traced function */
+		emit_ld(RV_REG_RA, stack_size - retaddr_off, RV_REG_SP, ctx);
+
+	emit_ld(RV_REG_FP, stack_size - fp_off, RV_REG_SP, ctx);
+	emit_addi(RV_REG_SP, RV_REG_SP, stack_size, ctx);
+
+	emit_jalr(RV_REG_ZERO, RV_REG_RA, 0, ctx);
+
+	bpf_flush_icache(ctx->insns, ctx->insns + ctx->ninsns);
+
+	kfree(branches_off);
+
+	return ctx->ninsns;
+
+}
+
+int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,
+				void *image_end, const struct btf_func_model *m,
+				u32 flags, struct bpf_tramp_links *tlinks,
+				void *func_addr)
+{
+	int ret;
+	struct rv_jit_context ctx;
+
+	ctx.ninsns = 0;
+	ctx.insns = image;
+	ret = __arch_prepare_bpf_trampoline(im, m, tlinks, func_addr, flags, &ctx);
+	if (ret < 0)
+		return ret;
+
+	if (ninsns_rvoff(ret) > (long)image_end - (long)image)
+		return -EFBIG;
+
+	return ninsns_rvoff(ret);
+}
+
 int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		      bool extra_pass)
 {
-- 
2.25.1

