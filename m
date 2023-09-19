Return-Path: <bpf+bounces-10344-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00EEF7A5839
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 05:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A98262819AE
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 03:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C16235890;
	Tue, 19 Sep 2023 03:57:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9985C341B7;
	Tue, 19 Sep 2023 03:57:02 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CAC10E;
	Mon, 18 Sep 2023 20:56:58 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RqSXN4qqCz4f3kq4;
	Tue, 19 Sep 2023 11:56:52 +0800 (CST)
Received: from localhost.localdomain (unknown [10.67.175.61])
	by APP4 (Coremail) with SMTP id gCh0CgBH09IDHAlldnxXAw--.51651S6;
	Tue, 19 Sep 2023 11:56:53 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Conor Dooley <conor@kernel.org>,
	Luke Nelson <luke.r.nels@gmail.com>,
	Pu Lehui <pulehui@huawei.com>,
	Pu Lehui <pulehui@huaweicloud.com>
Subject: [PATCH bpf-next 4/4] riscv, bpf: Mixing bpf2bpf and tailcalls
Date: Tue, 19 Sep 2023 11:57:11 +0800
Message-Id: <20230919035711.3297256-5-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230919035711.3297256-1-pulehui@huaweicloud.com>
References: <20230919035711.3297256-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBH09IDHAlldnxXAw--.51651S6
X-Coremail-Antispam: 1UD129KBjvJXoWxtF4DWr1kZFy8Zr4ruF15Jwb_yoWfKF17pa
	4kKw4fCFW0qa15JFZrGF1DXw1akw4vv3ZIkry3Kw4Ska1qqrykG3WxKa1YyFy5Ar95Zw1x
	Xr4Dt3ZFga17JrJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUma14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsG
	vfC2KfnxnUUI43ZEXa7VUbPC7UUUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Pu Lehui <pulehui@huawei.com>

In the current RV64 JIT, if we just don't initialize the TCC in subprog,
the TCC can be propagated from the parent process to the subprocess, but
the TCC of the parent process cannot be restored when the subprocess
exits. Since the RV64 TCC is initialized before saving the callee saved
registers into the stack, we cannot use the callee saved register to
pass the TCC, otherwise the original value of the callee saved register
will be destroyed. So we implemented mixing bpf2bpf and tailcalls
similar to x86_64, i.e. using a non-callee saved register to transfer
the TCC between functions, and saving that register to the stack to
protect the TCC value. At the same time, we also consider the scenario
of mixing trampoline.

Tests test_bpf.ko and test_verifier have passed, as well as the relative
testcases of test_progs*.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 arch/riscv/net/bpf_jit.h        |  1 +
 arch/riscv/net/bpf_jit_comp64.c | 91 ++++++++++++++-------------------
 2 files changed, 39 insertions(+), 53 deletions(-)

diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
index d21c6c92a..ca518846c 100644
--- a/arch/riscv/net/bpf_jit.h
+++ b/arch/riscv/net/bpf_jit.h
@@ -75,6 +75,7 @@ struct rv_jit_context {
 	int nexentries;
 	unsigned long flags;
 	int stack_size;
+	int tcc_offset;
 };
 
 /* Convert from ninsns to bytes. */
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index f2ded1151..f37be4911 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -13,13 +13,11 @@
 #include <asm/patch.h>
 #include "bpf_jit.h"
 
+#define RV_REG_TCC		RV_REG_A6
 #define RV_FENTRY_NINSNS	2
 /* fentry and TCC init insns will be skipped on tailcall */
 #define RV_TAILCALL_OFFSET	((RV_FENTRY_NINSNS + 1) * 4)
 
-#define RV_REG_TCC RV_REG_A6
-#define RV_REG_TCC_SAVED RV_REG_S6 /* Store A6 in S6 if program do calls */
-
 static const int regmap[] = {
 	[BPF_REG_0] =	RV_REG_A5,
 	[BPF_REG_1] =	RV_REG_A0,
@@ -51,14 +49,12 @@ static const int pt_regmap[] = {
 };
 
 enum {
-	RV_CTX_F_SEEN_TAIL_CALL =	0,
 	RV_CTX_F_SEEN_CALL =		RV_REG_RA,
 	RV_CTX_F_SEEN_S1 =		RV_REG_S1,
 	RV_CTX_F_SEEN_S2 =		RV_REG_S2,
 	RV_CTX_F_SEEN_S3 =		RV_REG_S3,
 	RV_CTX_F_SEEN_S4 =		RV_REG_S4,
 	RV_CTX_F_SEEN_S5 =		RV_REG_S5,
-	RV_CTX_F_SEEN_S6 =		RV_REG_S6,
 };
 
 static u8 bpf_to_rv_reg(int bpf_reg, struct rv_jit_context *ctx)
@@ -71,7 +67,6 @@ static u8 bpf_to_rv_reg(int bpf_reg, struct rv_jit_context *ctx)
 	case RV_CTX_F_SEEN_S3:
 	case RV_CTX_F_SEEN_S4:
 	case RV_CTX_F_SEEN_S5:
-	case RV_CTX_F_SEEN_S6:
 		__set_bit(reg, &ctx->flags);
 	}
 	return reg;
