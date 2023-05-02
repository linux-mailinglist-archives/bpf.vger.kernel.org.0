Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668BD6F4D6B
	for <lists+bpf@lfdr.de>; Wed,  3 May 2023 01:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjEBXJR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 2 May 2023 19:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjEBXJP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 May 2023 19:09:15 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BA1C3
        for <bpf@vger.kernel.org>; Tue,  2 May 2023 16:09:13 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 342JY52b021856
        for <bpf@vger.kernel.org>; Tue, 2 May 2023 16:09:13 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3qatbsqfc0-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 02 May 2023 16:09:12 -0700
Received: from twshared30317.05.prn5.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 2 May 2023 16:09:11 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 88E132FD4BE16; Tue,  2 May 2023 16:06:41 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 09/10] bpf: use recorded bpf_capable flag in JIT code
Date:   Tue, 2 May 2023 16:06:18 -0700
Message-ID: <20230502230619.2592406-10-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230502230619.2592406-1-andrii@kernel.org>
References: <20230502230619.2592406-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: hF4L54z7foW9-v2hQU00SuTBvw3lif2W
X-Proofpoint-GUID: hF4L54z7foW9-v2hQU00SuTBvw3lif2W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-02_12,2023-04-27_01,2023-02-09_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Use recorded bpf_capable flag of a BPF program in
bpf_jit_charge_modmem(), if possible. If BPF program is unavailable,
fallback to system-level bpf_capable() check. This is currently the case
for BPF trampoline update code, which might not be associated with
a particular instance of BPF program.

All the other users of bpf_jit_charge_modmem() do work within a context
of a specific BPF program, so can trivially use prog->aux->bpf_capable.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 arch/arm/net/bpf_jit_32.c        |  2 +-
 arch/arm64/net/bpf_jit_comp.c    |  2 +-
 arch/loongarch/net/bpf_jit.c     |  2 +-
 arch/mips/net/bpf_jit_comp.c     |  2 +-
 arch/powerpc/net/bpf_jit_comp.c  |  2 +-
 arch/riscv/net/bpf_jit_core.c    |  3 ++-
 arch/s390/net/bpf_jit_comp.c     |  3 ++-
 arch/sparc/net/bpf_jit_comp_64.c |  2 +-
 arch/x86/net/bpf_jit_comp.c      |  3 ++-
 arch/x86/net/bpf_jit_comp32.c    |  2 +-
 include/linux/bpf.h              |  2 +-
 include/linux/filter.h           |  6 ++++--
 kernel/bpf/core.c                | 20 +++++++++++---------
 kernel/bpf/trampoline.c          |  2 +-
 14 files changed, 30 insertions(+), 23 deletions(-)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index 6a1c9fca5260..82dae8e4d6b1 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -1963,7 +1963,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	image_size = sizeof(u32) * ctx.idx;
 
 	/* Now we know the size of the structure to make */
