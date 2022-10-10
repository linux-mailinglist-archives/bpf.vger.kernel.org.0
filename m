Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335505F9C06
	for <lists+bpf@lfdr.de>; Mon, 10 Oct 2022 11:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbiJJJfM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Oct 2022 05:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbiJJJfK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Oct 2022 05:35:10 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E2A738684;
        Mon, 10 Oct 2022 02:35:02 -0700 (PDT)
Received: from bogon.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxrms850NjA_0pAA--.6245S2;
        Mon, 10 Oct 2022 17:34:52 +0800 (CST)
From:   Youling Tang <tangyouling@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH 7/7] LoongArch: bpf: Add BPF exception tables
Date:   Mon, 10 Oct 2022 17:34:52 +0800
Message-Id: <1665394492-14209-1-git-send-email-tangyouling@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf8Cxrms850NjA_0pAA--.6245S2
X-Coremail-Antispam: 1UD129KBjvJXoW3JFy3AF48Jw48WF4UtFW3GFg_yoWfXw1rpF
        WDA3Z5GrWrWr4xWF48JFW7Zr13Kws7Gw12qFWFk34Fva12qr1rGF18KF9IgFZ8A3ykWF1x
        Xa1Fkry29a1rA37anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvlb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4
        vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kI
        c2xKxwCY02Avz4vE14v_GFWl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
        1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
        14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7
        IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
        z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvj
        DU0xZFpf9x07bF3ktUUUUU=
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Inspired by commit 800834285361("bpf, arm64: Add BPF exception tables"),
do similar to LoongArch to add BPF exception tables.

When a tracing BPF program attempts to read memory without using the
bpf_probe_read() helper, the verifier marks the load instruction with
the BPF_PROBE_MEM flag. Since the LoongArch JIT does not currently
recognize this flag it falls back to the interpreter.

Add support for BPF_PROBE_MEM, by appending an exception table to the
BPF program. If the load instruction causes a data abort, the fixup
infrastructure finds the exception table and fixes up the fault, by
clearing the destination register and jumping over the faulting
instruction.

To keep the compact exception table entry format, inspect the pc in
fixup_exception(). A more generic solution would add a "handler" field
to the table entry, like on x86 and arm64 etc.

Signed-off-by: Youling Tang <tangyouling@loongson.cn>
---
 arch/loongarch/include/asm/asm-extable.h |  1 +
 arch/loongarch/include/asm/extable.h     | 12 ++++
 arch/loongarch/mm/extable.c              |  2 +
 arch/loongarch/net/bpf_jit.c             | 84 ++++++++++++++++++++++--
 arch/loongarch/net/bpf_jit.h             |  2 +
 5 files changed, 96 insertions(+), 5 deletions(-)

diff --git a/arch/loongarch/include/asm/asm-extable.h b/arch/loongarch/include/asm/asm-extable.h
index f5502cb50c6e..df05005f2b80 100644
--- a/arch/loongarch/include/asm/asm-extable.h
+++ b/arch/loongarch/include/asm/asm-extable.h
@@ -5,6 +5,7 @@
 #define EX_TYPE_NONE			0
 #define EX_TYPE_FIXUP			1
 #define EX_TYPE_UACCESS_ERR_ZERO	2
+#define EX_TYPE_BPF			3
 
 #ifdef __ASSEMBLY__
 
diff --git a/arch/loongarch/include/asm/extable.h b/arch/loongarch/include/asm/extable.h
index 92612b4364a1..9f15f545e664 100644
--- a/arch/loongarch/include/asm/extable.h
+++ b/arch/loongarch/include/asm/extable.h
@@ -32,6 +32,18 @@ do {							\
 	(b)->data = (tmp).data;				\
 } while (0)
 
+#ifdef CONFIG_BPF_JIT
+bool ex_handler_bpf(const struct exception_table_entry *ex,
+		    struct pt_regs *regs);
+#else
+static inline
+bool ex_handler_bpf(const struct exception_table_entry *ex,
+		    struct pt_regs *regs)
+{
+	return false;
+}
+#endif /* !CONFIG_BPF_JIT */
+
 bool fixup_exception(struct pt_regs *regs);
 
 #endif
