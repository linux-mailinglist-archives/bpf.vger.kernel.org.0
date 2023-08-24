Return-Path: <bpf+bounces-8479-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB3178704A
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 15:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74DE22813D0
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 13:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD382891C;
	Thu, 24 Aug 2023 13:31:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A595CA6E
	for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 13:31:46 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD14EE5E;
	Thu, 24 Aug 2023 06:31:44 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-31c73c21113so739143f8f.1;
        Thu, 24 Aug 2023 06:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692883903; x=1693488703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZE4gDzK4BarFOpFDUm7HsASsZoYlPGB/PtNYZtQuQCs=;
        b=kUDT9RjwDHv+JZXpX798v6QF8WCmiH9+ChraAqrdEgCcxpCTrkdSXC0HSqVuKGjMoe
         4TZ8TMsgeLbCUFChDXAMCx6GW8BPtylnx6TxgmN4afs+pjIBNFfdfZRMMXCg+w1vCtJQ
         QVz/uXJ5LUmDSA8901Uj6fGVc1hqiBYqIfWuYJXgvMS6bBU6xifqsCXcLQUGB2WF/+l/
         h+AhNeV5kA1gZ/qCEYrW5jhJfQe+YSE9g5+qL1Uo3Fukd/qZCisCNVUW6QJ+LdkiFr9N
         3otdSppiB1rW3Gw2F1X2OCk3aNWlspGnyXPpEmCKaIABB28qu6r4/gT6duzmsg+48xQe
         +rEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692883903; x=1693488703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZE4gDzK4BarFOpFDUm7HsASsZoYlPGB/PtNYZtQuQCs=;
        b=Ytoubjx/yvO5g+ZHK1kugfmx/uCNZ4y5rmHjAG9TWOVEtEMMkVzuGyx8JbfdZfJaHO
         b0Z7YPNuV+bzW4IJB767xPRIjORx6jLP2cHpO/aFJO9SNyjLziOkXYwNHSBhNIDfSGSV
         scVdbsq9CqNkHdDNDPeUJRYW9CCLCsYwJWHyAHcZBrSnftMpUSJ+0KPd/ikHE+si5YqK
         GOI2yVmONIj2CtJlk6G7QbpEXJxUPSv6g33OpVbSMp0IarfTLKltb6FU/TYFWbSAC7Q0
         UIV/uh82fQ+hjjN6xscnbXxGWDtbjA0mlHHwCBoWlHsaLRGZi4A+Aj4ZMtl+ExofvlFQ
         TqZQ==
X-Gm-Message-State: AOJu0YyOGAkfnyCv6XKg9dstSLTVjssuH3TDiDP6O/oOZWKR/Hx33S5+
	wsyhBLj9Kv32dLcJpBmfJ5Y=
X-Google-Smtp-Source: AGHT+IE1DHrzD3RMD7X4DeWFzUxZYCQraZB2mYQ/IPMdz7u1EG1Wbjt6XtsI/mZNX+FYlVXWg+AhbQ==
X-Received: by 2002:adf:f602:0:b0:31c:5e4d:4e75 with SMTP id t2-20020adff602000000b0031c5e4d4e75mr7471812wrp.44.1692883902923;
        Thu, 24 Aug 2023 06:31:42 -0700 (PDT)
Received: from ip-172-31-30-46.eu-west-1.compute.internal (ec2-54-170-241-106.eu-west-1.compute.amazonaws.com. [54.170.241.106])
        by smtp.gmail.com with ESMTPSA id h11-20020a5d548b000000b00317e77106dbsm22396112wrv.48.2023.08.24.06.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 06:31:41 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 3/3] bpf, riscv: use prog pack allocator in the BPF JIT
Date: Thu, 24 Aug 2023 13:31:35 +0000
Message-Id: <20230824133135.1176709-4-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230824133135.1176709-1-puranjay12@gmail.com>
References: <20230824133135.1176709-1-puranjay12@gmail.com>
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
---
 arch/riscv/net/bpf_jit.h        |   3 +
 arch/riscv/net/bpf_jit_comp64.c |  56 +++++++++++++---
 arch/riscv/net/bpf_jit_core.c   | 113 +++++++++++++++++++++++++++-----
 3 files changed, 146 insertions(+), 26 deletions(-)

diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
index 2717f5490428..ad69319c8ea7 100644
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
index 0ca4f5c0097c..d77b16338ba2 100644
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
@@ -465,7 +469,11 @@ static int emit_call(u64 addr, bool fixed_addr, struct rv_jit_context *ctx)
 	u64 ip;
 
 	if (addr && ctx->insns) {
-		ip = (u64)(long)(ctx->insns + ctx->ninsns);
+		/*
+		 * Use the ro_insns(RX) to calculate the offset as the BPF
+		 * program will finally run from this memory region.
+		 */
+		ip = (u64)(long)(ctx->ro_insns + ctx->ninsns);
 		off = addr - ip;
 	}
 
@@ -578,7 +586,8 @@ static int add_exception_handler(const struct bpf_insn *insn,
 {
 	struct exception_table_entry *ex;
 	unsigned long pc;
-	off_t offset;
+	off_t ins_offset;
+	off_t fixup_offset;
 
 	if (!ctx->insns || !ctx->prog->aux->extable || BPF_MODE(insn->code) != BPF_PROBE_MEM)
 		return 0;
@@ -593,12 +602,17 @@ static int add_exception_handler(const struct bpf_insn *insn,
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
@@ -607,12 +621,25 @@ static int add_exception_handler(const struct bpf_insn *insn,
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
 
@@ -1006,6 +1033,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,
 
 	ctx.ninsns = 0;
 	ctx.insns = NULL;
+	ctx.ro_insns = NULL;
 	ret = __arch_prepare_bpf_trampoline(im, m, tlinks, func_addr, flags, &ctx);
 	if (ret < 0)
 		return ret;
@@ -1014,7 +1042,15 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,
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
index 7a26a3e1c73c..4c8dffc09368 100644
--- a/arch/riscv/net/bpf_jit_core.c
+++ b/arch/riscv/net/bpf_jit_core.c
@@ -8,6 +8,8 @@
 
 #include <linux/bpf.h>
 #include <linux/filter.h>
+#include <linux/memory.h>
+#include <asm/patch.h>
 #include "bpf_jit.h"
 
 /* Number of iterations to try until offsets converge. */
@@ -117,16 +119,27 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 				sizeof(struct exception_table_entry);
 			prog_size = sizeof(*ctx->insns) * ctx->ninsns;
 
-			jit_data->header =
-				bpf_jit_binary_alloc(prog_size + extable_size,
-						     &jit_data->image,
-						     sizeof(u32),
-						     bpf_fill_ill_insns);
-			if (!jit_data->header) {
+			jit_data->ro_header =
+				bpf_jit_binary_pack_alloc(prog_size +
+							  extable_size,
+							  &jit_data->ro_image,
+							  sizeof(u32),
+							  &jit_data->header,
+							  &jit_data->image,
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
@@ -138,14 +151,12 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 
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
@@ -154,23 +165,35 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 
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
+		if (WARN_ON(bpf_jit_binary_pack_finalize(prog,
+							 jit_data->ro_header,
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
+		bpf_flush_icache(jit_data->ro_header,
+				 ctx->ro_insns + ctx->ninsns);
 		for (i = 0; i < prog->len; i++)
 			ctx->offset[i] = ninsns_rvoff(ctx->offset[i]);
 		bpf_prog_fill_jited_linfo(prog, ctx->offset);
@@ -185,6 +208,15 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		bpf_jit_prog_release_other(prog, prog == orig_prog ?
 					   tmp : orig_prog);
 	return prog;
+
+out_free_hdr:
+	if (jit_data->header) {
+		bpf_arch_text_copy(&jit_data->ro_header->size,
+				   &jit_data->header->size,
+				   sizeof(jit_data->header->size));
+		bpf_jit_binary_pack_free(jit_data->ro_header, jit_data->header);
+	}
+	goto out_offset;
 }
 
 u64 bpf_jit_alloc_exec_limit(void)
@@ -204,3 +236,52 @@ void bpf_jit_free_exec(void *addr)
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
+	int ret = 0;
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
2.39.2


