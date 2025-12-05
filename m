Return-Path: <bpf+bounces-76161-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F21BCCA89CC
	for <lists+bpf@lfdr.de>; Fri, 05 Dec 2025 18:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 163173027ED3
	for <lists+bpf@lfdr.de>; Fri,  5 Dec 2025 17:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA2734C811;
	Fri,  5 Dec 2025 17:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SqzYXw8B"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9FA34F490;
	Fri,  5 Dec 2025 17:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764954945; cv=none; b=SPw3os03VE5gFxtWzRYLb5Z6znCdH6msTrjzQj1q8oi0GotHGNUiHIE5CUAYGrTbtkwcuEh+74vm60gKHzb4bzHS4AMW9iiYFz8ljqaGtQi/Fz+f3zkInyLG+dilrYps/r6qO7pC6Ptp7Srny/8kjqo3V/TEzR09KpU9MrxkQeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764954945; c=relaxed/simple;
	bh=n4UqXtWKP9aM7+of2a9zTKNpugsdsHjeuZZ9Y6vQt1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eWtbkm4K8YTon1bl7cxWyl5rQQ7kP8Ljx4UKFgfudFZjHLymXk/RQHLGYAxFH7XjnrX1AePRepG+MuH1Cqq2yWXM4WJ8JcSjY9cnUZT1Fz27cqf0qa8ll6UZr3DhbV9LeypqkEZENBH4IuyhEkKhxLw7Ar1by+EGzQZJA+vLy/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SqzYXw8B; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B5FoJau026734;
	Fri, 5 Dec 2025 17:14:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=YwkCBIDx+CdwD1PaP
	1iGkMwFtK6nggvYnNMUdWID+FY=; b=SqzYXw8BvnBgmnJEn08f1YgI7hOAOD+WW
	wb2fvvjCmGmwloFlWzYpjvYDuKotVwJq/RW+wX5vco9f2wdEFMlBKv2wbIYuBp4+
	dTnTnOSnU7dxkr7F89Jw4hVo+z0mLsqtMf8yNNlCpWNg1DyxyUGPLy9JgF5z+BBT
	rPsjeYD0dwKUyhj+r94wgws3bMPhTKJ3gEHVi2lkciQq+KXjyezyJWz1U6t6mhX7
	FKy5woedKWfSMweSirutQRsbwJ5HAmarRucqikcukd/IrNNPMeoE70BiUg2JRL51
	wz8YaQtaW2Yzru6q9hIVAJy5LrCJgP1jSsSHq5LEFygVWwF2ITfow==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrh7ey3m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 17:14:56 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B5HARnV011228;
	Fri, 5 Dec 2025 17:14:55 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrh7ey3f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 17:14:55 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B5EgTSg019120;
	Fri, 5 Dec 2025 17:14:54 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4arbhyeee0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 17:14:54 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B5HEone49152258
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Dec 2025 17:14:50 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B9D12004F;
	Fri,  5 Dec 2025 17:14:50 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CED7920043;
	Fri,  5 Dec 2025 17:14:49 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  5 Dec 2025 17:14:49 +0000 (GMT)
From: Jens Remus <jremus@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
        Steven Rostedt <rostedt@kernel.org>
Cc: Jens Remus <jremus@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Indu Bhagat <indu.bhagat@oracle.com>,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Florian Weimer <fweimer@redhat.com>, Kees Cook <kees@kernel.org>,
        "Carlos O'Donell" <codonell@redhat.com>, Sam James <sam@gentoo.org>,
        Dylan Hatch <dylanbhatch@google.com>
