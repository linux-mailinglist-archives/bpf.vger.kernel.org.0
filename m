Return-Path: <bpf+bounces-38767-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6458969932
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 11:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F75B287EF2
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 09:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB2F1C62DB;
	Tue,  3 Sep 2024 09:34:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181BC1C62AB
	for <bpf@vger.kernel.org>; Tue,  3 Sep 2024 09:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725356072; cv=none; b=LyqIQAyRGgSoGtPcKxwNxq2Qa9wgmPF6AgEnPFmhg0thgqu3t82Jw6ouaCaXklbXS/+tmv96p/oeGsTXdhN5Wkv1M/+3eIrzl03i7riIqv9oBcPlK53WLXo1vqDYbz3950aldEhUR+a/6U9jpfxD002Nm2tqHHlUKJRApxkRoMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725356072; c=relaxed/simple;
	bh=ORq8nXRHZmJ1y7Wa9ZaunH3+7n17b5xN7y/T9w9Tguc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OZyeMt8Sp+/h3o+gXtlklTFLPbthbOfN8UCcd+oxYYZCKmWwQUSF+CcoIVxDyudTDO3LafXch6cj1ZchZgZNpS+IrquE1cLiWe8VkqzEv/91K4Hvd8R1bm2WkmPtk37vwfjbMSKCLVmLiv+BPQY/9Cr+EuVF3One6oMgKC6iSTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WygRw6lxJz4f3jYJ
	for <bpf@vger.kernel.org>; Tue,  3 Sep 2024 17:34:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id DBB841A09F2
	for <bpf@vger.kernel.org>; Tue,  3 Sep 2024 17:34:19 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
	by APP3 (Coremail) with SMTP id _Ch0CgAHW4cZ2NZmPsAJAQ--.191S2;
	Tue, 03 Sep 2024 17:34:18 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH bpf-next v2] bpf, arm64: Jit BPF_CALL to direct call when possible
Date: Tue,  3 Sep 2024 17:44:07 +0800
Message-Id: <20240903094407.601107-1-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAHW4cZ2NZmPsAJAQ--.191S2
X-Coremail-Antispam: 1UD129KBjvJXoW3JrykCr43Jr13Wr4rtFWrKrg_yoWfZw1rpF
	ZrCw1FkrWrXrW7GFs7Ga18Ary3Kws5J3W7JFy8W3ySkr90qryrK3Z8K34avFZ8Ar95Zr13
	XF4qyr15uF1UA37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6x
	AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

Currently, BPF_CALL is always jited to indirect call. When target is
within the range of direct call, BPF_CALL can be jited to direct call.

For example, the following BPF_CALL

    call __htab_map_lookup_elem

is always jited to indirect call:

    mov     x10, #0xffffffffffff18f4
    movk    x10, #0x821, lsl #16
    movk    x10, #0x8000, lsl #32
    blr     x10

When the address of target __htab_map_lookup_elem is within the range of
direct call, the BPF_CALL can be jited to:

    bl      0xfffffffffd33bc98

This patch does such jit optimization by emitting arm64 direct calls for
BPF_CALL when possible, indirect calls otherwise.

Without this patch, the jit works as follows.

1. First pass
   A. Determine jited position and size for each bpf instruction.
   B. Computed the jited image size.

2. Allocate jited image with size computed in step 1.

3. Second pass
   A. Adjust jump offset for jump instructions
   B. Write the final image.

This works because, for a given bpf prog, regardless of where the jited
image is allocated, the jited result for each instruction is fixed. The
second pass differs from the first only in adjusting the jump offsets,
like changing "jmp imm1" to "jmp imm2", while the position and size of
the "jmp" instruction remain unchanged.

Now considering whether to jit BPF_CALL to arm64 direct or indirect call
instruction. The choice depends solely on the jump offset: direct call
if the jump offset is within 128MB, indirect call otherwise.

For a given BPF_CALL, the target address is known, so the jump offset is
decided by the jited address of the BPF_CALL instruction. In other words,
for a given bpf prog, the jited result for each BPF_CALL is determined
by its jited address.

The jited address for a BPF_CALL is the jited image address plus the
total jited size of all preceding instructions. For a given bpf prog,
there are clearly no BPF_CALL instructions before the first BPF_CALL
instruction. Since the jited result for all other instructions other
than BPF_CALL are fixed, the total jited size preceding the first
BPF_CALL is also fixed. Therefore, once the jited image is allocated,
the jited address for the first BPF_CALL is fixed.