-	header = bpf_jit_binary_alloc(image_size, &image_ptr,
+	header = bpf_jit_binary_alloc(prog, image_size, &image_ptr,
 				      sizeof(u32), jit_fill_hole);
 	/* Not able to allocate memory for the structure then
 	 * we must fall back to the interpretation
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index b26da8efa616..5c60d9922a03 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1533,7 +1533,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	/* also allocate space for plt target */
 	extable_offset = round_up(prog_size + PLT_TARGET_SIZE, extable_align);
 	image_size = extable_offset + extable_size;
-	header = bpf_jit_binary_alloc(image_size, &image_ptr,
+	header = bpf_jit_binary_alloc(prog, image_size, &image_ptr,
 				      sizeof(u32), jit_fill_hole);
 	if (header == NULL) {
 		prog = orig_prog;
diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index db9342b2d0e6..c803581e87db 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -1172,7 +1172,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	prog_size = sizeof(u32) * ctx.idx;
 	image_size = prog_size + extable_size;
 	/* Now we know the size of the structure to make */
-	header = bpf_jit_binary_alloc(image_size, &image_ptr,
+	header = bpf_jit_binary_alloc(prog, image_size, &image_ptr,
 				      sizeof(u32), jit_fill_hole);
 	if (header == NULL) {
 		prog = orig_prog;
diff --git a/arch/mips/net/bpf_jit_comp.c b/arch/mips/net/bpf_jit_comp.c
index a40d926b6513..365849adc238 100644
--- a/arch/mips/net/bpf_jit_comp.c
+++ b/arch/mips/net/bpf_jit_comp.c
@@ -985,7 +985,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 
 	/* Now we know the size of the structure to make */
 	image_size = sizeof(u32) * ctx.jit_index;
-	header = bpf_jit_binary_alloc(image_size, &image_ptr,
+	header = bpf_jit_binary_alloc(prog, image_size, &image_ptr,
 				      sizeof(u32), jit_fill_hole);
 	/*
 	 * Not able to allocate memory for the structure then
diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index e93aefcfb83f..fb7732fe2e7e 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -154,7 +154,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 	proglen = cgctx.idx * 4;
 	alloclen = proglen + FUNCTION_DESCR_SIZE + fixup_len + extable_len;
 
-	bpf_hdr = bpf_jit_binary_alloc(alloclen, &image, 4, bpf_jit_fill_ill_insns);
+	bpf_hdr = bpf_jit_binary_alloc(fp, alloclen, &image, 4, bpf_jit_fill_ill_insns);
 	if (!bpf_hdr) {
 		fp = org_fp;
 		goto out_addrs;
diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_core.c
index 737baf8715da..570567e02dc7 100644
--- a/arch/riscv/net/bpf_jit_core.c
+++ b/arch/riscv/net/bpf_jit_core.c
@@ -109,7 +109,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 			prog_size = sizeof(*ctx->insns) * ctx->ninsns;
 
 			jit_data->header =
-				bpf_jit_binary_alloc(prog_size + extable_size,
+				bpf_jit_binary_alloc(prog,
+						     prog_size + extable_size,
 						     &jit_data->image,
 						     sizeof(u32),
 						     bpf_fill_ill_insns);
diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index f95d7e401b96..11627295e695 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -1878,7 +1878,8 @@ static struct bpf_binary_header *bpf_jit_alloc(struct bpf_jit *jit,
 			    __alignof__(struct exception_table_entry));
 	extable_size = fp->aux->num_exentries *
 		sizeof(struct exception_table_entry);
-	header = bpf_jit_binary_alloc(code_size + extable_size, &jit->prg_buf,
+	header = bpf_jit_binary_alloc(fp,
+				      code_size + extable_size, &jit->prg_buf,
 				      8, jit_fill_hole);
 	if (!header)
 		return NULL;
diff --git a/arch/sparc/net/bpf_jit_comp_64.c b/arch/sparc/net/bpf_jit_comp_64.c
index fa0759bfe498..bff669698e86 100644
--- a/arch/sparc/net/bpf_jit_comp_64.c
+++ b/arch/sparc/net/bpf_jit_comp_64.c
@@ -1567,7 +1567,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 
 	/* Now we know the actual image size. */
 	image_size = sizeof(u32) * ctx.idx;
-	header = bpf_jit_binary_alloc(image_size, &image_ptr,
+	header = bpf_jit_binary_alloc(prog, image_size, &image_ptr,
 				      sizeof(u32), jit_fill_hole);
 	if (header == NULL) {
 		prog = orig_prog;
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 1056bbf55b17..593c9daad167 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2556,7 +2556,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 				sizeof(struct exception_table_entry);
 
 			/* allocate module memory for x86 insns and extable */
-			header = bpf_jit_binary_pack_alloc(roundup(proglen, align) + extable_size,
+			header = bpf_jit_binary_pack_alloc(prog,
+							   roundup(proglen, align) + extable_size,
 							   &image, align, &rw_header, &rw_image,
 							   jit_fill_hole);
 			if (!header) {
diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
index 429a89c5468b..e59ff8935b12 100644
--- a/arch/x86/net/bpf_jit_comp32.c
+++ b/arch/x86/net/bpf_jit_comp32.c
@@ -2586,7 +2586,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 			break;
 		}
 		if (proglen == oldproglen) {
-			header = bpf_jit_binary_alloc(proglen, &image,
+			header = bpf_jit_binary_alloc(prog, proglen, &image,
 						      1, jit_fill_hole);
 			if (!header) {
 				prog = orig_prog;
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a5832a69f24e..785b720358f5 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1277,7 +1277,7 @@ void bpf_image_ksym_add(void *data, struct bpf_ksym *ksym);
 void bpf_image_ksym_del(struct bpf_ksym *ksym);
 void bpf_ksym_add(struct bpf_ksym *ksym);
 void bpf_ksym_del(struct bpf_ksym *ksym);
-int bpf_jit_charge_modmem(u32 size);
+int bpf_jit_charge_modmem(u32 size, const struct bpf_prog *prog);
 void bpf_jit_uncharge_modmem(u32 size);
 bool bpf_prog_has_trampoline(const struct bpf_prog *prog);
 #else
diff --git a/include/linux/filter.h b/include/linux/filter.h
index bbce89937fde..9c207d9848e9 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1026,7 +1026,8 @@ typedef void (*bpf_jit_fill_hole_t)(void *area, unsigned int size);
 void bpf_jit_fill_hole_with_zero(void *area, unsigned int size);
 
 struct bpf_binary_header *
-bpf_jit_binary_alloc(unsigned int proglen, u8 **image_ptr,
+bpf_jit_binary_alloc(const struct bpf_prog *prog,
+		     unsigned int proglen, u8 **image_ptr,
 		     unsigned int alignment,
 		     bpf_jit_fill_hole_t bpf_fill_ill_insns);
 void bpf_jit_binary_free(struct bpf_binary_header *hdr);
@@ -1047,7 +1048,8 @@ static inline bool bpf_prog_kallsyms_verify_off(const struct bpf_prog *fp)
 }
 
 struct bpf_binary_header *
-bpf_jit_binary_pack_alloc(unsigned int proglen, u8 **ro_image,
+bpf_jit_binary_pack_alloc(const struct bpf_prog *prog,
+			  unsigned int proglen, u8 **ro_image,
 			  unsigned int alignment,
 			  struct bpf_binary_header **rw_hdr,
 			  u8 **rw_image,
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 7421487422d4..4d057d39c286 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -978,13 +978,13 @@ static int __init bpf_jit_charge_init(void)
 }
 pure_initcall(bpf_jit_charge_init);
 
-int bpf_jit_charge_modmem(u32 size)
+int bpf_jit_charge_modmem(u32 size, const struct bpf_prog *prog)
 {
 	if (atomic_long_add_return(size, &bpf_jit_current) > READ_ONCE(bpf_jit_limit)) {
-		if (!bpf_capable()) {
-			atomic_long_sub(size, &bpf_jit_current);
-			return -EPERM;
-		}
+		if (prog ? prog->aux->bpf_capable : bpf_capable())
+			return 0;
+		atomic_long_sub(size, &bpf_jit_current);
+		return -EPERM;
 	}
 
 	return 0;
@@ -1006,7 +1006,8 @@ void __weak bpf_jit_free_exec(void *addr)
 }
 
 struct bpf_binary_header *
-bpf_jit_binary_alloc(unsigned int proglen, u8 **image_ptr,
+bpf_jit_binary_alloc(const struct bpf_prog *prog,
+		     unsigned int proglen, u8 **image_ptr,
 		     unsigned int alignment,
 		     bpf_jit_fill_hole_t bpf_fill_ill_insns)
 {
@@ -1022,7 +1023,7 @@ bpf_jit_binary_alloc(unsigned int proglen, u8 **image_ptr,
 	 */
 	size = round_up(proglen + sizeof(*hdr) + 128, PAGE_SIZE);
 
-	if (bpf_jit_charge_modmem(size))
+	if (bpf_jit_charge_modmem(size, prog))
 		return NULL;
 	hdr = bpf_jit_alloc_exec(size);
 	if (!hdr) {
@@ -1061,7 +1062,8 @@ void bpf_jit_binary_free(struct bpf_binary_header *hdr)
  * the JITed program to the RO memory.
  */
 struct bpf_binary_header *
-bpf_jit_binary_pack_alloc(unsigned int proglen, u8 **image_ptr,
+bpf_jit_binary_pack_alloc(const struct bpf_prog *prog,
+			  unsigned int proglen, u8 **image_ptr,
 			  unsigned int alignment,
 			  struct bpf_binary_header **rw_header,
 			  u8 **rw_image,
@@ -1076,7 +1078,7 @@ bpf_jit_binary_pack_alloc(unsigned int proglen, u8 **image_ptr,
 	/* add 16 bytes for a random section of illegal instructions */
 	size = round_up(proglen + sizeof(*ro_header) + 16, BPF_PROG_CHUNK_SIZE);
 
-	if (bpf_jit_charge_modmem(size))
+	if (bpf_jit_charge_modmem(size, prog))
 		return NULL;
 	ro_header = bpf_prog_pack_alloc(size, bpf_fill_ill_insns);
 	if (!ro_header) {
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index ac021bc43a66..b464807f4b62 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -355,7 +355,7 @@ static struct bpf_tramp_image *bpf_tramp_image_alloc(u64 key, u32 idx)
 	if (!im)
 		goto out;
 
-	err = bpf_jit_charge_modmem(PAGE_SIZE);
+	err = bpf_jit_charge_modmem(PAGE_SIZE, NULL);
 	if (err)
 		goto out_free_im;
 
-- 
2.34.1

