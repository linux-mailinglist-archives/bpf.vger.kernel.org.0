Return-Path: <bpf+bounces-8626-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 851B0788C50
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 17:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 236C128183A
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 15:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA01107A0;
	Fri, 25 Aug 2023 15:18:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE974CA60
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 15:18:49 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71BB7212C
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 08:18:47 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37PEv9sn027614;
	Fri, 25 Aug 2023 15:18:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=b5iyNSIy/dvRWAiwMyb1JSzXYVNw0u1Ec3TtzrL04SQ=;
 b=OQut1+bw+xkxIX/4ANflemNi7NjPXnqHXFYrUVzypPhmmr/gPN4qPZOkiO6ieOYXrOAd
 PBnRkcDJ+w6yekptz9qtty6zhxU5pzIsZHM+/H03ML30rGFjD+UM9H6wjTzH3iMpEiM2
 Afyt+taEfzzOBxhJaYZoTtLJAIVGcUCC/U8Avr2jJG9a9o0gGtT3w0GHbMHotH9X9cA/
 m6dRV+TobwmNuZL45UPWgNJHx3gZfjbfd4gT3y3jWMv/waF67oYnSVLeuxvtt1fxgJXq
 5lmNuzATUIFaAEG3v82RnRO9FV2KNO0b27Ha5q9SDSOMxZuMmMN/ObPLeMhmDzVkKYAp Tw== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3spxgqrnwj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Aug 2023 15:18:24 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37PF4Bkn026133;
	Fri, 25 Aug 2023 15:18:23 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3snqgtfwq3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Aug 2023 15:18:23 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37PFIMEM44761614
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Aug 2023 15:18:22 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 271F62004D;
	Fri, 25 Aug 2023 15:18:22 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1FA4420040;
	Fri, 25 Aug 2023 15:18:20 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.ibm.com.com (unknown [9.43.75.97])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Aug 2023 15:18:19 +0000 (GMT)
From: Hari Bathini <hbathini@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, bpf@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Song Liu <songliubraving@fb.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v3 3/5] powerpc/bpf: use bpf_jit_binary_pack_[alloc|finalize|free]
Date: Fri, 25 Aug 2023 20:48:08 +0530
Message-ID: <20230825151810.164418-4-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230825151810.164418-1-hbathini@linux.ibm.com>
References: <20230825151810.164418-1-hbathini@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tOhpBRY7cfgmApMakPcjrxsT_Y-p-691
X-Proofpoint-ORIG-GUID: tOhpBRY7cfgmApMakPcjrxsT_Y-p-691
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_13,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308250134
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Use bpf_jit_binary_pack_alloc in powerpc jit. The jit engine first
writes the program to the rw buffer. When the jit is done, the program
is copied to the final location with bpf_jit_binary_pack_finalize.
With multiple jit_subprogs, bpf_jit_free is called on some subprograms
that haven't got bpf_jit_binary_pack_finalize() yet. Implement custom
bpf_jit_free() like in commit 1d5f82d9dd47 ("bpf, x86: fix freeing of
not-finalized bpf_prog_pack") to call bpf_jit_binary_pack_finalize(),
if necessary. While here, correct the misnomer powerpc64_jit_data to
powerpc_jit_data as it is meant for both ppc32 and ppc64.

Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
---
 arch/powerpc/net/bpf_jit.h        |  12 ++--
 arch/powerpc/net/bpf_jit_comp.c   | 110 ++++++++++++++++++++++--------
 arch/powerpc/net/bpf_jit_comp32.c |  13 ++--
 arch/powerpc/net/bpf_jit_comp64.c |  10 +--
 4 files changed, 98 insertions(+), 47 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
index 72b7bb34fade..02bd89aa8ea5 100644
--- a/arch/powerpc/net/bpf_jit.h
+++ b/arch/powerpc/net/bpf_jit.h
@@ -36,9 +36,6 @@
 		EMIT(PPC_RAW_BRANCH(offset));				      \
 	} while (0)
 
