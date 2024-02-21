Return-Path: <bpf+bounces-22408-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB62785E047
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 15:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B9971C23CE7
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 14:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE55680607;
	Wed, 21 Feb 2024 14:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZ1+0om5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EB780049;
	Wed, 21 Feb 2024 14:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708527096; cv=none; b=i490jrzs8PylzBDJNJXH7gy6x+A4EWI/gn9x54MOXpSlTlFlfHGWfAR0uoAn3TXxXfdFvooCIIBw8wpR0itSyFIcq1VLcKnDn72Wxi9GrIoVEtaG+iPkZb2d4iWf0rClHBnt58VrIw6yAZq0qesRKyv4n/1P4zANely9T7KNEWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708527096; c=relaxed/simple;
	bh=O4GSXcbyEF1gKko/iFzgVckMygcE6RZ27ive23FoIhs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=irzteGLtyhLkOowas5QUrCmwijw2GzOKun74+fKY2axtIQVtAHIOftfNMBixlUdCkkRYZXjV3ne4TJAW0IR0LqxZEvAmj1rOSVIJqMHV26kBhMv+JOHvlEhzVjVLvH1389h/wRpxr9fTkAOa42pN2S0XeDFVchzMjvGUY5q7gzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZ1+0om5; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-512bde3d197so3386513e87.0;
        Wed, 21 Feb 2024 06:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708527092; x=1709131892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JF/SHXxgK2ZiZmUy3urtep32hgaGvw6CLP99kn1BZtg=;
        b=JZ1+0om5P0qoFLeQq06MmDqGXf+kXypiD7zpDiQ/Syl0YAIfIXrduskFvnh15MYbN6
         WE3/5/1Ti+lbpuLr/orpH0tK2hXUXMGEU6f1wG2jGsXIVlhHrhwML05jYL54SMKzdhAI
         o6ltnvqaGvltxhOw5NWvcEieZaTB08RKKKR319HjPbYX1dzO61/SOkF+ut20ieaChQfo
         ry34ZBffIaoOLI1naTuUNxSZ7WUhRFzwwTKHwp6GfSuLLMdi/Z5RjwZRbjVv/NovhI/a
         GwRjrjvQK8wfSvVGbAwwoDdDhOmFRtpP0fUeTKta+ttR3vMCdvYFGaXSIMsEcPaSFk4U
         YOEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708527092; x=1709131892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JF/SHXxgK2ZiZmUy3urtep32hgaGvw6CLP99kn1BZtg=;
        b=S8TkSHdzC8m6T5QXzd0ZHuqVZ0v7QDv5cuaz2XT+wTEX+oP1upq51c3NE20iq5DxnN
         pNivDvI5ZfP/sEVkdi4juMpQRxkx1s7q80k36ME5ydx8qNHVr+nv+3m9KbsTr9riARvm
         ngCcq/PxBPvrh9jnrf1RCIXgfZlZWSACXERp8LG+kBschesJXxFAi5qfplAyr26dYAct
         spLCHyHbATvZgdNJf58HaiIKi0Ze2ItShP7kaeqhN+A36RLpZMVJLqFn6iuBiQDUGuiI
         GFgPddrxQ8O5edXIgEzj5Z53tSyUxVHhLfSPmLJ5zmfphAQrJ8BxpOC7TwYLYBd/Mc85
         q4XA==
X-Forwarded-Encrypted: i=1; AJvYcCUEjaMz93XKY1QktkUVwlSVnpPVm6tTkasFxjhwiSbM0H3+rbriKlwoZJTLfcoPUZQ8y8m/zDZIsYUdPEr/sElspolYF8oLDwl7jl0EsAduxPYAzPs0ackuUBX/6qIF+7yW
X-Gm-Message-State: AOJu0YzxVb3yJ5GJa/tdpxjvn+aaHgKbt0rila7ox8iSdV2gwxKR4/PX
	9xBQDP4XrkQgOVfi92LpJaeewZh5OOZqucFL9c6G8goNwldWE3xq
