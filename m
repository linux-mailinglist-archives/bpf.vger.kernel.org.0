Return-Path: <bpf+bounces-62945-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E76BCB008F5
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 18:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2012F1CA277C
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 16:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E2D2EFD9D;
	Thu, 10 Jul 2025 16:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gXTMrzN5"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4662F2366;
	Thu, 10 Jul 2025 16:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752165363; cv=none; b=jc4JcAPPSXyOY12yC1EwHbOpAZycv/qbFCaAwKaFeEOmpOLQncgXGJLWLmcyFQOZiipAw9hvRJ0H8Paob4ECc+Qiz3y3Dwl7zM/R61GkX1cecEaOyRihFZJpmQVMvYMNSLIW00s2nV9U9eyAZ8LmyhMp6bsA/1ORNJMkMn0dYkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752165363; c=relaxed/simple;
	bh=lRRs4ZXJpUwxnruw9Aw1vFLZ3QwboXxyNzSGKh/SutU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BTyQVOK+/6PGSTXBrzuZIEnGeJFQu63pQU6aRh/5Py0+U3BgtbO4/e/fg7A3L4XnuNBhxZWsBd/LRHC0Mwc0vAAd563jsCStWIDSfDc2x0LAiKJN2WrUlWAkyxbNFWkiCZMtLJyeMK0mnEgx3JnEpCrwP8Ml13HXhHVcSSKBVWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gXTMrzN5; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56ACALZF008445;
	Thu, 10 Jul 2025 16:35:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=dLpURqXy0X9ikZ433
	zJ2XsLbDK7WPIJsqR+KifaA20A=; b=gXTMrzN5dXI6yOiJJ+ZS00w1nT4CUvohU
	icZ6WmAj12tPlAnoaKsK9Grbs6x8yR0kyXHI7neiXpvqS6LP+iKyuJY89LGekvZ5
	r02uDAedsCH/shKfo1whtnthNpdUvttUkT0ojayTMmQ4Ua03tdHWGwrfRA/dmhve
	DPU3bQxjcKwy+Zfcjl/GRrApi19AzcXoHriXaUScYovyALBDcmlX9OKP8my/C5i5
	CrM7UYNS3QpMq5K9Q6oM93IBwNBjP9Fm5NeuX62hF90EFwK9l0mP6HkQdGkhdovD
	BwrtNkoYqT/gDGg0fFUx8NappTtzvSrwtDRMhseHzfpXt+98/6dyA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47svb26atm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 16:35:32 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56AEvlu5024684;
	Thu, 10 Jul 2025 16:35:32 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 47qh32p8mq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 16:35:31 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56AGZSYi12714312
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 16:35:28 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2367F2005A;
	Thu, 10 Jul 2025 16:35:28 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D72442004D;
	Thu, 10 Jul 2025 16:35:27 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 10 Jul 2025 16:35:27 +0000 (GMT)
From: Jens Remus <jremus@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        bpf@vger.kernel.org, x86@kernel.org,
        Steven Rostedt <rostedt@kernel.org>
Cc: Jens Remus <jremus@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Indu Bhagat <indu.bhagat@oracle.com>,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Florian Weimer <fweimer@redhat.com>,
        Sam James <sam@gentoo.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [RFC PATCH v1 14/16] PREREQ: x86/asm: Avoid emitting DWARF CFI for non-VDSO
Date: Thu, 10 Jul 2025 18:35:20 +0200
Message-ID: <20250710163522.3195293-15-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250710163522.3195293-1-jremus@linux.ibm.com>
References: <20250710163522.3195293-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEzOSBTYWx0ZWRfXzgzNkj0fboa1 oeO4a2w/N+AxGb7uCCfwYWnWAcv4I87VwzXptAvUzxbXfGta8gMUMacp3Suujus9CPju+gv0gGt YlIgkkgXx6+wyD/GqTqDMcb0GCI1brVREe4A5rr17KlAiVta3JIEHhYEmiVAGq169Bo0vmqKmHy
 A4HsJCMhboqYyKC1cFOvg6Qn/gZiAcdF6PHBnwvO0z7c1OFxmuUxDi85gsGGVKDFuUlH4Nulsfv 91pCxzrCjvb+HEQv/FWcX+nqOidjgdKsyMvB2B0j/TNuBvWPV/fHadBE9z1ST+o5c8L71LaZCaM aU7zhzIQr7qHYUqxIvCZV5W8sd7sx14a/nALHMurlTUDiFbSwartht+UxNnfj0goKsUjhXWQyGL
 YaRMKsbr6OLhb9fLMIWZJOUPvdnANMGSjI2YqR6wgWfSehWlatDTjQXlpGWuwopVSViFw25C