-/* bl (unconditional 'branch' with link) */
-#define PPC_BL(dest)	EMIT(PPC_RAW_BL((dest) - (unsigned long)(image + ctx->idx)))
-
 /* "cond" here covers BO:BI fields. */
 #define PPC_BCC_SHORT(cond, dest)					      \
 	do {								      \
@@ -169,16 +166,17 @@ static inline void bpf_clear_seen_register(struct codegen_context *ctx, int i)
 }
 
 void bpf_jit_init_reg_mapping(struct codegen_context *ctx);
-int bpf_jit_emit_func_call_rel(u32 *image, struct codegen_context *ctx, u64 func);
-int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *ctx,
+int bpf_jit_emit_func_call_rel(u32 *image, u32 *fimage, struct codegen_context *ctx, u64 func);
+int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct codegen_context *ctx,
 		       u32 *addrs, int pass, bool extra_pass);
 void bpf_jit_build_prologue(u32 *image, struct codegen_context *ctx);
 void bpf_jit_build_epilogue(u32 *image, struct codegen_context *ctx);
 void bpf_jit_realloc_regs(struct codegen_context *ctx);
 int bpf_jit_emit_exit_insn(u32 *image, struct codegen_context *ctx, int tmp_reg, long exit_addr);
 
-int bpf_add_extable_entry(struct bpf_prog *fp, u32 *image, int pass, struct codegen_context *ctx,
-			  int insn_idx, int jmp_off, int dst_reg);
+int bpf_add_extable_entry(struct bpf_prog *fp, u32 *image, u32 *fimage, int pass,
+			  struct codegen_context *ctx, int insn_idx,
+			  int jmp_off, int dst_reg);
 
 #endif
 
diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index 7cd4cf53d61c..c60d7570e05d 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -64,10 +64,13 @@ int bpf_jit_emit_exit_insn(u32 *image, struct codegen_context *ctx, int tmp_reg,
 	return 0;
 }
 
