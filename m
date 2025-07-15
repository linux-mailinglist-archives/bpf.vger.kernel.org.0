Return-Path: <bpf+bounces-63378-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42934B06941
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 00:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88C8E17A7D3
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 22:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D042C178E;
	Tue, 15 Jul 2025 22:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CCd9qaGU"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4092741BC;
	Tue, 15 Jul 2025 22:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752618479; cv=none; b=GYdk3Zlz/vXo9ZwZUbvzKikXngrtEzG7PNW3Rz5eL6xG5o7Wzzc6oZcZvSXE/lHry7w8IeXp2VaSRHgv7JQzUsbH5tzOhgjQ5RrHQgrwFgouh4KqGEUkvLWzNE47Wpl6UJPbiL0zCWkQU9sAQb525663z5+mammcD0XnsRuf0A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752618479; c=relaxed/simple;
	bh=ocGQa01go6Kb79d/4JBGL0Wx9SVjLqUNyavQbgjutQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oXt7K7XO2NiilnKTrc3Vj9Eo3e/nPR7TQy2Rl56a51/sYJsrNGN5xjoy3npKNjkbl2SL8MljsUuHFYf4vpcnfmNrfSje+dURQgjxMnslvxD++YW+N1or05NXcLsayGS2FDCoUB/L10Ed0+XxEUZ/kWBo1+/Drqr2t2z+qZVFn9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CCd9qaGU; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FKXgqG019158;
	Tue, 15 Jul 2025 22:27:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=gS+/tuQy976W+RVTHE95eqQhqHkfx
	MKnoasXRQUdi/A=; b=CCd9qaGUWakMmuH+qe6vmOhX1N+Oh41rlrUAqVU788q42
	cgGXazXnhbjDeam0+n4HhLIZgOTqVkaZO3wgcJxjDAWhIYex8xrXY0zZggga2VDS
	KmwPdRlJrwBIuXhzXqvYUWgnXO0hWSxS3ZGKehml8IrE88tBvi0jmIL9E+KlJKSe
	FrQsaZn9848Lrd9Bn6k2uBUXySJQ5eMwpnO6k+KrzoNxqVQUcPVXz9GVfKBMuHls
	w8HwbAyvvJ6Kwf3AmDABK32NDz5DG1knLGmEy1LCp0lH/FlqjnZFN6/zl8OLOAQV
	oCHCCTA1mYJK/zsKse3OdU1hz3v7zPWtU/+1jBnuQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ujr0ypca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 22:27:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56FLJDDJ023939;
	Tue, 15 Jul 2025 22:27:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5akb1n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 22:27:50 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56FMRn6a033852;
	Tue, 15 Jul 2025 22:27:49 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 47ue5akb1d-1;
	Tue, 15 Jul 2025 22:27:49 +0000
From: Yifei Liu <yifei.l.liu@oracle.com>
To: yonghong.song@linux.dev, ast@kernel.org
Cc: yifei.l.liu@oracle.com, bpf@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH linux-6.12.y 1/2] selftests/bpf: Add a test for arena range tree algorithm
Date: Tue, 15 Jul 2025 15:27:20 -0700
Message-ID: <20250715222721.3483220-1-yifei.l.liu@oracle.com>
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
 definitions=2025-07-15_05,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507150207
X-Authority-Analysis: v=2.4 cv=d9T1yQjE c=1 sm=1 tr=0 ts=6876d5e7 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=EwfujYzQiyYeUg5ViUcA:9
X-Proofpoint-ORIG-GUID: jjjHXd8M7urWXTbtXFX7Jiia9FZIedbq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDIwOCBTYWx0ZWRfXxKhmx2KSa29I LZSLALgfx0wYTM9jCqDrsp4h0Ji+4dnLsztuTnKwWMrRt3X6XVRh7/SQgK4rooDN0RkxYudw8nl bCQ1nqwMZvGlIphH0NILOj0dzi8qyuj5dUY+iAab88j++NoAaUZID5FTJkWLlsE7aYJuH98sZXT
 ZoOvdM2wHhpcDqdfFvnCzTXaNhw2g7Pm4bfOlGuDogENdR/fGF5sEGlN8x5Wzjb1V5/GUJmxCeW wlPdwUJOPQTksepIUMQ5+NRapGF/OiSiucV9/XjJQTfTrZpsZaU6PaiIklgCUWYXoMpFySOryqi T/9ZxoklmsnMomh71OjgXD+Pv1FPNF7+8lX1N1D/M2HdSoxvPB5KN3IbVvJIUvoGTzidXyzIwtu
 Djd/JHboNwAlpXS86U85bDdiNvMPPsJFWqYsyWe+BpvcDMAHiWB8LKIJylMS6wmw6Gsi65Ja
X-Proofpoint-GUID: jjjHXd8M7urWXTbtXFX7Jiia9FZIedbq

From: Alexei Starovoitov <ast@kernel.org>

Add a test that verifies specific behavior of arena range tree
algorithm and adjust existing big_alloc1 test due to use
of global data in arena.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Link: https://lore.kernel.org/bpf/20241108025616.17625-3-alexei.starovoitov@gmail.com
(cherry picked from commit e58358afa84e8e271a296459d35d1715c7572013)

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


