Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8543F5AB535
	for <lists+bpf@lfdr.de>; Fri,  2 Sep 2022 17:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236496AbiIBPbo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Sep 2022 11:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236489AbiIBPbO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Sep 2022 11:31:14 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB35F2D73;
        Fri,  2 Sep 2022 08:12:44 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MK1Zp3RpjzlCGx;
        Fri,  2 Sep 2022 23:11:14 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
        by APP3 (Coremail) with SMTP id _Ch0CgBn4UhlHRJja8YAAQ--.58277S4;
        Fri, 02 Sep 2022 23:12:42 +0800 (CST)
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
Subject: [PATCH bpf-next 2/2] bpf, arm64: Eliminate false -EFBIG error in bpf trampoline
Date:   Fri,  2 Sep 2022 11:20:42 -0400
Message-Id: <20220902152043.721806-3-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220902152043.721806-1-xukuohai@huaweicloud.com>
References: <20220902152043.721806-1-xukuohai@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgBn4UhlHRJja8YAAQ--.58277S4
X-Coremail-Antispam: 1UD129KBjvJXoW3Jr4UGw18CrWkWrWUur4Durg_yoWxAF4rpa
        yDGw4YyFW8Xrs8Wa1kXFWUAF1akw1qgry7CrWUG3yS9a4YqryDGa4UGFyYvrW5urZ5Ar1x
        ZF4qyF98CrWxGwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAI
        w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
        0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1sa9DUUUUU==
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

With jiting BPF_CALL to indirect call or direct call based on the jump
distance, the bpf trampoline size calculated with NULL image address
may be larger than the actual size needed, resulting in a fake -EFBIG
error.

