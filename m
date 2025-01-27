Return-Path: <bpf+bounces-49886-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 675A1A1DDAE
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 22:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30C5C165000
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 21:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7843D1953A2;
	Mon, 27 Jan 2025 21:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dnnDKoyO"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AFE191F83;
	Mon, 27 Jan 2025 21:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738011772; cv=none; b=KTtsFu0Z4fu7/vMZoXtxg/QXlKm2Ie6u/pUWgd9qaAq5A6/YoCINhnGj/Gw7XbPxPiYA88GUZvyFdBmasCSdtWjrTCt14EfQkF35tEnA0mYEoauzlbMibdSotxxqa8odvv8FlsOtD6QGudi0ti4sdVL/juc9yZUp8VPFdM1mdnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738011772; c=relaxed/simple;
	bh=Jzzaqb9zUmK7inShSCbAHUi05tZQFwdpFhw5CYvjuKc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nJOcA89B48PKa0ZqOnMFf93F4gf6yMunOPAY1NZcyUrlesMPJaP8czXaOt96Z/fO+qKVMg1Ae9kJ+FPKSiLdIy5ptI+eRvoyq7l45cd6fa1+3VxMWHpRoU5QMfph5gvKb4jum2uJXSxLrmcI4D5sVdce5GQOrKkDOBY6okN/Uks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dnnDKoyO; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50RKBncR008472;
	Mon, 27 Jan 2025 21:02:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=0THMBMTpZmDYX33m9G4WC38BU9qZK
	bWjrLhJJpE11H8=; b=dnnDKoyOrBnIotzgalFlQazp2eOiZx4VM7v4y8RrveUnr
	bjH+5RCP+MU8MD1mdIraymcWEvi/QIH5uKi61iOvOs7GFXU1BpAhPKm2Vq+z4Qha
	z2QofOpZpRCbHxTQThG7FYZqp9OxCQPCs7w6LRXxAfv7wSVKJS4ycLg3+tvYQDgH
	98v6e3/QfqQag7Osc3MbX7UfT28Z3cj2l1NRVev807p1Rx0S6qVTDwvlYkDUPcXh
	1LjsjsziS441u2gYSQ4MCuCXSDs+rnCKbB0qlpTiEGmxENpip0hjhjOxHuYms9mT
	bqViShPX+prGP220uNLpiC63arv0GxHhTibNSG+Ig==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44ee6d8hu2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jan 2025 21:02:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50RKAlr1035827;
	Mon, 27 Jan 2025 21:02:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44cpddh2su-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jan 2025 21:02:21 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50RL2LVG013318;
	Mon, 27 Jan 2025 21:02:21 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 44cpddh2s1-1;
	Mon, 27 Jan 2025 21:02:21 +0000
From: Yifei Liu <yifei.l.liu@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, aniel@iogearbox.net,
        leon.hwang@linux.dev
Cc: yifei.l.liu@oracle.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 Linux-6.12.y 1/1] selftests/bpf: Add test to verify tailcall and freplace restrictions
Date: Mon, 27 Jan 2025 13:02:14 -0800
Message-ID: <20250127210214.3802032-1-yifei.l.liu@oracle.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_10,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 phishscore=0 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501270165
X-Proofpoint-GUID: BUoPJ7trE50kUmgJjsJlfpoAgli6Pwnl
X-Proofpoint-ORIG-GUID: BUoPJ7trE50kUmgJjsJlfpoAgli6Pwnl

From: Leon Hwang <leon.hwang@linux.dev>

[ Upstream commit 021611d33e78694f4bd54573093c6fc70a812644 ]

Add a test case to ensure that attaching a tail callee program with an
freplace program fails, and that updating an extended program to a
prog_array map is also prohibited.

This test is designed to prevent the potential infinite loop issue caused
by the combination of tail calls and freplace, ensuring the correct
behavior and stability of the system.

Additionally, fix the broken tailcalls/tailcall_freplace selftest
because an extension prog should not be tailcalled.

