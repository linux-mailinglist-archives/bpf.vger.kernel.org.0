Return-Path: <bpf+bounces-68162-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5037CB5395A
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 18:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BCF87BBBE8
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 16:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E00353376;
	Thu, 11 Sep 2025 16:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R9ziZbco"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E362206A9
	for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 16:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757608296; cv=none; b=H9MkpSevMHOhMEFRHHwqK4fgAO556h1w8yJxQjMPDBFROb6E4DDaWN9Cj/iUY+jYKtjhoFReYcUh4KzPXglwQbNl21eTtS+yypJwp5HXNJhkxemVrHkxsy5Lj30PRXhmJCmYra9dda29r6mEv7kgW7tSCez5ZRSdaBojiDEbBog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757608296; c=relaxed/simple;
	bh=X8Ym7EaLzqN23+0UFG5M9DPXuHBHP2XdryvfovS0alM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XqyUiic080QdjoHq3SS02QvfnUEQfAgGUAUY1NKMwODgRIM9uxi8/CqEHVPo4QAbINsH5lFnBPapb7oFn9/QW4iHO59UtlAeVyqJwyIOzpYq6QRkRB4kyARTBKk5fVohauZoOdxsN/QUZFU+6jaLCr7qa6tmWYLwtmj5yovvxbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=R9ziZbco; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BFtwnE019098;
	Thu, 11 Sep 2025 16:31:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=Oq7W1xl/WQOlGbr/qqJFr1GQg04fN
	vCC+4DLOEKvyOk=; b=R9ziZbcoQ0Eoew/pFQa5pumN3+vuQWkGZJ+Fl1Zme8ApZ
	b7S2dnVvC4r9xQIjez5qw7l4cUg92IvqpfzAY5osRtrolfmc6AO/9CfDoo/v+fyn
	rW6hrqGtfwrLG/x6J44nEQi49xyprb9WtU2OKcpMVNTlxat5I4Du2BNqZX4MyZt/
	/bXmtusIrAcdzKflBudtzcrA466keXUBWH0BrEn9RA79gt1CY2wIBdxQHZ4DTzhI
	TCJ0pLuJ32kDVJNZWNrB6tTacqgmL8RzCMAuaoaTZEC7R8k9TLIH0k7SEJBu4C2i
	A5d21WjdtNyzTdwls2qbl0/pA+H7o+pbddi3DNB0Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922x96kgj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 16:31:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58BFtLoG013640;
	Thu, 11 Sep 2025 16:31:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bdcv209-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 16:31:06 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58BGV5ns020404;
	Thu, 11 Sep 2025 16:31:05 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-60-192.vpn.oracle.com [10.154.60.192])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 490bdcv1vf-1;
	Thu, 11 Sep 2025 16:31:05 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
        brauner@kernel.org, bboscaccy@linux.microsoft.com, ameryhung@gmail.com,
        emil@etsalapatis.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 bpf-next] selftests/bpf: more open-coded gettid syscall cleanup
Date: Thu, 11 Sep 2025 17:30:56 +0100
Message-ID: <20250911163056.543071-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_02,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509110147
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE2NiBTYWx0ZWRfX/R53MATzBE23
 6g2ACIZWBqo3ohwyRk/Om8EPo2aUo/r3bqkl4HpzdVE3+8MUb2u9rnC8IIZpl/buYun8BlQyCjt
 lMpm3UevTHMKnGoq1HLwijraFiSCbMYDSQfdyHcnpRjQL3F64BVcqVYnetDyt7NpotteNQ+wzLa
 xF9oWnEDBp88alqK7DwsIBBkphT/g5fpw8dZDFamqg20Uv7sn4wnsHk05UAJvtRX6h8y4IVuKwx
 yZPTqwIFUOjM/MomfL6s+o3vRN2xXvnoD0sJJ6bipPIcqwTkxddMkV4klolvEZNat6oGzdoGUQT
 g38cBHb1haGU+DM/P6I5X6vhNpMyaFfpoFlI0i7cPb3rWdiMXwkgz1EOS71TT52D5AvC4mbXYLR
 OslIehND
X-Proofpoint-GUID: nBsk-vpWZx6-LdS_RA40uz2wWJ0FHo96
X-Proofpoint-ORIG-GUID: nBsk-vpWZx6-LdS_RA40uz2wWJ0FHo96
X-Authority-Analysis: v=2.4 cv=LYY86ifi c=1 sm=1 tr=0 ts=68c2f94b b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=0AllhwCjRtaCXWdvmIsA:9

