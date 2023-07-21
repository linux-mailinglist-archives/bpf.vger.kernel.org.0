Return-Path: <bpf+bounces-5600-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F2275C407
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 12:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6068282226
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 10:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660EA19BC5;
	Fri, 21 Jul 2023 10:06:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6F2DF67;
	Fri, 21 Jul 2023 10:06:39 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7273F30E3;
	Fri, 21 Jul 2023 03:06:23 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4R6lZM33vwz4f468R;
	Fri, 21 Jul 2023 18:06:19 +0800 (CST)
Received: from localhost.localdomain (unknown [10.67.175.61])
	by APP1 (Coremail) with SMTP id cCh0CgCnEi2aWLpk84zSNg--.13464S2;
	Fri, 21 Jul 2023 18:06:19 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: linux-riscv@lists.infradead.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
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
	Guo Ren <guoren@kernel.org>,
	Song Shuai <suagrfillet@gmail.com>,
	Pu Lehui <pulehui@huawei.com>,
	Pu Lehui <pulehui@huaweicloud.com>
Subject: [PATCH v2] riscv, bpf: Adapt bpf trampoline to optimized riscv ftrace framework
Date: Fri, 21 Jul 2023 18:06:27 +0800
Message-Id: <20230721100627.2630326-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCnEi2aWLpk84zSNg--.13464S2
X-Coremail-Antispam: 1UD129KBjvJXoW3XF4ktw18Ww4kZr45ZF1rtFb_yoWDJrWkp3
	s3KrZ7AFWvqF4j9r9rWF18Xr13Ar4DtFyqkryfJws5Cw45Zr93CF18Kr4Fqry5C3s5uw48
	JFs8A34qk3W7JrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvY14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0J
	UQvtAUUUUU=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
	MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Pu Lehui <pulehui@huawei.com>

Commit 6724a76cff85 ("riscv: ftrace: Reduce the detour code size to
half") optimizes the detour code size of kernel functions to half with
T0 register and the upcoming DYNAMIC_FTRACE_WITH_DIRECT_CALLS of riscv
is based on this optimization, we need to adapt riscv bpf trampoline
based on this. One thing to do is to reduce detour code size of bpf
programs, and the second is to deal with the return address after the
execution of bpf trampoline. Meanwhile, we need to construct the frame
of parent function, otherwise we will miss one layer when unwinding.
The related tests have passed.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
v2:
- target to riscv tree to avoid the crash caused by the wrong merge
  sequence.
- fix the wrong position of traced function FP.

 arch/riscv/net/bpf_jit_comp64.c | 153 +++++++++++++++++---------------
 1 file changed, 82 insertions(+), 71 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index c648864c8cd1..0ca4f5c0097c 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -13,6 +13,8 @@
 #include <asm/patch.h>
 #include "bpf_jit.h"
 
+#define RV_FENTRY_NINSNS 2
+
 #define RV_REG_TCC RV_REG_A6
 #define RV_REG_TCC_SAVED RV_REG_S6 /* Store A6 in S6 if program do calls */
 
@@ -241,7 +243,7 @@ static void __build_epilogue(bool is_tail_call, struct rv_jit_context *ctx)
 	if (!is_tail_call)
 		emit_mv(RV_REG_A0, RV_REG_A5, ctx);
 	emit_jalr(RV_REG_ZERO, is_tail_call ? RV_REG_T3 : RV_REG_RA,
-		  is_tail_call ? 20 : 0, /* skip reserved nops and TCC init */
+		  is_tail_call ? (RV_FENTRY_NINSNS + 1) * 4 : 0, /* skip reserved nops and TCC init */
 		  ctx);
 }
 
@@ -618,32 +620,7 @@ static int add_exception_handler(const struct bpf_insn *insn,
 	return 0;
 }
 
-static int gen_call_or_nops(void *target, void *ip, u32 *insns)
-{
-	s64 rvoff;
-	int i, ret;
-	struct rv_jit_context ctx;
-
-	ctx.ninsns = 0;
-	ctx.insns = (u16 *)insns;
-
-	if (!target) {
-		for (i = 0; i < 4; i++)
-			emit(rv_nop(), &ctx);
-		return 0;
-	}
-
-	rvoff = (s64)(target - (ip + 4));
-	emit(rv_sd(RV_REG_SP, -8, RV_REG_RA), &ctx);
-	ret = emit_jump_and_link(RV_REG_RA, rvoff, false, &ctx);
-	if (ret)
-		return ret;
-	emit(rv_ld(RV_REG_RA, -8, RV_REG_SP), &ctx);
-
-	return 0;
-}
-
-static int gen_jump_or_nops(void *target, void *ip, u32 *insns)
+static int gen_jump_or_nops(void *target, void *ip, u32 *insns, bool is_call)
 {
 	s64 rvoff;
 	struct rv_jit_context ctx;
@@ -658,38 +635,35 @@ static int gen_jump_or_nops(void *target, void *ip, u32 *insns)
 	}
 
 	rvoff = (s64)(target - ip);