cd tools/testing/selftests/bpf; ./test_progs -t tailcalls
337/25  tailcalls/tailcall_freplace:OK
337/26  tailcalls/tailcall_bpf2bpf_freplace:OK
337     tailcalls:OK
Summary: 1/26 PASSED, 0 SKIPPED, 0 FAILED

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
Link: https://lore.kernel.org/r/20241015150207.70264-3-leon.hwang@linux.dev
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
(cherry picked from commit 021611d33e78694f4bd54573093c6fc70a812644)
[Yifei: bpf freplace update is backported by commit 987aa730bad3 ("bpf: Prevent tailcall infinite
loop caused by freplace"). It will cause selftest #336/25 failed. Then backport the selftest commit]
Signed-off-by: Yifei Liu <yifei.l.liu@oracle.com>
---
 .../selftests/bpf/prog_tests/tailcalls.c      | 120 ++++++++++++++++--
 .../testing/selftests/bpf/progs/tc_bpf2bpf.c  |   5 +-
 2 files changed, 109 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
index 21c5a37846ad..40f22454cf05 100644
--- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
+++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
@@ -1496,8 +1496,8 @@ static void test_tailcall_bpf2bpf_hierarchy_3(void)
 	RUN_TESTS(tailcall_bpf2bpf_hierarchy3);
 }
 
-/* test_tailcall_freplace checks that the attached freplace prog is OK to
- * update the prog_array map.
+/* test_tailcall_freplace checks that the freplace prog fails to update the
+ * prog_array map, no matter whether the freplace prog attaches to its target.
  */
 static void test_tailcall_freplace(void)
 {
@@ -1505,7 +1505,7 @@ static void test_tailcall_freplace(void)
 	struct bpf_link *freplace_link = NULL;
 	struct bpf_program *freplace_prog;
 	struct tc_bpf2bpf *tc_skel = NULL;
-	int prog_fd, map_fd;
+	int prog_fd, tc_prog_fd, map_fd;
 	char buff[128] = {};
 	int err, key;
 
@@ -1523,9 +1523,10 @@ static void test_tailcall_freplace(void)
 	if (!ASSERT_OK_PTR(tc_skel, "tc_bpf2bpf__open_and_load"))
 		goto out;
 
-	prog_fd = bpf_program__fd(tc_skel->progs.entry_tc);
+	tc_prog_fd = bpf_program__fd(tc_skel->progs.entry_tc);
 	freplace_prog = freplace_skel->progs.entry_freplace;
-	err = bpf_program__set_attach_target(freplace_prog, prog_fd, "subprog");
+	err = bpf_program__set_attach_target(freplace_prog, tc_prog_fd,
+					     "subprog_tc");
 	if (!ASSERT_OK(err, "set_attach_target"))
 		goto out;
 
@@ -1533,27 +1534,116 @@ static void test_tailcall_freplace(void)
 	if (!ASSERT_OK(err, "tailcall_freplace__load"))
 		goto out;
 
-	freplace_link = bpf_program__attach_freplace(freplace_prog, prog_fd,
-						     "subprog");
+	map_fd = bpf_map__fd(freplace_skel->maps.jmp_table);
+	prog_fd = bpf_program__fd(freplace_prog);
+	key = 0;
+	err = bpf_map_update_elem(map_fd, &key, &prog_fd, BPF_ANY);
+	ASSERT_ERR(err, "update jmp_table failure");
+
+	freplace_link = bpf_program__attach_freplace(freplace_prog, tc_prog_fd,
+						     "subprog_tc");
 	if (!ASSERT_OK_PTR(freplace_link, "attach_freplace"))
 		goto out;
 
-	map_fd = bpf_map__fd(freplace_skel->maps.jmp_table);
-	prog_fd = bpf_program__fd(freplace_prog);
+	err = bpf_map_update_elem(map_fd, &key, &prog_fd, BPF_ANY);
+	ASSERT_ERR(err, "update jmp_table failure");
+
+out:
+	bpf_link__destroy(freplace_link);
+	tailcall_freplace__destroy(freplace_skel);
+	tc_bpf2bpf__destroy(tc_skel);
+}
+
+/* test_tailcall_bpf2bpf_freplace checks the failure that fails to attach a tail
+ * callee prog with freplace prog or fails to update an extended prog to
+ * prog_array map.
+ */
+static void test_tailcall_bpf2bpf_freplace(void)
+{
+	struct tailcall_freplace *freplace_skel = NULL;
+	struct bpf_link *freplace_link = NULL;
+	struct tc_bpf2bpf *tc_skel = NULL;
+	char buff[128] = {};
+	int prog_fd, map_fd;
+	int err, key;
+
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		    .data_in = buff,
+		    .data_size_in = sizeof(buff),
+		    .repeat = 1,
+	);
+
+	tc_skel = tc_bpf2bpf__open_and_load();
+	if (!ASSERT_OK_PTR(tc_skel, "tc_bpf2bpf__open_and_load"))
+		goto out;
+
+	prog_fd = bpf_program__fd(tc_skel->progs.entry_tc);
+	freplace_skel = tailcall_freplace__open();
+	if (!ASSERT_OK_PTR(freplace_skel, "tailcall_freplace__open"))
+		goto out;
+
+	err = bpf_program__set_attach_target(freplace_skel->progs.entry_freplace,
+					     prog_fd, "subprog_tc");
+	if (!ASSERT_OK(err, "set_attach_target"))
+		goto out;
+
+	err = tailcall_freplace__load(freplace_skel);
+	if (!ASSERT_OK(err, "tailcall_freplace__load"))
+		goto out;
+
+	/* OK to attach then detach freplace prog. */
+
+	freplace_link = bpf_program__attach_freplace(freplace_skel->progs.entry_freplace,
+						     prog_fd, "subprog_tc");
+	if (!ASSERT_OK_PTR(freplace_link, "attach_freplace"))
+		goto out;
+
+	err = bpf_link__destroy(freplace_link);
+	if (!ASSERT_OK(err, "destroy link"))
+		goto out;
+
+	/* OK to update prog_array map then delete element from the map. */
+
 	key = 0;
+	map_fd = bpf_map__fd(freplace_skel->maps.jmp_table);
 	err = bpf_map_update_elem(map_fd, &key, &prog_fd, BPF_ANY);
 	if (!ASSERT_OK(err, "update jmp_table"))
 		goto out;
 
-	prog_fd = bpf_program__fd(tc_skel->progs.entry_tc);
-	err = bpf_prog_test_run_opts(prog_fd, &topts);
-	ASSERT_OK(err, "test_run");
-	ASSERT_EQ(topts.retval, 34, "test_run retval");
+	err = bpf_map_delete_elem(map_fd, &key);
+	if (!ASSERT_OK(err, "delete_elem from jmp_table"))
+		goto out;
+
+	/* Fail to attach a tail callee prog with freplace prog. */
+
+	err = bpf_map_update_elem(map_fd, &key, &prog_fd, BPF_ANY);
+	if (!ASSERT_OK(err, "update jmp_table"))
+		goto out;
+
+	freplace_link = bpf_program__attach_freplace(freplace_skel->progs.entry_freplace,
+						     prog_fd, "subprog_tc");
+	if (!ASSERT_ERR_PTR(freplace_link, "attach_freplace failure"))
+		goto out;
+
+	err = bpf_map_delete_elem(map_fd, &key);
+	if (!ASSERT_OK(err, "delete_elem from jmp_table"))
+		goto out;
+
+	/* Fail to update an extended prog to prog_array map. */
+
+	freplace_link = bpf_program__attach_freplace(freplace_skel->progs.entry_freplace,
+						     prog_fd, "subprog_tc");
+	if (!ASSERT_OK_PTR(freplace_link, "attach_freplace"))
+		goto out;
+
+	err = bpf_map_update_elem(map_fd, &key, &prog_fd, BPF_ANY);
+	if (!ASSERT_ERR(err, "update jmp_table failure"))
+		goto out;
 
 out:
 	bpf_link__destroy(freplace_link);
-	tc_bpf2bpf__destroy(tc_skel);
 	tailcall_freplace__destroy(freplace_skel);
+	tc_bpf2bpf__destroy(tc_skel);
 }
 
 void test_tailcalls(void)
