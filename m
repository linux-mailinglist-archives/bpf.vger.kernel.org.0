Return-Path: <bpf+bounces-56379-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB02FA96219
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 10:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D89EF17AB6C
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 08:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD48B290BAC;
	Tue, 22 Apr 2025 08:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XNSNdpCm"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5177E28F92E;
	Tue, 22 Apr 2025 08:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745310408; cv=none; b=T23MZ6LgYKnz9r/7dqvN18Q+h5RLP57av/JXTCr+EC0lnGz7ONQYByWTi+g3TwdDUz/zu+npPioWsqSo0KEDEHuzgY/y7+oifiMP66LdCTzPxkU685upfyFJi81lPFB9xjbX2QasvJ1kID458eyk/qDgFeVX7LZIX8NIf6FYPgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745310408; c=relaxed/simple;
	bh=VMTXopvMt04K3em0o8QhLt1IlwKuMaviyMmMJI8fX38=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cCgZp/OfBkljeojWdg1vBGXv331Hp8xytplcJFe7fOnihI6d5vLzXQLry+BZthwfAY8hJWX9B5ZNWRfM3mv3iJLH4Pox0SaAYXIMOapi1d99i00bIpfYiRMwYiF/QXAWjljfohLWddCFnmhCZWrL1cAfmPbbR/yfLsEP9B9aBm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XNSNdpCm; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53M6bPuc012277;
	Tue, 22 Apr 2025 08:26:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=SQrqqKR7VA/qlP9yuXRKMxrzXQrlCZ/mnMefgR933
	BQ=; b=XNSNdpCm1ikfkBPtW5XwFgw7sMEjXHtzcUo2o+zs4zIRIhvC1+YxOTjSQ
	L3KapxnFi/b2MyLCcT8efVJOLsSV8dOgcswVwQWkKXfudZNUaCw0lBJpC8RJdn9l
	wBBu4DpwYy9XXe+wLs+eaJbzi1Tjw95p1XaSCG/hJU/qw4q2eeCIjbX/LhlYiFIA
	dwbs7OewILq8Fk6mo4hux1ci6im8+bwbbGugTJ55H34pF46ZJWPuIa3rWMuA/k0h
	6vrRzr3L797wgn+qUMpdne+0rVn0gJj+j4BYW0oWiEIuVl6qWVhjRhPxKocrflM9
	2kXCAQPkZecSt8GF6DfYS1rWIWQlQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46660fgex8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 08:26:17 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53M8LAum010061;
	Tue, 22 Apr 2025 08:26:17 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46660fgex5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 08:26:17 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53M8C1MT001858;
	Tue, 22 Apr 2025 08:26:16 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 464rck1rjy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 08:26:16 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53M8QCPd34865912
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 08:26:12 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C02F320043;
	Tue, 22 Apr 2025 08:26:12 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 472242004B;
	Tue, 22 Apr 2025 08:26:10 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.in.ibm.com (unknown [9.109.222.82])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 22 Apr 2025 08:26:10 +0000 (GMT)
From: Hari Bathini <hbathini@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, bpf@vger.kernel.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        "Naveen N. Rao" <naveen@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, stable@vger.kernel.org
Subject: [PATCH v3] powerpc/bpf: fix JIT code size calculation of bpf trampoline
Date: Tue, 22 Apr 2025 13:56:09 +0530
Message-ID: <20250422082609.949301-1-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NdZsWW6kC9lkoS6BCIFTHPEgBZaNs9IR
X-Authority-Analysis: v=2.4 cv=YdC95xRf c=1 sm=1 tr=0 ts=680752a9 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=2fGx8izRS4zgbLbr9iIA:9
X-Proofpoint-ORIG-GUID: J92uvSD2EgmyFHg2R5jQwwTzFFcgx9LC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_04,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 mlxlogscore=820 impostorscore=0 spamscore=0 mlxscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504220060

arch_bpf_trampoline_size() provides JIT size of the BPF trampoline
before the buffer for JIT'ing it is allocated. The total number of
instructions emitted for BPF trampoline JIT code depends on where
the final image is located. So, the size arrived at with the dummy
pass in arch_bpf_trampoline_size() can vary from the actual size
needed in  arch_prepare_bpf_trampoline().  When the instructions
accounted in  arch_bpf_trampoline_size() is less than the number of
instructions emitted during the actual JIT compile of the trampoline,
the below warning is produced:

  WARNING: CPU: 8 PID: 204190 at arch/powerpc/net/bpf_jit_comp.c:981 __arch_prepare_bpf_trampoline.isra.0+0xd2c/0xdcc

