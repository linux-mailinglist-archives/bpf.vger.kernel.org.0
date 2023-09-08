Return-Path: <bpf+bounces-9514-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2ECD798918
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 16:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92ADC281E6C
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 14:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E29F514;
	Fri,  8 Sep 2023 14:43:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8B863C5
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 14:43:29 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2621FCA;
	Fri,  8 Sep 2023 07:43:25 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-52bcd4db4bdso2822067a12.3;
        Fri, 08 Sep 2023 07:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694184204; x=1694789004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ThR5OLy+3JkliuZLZ6KlRbjSRoeoMQag0x1mHZU/8XI=;
        b=CaQTe04xWcRH+GXzkKjQWs78i0wIZciuRPSWJ8i5GCuOPLiEmbfzNpP6dkWRjLK/gI
         n627SE7/sA+o54rqPtiy24QJ0NB6Bfnm2AGJoXm8GWAYEcegMVq9luL0XTqndig4ZYEN
         kJu8dyVr4W88XopiGHOnQeVM7SwOk3bwZk0aQ7Qivr0Jy/8C+yOu0YttaUKVeS2rCWn0
         +SR2wP0F3J/BapmA/GR+4gVcSsCdT3rhuMhi1kkKU2JcBWe67CX81jZCjoKC68yEaUcv
         UrkPWEfZo0wHGJgDTNyYINBmZ29P+r2SHt5jjgtMjPmDGCrV6O79HL2Mre+Vyk7qI1fL
         yzuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694184204; x=1694789004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ThR5OLy+3JkliuZLZ6KlRbjSRoeoMQag0x1mHZU/8XI=;
        b=t96UXcWeNOntlx7M9cSekDxRjOOPnkMVlrX2CcqB41acKo/4+I2HJI9Bzwj4RTEC8A
         hD9nXvvdOoR1g/Pu8ByjuNCAmwuAghP+jm3toVlQnC/wIxvztYTAzuVnxOysit3oNd/Y
         1mPw8nVakiSG8UpDzgGl3Fg5VLr4GRdjUMaKP28ReeZBLAMhSjGV3M9Yp94g5UqK8+Zi
         BJ9kpCy6TzBR4l7Oiq3bFZ7B4GxgBGiLvr7J4deX8aySBNTyi8DKX/vAXpvDfDHzk/HS
         VwAUjldYY6RfQT+otvQCJ5v48mpML2oaMYiULswwelkppksXLxus8XO4oPwnTNLjRFqe
         U75g==
X-Gm-Message-State: AOJu0Ywajt25ClylRGTivu//g9te7TgsXIK43uyVExf6cxwph58nmnxS
	xYClJnK0OhqS5P3122hTj6Y=
X-Google-Smtp-Source: AGHT+IFoU3JbElqJiH4iO+eq0y3MYGNE4W4vJzM+EJMS9XRt46ao/ZfiYeE9Lf+HfP3tZi1FdxI1NQ==
X-Received: by 2002:a17:907:7612:b0:9a9:efa0:fccf with SMTP id jx18-20020a170907761200b009a9efa0fccfmr2159161ejc.0.1694184204186;
        Fri, 08 Sep 2023 07:43:24 -0700 (PDT)
Received: from ip-172-31-30-46.eu-west-1.compute.internal (ec2-54-217-129-48.eu-west-1.compute.amazonaws.com. [54.217.129.48])
        by smtp.gmail.com with ESMTPSA id lz5-20020a170906fb0500b0098e78ff1a87sm1099436ejb.120.2023.09.08.07.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 07:43:23 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 3/3] bpf, arm64: use bpf_jit_binary_pack_alloc
Date: Fri,  8 Sep 2023 14:43:20 +0000
Message-Id: <20230908144320.2474-4-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908144320.2474-1-puranjay12@gmail.com>
References: <20230908144320.2474-1-puranjay12@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
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
 arch/arm64/net/bpf_jit_comp.c | 136 ++++++++++++++++++++++++++++------
 1 file changed, 112 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 150d1c6543f7..98efad6aaa19 100644
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
@@ -205,6 +206,11 @@ static void jit_fill_hole(void *area, unsigned int size)
 		*ptr++ = cpu_to_le32(AARCH64_BREAK_FAULT);
 }
 
+int bpf_arch_text_invalidate(void *dst, size_t len)
+{
+	return aarch64_insn_set(dst, AARCH64_BREAK_FAULT, len);
+}
+
 static inline int epilogue_offset(const struct jit_ctx *ctx)
 {
 	int to = ctx->epilogue_offset;
@@ -707,7 +713,8 @@ static int add_exception_handler(const struct bpf_insn *insn,
 				 struct jit_ctx *ctx,
 				 int dst_reg)
 {
-	off_t offset;
+	off_t ins_offset;
+	off_t fixup_offset;
 	unsigned long pc;
 	struct exception_table_entry *ex;
 
@@ -724,12 +731,17 @@ static int add_exception_handler(const struct bpf_insn *insn,
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
@@ -738,12 +750,25 @@ static int add_exception_handler(const struct bpf_insn *insn,
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
@@ -1511,7 +1536,8 @@ static inline void bpf_flush_icache(void *start, void *end)
 
 struct arm64_jit_data {
 	struct bpf_binary_header *header;
-	u8 *image;
+	u8 *ro_image;
+	struct bpf_binary_header *ro_header;
 	struct jit_ctx ctx;
 };
 
@@ -1520,12 +1546,14 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
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
@@ -1552,8 +1580,11 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
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
@@ -1598,18 +1629,27 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
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
@@ -1617,9 +1657,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	build_prologue(&ctx, was_classic);
 
 	if (build_body(&ctx, extra_pass)) {
-		bpf_jit_binary_free(header);
 		prog = orig_prog;
-		goto out_off;
+		goto out_free_hdr;
 	}
 
 	build_epilogue(&ctx);
@@ -1627,34 +1666,44 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 
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
 
@@ -1675,6 +1724,14 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
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
@@ -1682,6 +1739,13 @@ bool bpf_jit_supports_kfunc_call(void)
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
@@ -2286,3 +2350,27 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type poke_type,
 
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


