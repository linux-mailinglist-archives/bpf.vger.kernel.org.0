Return-Path: <bpf+bounces-76159-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E00F1CA8A38
	for <lists+bpf@lfdr.de>; Fri, 05 Dec 2025 18:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FAAA3046FAC
	for <lists+bpf@lfdr.de>; Fri,  5 Dec 2025 17:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB1135293A;
	Fri,  5 Dec 2025 17:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UVy29g8P"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4954734F476;
	Fri,  5 Dec 2025 17:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764954944; cv=none; b=qwJs9k7JEXqr3s2O3fl0+q57C6TOAjq6i4EZmgMh8CZTz+qlrKfe547FdgHZS7xXDIIq/fnuxSK7CZThdbm6U7RCw+7pK8oIPBj2T/9aiR0FuJ2tmieDPzOexyzfsmjdpmFbVKhOr87vmwV3BrzNRoXd3ycSW7qGpm4xBURPeoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764954944; c=relaxed/simple;
	bh=kaPUe9HEKn8n1z5tXB04hI3rzMgQLA6Ru2FLKn1YNjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eeyR8vn46+UkSM+npnLw/wIGIH6eA2XdIRn0+5DcM7ZO4ON/UeXKeJXNPIP6NusmIkeMnNqZfALz08OJKDvitI3kt1GK2xE7TTVGBscan1Y9DhYHXOwIe7+YfhcpYqLyhZdYKJojfvy0n5QjEFMTQ53i4uQDNh3HjXBlpLWl2RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UVy29g8P; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B562uWx013225;
	Fri, 5 Dec 2025 17:14:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=0U9VOyhHCvaJ8UWLX
	8BbR5hsyCDcsncf5gTti8J2pdY=; b=UVy29g8PcS7OpfgGLVEpTLWTS3Kodu8xJ
	1hepYsUMezSP+heBzlNlkgzjBCFlrJsaT+1T0t2MuLHYN3YnfwsdlMrasjorjuxZ
	WitZ7J6bJrGCcPJ9kh3dX6N98glgZdKzrFRE1rdJ31Qyrbv4cd+RWr7/WvgqECcB
	6S2/fpdcC+Nq/AXo9MJxmZslD/ndsbVoM+v98lENVUAbO/gWrEQaWnqMlv7kfxhn
	iLQLa3a3xSx7h0hNrMB5DBLlMMmVkH7r2hN0ZNYF3CofUkyGsynlIg79F4HwASVo
	EIeYeTBFlNo0qUmUYpDbrjg9fHZhLIOWc2LeP3x4ut/SlblNGwq/g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrja6v9d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 17:14:55 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B5H2tBS009862;
	Fri, 5 Dec 2025 17:14:55 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrja6v9a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 17:14:54 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B5FBcKa003864;
	Fri, 5 Dec 2025 17:14:53 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ardck65pp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 17:14:53 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B5HEnTk61866418
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Dec 2025 17:14:50 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C9EB12004F;
	Fri,  5 Dec 2025 17:14:49 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 888FA2004B;
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
Subject: [RFC PATCH v2 04/15] s390: asm/dwarf.h should only be included in assembly files
Date: Fri,  5 Dec 2025 18:14:35 +0100
Message-ID: <20251205171446.2814872-5-jremus@linux.ibm.com>
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
X-Proofpoint-GUID: zFe8HpvCA9VbDdwEXg3Af02nT6U1ypeY
X-Proofpoint-ORIG-GUID: WQQqPZ2nyQxhim56UGojHHGGvWDhM7Ys
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAyMCBTYWx0ZWRfX6U+c3bxo51oh
 wd4gX+tK7MZlKkaW05TX/u5nn1PXxGtdEPOaStAkXNUGmxlNUGk1R0jgvdoSAPeSZUnf7r7xOh9
 aWJM/H5ih0sVawYNolAsZT4NOwY3/AlQOOrymUKi1QvKjFewysL2o1ZDH/pn1nstJlnBfw9Xc0A
 F8soKFH7FbHPRaqK/5f6wjXP9FkTrOLcBE+r/WUpxm+XKaMwVtNve4SXPGD4GZ4c2wTUnpCCejH
 eNpL48NMt+R5dxYeaU+kXcYt06e0Hp9COv2Pdloys3tJ4EhhrnSTpsk7y9Wbrct9oLrk+czY7dq
 4/pnir5b9F9LNZ8BpN6pvhD/70EvJE/J/YDZ7a/tZzQhh4Gs9j6CZNidnERUAJzFmMLdZz8waA7
 0WPuvMYt5S5ZyJTspOMxs862Nv0sIQ==
X-Authority-Analysis: v=2.4 cv=dYGNHHXe c=1 sm=1 tr=0 ts=6933130f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=62EC5onNXgn9lpaB:21 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=AB0lExOjSfRHyy3z6bMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_06,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511290020

Align to x86 and add a compile-time check that asm/dwarf.h is only
included in pure assembly files.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    Changes in RFC v2:
    - Adjust to upstream change of __ASSEMBLY__ to __ASSEMBLER__.

 arch/s390/include/asm/dwarf.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/include/asm/dwarf.h b/arch/s390/include/asm/dwarf.h
index e3ad6798d0cd..df9f467910f7 100644
--- a/arch/s390/include/asm/dwarf.h
+++ b/arch/s390/include/asm/dwarf.h
@@ -2,7 +2,9 @@
 #ifndef _ASM_S390_DWARF_H
 #define _ASM_S390_DWARF_H
 
-#ifdef __ASSEMBLER__
+#ifndef __ASSEMBLER__
+#warning "asm/dwarf.h should be only included in pure assembly files"
+#endif
 
 #define CFI_STARTPROC		.cfi_startproc
 #define CFI_ENDPROC		.cfi_endproc
@@ -33,6 +35,4 @@
 	.cfi_sections .eh_frame, .debug_frame
 #endif
 
-#endif	/* __ASSEMBLER__ */
-
 #endif	/* _ASM_S390_DWARF_H */
-- 
2.51.0


