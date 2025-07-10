Return-Path: <bpf+bounces-62937-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFE3B008E8
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 18:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 682157BC493
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 16:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A832F0044;
	Thu, 10 Jul 2025 16:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lA5+eq0W"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE3E274B25;
	Thu, 10 Jul 2025 16:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752165354; cv=none; b=uqniHValqZzTbBid9BxXOjzq+auvw4T/9+9InIpMCwPlDtlTWs41d390omjUpzeBTtaB34dm6r/c5pdL6GeoVJEv6fnNClCRqt67QVsCKgiQQO6i3xGG1rFHh3o6zBQUaleNCfDdcTQ2JnbwneyOJSr5vhI3ltRWU+GdrQ7oDZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752165354; c=relaxed/simple;
	bh=ZX5VEKy+tXemUjC+v9hW4xDNrhvfiApab+IDAU5Z9Ys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UHYhrTBT6HDY10/FdexaBTiMF6yLZKwyNwOoV1wDL/3MAAH9xjxdSiHfasv7Af6VDjp1tHJC0SjMr9nN/b2fwFMvG5UV+JmKO1ebr7uwhdgz8eeV/r1XEZaE3j20M9SyUKgJERI9PFc2TmA4xyEmgaijOLjRVXro+z7dxPSaQCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lA5+eq0W; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56AD5iu8028946;
	Thu, 10 Jul 2025 16:35:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=oQgc8Tb7yTrO5jNCO
	Lp9cjAZeN86sDDgbZi+kb5fn50=; b=lA5+eq0WolCPQhzQBDKf3+IzBCdXGd7NS
	zSOOPHpdOSRyseRPVSar0LmwOqbwAiH+QtAapA52XuErEL6mVhvNMrj1oIKv28RG
	AM2cORLnHlIxewsSikXOHSCDgpdB1vJ20J/SABoGNr9ibSloBT+8QtOPZQHk+Chs
	RA3L9YvOmrGRx4yhXhwkKuYXmBqgfxJuKqxAAPHYYSzvZTUx/p0R5EuM7n4ZryQi
	l7rDcTfpA/3j/xv6LWjl98HWo7CCRmC55TJbwLKe3zs7uzaQomgT1Unxoz/XTbop
	pvN955a7M4jMcDQId2sdwbxyCEX2QLl9nIX/AzpjGEdSDa+326nRA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ptjrd3aw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 16:35:29 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56AFnBuK013555;
	Thu, 10 Jul 2025 16:35:28 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47qgkm6bbv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 16:35:28 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56AGZPcK58458488
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 16:35:25 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 279262004B;
	Thu, 10 Jul 2025 16:35:25 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E0DEF2004D;
	Thu, 10 Jul 2025 16:35:24 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 10 Jul 2025 16:35:24 +0000 (GMT)
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
        Sam James <sam@gentoo.org>
Subject: [RFC PATCH v1 03/16] s390/vdso: Avoid emitting DWARF CFI for non-vDSO
Date: Thu, 10 Jul 2025 18:35:09 +0200
Message-ID: <20250710163522.3195293-4-jremus@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=GL8IEvNK c=1 sm=1 tr=0 ts=686febd1 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=meVymXHHAAAA:8 a=VnNF1IyMAAAA:8 a=BeDKgDnIR9-QKG0Pbi4A:9 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-ORIG-GUID: -9wqBJZ7nR8PW5ex_BvQ3nIrMUn_d7Xe
X-Proofpoint-GUID: -9wqBJZ7nR8PW5ex_BvQ3nIrMUn_d7Xe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEzOSBTYWx0ZWRfXzMU6D3+v4Nwd AhhGmxIxJLd4PeChfBf4kssqHijisjgT3A8Y+s7yItf93cIN1eDtr5CUfXGae+LCIzovjOLVzmt Zc2oVLNMLd9GVseAPUvv7Hw5ASW0XsCPHxJByNZC1zqcOkVuWOKK90t8/BmfzX95EiAcS9eTPTk
 8N6xC3k4ccGCpTmOxZtIzI12yGksJgGH3yVVukWQiOJyL0v0DeiqzhALK38/HUtzY82AgMo9aqn V/QI3PDYbKIiVkUIX8epXoKw1daPklJ8V0OwYwIF5qQoaT3pobal2dIwkGHYUZBQPPG7eh5L/Fj G+fYE2sXRCCGq1cPegPdZxptaCDzrKizG9OMRqqp8S0Y90GzY35NtrJQj1HdCo9Mu5l6nAhNbOr
 Z18qI/vtWxn5O/FZZGCxWt8n8BiD4llUu6FRG4cwAHC2Q9EALkJkbeeP7zNcME/hvN4dTyZ/
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 mlxlogscore=956
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507100139

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
index fdf51f66a9ed..5052ee6a40f7 100644
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
2.48.1


