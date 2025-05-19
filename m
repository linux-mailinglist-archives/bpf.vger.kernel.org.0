Return-Path: <bpf+bounces-58509-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A06FABCB04
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 00:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 774D81B63F6A
	for <lists+bpf@lfdr.de>; Mon, 19 May 2025 22:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D8421CFF4;
	Mon, 19 May 2025 22:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="anbp183L"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C78217F27
	for <bpf@vger.kernel.org>; Mon, 19 May 2025 22:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747694230; cv=none; b=oEvyLtVn/40mQCnBNujToLVx9guvER8/rvxXH0+dxYwck67KKBPAi9TVxvjwdSsZo8OYdR0zm9BmINCEFSoA9/KKzFHX4lhwua+KZ+PGIqOxfuFTK820DJQBcB+yx1yM+iXVDJtUGAtgS1SPUn0s9yAKAU66aWjnrHwVIc9v0AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747694230; c=relaxed/simple;
	bh=etXA+t7MhliZdD0SvpR01zKcqVfczR9i8YCqrGmDG8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XqoHJHQACNOYoUDkLkQ7nMJEcKuWXjiCNpiheYJmLskhGJ8utqqhLcWPBHpvnv5tzQaPbcQcD4C3pTuDmr4tTTfi8FqQjD87D6rAWj3TOpWDr78cijwIiO16Ro/5p1KX40veajNuUHxbMGXvWFkoZKySlxdPrT0GO4M1bOuwkWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=anbp183L; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54JFQGbt000724;
	Mon, 19 May 2025 22:36:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=q7drTfK2e4Q2W7ElX
	/nzzg+hRAiIBecOEV/bufcsG6A=; b=anbp183LHipKM1NcQQFVsug3KMkbgDmvv
	H1R4GVCOOkcqbebA5BsIElI46sifs7js4RcwXwlxZfEit6ZInOIKDxRhjKE/T++O
	w0sPl5egusefnAhkWUFy+3dVq0LRT2ed+TKXOTeFfWC/2z693zgq+nD5dyCv0PA7
	9g/QITVH992TDPanHFityv9HqBvV4PYy49iVNnkeBZAoJbrHQeZSrl7p4f9tRPaW
	dB1lykpzgIkehxZHNmdepICGCnC/ZwB4LRrFpq3WpfD12NeFIgXcXFdqOnsRmFFS
	f2usu1/++hd2+RaECx/PGAzofHU0XEJIaAKmHKXF7S3d9Hj7lRdlA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46r2qhu8jh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 May 2025 22:36:54 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54JMFUTP002483;
	Mon, 19 May 2025 22:36:53 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46q5snrv3j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 May 2025 22:36:53 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54JManNa26280522
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 22:36:49 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9BBD620130;
	Mon, 19 May 2025 22:36:49 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B5F22012B;
	Mon, 19 May 2025 22:36:49 +0000 (GMT)
Received: from heavy.ibmuc.com (unknown [9.111.59.242])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 19 May 2025 22:36:49 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 1/3] s390: always declare expoline thunks
Date: Mon, 19 May 2025 23:30:04 +0100
Message-ID: <20250519223646.66382-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519223646.66382-1-iii@linux.ibm.com>
References: <20250519223646.66382-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDIxMSBTYWx0ZWRfX9KpQgBHfRpE+ H6IrcUnVENa1PQj5DNgK0VExhCkKz8pNtLF5y3Ny+2IRW0yROfDMfT7ElNtcnswQFqnpyOSk0Ph /2mTNCOYkWwqNXOLU08voyGbQf8fgNDIeQatjbqS17sKiwi3+C/U+k0rcyomxzMUYr0g5T6J0GA
 eG+YbzhxLGmLzlEKTR/37v3dqgnzpVyh7odO2HToYoWvNjxIvwPGlZTKJB2bCxq7G/waD1WkEus 4xzNE1h/qNTEpqOBjcaovYbRAEybbNIBgmV+tBF10OnwBgtDkR9OYiZXmkZGHkilMW21KEW3LBe j8iVNQ+ekn1+wa1IPCBFXAaZ3kRHTHY++oikCBp39V675cysZv53d+BLESN6N+36lBwwDzgEPCo
 BO7SOH/4O1Iae8L5vji6VG+9fO8iWRMFIbYwxEunDphvZeMKQ/b+d0TRCeeBH13+E+JVYQt9
X-Proofpoint-ORIG-GUID: TJIaiQJobpcxgtiruldMd33L8hjEq9P7
X-Proofpoint-GUID: TJIaiQJobpcxgtiruldMd33L8hjEq9P7
X-Authority-Analysis: v=2.4 cv=P406hjAu c=1 sm=1 tr=0 ts=682bb286 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=ChB1wMQ3nHtc0InmXuwA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_09,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 mlxscore=0 adultscore=0 impostorscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=788 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505190211

It would be convenient to use the following pattern in the BPF JIT:

  if (nospec_uses_trampoline())
    emit_call(__s390_indirect_jump_r1);

Unfortunately with CONFIG_EXPOLINE=n the compiler complains about the
missing prototype of __s390_indirect_jump_r1(). One could wrap the
whole "if" statement in an #ifdef, but this clutters the code.

Instead, declare expoline thunk prototypes even when compiling without
expolines. When using the above code structure and compiling without
expolines, references to them are optimized away, and there are no
linker errors.

Acked-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/include/asm/nospec-branch.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/s390/include/asm/nospec-branch.h b/arch/s390/include/asm/nospec-branch.h
index 192835a3e24d..c7c96282f011 100644
--- a/arch/s390/include/asm/nospec-branch.h
+++ b/arch/s390/include/asm/nospec-branch.h
@@ -26,8 +26,6 @@ static inline bool nospec_uses_trampoline(void)
 	return __is_defined(CC_USING_EXPOLINE) && !nospec_disable;
 }
 
-#ifdef CONFIG_EXPOLINE_EXTERN
-
 void __s390_indirect_jump_r1(void);
 void __s390_indirect_jump_r2(void);
 void __s390_indirect_jump_r3(void);
@@ -44,8 +42,6 @@ void __s390_indirect_jump_r13(void);
 void __s390_indirect_jump_r14(void);
 void __s390_indirect_jump_r15(void);
 
-#endif
-
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_S390_EXPOLINE_H */
-- 
2.49.0


