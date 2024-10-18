Return-Path: <bpf+bounces-42448-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 115E19A4501
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 19:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26C9F1C21C7A
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 17:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A656207212;
	Fri, 18 Oct 2024 17:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YV2dcwuo"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D8B205E33;
	Fri, 18 Oct 2024 17:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729273069; cv=none; b=noUWtPS9cKQKEjt+64q0r+nsHrfWw2c5GJd7I1qJcZpDpAsR1Ei9pzqSbv1odtThZCTM+jfdg9ps3rMr5YVAMePRGJQ4eRYF2A0OWp9XTmirP0/mbzqlvML2fq5WeagYslBqqGW//XDfE1skqan7EhrPvhdV3rOZI2eaDVNs/kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729273069; c=relaxed/simple;
	bh=J8nudRCXZPwGlnOVem+kl+d9Kaots6W/qKAvzBM9Hi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=odIlskC+sJmDBVigfJOBzPWUW6zLg5IWke0+4qcEYCFtifi3qzYfuwz70QGlYjtZa8STKkrEw1Gu4DbdqkqXhyUfJdf3LfDB7u7GlnDBHJEY6i33YZhWkF5jXcfm7aGulxkjtK7BizcvhwcAiZLBSacIUUavKxnr+G0ei58Odk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YV2dcwuo; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49IA9bOl014392;
	Fri, 18 Oct 2024 17:37:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=0sjux67/cGH3S6nXu
	eXFhTGrggywG6rcpcrWORYy/FM=; b=YV2dcwuoyGB2DT52p/xsR5chrz6qrfQs7
	E2yvRxlS62TkysrbGvixLUVYvbC46EoF1ZgmO/3okr8W6AyjPVLlh28PJ+DeC4wB
	rcSBgb+v/On5+nD7p7X1hLCZLUgAgofDsfZatJntCa+Zv2CbpI/wb+iDqoYxxR6X
	E30fzVkAfk43B5staOgr+G3SwUCGBu/1vGbzSZsBobLGxAWLlTEYmNEPul57owdn
	E83ed+VeH3Ut63uQPZiViXQPGg1RSQUe469agIVeI/8vCLLQuKN52D86rKCz3z30
	WILGM6Y9FctExNPIFdhHpqf4CJMGESJUKiaJjZg9mFxVRIiY2cBZA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42aqgrack0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 17:37:23 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49IHbMOg011732;
	Fri, 18 Oct 2024 17:37:22 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42aqgracjv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 17:37:22 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49IFO4Xo005381;
	Fri, 18 Oct 2024 17:37:21 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4285njnpkv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 17:37:21 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49IHbIbU33423806
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 17:37:18 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ECCB22004B;
	Fri, 18 Oct 2024 17:37:17 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED5A420040;
	Fri, 18 Oct 2024 17:37:13 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.ibm.com.com (unknown [9.43.99.188])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Oct 2024 17:37:13 +0000 (GMT)
From: Hari Bathini <hbathini@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, bpf@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>, "Naveen N. Rao" <naveen@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Vishal Chourasia <vishalc@linux.ibm.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Subject: [PATCH v6 09/17] powerpc64/bpf: Fold bpf_jit_emit_func_call_hlp() into bpf_jit_emit_func_call_rel()
Date: Fri, 18 Oct 2024 23:06:24 +0530
Message-ID: <20241018173632.277333-10-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241018173632.277333-1-hbathini@linux.ibm.com>
References: <20241018173632.277333-1-hbathini@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pNk0nrymyuQU1u-bv7mWJIhUVBul9BAE
X-Proofpoint-GUID: Vj80RSIAhFVJfCPNwPcdlE7XvJuUsgUA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 spamscore=0 mlxscore=0 suspectscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410180111

From: Naveen N Rao <naveen@kernel.org>

Commit 61688a82e047 ("powerpc/bpf: enable kfunc call") enhanced
bpf_jit_emit_func_call_hlp() to handle calls out to module region, where
bpf progs are generated. The only difference now between
bpf_jit_emit_func_call_hlp() and bpf_jit_emit_func_call_rel() is in
handling of the initial pass where target function address is not known.
Fold that logic into bpf_jit_emit_func_call_hlp() and rename it to
bpf_jit_emit_func_call_rel() to simplify bpf function call JIT code.

We don't actually need to load/restore TOC across a call out to a
different kernel helper or to a different bpf program since they all
work with the kernel TOC. We only need to do it if we have to call out
to a module function. So, guard TOC load/restore with appropriate
conditions.

