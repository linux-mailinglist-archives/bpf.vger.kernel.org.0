Return-Path: <bpf+bounces-65287-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0314B1F143
	for <lists+bpf@lfdr.de>; Sat,  9 Aug 2025 01:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70489A0230D
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 23:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B8E3FE7;
	Fri,  8 Aug 2025 23:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aiWoJ8Jq"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5E37346F;
	Fri,  8 Aug 2025 23:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754695213; cv=none; b=HDVjZThsVAjJI4R2fj8tXgaqHHXmxjri80PXTch2kihOcX2PcRJTxO9ncZNghVkEi3bB5aN6WFtKRjsE4AUtDcyJzEhrWblsmb/MBcdLmJtJw+DJijuslk77vR/2H/9qHmwecXR+bgT1IdGZxs7EYBE9SDjYSXYHVDFVOoGDsJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754695213; c=relaxed/simple;
	bh=y8XZJDF3N2BnUVsmQZiq3Jpz4RaTF/iykWAGN63haUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CCAZsVe4mu9Zd/tE5okNVLhrmCYDupXJ3zT65MaS0kFGjvbyGqUB06Y6JPeY9lbQ/B30CRPijPCridVzeFbtFwZ5JUGjnqq8bjvPZ/II2u+O2QDZUm7L7RHsjm6U9nXpppdJYIIOcVSkv+dPs1781p3MZFBa1lcq7d72hTgbYZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aiWoJ8Jq; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 578I0t7Q032751;
	Fri, 8 Aug 2025 23:20:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=XG5F5
	kCIGMnX7262PbhEWjgq+ktcGNiebWzoBldI0Ac=; b=aiWoJ8JqCH0shVMNy4eWV
	HYjZ9ynegP+FV+68J3B6o6QadxWs+jDo9Pe6EVsiGkRinUzHu/a8+0tyxz+1pMC7
	BHYizxtSx2HMOVH3luxlmOk9TU/udBHrTU39lPLmBYTkEEW78DCE4ineRP+nEyTJ
	3CPn9ODTTmVLGdR0jxirD31ZjnxTAj8yDriZtMDwJgrdkinNNlQ0iVnhGnLEEpxL
	TfkcGdqV082f+EsGEE4H98RCoZ7ofTwSdAV41eyZaz6dz6DRv37HmelAVv7zXgyK
	6q/dZ9DyhaIc4G6dfSr+Sb7oXj6v9RFVv0UOfSTFKGHbdmsB4tRsV0637Gr8Lw8P
	w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpvh7f5e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Aug 2025 23:20:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 578N6cA9027106;
	Fri, 8 Aug 2025 23:20:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwr9pmq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Aug 2025 23:20:08 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 578NK7w4019341;
	Fri, 8 Aug 2025 23:20:08 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 48bpwr9pkp-2;
	Fri, 08 Aug 2025 23:20:08 +0000
From: Yifei Liu <yifei.l.liu@oracle.com>
To: stable@vger.kernel.org, ast@kernel.org
Cc: yifei.l.liu@oracle.com, bpf@vger.kernel.org
Subject: [PATCH linux-6.12.y 2/2] selftests/bpf: Fix build error with llvm 19
Date: Fri,  8 Aug 2025 16:19:38 -0700
Message-ID: <20250808231938.1762975-2-yifei.l.liu@oracle.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250808231938.1762975-1-yifei.l.liu@oracle.com>
References: <20250808231938.1762975-1-yifei.l.liu@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_08,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508080187
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDE4NyBTYWx0ZWRfXwd6saPea6oK8
 iFPh0QAclsgS7hbDJ1R9Au+APQsmBx22922iuZ+UhPm/QUBvP2Rz4q1ATquK9NPaefusjAj98dX
 FR18z0S4Cy9gX2tUkjDVMK6Iis9wINJ2HcShkrlHbihdUUrWSVkUhaEsuBWQo4Z5BjLFcnAoxTJ
 sj87XMa8cSfeRqjAihQ1vLlNmn75fIcpAI2ek8zFHPsMUECVtic/8p1nD8MNe3lqHEZEBaNBJG9
 kLofJSDJb01nC0BS0VC7Hlhc5SAfrimOjK7dTbcwWdFiqN+heT0dWUacsIQzIgh71XsGspX8wnX
 elNt0cZKrf88tGxGjM7heZFB0kun9XX2/URnowXxgU+vm1sTGK2y6OL3YHsiHCqiVZ1Z0/kktEo
 /niE6GSC3MmUBqwh7slN9VRFI4C/KjqyaJezaYXhiiUp3U3px3YmKJtgt1Wo0dlWfcYxUNGf
X-Proofpoint-ORIG-GUID: rOSp0DPb03QtrmZl6kh2kfkul4MmqHU8
X-Proofpoint-GUID: rOSp0DPb03QtrmZl6kh2kfkul4MmqHU8
X-Authority-Analysis: v=2.4 cv=Hpl2G1TS c=1 sm=1 tr=0 ts=68968629 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8
 a=6Arr1k8fy0lx9qeTgWMA:9

From: Alexei Starovoitov <ast@kernel.org>

[ Upstream commit 608e99f7869e3a6e028c7cba14a896c7797e8746 ]

llvm 19 fails to compile arena self test:
CLNG-BPF [test_progs] verifier_arena_large.bpf.o
progs/verifier_arena_large.c:90:24: error: unsupported signed division, please convert to unsigned div/mod.
   90 |                 pg_idx = (pg - base) / PAGE_SIZE;

Though llvm <= 18 and llvm >= 20 don't have this issue,
fix the test to avoid the build error.

Reported-by: Jiri Olsa <olsajiri@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>

[Yifei: This fix is necessary to make the selfttest build with llvm19 if
commit e58358afa84e ("selftests/bpf: Add a test for arena range tree algorithm") is backported]
Signed-off-by: Yifei Liu <yifei.l.liu@oracle.com>
---
 tools/testing/selftests/bpf/progs/verifier_arena_large.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_large.c b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
index f318675814c6..758b09a5eb88 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena_large.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
@@ -87,7 +87,7 @@ __noinline int alloc_pages(int page_cnt, int pages_atonce, bool first_pass,
 					   NUMA_NO_NODE, 0);
 		if (!pg)
 			return step;
-		pg_idx = (pg - base) / PAGE_SIZE;
+		pg_idx = (unsigned long) (pg - base) / PAGE_SIZE;
 		if (first_pass) {
 			/* Pages must be allocated sequentially */
 			if (pg_idx != i)
-- 
2.46.0


