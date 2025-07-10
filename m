Return-Path: <bpf+bounces-62947-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 455F4B008FB
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 18:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24FBE16FCF5
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 16:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E322F3637;
	Thu, 10 Jul 2025 16:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="F1TFFg+B"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D053D2EFDB7;
	Thu, 10 Jul 2025 16:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752165375; cv=none; b=h4AZ+Jjp9k2TUr12M8UhuutBOKSBjEEsomJLS3Z7KwZ+M3RBWHvm2SwQoxlaf0ZbX2y/W4L3HkFKTx34aowIf02hSsYz9FrD3i3/13hyeBdBQOUJnqVG+SRBlyBIFcoOebJla+oZPO27SRicZ5O+0/IZroIxJ6F/5RCZkERsWhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752165375; c=relaxed/simple;
	bh=0vJWpp1BmbZ+f0zTAZ3jlmEW/uAv+t+YKzeyKWWg1RQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KkHkWiiHEthX+dxXRnqi2afit4gKriWdCPlfxCPdAk18+cPmXhLS298nNRk9Unmn6z+n+uTwlCq1ST4E7UdHs39p5jiWGNZRsdY+CH/CYsSVR8gnx0mb0+/CTliBkMe1AWHis2rKoI0X/ZbwLhT2G0iRTOeKdxrUFVihGPUEda8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=F1TFFg+B; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56AGWGg3003799;
	Thu, 10 Jul 2025 16:35:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=J0Aj3viCRgNhlNDYJ
	Ou/WXWjIHdWC6edfdvJr86GHWw=; b=F1TFFg+BMuCsYVHCMpv9A74uF6sRButiw
	zyu3hTT7ZwHhk/hte72mkj7ro8Kh5WXbcJgtjglns0uRY6ZoGY8KC2Om0o1MSsXE
	Vk3cibfPg+MGewTbLCCc1+PrTMjAGInYHsM8/LKQV3rGOm3b1hjfltUOTY5P6pg4
	BkUfg2lpofhK7wSY905bOUsXE2tIhJro46LaEoMWDCPPfUpeZRmmNDyWSe1MfJ/k
	/yYZKH3hOLbZ9G7sNsYk7Og0Gg/LXbpdpbX9iO1FtCKhj/GSyqVUg6y6MqcGECZo
	DAR00WnYQTfb3+G2dEMGd79fvvxf772EVLVtO1pIxB0VbP8Oeg3ew==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47pusse6a4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 16:35:29 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56ADaNBQ021525;
	Thu, 10 Jul 2025 16:35:28 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 47qectxrmw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 16:35:28 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56AGZO7V60555664
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 16:35:25 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DCB1220043;
	Thu, 10 Jul 2025 16:35:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A1AA22004B;
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
Subject: [RFC PATCH v1 02/16] s390: asm/dwarf.h should only be included in assembly files
Date: Thu, 10 Jul 2025 18:35:08 +0200
Message-ID: <20250710163522.3195293-3-jremus@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Vaj3PEp9 c=1 sm=1 tr=0 ts=686febd1 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=62EC5onNXgn9lpaB:21 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=AB0lExOjSfRHyy3z6bMA:9
X-Proofpoint-GUID: OC2ueetbyejJeOUMHdFkDZQbM4J5xhad
X-Proofpoint-ORIG-GUID: OC2ueetbyejJeOUMHdFkDZQbM4J5xhad
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEzOSBTYWx0ZWRfX+fRxaAqnNCEy /smFp9yN4tOoaquCC0pqfKU/EvUiXOH1zJwkSl4ep/HjkjHt/dosHdyPylt/nznJnVFslQboEbS Vz8ibRni232TyAL9BlMqjubagMyQmzx3mdjCTcadkMyXh0URU3YH8coA/LICKDklacpyX87nn0y
 YcuGwmwrYeAQJvQFttdGxmoSArUxSCKhmq2XibnYhBSN/b6QUgML0c1n+CYJtpPz4Sv9r0IvM79 iE27pgE1223OURYEIV1Gu3qbZpxqKsfqFfa1Vkp6eupsiRKIilt6cxlN1Vvt1nDjyngTrGlxG4c xbiEWStfwdoY5yX2e7Df3HH/vgy+Eoe9yaGe30pntNvLDdzGe1K4yVnQLXdI2l8qCNuvp5jOplU
 yY01Q3CRD62wgBvxgsK4YQQL3p5BLCI3pBIhggQZV4CxN7ET0K49TrA8C04kanuTlpjPQOVd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=935 suspectscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 spamscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507100139

Align to x86 and add a compile-time check that asm/dwarf.h is only
included in pure assembly files.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---
 arch/s390/include/asm/dwarf.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/include/asm/dwarf.h b/arch/s390/include/asm/dwarf.h
index 390906b8e386..fdf51f66a9ed 100644
--- a/arch/s390/include/asm/dwarf.h
+++ b/arch/s390/include/asm/dwarf.h
@@ -2,7 +2,9 @@
 #ifndef _ASM_S390_DWARF_H
 #define _ASM_S390_DWARF_H
 
-#ifdef __ASSEMBLY__
+#ifndef __ASSEMBLY__
+#warning "asm/dwarf.h should be only included in pure assembly files"
+#endif
 
 #define CFI_STARTPROC		.cfi_startproc
 #define CFI_ENDPROC		.cfi_endproc
@@ -33,6 +35,4 @@
 	.cfi_sections .eh_frame, .debug_frame
 #endif
 
-#endif	/* __ASSEMBLY__ */
-
 #endif	/* _ASM_S390_DWARF_H */
-- 
2.48.1


