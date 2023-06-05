Return-Path: <bpf+bounces-1798-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D50F2721FD2
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 09:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9027A2811F8
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 07:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE5711CBE;
	Mon,  5 Jun 2023 07:40:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D407911CA1
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 07:40:30 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084D1BD;
	Mon,  5 Jun 2023 00:40:29 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-30af0aa4812so3963052f8f.1;
        Mon, 05 Jun 2023 00:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685950827; x=1688542827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7uLu0MKoT2YcSWwQmWFrEpyEOBt5snH1w0w+98A6AE=;
        b=Fd+8ZiArtALO8L+RipgFoGryrvHn7aJdM+c71cEUaFe8WfAEZ6lgy6p4vBq2GEJ+Rr
         HiP7oQvJecxPZYwzaIuV2kqp/4UpNHlwwM/R1a1bcPALoJBjY3mZPzFOrvQE8AI0DK+T
         pQe9AfMue8cdVvJFzyaVUQS/0f/67AFrUeahlUbZ8ke6675YAEJY8rmrQN9YTf/kD79D
         L800uulHIHdoJE3F33NV+yY9eaWmMlaBLTkWbspCOPf3OFtxl2OwIBmBfgFVTCF1GWdw
         +6VgCl58xSBkJl87ubVaCA5rQAL085z8Vi3CbKQtK4KYdbv5XFe2mr/MXZaE8B3hVoSe
         YOSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685950827; x=1688542827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U7uLu0MKoT2YcSWwQmWFrEpyEOBt5snH1w0w+98A6AE=;
        b=OGT/92ewv9ZQMTT68BfEJw4I19Bu4RSnb1SrDW4X7fPMqx742BGNl4N7YUmGU8rthp
         rH2iNtcaNDlPDbwoL80t/rO4FqxFqjCrehCDGyrg5gbfO8op1mLJboEVKZ0veKKonjUA
         TRtZqZXaExPEkOSMgoAfakiRH+0vM7O4IiIw+8E3LQVPHPO3rWMr5C4YbvsfH3mFDdke
         0rmXRIMI12mlsrh3Poa6lrNgcIyoh5nGNKVe9oAzHWlccO6hd16ePyeRvBfnWdrlhKzB
         F5g5r7dCizqddQqd4caDL+DHyijt6srmUcWQqhjq90WMLhGd3tqi54w1jGTTAZPvKbRb
         OM9A==
X-Gm-Message-State: AC+VfDxFt03BtBTWeCx+RbSkTA8/FA2OjTtljlG86tBlmEz6utO9klPl
	4WnaHsSUIW5hBJsev7GI7eU=
X-Google-Smtp-Source: ACHHUZ5Db5vZjZItfR09bz49VUXwkGlA7pPtWGZM69tBAdXIUMUY/apMk1UlRmXTQKopJ/U4OGhBvg==
X-Received: by 2002:a05:6000:194e:b0:307:c471:7b38 with SMTP id e14-20020a056000194e00b00307c4717b38mr4119865wry.59.1685950827352;
        Mon, 05 Jun 2023 00:40:27 -0700 (PDT)
Received: from ip-172-31-22-112.eu-west-1.compute.internal (ec2-34-244-49-215.eu-west-1.compute.amazonaws.com. [34.244.49.215])
        by smtp.gmail.com with ESMTPSA id c18-20020adfed92000000b0030ae499da59sm8882103wro.111.2023.06.05.00.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 00:40:27 -0700 (PDT)
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
Subject: [PATCH bpf-next 3/3] bpf, arm64: use bpf_jit_binary_pack_alloc
Date: Mon,  5 Jun 2023 07:40:24 +0000
Message-Id: <20230605074024.1055863-4-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230605074024.1055863-1-puranjay12@gmail.com>
References: <20230605074024.1055863-1-puranjay12@gmail.com>
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
done, the program is copied to the final ROX buffer
with bpf_jit_binary_pack_finalize.

Implement bpf_arch_text_copy() and bpf_arch_text_invalidate() for ARM64
JIT as these functions are required by bpf_jit_binary_pack allocator.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 arch/arm64/net/bpf_jit_comp.c | 119 +++++++++++++++++++++++++++++-----
 1 file changed, 102 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 145b540ec34f..ee9414cadea8 100644
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
 
