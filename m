Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D92F230DF9
	for <lists+bpf@lfdr.de>; Tue, 28 Jul 2020 17:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730886AbgG1Pf5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jul 2020 11:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730824AbgG1Pf4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jul 2020 11:35:56 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373CCC061794
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2020 08:35:56 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id v22so4367110edy.0
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2020 08:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BjK0fVWFJiMws8QPjlt9HONfEvKj0VRNpyzBP7kwY2U=;
        b=yjnsK+f8xjIJr4+eVpn8whClF5jHpkFXj2aV06CuRYqJQ20NcA79HT0waJEZ3Snvd7
         h0r0r9C3pTVn0Ut04MVD7a/4HC3V1kf+4oN/pu2utgG/+L3/PNUggZk0IEPIHFvq1WFF
         E6nJAZp+bE847ehDv0cXzxF2/lpv/B49QeTCTqAaUcs3yljVNpJMlwDtHyeu87FCXB2t
         N8SHtxOnI7xPW2MMpwXzeA2vLSttJLsV1zNEH2lx0Y+ksUYhjmhldPtOz0Q954zd+DmV
         MVkXWJL7HtSSKv3ujn0C8/Cn1YduVyMvmEYkfhUzzCnDU2X/TNhzfERNqf3LrX3pSnHP
         Ckbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BjK0fVWFJiMws8QPjlt9HONfEvKj0VRNpyzBP7kwY2U=;
        b=fWbvmcOdOotvXuoOwphPGp0IB6Rekk15qTCqIB2zNY2M5Cvev0px7oqOHehp5QW9nv
         wgdpfH5IAfKqxCbJgzVIwfoORFF8B/p0EvnOPLb59J6waV8Se04Lf+9ISkJtWQk6jvx9
         Ej+LeyIeFacIgfwuqQBwRQMEmQRfwbgzz92na8R7t+vcMeknsG0V0QH3HL+gA50tbr9t
         J53owCyq7iv4Dz5XDlZNR56USLAJo/jAjGLT6HrOd6D42tPZomk/+d9FEUmmEskO/DkT
         Ynhp1pOIsLaoRYiIjd7UPPw/kDUtT5W5cMZTnIa/r6sMzcwi6yPwv9Umjii/clQCC9LP
         XYFA==
X-Gm-Message-State: AOAM5336nsu8u70VjGZjbcF/DdOA6W15fstCwUKVJSDzP6+ahQyXfTx3
        QSYa01VQkZjwBcsUYjwnL8N+GQ==
X-Google-Smtp-Source: ABdhPJwnqY3VGhYzh7meof7lOJH4J3+Bt+zxMUOHzc7owjBUWwo0Sljh/eB5aYUjliMDXHK3Zu/6XA==
X-Received: by 2002:a05:6402:204e:: with SMTP id bc14mr27184609edb.128.1595950554815;
        Tue, 28 Jul 2020 08:35:54 -0700 (PDT)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id ce12sm10217235edb.4.2020.07.28.08.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 08:35:54 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, daniel@iogearbox.net,
        ast@kernel.org, zlim.lnx@gmail.com, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, andriin@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH bpf-next 1/1] arm64: bpf: Add BPF exception tables
Date:   Tue, 28 Jul 2020 17:21:26 +0200
Message-Id: <20200728152122.1292756-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200728152122.1292756-1-jean-philippe@linaro.org>
References: <20200728152122.1292756-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When a tracing BPF program attempts to read memory without using the
bpf_probe_read() helper, the verifier marks the load instruction with
the BPF_PROBE_MEM flag. Since the arm64 JIT does not currently recognize
this flag it falls back to the interpreter.

Add support for BPF_PROBE_MEM, by appending an exception table to the
BPF program. If the load instruction causes a data abort, the fixup
infrastructure finds the exception table and fixes up the fault, by
clearing the destination register and jumping over the faulting
instruction.

To keep the compact exception table entry format, inspect the pc in
fixup_exception(). A more generic solution would add a "handler" field
to the table entry, like on x86 and s390.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
Note: the extable is aligned on 32 bits. Given that extable entries have
32-bit members I figured we don't need to align it to 64 bits.
---
 arch/arm64/include/asm/extable.h |  3 ++
 arch/arm64/mm/extable.c          | 11 ++--
 arch/arm64/net/bpf_jit_comp.c    | 93 +++++++++++++++++++++++++++++---
 3 files changed, 98 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/extable.h b/arch/arm64/include/asm/extable.h
