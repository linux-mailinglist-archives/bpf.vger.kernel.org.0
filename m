Return-Path: <bpf+bounces-28467-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 597018B9F93
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 19:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CDC31C225F6
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 17:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146E8171084;
	Thu,  2 May 2024 17:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QnbdsD77"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BCD16FF3D
	for <bpf@vger.kernel.org>; Thu,  2 May 2024 17:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714671176; cv=none; b=V28mxD/TPvW577lAbnTcfQqJHHAE0t/z2egDYtyGhLn/K6/24nrZmxvi9lhb9n9ywyefP0fFbQ9fW6MSLCl9FHC0PmGbcGmWeRKGeMM/WBSkC146lWRZXh4J9Qn4KR7acfMcoBKzm3O9KeCRrmKwIDqMlQl7pGbGTgTT0orVFXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714671176; c=relaxed/simple;
	bh=XgD+Sf8cLkgPqmhjLFzmFUy5GLdpIxAoCz/VpaIdB4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=miefBUwlMcP1qQUURUdD7HCVcBQtlvd+BDuESotMDddOXDE5kKxYuGpLPJ9Ft7xkYzHHcijkIs3/dPpX+ydkF1+SVjUoTmV8AOyBoWzYb2I/hOS6R+EcF8xIydufMzxgsPT4wRMAG9K3nnRqRB3psLQaFBYAtzddZ+jFb+SEL6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QnbdsD77; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 442HMENs027178;
	Thu, 2 May 2024 17:32:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=+Qa/A8KDIGgpzN5dZLg28DJ8RPhkFjvXY7+TLOjBanI=;
 b=QnbdsD77FXQclKyS7yTVRJ4UzjuVQChkZbn7E9GvsI/gQovZEV4sYUDjULAaUAhCQtr6
 0p3TS9UY66knaBF2zsoWRthBeWJLnMKz9Atxb64NENTfpTGgqWcZhf6ng6cWrGw6UWeP
 BKZReSwDXkLey1jFB247+Ce+jMVfDyspFDmWK6VV1jOKYJdzxPbIkZix44z/AKW6/O8f
 CSwtKvwYnKQbO3SvY7mdrNYZSgIDM/6qICrRUs87hEW5X5Xsuh/X9ZERXu1H8hMeMX/w
 NxI1tjmCQXHw4ldiYWFCoSrjdKzxkBnSvR/wBuUbH0sRV0MaSs5ID6VXx/L/pCQx9Ohf ag== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xvf5r00tt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 May 2024 17:32:18 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 442FZlqO003613;
	Thu, 2 May 2024 17:32:17 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xscpps6jd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 May 2024 17:32:17 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 442HWD9u37093724
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 May 2024 17:32:15 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3AF022004F;
	Thu,  2 May 2024 17:32:13 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A93F2004B;
	Thu,  2 May 2024 17:32:10 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.ibm.com.com (unknown [9.43.113.195])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 May 2024 17:32:09 +0000 (GMT)
From: Hari Bathini <hbathini@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, bpf@vger.kernel.org
Cc: Song Liu <songliubraving@fb.com>, Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Martin KaFai Lau <martin.lau@linux.dev>
Subject: [PATCH v4 2/2] powerpc/bpf: enable kfunc call
Date: Thu,  2 May 2024 23:02:05 +0530
Message-ID: <20240502173205.142794-2-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240502173205.142794-1-hbathini@linux.ibm.com>
References: <20240502173205.142794-1-hbathini@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Agu0v6p1xyuZw_1Xp9VVo3N1RZK4b-SM
X-Proofpoint-ORIG-GUID: Agu0v6p1xyuZw_1Xp9VVo3N1RZK4b-SM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-02_09,2024-05-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 impostorscore=0 clxscore=1015 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405020115

Currently, bpf jit code on powerpc assumes all the bpf functions and
helpers to be part of core kernel text. This is false for kfunc case,
as function addresses may not be part of core kernel text area. So,
add support for addresses that are not within core kernel text area
too, to enable kfunc support. Emit instructions based on whether the
function address is within core kernel text address or not, to retain
optimized instruction sequence where possible.

In case of PCREL, as a bpf function that is not within core kernel
text area is likely to go out of range with relative addressing on
kernel base, use PC relative addressing. If that goes out of range,
load the full address with PPC_LI64().

With addresses that are not within core kernel text area supported,
override bpf_jit_supports_kfunc_call() to enable kfunc support. Also,
override bpf_jit_supports_far_kfunc_call() to enable 64-bit pointers,
as an address offset can be more than 32-bit long on PPC64.

Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
---

* Changes in v4:
  - Use either kernelbase or PC for relative addressing. Also, fallback
    to PPC_LI64(), if both are out of range.
  - Update r2 with kernel TOC for elfv1 too as elfv1 also uses the
    optimization sequence, that expects r2 to be kernel TOC, when
    function address is within core kernel text.

* Changes in v3:
  - Retained optimized instruction sequence when function address is
    a core kernel address as suggested by Naveen.
  - Used unoptimized instruction sequence for PCREL addressing to
    avoid out of range errors for core kernel function addresses.
  - Folded patch that adds support for kfunc calls with patch that
    enables/advertises this support as suggested by Naveen.


 arch/powerpc/net/bpf_jit_comp.c   | 10 +++++
 arch/powerpc/net/bpf_jit_comp64.c | 61 ++++++++++++++++++++++++++-----
 2 files changed, 61 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index 0f9a21783329..984655419da5 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -359,3 +359,13 @@ void bpf_jit_free(struct bpf_prog *fp)
 
 	bpf_prog_unlock_free(fp);
 }
