Return-Path: <bpf+bounces-76300-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D81FECADE1C
	for <lists+bpf@lfdr.de>; Mon, 08 Dec 2025 18:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 527C9300E020
	for <lists+bpf@lfdr.de>; Mon,  8 Dec 2025 17:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAEC30FC3E;
	Mon,  8 Dec 2025 17:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lLynAJUy"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF132FC024;
	Mon,  8 Dec 2025 17:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765214195; cv=none; b=PRcA9+NX4YKAZv6tnDexo47WY1VL4mEtf5fvR9rkaczQ5GtYdqqqYMI+yQrr1NNb4zB0D9m82BQidoJMdQsgS3NiU1d9k/8VjOxFtIMwMXG9AEUFOgW6LeCDqseuMoxooVRexfVTR0LBs4/bH9vEdVt2FRVfDrHTxnjDSEMAadE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765214195; c=relaxed/simple;
	bh=kaPUe9HEKn8n1z5tXB04hI3rzMgQLA6Ru2FLKn1YNjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rNEVlok+TiYqjNXd8XLi1Qi8DYevuMmL7bUV0fWCBDmryWPBCNiJ2OYpZ4dwMQY9vuL+HojrTm0T62Wf42uQUl4bZ/9Omic6fKnhN1KNm+qjWhVc/cP/jjHmPfl20XIJkiYT3uNS1CTcay5vvgJ701QBsfslgRsr0NwuBLkh1Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lLynAJUy; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B8DhXjQ025527;
	Mon, 8 Dec 2025 17:16:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=0U9VOyhHCvaJ8UWLX
	8BbR5hsyCDcsncf5gTti8J2pdY=; b=lLynAJUyRy83JZMsWEU3xKgLH+9jH33M6
	C2E0+d721IuPHgFA76hFXcC3ItiPsMSa7P7OX/tm8MRMY8qd0BjwkxUtjYeLfucy
	x81bqdQaddtXJuq9fgGzWDVYrVoDpcaHE7tXKm6bKCT81HPoj6lY/TbtaokFhoD5
	1KCpBlUN+aJyNlh1IZl8uDxoL/oIBXmRXxwpONlEyUm3t4VmAsoqRuoZ14+cGxgv
	OIvvzykm+Tv38Jmnakc0/3UqTcxM7NTj6sl0J40oEtwJazUBJx0YPuma30w9vzz1
	gukdiyr+PbvIwnS7WUeEZ2ZuEtJFxDIpw9ekZN1AOCwOsoH6pzapg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc0jrwu8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 17:16:10 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B8HAwxC002860;
	Mon, 8 Dec 2025 17:16:09 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc0jrwu2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 17:16:09 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B8FL51g012443;
	Mon, 8 Dec 2025 17:16:08 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aw0ajpp2r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 17:16:08 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B8HG4R961342090
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Dec 2025 17:16:04 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 101B720043;
	Mon,  8 Dec 2025 17:16:04 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF9752004B;
	Mon,  8 Dec 2025 17:16:03 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Dec 2025 17:16:03 +0000 (GMT)
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
Subject: [RFC PATCH v3 05/17] s390: asm/dwarf.h should only be included in assembly files
Date: Mon,  8 Dec 2025 18:15:47 +0100
Message-ID: <20251208171559.2029709-6-jremus@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Cf8FJbrl c=1 sm=1 tr=0 ts=693707da cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=62EC5onNXgn9lpaB:21 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=AB0lExOjSfRHyy3z6bMA:9
X-Proofpoint-ORIG-GUID: r93HJSv6I2omweIaegMuYo6u9htb3Wwq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAxNiBTYWx0ZWRfXyWlzPRUlSLKh
 mUCPwd40Nke5orPaDQEstZ2e5sl2ihuT7FuLZ33GW9dhyKG8u5MUDcLftmmIsPPnolWZMl4dsri
 Sv6W2ooltOogkGBTOXkTJQZGf/vIq9gJ9/ZgazYUxq2bsVPRJhpPsIIhwZ993CQSfgOyL3zeb+I
 4/IIJCsblTiF8PkOlP6ifOIKz20jHXd2TZn1yzEkyX5U+5fTe/qkzVGbIX10uiSysbonSE+JjC2
 JzESEqMTTiqN6NTexCtUyTcEr58nq++/dOISmQg+38e3xwuOBOjLOAV77z4OhILMQzU30NjXbD7
 YpasAwzGJyhFgfL/Rr0oHtvPZ2beY70C80Ru/DVB9GS8WhFm7GGJiHTq1S0qrsl3Z7xFR4+C7fU
 lTZARm3M6G7oYNobutbBHtv66g52nQ==
X-Proofpoint-GUID: W1MktHLLvwatBYEBFKS3MFifJqO4sc7Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2512060016

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