index 56a4f68b262e..bcee40df1586 100644
--- a/arch/arm64/include/asm/extable.h
+++ b/arch/arm64/include/asm/extable.h
@@ -22,5 +22,8 @@ struct exception_table_entry
 
 #define ARCH_HAS_RELATIVE_EXTABLE
 
+int arm64_bpf_fixup_exception(const struct exception_table_entry *ex,
+			      struct pt_regs *regs);
+
 extern int fixup_exception(struct pt_regs *regs);
 #endif
diff --git a/arch/arm64/mm/extable.c b/arch/arm64/mm/extable.c
index 81e694af5f8c..1f42991cacdd 100644
--- a/arch/arm64/mm/extable.c
+++ b/arch/arm64/mm/extable.c
@@ -11,8 +11,13 @@ int fixup_exception(struct pt_regs *regs)
 	const struct exception_table_entry *fixup;
 
 	fixup = search_exception_tables(instruction_pointer(regs));
-	if (fixup)
-		regs->pc = (unsigned long)&fixup->fixup + fixup->fixup;
+	if (!fixup)
+		return 0;
 
-	return fixup != NULL;
+	if (regs->pc >= BPF_JIT_REGION_START &&
+	    regs->pc < BPF_JIT_REGION_END)
+		return arm64_bpf_fixup_exception(fixup, regs);
+
+	regs->pc = (unsigned long)&fixup->fixup + fixup->fixup;
+	return 1;
 }
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 3cb25b43b368..f8912e45be7a 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -7,6 +7,7 @@
 
 #define pr_fmt(fmt) "bpf_jit: " fmt
 
+#include <linux/bitfield.h>
 #include <linux/bpf.h>
 #include <linux/filter.h>
 #include <linux/printk.h>
@@ -56,6 +57,7 @@ struct jit_ctx {
 	int idx;
 	int epilogue_offset;
 	int *offset;
+	int exentry_idx;
 	__le32 *image;
 	u32 stack_size;
 };
@@ -351,6 +353,67 @@ static void build_epilogue(struct jit_ctx *ctx)
 	emit(A64_RET(A64_LR), ctx);
 }
 
+#define BPF_FIXUP_OFFSET_MASK	GENMASK(26, 0)
+#define BPF_FIXUP_REG_MASK	GENMASK(31, 27)
+
+int arm64_bpf_fixup_exception(const struct exception_table_entry *ex,
+			      struct pt_regs *regs)
+{
+	off_t offset = FIELD_GET(BPF_FIXUP_OFFSET_MASK, ex->fixup);
+	int dst_reg = FIELD_GET(BPF_FIXUP_REG_MASK, ex->fixup);
+
+	regs->regs[dst_reg] = 0;
+	regs->pc = (unsigned long)&ex->fixup - offset;
+	return 1;
+}
+
+/* For accesses to BTF pointers, add an entry to the exception table */
+static int add_exception_handler(const struct bpf_insn *insn,
+				 struct jit_ctx *ctx,
+				 int dst_reg)
+{
+	off_t offset;
+	unsigned long pc;
+	struct exception_table_entry *ex;
+
+	if (!ctx->image)
+		/* First pass */
+		return 0;
+
+	if (BPF_MODE(insn->code) != BPF_PROBE_MEM)
+		return 0;
+
+	if (!ctx->prog->aux->extable ||
+	    WARN_ON_ONCE(ctx->exentry_idx >= ctx->prog->aux->num_exentries))
+		return -EINVAL;
+
+	ex = &ctx->prog->aux->extable[ctx->exentry_idx];
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
+	offset = (long)&ex->fixup - (pc + AARCH64_INSN_SIZE);
+	if (!FIELD_FIT(BPF_FIXUP_OFFSET_MASK, offset))
+		return -ERANGE;
+
+	ex->fixup = FIELD_PREP(BPF_FIXUP_OFFSET_MASK, offset) |
+		    FIELD_PREP(BPF_FIXUP_REG_MASK, dst_reg);
+
+	ctx->exentry_idx++;
+	return 0;
+}
+
 /* JITs an eBPF instruction.
  * Returns:
  * 0  - successfully JITed an 8-byte eBPF instruction.
@@ -375,6 +438,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 	u8 jmp_cond, reg;
 	s32 jmp_offset;
 	u32 a64_insn;
+	int ret;
 
 #define check_imm(bits, imm) do {				\
 	if ((((imm) > 0) && ((imm) >> (bits))) ||		\
@@ -694,7 +758,6 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 		const u8 r0 = bpf2a64[BPF_REG_0];
 		bool func_addr_fixed;
 		u64 func_addr;
-		int ret;
 
 		ret = bpf_jit_get_func_addr(ctx->prog, insn, extra_pass,
 					    &func_addr, &func_addr_fixed);
@@ -738,6 +801,10 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 	case BPF_LDX | BPF_MEM | BPF_H:
 	case BPF_LDX | BPF_MEM | BPF_B:
 	case BPF_LDX | BPF_MEM | BPF_DW:
+	case BPF_LDX | BPF_PROBE_MEM | BPF_DW:
+	case BPF_LDX | BPF_PROBE_MEM | BPF_W:
+	case BPF_LDX | BPF_PROBE_MEM | BPF_H:
+	case BPF_LDX | BPF_PROBE_MEM | BPF_B:
 		emit_a64_mov_i(1, tmp, off, ctx);
 		switch (BPF_SIZE(code)) {
 		case BPF_W:
@@ -753,6 +820,10 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 			emit(A64_LDR64(dst, src, tmp), ctx);
 			break;
 		}
+
+		ret = add_exception_handler(insn, ctx, dst);
+		if (ret)
+			return ret;
 		break;
 
 	/* ST: *(size *)(dst + off) = imm */