@@ -86,7 +81,6 @@ static bool seen_reg(int reg, struct rv_jit_context *ctx)
 	case RV_CTX_F_SEEN_S3:
 	case RV_CTX_F_SEEN_S4:
 	case RV_CTX_F_SEEN_S5:
-	case RV_CTX_F_SEEN_S6:
 		return test_bit(reg, &ctx->flags);
 	}
 	return false;
@@ -102,32 +96,6 @@ static void mark_call(struct rv_jit_context *ctx)
 	__set_bit(RV_CTX_F_SEEN_CALL, &ctx->flags);
 }
 
-static bool seen_call(struct rv_jit_context *ctx)
-{
-	return test_bit(RV_CTX_F_SEEN_CALL, &ctx->flags);
-}
-
-static void mark_tail_call(struct rv_jit_context *ctx)
-{
-	__set_bit(RV_CTX_F_SEEN_TAIL_CALL, &ctx->flags);
-}
-
-static bool seen_tail_call(struct rv_jit_context *ctx)
-{
-	return test_bit(RV_CTX_F_SEEN_TAIL_CALL, &ctx->flags);
-}
-
-static u8 rv_tail_call_reg(struct rv_jit_context *ctx)
-{
-	mark_tail_call(ctx);
-
-	if (seen_call(ctx)) {
-		__set_bit(RV_CTX_F_SEEN_S6, &ctx->flags);
-		return RV_REG_S6;
-	}
-	return RV_REG_A6;
-}
-
 static bool is_32b_int(s64 val)
 {
 	return -(1L << 31) <= val && val < (1L << 31);
@@ -235,10 +203,7 @@ static void __build_epilogue(bool is_tail_call, struct rv_jit_context *ctx)
 		emit_ld(RV_REG_S5, store_offset, RV_REG_SP, ctx);
 		store_offset -= 8;
 	}
-	if (seen_reg(RV_REG_S6, ctx)) {
-		emit_ld(RV_REG_S6, store_offset, RV_REG_SP, ctx);
-		store_offset -= 8;
-	}
+	emit_ld(RV_REG_TCC, store_offset, RV_REG_SP, ctx);
 
 	emit_addi(RV_REG_SP, RV_REG_SP, stack_adjust, ctx);
 	/* Set return value. */