Signed-off-by: Naveen N Rao <naveen@kernel.org>
---
 arch/powerpc/net/bpf_jit_comp64.c | 61 +++++++++----------------------
 1 file changed, 17 insertions(+), 44 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index 2cbcdf93cc19..f3be024fc685 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -202,14 +202,22 @@ void bpf_jit_build_epilogue(u32 *image, struct codegen_context *ctx)
 	EMIT(PPC_RAW_BLR());
 }
 
-static int
-bpf_jit_emit_func_call_hlp(u32 *image, u32 *fimage, struct codegen_context *ctx, u64 func)
+int bpf_jit_emit_func_call_rel(u32 *image, u32 *fimage, struct codegen_context *ctx, u64 func)
 {
 	unsigned long func_addr = func ? ppc_function_entry((void *)func) : 0;
 	long reladdr;
 
-	if (WARN_ON_ONCE(!kernel_text_address(func_addr)))
-		return -EINVAL;
+	/* bpf to bpf call, func is not known in the initial pass. Emit 5 nops as a placeholder */
+	if (!func) {
+		for (int i = 0; i < 5; i++)
+			EMIT(PPC_RAW_NOP());
+		/* elfv1 needs an additional instruction to load addr from descriptor */
+		if (IS_ENABLED(CONFIG_PPC64_ELF_ABI_V1))
+			EMIT(PPC_RAW_NOP());
+		EMIT(PPC_RAW_MTCTR(_R12));
+		EMIT(PPC_RAW_BCTRL());
+		return 0;
+	}
 
 #ifdef CONFIG_PPC_KERNEL_PCREL
 	reladdr = func_addr - local_paca->kernelbase;
@@ -266,7 +274,8 @@ bpf_jit_emit_func_call_hlp(u32 *image, u32 *fimage, struct codegen_context *ctx,
 			 * We can clobber r2 since we get called through a
 			 * function pointer (so caller will save/restore r2).
 			 */
-			EMIT(PPC_RAW_LD(_R2, bpf_to_ppc(TMP_REG_2), 8));
+			if (is_module_text_address(func_addr))
+				EMIT(PPC_RAW_LD(_R2, bpf_to_ppc(TMP_REG_2), 8));
 		} else {
 			PPC_LI64(_R12, func);
 			EMIT(PPC_RAW_MTCTR(_R12));
@@ -276,46 +285,14 @@ bpf_jit_emit_func_call_hlp(u32 *image, u32 *fimage, struct codegen_context *ctx,
 		 * Load r2 with kernel TOC as kernel TOC is used if function address falls
 		 * within core kernel text.
 		 */
-		EMIT(PPC_RAW_LD(_R2, _R13, offsetof(struct paca_struct, kernel_toc)));
+		if (is_module_text_address(func_addr))
+			EMIT(PPC_RAW_LD(_R2, _R13, offsetof(struct paca_struct, kernel_toc)));
 	}
 #endif
 
 	return 0;
 }
 
-int bpf_jit_emit_func_call_rel(u32 *image, u32 *fimage, struct codegen_context *ctx, u64 func)
-{
-	unsigned int i, ctx_idx = ctx->idx;
-
-	if (WARN_ON_ONCE(func && is_module_text_address(func)))
-		return -EINVAL;
-
-	/* skip past descriptor if elf v1 */
-	func += FUNCTION_DESCR_SIZE;
-
-	/* Load function address into r12 */
-	PPC_LI64(_R12, func);
-
-	/* For bpf-to-bpf function calls, the callee's address is unknown
-	 * until the last extra pass. As seen above, we use PPC_LI64() to
-	 * load the callee's address, but this may optimize the number of
-	 * instructions required based on the nature of the address.
-	 *
-	 * Since we don't want the number of instructions emitted to increase,
-	 * we pad the optimized PPC_LI64() call with NOPs to guarantee that
-	 * we always have a five-instruction sequence, which is the maximum
-	 * that PPC_LI64() can emit.
-	 */
-	if (!image)
-		for (i = ctx->idx - ctx_idx; i < 5; i++)
-			EMIT(PPC_RAW_NOP());
-
-	EMIT(PPC_RAW_MTCTR(_R12));
-	EMIT(PPC_RAW_BCTRL());
-
-	return 0;
-}
-
 static int bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 out)
 {
 	/*
@@ -1102,11 +1079,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 			if (ret < 0)
 				return ret;
 
-			if (func_addr_fixed)
-				ret = bpf_jit_emit_func_call_hlp(image, fimage, ctx, func_addr);
-			else
-				ret = bpf_jit_emit_func_call_rel(image, fimage, ctx, func_addr);
-
+			ret = bpf_jit_emit_func_call_rel(image, fimage, ctx, func_addr);
 			if (ret)
 				return ret;
 
-- 
2.47.0