@@ -1606,4 +1696,6 @@ void test_tailcalls(void)
 	test_tailcall_bpf2bpf_hierarchy_3();
 	if (test__start_subtest("tailcall_freplace"))
 		test_tailcall_freplace();
+	if (test__start_subtest("tailcall_bpf2bpf_freplace"))
+		test_tailcall_bpf2bpf_freplace();
 }
diff --git a/tools/testing/selftests/bpf/progs/tc_bpf2bpf.c b/tools/testing/selftests/bpf/progs/tc_bpf2bpf.c
index 79f5087dade2..fe6249d99b31 100644
--- a/tools/testing/selftests/bpf/progs/tc_bpf2bpf.c
+++ b/tools/testing/selftests/bpf/progs/tc_bpf2bpf.c
@@ -5,10 +5,11 @@
 #include "bpf_misc.h"
 
 __noinline
-int subprog(struct __sk_buff *skb)
+int subprog_tc(struct __sk_buff *skb)
 {
 	int ret = 1;
 
+	__sink(skb);
 	__sink(ret);
 	/* let verifier know that 'subprog_tc' can change pointers to skb->data */
 	bpf_skb_change_proto(skb, 0, 0);
@@ -18,7 +19,7 @@ int subprog(struct __sk_buff *skb)
 SEC("tc")
 int entry_tc(struct __sk_buff *skb)
 {
-	return subprog(skb);
+	return subprog_tc(skb);
 }
 
 char __license[] SEC("license") = "GPL";
-- 
2.46.0


