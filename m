Return-Path: <bpf+bounces-8859-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D56D78B5BE
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 19:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5C3B280E7A
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 17:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BFD13AF6;
	Mon, 28 Aug 2023 17:00:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A4A13ADC
	for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 17:00:05 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B3B136;
	Mon, 28 Aug 2023 10:00:02 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fef56f7223so31047005e9.3;
        Mon, 28 Aug 2023 10:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693242001; x=1693846801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q8OsLeLjJDC6dcr6beMUQZEpMzD/YI8vKFDuT6sd4m0=;
        b=bpA/K0Fws6GYZykdDTAZPqOtuh0w6IJ/EUj5OsqpXUmgkk1LovMoj6i/y3oKkGwczm
         YqQkHhXN0AsqTcv16ryKrt/ZXRLmUjDu/7b+tAgah7XTLL252IYZOzD4VSxjQO9mMPUV
         krwhKZG9kCJs/VLzQ3fVwGlKoMnVAezt5aCpMBPOQpJ0kK7QHpKGfJCrzeEDQvkJkAqN
         QxxYjFfLLGze8/RmsHVPC/EeW7TXPodSfTWNd+qmyNpEdCo0pXLMV+hchmFgDAKY8mHu
         8vj5BX+IHkVQsWizDhvzEyjD8RubicTE1Y3HL+zc8WAz4yqcW81JqKvaRqZacfmiyeo2
         PeRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693242001; x=1693846801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q8OsLeLjJDC6dcr6beMUQZEpMzD/YI8vKFDuT6sd4m0=;
        b=dhztGxf6IRzcfYKhN1VmXRJqVVtMTQ7/xFX2Ob+3hJSe++7SV01cm0D/kMD35Xq2MI
         mt5rQdWdPdLeNSR60MrWNaO7VmDqi82N0S0edD8eGN2BEInBJxvSXKl3mrPLPaM7M7zX
         x2yPODz0k0q5HZROXv85EV26jz8EdehcK63r2ZtGton5pphAvPEieZSPjRKuIY6vNLiC
         LvjFd10ZUOwDItDf57e2PllKQjH9twqvUYoYqxrNtgegZrX5FoxXB8aszzlb4G56sxHp
         TBiwh6qNfH3aAmQI64kZGJfdnnyMi0PCaiUnUYiwc2u4rA1XzeHn4Lj3G7ObJFl4eigV
         0UbQ==
X-Gm-Message-State: AOJu0YxOXno3G3jR6KNlu80kV2obJj7a7uM7wxi9lJhdXJLMyBC0t48a
	W6Ab5RxU1KDd+KSBxcS9JCM=
X-Google-Smtp-Source: AGHT+IGL2Z+WyaGGKa/ZFngK9Kc1wWXtqN8kB4kJmknK7RbcUepPwVQxEcYsTu+JpIFCf6EkiGcwTg==
X-Received: by 2002:a05:600c:201:b0:400:419c:bbde with SMTP id 1-20020a05600c020100b00400419cbbdemr11537299wmi.18.1693242001240;
        Mon, 28 Aug 2023 10:00:01 -0700 (PDT)
Received: from ip-172-31-30-46.eu-west-1.compute.internal (ec2-54-170-241-106.eu-west-1.compute.amazonaws.com. [54.170.241.106])
        by smtp.gmail.com with ESMTPSA id g9-20020a056000118900b0031ad5fb5a0fsm11033613wrx.58.2023.08.28.10.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 10:00:00 -0700 (PDT)
From: Puranjay Mohan <puranjay12@gmail.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	pulehui@huawei.com,
	conor.dooley@microchip.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	kpsingh@kernel.org,
	bjorn@kernel.org,
	bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: puranjay12@gmail.com
Subject: [PATCH bpf-next v3 3/3] bpf, riscv: use prog pack allocator in the BPF JIT
Date: Mon, 28 Aug 2023 16:59:58 +0000
Message-Id: <20230828165958.1714079-4-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230828165958.1714079-1-puranjay12@gmail.com>
References: <20230828165958.1714079-1-puranjay12@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Use bpf_jit_binary_pack_alloc() for memory management of JIT binaries in
RISCV BPF JIT. The bpf_jit_binary_pack_alloc creates a pair of RW and RX
buffers. The JIT writes the program into the RW buffer. When the JIT is
done, the program is copied to the final RX buffer with
bpf_jit_binary_pack_finalize.