@@ -332,7 +297,6 @@ static void emit_zext_32(u8 reg, struct rv_jit_context *ctx)
 static int emit_bpf_tail_call(int insn, struct rv_jit_context *ctx)
 {
 	int tc_ninsn, off, start_insn = ctx->ninsns;
-	u8 tcc = rv_tail_call_reg(ctx);
 
 	/* a0: &ctx
 	 * a1: &array
@@ -355,9 +319,11 @@ static int emit_bpf_tail_call(int insn, struct rv_jit_context *ctx)
 	/* if (--TCC < 0)
 	 *     goto out;
 	 */
-	emit_addi(RV_REG_TCC, tcc, -1, ctx);
+	emit_ld(RV_REG_TCC, ctx->tcc_offset, RV_REG_SP, ctx);
+	emit_addi(RV_REG_TCC, RV_REG_TCC, -1, ctx);
 	off = ninsns_rvoff(tc_ninsn - (ctx->ninsns - start_insn));
 	emit_branch(BPF_JSLT, RV_REG_TCC, RV_REG_ZERO, off, ctx);
+	emit_sd(RV_REG_SP, ctx->tcc_offset, RV_REG_TCC, ctx);
 
 	/* prog = array->ptrs[index];
 	 * if (!prog)
@@ -763,7 +729,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	int i, ret, offset;
 	int *branches_off = NULL;
 	int stack_size = 0, nregs = m->nr_args;
-	int retval_off, args_off, nregs_off, ip_off, run_ctx_off, sreg_off;
+	int retval_off, args_off, nregs_off, ip_off, run_ctx_off, sreg_off, tcc_off;
 	struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
 	struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
 	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
@@ -807,6 +773,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	 *
 	 * FP - sreg_off    [ callee saved reg	]
 	 *
+	 * FP - tcc_off     [ tail call count	] BPF_TRAMP_F_TAIL_CALL_CTX
+	 *
 	 *		    [ pads              ] pads for 16 bytes alignment
 	 */
 
@@ -848,6 +816,11 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	stack_size += 8;
 	sreg_off = stack_size;
 
+	if (flags & BPF_TRAMP_F_TAIL_CALL_CTX) {
+		stack_size += 8;
+		tcc_off = stack_size;
+	}
+
 	stack_size = round_up(stack_size, 16);
 
 	if (func_addr) {
@@ -874,6 +847,10 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 		emit_addi(RV_REG_FP, RV_REG_SP, stack_size, ctx);
 	}
 
+	/* store tail call count */
+	if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
+		emit_sd(RV_REG_FP, -tcc_off, RV_REG_TCC, ctx);
+
 	/* callee saved register S1 to pass start time */
 	emit_sd(RV_REG_FP, -sreg_off, RV_REG_S1, ctx);
 
@@ -927,6 +904,9 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
 		restore_args(nregs, args_off, ctx);
+		/* restore TCC to RV_REG_TCC before calling the original function */
+		if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
+			emit_ld(RV_REG_TCC, -tcc_off, RV_REG_FP, ctx);
 		ret = emit_call((const u64)orig_call, true, ctx);
 		if (ret)
 			goto out;
@@ -967,6 +947,10 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 
 	emit_ld(RV_REG_S1, -sreg_off, RV_REG_FP, ctx);
 
+	/* restore TCC to RV_REG_TCC before calling the original function */
+	if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
+		emit_ld(RV_REG_TCC, -tcc_off, RV_REG_FP, ctx);
+
 	if (func_addr) {
 		/* trampoline called from function entry */
 		emit_ld(RV_REG_T0, stack_size - 8, RV_REG_SP, ctx);
@@ -1476,6 +1460,9 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		if (ret < 0)
 			return ret;
 
+		/* restore TCC from stack to RV_REG_TCC */
+		emit_ld(RV_REG_TCC, ctx->tcc_offset, RV_REG_SP, ctx);
+
 		ret = emit_call(addr, fixed_addr, ctx);
 		if (ret)
 			return ret;
@@ -1735,6 +1722,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 void bpf_jit_build_prologue(struct rv_jit_context *ctx)
 {
 	int i, stack_adjust = 0, store_offset, bpf_stack_adjust;
+	bool is_main = ctx->prog->aux->func_idx == 0;
 
 	bpf_stack_adjust = round_up(ctx->prog->aux->stack_depth, 16);
 	if (bpf_stack_adjust)
@@ -1753,8 +1741,7 @@ void bpf_jit_build_prologue(struct rv_jit_context *ctx)
 		stack_adjust += 8;
 	if (seen_reg(RV_REG_S5, ctx))
 		stack_adjust += 8;
-	if (seen_reg(RV_REG_S6, ctx))
-		stack_adjust += 8;
+	stack_adjust += 8; /* RV_REG_TCC */
 
 	stack_adjust = round_up(stack_adjust, 16);
 	stack_adjust += bpf_stack_adjust;
@@ -1769,7 +1756,8 @@ void bpf_jit_build_prologue(struct rv_jit_context *ctx)
 	 * (TCC) register. This instruction is skipped for tail calls.
 	 * Force using a 4-byte (non-compressed) instruction.
 	 */
-	emit(rv_addi(RV_REG_TCC, RV_REG_ZERO, MAX_TAIL_CALL_CNT), ctx);
+	if (is_main)
+		emit(rv_addi(RV_REG_TCC, RV_REG_ZERO, MAX_TAIL_CALL_CNT), ctx);
 
 	emit_addi(RV_REG_SP, RV_REG_SP, -stack_adjust, ctx);
 
@@ -1799,22 +1787,14 @@ void bpf_jit_build_prologue(struct rv_jit_context *ctx)
 		emit_sd(RV_REG_SP, store_offset, RV_REG_S5, ctx);
 		store_offset -= 8;
 	}
-	if (seen_reg(RV_REG_S6, ctx)) {
-		emit_sd(RV_REG_SP, store_offset, RV_REG_S6, ctx);
-		store_offset -= 8;
-	}
+	emit_sd(RV_REG_SP, store_offset, RV_REG_TCC, ctx);
+	ctx->tcc_offset = store_offset;
 
 	emit_addi(RV_REG_FP, RV_REG_SP, stack_adjust, ctx);
 
 	if (bpf_stack_adjust)
 		emit_addi(RV_REG_S5, RV_REG_SP, bpf_stack_adjust, ctx);
 
-	/* Program contains calls and tail calls, so RV_REG_TCC need
-	 * to be saved across calls.
-	 */
-	if (seen_tail_call(ctx) && seen_call(ctx))
-		emit_mv(RV_REG_TCC_SAVED, RV_REG_TCC, ctx);
-
 	ctx->stack_size = stack_adjust;
 }
 
@@ -1827,3 +1807,8 @@ bool bpf_jit_supports_kfunc_call(void)
 {
 	return true;
 }
+
+bool bpf_jit_supports_subprog_tailcalls(void)
+{
+	return true;
+}
-- 
2.25.1


