Return-Path: <bpf+bounces-65286-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D21B1F141
	for <lists+bpf@lfdr.de>; Sat,  9 Aug 2025 01:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0056B189868B
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 23:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAD026CE14;
	Fri,  8 Aug 2025 23:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MFwNKQzw"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909A53FE7;
	Fri,  8 Aug 2025 23:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754695213; cv=none; b=Yviw2yGZT//soxDsPKUR2CPmKr2easK9fOlTUN5eUHZCy8AW01KNoGb+ElOTgQ+lIES6iOyTfF5+KXq9VMQEyn9OCehkMrLL+rL9qV5BQSdZeI6su0izGIwuyMcDiNy41wgQz/kmBQZFYpaULXIoqprvf8UKDMzZmYvmArBJJeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754695213; c=relaxed/simple;
	bh=ZsqAtgYcJGXPQ4eKJ9U9BC81ssov6AH9jl4AaSpgN4E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gJHX937LFtHC4/U4aLJyGR9OsX0Fv7cdQl/hY4CIVS0PwFk7Czws59cpfwlG+xudBMECvCNtD43ORG/AGMpYydXkvrC+dSO88tSVq8ZZi1f9RQRtCkA4ETGD47c76QIstvkVwhmoF7K0GtJO0qLEWlBjFpCvGd4H+vSZCWhUS4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MFwNKQzw; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 578I0wUZ007457;
	Fri, 8 Aug 2025 23:20:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=BV2ihhISHRbvFezu1srdeWmP5NTsF
	VRHkc4qweGASWE=; b=MFwNKQzwxPAAJ1CVDlMKOktR+9HKP5jhJ+5NOkhdtYMee
	rPQ5DWcd3lnXlyvvIyq4PU7v2X3tTyLRFJodt9wrciEZp584F/EJdCP8SgVVrK5Q
	rJWr6CW23/okJcStkzsoYFI7bk6wn5BA/+0GhGqZJblKjY4XE87E/CnS54gL1FBQ
	FhyIJruMgipTSXdCA9ZliyXbTIqHXWbHFyTKEINR7LuCY63cmwEPphM1mZTVQPjC
	e4U4pvLpXKzBCUWkQsm+8qqAX4pJXu6Vdv6Iwe4gbM7INfFNFS3fHktbX6Sde8b6
	7MzAHBt94TIV4KKZzZIVfVxHQnFRjj6LkTziVFd3A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpvjybud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Aug 2025 23:20:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 578N7fDC027076;
	Fri, 8 Aug 2025 23:20:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwr9pm8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Aug 2025 23:20:08 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 578NK7w2019341;
	Fri, 8 Aug 2025 23:20:07 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 48bpwr9pkp-1;
	Fri, 08 Aug 2025 23:20:07 +0000
From: Yifei Liu <yifei.l.liu@oracle.com>
To: stable@vger.kernel.org, ast@kernel.org
Cc: yifei.l.liu@oracle.com, bpf@vger.kernel.org
Subject: [PATCH linux-6.12.y 1/2] selftests/bpf: Add a test for arena range tree algorithm
Date: Fri,  8 Aug 2025 16:19:37 -0700
Message-ID: <20250808231938.1762975-1-yifei.l.liu@oracle.com>
X-Mailer: git-send-email 2.46.0
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
X-Proofpoint-ORIG-GUID: AFWCuE_a7PdHR0I4Ku_GLDCDbdyG5z--
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDE4NyBTYWx0ZWRfX9P0MlY9hKdKr
 jPVar4KqAdgkuzK15GFK6HsPY4kT8QRw+8GcqNw7iSmRq8pp8Vhhu42lKFqnH2Li0VJvz/7tFT/
 u5f1PaXVeIDPIFE7D5J4N9u4d6P/RbsZoi8j31cesaW/7iqh4WXs0f+eCLeQjCK3xV0/fbQiJpx
 8STY9Zgu43x2V+yLGC3pZwRt/rIp9N1/g8n8uh3oX1kz+kGLwwnrDTEQ62Au7riEd+dJGPlhgTF
 3HboMVQ+Z89NkGOs25BdeBbgvOMgDymwHCzoCssczo4d6811EyBCffd3eOwzKZyLzGVyuAAR0oO
 1iA3vPnNBcAYBhhVK/JxiHul9WZ6FEy6SvlL6mZExC8A2szmkFxQDVQciTVR5RPE0p/YEI4EUM/
 f4lGfb6yTKQRxcbDUNJ1e/u60Uy4J++Wdcai9NjLZLvLQFSjSf6OKIO6pHTj7I9mpmnOMcYn
X-Authority-Analysis: v=2.4 cv=dobbC0g4 c=1 sm=1 tr=0 ts=68968628 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8
 a=EwfujYzQiyYeUg5ViUcA:9
X-Proofpoint-GUID: AFWCuE_a7PdHR0I4Ku_GLDCDbdyG5z--

From: Alexei Starovoitov <ast@kernel.org>

[ Upstream commit e58358afa84e8e271a296459d35d1715c7572013 ]