So remove the estimate of the bpf trampoline size based on NULL image
address, and check if there is enough space when emitting instructions.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 arch/arm64/net/bpf_jit_comp.c | 67 ++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 37 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 69eb29f397e5..34d78ca16beb 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -73,6 +73,7 @@ struct jit_ctx {
 	const struct bpf_prog *prog;
 	int idx;
 	bool write;
+	int max_insns;
 	int epilogue_offset;
 	int *offset;
 	int exentry_idx;
@@ -90,11 +91,15 @@ struct bpf_plt {
 #define PLT_TARGET_SIZE   sizeof_field(struct bpf_plt, target)
 #define PLT_TARGET_OFFSET offsetof(struct bpf_plt, target)
 
-static inline void emit(const u32 insn, struct jit_ctx *ctx)
+static inline void __emit(u32 insn, struct jit_ctx *ctx, int idx)
 {
-	if (ctx->image != NULL && ctx->write)
-		ctx->image[ctx->idx] = cpu_to_le32(insn);
+	if (ctx->image != NULL && ctx->write && idx < ctx->max_insns)
+		ctx->image[idx] = cpu_to_le32(insn);
+}
 
+static inline void emit(u32 insn, struct jit_ctx *ctx)
+{
+	__emit(insn, ctx, ctx->idx);
 	ctx->idx++;
 }
 
@@ -1544,6 +1549,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	build_epilogue(&ctx);
 	build_plt(&ctx);
 
+	ctx.max_insns = ctx.idx;
 	extable_align = __alignof__(struct exception_table_entry);
 	extable_size = prog->aux->num_exentries *
 		sizeof(struct exception_table_entry);
@@ -1603,7 +1609,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	build_plt(&ctx);
 
 	/* 3. Extra pass to validate JITed code. */
-	if (validate_ctx(&ctx)) {
+	if (WARN_ON_ONCE(ctx.idx > ctx.max_insns) || validate_ctx(&ctx)) {
 		bpf_jit_binary_free(header);
 		prog = orig_prog;
 		goto out_off;
@@ -1687,7 +1693,7 @@ static void invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_link *l,
 			    int args_off, int retval_off, int run_ctx_off,
 			    bool save_ret)
 {
-	__le32 *branch;
+	int bridx;
 	u64 enter_prog;
 	u64 exit_prog;
 	struct bpf_prog *p = l->link.prog;
@@ -1725,7 +1731,7 @@ static void invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_link *l,
 	/* if (__bpf_prog_enter(prog) == 0)
 	 *         goto skip_exec_of_prog;
 	 */
-	branch = ctx->image + ctx->idx;
+	bridx = ctx->idx;
 	emit(A64_NOP, ctx);
 
 	/* save return value to callee saved register x20 */
@@ -1740,10 +1746,7 @@ static void invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_link *l,
 	if (save_ret)
 		emit(A64_STR64I(A64_R(0), A64_SP, retval_off), ctx);
 
-	if (ctx->image) {
-		int offset = &ctx->image[ctx->idx] - branch;
-		*branch = cpu_to_le32(A64_CBZ(1, A64_R(0), offset));
-	}
+	__emit(A64_CBZ(1, A64_R(0), ctx->idx - bridx), ctx, bridx);
 
 	/* arg1: prog */
 	emit(A64_MOV(1, A64_R(0), A64_R(19)), ctx);
@@ -1757,7 +1760,7 @@ static void invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_link *l,
 
 static void invoke_bpf_mod_ret(struct jit_ctx *ctx, struct bpf_tramp_links *tl,
 			       int args_off, int retval_off, int run_ctx_off,
-			       __le32 **branches)
+			       int *bridx)
 {
 	int i;
 
@@ -1775,7 +1778,7 @@ static void invoke_bpf_mod_ret(struct jit_ctx *ctx, struct bpf_tramp_links *tl,
 		/* Save the location of branch, and generate a nop.
 		 * This nop will be replaced with a cbnz later.
 		 */
-		branches[i] = ctx->image + ctx->idx;
+		bridx[i] = ctx->idx;
 		emit(A64_NOP, ctx);
 	}
 }
@@ -1828,7 +1831,7 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
 	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
 	bool save_ret;
-	__le32 **branches = NULL;
+	int *bridx = NULL;
 
 	/* trampoline stack layout:
 	 *                  [ parent ip         ]
@@ -1936,13 +1939,12 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 				flags & BPF_TRAMP_F_RET_FENTRY_RET);
 
 	if (fmod_ret->nr_links) {
-		branches = kcalloc(fmod_ret->nr_links, sizeof(__le32 *),
-				   GFP_KERNEL);
-		if (!branches)
+		bridx = kcalloc(fmod_ret->nr_links, sizeof(int), GFP_KERNEL);
+		if (!bridx)
 			return -ENOMEM;
 
 		invoke_bpf_mod_ret(ctx, fmod_ret, args_off, retval_off,
-				   run_ctx_off, branches);
+				   run_ctx_off, bridx);
 	}
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
@@ -1957,11 +1959,10 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 		emit(A64_NOP, ctx);
 	}
 
-	/* update the branches saved in invoke_bpf_mod_ret with cbnz */
-	for (i = 0; i < fmod_ret->nr_links && ctx->image != NULL; i++) {
-		int offset = &ctx->image[ctx->idx] - branches[i];
-		*branches[i] = cpu_to_le32(A64_CBNZ(1, A64_R(10), offset));
-	}
+	/* update the bridx saved in invoke_bpf_mod_ret with cbnz */
+	for (i = 0; i < fmod_ret->nr_links; i++)
+		__emit(A64_CBNZ(1, A64_R(10), ctx->idx - bridx[i]), ctx,
+		       bridx[i]);
 
 	for (i = 0; i < fexit->nr_links; i++)
 		invoke_bpf_prog(ctx, fexit->links[i], args_off, retval_off,
@@ -2004,7 +2005,7 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	if (ctx->image)
 		bpf_flush_icache(ctx->image, ctx->image + ctx->idx);
 
-	kfree(branches);
+	kfree(bridx);
 
 	return ctx->idx;
 }
@@ -2018,35 +2019,27 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,
 	int nargs = m->nr_args;
 	int max_insns = ((long)image_end - (long)image) / AARCH64_INSN_SIZE;
 	struct jit_ctx ctx = {
-		.image = NULL,
+		.image = image,
 		.idx = 0,
 		.write = true,
+		.max_insns = max_insns,
 	};
 
 	/* the first 8 arguments are passed by registers */
 	if (nargs > 8)
 		return -ENOTSUPP;
 
+	jit_fill_hole(image, (unsigned int)(image_end - image));
+
 	ret = prepare_trampoline(&ctx, im, tlinks, orig_call, nargs, flags);
+
 	if (ret < 0)
 		return ret;
 
 	if (ret > max_insns)
 		return -EFBIG;
 
-	ctx.image = image;
-	ctx.idx = 0;
-
-	jit_fill_hole(image, (unsigned int)(image_end - image));
-	ret = prepare_trampoline(&ctx, im, tlinks, orig_call, nargs, flags);
-
-	if (ret > 0 && validate_code(&ctx) < 0)
-		ret = -EINVAL;
-
-	if (ret > 0)
-		ret *= AARCH64_INSN_SIZE;
-
-	return ret;
+	return validate_code(&ctx) < 0 ? -EINVAL : ret * AARCH64_INSN_SIZE;
 }
 
 static bool is_long_jump(void *ip, void *target)
-- 
2.30.2

