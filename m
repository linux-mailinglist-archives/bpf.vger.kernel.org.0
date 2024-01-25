Return-Path: <bpf+bounces-20328-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9206383C3AF
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 14:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC0C41C22815
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 13:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CA85812A;
	Thu, 25 Jan 2024 13:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Js89LdnW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F61457317;
	Thu, 25 Jan 2024 13:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706189553; cv=none; b=kWKG7Z4Qsy8x6qhG2UrFhG1Fg/YeE0I6J8+dCJfWen6m3LOneCn8TkZwsHrffsGOsjwBtiwgEtsHxJ2ce4vgZLC10WW8SNYsRmt1Rgc1JdaKBCclMbRd0PMsfv0w89HqOv12hAWusLFOGtSkWFk8tPTgnEXn0lVjnR6+oNVIblQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706189553; c=relaxed/simple;
	bh=O4GSXcbyEF1gKko/iFzgVckMygcE6RZ27ive23FoIhs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L1CsL1WqCVeYnF1dtjRVNd7BfwMYE+JcfkfXjBi5aS5K0HzPB8iyMJKwTH+7Bdzr7o3HOmHTycm45hvZm5F6ede+/XOPHxjRmYZnY2DMy+HRg58kBp6cxB/L9phqO3fVhpBNs6lvoeM0ZudW9YkRp4Nu5qp+Vqj357tI/eWhkkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Js89LdnW; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40e60e137aaso73643865e9.0;
        Thu, 25 Jan 2024 05:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706189549; x=1706794349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JF/SHXxgK2ZiZmUy3urtep32hgaGvw6CLP99kn1BZtg=;
        b=Js89LdnWa7WJ72GiBZjrAAjr/WZVB3f4RJd1l2tDcD1tZiUbtUlV8l6OCqV/JO4+qU
         QPrUmaxaNUi2/DQ7d+QAcNdb6J83AcnoHhHTFxTfEE0pQ6O5+IhUrKUt3fo35HCn+UNk
         KWbIjafSKMCaIS5if0aBvx2iHmq0W5TUNAKcDV6AyQ4qmP/HLZ/VDsUDDJ3Qs4NFeHtI
         lluWUGtZuLDe7WFp4tZiSMK4yppmJ0w54EVtip/Chamx7IaDVX1wGNNMbQq+0Is35IJy
         DgV8rgKx71x81rGsW+C3NaorYnPk4vcMZe6OPID6QVNCgyQXP1dOCq3Dp+AvmJljR7er
         rqcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706189549; x=1706794349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JF/SHXxgK2ZiZmUy3urtep32hgaGvw6CLP99kn1BZtg=;
        b=kY1b+e4bnsZ5T2AWImxl8d2210mYyElMNIoS3QLHwRaQ/KKQy84kkTxTBAC88EDTiP
         +2214TEgk33nm6L/7NInLI7FIcTygB5zqHKQ0pTaY5esujqabkIEB7VcyfHfLHw0zvRU
         DisqFM1qY8U60BdB+Cnzk6gk0PeGLyljcMyczE+hrQgCxoaeRE/J25rM5IFy6y5EdKeX
         3HLSKRO+tL/08yR70xOIsl/lnxoCx2YjysYapMcDrQuIyl6WmUQa4kvnOr6OMja4RviP
         53w1DYmj6SvbutnYGmKE91+h26sAkqPqhSKEbko1i+lufNf+au/p6WyvZ2kohg7FNMzh
         xcvw==
X-Gm-Message-State: AOJu0YyKq5BUu+teiJuCdBzuPI2l6QKy6A0/bxwrnLmcQFbsVWEKxLF5
	XmjlWVC1wmtzAH+ARLdoRoK3PTdrdLMusOJOi2cmzOTrEYJkWw56
X-Google-Smtp-Source: AGHT+IFiQWsya8LFAGeIuBtWfIJoYlkihO9LhhMv7WoTe9SlKoR9v49bSwzb2ZUHtz3VvBOGmW/1tQ==
X-Received: by 2002:a05:600c:1f90:b0:40e:c64b:9129 with SMTP id je16-20020a05600c1f9000b0040ec64b9129mr363558wmb.11.1706189549029;
        Thu, 25 Jan 2024 05:32:29 -0800 (PST)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id t15-20020a05600c198f00b0040e395cd20bsm2651657wmq.7.2024.01.25.05.32.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jan 2024 05:32:28 -0800 (PST)
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
Subject: [PATCH bpf-next v7 2/2] bpf, arm64: use bpf_prog_pack for memory management
Date: Thu, 25 Jan 2024 13:31:59 +0000
Message-Id: <20240125133159.85086-3-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240125133159.85086-1-puranjay12@gmail.com>
References: <20240125133159.85086-1-puranjay12@gmail.com>
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