Implement bpf_arch_text_copy() and bpf_arch_text_invalidate() for RISCV
JIT as these functions are required by bpf_jit_binary_pack allocator.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
Reviewed-by: Song Liu <song@kernel.org>
---
 arch/riscv/net/bpf_jit.h        |   3 +
 arch/riscv/net/bpf_jit_comp64.c |  60 ++++++++++++++----
 arch/riscv/net/bpf_jit_core.c   | 106 +++++++++++++++++++++++++++-----
 3 files changed, 141 insertions(+), 28 deletions(-)

diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
index d21c6c92a683..a5ce1ab76ece 100644
--- a/arch/riscv/net/bpf_jit.h
+++ b/arch/riscv/net/bpf_jit.h
@@ -68,6 +68,7 @@ static inline bool is_creg(u8 reg)
 struct rv_jit_context {
 	struct bpf_prog *prog;
 	u16 *insns;		/* RV insns */
+	u16 *ro_insns;
 	int ninsns;
 	int prologue_len;
 	int epilogue_offset;
@@ -85,7 +86,9 @@ static inline int ninsns_rvoff(int ninsns)
 
 struct rv_jit_data {
 	struct bpf_binary_header *header;
+	struct bpf_binary_header *ro_header;
 	u8 *image;
+	u8 *ro_image;
 	struct rv_jit_context ctx;
 };
 
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 8423f4ddf8f5..ecd3ae6f4116 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -144,7 +144,11 @@ static bool in_auipc_jalr_range(s64 val)
 /* Emit fixed-length instructions for address */
 static int emit_addr(u8 rd, u64 addr, bool extra_pass, struct rv_jit_context *ctx)
 {
-	u64 ip = (u64)(ctx->insns + ctx->ninsns);
+	/*
+	 * Use the ro_insns(RX) to calculate the offset as the BPF program will
+	 * finally run from this memory region.
+	 */
+	u64 ip = (u64)(ctx->ro_insns + ctx->ninsns);
 	s64 off = addr - ip;
 	s64 upper = (off + (1 << 11)) >> 12;
 	s64 lower = off & 0xfff;
@@ -464,8 +468,12 @@ static int emit_call(u64 addr, bool fixed_addr, struct rv_jit_context *ctx)
 	s64 off = 0;
 	u64 ip;
 
-	if (addr && ctx->insns) {
-		ip = (u64)(long)(ctx->insns + ctx->ninsns);
+	if (addr && ctx->insns && ctx->ro_insns) {
+		/*
+		 * Use the ro_insns(RX) to calculate the offset as the BPF
+		 * program will finally run from this memory region.
+		 */
+		ip = (u64)(long)(ctx->ro_insns + ctx->ninsns);
 		off = addr - ip;
 	}
 
@@ -578,9 +586,10 @@ static int add_exception_handler(const struct bpf_insn *insn,
 {
 	struct exception_table_entry *ex;
 	unsigned long pc;
-	off_t offset;
+	off_t ins_offset;
+	off_t fixup_offset;
 
-	if (!ctx->insns || !ctx->prog->aux->extable ||
+	if (!ctx->insns || !ctx->ro_insns || !ctx->prog->aux->extable ||
 	    (BPF_MODE(insn->code) != BPF_PROBE_MEM && BPF_MODE(insn->code) != BPF_PROBE_MEMSX))
 		return 0;
 
@@ -594,12 +603,17 @@ static int add_exception_handler(const struct bpf_insn *insn,
 		return -EINVAL;
 
 	ex = &ctx->prog->aux->extable[ctx->nexentries];
-	pc = (unsigned long)&ctx->insns[ctx->ninsns - insn_len];
+	pc = (unsigned long)&ctx->ro_insns[ctx->ninsns - insn_len];
 
-	offset = pc - (long)&ex->insn;
-	if (WARN_ON_ONCE(offset >= 0 || offset < INT_MIN))
+	/*
+	 * This is the relative offset of the instruction that may fault from
+	 * the exception table itself. This will be written to the exception
+	 * table and if this instruction faults, the destination register will
+	 * be set to '0' and the execution will jump to the next instruction.
+	 */
+	ins_offset = pc - (long)&ex->insn;
+	if (WARN_ON_ONCE(ins_offset >= 0 || ins_offset < INT_MIN))
 		return -ERANGE;
-	ex->insn = offset;
 
 	/*
 	 * Since the extable follows the program, the fixup offset is always
@@ -608,12 +622,25 @@ static int add_exception_handler(const struct bpf_insn *insn,
 	 * bits. We don't need to worry about buildtime or runtime sort
 	 * modifying the upper bits because the table is already sorted, and
 	 * isn't part of the main exception table.
+	 *
+	 * The fixup_offset is set to the next instruction from the instruction
+	 * that may fault. The execution will jump to this after handling the
+	 * fault.
 	 */
-	offset = (long)&ex->fixup - (pc + insn_len * sizeof(u16));
-	if (!FIELD_FIT(BPF_FIXUP_OFFSET_MASK, offset))
+	fixup_offset = (long)&ex->fixup - (pc + insn_len * sizeof(u16));
+	if (!FIELD_FIT(BPF_FIXUP_OFFSET_MASK, fixup_offset))
 		return -ERANGE;
 
-	ex->fixup = FIELD_PREP(BPF_FIXUP_OFFSET_MASK, offset) |
+	/*
+	 * The offsets above have been calculated using the RO buffer but we
+	 * need to use the R/W buffer for writes.
+	 * switch ex to rw buffer for writing.
+	 */
+	ex = (void *)ctx->insns + ((void *)ex - (void *)ctx->ro_insns);
+
+	ex->insn = ins_offset;
+
+	ex->fixup = FIELD_PREP(BPF_FIXUP_OFFSET_MASK, fixup_offset) |
 		FIELD_PREP(BPF_FIXUP_REG_MASK, dst_reg);
 	ex->type = EX_TYPE_BPF;
 
@@ -1007,6 +1034,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,
 
 	ctx.ninsns = 0;
 	ctx.insns = NULL;
+	ctx.ro_insns = NULL;
 	ret = __arch_prepare_bpf_trampoline(im, m, tlinks, func_addr, flags, &ctx);
 	if (ret < 0)
 		return ret;
@@ -1015,7 +1043,15 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,
 		return -EFBIG;
 
 	ctx.ninsns = 0;
+	/*
+	 * The bpf_int_jit_compile() uses a RW buffer (ctx.insns) to write the
+	 * JITed instructions and later copies it to a RX region (ctx.ro_insns).
+	 * It also uses ctx.ro_insns to calculate offsets for jumps etc. As the
+	 * trampoline image uses the same memory area for writing and execution,
+	 * both ctx.insns and ctx.ro_insns can be set to image.
+	 */
 	ctx.insns = image;
+	ctx.ro_insns = image;
 	ret = __arch_prepare_bpf_trampoline(im, m, tlinks, func_addr, flags, &ctx);
 	if (ret < 0)
 		return ret;
diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_core.c
index 7a26a3e1c73c..7b70ccb7fec3 100644
--- a/arch/riscv/net/bpf_jit_core.c
+++ b/arch/riscv/net/bpf_jit_core.c
@@ -8,6 +8,8 @@
 
 #include <linux/bpf.h>
 #include <linux/filter.h>
+#include <linux/memory.h>
+#include <asm/patch.h>
 #include "bpf_jit.h"
 
 /* Number of iterations to try until offsets converge. */
@@ -117,16 +119,24 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 				sizeof(struct exception_table_entry);
 			prog_size = sizeof(*ctx->insns) * ctx->ninsns;
 
-			jit_data->header =
-				bpf_jit_binary_alloc(prog_size + extable_size,
-						     &jit_data->image,
-						     sizeof(u32),
-						     bpf_fill_ill_insns);
-			if (!jit_data->header) {
+			jit_data->ro_header =
+				bpf_jit_binary_pack_alloc(prog_size + extable_size,
+							  &jit_data->ro_image, sizeof(u32),
+							  &jit_data->header, &jit_data->image,
+							  bpf_fill_ill_insns);
+			if (!jit_data->ro_header) {
 				prog = orig_prog;
 				goto out_offset;
 			}
 
+			/*
+			 * Use the image(RW) for writing the JITed instructions. But also save
+			 * the ro_image(RX) for calculating the offsets in the image. The RW
+			 * image will be later copied to the RX image from where the program
+			 * will run. The bpf_jit_binary_pack_finalize() will do this copy in the
+			 * final step.
+			 */
+			ctx->ro_insns = (u16 *)jit_data->ro_image;
 			ctx->insns = (u16 *)jit_data->image;
 			/*
 			 * Now, when the image is allocated, the image can
@@ -138,14 +148,12 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 
 	if (i == NR_JIT_ITERATIONS) {
 		pr_err("bpf-jit: image did not converge in <%d passes!\n", i);
-		if (jit_data->header)
-			bpf_jit_binary_free(jit_data->header);
 		prog = orig_prog;
-		goto out_offset;
+		goto out_free_hdr;
 	}
 
 	if (extable_size)
-		prog->aux->extable = (void *)ctx->insns + prog_size;
+		prog->aux->extable = (void *)ctx->ro_insns + prog_size;
 
 skip_init_ctx:
 	pass++;
@@ -154,23 +162,33 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 
 	bpf_jit_build_prologue(ctx);
 	if (build_body(ctx, extra_pass, NULL)) {
-		bpf_jit_binary_free(jit_data->header);
 		prog = orig_prog;
-		goto out_offset;
+		goto out_free_hdr;
 	}
 	bpf_jit_build_epilogue(ctx);
 
 	if (bpf_jit_enable > 1)
 		bpf_jit_dump(prog->len, prog_size, pass, ctx->insns);
 
-	prog->bpf_func = (void *)ctx->insns;
+	prog->bpf_func = (void *)ctx->ro_insns;
 	prog->jited = 1;
 	prog->jited_len = prog_size;
 
-	bpf_flush_icache(jit_data->header, ctx->insns + ctx->ninsns);
-
 	if (!prog->is_func || extra_pass) {
-		bpf_jit_binary_lock_ro(jit_data->header);
+		if (WARN_ON(bpf_jit_binary_pack_finalize(prog, jit_data->ro_header,
+							 jit_data->header))) {
+			/* ro_header has been freed */
+			jit_data->ro_header = NULL;
+			prog = orig_prog;
+			goto out_offset;
+		}
+		/*
+		 * The instructions have now been copied to the ROX region from
+		 * where they will execute.
+		 * Write any modified data cache blocks out to memory and
+		 * invalidate the corresponding blocks in the instruction cache.
+		 */
+		bpf_flush_icache(jit_data->ro_header, ctx->ro_insns + ctx->ninsns);
 		for (i = 0; i < prog->len; i++)
 			ctx->offset[i] = ninsns_rvoff(ctx->offset[i]);
 		bpf_prog_fill_jited_linfo(prog, ctx->offset);
@@ -185,6 +203,14 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		bpf_jit_prog_release_other(prog, prog == orig_prog ?
 					   tmp : orig_prog);
 	return prog;
+
+out_free_hdr:
+	if (jit_data->header) {
+		bpf_arch_text_copy(&jit_data->ro_header->size, &jit_data->header->size,
+				   sizeof(jit_data->header->size));
+		bpf_jit_binary_pack_free(jit_data->ro_header, jit_data->header);
+	}
+	goto out_offset;
 }
 
 u64 bpf_jit_alloc_exec_limit(void)
@@ -204,3 +230,51 @@ void bpf_jit_free_exec(void *addr)
 {
 	return vfree(addr);
 }
+
+void *bpf_arch_text_copy(void *dst, void *src, size_t len)
+{
+	int ret;
+
+	mutex_lock(&text_mutex);
+	ret = patch_text_nosync(dst, src, len);
+	mutex_unlock(&text_mutex);
+
+	if (ret)
+		return ERR_PTR(-EINVAL);
+
+	return dst;
+}
+
+int bpf_arch_text_invalidate(void *dst, size_t len)
+{
+	int ret;
+
+	mutex_lock(&text_mutex);
+	ret = patch_text_set_nosync(dst, 0, len);
+	mutex_unlock(&text_mutex);
+
+	return ret;
+}
+
+void bpf_jit_free(struct bpf_prog *prog)
+{
+	if (prog->jited) {
+		struct rv_jit_data *jit_data = prog->aux->jit_data;
+		struct bpf_binary_header *hdr;
+
+		/*
+		 * If we fail the final pass of JIT (from jit_subprogs),
+		 * the program may not be finalized yet. Call finalize here
+		 * before freeing it.
+		 */
+		if (jit_data) {
+			bpf_jit_binary_pack_finalize(prog, jit_data->ro_header, jit_data->header);
+			kfree(jit_data);
+		}
+		hdr = bpf_jit_binary_pack_hdr(prog);
+		bpf_jit_binary_pack_free(hdr, NULL);
+		WARN_ON_ONCE(!bpf_prog_kallsyms_verify_off(prog));
+	}
+
+	bpf_prog_unlock_free(prog);
+}
-- 
2.40.1


