Return-Path: <bpf+bounces-62942-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E93D6B008F1
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 18:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06047188D1FB
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 16:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3812F1FDC;
	Thu, 10 Jul 2025 16:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kbUC6low"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4782F1989;
	Thu, 10 Jul 2025 16:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752165359; cv=none; b=sJuvOAXU4nP2uPeu0yLqEcKHkZsdMZaeiLwIyFzfw0R9i7CmSxCLxQiV4d6t4lbtzem17Jbut8o8xibAdi47QMgcrn2e7cWMi/qOh3ifSeiboo1KogWwyOXN/ZpL4OrHNQVjzOMgPXXCuFWXohUoEajOZM3KLLE1VBMHjwPk8sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752165359; c=relaxed/simple;
	bh=v2hOjtlwbj3g1hX2d26zeY4TfESRrouASt/PND3A8MY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mm/WKxKNFmCmBvlX6ey5uZ/is1aUbWIqOvXhIGKZIASd5N/AN5o0Tr4W3xFgucwLkfMHqoATqsGWqPb1v1HpZCQVrIArf8F8D2Zg6RB067BA0uFl34gKVzqed9PtyAsgnTytuGPjRHTZ+oF1YRSL0npd++pVZ9aFbUCKDbVVsCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kbUC6low; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56AB7Akr023830;
	Thu, 10 Jul 2025 16:35:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=6gDEz5N4zauu273L0
	4Rm/AckpJgUD1W4BKQOI5obf84=; b=kbUC6lowLPgt64V5myDQcnNPGgZ+53Y2M
	shBCiq92mVC5UVlCr/cUcgRf1DbvS+j+2YrS94eOa0zazYoUaSFCT40MesTdgno0
	pXcvR5YSsApJzKFtZ1hm7fDZq0n08Vj78VODS4jEL8A9DXG8BMFoKGhvk4w4G6WU
	zPukF9I+QIzervtkcs3LtfKcM57sb+dYWnwcLF+0U6699GbItF1NyDm1aCmi/kCq
	gSTNRUmoKSUdElBh+DJ1SYyrYWCFPfPnOHW7nH2OIOnXB64w6w+Rs1yo9vcbKST6
	Fw5HfIMjgS6LCiiNrnbOh3bpOkdqEhVRiNJpqJZqZ0Yuj39upe9zw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ptjrd3ba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 16:35:31 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56ADhsCM010851;
	Thu, 10 Jul 2025 16:35:30 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47qes0eqtf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 16:35:30 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56AGZQ9829622826
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 16:35:26 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C38D020040;
	Thu, 10 Jul 2025 16:35:26 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8848F2004B;
	Thu, 10 Jul 2025 16:35:26 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 10 Jul 2025 16:35:26 +0000 (GMT)
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
Subject: [RFC PATCH v1 09/16] unwind_user/sframe: Enable archs with encoded SFrame CFA offsets
Date: Thu, 10 Jul 2025 18:35:15 +0200
Message-ID: <20250710163522.3195293-10-jremus@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=GL8IEvNK c=1 sm=1 tr=0 ts=686febd3 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=Og4hOgGxDI197znzLmcA:9
X-Proofpoint-ORIG-GUID: eIOvg8Wub475XZyy23-eoHTnvFKsHL4r
X-Proofpoint-GUID: eIOvg8Wub475XZyy23-eoHTnvFKsHL4r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEzOSBTYWx0ZWRfX5HZjNHwLj/gH 9xIzYquVxSacjVxI9K5pMvOcTDYwxkZ96PYItwu+TV91D6xvF0x6WsGW+c1sKfNm2Xz6nnoBMuK sYUPRkyYzgBvadYXY1v3ypFya0H8On2d1irUt5I/PJA+1lVDTtDvmiPfwKGEGWmqABq8Z6E2D/c
 AJ/vhywwZiApok8R6g/RbuWnaiCE4QVbxC6NXIY8P5cIE5402LnchihDMEMwTMXRB33VUafdURc E+cbRhvtFUfSCN62fHIcZOZvyBI7zpo0k7Z4RRlwcMgrbqszQSITqhBoZF9aSGKqnaYGt8ecBRC 6MQz+fRqgzD5rT5E+8CDqkFcfUEGQJQ99/oyS86PGewF32oyJYvPHe4z3mRQnHPhWgboz3w5Nhf
 jiT4wQ4G01odhthsbAwHdwbWMwURgca4AGar2pFDgmvMdgqYCIx5XMi1740dC25qWzTb+4TP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 mlxlogscore=918
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507100139

Enable architectures, such as s390, which store SFrame CFA offset values
encoded, to e.g. make (better) use of unsigned 8-bit SFrame offsets.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---
 include/asm-generic/unwind_user_sframe.h | 11 +++++++++++
 kernel/unwind/sframe.c                   |  1 +
 2 files changed, 12 insertions(+)

diff --git a/include/asm-generic/unwind_user_sframe.h b/include/asm-generic/unwind_user_sframe.h
index 8cef3e0857b6..cea0410a259a 100644
--- a/include/asm-generic/unwind_user_sframe.h
+++ b/include/asm-generic/unwind_user_sframe.h
@@ -5,6 +5,16 @@
 #include <linux/unwind_user_types.h>
 #include <linux/types.h>
 
+/**
+ * generic_sframe_cfa_offset_decode - Decode SFrame CFA offset.
+ *
+ * Returns the decoded SFrame CFA offset value.
+ */
+static inline s32 generic_sframe_cfa_offset_decode(s32 offset)
+{
+	return offset;
+}
+
 /**
  * generic_sframe_set_frame_reginfo - Populate info to unwind FP/RA register
  * from SFrame offset.
@@ -48,6 +58,7 @@ static inline s32 generic_sframe_sp_val_off(void)
 	return 0;
 }
 
+#define sframe_cfa_offset_decode generic_sframe_cfa_offset_decode
 #define sframe_set_frame_reginfo generic_sframe_set_frame_reginfo
 #define sframe_sp_val_off generic_sframe_sp_val_off
 
diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
index 43ef3a8c4c26..e8658401a286 100644
--- a/kernel/unwind/sframe.c
+++ b/kernel/unwind/sframe.c
@@ -220,6 +220,7 @@ static __always_inline int __read_fre(struct sframe_section *sec,
 
 	UNSAFE_GET_USER_INC(cfa_off, cur, offset_size, Efault);
 	offset_count--;
+	cfa_off = sframe_cfa_offset_decode(cfa_off);
 
 	ra_off = sec->ra_off;
 	if (!ra_off && offset_count) {
-- 
2.48.1


