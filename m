Return-Path: <bpf+bounces-54746-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53451A71640
	for <lists+bpf@lfdr.de>; Wed, 26 Mar 2025 13:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D3BD3AF132
	for <lists+bpf@lfdr.de>; Wed, 26 Mar 2025 12:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04A114D2A0;
	Wed, 26 Mar 2025 12:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IdpyvnCk"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4981D6187;
	Wed, 26 Mar 2025 12:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742990921; cv=none; b=H80azB76LxknLbi7/vtZqfV7LJY8yR7FKz7SXQ8ktUC9MfpzjX2ki/1HLWZXoTMSaVCTh2P0MpBcPzCQDwtaAEfa5OD3+t8rt30xI9fEbeMR2u6DkLJjgOCE88lJnBacer5a0nbHzFauH7k0bmDwOdEG4MdqukNfNqC/sjsPfXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742990921; c=relaxed/simple;
	bh=t1W9A7CztuYOzyocp5DJOWnQhbCVCTcqe7Werp2bR1k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gO+TmkfO4rkLSOOTJ+U+G+jYlgt/hzlrjFMIZ3EMqjdyaX+XQL7Pram7VWJVGwvRywZHHV4l3Bg21tKbLK7OQVvUnp0BTzjmyh/sCAXVo2CBExjvFSTFZPz4f34sFWLbUyqgW08IsUiF5f5eELxA7PRglwQMspkJuG91BZ1gPSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IdpyvnCk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52Q1jDcT026988;
	Wed, 26 Mar 2025 12:08:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=scsnGuI4cun0Pezz+whqX+7I1f1DZvHWO46k2SNU/
	Hk=; b=IdpyvnCkf6UiB4n8i++o1byKwDuenD/Z1iXLh28PSOLPqKguaF7aqiuUT
	/txcKe1/HmhB5JzH5q7+Ha32WSQdKC/HzGI01HVcbRgiKf0WEO6wgceQ98TgOpjp
	qnQP+KvZ+2jBxbiIkPWFKPvokobOtD/L20RifJGOX7bcLCq1/8ZKNwTj2PcVtO2Q
	MJ+chcISqGTczuKoIjpo85UBAA4CNtHzym0SR2hHyRzvRz6n8C93OsPuEaaRRKfk
	zx8TKO0AV5JxDi8zWOGPtkrKwX62+jbwDGncM82/LPneq3p0YmlKwad/wio7Q02J
	7EnKPIWlswlaof9vmgAInclzet54w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45kbjx2nrd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 12:08:09 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52QC3hcj027642;
	Wed, 26 Mar 2025 12:08:08 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45kbjx2nr5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 12:08:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52QBsZYW005801;
	Wed, 26 Mar 2025 12:08:08 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45ja82fxaf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 12:08:07 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52QC84Bn21954864
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Mar 2025 12:08:04 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A1752004B;
	Wed, 26 Mar 2025 12:08:04 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 747CE20040;
	Wed, 26 Mar 2025 12:08:01 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.ibm.com.com (unknown [9.43.113.131])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Mar 2025 12:08:01 +0000 (GMT)
From: Hari Bathini <hbathini@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, bpf@vger.kernel.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Naveen N. Rao" <naveen@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Nicholas Piggin <npiggin@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>, stable@vger.kernel.org
Subject: [PATCH] powerpc64/bpf: fix JIT code size calculation of bpf trampoline
Date: Wed, 26 Mar 2025 17:38:00 +0530
Message-ID: <20250326120800.1141056-1-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XqlQA9WjzOD7z2NE0J22XdWUXsPLNiVH
X-Proofpoint-ORIG-GUID: 9CHHgm0--2r1Zri-QBe13F6AWbFgBKqc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_04,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 spamscore=0
 clxscore=1011 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=616 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503260073

The JIT compile of ldimm instructions can be anywhere between 1-5
instructions long depending on the value being loaded.

arch_bpf_trampoline_size() provides JIT size of the BPF trampoline
before the buffer for JIT'ing it is allocated. BPF trampoline JIT
code has ldimm instructions that need to load the value of pointer
to struct bpf_tramp_image. But this pointer value is not same while
calling arch_bpf_trampoline_size() & arch_prepare_bpf_trampoline().
So, the size arrived at using arch_bpf_trampoline_size() can vary
from the size needed in arch_prepare_bpf_trampoline(). When the
number of ldimm instructions emitted in arch_bpf_trampoline_size()
is less than the number of ldimm instructions emitted during the
actual JIT compile of trampoline, the below warning is produced:

  WARNING: CPU: 8 PID: 204190 at arch/powerpc/net/bpf_jit_comp.c:981 __arch_prepare_bpf_trampoline.isra.0+0xd2c/0xdcc