X-Google-Smtp-Source: AGHT+IEcMJI2ZNS2QhONQmxg/zvzrVRGxcYNQZp9gayRMcCBn7KtpOFyrEhhXI4PYa51fx5qspgEKw==
X-Received: by 2002:a05:6512:951:b0:512:b914:7d6f with SMTP id u17-20020a056512095100b00512b9147d6fmr4677018lft.65.1708527092191;
        Wed, 21 Feb 2024 06:51:32 -0800 (PST)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id co3-20020a0560000a0300b0033d70dd0e04sm4982751wrb.8.2024.02.21.06.51.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Feb 2024 06:51:31 -0800 (PST)
From: Puranjay Mohan <puranjay12@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	catalin.marinas@arm.com,
	mark.rutland@arm.com,
	bpf@vger.kernel.org,
	kpsingh@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	xukuohai@huaweicloud.com
Cc: puranjay12@gmail.com
Subject: [PATCH bpf-next v8 2/2] bpf, arm64: use bpf_prog_pack for memory management
Date: Wed, 21 Feb 2024 14:51:06 +0000
Message-Id: <20240221145106.105995-3-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240221145106.105995-1-puranjay12@gmail.com>
References: <20240221145106.105995-1-puranjay12@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use bpf_jit_binary_pack_alloc for memory management of JIT binaries in
ARM64 BPF JIT. The bpf_jit_binary_pack_alloc creates a pair of RW and RX
buffers. The JIT writes the program into the RW buffer. When the JIT is
done, the program is copied to the final RX buffer
with bpf_jit_binary_pack_finalize.

Implement bpf_arch_text_copy() and bpf_arch_text_invalidate() for ARM64
JIT as these functions are required by bpf_jit_binary_pack allocator.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
Acked-by: Song Liu <song@kernel.org>
---
 arch/arm64/net/bpf_jit_comp.c | 139 ++++++++++++++++++++++++++++------
 1 file changed, 115 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index cfd5434de483..58e54a1929c9 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -76,6 +76,7 @@ struct jit_ctx {
 	int *offset;
 	int exentry_idx;
 	__le32 *image;
+	__le32 *ro_image;
 	u32 stack_size;
 	int fpb_offset;
 };
@@ -205,6 +206,14 @@ static void jit_fill_hole(void *area, unsigned int size)
 		*ptr++ = cpu_to_le32(AARCH64_BREAK_FAULT);
 }
 
