Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4817F5BC4F0
	for <lists+bpf@lfdr.de>; Mon, 19 Sep 2022 11:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbiISJEi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Sep 2022 05:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiISJEg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Sep 2022 05:04:36 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCA9B79;
        Mon, 19 Sep 2022 02:04:32 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MWJbv3XQ6zlBqw;
        Mon, 19 Sep 2022 17:02:51 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
        by APP2 (Coremail) with SMTP id Syh0CgDHY22cMChjI49JBA--.48437S3;
        Mon, 19 Sep 2022 17:04:31 +0800 (CST)
From:   Xu Kuohai <xukuohai@huaweicloud.com>
To:     bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Zi Shen Lim <zlim.lnx@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [RESEND PATCH bpf-next 1/2] bpf, arm64: Jit BPF_CALL to direct call when possible
Date:   Mon, 19 Sep 2022 05:21:37 -0400
Message-Id: <20220919092138.1027353-2-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220919092138.1027353-1-xukuohai@huaweicloud.com>
References: <20220919092138.1027353-1-xukuohai@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgDHY22cMChjI49JBA--.48437S3
X-Coremail-Antispam: 1UD129KBjvJXoW3JrW8tr4UuF15ury7Jw1rXrb_yoWxCFW5pa
        9xGw1YkrW8XrWUGFs7JF4kAry3Kws5W347Gry8u3yFkas0gr93Gan8K34a9FZ8Ar95Zr1x
        XF4qyry3ua1UJrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
        A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
        8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
        0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7TKZDUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Xu Kuohai <xukuohai@huawei.com>

Currently BPF_CALL is always jited to indirect call, but when target is
in the range of direct call, BPF_CALL can be jited to direct call.

For example, the following BPF_CALL

    call __htab_map_lookup_elem

is always jited to an indirect call:

    mov     x10, #0xffffffffffff18f4
    movk    x10, #0x821, lsl #16
    movk    x10, #0x8000, lsl #32
    blr     x10

When the target is in the range of direct call, it can be jited to:

    bl      0xfffffffffd33bc98

This patch does such jit when possible.

1. First pass, get the maximum jited image size. Since the jited image
   memory is not allocated yet, the distance between jited BPF_CALL
   instructon and call target is unknown, so jit all BPF_CALL to indirect
   call to get the maximum image size.

2. Allocate image memory with the size caculated in step 1.

3. Second pass, determine the jited address and size for every bpf instruction.
   Since image memory is now allocated and there is only one jit method for
   bpf instructions other than BPF_CALL, so the jited address for the first
   BPF_CALL is determined, so the distance to call target is determined, so
   the first BPF_CALL is determined to be jited to direct or indirect call,
   so the jited image size after the first BPF_CALL is determined. By analogy,
   the jited addresses and sizes for all subsequent BPF instructions are
   determined.

4. Last pass, generate the final image. The jump offset of jump instruction
   whose target is within the jited image is determined in this pass, since
   the target instruction address may be changed in step 3.