which is:

  /* Make sure the trampoline generation logic doesn't overflow */
  if (image && WARN_ON_ONCE(&image[ctx->idx] >
			(u32 *)rw_image_end - BPF_INSN_SAFETY)) {

Pass NULL as the first argument to __arch_prepare_bpf_trampoline()
call from arch_bpf_trampoline_size() function, to differentiate it
from how arch_prepare_bpf_trampoline() calls it and ensure maximum
possible instructions are emitted in arch_bpf_trampoline_size() for
ldimm instructions that load a different value during the actual JIT
compile of BPF trampoline.

Fixes: d243b62b7bd3 ("powerpc64/bpf: Add support for bpf trampolines")
Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Closes: https://lore.kernel.org/all/6168bfc8-659f-4b5a-a6fb-90a916dde3b3@linux.ibm.com/
Cc: stable@vger.kernel.org # v6.13+
Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
---
 arch/powerpc/net/bpf_jit_comp.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index 2991bb171a9b..49d7e9a8d17c 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -686,7 +686,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	 *                              [                   ] --
 	 * LR save area                 [ r0 save (64-bit)  ]   | header
 	 *                              [ r0 save (32-bit)  ]   |
-	 * dummy frame for unwind       [ back chain 1      ] --
+	 /* dummy frame for unwind       [ back chain 1      ] --
 	 *                              [ padding           ] align stack frame
 	 *       r4_off                 [ r4 (tailcallcnt)  ] optional - 32-bit powerpc
 	 *       alt_lr_off             [ real lr (ool stub)] optional - actual lr
@@ -833,7 +833,12 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	EMIT(PPC_RAW_STL(_R26, _R1, nvr_off + SZL));
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
-		PPC_LI_ADDR(_R3, (unsigned long)im);
+		/*
+		 * Emit maximum possible instructions while getting the size of
+		 * bpf trampoline to ensure trampoline JIT code doesn't overflow.
+		 */
+		PPC_LI_ADDR(_R3, im ? (unsigned long)im :
+				(unsigned long)(~(1UL << (BITS_PER_LONG - 1))));
 		ret = bpf_jit_emit_func_call_rel(image, ro_image, ctx,
 						 (unsigned long)__bpf_tramp_enter);
 		if (ret)
@@ -889,7 +894,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 			bpf_trampoline_restore_tail_call_cnt(image, ctx, func_frame_offset, r4_off);
 
 		/* Reserve space to patch branch instruction to skip fexit progs */
-		im->ip_after_call = &((u32 *)ro_image)[ctx->idx];
+		if (im)
+			im->ip_after_call = &((u32 *)ro_image)[ctx->idx];
 		EMIT(PPC_RAW_NOP());
 	}
 
@@ -912,8 +918,14 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 		}
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
-		im->ip_epilogue = &((u32 *)ro_image)[ctx->idx];
-		PPC_LI_ADDR(_R3, im);
+		if (im)
+			im->ip_epilogue = &((u32 *)ro_image)[ctx->idx];
+		/*
+		 * Emit maximum possible instructions while getting the size of
+		 * bpf trampoline to ensure trampoline JIT code doesn't overflow.
+		 */
+		PPC_LI_ADDR(_R3, im ? (unsigned long)im :
+				(unsigned long)(~(1UL << (BITS_PER_LONG - 1))));
 		ret = bpf_jit_emit_func_call_rel(image, ro_image, ctx,
 						 (unsigned long)__bpf_tramp_exit);
 		if (ret)
@@ -972,7 +984,6 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
 			     struct bpf_tramp_links *tlinks, void *func_addr)
 {
-	struct bpf_tramp_image im;
 	void *image;
 	int ret;
 
@@ -988,7 +999,13 @@ int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
 	if (!image)
 		return -ENOMEM;
 
-	ret = __arch_prepare_bpf_trampoline(&im, image, image + PAGE_SIZE, image,
+	/*
+	 * Pass NULL as bpf_tramp_image pointer to differentiate the intent to get the
+	 * buffer size for trampoline here. This differentiation helps in accounting for
+	 * maximum possible instructions if the JIT code size is likely to vary during
+	 * the actual JIT compile of the trampoline.
+	 */
+	ret = __arch_prepare_bpf_trampoline(NULL, image, image + PAGE_SIZE, image,
 					    m, flags, tlinks, func_addr);
 	bpf_jit_free_exec(image);
 
-- 
2.48.1