@@ -868,6 +939,9 @@ static int validate_code(struct jit_ctx *ctx)
 			return -1;
 	}
 
+	if (WARN_ON_ONCE(ctx->exentry_idx != ctx->prog->aux->num_exentries))
+		return -1;
+
 	return 0;
 }
 
@@ -884,6 +958,7 @@ struct arm64_jit_data {
 
 struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 {
+	int image_size, prog_size, extable_size;
 	struct bpf_prog *tmp, *orig_prog = prog;
 	struct bpf_binary_header *header;
 	struct arm64_jit_data *jit_data;
@@ -891,7 +966,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	bool tmp_blinded = false;
 	bool extra_pass = false;
 	struct jit_ctx ctx;
-	int image_size;
 	u8 *image_ptr;
 
 	if (!prog->jit_requested)
@@ -922,7 +996,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		image_ptr = jit_data->image;
 		header = jit_data->header;
 		extra_pass = true;
-		image_size = sizeof(u32) * ctx.idx;
+		prog_size = sizeof(u32) * ctx.idx;
 		goto skip_init_ctx;
 	}
 	memset(&ctx, 0, sizeof(ctx));
@@ -950,8 +1024,12 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	ctx.epilogue_offset = ctx.idx;
 	build_epilogue(&ctx);
 
+	extable_size = prog->aux->num_exentries *
+		sizeof(struct exception_table_entry);
+
 	/* Now we know the actual image size. */
-	image_size = sizeof(u32) * ctx.idx;
+	prog_size = sizeof(u32) * ctx.idx;
+	image_size = prog_size + extable_size;
 	header = bpf_jit_binary_alloc(image_size, &image_ptr,
 				      sizeof(u32), jit_fill_hole);
 	if (header == NULL) {
@@ -962,8 +1040,11 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	/* 2. Now, the actual pass. */
 
 	ctx.image = (__le32 *)image_ptr;
+	if (extable_size)
+		prog->aux->extable = (void *)image_ptr + prog_size;
 skip_init_ctx:
 	ctx.idx = 0;
+	ctx.exentry_idx = 0;
 
 	build_prologue(&ctx, was_classic);
 
@@ -984,7 +1065,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 
 	/* And we're done. */
 	if (bpf_jit_enable > 1)
-		bpf_jit_dump(prog->len, image_size, 2, ctx.image);
+		bpf_jit_dump(prog->len, prog_size, 2, ctx.image);
 
 	bpf_flush_icache(header, ctx.image + ctx.idx);
 
@@ -1005,7 +1086,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	}
 	prog->bpf_func = (void *)ctx.image;
 	prog->jited = 1;
-	prog->jited_len = image_size;
+	prog->jited_len = prog_size;
 
 	if (!prog->is_func || extra_pass) {
 		bpf_prog_fill_jited_linfo(prog, ctx.offset);
-- 
2.27.0