-	return emit_jump_and_link(RV_REG_ZERO, rvoff, false, &ctx);
+	return emit_jump_and_link(is_call ? RV_REG_T0 : RV_REG_ZERO, rvoff, false, &ctx);
 }
 
 int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type poke_type,
 		       void *old_addr, void *new_addr)
 {
-	u32 old_insns[4], new_insns[4];
+	u32 old_insns[RV_FENTRY_NINSNS], new_insns[RV_FENTRY_NINSNS];
 	bool is_call = poke_type == BPF_MOD_CALL;
-	int (*gen_insns)(void *target, void *ip, u32 *insns);
-	int ninsns = is_call ? 4 : 2;
 	int ret;
 
-	if (!is_bpf_text_address((unsigned long)ip))
+	if (!is_kernel_text((unsigned long)ip) &&
+	    !is_bpf_text_address((unsigned long)ip))
 		return -ENOTSUPP;
 
-	gen_insns = is_call ? gen_call_or_nops : gen_jump_or_nops;
-
-	ret = gen_insns(old_addr, ip, old_insns);
+	ret = gen_jump_or_nops(old_addr, ip, old_insns, is_call);
 	if (ret)
 		return ret;
 
-	if (memcmp(ip, old_insns, ninsns * 4))
+	if (memcmp(ip, old_insns, RV_FENTRY_NINSNS * 4))
 		return -EFAULT;
 
-	ret = gen_insns(new_addr, ip, new_insns);
+	ret = gen_jump_or_nops(new_addr, ip, new_insns, is_call);
 	if (ret)
 		return ret;
 
 	cpus_read_lock();
 	mutex_lock(&text_mutex);
-	if (memcmp(ip, new_insns, ninsns * 4))
-		ret = patch_text(ip, new_insns, ninsns);
+	if (memcmp(ip, new_insns, RV_FENTRY_NINSNS * 4))
+		ret = patch_text(ip, new_insns, RV_FENTRY_NINSNS);
 	mutex_unlock(&text_mutex);
 	cpus_read_unlock();
 
@@ -787,8 +761,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	int i, ret, offset;
 	int *branches_off = NULL;
 	int stack_size = 0, nregs = m->nr_args;
-	int retaddr_off, fp_off, retval_off, args_off;
-	int nregs_off, ip_off, run_ctx_off, sreg_off;
+	int retval_off, args_off, nregs_off, ip_off, run_ctx_off, sreg_off;
 	struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
 	struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
 	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
@@ -796,13 +769,27 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	bool save_ret;
 	u32 insn;
 
-	/* Generated trampoline stack layout:
+	/* Two types of generated trampoline stack layout:
+	 *
+	 * 1. trampoline called from function entry
+	 * --------------------------------------
+	 * FP + 8	    [ RA to parent func	] return address to parent
+	 *					  function
+	 * FP + 0	    [ FP of parent func ] frame pointer of parent
+	 *					  function
+	 * FP - 8           [ T0 to traced func ] return address of traced
+	 *					  function
+	 * FP - 16	    [ FP of traced func ] frame pointer of traced
+	 *					  function
+	 * --------------------------------------
 	 *
-	 * FP - 8	    [ RA of parent func	] return address of parent
+	 * 2. trampoline called directly
+	 * --------------------------------------
+	 * FP - 8	    [ RA to caller func ] return address to caller
 	 *					  function
-	 * FP - retaddr_off [ RA of traced func	] return address of traced
+	 * FP - 16	    [ FP of caller func	] frame pointer of caller
 	 *					  function
-	 * FP - fp_off	    [ FP of parent func ]
+	 * --------------------------------------
 	 *
 	 * FP - retval_off  [ return value      ] BPF_TRAMP_F_CALL_ORIG or
 	 *					  BPF_TRAMP_F_RET_FENTRY_RET
@@ -833,14 +820,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	if (nregs > 8)
 		return -ENOTSUPP;
 
-	/* room for parent function return address */
-	stack_size += 8;
-
-	stack_size += 8;
-	retaddr_off = stack_size;
-
-	stack_size += 8;
-	fp_off = stack_size;
+	/* room of trampoline frame to store return address and frame pointer */
+	stack_size += 16;
 
 	save_ret = flags & (BPF_TRAMP_F_CALL_ORIG | BPF_TRAMP_F_RET_FENTRY_RET);
 	if (save_ret) {
@@ -867,12 +848,29 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 
 	stack_size = round_up(stack_size, 16);
 
-	emit_addi(RV_REG_SP, RV_REG_SP, -stack_size, ctx);
-
-	emit_sd(RV_REG_SP, stack_size - retaddr_off, RV_REG_RA, ctx);
-	emit_sd(RV_REG_SP, stack_size - fp_off, RV_REG_FP, ctx);
-
-	emit_addi(RV_REG_FP, RV_REG_SP, stack_size, ctx);
+	if (func_addr) {
+		/* For the trampoline called from function entry,
+		 * the frame of traced function and the frame of
+		 * trampoline need to be considered.
+		 */
+		emit_addi(RV_REG_SP, RV_REG_SP, -16, ctx);
+		emit_sd(RV_REG_SP, 8, RV_REG_RA, ctx);
+		emit_sd(RV_REG_SP, 0, RV_REG_FP, ctx);
+		emit_addi(RV_REG_FP, RV_REG_SP, 16, ctx);
+
+		emit_addi(RV_REG_SP, RV_REG_SP, -stack_size, ctx);
+		emit_sd(RV_REG_SP, stack_size - 8, RV_REG_T0, ctx);
+		emit_sd(RV_REG_SP, stack_size - 16, RV_REG_FP, ctx);
+		emit_addi(RV_REG_FP, RV_REG_SP, stack_size, ctx);
+	} else {
+		/* For the trampoline called directly, just handle
+		 * the frame of trampoline.
+		 */
+		emit_addi(RV_REG_SP, RV_REG_SP, -stack_size, ctx);
+		emit_sd(RV_REG_SP, stack_size - 8, RV_REG_RA, ctx);
+		emit_sd(RV_REG_SP, stack_size - 16, RV_REG_FP, ctx);
+		emit_addi(RV_REG_FP, RV_REG_SP, stack_size, ctx);
+	}
 
 	/* callee saved register S1 to pass start time */
 	emit_sd(RV_REG_FP, -sreg_off, RV_REG_S1, ctx);
@@ -890,7 +888,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 
 	/* skip to actual body of traced function */
 	if (flags & BPF_TRAMP_F_SKIP_FRAME)
-		orig_call += 16;
+		orig_call += RV_FENTRY_NINSNS * 4;
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
 		emit_imm(RV_REG_A0, (const s64)im, ctx);
@@ -967,17 +965,30 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 
 	emit_ld(RV_REG_S1, -sreg_off, RV_REG_FP, ctx);
 
-	if (flags & BPF_TRAMP_F_SKIP_FRAME)
-		/* return address of parent function */
-		emit_ld(RV_REG_RA, stack_size - 8, RV_REG_SP, ctx);
-	else
-		/* return address of traced function */
-		emit_ld(RV_REG_RA, stack_size - retaddr_off, RV_REG_SP, ctx);
+	if (func_addr) {
+		/* trampoline called from function entry */
+		emit_ld(RV_REG_T0, stack_size - 8, RV_REG_SP, ctx);
+		emit_ld(RV_REG_FP, stack_size - 16, RV_REG_SP, ctx);
+		emit_addi(RV_REG_SP, RV_REG_SP, stack_size, ctx);
 
-	emit_ld(RV_REG_FP, stack_size - fp_off, RV_REG_SP, ctx);
-	emit_addi(RV_REG_SP, RV_REG_SP, stack_size, ctx);
+		emit_ld(RV_REG_RA, 8, RV_REG_SP, ctx);
+		emit_ld(RV_REG_FP, 0, RV_REG_SP, ctx);
+		emit_addi(RV_REG_SP, RV_REG_SP, 16, ctx);
 
-	emit_jalr(RV_REG_ZERO, RV_REG_RA, 0, ctx);
+		if (flags & BPF_TRAMP_F_SKIP_FRAME)
+			/* return to parent function */
+			emit_jalr(RV_REG_ZERO, RV_REG_RA, 0, ctx);
+		else
+			/* return to traced function */
+			emit_jalr(RV_REG_ZERO, RV_REG_T0, 0, ctx);
+	} else {
+		/* trampoline called directly */
+		emit_ld(RV_REG_RA, stack_size - 8, RV_REG_SP, ctx);
+		emit_ld(RV_REG_FP, stack_size - 16, RV_REG_SP, ctx);
+		emit_addi(RV_REG_SP, RV_REG_SP, stack_size, ctx);
+
+		emit_jalr(RV_REG_ZERO, RV_REG_RA, 0, ctx);
+	}
 
 	ret = ctx->ninsns;
 out:
@@ -1691,8 +1702,8 @@ void bpf_jit_build_prologue(struct rv_jit_context *ctx)
 
 	store_offset = stack_adjust - 8;
 
-	/* reserve 4 nop insns */
-	for (i = 0; i < 4; i++)
+	/* nops reserved for auipc+jalr pair */
+	for (i = 0; i < RV_FENTRY_NINSNS; i++)
 		emit(rv_nop(), ctx);
 
 	/* First instruction is always setting the tail-call-counter
-- 
2.25.1


