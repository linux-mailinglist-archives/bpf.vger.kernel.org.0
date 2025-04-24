Return-Path: <bpf+bounces-56628-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB21A9B4BA
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 18:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D98424A7763
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 16:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786D3289372;
	Thu, 24 Apr 2025 16:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="R86pyqun"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FD027A926
	for <bpf@vger.kernel.org>; Thu, 24 Apr 2025 16:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745513748; cv=none; b=pDm3BfrJCohKvkE2Dkoy8F5CwYsj3+UwZs+HxkA8ZN/p7ZDFr6jXdAPqexTVihoepEuUkzpUdD6l83pnIcr0nCxiXKLCd3NIHPSG1tcoU5/y96yA6Skva41jBxIau9W7Yd3ltQAYzO1D98UZ0JiQUkeXdNz5M1trHat0RsJG1LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745513748; c=relaxed/simple;
	bh=I29QEM5D+uhJU1jAH2RYVumU9HyytmqLry4+rALnsBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z1A+37DA7I8lcNo4KbH11yhmEcLsIKFYIRUCvkRtPNt1PHwy8Gt20zYQtXBiNFfbHlLDFvTl6BDAEofUBadjZJ8aSiTCHvV+zqw9wvOhrYxFItAXk5TRzYTEHtsAURLsLbEKLP+EzDigeCXvXzZSjRirtfR71ayqVHONedeUc3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=R86pyqun; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53OGfMVv010512;
	Thu, 24 Apr 2025 16:55:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=sQHv+Lq9w8/KxD5zE
	THyLGZxxBCLTrEGReLnz+IXPKo=; b=R86pyqunZrNRDAhcWEJR07xO0bmszHp67
	0oWrrKTfSCI6f6bWlXcOk9sDhspkhQ3bPO8GA9CkBOH8aKhNdr56YQfSVfAVUBNF
	EaK6BxNigxu6YYm1Q8kD5qYShk+2fUrRw3NlUOGu4b04uNReEz0zkj0tiAYeUpS6
	ky3r6f0H23Mm0HhERMvd/wVuqT0SGf59d8OfmNqxMMnIPzLyos9Wpkv9W3XCK1C2
	AisKscqcBYyCEeurIIF7/SW0MvY0k056bX2fLBXtCKB+BddttdkA51BZJRpDNJ6G
	b0jpIVHmFHAYcpHDY5YtRiFgoAm5DCSJHefPOoJ940gNeCz9VFyiQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4677sm51nt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 16:55:33 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53OFRX5V005872;
	Thu, 24 Apr 2025 16:55:32 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 466jfxh4yj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 16:55:32 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53OGtSii46530898
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 16:55:28 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 33F5720040;
	Thu, 24 Apr 2025 16:55:28 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 04F5D2004B;
	Thu, 24 Apr 2025 16:55:28 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.155.201.197])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 24 Apr 2025 16:55:27 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 3/3] selftests/bpf: Fix endianness issue in __qspinlock declaration
Date: Thu, 24 Apr 2025 18:41:27 +0200
Message-ID: <20250424165525.154403-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250424165525.154403-1-iii@linux.ibm.com>
References: <20250424165525.154403-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDExNCBTYWx0ZWRfX/4+JKVR1Oxk5 LD1uPUTj+6z1kX/oU8UWmSnx3FemNYTZGO409swwVSYZojDO+/1NUfFHWHXFm5XdhdB/uSgvz8V AGltKquXlIEG1Gt1OiXqNEbamziCcAGftPForU6OjOYgdSWOUKyQOh8/KTjCwyMYAjME08uqr+o
 UDU7x/SE6ed27tF9Sq5ZmfAyHodOsjJRrlDujoF1tuFTSS0Pd7L0Kx7DjA6qGjDtsJ+qhtmD0s1 1NZwgiP3T7JXAuxLiH2hgDOLEsnJxtmwwxpmZCFadznmBJlq9kR+p7EL3/KUQVJEUtqyH2pFeDU TRCAEKgNz5XpPYwZLEOfRhryKOvM1TWwOZFuV2VkU6B531UWmRb1/lZQ7Kp7ZEPYTxO0WC0xe2+
 At/MNB51pWqOZdf3EmjTkKNVjb9hlQg78neLg43hMq+GIzyenJwDzaNbgpuhtoK2lv5rTE3P
X-Proofpoint-GUID: 0hCuzuOARm1icJC9sxAq8f9AQ3dWhv2Z
X-Proofpoint-ORIG-GUID: 0hCuzuOARm1icJC9sxAq8f9AQ3dWhv2Z
X-Authority-Analysis: v=2.4 cv=CcMI5Krl c=1 sm=1 tr=0 ts=680a6d05 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=14Z9VMvTplFf1AX8eLQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-24_07,2025-04-24_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 clxscore=1015 mlxlogscore=957 adultscore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504240114

Copy the big-endian field declarations from qspinlock_types.h,
otherwise some properties won't hold on big-endian systems. For
example, assigning lock->val = 1 should result in lock->locked == 1,
which is not the case there.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 .../selftests/bpf/progs/bpf_arena_spin_lock.h        | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/bpf_arena_spin_lock.h b/tools/testing/selftests/bpf/progs/bpf_arena_spin_lock.h
index 4e29c31c4ef8..d67466c1ff77 100644
--- a/tools/testing/selftests/bpf/progs/bpf_arena_spin_lock.h
+++ b/tools/testing/selftests/bpf/progs/bpf_arena_spin_lock.h
@@ -32,6 +32,7 @@ extern unsigned long CONFIG_NR_CPUS __kconfig;
 struct __qspinlock {
 	union {
 		atomic_t val;
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
 		struct {
 			u8 locked;
 			u8 pending;
@@ -40,6 +41,17 @@ struct __qspinlock {
 			u16 locked_pending;
 			u16 tail;
 		};
+#else
+		struct {
+			u16 tail;
+			u16 locked_pending;
+		};
+		struct {
+			u8 reserved[2];
+			u8 pending;
+			u8 locked;
+		};
+#endif
 	};
 };
 
-- 
2.49.0


