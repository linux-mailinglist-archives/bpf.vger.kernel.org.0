Return-Path: <bpf+bounces-43508-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF69B9B5C85
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 08:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A7DFB22BD0
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 07:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4451E3DC9;
	Wed, 30 Oct 2024 07:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UBSRZDFM"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6391E3764;
	Wed, 30 Oct 2024 07:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730272207; cv=none; b=tRXUGZC23ms0IwAd5/dR4O/7C2fdZmrQh+ZTg+S1Le0cWJNoG2kiN5/ZV0NJDzXTktL2J40qutGVjWfbGp60znV4EbI8zjFCzQbqRHtmBpIFmvvZYgG9QHngkip+saHICSN8LcT4tkVIcB1xqB9fCgsFs5oRpdrGRHRtddDAkk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730272207; c=relaxed/simple;
	bh=J8nudRCXZPwGlnOVem+kl+d9Kaots6W/qKAvzBM9Hi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iwbs8gUKo3pqyaMKKbWGS1PxwENaH/IAmpLwF8NL847sVGDOvgI3RfiSmV8hpCH6S74uKGBZJWq34uB6VMW3sWSKK9TZ1IsCGFxz//oPg9BlwoADIX9PPLesc1CL9qD4uIYvBXNIMpDsKbboRe+Twg55IvTYcS6FMPc1JYQmAzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UBSRZDFM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49U2d4EV030085;
	Wed, 30 Oct 2024 07:09:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=0sjux67/cGH3S6nXu
	eXFhTGrggywG6rcpcrWORYy/FM=; b=UBSRZDFMY0/ldb96rtF9AwC4cIXGnvuri
	0Uie472Xox0N/t4MPNZmgYqUR1BrDRLTtDcmLiuIeV1yqIrPNEWKThY6dxxnIeUV
	SYpAXJMg8wYxds+9+9HB0mdZEs5qDOd0Qk5/6Sy0zZ2HYUf5vHd4B43yZHa9H5W6
	qjdzTt4VFiKBat4Zx/nbe5QGWtE9//DCKtKJw7dFAeYMPOrLW7FcIuKo6Y7d5Jof
	bP+tvAWtoN8dt4QE/bLZ4yc/dF8tonzetxHtGdbYM83HEMS7zrzq0xMj2UvhcB93
	I7rgthoBT6PpJpGW6cIJSlRXrnILEkD/BDZLMmp4pjRyl1q/dKOCQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42js0h7436-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 07:09:37 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49U79aAK032041;
	Wed, 30 Oct 2024 07:09:36 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42js0h7431-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 07:09:36 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49U4axYL024535;
	Wed, 30 Oct 2024 07:09:35 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42hcyjemuu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 07:09:35 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49U79Wxl17105242
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Oct 2024 07:09:32 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 126BA2004B;
	Wed, 30 Oct 2024 07:09:32 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5EF4420043;
	Wed, 30 Oct 2024 07:09:28 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.in.ibm.com (unknown [9.203.115.143])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 30 Oct 2024 07:09:28 +0000 (GMT)
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
Subject: [PATCH v7 09/17] powerpc64/bpf: Fold bpf_jit_emit_func_call_hlp() into bpf_jit_emit_func_call_rel()
Date: Wed, 30 Oct 2024 12:38:42 +0530
Message-ID: <20241030070850.1361304-10-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241030070850.1361304-1-hbathini@linux.ibm.com>
References: <20241030070850.1361304-1-hbathini@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kL7Bc55RKnHWQN-uIBNt7CFP8HtAMQUm
X-Proofpoint-ORIG-GUID: D-NzvgIGcV6WN5WHZixraW9KyuFxu6g9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 adultscore=0 clxscore=1015 mlxlogscore=999
 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410300051

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