@@ -717,12 +733,11 @@ static int add_exception_handler(const struct bpf_insn *insn,
 		return -EINVAL;
 
 	ex = &ctx->prog->aux->extable[ctx->exentry_idx];
-	pc = (unsigned long)&ctx->image[ctx->idx - 1];
+	pc = (unsigned long)&ctx->ro_image[ctx->idx - 1];
 
-	offset = pc - (long)&ex->insn;
-	if (WARN_ON_ONCE(offset >= 0 || offset < INT_MIN))
+	ins_offset = pc - (long)&ex->insn;
+	if (WARN_ON_ONCE(ins_offset >= 0 || ins_offset < INT_MIN))
 		return -ERANGE;
-	ex->insn = offset;
 
 	/*
 	 * Since the extable follows the program, the fixup offset is always
@@ -732,11 +747,20 @@ static int add_exception_handler(const struct bpf_insn *insn,
 	 * modifying the upper bits because the table is already sorted, and
 	 * isn't part of the main exception table.
 	 */
-	offset = (long)&ex->fixup - (pc + AARCH64_INSN_SIZE);
-	if (!FIELD_FIT(BPF_FIXUP_OFFSET_MASK, offset))
+	fixup_offset = (long)&ex->fixup - (pc + AARCH64_INSN_SIZE);
+	if (!FIELD_FIT(BPF_FIXUP_OFFSET_MASK, fixup_offset))
 		return -ERANGE;
 
-	ex->fixup = FIELD_PREP(BPF_FIXUP_OFFSET_MASK, offset) |
+	/*
+	 * The offsets above have been calculated using the RO+X buffer but we
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
@@ -1446,6 +1470,7 @@ static inline void bpf_flush_icache(void *start, void *end)
 
 struct arm64_jit_data {
 	struct bpf_binary_header *header;
+	struct bpf_binary_header *rw_header;
 	u8 *image;
 	struct jit_ctx ctx;
 };
@@ -1454,6 +1479,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 {
 	int image_size, prog_size, extable_size, extable_align, extable_offset;
 	struct bpf_prog *tmp, *orig_prog = prog;
+	struct bpf_binary_header *rw_header;
 	struct bpf_binary_header *header;
 	struct arm64_jit_data *jit_data;
 	bool was_classic = bpf_prog_was_classic(prog);
@@ -1461,6 +1487,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	bool extra_pass = false;
 	struct jit_ctx ctx;
 	u8 *image_ptr;
+	u8 *rw_image_ptr;
 
 	if (!prog->jit_requested)
 		return orig_prog;
@@ -1489,6 +1516,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		ctx = jit_data->ctx;
 		image_ptr = jit_data->image;
 		header = jit_data->header;
+		rw_header = jit_data->rw_header;
+		rw_image_ptr = (void *)rw_header + ((void *)image_ptr
+						 - (void *)header);
 		extra_pass = true;
 		prog_size = sizeof(u32) * ctx.idx;
 		goto skip_init_ctx;
@@ -1533,8 +1563,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	/* also allocate space for plt target */
 	extable_offset = round_up(prog_size + PLT_TARGET_SIZE, extable_align);
 	image_size = extable_offset + extable_size;
-	header = bpf_jit_binary_alloc(image_size, &image_ptr,
-				      sizeof(u32), jit_fill_hole);
+	header = bpf_jit_binary_pack_alloc(image_size, &image_ptr, sizeof(u32),
+					   &rw_header, &rw_image_ptr,
+					   jit_fill_hole);
 	if (header == NULL) {
 		prog = orig_prog;
 		goto out_off;
@@ -1542,19 +1573,24 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 
 	/* 2. Now, the actual pass. */
 
-	ctx.image = (__le32 *)image_ptr;
 	if (extable_size)
 		prog->aux->extable = (void *)image_ptr + extable_offset;
 skip_init_ctx:
+	/*
+	 * Use the rw_image_ptr for writing the JITed instructions.
+	 * Save the read only image_ptr in ctx because it will be used to
+	 * calculate offsets for filling out the exception table later.
+	 */
+	ctx.image = (__le32 *)rw_image_ptr;
+	ctx.ro_image = (__le32 *)image_ptr;
 	ctx.idx = 0;
 	ctx.exentry_idx = 0;
 
 	build_prologue(&ctx, was_classic);
 
 	if (build_body(&ctx, extra_pass)) {
-		bpf_jit_binary_free(header);
 		prog = orig_prog;
-		goto out_off;
+		goto out_free_hdr;
 	}
 
 	build_epilogue(&ctx);
@@ -1562,32 +1598,42 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 
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
 
+	/*
+	 * As the JITed instructions have been written to the R/W buffer, we can
+	 * move ctx.image back to the RO+X buffer from where the BPF program
+	 * will run. bpf_jit_binary_pack_finalize() will copy the instructions
+	 * from the R/W buffer to the RO+X buffer.
+	 */
+	ctx.image = (__le32 *)image_ptr;
 	bpf_flush_icache(header, ctx.image + ctx.idx);
 
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
+		if (WARN_ON(bpf_jit_binary_pack_finalize(prog, header,
+							 rw_header))) {
+			header = NULL;
 			goto out_off;
 		}
-		bpf_jit_binary_lock_ro(header);
 	} else {
 		jit_data->ctx = ctx;
 		jit_data->image = image_ptr;
 		jit_data->header = header;
+		jit_data->rw_header = rw_header;
 	}
 	prog->bpf_func = (void *)ctx.image;
 	prog->jited = 1;
@@ -1610,6 +1656,14 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		bpf_jit_prog_release_other(prog, prog == orig_prog ?
 					   tmp : orig_prog);
 	return prog;
+
+out_free_hdr:
+	if (header) {
+		bpf_arch_text_copy(&header->size, &rw_header->size,
+				   sizeof(rw_header->size));
+		bpf_jit_binary_pack_free(header, rw_header);
+	}
+	goto out_off;
 }
 
 bool bpf_jit_supports_kfunc_call(void)
@@ -1617,6 +1671,13 @@ bool bpf_jit_supports_kfunc_call(void)
 	return true;
 }
 
+void *bpf_arch_text_copy(void *dst, void *src, size_t len)
+{
+	if (aarch64_insn_copy(dst, src, len) == NULL)
+		return ERR_PTR(-EINVAL);
+	return dst;
+}
+
 u64 bpf_jit_alloc_exec_limit(void)
 {
 	return VMALLOC_END - VMALLOC_START;
@@ -2221,3 +2282,27 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type poke_type,
 
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
+			bpf_jit_binary_pack_finalize(prog, jit_data->header,
+						     jit_data->rw_header);
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
2.39.2