Tested with test_bpf.ko and some arm64 working selftests, nothing failed.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 arch/arm64/net/bpf_jit_comp.c | 71 ++++++++++++++++++++++++++++-------
 1 file changed, 58 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 30f76178608b..06437e34614b 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -72,6 +72,7 @@ static const int bpf2a64[] = {
 struct jit_ctx {
 	const struct bpf_prog *prog;
 	int idx;
+	bool write;
 	int epilogue_offset;
 	int *offset;
 	int exentry_idx;
@@ -91,7 +92,7 @@ struct bpf_plt {
 
 static inline void emit(const u32 insn, struct jit_ctx *ctx)
 {
-	if (ctx->image != NULL)
+	if (ctx->image != NULL && ctx->write)
 		ctx->image[ctx->idx] = cpu_to_le32(insn);
 
 	ctx->idx++;
@@ -178,10 +179,29 @@ static inline void emit_addr_mov_i64(const int reg, const u64 val,
 
 static inline void emit_call(u64 target, struct jit_ctx *ctx)
 {
-	u8 tmp = bpf2a64[TMP_REG_1];
+	u8 tmp;
+	long offset;
+	unsigned long pc;
+	u32 insn = AARCH64_BREAK_FAULT;
+
+	/* if ctx->image == NULL or target == 0, the jump distance is unknown,
+	 * emit indirect call.
+	 */
+	if (ctx->image && target) {
+		pc = (unsigned long)&ctx->image[ctx->idx];
+		offset = (long)target - (long)pc;
+		if (offset >= -SZ_128M && offset < SZ_128M)
+			insn = aarch64_insn_gen_branch_imm(pc, target,
+					AARCH64_INSN_BRANCH_LINK);
+	}
 
-	emit_addr_mov_i64(tmp, target, ctx);
-	emit(A64_BLR(tmp), ctx);
+	if (insn == AARCH64_BREAK_FAULT) {
+		tmp = bpf2a64[TMP_REG_1];
+		emit_addr_mov_i64(tmp, target, ctx);
+		emit(A64_BLR(tmp), ctx);
+	} else {
+		emit(insn, ctx);
+	}
 }
 
 static inline int bpf2a64_offset(int bpf_insn, int off,
@@ -1392,13 +1412,11 @@ static int build_body(struct jit_ctx *ctx, bool extra_pass)
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
@@ -1409,8 +1427,7 @@ static int build_body(struct jit_ctx *ctx, bool extra_pass)
 	 * the last element with the offset after the last
 	 * instruction (end of program)
 	 */
-	if (ctx->image == NULL)
-		ctx->offset[i] = ctx->idx;
+	ctx->offset[i] = ctx->idx;
 
 	return 0;
 }
@@ -1461,6 +1478,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	bool extra_pass = false;
 	struct jit_ctx ctx;
 	u8 *image_ptr;
+	int body_idx;
+	int exentry_idx;
 
 	if (!prog->jit_requested)
 		return orig_prog;
@@ -1515,6 +1534,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		goto out_off;
 	}
 
+	/* Get the max image size */
 	if (build_body(&ctx, extra_pass)) {
 		prog = orig_prog;
 		goto out_off;
@@ -1528,7 +1548,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	extable_size = prog->aux->num_exentries *
 		sizeof(struct exception_table_entry);
 
-	/* Now we know the actual image size. */
+	/* Now we know the max image size. */
 	prog_size = sizeof(u32) * ctx.idx;
 	/* also allocate space for plt target */
 	extable_offset = round_up(prog_size + PLT_TARGET_SIZE, extable_align);
@@ -1548,15 +1568,37 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 skip_init_ctx:
 	ctx.idx = 0;
 	ctx.exentry_idx = 0;
+	ctx.write = true;
 
 	build_prologue(&ctx, was_classic);
 
+	/* Record exentry_idx and ctx.idx before first build_body */
+	exentry_idx = ctx.exentry_idx;
+	body_idx = ctx.idx;
+	/* Don't write instruction to memory for now */
+	ctx.write = false;
+
+	/* Determine call distance and instruction position */
 	if (build_body(&ctx, extra_pass)) {
 		bpf_jit_binary_free(header);
 		prog = orig_prog;
 		goto out_off;
 	}
 
+	ctx.epilogue_offset = ctx.idx;
+
+	ctx.exentry_idx = exentry_idx;
+	ctx.idx = body_idx;
+	ctx.write = true;
+
+	/* Determine jump offset and write result to memory */
+	if (build_body(&ctx, extra_pass) ||
+		WARN_ON_ONCE(ctx.idx != ctx.epilogue_offset)) {
+		bpf_jit_binary_free(header);
+		prog = orig_prog;
+		goto out_off;
+	}
+
 	build_epilogue(&ctx);
 	build_plt(&ctx);
 
@@ -1567,6 +1609,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		goto out_off;
 	}
 
+	/* Update prog size */
+	prog_size = sizeof(u32) * ctx.idx;
 	/* And we're done. */
 	if (bpf_jit_enable > 1)
 		bpf_jit_dump(prog->len, prog_size, 2, ctx.image);
@@ -1574,8 +1618,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	bpf_flush_icache(header, ctx.image + ctx.idx);
 
 	if (!prog->is_func || extra_pass) {
-		if (extra_pass && ctx.idx != jit_data->ctx.idx) {
-			pr_err_once("multi-func JIT bug %d != %d\n",
+		if (extra_pass && ctx.idx > jit_data->ctx.idx) {
+			pr_err_once("multi-func JIT bug %d > %d\n",
 				    ctx.idx, jit_data->ctx.idx);
 			bpf_jit_binary_free(header);
 			prog->bpf_func = NULL;
@@ -1976,6 +2020,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,
 	struct jit_ctx ctx = {
 		.image = NULL,
 		.idx = 0,
+		.write = true,
 	};
 
 	/* the first 8 arguments are passed by registers */
-- 
2.30.2