diff --git a/arch/loongarch/mm/extable.c b/arch/loongarch/mm/extable.c
index e6871edd0631..3bb90c705b1b 100644
--- a/arch/loongarch/mm/extable.c
+++ b/arch/loongarch/mm/extable.c
@@ -58,6 +58,8 @@ bool fixup_exception(struct pt_regs *regs)
 		return ex_handler_fixup(ex, regs);
 	case EX_TYPE_UACCESS_ERR_ZERO:
 		return ex_handler_uaccess_err_zero(ex, regs);
+	case EX_TYPE_BPF:
+		return ex_handler_bpf(ex, regs);
 	}
 
 	BUG();
diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 9963ae69b2aa..ce96d38000e4 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -388,6 +388,63 @@ static bool is_signed_bpf_cond(u8 cond)
 	       cond == BPF_JSGE || cond == BPF_JSLE;
 }
 
+#define BPF_FIXUP_OFFSET_MASK	GENMASK(26, 0)
+#define BPF_FIXUP_REG_MASK	GENMASK(31, 27)
+
+bool ex_handler_bpf(const struct exception_table_entry *ex,
+		    struct pt_regs *regs)
+{
+	off_t offset = FIELD_GET(BPF_FIXUP_OFFSET_MASK, ex->fixup);
+	int dst_reg = FIELD_GET(BPF_FIXUP_REG_MASK, ex->fixup);
+
+	regs->regs[dst_reg] = 0;
+	regs->csr_era = (unsigned long)&ex->fixup - offset;
+	return true;
+}
+
+/* For accesses to BTF pointers, add an entry to the exception table */
+static int add_exception_handler(const struct bpf_insn *insn,
+				 struct jit_ctx *ctx,
+				 int dst_reg)
+{
+	struct exception_table_entry *ex;
+	unsigned long pc;
+	off_t offset;
+
+	if (!ctx->image || !ctx->prog->aux->extable || BPF_MODE(insn->code) != BPF_PROBE_MEM)
+		return 0;
+
+	if (WARN_ON_ONCE(ctx->num_exentries >= ctx->prog->aux->num_exentries))
+		return -EINVAL;
+
+	ex = &ctx->prog->aux->extable[ctx->num_exentries];
+	pc = (unsigned long)&ctx->image[ctx->idx - 1];
+
+	offset = pc - (long)&ex->insn;
+	if (WARN_ON_ONCE(offset >= 0 || offset < INT_MIN))
+		return -ERANGE;
+	ex->insn = offset;
+
+	/*
+	 * Since the extable follows the program, the fixup offset is always
+	 * negative and limited to BPF_JIT_REGION_SIZE. Store a positive value
+	 * to keep things simple, and put the destination register in the upper
+	 * bits. We don't need to worry about buildtime or runtime sort
+	 * modifying the upper bits because the table is already sorted, and
+	 * isn't part of the main exception table.
+	 */
+	offset = (long)&ex->fixup - (pc + LOONGARCH_INSN_SIZE);
+	if (!FIELD_FIT(BPF_FIXUP_OFFSET_MASK, offset))
+		return -ERANGE;
+
+	ex->fixup = FIELD_PREP(BPF_FIXUP_OFFSET_MASK, offset) |
+		FIELD_PREP(BPF_FIXUP_REG_MASK, dst_reg);
+	ex->type = EX_TYPE_BPF;
+
+	ctx->num_exentries++;
+	return 0;
+}
+
 static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool extra_pass)
 {
 	const bool is32 = BPF_CLASS(insn->code) == BPF_ALU ||
@@ -821,6 +878,10 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 	case BPF_LDX | BPF_MEM | BPF_H:
 	case BPF_LDX | BPF_MEM | BPF_W:
 	case BPF_LDX | BPF_MEM | BPF_DW:
+	case BPF_LDX | BPF_PROBE_MEM | BPF_DW:
+	case BPF_LDX | BPF_PROBE_MEM | BPF_W:
+	case BPF_LDX | BPF_PROBE_MEM | BPF_H:
+	case BPF_LDX | BPF_PROBE_MEM | BPF_B:
 		switch (BPF_SIZE(code)) {
 		case BPF_B:
 			if (is_signed_imm12(off)) {
@@ -859,6 +920,10 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 			}
 			break;
 		}
+
+		ret = add_exception_handler(insn, ctx, dst);
+		if (ret)
+			return ret;
 		break;
 
 	/* *(size *)(dst + off) = imm */
@@ -1024,6 +1089,9 @@ static int validate_code(struct jit_ctx *ctx)
 			return -1;
 	}
 
