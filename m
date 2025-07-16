Return-Path: <bpf+bounces-63481-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C9FB07E56
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 21:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC2CE7B9B33
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 19:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DD22BCF4A;
	Wed, 16 Jul 2025 19:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P2e5PxYT"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D41629A9F9;
	Wed, 16 Jul 2025 19:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752695149; cv=none; b=VesUcSDsnZr2yAYNk5v6HkulzBU8T3M7F61sWSG5kmGL+MwaZ9QJWFFckmPbNl3VF9QtjBWIN0yKfsjVaKzj676j4lpdOEVugWzBaCnEQwZQU2Ww685D0j3gCTKiQ8DfHky4FMpRpyDqEZLmAqemUUfzUcy+9cQqIXirzpqN6IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752695149; c=relaxed/simple;
	bh=NQtTZkIvBOastxLKC5Q7RvR2xUBGdx/wgZ5cQzkQwUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D7VLy9qzM6yLkLg7awrLQoSE2yzRsQ62s/dSrGGd/PkpLEhn0leR0mb7OHdd1x5UOi+xw5baEYM1vPsJMYnCsfPFN5LAMyPMRqCeBlDIjGarmg9ae7Voqyrn3Q4gQhxUVHIREwZo63B0bUN/sRzf6inVLLid50vRPScewN0TWtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P2e5PxYT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GH8vni011103;
	Wed, 16 Jul 2025 19:45:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Y29BVFkUhPv1mwyCA
	qjEKzTRIB2vGX3QxGjiUAJ79EQ=; b=P2e5PxYTrvwsgkrsth0Q1/unCziIwMxNC
	wiJ304oWITvx71U3fJy2ETW3pLE5+UGStt5ZOA9x2KHaPWaUK5Tn4sVU7P+oCNiM
	ICLRcAFHX2Nj7MEeAuMBp+ROhVtyMf6cqieJdBwqlnISwTD07qR1sHpeAn+I6HBg
	CLE7IC31zfmK6bB5lm4clonVaxKdgf1TUDQJaTWiKCU4FfI/BvyW9GKswK/rupvt
	4duQ+IJYVSgx3HF3LBcit2fyv7g2v3Qru3JEaeUjMS4hP7Ve/z2vXNLoBpi7iekW
	FrcbfPl05hSDs7A9bOZHxMlwv9GLjw4e2VV23yrIUDXpRxjkV9vvw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47vdfmt4s0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Jul 2025 19:45:32 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56GIFGqx025987;
	Wed, 16 Jul 2025 19:45:31 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47v31ps2ge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Jul 2025 19:45:30 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56GJjQXq48103814
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 19:45:27 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA4652004B;
	Wed, 16 Jul 2025 19:45:26 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 64E9120040;
	Wed, 16 Jul 2025 19:45:26 +0000 (GMT)
Received: from heavy.lan (unknown [9.87.137.252])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Jul 2025 19:45:26 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>, stable@vger.kernel.org
Subject: [PATCH 1/2] s390/bpf: Fix bpf_arch_text_poke() with new_addr == NULL again
Date: Wed, 16 Jul 2025 21:35:06 +0200
Message-ID: <20250716194524.48109-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250716194524.48109-1-iii@linux.ibm.com>
References: <20250716194524.48109-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: h6PgWwoveQNaYjY_jT_0f6J_WjI8sLSU
X-Authority-Analysis: v=2.4 cv=JOI7s9Kb c=1 sm=1 tr=0 ts=6878015c cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=HvXbtDsurDdKXsHfnjQA:9
X-Proofpoint-ORIG-GUID: h6PgWwoveQNaYjY_jT_0f6J_WjI8sLSU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDE3NCBTYWx0ZWRfX9VcOhuLRTsZR vHEgyXNiHcOZhAzuVt++tEh8uEmTK8zp7PpwWrnmGxZNKmpfkpi5DGLp3UF9nJj5SEV6qLIL301 kcDAlZMURMzvzw9S7ZCBE8piYBpT4h+bgQC3MyXaYsHVpleuoLgGNtYfrinm29Pdc7D2cnyG2dz
 vgspdJh8XLP+hvhWTkHZzfCkLuB461wZrLqMd5VOeQyM8Lh9/7WRz86fI2973jRHj/bZCKGYQOW 28K87dk1icOD6N23XzquLC2EWEajVANe6HerYUZM7Cd+A+fDB5hihnPWCrD59RYeAHQgW2tc3UG tQs6ZM/SlXiSG5pcXziwTgb3y01fLW7JLCf+Q3bh1cLLMYmXSTQVO0Pb4NQoawE9H7ayG07DToE
 LRxoec3JxMaaLJ0MV85bDsQ5BSnzLpZ0rY+V8g34YsMGkZCJMQzW9zDdUTUSO02jXJBfNb2E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_03,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 clxscore=1011 bulkscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0 impostorscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507160174

Commit 7ded842b356d ("s390/bpf: Fix bpf_plt pointer arithmetic") has
accidentally removed the critical piece of commit c730fce7c70c
("s390/bpf: Fix bpf_arch_text_poke() with new_addr == NULL"), causing
intermittent kernel panics in e.g. perf's on_switch() prog to reappear.

Restore the fix and add a comment.

Fixes: 7ded842b356d ("s390/bpf: Fix bpf_plt pointer arithmetic")
Cc: stable@vger.kernel.org
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/net/bpf_jit_comp.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 8bb738f1b1b6..bb17efe29d65 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -576,7 +576,15 @@ static void bpf_jit_plt(struct bpf_plt *plt, void *ret, void *target)
 {
 	memcpy(plt, &bpf_plt, sizeof(*plt));
 	plt->ret = ret;
-	plt->target = target;
+	/*
+	 * (target == NULL) implies that the branch to this PLT entry was
+	 * patched and became a no-op. However, some CPU could have jumped
+	 * to this PLT entry before patching and may be still executing it.
+	 *
+	 * Since the intention in this case is to make the PLT entry a no-op,
+	 * make the target point to the return label instead of NULL.
+	 */
+	plt->target = target ?: ret;
 }
 
 /*
-- 
2.50.1