-struct powerpc64_jit_data {
-	struct bpf_binary_header *header;
+struct powerpc_jit_data {
+	/* address of rw header */
+	struct bpf_binary_header *hdr;
+	/* address of ro final header */
+	struct bpf_binary_header *fhdr;
 	u32 *addrs;
-	u8 *image;
+	u8 *fimage;
 	u32 proglen;
 	struct codegen_context ctx;
 };
@@ -84,15 +87,18 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 	u8 *image = NULL;
 	u32 *code_base;
 	u32 *addrs;
-	struct powerpc64_jit_data *jit_data;
+	struct powerpc_jit_data *jit_data;
 	struct codegen_context cgctx;
 	int pass;
 	int flen;
-	struct bpf_binary_header *bpf_hdr;
+	struct bpf_binary_header *fhdr = NULL;
+	struct bpf_binary_header *hdr = NULL;
 	struct bpf_prog *org_fp = fp;
 	struct bpf_prog *tmp_fp;
 	bool bpf_blinded = false;
 	bool extra_pass = false;
+	u8 *fimage = NULL;
+	u32 *fcode_base;
 	u32 extable_len;
 	u32 fixup_len;
 
@@ -122,9 +128,16 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 	addrs = jit_data->addrs;
 	if (addrs) {
 		cgctx = jit_data->ctx;
-		image = jit_data->image;
-		bpf_hdr = jit_data->header;
+		/*
+		 * JIT compiled to a writable location (image/code_base) first.
+		 * It is then moved to the readonly final location (fimage/fcode_base)
+		 * using instruction patching.
+		 */
+		fimage = jit_data->fimage;
+		fhdr = jit_data->fhdr;
 		proglen = jit_data->proglen;
+		hdr = jit_data->hdr;
+		image = (void *)hdr + ((void *)fimage - (void *)fhdr);
 		extra_pass = true;
 		/* During extra pass, ensure index is reset before repopulating extable entries */
 		cgctx.exentry_idx = 0;
@@ -144,7 +157,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 	cgctx.stack_size = round_up(fp->aux->stack_depth, 16);
 
 	/* Scouting faux-generate pass 0 */
-	if (bpf_jit_build_body(fp, 0, &cgctx, addrs, 0, false)) {
+	if (bpf_jit_build_body(fp, NULL, NULL, &cgctx, addrs, 0, false)) {
 		/* We hit something illegal or unsupported. */
 		fp = org_fp;
 		goto out_addrs;
@@ -159,7 +172,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 	 */
 	if (cgctx.seen & SEEN_TAILCALL || !is_offset_in_branch_range((long)cgctx.idx * 4)) {
 		cgctx.idx = 0;
-		if (bpf_jit_build_body(fp, 0, &cgctx, addrs, 0, false)) {
+		if (bpf_jit_build_body(fp, NULL, NULL, &cgctx, addrs, 0, false)) {
 			fp = org_fp;
 			goto out_addrs;
 		}
@@ -181,17 +194,19 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 	proglen = cgctx.idx * 4;
 	alloclen = proglen + FUNCTION_DESCR_SIZE + fixup_len + extable_len;
 
-	bpf_hdr = bpf_jit_binary_alloc(alloclen, &image, 4, bpf_jit_fill_ill_insns);
-	if (!bpf_hdr) {
+	fhdr = bpf_jit_binary_pack_alloc(alloclen, &fimage, 4, &hdr, &image,
+					      bpf_jit_fill_ill_insns);
+	if (!fhdr) {
 		fp = org_fp;
 		goto out_addrs;
 	}
 
 	if (extable_len)
-		fp->aux->extable = (void *)image + FUNCTION_DESCR_SIZE + proglen + fixup_len;
+		fp->aux->extable = (void *)fimage + FUNCTION_DESCR_SIZE + proglen + fixup_len;
 
 skip_init_ctx:
 	code_base = (u32 *)(image + FUNCTION_DESCR_SIZE);
+	fcode_base = (u32 *)(fimage + FUNCTION_DESCR_SIZE);
 
 	/* Code generation passes 1-2 */
 	for (pass = 1; pass < 3; pass++) {
@@ -199,8 +214,10 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 		cgctx.idx = 0;
 		cgctx.alt_exit_addr = 0;
 		bpf_jit_build_prologue(code_base, &cgctx);
-		if (bpf_jit_build_body(fp, code_base, &cgctx, addrs, pass, extra_pass)) {
-			bpf_jit_binary_free(bpf_hdr);
+		if (bpf_jit_build_body(fp, code_base, fcode_base, &cgctx, addrs, pass,
+				       extra_pass)) {
+			bpf_arch_text_copy(&fhdr->size, &hdr->size, sizeof(hdr->size));
+			bpf_jit_binary_pack_free(fhdr, hdr);
 			fp = org_fp;
 			goto out_addrs;
 		}
@@ -220,17 +237,19 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 
 #ifdef CONFIG_PPC64_ELF_ABI_V1
 	/* Function descriptor nastiness: Address + TOC */
-	((u64 *)image)[0] = (u64)code_base;
+	((u64 *)image)[0] = (u64)fcode_base;
 	((u64 *)image)[1] = local_paca->kernel_toc;
 #endif
 
-	fp->bpf_func = (void *)image;
+	fp->bpf_func = (void *)fimage;
 	fp->jited = 1;
 	fp->jited_len = proglen + FUNCTION_DESCR_SIZE;
 
-	bpf_flush_icache(bpf_hdr, (u8 *)bpf_hdr + bpf_hdr->size);
 	if (!fp->is_func || extra_pass) {
-		bpf_jit_binary_lock_ro(bpf_hdr);
+		if (bpf_jit_binary_pack_finalize(fp, fhdr, hdr)) {
+			fp = org_fp;
+			goto out_addrs;
+		}
 		bpf_prog_fill_jited_linfo(fp, addrs);
 out_addrs:
 		kfree(addrs);
@@ -240,8 +259,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 		jit_data->addrs = addrs;
 		jit_data->ctx = cgctx;
 		jit_data->proglen = proglen;
-		jit_data->image = image;
-		jit_data->header = bpf_hdr;
+		jit_data->fimage = fimage;
+		jit_data->fhdr = fhdr;
+		jit_data->hdr = hdr;
 	}
 
 out:
@@ -255,12 +275,13 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
  * The caller should check for (BPF_MODE(code) == BPF_PROBE_MEM) before calling
  * this function, as this only applies to BPF_PROBE_MEM, for now.
  */
-int bpf_add_extable_entry(struct bpf_prog *fp, u32 *image, int pass, struct codegen_context *ctx,
-			  int insn_idx, int jmp_off, int dst_reg)
+int bpf_add_extable_entry(struct bpf_prog *fp, u32 *image, u32 *fimage, int pass,
+			  struct codegen_context *ctx, int insn_idx, int jmp_off,
+			  int dst_reg)
 {
 	off_t offset;
 	unsigned long pc;
-	struct exception_table_entry *ex;
+	struct exception_table_entry *ex, *ex_entry;
 	u32 *fixup;
 
 	/* Populate extable entries only in the last pass */
@@ -271,9 +292,16 @@ int bpf_add_extable_entry(struct bpf_prog *fp, u32 *image, int pass, struct code
 	    WARN_ON_ONCE(ctx->exentry_idx >= fp->aux->num_exentries))
 		return -EINVAL;
 
+	/*
+	 * Program is first written to image before copying to the
+	 * final location (fimage). Accordingly, update in the image first.
+	 * As all offsets used are relative, copying as is to the
+	 * final location should be alright.
+	 */
 	pc = (unsigned long)&image[insn_idx];
+	ex = (void *)fp->aux->extable - (void *)fimage + (void *)image;
 
-	fixup = (void *)fp->aux->extable -
+	fixup = (void *)ex -
 		(fp->aux->num_exentries * BPF_FIXUP_LEN * 4) +
 		(ctx->exentry_idx * BPF_FIXUP_LEN * 4);
 
@@ -284,17 +312,17 @@ int bpf_add_extable_entry(struct bpf_prog *fp, u32 *image, int pass, struct code
 	fixup[BPF_FIXUP_LEN - 1] =
 		PPC_RAW_BRANCH((long)(pc + jmp_off) - (long)&fixup[BPF_FIXUP_LEN - 1]);
 
-	ex = &fp->aux->extable[ctx->exentry_idx];
+	ex_entry = &ex[ctx->exentry_idx];
 
-	offset = pc - (long)&ex->insn;
+	offset = pc - (long)&ex_entry->insn;
 	if (WARN_ON_ONCE(offset >= 0 || offset < INT_MIN))
 		return -ERANGE;
-	ex->insn = offset;
+	ex_entry->insn = offset;
 
-	offset = (long)fixup - (long)&ex->fixup;
+	offset = (long)fixup - (long)&ex_entry->fixup;
 	if (WARN_ON_ONCE(offset >= 0 || offset < INT_MIN))
 		return -ERANGE;
-	ex->fixup = offset;
+	ex_entry->fixup = offset;
 
 	ctx->exentry_idx++;
 	return 0;
@@ -328,3 +356,27 @@ int bpf_arch_text_invalidate(void *dst, size_t len)
 
 	return ret;
 }
+
+void bpf_jit_free(struct bpf_prog *fp)
+{
+	if (fp->jited) {
+		struct powerpc_jit_data *jit_data = fp->aux->jit_data;
+		struct bpf_binary_header *hdr;
+
+		/*
+		 * If we fail the final pass of JIT (from jit_subprogs),
+		 * the program may not be finalized yet. Call finalize here
+		 * before freeing it.
+		 */
+		if (jit_data) {
+			bpf_jit_binary_pack_finalize(fp, jit_data->fhdr, jit_data->hdr);
+			kvfree(jit_data->addrs);
+			kfree(jit_data);
+		}
+		hdr = bpf_jit_binary_pack_hdr(fp);
+		bpf_jit_binary_pack_free(hdr, NULL);
+		WARN_ON_ONCE(!bpf_prog_kallsyms_verify_off(fp));
+	}
+
+	bpf_prog_unlock_free(fp);
+}
diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
index 7f91ea064c08..434417c755fd 100644
--- a/arch/powerpc/net/bpf_jit_comp32.c
+++ b/arch/powerpc/net/bpf_jit_comp32.c
@@ -200,12 +200,13 @@ void bpf_jit_build_epilogue(u32 *image, struct codegen_context *ctx)
 	EMIT(PPC_RAW_BLR());
 }
 
-int bpf_jit_emit_func_call_rel(u32 *image, struct codegen_context *ctx, u64 func)
+/* Relative offset needs to be calculated based on final image location */
+int bpf_jit_emit_func_call_rel(u32 *image, u32 *fimage, struct codegen_context *ctx, u64 func)
 {
-	s32 rel = (s32)func - (s32)(image + ctx->idx);
+	s32 rel = (s32)func - (s32)(fimage + ctx->idx);
 
 	if (image && rel < 0x2000000 && rel >= -0x2000000) {
-		PPC_BL(func);
+		EMIT(PPC_RAW_BL(rel));
 	} else {
 		/* Load function address into r0 */
 		EMIT(PPC_RAW_LIS(_R0, IMM_H(func)));
@@ -278,7 +279,7 @@ static int bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 o
 }
 
 /* Assemble the body code between the prologue & epilogue */
-int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *ctx,
+int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct codegen_context *ctx,
 		       u32 *addrs, int pass, bool extra_pass)
 {
 	const struct bpf_insn *insn = fp->insnsi;
@@ -997,7 +998,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 					jmp_off += 4;
 				}
 
-				ret = bpf_add_extable_entry(fp, image, pass, ctx, insn_idx,
+				ret = bpf_add_extable_entry(fp, image, fimage, pass, ctx, insn_idx,
 							    jmp_off, dst_reg);
 				if (ret)
 					return ret;
@@ -1053,7 +1054,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 				EMIT(PPC_RAW_STW(bpf_to_ppc(BPF_REG_5), _R1, 12));
 			}
 
-			ret = bpf_jit_emit_func_call_rel(image, ctx, func_addr);
+			ret = bpf_jit_emit_func_call_rel(image, fimage, ctx, func_addr);
 			if (ret)
 				return ret;
 
diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index 0f8048f6dad6..79f23974a320 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -240,7 +240,7 @@ static int bpf_jit_emit_func_call_hlp(u32 *image, struct codegen_context *ctx, u
 	return 0;
 }
 
-int bpf_jit_emit_func_call_rel(u32 *image, struct codegen_context *ctx, u64 func)
+int bpf_jit_emit_func_call_rel(u32 *image, u32 *fimage, struct codegen_context *ctx, u64 func)
 {
 	unsigned int i, ctx_idx = ctx->idx;
 
@@ -361,7 +361,7 @@ asm (
 );
 
 /* Assemble the body code between the prologue & epilogue */
-int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *ctx,
+int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct codegen_context *ctx,
 		       u32 *addrs, int pass, bool extra_pass)
 {
 	enum stf_barrier_type stf_barrier = stf_barrier_type_get();
@@ -940,8 +940,8 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 				addrs[++i] = ctx->idx * 4;
 
 			if (BPF_MODE(code) == BPF_PROBE_MEM) {
-				ret = bpf_add_extable_entry(fp, image, pass, ctx, ctx->idx - 1,
-							    4, dst_reg);
+				ret = bpf_add_extable_entry(fp, image, fimage, pass, ctx,
+							    ctx->idx - 1, 4, dst_reg);
 				if (ret)
 					return ret;
 			}
@@ -995,7 +995,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 			if (func_addr_fixed)
 				ret = bpf_jit_emit_func_call_hlp(image, ctx, func_addr);
 			else
-				ret = bpf_jit_emit_func_call_rel(image, ctx, func_addr);
+				ret = bpf_jit_emit_func_call_rel(image, fimage, ctx, func_addr);
 
 			if (ret)
 				return ret;
-- 
2.41.0


