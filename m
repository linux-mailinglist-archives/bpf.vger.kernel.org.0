Return-Path: <bpf+bounces-28466-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E82D98B9F92
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 19:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76B8A1F2416C
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 17:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C019617107A;
	Thu,  2 May 2024 17:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GBt2AHgZ"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B7728FC;
	Thu,  2 May 2024 17:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714671176; cv=none; b=KZpgOINhvIQ5cq0LtE3yjQ3FluysqfcGZtK/blqlbPfPZbf5ksDLMftbSLwNjipjPvmZtP53+ujP8z1CdhNylWkL5vBTqv5XWCMpsbyKQdJBpxS61RR14TYFvnIDc75nBnYAwvoW00phk6aVldG3ppAbcxzLpAxBPYtA2nz7K00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714671176; c=relaxed/simple;
	bh=LaCvykQvdmUOuzSwHmR3Avj+B1lxgk4vwyJwgGxaceo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rLUF6hQlX/iKdjM+PKXdV3+t566PWuEsVz1JKBPX4XJGpVQilnALJZ6pKiEKWEUwqTOsxJ62oUh9FH9z6wSAuZvZVGB8NFrZyVEktf6lFGRwVwKuz7TPoN+fOPAQkqif+pq6TWV5Cl5v+LFQT6itwoveQEJ75/BLt653VJXpqy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GBt2AHgZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 442HRCti021266;
	Thu, 2 May 2024 17:32:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=JIL5lk6UNm+SMBzpIAyATQq6e3XKM7ByRDdvdp+Nd6U=;
 b=GBt2AHgZy2ljW+aV4fCT/SgKow/iYqbWiusf4yRCqk/Z4b4nlO8dYhquVDp2Kds8FLqn
 CI76xWPfVSd1WjGyzfNoXMejjii3/iZKJiFIqeFoZTbtzbSFKRbDiQ/ck90jIzGmZcKa
 gCliM7lhw6sIPDVCDCXuvTD/h81CIb4AeJay//Mm3A7OUvqgcB+FXvux/SWixZ1iBACe
 W0laFeQTPR5RaLdUh6jvHZMBBSyB8+bfHatBk4qsHEEQB4bc983z8FunJmWHc6A6l7k+
 TeaOTLUoESXpR9NHXNdE7hlvvqDKEyHjLVQSa8nM2O5WfsWneNGpV77Hssfc2qkkU3fm Sw== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xvf87r0eb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 May 2024 17:32:14 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 442EsJdi027556;
	Thu, 2 May 2024 17:32:13 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xsc30sc95-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 May 2024 17:32:13 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 442HW9wO30605740
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 May 2024 17:32:11 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A65BF20065;
	Thu,  2 May 2024 17:32:09 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E144F2004D;
	Thu,  2 May 2024 17:32:06 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.ibm.com.com (unknown [9.43.113.195])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 May 2024 17:32:06 +0000 (GMT)
From: Hari Bathini <hbathini@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, bpf@vger.kernel.org
Cc: Song Liu <songliubraving@fb.com>, Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Martin KaFai Lau <martin.lau@linux.dev>, stable@vger.kernel.org
Subject: [PATCH v4 1/2] powerpc64/bpf: fix tail calls for PCREL addressing
Date: Thu,  2 May 2024 23:02:04 +0530
Message-ID: <20240502173205.142794-1-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jYrSV768ZNXbY9FSJdfTlD6fTHVxz4kW
X-Proofpoint-GUID: jYrSV768ZNXbY9FSJdfTlD6fTHVxz4kW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-02_09,2024-05-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 clxscore=1011
 impostorscore=0 spamscore=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2404010000 definitions=main-2405020115

With PCREL addressing, there is no kernel TOC. So, it is not setup in
prologue when PCREL addressing is used. But the number of instructions
to skip on a tail call was not adjusted accordingly. That resulted in
not so obvious failures while using tailcalls. 'tailcalls' selftest
crashed the system with the below call trace:

  bpf_test_run+0xe8/0x3cc (unreliable)
  bpf_prog_test_run_skb+0x348/0x778
  __sys_bpf+0xb04/0x2b00
  sys_bpf+0x28/0x38
  system_call_exception+0x168/0x340
  system_call_vectored_common+0x15c/0x2ec

Also, as bpf programs are always module addresses and a bpf helper in
general is a core kernel text address, using PC relative addressing
often fails with "out of range of pcrel address" error. Switch to
using kernel base for relative addressing to handle this better.

