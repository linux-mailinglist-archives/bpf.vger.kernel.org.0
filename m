Return-Path: <bpf+bounces-63379-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9B3B06943
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 00:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E678C1AA7ED4
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 22:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AA02C324A;
	Tue, 15 Jul 2025 22:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="M+yxXwxp"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4B72741BC;
	Tue, 15 Jul 2025 22:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752618484; cv=none; b=HQOizST283hsNkTiJeDi0GU7YE2deQ6raycOjHgkv52HGgzM45LAQrErvorENwHdpBCFuQW+G5UhdxMTO68bggoClFrDwC8TsXV3I7QcsXtHR5jj+yqg0gjS2Hcai6PVol6LXW8cTnd2a9mjz5cl+wD+YFgUt+D8WHVlI7Ow0wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752618484; c=relaxed/simple;
	bh=frRssE2mv/R+AgQ3v2TX6ipYZFIgwCN8LsxVYKg4+GI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KEuc7/onK4X8OzBDCZGLADjr0anaPmWL1E3hZN3IMXfHy+tbIOzetPa7SaCVpICqGz8TQnmH9pQZt5ipR1+P9D8wASj4GZ2s2VacsIwcQilIwudVehGVT0B4YzC/Gr/xt8EC3DIEmt8CZUnRmsx/OccDIaRKDJmSv7RhNXOcDp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=M+yxXwxp; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FKXmuc009005;
	Tue, 15 Jul 2025 22:27:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=/NDpp
	uo85M9YXPdhE7Eu91UwGRoAF4bjDfBxCRFvVhU=; b=M+yxXwxpjyrO6Q1ucSTgg
	hP7zyiRDkGA+xMYsZTySwqgn/slbaDv7iNmzDTZ6tZzjF8Ara5MBxR9mOgZLI2ck
	3EygF7kSwYjaKeX56McYIBkXDL05LymkH9BEX7NvKoCpvKtXuqc4uF3mXiMNTk4f
	9cYkaPvbtHWL6v6TRmAHBAj2ylKfUWBql1og6zMI14bhl3dHGg+NB+VaTrDp5Gq5
	utZ/rhXbF6ih8/UwC0bM0A6SmJug+GC+DWcP4xS2gg12rkwQosadoI+cSje3a1/7
	cGYAa9SIgnhnENZtLON6BtYSwhLq4WMHx18oiKHi+/hACu3B+Kv1zgFHWaXP9L++
	Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ujy4qpw5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 22:27:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56FKHTic023762;
	Tue, 15 Jul 2025 22:27:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5akb1t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 22:27:50 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56FMRn6c033852;
	Tue, 15 Jul 2025 22:27:50 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 47ue5akb1d-2;
	Tue, 15 Jul 2025 22:27:50 +0000
From: Yifei Liu <yifei.l.liu@oracle.com>
To: yonghong.song@linux.dev, ast@kernel.org
Cc: yifei.l.liu@oracle.com, bpf@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH linux-6.12.y 2/2] selftests/bpf: Fix build error with llvm 19
Date: Tue, 15 Jul 2025 15:27:21 -0700
Message-ID: <20250715222721.3483220-2-yifei.l.liu@oracle.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250715222721.3483220-1-yifei.l.liu@oracle.com>
References: <20250715222721.3483220-1-yifei.l.liu@oracle.com>
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
X-Proofpoint-ORIG-GUID: NLoJis69D99aNKGZ6dmZjFosTL7vjSla
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDIwOCBTYWx0ZWRfX+GtyoalPyESG wVfbWxt3lFL6hL4RKYmfLCtLEJJwkEl9luIMbMHYZNhayKzYnTG4v54okR7vf9tHmQVLv/J7Zh1 snkLjSa7mMOTc+mhLiOnRG3S/xLw7xdpAglHdtXnfsp1BfFXbPZKdtDhmrrbyZ40unrmk7cuI6b
 dHfAZI2YNKAZ4fdL7E9ZeUZWo8sJHlEClKd8qqE/QhiNt4vSb6zMd+OQ3HoBcD9a3zEBs8nEeVv NHTBrDLyJYSVU2JZ0SLMv5KL6/9gfFpRgyCF+FGwY5VUpzIDf7jL+b7OONtOvBkMQy64bGJi8X5 p+5laLmDkkF+kbg7/SxUWtapmQ/w6FlE3utwSNyFqeojr7AvhyGTN3lV85MlBsiNYgJzPUSWaa3
 evvQA9fKktnrzv18PJ5vSMegAC9UwLFFj/F/eYHf/hkONwqv0EPwUjpbHkb3rK5F8Gthr0Gg
X-Authority-Analysis: v=2.4 cv=Xtr6OUF9 c=1 sm=1 tr=0 ts=6876d5e7 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=6Arr1k8fy0lx9qeTgWMA:9
X-Proofpoint-GUID: NLoJis69D99aNKGZ6dmZjFosTL7vjSla

From: Alexei Starovoitov <ast@kernel.org>

llvm 19 fails to compile arena self test:
CLNG-BPF [test_progs] verifier_arena_large.bpf.o
progs/verifier_arena_large.c:90:24: error: unsupported signed division, please convert to unsigned div/mod.
   90 |                 pg_idx = (pg - base) / PAGE_SIZE;

Though llvm <= 18 and llvm >= 20 don't have this issue,
fix the test to avoid the build error.

Reported-by: Jiri Olsa <olsajiri@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
(cherry picked from commit 608e99f7869e3a6e028c7cba14a896c7797e8746)

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