X-Authority-Analysis: v=2.4 cv=Y774sgeN c=1 sm=1 tr=0 ts=686febd5 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=meVymXHHAAAA:8 a=zOOTxvlrTZNIKiBVQswA:9 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-ORIG-GUID: qQ5hGor0rDVpNc66sxy5Y8W-sqMf2aOH
X-Proofpoint-GUID: qQ5hGor0rDVpNc66sxy5Y8W-sqMf2aOH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 mlxlogscore=862 mlxscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507100139

From: Josh Poimboeuf <jpoimboe@kernel.org>

It was decided years ago that .cfi_* annotations aren't maintainable in
the kernel.  They were replaced by objtool unwind hints.  For the kernel
proper, ensure the CFI_* macros don't do anything.

On the other hand the VDSO library *does* use them, so user space can
unwind through it.

Make sure these macros only work for VDSO.  They aren't actually being
used outside of VDSO anyway, so there's no functional change.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---

Notes (jremus):
    Link: https://lore.kernel.org/all/20250425024022.477374378@goodmis.org/
    
    This is only a prerequisite for the subsequent prerequisite patch
    "x86/vdso: Enable sframe generation in VDSO" to apply cleanly.

 arch/x86/include/asm/dwarf2.h | 51 ++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/dwarf2.h b/arch/x86/include/asm/dwarf2.h
index 302e11b15da8..65d958ef1178 100644
--- a/arch/x86/include/asm/dwarf2.h
+++ b/arch/x86/include/asm/dwarf2.h
@@ -6,6 +6,15 @@
 #warning "asm/dwarf2.h should be only included in pure assembly files"
 #endif
 
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
 #define CFI_DEF_CFA		.cfi_def_cfa
@@ -21,21 +30,31 @@
 #define CFI_UNDEFINED		.cfi_undefined
 #define CFI_ESCAPE		.cfi_escape
 
-#ifndef BUILD_VDSO
-	/*
-	 * Emit CFI data in .debug_frame sections, not .eh_frame sections.
-	 * The latter we currently just discard since we don't do DWARF
-	 * unwinding at runtime.  So only the offline DWARF information is
-	 * useful to anyone.  Note we should not use this directive if we
-	 * ever decide to enable DWARF unwinding at runtime.
-	 */
-	.cfi_sections .debug_frame
-#else
-	 /*
-	  * For the vDSO, emit both runtime unwind information and debug
-	  * symbols for the .dbg file.
-	  */
-	.cfi_sections .eh_frame, .debug_frame
-#endif
+#else /* !BUILD_VDSO */
+
+/*
+ * On x86, these macros aren't used outside VDSO.  As well they shouldn't be:
+ * they're fragile and very difficult to maintain.
+ */
+
+.macro nocfi args:vararg
+.endm
+
+#define CFI_STARTPROC		nocfi
+#define CFI_ENDPROC		nocfi
+#define CFI_DEF_CFA		nocfi
+#define CFI_DEF_CFA_REGISTER	nocfi
+#define CFI_DEF_CFA_OFFSET	nocfi
+#define CFI_ADJUST_CFA_OFFSET	nocfi
+#define CFI_OFFSET		nocfi
+#define CFI_REL_OFFSET		nocfi
+#define CFI_REGISTER		nocfi
+#define CFI_RESTORE		nocfi
+#define CFI_REMEMBER_STATE	nocfi
+#define CFI_RESTORE_STATE	nocfi
+#define CFI_UNDEFINED		nocfi
+#define CFI_ESCAPE		nocfi
+
+#endif /* !BUILD_VDSO */
 
 #endif /* _ASM_X86_DWARF2_H */
-- 
2.48.1