Fixes: 7e3a68be42e1 ("powerpc/64: vmlinux support building with PCREL addresing")
Cc: stable@vger.kernel.org
Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
---

* Changes in v4:
  - Fix out of range errors by switching to kernelbase instead of PC
    for relative addressing.

* Changes in v3:
  - New patch to fix tailcall issues with PCREL addressing.


 arch/powerpc/net/bpf_jit_comp64.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index 79f23974a320..4de08e35e284 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -202,7 +202,8 @@ void bpf_jit_build_epilogue(u32 *image, struct codegen_context *ctx)
 	EMIT(PPC_RAW_BLR());
 }
 
-static int bpf_jit_emit_func_call_hlp(u32 *image, struct codegen_context *ctx, u64 func)
+static int
+bpf_jit_emit_func_call_hlp(u32 *image, u32 *fimage, struct codegen_context *ctx, u64 func)
 {
 	unsigned long func_addr = func ? ppc_function_entry((void *)func) : 0;
 	long reladdr;
@@ -211,19 +212,20 @@ static int bpf_jit_emit_func_call_hlp(u32 *image, struct codegen_context *ctx, u
 		return -EINVAL;
 
 	if (IS_ENABLED(CONFIG_PPC_KERNEL_PCREL)) {
-		reladdr = func_addr - CTX_NIA(ctx);
+		reladdr = func_addr - local_paca->kernelbase;
 
 		if (reladdr >= (long)SZ_8G || reladdr < -(long)SZ_8G) {
-			pr_err("eBPF: address of %ps out of range of pcrel address.\n",
-				(void *)func);
+			pr_err("eBPF: address of %ps out of range of 34-bit relative address.\n",
+			       (void *)func);
 			return -ERANGE;
 		}
-		/* pla r12,addr */
-		EMIT(PPC_PREFIX_MLS | __PPC_PRFX_R(1) | IMM_H18(reladdr));
-		EMIT(PPC_INST_PADDI | ___PPC_RT(_R12) | IMM_L(reladdr));
-		EMIT(PPC_RAW_MTCTR(_R12));
-		EMIT(PPC_RAW_BCTR());
-
+		EMIT(PPC_RAW_LD(_R12, _R13, offsetof(struct paca_struct, kernelbase)));
+		/* Align for subsequent prefix instruction */
+		if (!IS_ALIGNED((unsigned long)fimage + CTX_NIA(ctx), 8))
+			EMIT(PPC_RAW_NOP());
+		/* paddi r12,r12,addr */
+		EMIT(PPC_PREFIX_MLS | __PPC_PRFX_R(0) | IMM_H18(reladdr));
+		EMIT(PPC_INST_PADDI | ___PPC_RT(_R12) | ___PPC_RA(_R12) | IMM_L(reladdr));
 	} else {
 		reladdr = func_addr - kernel_toc_addr();
 		if (reladdr > 0x7FFFFFFF || reladdr < -(0x80000000L)) {
@@ -233,9 +235,9 @@ static int bpf_jit_emit_func_call_hlp(u32 *image, struct codegen_context *ctx, u
 
 		EMIT(PPC_RAW_ADDIS(_R12, _R2, PPC_HA(reladdr)));
 		EMIT(PPC_RAW_ADDI(_R12, _R12, PPC_LO(reladdr)));
-		EMIT(PPC_RAW_MTCTR(_R12));
-		EMIT(PPC_RAW_BCTRL());
 	}
+	EMIT(PPC_RAW_MTCTR(_R12));
+	EMIT(PPC_RAW_BCTRL());
 
 	return 0;
 }
@@ -285,7 +287,7 @@ static int bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 o
 	int b2p_index = bpf_to_ppc(BPF_REG_3);
 	int bpf_tailcall_prologue_size = 8;
 
-	if (IS_ENABLED(CONFIG_PPC64_ELF_ABI_V2))
+	if (!IS_ENABLED(CONFIG_PPC_KERNEL_PCREL) && IS_ENABLED(CONFIG_PPC64_ELF_ABI_V2))
 		bpf_tailcall_prologue_size += 4; /* skip past the toc load */
 
 	/*
@@ -993,7 +995,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 				return ret;
 
 			if (func_addr_fixed)
-				ret = bpf_jit_emit_func_call_hlp(image, ctx, func_addr);
+				ret = bpf_jit_emit_func_call_hlp(image, fimage, ctx, func_addr);
 			else
 				ret = bpf_jit_emit_func_call_rel(image, fimage, ctx, func_addr);
 
-- 
2.44.0