Add a test that verifies specific behavior of arena range tree
algorithm and adjust existing big_alloc1 test due to use
of global data in arena.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Link: https://lore.kernel.org/bpf/20241108025616.17625-3-alexei.starovoitov@gmail.com

[Yifei: This commit fixes the failure of verifier_arena_large test over 64k page size kernels.
This commit also introduce some new tests targeting the new feature, arena range tree algorithm,
which is not in linux-6.12.y, I just comment out the test headers so that it would not be run here.
If this feature is introduced later, we can just uncomment those two lines.]
Signed-off-by: Yifei Liu <yifei.l.liu@oracle.com>
---
 .../bpf/progs/verifier_arena_large.c          | 110 +++++++++++++++++-
 1 file changed, 108 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_large.c b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
index 6065f862d964..f318675814c6 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena_large.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
@@ -29,12 +29,12 @@ int big_alloc1(void *ctx)
 	if (!page1)
 		return 1;
 	*page1 = 1;
-	page2 = bpf_arena_alloc_pages(&arena, base + ARENA_SIZE - PAGE_SIZE,
+	page2 = bpf_arena_alloc_pages(&arena, base + ARENA_SIZE - PAGE_SIZE * 2,
 				      1, NUMA_NO_NODE, 0);
 	if (!page2)
 		return 2;
 	*page2 = 2;
-	no_page = bpf_arena_alloc_pages(&arena, base + ARENA_SIZE,
+	no_page = bpf_arena_alloc_pages(&arena, base + ARENA_SIZE - PAGE_SIZE,
 					1, NUMA_NO_NODE, 0);
 	if (no_page)
 		return 3;
@@ -66,4 +66,110 @@ int big_alloc1(void *ctx)
 #endif
 	return 0;
 }
+
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+#define PAGE_CNT 100
+__u8 __arena * __arena page[PAGE_CNT]; /* occupies the first page */
+__u8 __arena *base;
+
+/*
+ * Check that arena's range_tree algorithm allocates pages sequentially
+ * on the first pass and then fills in all gaps on the second pass.
+ */
+__noinline int alloc_pages(int page_cnt, int pages_atonce, bool first_pass,
+		int max_idx, int step)
+{
+	__u8 __arena *pg;
+	int i, pg_idx;
+
+	for (i = 0; i < page_cnt; i++) {
+		pg = bpf_arena_alloc_pages(&arena, NULL, pages_atonce,
+					   NUMA_NO_NODE, 0);
+		if (!pg)
+			return step;
+		pg_idx = (pg - base) / PAGE_SIZE;
+		if (first_pass) {
+			/* Pages must be allocated sequentially */
+			if (pg_idx != i)
+				return step + 100;
+		} else {
+			/* Allocator must fill into gaps */
+			if (pg_idx >= max_idx || (pg_idx & 1))
+				return step + 200;
+		}
+		*pg = pg_idx;
+		page[pg_idx] = pg;
+		cond_break;
+	}
+	return 0;
+}
+
+//SEC("syscall")
+//__success __retval(0)
+int big_alloc2(void *ctx)
+{
+	__u8 __arena *pg;
+	int i, err;
+
+	base = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	if (!base)
+		return 1;
+	bpf_arena_free_pages(&arena, (void __arena *)base, 1);
+
+	err = alloc_pages(PAGE_CNT, 1, true, PAGE_CNT, 2);
+	if (err)
+		return err;
+
+	/* Clear all even pages */
+	for (i = 0; i < PAGE_CNT; i += 2) {
+		pg = page[i];
+		if (*pg != i)
+			return 3;
+		bpf_arena_free_pages(&arena, (void __arena *)pg, 1);
+		page[i] = NULL;
+		cond_break;
+	}
+
+	/* Allocate into freed gaps */
+	err = alloc_pages(PAGE_CNT / 2, 1, false, PAGE_CNT, 4);
+	if (err)
+		return err;
+
+	/* Free pairs of pages */
+	for (i = 0; i < PAGE_CNT; i += 4) {
+		pg = page[i];
+		if (*pg != i)
+			return 5;
+		bpf_arena_free_pages(&arena, (void __arena *)pg, 2);
+		page[i] = NULL;
+		page[i + 1] = NULL;
+		cond_break;
+	}
+
+	/* Allocate 2 pages at a time into freed gaps */
+	err = alloc_pages(PAGE_CNT / 4, 2, false, PAGE_CNT, 6);
+	if (err)
+		return err;
+
+	/* Check pages without freeing */
+	for (i = 0; i < PAGE_CNT; i += 2) {
+		pg = page[i];
+		if (*pg != i)
+			return 7;
+		cond_break;
+	}
+
+	pg = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+
+	if (!pg)
+		return 8;
+	/*
+	 * The first PAGE_CNT pages are occupied. The new page
+	 * must be above.
+	 */
+	if ((pg - base) / PAGE_SIZE < PAGE_CNT)
+		return 9;
+	return 0;
+}
+#endif
 char _license[] SEC("license") = "GPL";
-- 
2.46.0