Now that the jited result for the first BPF_CALL is fixed, the jited
results for all instructions preceding the second BPF_CALL are fixed.
So the jited address and result for the second BPF_CALL are also fixed.

Similarly, we can conclude that the jited addresses and results for all
subsequent BPF_CALL instructions are fixed.

This means that, for a given bpf prog, once the jited image is allocated,
the jited address and result for all instructions, including all BPF_CALL
instructions, are fixed.

Based on the observation, with this patch, the jit works as follows.

1. First pass
   Estimate the maximum jited image size. In this pass, all BPF_CALLs
   are jited to arm64 indirect calls since the jump offsets are unknown
   because the jited image is not allocated.

2. Allocate jited image with size estimated in step 1.

3. Second pass
   A. Determine the jited result for each BPF_CALL.
   B. Determine jited address and size for each bpf instruction.

4. Third pass
   A. Adjust jump offset for jump instructions.
   B. Write the final image.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
v2:
1. Rebase and update commit message
2. Remove the outdated second patch

v1:
https://lore.kernel.org/bpf/20220919092138.1027353-1-xukuohai@huaweicloud.com/
---
 arch/arm64/net/bpf_jit_comp.c | 91 +++++++++++++++++++++++++++++------
 1 file changed, 75 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 8aa32cb140b9..8bbd0b20136a 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -84,6 +84,7 @@ struct jit_ctx {
 	u64 user_vm_start;
 	u64 arena_vm_start;
 	bool fp_used;
+	bool write;
 };
 
 struct bpf_plt {
@@ -97,7 +98,7 @@ struct bpf_plt {
 
 static inline void emit(const u32 insn, struct jit_ctx *ctx)
 {
-	if (ctx->image != NULL)
+	if (ctx->image != NULL && ctx->write)
 		ctx->image[ctx->idx] = cpu_to_le32(insn);
 
 	ctx->idx++;
@@ -182,14 +183,47 @@ static inline void emit_addr_mov_i64(const int reg, const u64 val,
 	}
 }
 
-static inline void emit_call(u64 target, struct jit_ctx *ctx)
+static bool should_emit_indirect_call(long target, const struct jit_ctx *ctx)
 {
-	u8 tmp = bpf2a64[TMP_REG_1];
+	long offset;
 
+	/* when ctx->ro_image is not allocated or the target is unknown,
+	 * emit indirect call
+	 */
+	if (!ctx->ro_image || !target)
+		return true;
+
+	offset = target - (long)&ctx->ro_image[ctx->idx];
+	return offset < -SZ_128M || offset >= SZ_128M;
+}
+
+static void emit_direct_call(u64 target, struct jit_ctx *ctx)
+{
+	u32 insn;
+	unsigned long pc;
+
+	pc = (unsigned long)&ctx->ro_image[ctx->idx];
+	insn = aarch64_insn_gen_branch_imm(pc, target, AARCH64_INSN_BRANCH_LINK);
+	emit(insn, ctx);
+}
+
+static void emit_indirect_call(u64 target, struct jit_ctx *ctx)
+{
+	u8 tmp;
+
+	tmp = bpf2a64[TMP_REG_1];
 	emit_addr_mov_i64(tmp, target, ctx);
 	emit(A64_BLR(tmp), ctx);
 }
 
+static void emit_call(u64 target, struct jit_ctx *ctx)
+{
+	if (should_emit_indirect_call((long)target, ctx))
+		emit_indirect_call(target, ctx);
+	else
+		emit_direct_call(target, ctx);
+}
+
 static inline int bpf2a64_offset(int bpf_insn, int off,
 				 const struct jit_ctx *ctx)
 {
@@ -1649,13 +1683,11 @@ static int build_body(struct jit_ctx *ctx, bool extra_pass)
 		const struct bpf_insn *insn = &prog->insnsi[i];
 		int ret;
 
-		if (ctx->image == NULL)
-			ctx->offset[i] = ctx->idx;
+		ctx->offset[i] = ctx->idx;
 		ret = build_insn(insn, ctx, extra_pass);
 		if (ret > 0) {
 			i++;
-			if (ctx->image == NULL)
-				ctx->offset[i] = ctx->idx;
+			ctx->offset[i] = ctx->idx;
 			continue;
 		}
 		if (ret)
@@ -1666,8 +1698,7 @@ static int build_body(struct jit_ctx *ctx, bool extra_pass)
 	 * the last element with the offset after the last
 	 * instruction (end of program)
 	 */
-	if (ctx->image == NULL)
-		ctx->offset[i] = ctx->idx;
+	ctx->offset[i] = ctx->idx;
 
 	return 0;
 }
@@ -1721,6 +1752,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	struct jit_ctx ctx;
 	u8 *image_ptr;
 	u8 *ro_image_ptr;
+	int body_idx;
+	int exentry_idx;
 
 	if (!prog->jit_requested)
 		return orig_prog;
@@ -1768,8 +1801,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	ctx.user_vm_start = bpf_arena_get_user_vm_start(prog->aux->arena);
 	ctx.arena_vm_start = bpf_arena_get_kern_vm_start(prog->aux->arena);
 
-	/*
-	 * 1. Initial fake pass to compute ctx->idx and ctx->offset.
+	/* Pass 1: Estimate the maximum image size.
 	 *
 	 * BPF line info needs ctx->offset[i] to be the offset of
 	 * instruction[i] in jited image, so build prologue first.
@@ -1792,7 +1824,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	extable_size = prog->aux->num_exentries *
 		sizeof(struct exception_table_entry);
 
-	/* Now we know the actual image size. */
+	/* Now we know the maximum image size. */
 	prog_size = sizeof(u32) * ctx.idx;
 	/* also allocate space for plt target */
 	extable_offset = round_up(prog_size + PLT_TARGET_SIZE, extable_align);
@@ -1805,7 +1837,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		goto out_off;
 	}
 
-	/* 2. Now, the actual pass. */
+	/* Pass 2: Determine jited position and result for each instruction */
 
 	/*
 	 * Use the image(RW) for writing the JITed instructions. But also save
@@ -1821,30 +1853,56 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 skip_init_ctx:
 	ctx.idx = 0;
 	ctx.exentry_idx = 0;
+	ctx.write = true;
 
 	build_prologue(&ctx, was_classic);
 
+	/* Record exentry_idx and body_idx before first build_body */
+	exentry_idx = ctx.exentry_idx;
+	body_idx = ctx.idx;
+	/* Dont write body instructions to memory for now */
+	ctx.write = false;
+
 	if (build_body(&ctx, extra_pass)) {
 		prog = orig_prog;
 		goto out_free_hdr;
 	}
 
+	ctx.epilogue_offset = ctx.idx;
+	ctx.exentry_idx = exentry_idx;
+	ctx.idx = body_idx;
+	ctx.write = true;
+
+	/* Pass 3: Adjust jump offset and write final image */
+	if (build_body(&ctx, extra_pass) ||
+		WARN_ON_ONCE(ctx.idx != ctx.epilogue_offset)) {
+		prog = orig_prog;
+		goto out_free_hdr;
+	}
+
 	build_epilogue(&ctx);
 	build_plt(&ctx);
 
-	/* 3. Extra pass to validate JITed code. */
+	/* Extra pass to validate JITed code. */
 	if (validate_ctx(&ctx)) {
 		prog = orig_prog;
 		goto out_free_hdr;
 	}
 
+	/* update the real prog size */
+	prog_size = sizeof(u32) * ctx.idx;
+
 	/* And we're done. */
 	if (bpf_jit_enable > 1)
 		bpf_jit_dump(prog->len, prog_size, 2, ctx.image);
 
 	if (!prog->is_func || extra_pass) {
-		if (extra_pass && ctx.idx != jit_data->ctx.idx) {
-			pr_err_once("multi-func JIT bug %d != %d\n",
+		/* The jited image may shrink since the jited result for
+		 * BPF_CALL to subprog may be changed from indirect call
+		 * to direct call.
+		 */
+		if (extra_pass && ctx.idx > jit_data->ctx.idx) {
+			pr_err_once("multi-func JIT bug %d > %d\n",
 				    ctx.idx, jit_data->ctx.idx);
 			prog->bpf_func = NULL;
 			prog->jited = 0;
@@ -2315,6 +2373,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *ro_image,
 		.image = image,
 		.ro_image = ro_image,
 		.idx = 0,
+		.write = true,
 	};
 
 	nregs = btf_func_model_nregs(m);
-- 
2.39.2


