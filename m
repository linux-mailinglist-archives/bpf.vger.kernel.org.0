Return-Path: <bpf+bounces-76303-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 323CBCADE1F
	for <lists+bpf@lfdr.de>; Mon, 08 Dec 2025 18:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C05183047B44
	for <lists+bpf@lfdr.de>; Mon,  8 Dec 2025 17:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EA7314D2A;
	Mon,  8 Dec 2025 17:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JIodgsqQ"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F112FBE11;
	Mon,  8 Dec 2025 17:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765214200; cv=none; b=i0yauood1m6p5t5mIY5yvchWJkuw8Re5cmI4qffo94p0160YZ6lEciLBDnO+hysDOhkuFmQOKRGGcrXezexJx3+vuSV9kiYn4JPD5HffsJ+Z+4tZ/zuVimlwBrepN+/U0mMdzjSaw/DZC2IJLB0yuOiqqK84r9+WqQECxXyQTVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765214200; c=relaxed/simple;
	bh=n4UqXtWKP9aM7+of2a9zTKNpugsdsHjeuZZ9Y6vQt1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ats3zMS/NbfaaCF7P4usWnJeRoSpkzXYm8NA45wNFrqiYVBMq5bwyb9LE08rnyPo6Jb0XMac1OUVqlfE0P93JZIGC7yVFs7YvAdoGLBKTHQFfhwcjYI/DRi1Itpxd9kDM0vS/P7O+8tGDjDzyCBdCQJc5KQ/Qla6SnqtTYHmUNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JIodgsqQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B87jU2o032400;
	Mon, 8 Dec 2025 17:16:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=YwkCBIDx+CdwD1PaP
	1iGkMwFtK6nggvYnNMUdWID+FY=; b=JIodgsqQ5giB9xuBFH9zGASMVHgEwm1nM
	01lhgp7nALV4lC1ZOAGksr2nSFNzu4z8oIG1MX8sSWnmPipggwTLOJGXqZO2I/JU
	8fUfsovZNsJSQNtD/m5HCvDDtLf6pVXNqudYFiR0mnUWhyGFkNT3LTPiOe8Qh1pR
	xtx6RWvP6/ry7xKVfh07v+z0HPPSH/WC4FOSgtYqh5BRdQOTx8AoN0obker9q+gS
	sEkba3W2hBwcSMYNMGE9DmRqE8tMVA58aGwUVVhalSm7gPrG+xAqMiCWVWEN87U9
	kefGqqaLh/X8v0mF99A4oQm222cRtfKAZnobckug9jQV+Z01vlOIg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc618x5h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 17:16:10 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B8H1lPv013244;
	Mon, 8 Dec 2025 17:16:09 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc618x58-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 17:16:09 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B8G7IjH026799;
	Mon, 8 Dec 2025 17:16:08 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aw1h0xfku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 17:16:08 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B8HG4cR60358938
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Dec 2025 17:16:04 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 69F5020043;
	Mon,  8 Dec 2025 17:16:04 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 158AD2004D;
	Mon,  8 Dec 2025 17:16:04 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Dec 2025 17:16:04 +0000 (GMT)
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
Subject: [RFC PATCH v3 06/17] s390/vdso: Avoid emitting DWARF CFI for non-vDSO
Date: Mon,  8 Dec 2025 18:15:48 +0100
Message-ID: <20251208171559.2029709-7-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251208171559.2029709-1-jremus@linux.ibm.com>
References: <20251208171559.2029709-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAyMCBTYWx0ZWRfX5jZeM+WTsfn3
 +sHyJsDIzkJhxX+p7VsSQk+OkoKrvSlqkEd+oWE1rM6r+xqrqU+T3pCQPbiJZd7JcnW84j9idPJ
 maLMdn2xBHFZppX1gdzYnHzT1rO+vQbPs8bsspWOytwmEKnC+yF25txMLPioICoFHPx+VOpAB4H
 qNBB9qYzRX/1yYBDm8mMggGziFxS2KtWOPytlQ8zXZ/5Nz+hSIz7vHHAHKw78yDlPOqAD76WMam
 hLp4h2QqJ/BIk5iNVRY8H+yLiExPreMp0qdKJunf6au0ED6U8f/vZ2GMY8p5MYF9ZVFN45f/vTE
 tsY6P6X0E4TEnwbIfOwZq2TtpzlaaAMIrSeccN/m9AwnRxaUjFiiSg/9teXg8iime+wMNK2LXVm
 2Kim3+HJ++mj6BGDGoCq3iprbLgv/w==
X-Proofpoint-GUID: AtyoosCu-jjGI1nH9HptHZlond16_jBv
X-Proofpoint-ORIG-GUID: 6lGGs0Rc-y0qYKZC9_9Tp_ni9O2crJcA
X-Authority-Analysis: v=2.4 cv=O/U0fR9W c=1 sm=1 tr=0 ts=693707da cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=meVymXHHAAAA:8
 a=VnNF1IyMAAAA:8 a=BeDKgDnIR9-QKG0Pbi4A:9 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060020

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


