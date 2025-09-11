Return-Path: <bpf+bounces-68091-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB64B52A1A
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 09:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98F621C80E58
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 07:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4043F2727E7;
	Thu, 11 Sep 2025 07:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="K5Wl1gtC"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1281D1DE2A7
	for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 07:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757576034; cv=none; b=Qs7zfPSeFsUau6WJCbjjVpKFeEu0k9rClbStMzPq170y8/3Hxj0MRNJnVxxGVwbdFrASNVKnImmtRuSkBEq31CaiCpdIeu1b45uN0lA5QtFrPoARmHGYOxUAyeNmuFSBk/2QU/e3cYazUgPdYL5vSEwrxD5ejgbH4Th82r4yZ28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757576034; c=relaxed/simple;
	bh=kssFl/+EIh7lV8T2lecGQRXqIczGdrogbsdKAaxAud8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AfgbSiKD5sLN7dRIY96ZDf8wZxbvlpHaVTJ7kIg1+GK+EoH7GyYYsL8I0Ubxl+XtQ6faxIzeTFNZz6ASDWNw5V3XPwXak1E73G3rcTQx7XLnwzZWJWNkt4r57ihoYFX7FhlPFRfGZFd2Y6bMSOm5SO/yGN8kX7r0hkluKPDBS58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=K5Wl1gtC; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ALfn3S006481;
	Thu, 11 Sep 2025 07:33:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=tLQLXDj1X0yNlKQUiyz+yx+y5NtsP
	9ktNRgPy4PZlF4=; b=K5Wl1gtCPhf39UGBkJZXPx37cYkpMmaplHwXxN8AexUFZ
	zNtvIjtB3u1lCkXDFqXnZ8IzxlmwzB4PvsHk3EwPGl3O+HggmBYvXR6DG3qogLK4
	2ZgFqo4UpVIZOmmIZGTtUNVr8NmxdPQrrphtg31XGKbKj9jl6GDVjGtv++eOpU97
	sRaaeBRfMUN9SAVKV5eeVuDfuql2YfVsJtBGKKlQw4PSIF4QQp1SkAgfz/o6uTZh
	H7mA5o4y7VRsuNeV3+vuAI/BElZcq060iWB3qEIg49PuxT1R9M6e5ZRICCHq0cb+
	yyZI6dphVwaIl7X52WndbIqRsWiOsc6huSdgu3yEw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4921d1ntw0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 07:33:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58B6ibjT002779;
	Thu, 11 Sep 2025 07:33:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bdjm7gb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 07:33:24 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58B7XMh7039332;
	Thu, 11 Sep 2025 07:33:23 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-62-23.vpn.oracle.com [10.154.62.23])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 490bdjm71c-1;
	Thu, 11 Sep 2025 07:33:23 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
        brauner@kernel.org, bboscaccy@linux.microsoft.com, ameryhung@gmail.com,
        emil@etsalapatis.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next] selftests/bpf: more open-coded gettid syscall cleanup
Date: Thu, 11 Sep 2025 08:33:00 +0100
Message-ID: <20250911073300.463685-1-alan.maguire@oracle.com>
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
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509110066
X-Proofpoint-ORIG-GUID: GMuTSMf6F8Cv3dC_qGuu7cPozQMfMbV4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1MCBTYWx0ZWRfXxthhIZYRBoeN
 yLPrKjA7ktOlxWbvfzeVFjDBnrH1pC50g8QiPi0LZq6zk2ccCs5PmKXemB57S91DlD45hDp8lib
 aOb2aAhXiQvz8Od2Fgi3xDOEtNV24pgLpW5Nbsx9DJJjkjAg+FBeLN/1MFZPvGnP3USSK4ekqkF
 DC4KtY1V/PVaVah0h1sFXte8qPEkBiRFRTlZiHPgmj0sqGzj2puWbMyVb63J1UC7ra8Ja+3LQih
 kf78Y+WHTPB66BdzZPdk0UBNTKvpWSMe+uMYolYis7fFgbLu0Sy079Q67HEClWWVpUwJeqHjsxs
 EU5WYgyM9QH7Gp2MGKS2px7eW4eAZbYTH1uHwsMKkirAxJzjOeTkNesocg/3FsX6s3PkZKUY02Y
 nH5Jme595+BVBIlPe6UwyjR8WLMq3g==
X-Authority-Analysis: v=2.4 cv=d6P1yQjE c=1 sm=1 tr=0 ts=68c27b45 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=jEMQp6iPR3_ZpoY8pOwA:9 cc=ntf
 awl=host:12084
X-Proofpoint-GUID: GMuTSMf6F8Cv3dC_qGuu7cPozQMfMbV4

commit 0e2fb011a0ba ("selftests/bpf: Clean up open-coded gettid syscall invocations")

addressed the issue that older libc may not have a gettid()
function call wrapper for the associated syscall.  A few more
instances have crept into tests, use sys_gettid() instead.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/testing/selftests/bpf/network_helpers.c                 | 2 +-
 tools/testing/selftests/bpf/prog_tests/cgroup_xattr.c         | 2 +-
 tools/testing/selftests/bpf/prog_tests/kernel_flag.c          | 2 +-
 tools/testing/selftests/bpf/prog_tests/task_local_data.h      | 2 +-
 tools/testing/selftests/bpf/prog_tests/test_task_local_data.c | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

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
2.31.1


