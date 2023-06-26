Return-Path: <bpf+bounces-3425-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 943BF73DAA1
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 10:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24190280DC1
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 08:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E356FD6;
	Mon, 26 Jun 2023 08:58:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4626FA1
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 08:58:19 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C762723;
	Mon, 26 Jun 2023 01:58:16 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fa70ec8d17so35199065e9.1;
        Mon, 26 Jun 2023 01:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687769895; x=1690361895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5i6ERh1cNmAmSBJdCUvzjUDJeDW4Go6V1bRVLdgUVO4=;
        b=nnh3t8J8zcxxotxX5qEsNJFdmTJgqCGMTS5BreYm4H7cjTfQ/n90LFyuJ+JmQ9IRuH
         32+Yb6c1NR9Wm5hYZM6TDzMjieMYAGcHLXaqaGnGB8zBvyBoAUp45xwcfyXGu3cQVqKf
         Hnk3d3sFPL8wrGQzHBJIRkhV5XGK5uDnNLqRlM2GLjp3yeRuA+XAOiMwb8xxMh/XP+2G
         aF9E2knkZdRSqQCC/RO2zTRaZWiW7+TWxffiBvKAaTwAAVed1xriwssaVT4+MUmPjVjI
         twe2IcEOQi2k1L7q3wWriLQw1KNZO3XX6f1Ui+o0msbFL1jgaEKeSYjPOEL7LndOKBDa
         5F1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687769895; x=1690361895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5i6ERh1cNmAmSBJdCUvzjUDJeDW4Go6V1bRVLdgUVO4=;
        b=IpBa9Un6Sb5g//OZrFXfILgs+8d2mA2AbKcqcU3zpU9306uMzmKDS2zDoNhWkeb8mH
         BhvR8SxC/i5DAn2JC5BqemsNS07aYLHFET2wABUKu4BcbgpgcvGLsKAJCc0QxDzZFT+T
         l8ISkSSti6/zX1cGyr7cmWLDZjJN00sevWvczxu68fRGF1k/agE1Hn5R4dVs28NUmRJk
         g8qF4PdXiNos4fRpKlX3gkhdP2o0k02pYHbFr3knw/CkoQC2FMDAb7fn0C44+xQSYBFf
         8PviRet4dWesViqyZ87QfHY3tMmV/m/9kC0XYNd8x6x2+Me/4NTTdsoHZ+UpKaliA4cB
         L3rQ==
X-Gm-Message-State: AC+VfDxUhTgOzOw1F172voW+yTvhapjwQtcqU2Ub7Yx6598RNIo5Gc/c
	6stjA9MF1yi31kQR56RRUH1JMvFv0eSk1bs308i5wQ==
X-Google-Smtp-Source: ACHHUZ47FEyGqK6Tao3ltj9Lfc0JvJOGVs0Mwuhq9/hOWhPsnr2zPacJ538nQYASV7PmQ3UsdeK0Jg==
X-Received: by 2002:a05:600c:d8:b0:3f9:c9f4:acf1 with SMTP id u24-20020a05600c00d800b003f9c9f4acf1mr12509701wmm.7.1687769894589;
        Mon, 26 Jun 2023 01:58:14 -0700 (PDT)
Received: from ip-172-31-22-112.eu-west-1.compute.internal (ec2-34-242-96-229.eu-west-1.compute.amazonaws.com. [34.242.96.229])
        by smtp.gmail.com with ESMTPSA id h10-20020a5d504a000000b00313e8dc7facsm4883533wrt.116.2023.06.26.01.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 01:58:14 -0700 (PDT)
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
	linux-kernel@vger.kernel.org
Cc: puranjay12@gmail.com
Subject: [PATCH bpf-next v4 3/3] bpf, arm64: use bpf_jit_binary_pack_alloc
Date: Mon, 26 Jun 2023 08:58:11 +0000
Message-Id: <20230626085811.3192402-4-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230626085811.3192402-1-puranjay12@gmail.com>
References: <20230626085811.3192402-1-puranjay12@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
Changes in v3 => v4:
- Fix the cache maintenance by cleaning the data cache and invalidating the
  i-Cache only *after* copying the instructions to the ROX region.

Changes in v2 => v3:
- Set prog = orig_prog; in the failure path of bpf_jit_binary_pack_finalize()
call.
- Add comments explaining the usage of the offsets in the exception table.

Changes in v1 => v2:
- Made the naming of ro_ prefix consistent.
  Now image/header/image_ptr are read/write and
  ro_image/ro_header/ro_image_ptr are read-only.

 arch/arm64/net/bpf_jit_comp.c | 145 ++++++++++++++++++++++++++++------
 1 file changed, 121 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 145b540ec34f..cd05f0c513f4 100644
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
@@ -205,6 +206,20 @@ static void jit_fill_hole(void *area, unsigned int size)
 		*ptr++ = cpu_to_le32(AARCH64_BREAK_FAULT);
 }
 
+int bpf_arch_text_invalidate(void *dst, size_t len)
+{
+	__le32 *ptr;
+	int ret;
+
+	for (ptr = dst; len >= sizeof(u32); len -= sizeof(u32)) {
+		ret = aarch64_insn_patch_text_nosync(ptr++, AARCH64_BREAK_FAULT);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static inline int epilogue_offset(const struct jit_ctx *ctx)
 {
 	int to = ctx->epilogue_offset;
@@ -701,7 +716,8 @@ static int add_exception_handler(const struct bpf_insn *insn,
 				 struct jit_ctx *ctx,
 				 int dst_reg)
 {
-	off_t offset;
+	off_t ins_offset;
+	off_t fixup_offset;
 	unsigned long pc;
 	struct exception_table_entry *ex;
 
@@ -717,12 +733,17 @@ static int add_exception_handler(const struct bpf_insn *insn,
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
@@ -731,12 +752,25 @@ static int add_exception_handler(const struct bpf_insn *insn,
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
@@ -1446,7 +1480,8 @@ static inline void bpf_flush_icache(void *start, void *end)
 
 struct arm64_jit_data {
 	struct bpf_binary_header *header;
-	u8 *image;
+	u8 *ro_image;
+	struct bpf_binary_header *ro_header;
 	struct jit_ctx ctx;
 };
 
@@ -1455,12 +1490,14 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
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
@@ -1487,8 +1524,11 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
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
@@ -1533,18 +1573,27 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
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
@@ -1552,9 +1601,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	build_prologue(&ctx, was_classic);
 
 	if (build_body(&ctx, extra_pass)) {
-		bpf_jit_binary_free(header);
 		prog = orig_prog;
-		goto out_off;
+		goto out_free_hdr;
 	}
 
 	build_epilogue(&ctx);
@@ -1562,34 +1610,44 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 
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
 
@@ -1610,6 +1668,14 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
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
@@ -1617,6 +1683,13 @@ bool bpf_jit_supports_kfunc_call(void)
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
@@ -2221,3 +2294,27 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type poke_type,
 
 	return ret;
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
+			bpf_jit_binary_pack_finalize(prog, jit_data->ro_header,
+						     jit_data->header);
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