Subject: [RFC PATCH v2 05/15] s390/vdso: Avoid emitting DWARF CFI for non-vDSO
Date: Fri,  5 Dec 2025 18:14:36 +0100
Message-ID: <20251205171446.2814872-6-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251205171446.2814872-1-jremus@linux.ibm.com>
References: <20251205171446.2814872-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=dK+rWeZb c=1 sm=1 tr=0 ts=69331310 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=meVymXHHAAAA:8
 a=VnNF1IyMAAAA:8 a=BeDKgDnIR9-QKG0Pbi4A:9 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-GUID: I6owunHUd76ubwXa1thWJ8JjoIn5Mz3r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAyMCBTYWx0ZWRfX+xMnkIeN5F0h
 iqRaf3KwcyUXbCDx5LjC/Q2Y2lWxfBbWkG5cD+0zmcRJi1ycKgurVq1MKtysy+Ai+HY4ssAMlrl
 UyUSVicJKMe0IJouO4PcCQfdTVkwlb/SbSvrUvWOxez+feaNPAS0D+HUz4RNmWrhB5Y2c1LslxU
 ebNUkWoJxQCyDWiTHwzJhtzJiqOTFPp5PwC6pMJaHVixlr5NsdT6WBpCSFVPq9XI0VxSDUjOd4B
 dtHXa4n5H67W1qFpHTrjMrGDwh/jrjdLbPY+VFpqqVsTqLAbxkyODJyZfxuywSD1wWeo7KEcq3u
 OE0zpW8HWQ4iPZF6mq5EFh3HsNUaOf80p1ZNyeETkxHsbN9eOOD5Rj2i7z/yGlP1d0x0fEboVVX
 +GeW/HIEM4aVWX6odyBBiVC44dHOxg==
X-Proofpoint-ORIG-GUID: 22VuX9DZGyh6GFv98gNBhplTvioN6VoE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_06,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511290020

This replicates Josh's x86 commit TODO ("x86/asm: Avoid emitting DWARF
CFI for non-VDSO") for s390.  It also aligns asm/dwarf.h to x86
asm/dwarf2.h.

It was decided years ago that .cfi_* annotations aren't maintainable in
the kernel.  For the kernel proper, ensure the CFI_* macros don't do
anything.

On the other hand the vDSO library *does* use them, so user space can
unwind through it.

Make sure these macros only work for vDSO.  They aren't actually being
used outside of vDSO anyway, so there's no functional change.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    Link to latest x86 patch:
    https://lore.kernel.org/all/20250425024022.477374378@goodmis.org/

 arch/s390/include/asm/dwarf.h | 45 ++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 16 deletions(-)

diff --git a/arch/s390/include/asm/dwarf.h b/arch/s390/include/asm/dwarf.h
index df9f467910f7..6bcf37256feb 100644
--- a/arch/s390/include/asm/dwarf.h
+++ b/arch/s390/include/asm/dwarf.h
@@ -6,6 +6,18 @@
 #warning "asm/dwarf.h should be only included in pure assembly files"
 #endif
 
+.macro nocfi args:vararg
+.endm
+
+#ifdef BUILD_VDSO
+
+	/*
+	 * For the vDSO, emit both runtime unwind information and debug
+	 * symbols for the .dbg file.
+	 */
+
+	.cfi_sections .eh_frame, .debug_frame
+
 #define CFI_STARTPROC		.cfi_startproc
 #define CFI_ENDPROC		.cfi_endproc
 #define CFI_DEF_CFA_OFFSET	.cfi_def_cfa_offset
@@ -16,23 +28,24 @@
 #ifdef CONFIG_AS_CFI_VAL_OFFSET
 #define CFI_VAL_OFFSET		.cfi_val_offset
 #else
-#define CFI_VAL_OFFSET		#
+#define CFI_VAL_OFFSET		nocfi
 #endif
 
-#ifndef BUILD_VDSO
-	/*
-	 * Emit CFI data in .debug_frame sections and not in .eh_frame
-	 * sections.  The .eh_frame CFI is used for runtime unwind
-	 * information that is not being used.  Hence, vmlinux.lds.S
-	 * can discard the .eh_frame sections.
-	 */
-	.cfi_sections .debug_frame
-#else
-	/*
-	 * For vDSO, emit CFI data in both, .eh_frame and .debug_frame
-	 * sections.
-	 */
-	.cfi_sections .eh_frame, .debug_frame
-#endif
+#else /* !BUILD_VDSO */
+
+/*
+ * On s390, these macros aren't used outside vDSO.  As well they shouldn't be:
+ * they're fragile and very difficult to maintain.
+ */
+
+#define CFI_STARTPROC		nocfi
+#define CFI_ENDPROC		nocfi
+#define CFI_DEF_CFA_OFFSET	nocfi
+#define CFI_ADJUST_CFA_OFFSET	nocfi
+#define CFI_RESTORE		nocfi
+#define CFI_REL_OFFSET		nocfi
+#define CFI_VAL_OFFSET		nocfi
+
+#endif /* !BUILD_VDSO */
 
 #endif	/* _ASM_S390_DWARF_H */
-- 
2.51.0