+int bpf_arch_text_invalidate(void *dst, size_t len)
+{
+	if (!aarch64_insn_set(dst, AARCH64_BREAK_FAULT, len))
+		return -EINVAL;
+
+	return 0;
+}
+
 static inline int epilogue_offset(const struct jit_ctx *ctx)
 {
 	int to = ctx->epilogue_offset;
@@ -707,7 +716,8 @@ static int add_exception_handler(const struct bpf_insn *insn,
 				 struct jit_ctx *ctx,
 				 int dst_reg)
 {
-	off_t offset;
+	off_t ins_offset;
+	off_t fixup_offset;
 	unsigned long pc;
 	struct exception_table_entry *ex;
 
@@ -724,12 +734,17 @@ static int add_exception_handler(const struct bpf_insn *insn,
 		return -EINVAL;
 
 	ex = &ctx->prog->aux->extable[ctx->exentry_idx];
-	pc = (unsigned long)&ctx->image[ctx->idx - 1];
+	pc = (unsigned long)&ctx->ro_image[ctx->idx - 1];
 
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
@@ -738,12 +753,25 @@ static int add_exception_handler(const struct bpf_insn *insn,
 	 * bits. We don't need to worry about buildtime or runtime sort
 	 * modifying the upper bits because the table is already sorted, and
 	 * isn't part of the main exception table.
+	 *
+	 * The fixup_offset is set to the next instruction from the instruction
+	 * that may fault. The execution will jump to this after handling the
+	 * fault.
 	 */
-	offset = (long)&ex->fixup - (pc + AARCH64_INSN_SIZE);
-	if (!FIELD_FIT(BPF_FIXUP_OFFSET_MASK, offset))
+	fixup_offset = (long)&ex->fixup - (pc + AARCH64_INSN_SIZE);
+	if (!FIELD_FIT(BPF_FIXUP_OFFSET_MASK, fixup_offset))
 		return -ERANGE;
 
-	ex->fixup = FIELD_PREP(BPF_FIXUP_OFFSET_MASK, offset) |
+	/*
+	 * The offsets above have been calculated using the RO buffer but we
+	 * need to use the R/W buffer for writes.
+	 * switch ex to rw buffer for writing.
+	 */
+	ex = (void *)ctx->image + ((void *)ex - (void *)ctx->ro_image);
+
+	ex->insn = ins_offset;
+
+	ex->fixup = FIELD_PREP(BPF_FIXUP_OFFSET_MASK, fixup_offset) |
 		    FIELD_PREP(BPF_FIXUP_REG_MASK, dst_reg);
 
 	ex->type = EX_TYPE_BPF;
@@ -1511,7 +1539,8 @@ static inline void bpf_flush_icache(void *start, void *end)
 
 struct arm64_jit_data {
 	struct bpf_binary_header *header;
-	u8 *image;
+	u8 *ro_image;
+	struct bpf_binary_header *ro_header;
 	struct jit_ctx ctx;
 };
 
@@ -1520,12 +1549,14 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	int image_size, prog_size, extable_size, extable_align, extable_offset;
 	struct bpf_prog *tmp, *orig_prog = prog;
 	struct bpf_binary_header *header;
+	struct bpf_binary_header *ro_header;
 	struct arm64_jit_data *jit_data;
 	bool was_classic = bpf_prog_was_classic(prog);
 	bool tmp_blinded = false;
 	bool extra_pass = false;
 	struct jit_ctx ctx;
 	u8 *image_ptr;
+	u8 *ro_image_ptr;
 
 	if (!prog->jit_requested)
 		return orig_prog;
@@ -1552,8 +1583,11 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	}
 	if (jit_data->ctx.offset) {
 		ctx = jit_data->ctx;
-		image_ptr = jit_data->image;
+		ro_image_ptr = jit_data->ro_image;
+		ro_header = jit_data->ro_header;
 		header = jit_data->header;
+		image_ptr = (void *)header + ((void *)ro_image_ptr
+						 - (void *)ro_header);
 		extra_pass = true;
 		prog_size = sizeof(u32) * ctx.idx;
 		goto skip_init_ctx;
@@ -1598,18 +1632,27 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	/* also allocate space for plt target */
 	extable_offset = round_up(prog_size + PLT_TARGET_SIZE, extable_align);
 	image_size = extable_offset + extable_size;
-	header = bpf_jit_binary_alloc(image_size, &image_ptr,
-				      sizeof(u32), jit_fill_hole);
-	if (header == NULL) {
+	ro_header = bpf_jit_binary_pack_alloc(image_size, &ro_image_ptr,
+					      sizeof(u32), &header, &image_ptr,
+					      jit_fill_hole);
+	if (!ro_header) {
 		prog = orig_prog;
 		goto out_off;
 	}
 
 	/* 2. Now, the actual pass. */
 
+	/*
+	 * Use the image(RW) for writing the JITed instructions. But also save
+	 * the ro_image(RX) for calculating the offsets in the image. The RW
+	 * image will be later copied to the RX image from where the program
+	 * will run. The bpf_jit_binary_pack_finalize() will do this copy in the
+	 * final step.
+	 */
 	ctx.image = (__le32 *)image_ptr;
+	ctx.ro_image = (__le32 *)ro_image_ptr;
 	if (extable_size)
-		prog->aux->extable = (void *)image_ptr + extable_offset;
+		prog->aux->extable = (void *)ro_image_ptr + extable_offset;
 skip_init_ctx:
 	ctx.idx = 0;
 	ctx.exentry_idx = 0;
@@ -1617,9 +1660,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	build_prologue(&ctx, was_classic);
 
 	if (build_body(&ctx, extra_pass)) {
-		bpf_jit_binary_free(header);
 		prog = orig_prog;
-		goto out_off;
+		goto out_free_hdr;
 	}
 
 	build_epilogue(&ctx);
@@ -1627,34 +1669,44 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 
 	/* 3. Extra pass to validate JITed code. */
 	if (validate_ctx(&ctx)) {
-		bpf_jit_binary_free(header);
 		prog = orig_prog;
-		goto out_off;
+		goto out_free_hdr;
 	}
 
 	/* And we're done. */
 	if (bpf_jit_enable > 1)
 		bpf_jit_dump(prog->len, prog_size, 2, ctx.image);
 
-	bpf_flush_icache(header, ctx.image + ctx.idx);
-
 	if (!prog->is_func || extra_pass) {
 		if (extra_pass && ctx.idx != jit_data->ctx.idx) {
 			pr_err_once("multi-func JIT bug %d != %d\n",
 				    ctx.idx, jit_data->ctx.idx);
-			bpf_jit_binary_free(header);
 			prog->bpf_func = NULL;
 			prog->jited = 0;
 			prog->jited_len = 0;
+			goto out_free_hdr;
+		}
+		if (WARN_ON(bpf_jit_binary_pack_finalize(prog, ro_header,
+							 header))) {
+			/* ro_header has been freed */
+			ro_header = NULL;
+			prog = orig_prog;
 			goto out_off;
 		}
-		bpf_jit_binary_lock_ro(header);
+		/*
+		 * The instructions have now been copied to the ROX region from
+		 * where they will execute. Now the data cache has to be cleaned to
+		 * the PoU and the I-cache has to be invalidated for the VAs.
+		 */
+		bpf_flush_icache(ro_header, ctx.ro_image + ctx.idx);
 	} else {
 		jit_data->ctx = ctx;
-		jit_data->image = image_ptr;
+		jit_data->ro_image = ro_image_ptr;
 		jit_data->header = header;
+		jit_data->ro_header = ro_header;
 	}
-	prog->bpf_func = (void *)ctx.image;
+
+	prog->bpf_func = (void *)ctx.ro_image;
 	prog->jited = 1;
 	prog->jited_len = prog_size;
 
@@ -1675,6 +1727,14 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		bpf_jit_prog_release_other(prog, prog == orig_prog ?
 					   tmp : orig_prog);
 	return prog;
+
+out_free_hdr:
+	if (header) {
+		bpf_arch_text_copy(&ro_header->size, &header->size,
+				   sizeof(header->size));
+		bpf_jit_binary_pack_free(ro_header, header);
+	}
+	goto out_off;
 }
 
 bool bpf_jit_supports_kfunc_call(void)
@@ -1682,6 +1742,13 @@ bool bpf_jit_supports_kfunc_call(void)
 	return true;
 }
 
+void *bpf_arch_text_copy(void *dst, void *src, size_t len)
+{
+	if (!aarch64_insn_copy(dst, src, len))
+		return ERR_PTR(-EINVAL);
+	return dst;
+}
+
 u64 bpf_jit_alloc_exec_limit(void)
 {
 	return VMALLOC_END - VMALLOC_START;
@@ -2310,3 +2377,27 @@ bool bpf_jit_supports_ptr_xchg(void)
 {
 	return true;
 }
+
+void bpf_jit_free(struct bpf_prog *prog)
+{
+	if (prog->jited) {
+		struct arm64_jit_data *jit_data = prog->aux->jit_data;
+		struct bpf_binary_header *hdr;
+
+		/*
+		 * If we fail the final pass of JIT (from jit_subprogs),
+		 * the program may not be finalized yet. Call finalize here
+		 * before freeing it.
+		 */
+		if (jit_data) {
+			bpf_arch_text_copy(&jit_data->ro_header->size, &jit_data->header->size,
+					   sizeof(jit_data->header->size));
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