+	if (WARN_ON_ONCE(ctx->num_exentries != ctx->prog->aux->num_exentries))
+		return -1;
+
 	return 0;
 }
 
@@ -1031,7 +1099,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 {
 	bool tmp_blinded = false, extra_pass = false;
 	u8 *image_ptr;
-	int image_size;
+	int image_size, prog_size, extable_size;
 	struct jit_ctx ctx;
 	struct jit_data *jit_data;
 	struct bpf_binary_header *header;
@@ -1072,7 +1140,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		image_ptr = jit_data->image;
 		header = jit_data->header;
 		extra_pass = true;
-		image_size = sizeof(u32) * ctx.idx;
+		prog_size = sizeof(u32) * ctx.idx;
 		goto skip_init_ctx;
 	}
 
@@ -1094,12 +1162,15 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	ctx.epilogue_offset = ctx.idx;
 	build_epilogue(&ctx);
 
+	extable_size = prog->aux->num_exentries * sizeof(struct exception_table_entry);
+
 	/* Now we know the actual image size.
 	 * As each LoongArch instruction is of length 32bit,
 	 * we are translating number of JITed intructions into
 	 * the size required to store these JITed code.
 	 */
-	image_size = sizeof(u32) * ctx.idx;
+	prog_size = sizeof(u32) * ctx.idx;
+	image_size = prog_size + extable_size;
 	/* Now we know the size of the structure to make */
 	header = bpf_jit_binary_alloc(image_size, &image_ptr,
 				      sizeof(u32), jit_fill_hole);
@@ -1110,9 +1181,12 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 
 	/* 2. Now, the actual pass to generate final JIT code */
 	ctx.image = (union loongarch_instruction *)image_ptr;
+	if (extable_size)
+		prog->aux->extable = (void *)image_ptr + prog_size;
 
 skip_init_ctx:
 	ctx.idx = 0;
+	ctx.num_exentries = 0;
 
 	build_prologue(&ctx);
 	if (build_body(&ctx, extra_pass)) {
@@ -1131,7 +1205,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 
 	/* And we're done */
 	if (bpf_jit_enable > 1)
-		bpf_jit_dump(prog->len, image_size, 2, ctx.image);
+		bpf_jit_dump(prog->len, prog_size, 2, ctx.image);
 
 	/* Update the icache */
 	flush_icache_range((unsigned long)header, (unsigned long)(ctx.image + ctx.idx));
@@ -1153,7 +1227,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		jit_data->header = header;
 	}
 	prog->jited = 1;
-	prog->jited_len = image_size;
+	prog->jited_len = prog_size;
 	prog->bpf_func = (void *)ctx.image;
 
 	if (!prog->is_func || extra_pass) {
diff --git a/arch/loongarch/net/bpf_jit.h b/arch/loongarch/net/bpf_jit.h
index e665ddb0aeb8..ca708024fdd3 100644
--- a/arch/loongarch/net/bpf_jit.h
+++ b/arch/loongarch/net/bpf_jit.h
@@ -4,6 +4,7 @@
  *
  * Copyright (C) 2022 Loongson Technology Corporation Limited
  */
+#include <linux/bitfield.h>
 #include <linux/bpf.h>
 #include <linux/filter.h>
 #include <asm/cacheflush.h>
@@ -15,6 +16,7 @@ struct jit_ctx {
 	unsigned int flags;
 	unsigned int epilogue_offset;
 	u32 *offset;
+	int num_exentries;
 	union loongarch_instruction *image;
 	u32 stack_size;
 };
-- 
2.36.1