commit 0e2fb011a0ba ("selftests/bpf: Clean up open-coded gettid syscall invocations")

addressed the issue that older libc may not have a gettid()
function call wrapper for the associated syscall.  A few more
instances have crept into tests, use sys_gettid() instead,
and poison raw gettid() usage to avoid future issues.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/testing/selftests/bpf/bpf_util.h                        | 3 +++
 tools/testing/selftests/bpf/network_helpers.c                 | 2 +-
 tools/testing/selftests/bpf/prog_tests/cgroup_xattr.c         | 2 +-
 tools/testing/selftests/bpf/prog_tests/kernel_flag.c          | 2 +-
 tools/testing/selftests/bpf/prog_tests/task_local_data.h      | 2 +-
 tools/testing/selftests/bpf/prog_tests/test_task_local_data.c | 2 +-
 6 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_util.h b/tools/testing/selftests/bpf/bpf_util.h
index 5f6963a320d7..4bc2d25f33e1 100644
--- a/tools/testing/selftests/bpf/bpf_util.h
+++ b/tools/testing/selftests/bpf/bpf_util.h
@@ -67,6 +67,9 @@ static inline void bpf_strlcpy(char *dst, const char *src, size_t sz)
 #define sys_gettid() syscall(SYS_gettid)
 #endif
 
+/* and poison usage to ensure it does not creep back in. */
+#pragma GCC poison gettid
+
 #ifndef ENOTSUPP
 #define ENOTSUPP 524
 #endif
diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 72b5c174ab3b..cdf7b6641444 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -457,7 +457,7 @@ int append_tid(char *str, size_t sz)
 	if (end + 8 > sz)
 		return -1;
 
-	sprintf(&str[end], "%07d", gettid());
+	sprintf(&str[end], "%07ld", sys_gettid());
 	str[end + 7] = '\0';
 
 	return 0;
diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_xattr.c b/tools/testing/selftests/bpf/prog_tests/cgroup_xattr.c
index e0dd966e4a3e..5ad904e9d15d 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_xattr.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_xattr.c
@@ -44,7 +44,7 @@ static void test_read_cgroup_xattr(void)
 	if (!ASSERT_OK_PTR(skel, "read_cgroupfs_xattr__open_and_load"))
 		goto out;
 
-	skel->bss->target_pid = gettid();
+	skel->bss->target_pid = sys_gettid();
 
 	if (!ASSERT_OK(read_cgroupfs_xattr__attach(skel), "read_cgroupfs_xattr__attach"))
 		goto out;
diff --git a/tools/testing/selftests/bpf/prog_tests/kernel_flag.c b/tools/testing/selftests/bpf/prog_tests/kernel_flag.c
index a133354ac9bc..97b00c7efe94 100644
--- a/tools/testing/selftests/bpf/prog_tests/kernel_flag.c
+++ b/tools/testing/selftests/bpf/prog_tests/kernel_flag.c
@@ -16,7 +16,7 @@ void test_kernel_flag(void)
 	if (!ASSERT_OK_PTR(lsm_skel, "lsm_skel"))
 		return;
 
-	lsm_skel->bss->monitored_tid = gettid();
+	lsm_skel->bss->monitored_tid = sys_gettid();
 
 	ret = test_kernel_flag__attach(lsm_skel);
 	if (!ASSERT_OK(ret, "test_kernel_flag__attach"))
diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_data.h b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
index a408d10c3688..2de38776a2d4 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_local_data.h
+++ b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
@@ -158,7 +158,7 @@ static int __tld_init_data_p(int map_fd)
 	void *data_alloc = NULL;
 	int err, tid_fd = -1;
 
-	tid_fd = syscall(SYS_pidfd_open, gettid(), O_EXCL);
+	tid_fd = syscall(SYS_pidfd_open, sys_gettid(), O_EXCL);
 	if (tid_fd < 0) {
 		err = -errno;
 		goto out;
diff --git a/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c b/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
index 3b5cd2cd89c7..9fd6306b455c 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
@@ -63,7 +63,7 @@ void *test_task_local_data_basic_thread(void *arg)
 	if (!ASSERT_OK_PTR(value2, "tld_get_data"))
 		goto out;
 
-	tid = gettid();
+	tid = sys_gettid();
 
 	*value0 = tid + 0;
 	*value1 = tid + 1;
-- 
2.39.3