+
+bool bpf_jit_supports_kfunc_call(void)
+{
+	return true;
+}
+
+bool bpf_jit_supports_far_kfunc_call(void)
+{
+	return IS_ENABLED(CONFIG_PPC64);
+}
diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index 4de08e35e284..8afc14a4a125 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -208,17 +208,13 @@ bpf_jit_emit_func_call_hlp(u32 *image, u32 *fimage, struct codegen_context *ctx,
 	unsigned long func_addr = func ? ppc_function_entry((void *)func) : 0;
 	long reladdr;
 
-	if (WARN_ON_ONCE(!core_kernel_text(func_addr)))
+	if (WARN_ON_ONCE(!kernel_text_address(func_addr)))
 		return -EINVAL;
 
-	if (IS_ENABLED(CONFIG_PPC_KERNEL_PCREL)) {
-		reladdr = func_addr - local_paca->kernelbase;
+#ifdef CONFIG_PPC_KERNEL_PCREL
+	reladdr = func_addr - local_paca->kernelbase;
 
-		if (reladdr >= (long)SZ_8G || reladdr < -(long)SZ_8G) {
-			pr_err("eBPF: address of %ps out of range of 34-bit relative address.\n",
-			       (void *)func);
-			return -ERANGE;
-		}
+	if (reladdr < (long)SZ_8G && reladdr >= -(long)SZ_8G) {
 		EMIT(PPC_RAW_LD(_R12, _R13, offsetof(struct paca_struct, kernelbase)));
 		/* Align for subsequent prefix instruction */
 		if (!IS_ALIGNED((unsigned long)fimage + CTX_NIA(ctx), 8))
@@ -227,6 +223,26 @@ bpf_jit_emit_func_call_hlp(u32 *image, u32 *fimage, struct codegen_context *ctx,
 		EMIT(PPC_PREFIX_MLS | __PPC_PRFX_R(0) | IMM_H18(reladdr));
 		EMIT(PPC_INST_PADDI | ___PPC_RT(_R12) | ___PPC_RA(_R12) | IMM_L(reladdr));
 	} else {
+		unsigned long pc = (unsigned long)fimage + CTX_NIA(ctx);
+		bool alignment_needed = !IS_ALIGNED(pc, 8);
+
+		reladdr = func_addr - (alignment_needed ? pc + 4 :  pc);
+
+		if (reladdr < (long)SZ_8G && reladdr >= -(long)SZ_8G) {
+			if (alignment_needed)
+				EMIT(PPC_RAW_NOP());
+			/* pla r12,addr */
+			EMIT(PPC_PREFIX_MLS | __PPC_PRFX_R(1) | IMM_H18(reladdr));
+			EMIT(PPC_INST_PADDI | ___PPC_RT(_R12) | IMM_L(reladdr));
+		} else {
+			/* We can clobber r12 */
+			PPC_LI64(_R12, func);
+		}
+	}
+	EMIT(PPC_RAW_MTCTR(_R12));
+	EMIT(PPC_RAW_BCTRL());
+#else
+	if (core_kernel_text(func_addr)) {
 		reladdr = func_addr - kernel_toc_addr();
 		if (reladdr > 0x7FFFFFFF || reladdr < -(0x80000000L)) {
 			pr_err("eBPF: address of %ps out of range of kernel_toc.\n", (void *)func);
@@ -235,9 +251,34 @@ bpf_jit_emit_func_call_hlp(u32 *image, u32 *fimage, struct codegen_context *ctx,
 
 		EMIT(PPC_RAW_ADDIS(_R12, _R2, PPC_HA(reladdr)));
 		EMIT(PPC_RAW_ADDI(_R12, _R12, PPC_LO(reladdr)));
+		EMIT(PPC_RAW_MTCTR(_R12));
+		EMIT(PPC_RAW_BCTRL());
+	} else {
+		if (IS_ENABLED(CONFIG_PPC64_ELF_ABI_V1)) {
+			/* func points to the function descriptor */
+			PPC_LI64(bpf_to_ppc(TMP_REG_2), func);
+			/* Load actual entry point from function descriptor */
+			EMIT(PPC_RAW_LD(bpf_to_ppc(TMP_REG_1), bpf_to_ppc(TMP_REG_2), 0));
+			/* ... and move it to CTR */
+			EMIT(PPC_RAW_MTCTR(bpf_to_ppc(TMP_REG_1)));
+			/*
+			 * Load TOC from function descriptor at offset 8.
+			 * We can clobber r2 since we get called through a
+			 * function pointer (so caller will save/restore r2).
+			 */
+			EMIT(PPC_RAW_LD(_R2, bpf_to_ppc(TMP_REG_2), 8));
+		} else {
+			PPC_LI64(_R12, func);
+			EMIT(PPC_RAW_MTCTR(_R12));
+		}
+		EMIT(PPC_RAW_BCTRL());
+		/*
+		 * Load r2 with kernel TOC as kernel TOC is used if function address falls
+		 * within core kernel text.
+		 */
+		EMIT(PPC_RAW_LD(_R2, _R13, offsetof(struct paca_struct, kernel_toc)));
 	}
-	EMIT(PPC_RAW_MTCTR(_R12));
-	EMIT(PPC_RAW_BCTRL());
+#endif
 
 	return 0;
 }
-- 
2.44.0