which is:

  /* Make sure the trampoline generation logic doesn't overflow */
  if (image && WARN_ON_ONCE(&image[ctx->idx] >
  			(u32 *)rw_image_end - BPF_INSN_SAFETY)) {

So, during the dummy pass, instead of providing some arbitrary image
location, account for maximum possible instructions if and when there
is a dependency with image location for JIT'ing.

Fixes: d243b62b7bd3 ("powerpc64/bpf: Add support for bpf trampolines")
Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Closes: https://lore.kernel.org/all/6168bfc8-659f-4b5a-a6fb-90a916dde3b3@linux.ibm.com/
Cc: stable@vger.kernel.org # v6.13+
Acked-by: Naveen N Rao (AMD) <naveen@kernel.org>
Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
---

Changes since v2:
- Address review comments from Naveen:
  - Remove additional padding for 'case BPF_LD | BPF_IMM | BPF_DW:'
    in arch/powerpc/net/bpf_jit_comp*.c
  - Merge the if sequence in bpf_jit_emit_func_call_rel() with the
    other conditionals
  - Naveen, carried your Acked-by tag as the additional changes are
    minimal and in line with your suggestion. Feel free to update
    if you look at it differently.
  - Venkat, carried your Tested-by tag from v2 as the changes in
    v3 should not alter the test result. Feel free to update if
    you look at it differently.

Changes since v1:
- Pass NULL for image during intial pass and account for max. possible
  instruction during this pass as Naveen suggested.


 arch/powerpc/net/bpf_jit.h        | 20 ++++++++++++++++---
 arch/powerpc/net/bpf_jit_comp.c   | 33 ++++++++++---------------------
 arch/powerpc/net/bpf_jit_comp32.c |  6 ------
 arch/powerpc/net/bpf_jit_comp64.c | 15 +++++++-------
 4 files changed, 35 insertions(+), 39 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
index 6beacaec63d3..4c26912c2e3c 100644
--- a/arch/powerpc/net/bpf_jit.h
+++ b/arch/powerpc/net/bpf_jit.h
@@ -51,8 +51,16 @@
 		EMIT(PPC_INST_BRANCH_COND | (((cond) & 0x3ff) << 16) | (offset & 0xfffc));					\
 	} while (0)
 
-/* Sign-extended 32-bit immediate load */
+/*
+ * Sign-extended 32-bit immediate load
+ *
+ * If this is a dummy pass (!image), account for
+ * maximum possible instructions.
+ */
 #define PPC_LI32(d, i)		do {					      \
+	if (!image)							      \
+		ctx->idx += 2;						      \
+	else {								      \
 		if ((int)(uintptr_t)(i) >= -32768 &&			      \
 				(int)(uintptr_t)(i) < 32768)		      \
 			EMIT(PPC_RAW_LI(d, i));				      \
@@ -60,10 +68,15 @@
 			EMIT(PPC_RAW_LIS(d, IMM_H(i)));			      \
 			if (IMM_L(i))					      \
 				EMIT(PPC_RAW_ORI(d, d, IMM_L(i)));	      \
-		} } while(0)
+		}							      \
+	} } while (0)
 
 #ifdef CONFIG_PPC64
+/* If dummy pass (!image), account for maximum possible instructions */
 #define PPC_LI64(d, i)		do {					      \
+	if (!image)							      \
+		ctx->idx += 5;						      \
+	else {								      \
 		if ((long)(i) >= -2147483648 &&				      \
 				(long)(i) < 2147483648)			      \
 			PPC_LI32(d, i);					      \
@@ -84,7 +97,8 @@
 			if ((uintptr_t)(i) & 0x000000000000ffffULL)	      \
 				EMIT(PPC_RAW_ORI(d, d, (uintptr_t)(i) &       \
 							0xffff));             \
-		} } while (0)
+		}							      \
+	} } while (0)
 #define PPC_LI_ADDR	PPC_LI64
 
 #ifndef CONFIG_PPC_KERNEL_PCREL
diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index 2991bb171a9b..c0684733e9d6 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -504,10 +504,11 @@ static int invoke_bpf_prog(u32 *image, u32 *ro_image, struct codegen_context *ct
 	EMIT(PPC_RAW_ADDI(_R3, _R1, regs_off));
 	if (!p->jited)
 		PPC_LI_ADDR(_R4, (unsigned long)p->insnsi);
-	if (!create_branch(&branch_insn, (u32 *)&ro_image[ctx->idx], (unsigned long)p->bpf_func,
-			   BRANCH_SET_LINK)) {
-		if (image)
-			image[ctx->idx] = ppc_inst_val(branch_insn);
+	/* Account for max possible instructions during dummy pass for size calculation */
+	if (image && !create_branch(&branch_insn, (u32 *)&ro_image[ctx->idx],
+				    (unsigned long)p->bpf_func,
+				    BRANCH_SET_LINK)) {
+		image[ctx->idx] = ppc_inst_val(branch_insn);
 		ctx->idx++;
 	} else {
 		EMIT(PPC_RAW_LL(_R12, _R25, offsetof(struct bpf_prog, bpf_func)));
@@ -889,7 +890,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 			bpf_trampoline_restore_tail_call_cnt(image, ctx, func_frame_offset, r4_off);
 
 		/* Reserve space to patch branch instruction to skip fexit progs */
-		im->ip_after_call = &((u32 *)ro_image)[ctx->idx];
+		if (ro_image) /* image is NULL for dummy pass */
+			im->ip_after_call = &((u32 *)ro_image)[ctx->idx];
 		EMIT(PPC_RAW_NOP());
 	}
 
@@ -912,7 +914,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 		}
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
-		im->ip_epilogue = &((u32 *)ro_image)[ctx->idx];
+		if (ro_image) /* image is NULL for dummy pass */
+			im->ip_epilogue = &((u32 *)ro_image)[ctx->idx];
 		PPC_LI_ADDR(_R3, im);
 		ret = bpf_jit_emit_func_call_rel(image, ro_image, ctx,
 						 (unsigned long)__bpf_tramp_exit);
@@ -973,25 +976,9 @@ int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
 			     struct bpf_tramp_links *tlinks, void *func_addr)
 {
 	struct bpf_tramp_image im;
-	void *image;
 	int ret;
 
-	/*
-	 * Allocate a temporary buffer for __arch_prepare_bpf_trampoline().
-	 * This will NOT cause fragmentation in direct map, as we do not
-	 * call set_memory_*() on this buffer.
-	 *
-	 * We cannot use kvmalloc here, because we need image to be in
-	 * module memory range.
-	 */
-	image = bpf_jit_alloc_exec(PAGE_SIZE);
-	if (!image)
-		return -ENOMEM;
-
-	ret = __arch_prepare_bpf_trampoline(&im, image, image + PAGE_SIZE, image,
-					    m, flags, tlinks, func_addr);
-	bpf_jit_free_exec(image);
-
+	ret = __arch_prepare_bpf_trampoline(&im, NULL, NULL, NULL, m, flags, tlinks, func_addr);
 	return ret;
 }
 
diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
index c4db278dae36..0aace304dfe1 100644
--- a/arch/powerpc/net/bpf_jit_comp32.c
+++ b/arch/powerpc/net/bpf_jit_comp32.c
@@ -313,7 +313,6 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 		u64 func_addr;
 		u32 true_cond;
 		u32 tmp_idx;
-		int j;
 
 		if (i && (BPF_CLASS(code) == BPF_ALU64 || BPF_CLASS(code) == BPF_ALU) &&
 		    (BPF_CLASS(prevcode) == BPF_ALU64 || BPF_CLASS(prevcode) == BPF_ALU) &&
@@ -1099,13 +1098,8 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 		 * 16 byte instruction that uses two 'struct bpf_insn'
 		 */
 		case BPF_LD | BPF_IMM | BPF_DW: /* dst = (u64) imm */
-			tmp_idx = ctx->idx;
 			PPC_LI32(dst_reg_h, (u32)insn[i + 1].imm);
 			PPC_LI32(dst_reg, (u32)insn[i].imm);
-			/* padding to allow full 4 instructions for later patching */
-			if (!image)
-				for (j = ctx->idx - tmp_idx; j < 4; j++)
-					EMIT(PPC_RAW_NOP());
 			/* Adjust for two bpf instructions */
 			addrs[++i] = ctx->idx * 4;
 			break;
diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index 233703b06d7c..5daa77aee7f7 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -227,7 +227,14 @@ int bpf_jit_emit_func_call_rel(u32 *image, u32 *fimage, struct codegen_context *
 #ifdef CONFIG_PPC_KERNEL_PCREL
 	reladdr = func_addr - local_paca->kernelbase;
 
-	if (reladdr < (long)SZ_8G && reladdr >= -(long)SZ_8G) {
+	/*
+	 * If fimage is NULL (the initial pass to find image size),
+	 * account for the maximum no. of instructions possible.
+	 */
+	if (!fimage) {
+		ctx->idx += 7;
+		return 0;
+	} else if (reladdr < (long)SZ_8G && reladdr >= -(long)SZ_8G) {
 		EMIT(PPC_RAW_LD(_R12, _R13, offsetof(struct paca_struct, kernelbase)));
 		/* Align for subsequent prefix instruction */
 		if (!IS_ALIGNED((unsigned long)fimage + CTX_NIA(ctx), 8))
@@ -412,7 +419,6 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 		u64 imm64;
 		u32 true_cond;
 		u32 tmp_idx;
-		int j;
 
 		/*
 		 * addrs[] maps a BPF bytecode address into a real offset from
@@ -1046,12 +1052,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 		case BPF_LD | BPF_IMM | BPF_DW: /* dst = (u64) imm */
 			imm64 = ((u64)(u32) insn[i].imm) |
 				    (((u64)(u32) insn[i+1].imm) << 32);
-			tmp_idx = ctx->idx;
 			PPC_LI64(dst_reg, imm64);
-			/* padding to allow full 5 instructions for later patching */
-			if (!image)
-				for (j = ctx->idx - tmp_idx; j < 5; j++)
-					EMIT(PPC_RAW_NOP());
 			/* Adjust for two bpf instructions */
 			addrs[++i] = ctx->idx * 4;
 			break;
-- 
2.49.0


