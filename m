Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3565AB536
	for <lists+bpf@lfdr.de>; Fri,  2 Sep 2022 17:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236943AbiIBPbn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Sep 2022 11:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236413AbiIBPbM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Sep 2022 11:31:12 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6D5F2C9F;
        Fri,  2 Sep 2022 08:12:43 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MK1ZT5gSzzKKRj;
        Fri,  2 Sep 2022 23:10:57 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
        by APP3 (Coremail) with SMTP id _Ch0CgBn4UhlHRJja8YAAQ--.58277S3;
        Fri, 02 Sep 2022 23:12:40 +0800 (CST)
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
Subject: [PATCH bpf-next 1/2] bpf, arm64: Jit BPF_CALL to direct call when possible
Date:   Fri,  2 Sep 2022 11:20:41 -0400
Message-Id: <20220902152043.721806-2-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220902152043.721806-1-xukuohai@huaweicloud.com>
References: <20220902152043.721806-1-xukuohai@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgBn4UhlHRJja8YAAQ--.58277S3
X-Coremail-Antispam: 1UD129KBjvJXoW3JrykurWkKFWfJr1kCF43Awb_yoWxGFyUpa
        9rGw1YkrW8Xr47GFs7J3WkAry3Kws5W347KryfurWFkas0qr93Gan8K34a9FZxAr95Cr1x
        ZFWqyry3ua1UJrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
        A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
        0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
        JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwI
        xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
        Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7
        IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
        6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jn9N3UUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Xu Kuohai <xukuohai@huawei.com>

Currently BPF_CALL is always jited to indirect call, but when target is
in the range of direct call, a BPF_CALL can be jited to direct call.

For example, the following BPF_CALL

    call __htab_map_lookup_elem

is always jited to an indirect call:

    mov     x10, #0xffffffffffff18f4
    movk    x10, #0x821, lsl #16
    movk    x10, #0x8000, lsl #32
    blr     x10

When the target is in the range of a direct call, it can be jited to:

    bl      0xfffffffffd33bc98

This patch does such jit when possible.

1. Before allocating jit image memory, jit all BPF_CALL to indirect call,
   so we could get the maximum image size at the end.

2. Allocate jit image memory with the maximum image size.

3. Since we have now allocated jit image memory, every jited instruction
   address is determined, so the distance to call target is determined,
   so whether a BPF_CALL can be jited to direct call is determined.

4. Since step 3 may adjust the position of jited instructions, update the
   offset of jump instructions whose target is within the jit image.

Tested with test_bpf.ko and some arm64 working selftests, nothing failed.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 arch/arm64/net/bpf_jit_comp.c | 71 ++++++++++++++++++++++++++++-------
 1 file changed, 58 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 389623ae5a91..69eb29f397e5 100644
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
+	int body_offset;
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
+	body_offset = ctx.idx;
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
+	ctx.idx = body_offset;
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

