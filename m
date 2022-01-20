Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 690B3494731
	for <lists+bpf@lfdr.de>; Thu, 20 Jan 2022 07:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbiATGPA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 20 Jan 2022 01:15:00 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:41136 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1358738AbiATGOl (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 20 Jan 2022 01:14:41 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20K0eJg6025084
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 22:14:40 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dpad40drb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 22:14:40 -0800
Received: from twshared21922.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 19 Jan 2022 22:14:39 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id B5211FBA126E; Wed, 19 Jan 2022 22:14:31 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 3/4] selftests/bpf: switch to new libbpf XDP APIs
Date:   Wed, 19 Jan 2022 22:14:21 -0800
Message-ID: <20220120061422.2710637-4-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220120061422.2710637-1-andrii@kernel.org>
References: <20220120061422.2710637-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: oFtB1nezdJuuLDyxSqcRPLiSZgpTq-ML
X-Proofpoint-ORIG-GUID: oFtB1nezdJuuLDyxSqcRPLiSZgpTq-ML
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-20_02,2022-01-19_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 impostorscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 spamscore=0 clxscore=1015 phishscore=0 malwarescore=0 mlxlogscore=780
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201200031
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Switch to using new bpf_xdp_*() APIs across all selftests. Take
advantage of a more straightforward and user-friendly semantics of
old_prog_fd (0 means "don't care") in few places.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/prog_tests/xdp_attach.c     | 29 +++++++++----------
 .../bpf/prog_tests/xdp_cpumap_attach.c        |  8 ++---
 .../bpf/prog_tests/xdp_devmap_attach.c        |  8 ++---
 .../selftests/bpf/prog_tests/xdp_info.c       | 14 ++++-----
 .../selftests/bpf/prog_tests/xdp_link.c       | 26 ++++++++---------
 .../selftests/bpf/xdp_redirect_multi.c        |  8 ++---
 tools/testing/selftests/bpf/xdping.c          |  4 +--
 7 files changed, 47 insertions(+), 50 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_attach.c b/tools/testing/selftests/bpf/prog_tests/xdp_attach.c
index c6fa390e3aa1..62aa3edda5e6 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_attach.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_attach.c
@@ -11,8 +11,7 @@ void serial_test_xdp_attach(void)
 	const char *file = "./test_xdp.o";
 	struct bpf_prog_info info = {};
 	int err, fd1, fd2, fd3;
-	DECLARE_LIBBPF_OPTS(bpf_xdp_set_link_opts, opts,
-			    .old_fd = -1);
+	LIBBPF_OPTS(bpf_xdp_attach_opts, opts);
 
 	len = sizeof(info);
 
@@ -38,49 +37,47 @@ void serial_test_xdp_attach(void)
 	if (CHECK_FAIL(err))
 		goto out_2;
 
-	err = bpf_set_link_xdp_fd_opts(IFINDEX_LO, fd1, XDP_FLAGS_REPLACE,
-				       &opts);
+	err = bpf_xdp_attach(IFINDEX_LO, fd1, XDP_FLAGS_REPLACE, &opts);
 	if (CHECK(err, "load_ok", "initial load failed"))
 		goto out_close;
 
-	err = bpf_get_link_xdp_id(IFINDEX_LO, &id0, 0);
+	err = bpf_xdp_query_id(IFINDEX_LO, 0, &id0);
 	if (CHECK(err || id0 != id1, "id1_check",
 		  "loaded prog id %u != id1 %u, err %d", id0, id1, err))
 		goto out_close;
 
-	err = bpf_set_link_xdp_fd_opts(IFINDEX_LO, fd2, XDP_FLAGS_REPLACE,
-				       &opts);
+	err = bpf_xdp_attach(IFINDEX_LO, fd2, XDP_FLAGS_REPLACE, &opts);
 	if (CHECK(!err, "load_fail", "load with expected id didn't fail"))
 		goto out;
 
-	opts.old_fd = fd1;
-	err = bpf_set_link_xdp_fd_opts(IFINDEX_LO, fd2, 0, &opts);
+	opts.old_prog_fd = fd1;
+	err = bpf_xdp_attach(IFINDEX_LO, fd2, 0, &opts);
 	if (CHECK(err, "replace_ok", "replace valid old_fd failed"))
 		goto out;
-	err = bpf_get_link_xdp_id(IFINDEX_LO, &id0, 0);
+	err = bpf_xdp_query_id(IFINDEX_LO, 0, &id0);
 	if (CHECK(err || id0 != id2, "id2_check",
 		  "loaded prog id %u != id2 %u, err %d", id0, id2, err))
 		goto out_close;
 
-	err = bpf_set_link_xdp_fd_opts(IFINDEX_LO, fd3, 0, &opts);
+	err = bpf_xdp_attach(IFINDEX_LO, fd3, 0, &opts);
 	if (CHECK(!err, "replace_fail", "replace invalid old_fd didn't fail"))
 		goto out;
 
-	err = bpf_set_link_xdp_fd_opts(IFINDEX_LO, -1, 0, &opts);
+	err = bpf_xdp_detach(IFINDEX_LO, 0, &opts);
 	if (CHECK(!err, "remove_fail", "remove invalid old_fd didn't fail"))
 		goto out;
 
-	opts.old_fd = fd2;
-	err = bpf_set_link_xdp_fd_opts(IFINDEX_LO, -1, 0, &opts);
+	opts.old_prog_fd = fd2;
+	err = bpf_xdp_detach(IFINDEX_LO, 0, &opts);
 	if (CHECK(err, "remove_ok", "remove valid old_fd failed"))
 		goto out;
 
-	err = bpf_get_link_xdp_id(IFINDEX_LO, &id0, 0);
+	err = bpf_xdp_query_id(IFINDEX_LO, 0, &id0);
 	if (CHECK(err || id0 != 0, "unload_check",
 		  "loaded prog id %u != 0, err %d", id0, err))
 		goto out_close;
 out:
-	bpf_set_link_xdp_fd(IFINDEX_LO, -1, 0);
+	bpf_xdp_detach(IFINDEX_LO, 0, NULL);
 out_close:
 	bpf_object__close(obj3);
 out_2:
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c b/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c
index fd812bd43600..abe9d9f988ec 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c
@@ -23,11 +23,11 @@ void serial_test_xdp_cpumap_attach(void)
 		return;
 
 	prog_fd = bpf_program__fd(skel->progs.xdp_redir_prog);
-	err = bpf_set_link_xdp_fd(IFINDEX_LO, prog_fd, XDP_FLAGS_SKB_MODE);
+	err = bpf_xdp_attach(IFINDEX_LO, prog_fd, XDP_FLAGS_SKB_MODE, NULL);
 	if (!ASSERT_OK(err, "Generic attach of program with 8-byte CPUMAP"))
 		goto out_close;
 
-	err = bpf_set_link_xdp_fd(IFINDEX_LO, -1, XDP_FLAGS_SKB_MODE);
+	err = bpf_xdp_detach(IFINDEX_LO, XDP_FLAGS_SKB_MODE, NULL);
 	ASSERT_OK(err, "XDP program detach");
 
 	prog_fd = bpf_program__fd(skel->progs.xdp_dummy_cm);
@@ -45,9 +45,9 @@ void serial_test_xdp_cpumap_attach(void)
 	ASSERT_EQ(info.id, val.bpf_prog.id, "Match program id to cpumap entry prog_id");
 
 	/* can not attach BPF_XDP_CPUMAP program to a device */
-	err = bpf_set_link_xdp_fd(IFINDEX_LO, prog_fd, XDP_FLAGS_SKB_MODE);
+	err = bpf_xdp_attach(IFINDEX_LO, prog_fd, XDP_FLAGS_SKB_MODE, NULL);
 	if (!ASSERT_NEQ(err, 0, "Attach of BPF_XDP_CPUMAP program"))
-		bpf_set_link_xdp_fd(IFINDEX_LO, -1, XDP_FLAGS_SKB_MODE);
+		bpf_xdp_detach(IFINDEX_LO, XDP_FLAGS_SKB_MODE, NULL);
 
 	val.qsize = 192;
 	val.bpf_prog.fd = bpf_program__fd(skel->progs.xdp_dummy_prog);
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c b/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c
index 3079d5568f8f..fc1a40c3193b 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c
@@ -25,11 +25,11 @@ static void test_xdp_with_devmap_helpers(void)
 		return;
 
 	dm_fd = bpf_program__fd(skel->progs.xdp_redir_prog);
-	err = bpf_set_link_xdp_fd(IFINDEX_LO, dm_fd, XDP_FLAGS_SKB_MODE);
+	err = bpf_xdp_attach(IFINDEX_LO, dm_fd, XDP_FLAGS_SKB_MODE, NULL);
 	if (!ASSERT_OK(err, "Generic attach of program with 8-byte devmap"))
 		goto out_close;
 
-	err = bpf_set_link_xdp_fd(IFINDEX_LO, -1, XDP_FLAGS_SKB_MODE);
+	err = bpf_xdp_detach(IFINDEX_LO, XDP_FLAGS_SKB_MODE, NULL);
 	ASSERT_OK(err, "XDP program detach");
 
 	dm_fd = bpf_program__fd(skel->progs.xdp_dummy_dm);
@@ -47,9 +47,9 @@ static void test_xdp_with_devmap_helpers(void)
 	ASSERT_EQ(info.id, val.bpf_prog.id, "Match program id to devmap entry prog_id");
 
 	/* can not attach BPF_XDP_DEVMAP program to a device */
-	err = bpf_set_link_xdp_fd(IFINDEX_LO, dm_fd, XDP_FLAGS_SKB_MODE);
+	err = bpf_xdp_attach(IFINDEX_LO, dm_fd, XDP_FLAGS_SKB_MODE, NULL);
 	if (!ASSERT_NEQ(err, 0, "Attach of BPF_XDP_DEVMAP program"))
-		bpf_set_link_xdp_fd(IFINDEX_LO, -1, XDP_FLAGS_SKB_MODE);
+		bpf_xdp_detach(IFINDEX_LO, XDP_FLAGS_SKB_MODE, NULL);
 
 	val.ifindex = 1;
 	val.bpf_prog.fd = bpf_program__fd(skel->progs.xdp_dummy_prog);
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_info.c b/tools/testing/selftests/bpf/prog_tests/xdp_info.c
index abe48e82e1dc..0d01ff6cb91a 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_info.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_info.c
@@ -14,13 +14,13 @@ void serial_test_xdp_info(void)
 
 	/* Get prog_id for XDP_ATTACHED_NONE mode */
 
-	err = bpf_get_link_xdp_id(IFINDEX_LO, &prog_id, 0);
+	err = bpf_xdp_query_id(IFINDEX_LO, 0, &prog_id);
 	if (CHECK(err, "get_xdp_none", "errno=%d\n", errno))
 		return;
 	if (CHECK(prog_id, "prog_id_none", "unexpected prog_id=%u\n", prog_id))
 		return;
 
-	err = bpf_get_link_xdp_id(IFINDEX_LO, &prog_id, XDP_FLAGS_SKB_MODE);
+	err = bpf_xdp_query_id(IFINDEX_LO, XDP_FLAGS_SKB_MODE, &prog_id);
 	if (CHECK(err, "get_xdp_none_skb", "errno=%d\n", errno))
 		return;
 	if (CHECK(prog_id, "prog_id_none_skb", "unexpected prog_id=%u\n",
@@ -37,32 +37,32 @@ void serial_test_xdp_info(void)
 	if (CHECK(err, "get_prog_info", "errno=%d\n", errno))
 		goto out_close;
 
-	err = bpf_set_link_xdp_fd(IFINDEX_LO, prog_fd, XDP_FLAGS_SKB_MODE);
+	err = bpf_xdp_attach(IFINDEX_LO, prog_fd, XDP_FLAGS_SKB_MODE, NULL);
 	if (CHECK(err, "set_xdp_skb", "errno=%d\n", errno))
 		goto out_close;
 
 	/* Get prog_id for single prog mode */
 
-	err = bpf_get_link_xdp_id(IFINDEX_LO, &prog_id, 0);
+	err = bpf_xdp_query_id(IFINDEX_LO, 0, &prog_id);
 	if (CHECK(err, "get_xdp", "errno=%d\n", errno))
 		goto out;
 	if (CHECK(prog_id != info.id, "prog_id", "prog_id not available\n"))
 		goto out;
 
-	err = bpf_get_link_xdp_id(IFINDEX_LO, &prog_id, XDP_FLAGS_SKB_MODE);
+	err = bpf_xdp_query_id(IFINDEX_LO, XDP_FLAGS_SKB_MODE, &prog_id);
 	if (CHECK(err, "get_xdp_skb", "errno=%d\n", errno))
 		goto out;
 	if (CHECK(prog_id != info.id, "prog_id_skb", "prog_id not available\n"))
 		goto out;
 
-	err = bpf_get_link_xdp_id(IFINDEX_LO, &prog_id, XDP_FLAGS_DRV_MODE);
+	err = bpf_xdp_query_id(IFINDEX_LO, XDP_FLAGS_DRV_MODE, &prog_id);
 	if (CHECK(err, "get_xdp_drv", "errno=%d\n", errno))
 		goto out;
 	if (CHECK(prog_id, "prog_id_drv", "unexpected prog_id=%u\n", prog_id))
 		goto out;
 
 out:
-	bpf_set_link_xdp_fd(IFINDEX_LO, -1, 0);
+	bpf_xdp_detach(IFINDEX_LO, 0, NULL);
 out_close:
 	bpf_object__close(obj);
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_link.c b/tools/testing/selftests/bpf/prog_tests/xdp_link.c
index 983ab0b47d30..0c5e4ea8eaae 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_link.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_link.c
@@ -9,8 +9,8 @@
 void serial_test_xdp_link(void)
 {
 	__u32 duration = 0, id1, id2, id0 = 0, prog_fd1, prog_fd2, err;
-	DECLARE_LIBBPF_OPTS(bpf_xdp_set_link_opts, opts, .old_fd = -1);
 	struct test_xdp_link *skel1 = NULL, *skel2 = NULL;
+	LIBBPF_OPTS(bpf_xdp_attach_opts, opts);
 	struct bpf_link_info link_info;
 	struct bpf_prog_info prog_info;
 	struct bpf_link *link;
@@ -40,12 +40,12 @@ void serial_test_xdp_link(void)
 	id2 = prog_info.id;
 
 	/* set initial prog attachment */
-	err = bpf_set_link_xdp_fd_opts(IFINDEX_LO, prog_fd1, XDP_FLAGS_REPLACE, &opts);
+	err = bpf_xdp_attach(IFINDEX_LO, prog_fd1, XDP_FLAGS_REPLACE, &opts);
 	if (CHECK(err, "fd_attach", "initial prog attach failed: %d\n", err))
 		goto cleanup;
 
 	/* validate prog ID */
-	err = bpf_get_link_xdp_id(IFINDEX_LO, &id0, 0);
+	err = bpf_xdp_query_id(IFINDEX_LO, 0, &id0);
 	CHECK(err || id0 != id1, "id1_check",
 	      "loaded prog id %u != id1 %u, err %d", id0, id1, err);
 
@@ -54,14 +54,14 @@ void serial_test_xdp_link(void)
 	if (!ASSERT_ERR_PTR(link, "link_attach_should_fail")) {
 		bpf_link__destroy(link);
 		/* best-effort detach prog */
-		opts.old_fd = prog_fd1;
-		bpf_set_link_xdp_fd_opts(IFINDEX_LO, -1, XDP_FLAGS_REPLACE, &opts);
+		opts.old_prog_fd = prog_fd1;
+		bpf_xdp_detach(IFINDEX_LO, XDP_FLAGS_REPLACE, &opts);
 		goto cleanup;
 	}
 
 	/* detach BPF program */
-	opts.old_fd = prog_fd1;
-	err = bpf_set_link_xdp_fd_opts(IFINDEX_LO, -1, XDP_FLAGS_REPLACE, &opts);
+	opts.old_prog_fd = prog_fd1;
+	err = bpf_xdp_detach(IFINDEX_LO, XDP_FLAGS_REPLACE, &opts);
 	if (CHECK(err, "prog_detach", "failed %d\n", err))
 		goto cleanup;
 
@@ -72,24 +72,24 @@ void serial_test_xdp_link(void)
 	skel1->links.xdp_handler = link;
 
 	/* validate prog ID */
-	err = bpf_get_link_xdp_id(IFINDEX_LO, &id0, 0);
+	err = bpf_xdp_query_id(IFINDEX_LO, 0, &id0);
 	if (CHECK(err || id0 != id1, "id1_check",
 		  "loaded prog id %u != id1 %u, err %d", id0, id1, err))
 		goto cleanup;
 
 	/* BPF prog attach is not allowed to replace BPF link */
-	opts.old_fd = prog_fd1;
-	err = bpf_set_link_xdp_fd_opts(IFINDEX_LO, prog_fd2, XDP_FLAGS_REPLACE, &opts);
+	opts.old_prog_fd = prog_fd1;
+	err = bpf_xdp_attach(IFINDEX_LO, prog_fd2, XDP_FLAGS_REPLACE, &opts);
 	if (CHECK(!err, "prog_attach_fail", "unexpected success\n"))
 		goto cleanup;
 
 	/* Can't force-update when BPF link is active */
-	err = bpf_set_link_xdp_fd(IFINDEX_LO, prog_fd2, 0);
+	err = bpf_xdp_attach(IFINDEX_LO, prog_fd2, 0, NULL);
 	if (CHECK(!err, "prog_update_fail", "unexpected success\n"))
 		goto cleanup;
 
 	/* Can't force-detach when BPF link is active */
-	err = bpf_set_link_xdp_fd(IFINDEX_LO, -1, 0);
+	err = bpf_xdp_detach(IFINDEX_LO, 0, NULL);
 	if (CHECK(!err, "prog_detach_fail", "unexpected success\n"))
 		goto cleanup;
 
@@ -109,7 +109,7 @@ void serial_test_xdp_link(void)
 		goto cleanup;
 	skel2->links.xdp_handler = link;
 
-	err = bpf_get_link_xdp_id(IFINDEX_LO, &id0, 0);
+	err = bpf_xdp_query_id(IFINDEX_LO, 0, &id0);
 	if (CHECK(err || id0 != id2, "id2_check",
 		  "loaded prog id %u != id2 %u, err %d", id0, id1, err))
 		goto cleanup;
diff --git a/tools/testing/selftests/bpf/xdp_redirect_multi.c b/tools/testing/selftests/bpf/xdp_redirect_multi.c
index 51c8224b4ccc..aaedbf4955c3 100644
--- a/tools/testing/selftests/bpf/xdp_redirect_multi.c
+++ b/tools/testing/selftests/bpf/xdp_redirect_multi.c
@@ -32,12 +32,12 @@ static void int_exit(int sig)
 	int i;
 
 	for (i = 0; ifaces[i] > 0; i++) {
-		if (bpf_get_link_xdp_id(ifaces[i], &prog_id, xdp_flags)) {
-			printf("bpf_get_link_xdp_id failed\n");
+		if (bpf_xdp_query_id(ifaces[i], xdp_flags, &prog_id)) {
+			printf("bpf_xdp_query_id failed\n");
 			exit(1);
 		}
 		if (prog_id)
-			bpf_set_link_xdp_fd(ifaces[i], -1, xdp_flags);
+			bpf_xdp_detach(ifaces[i], xdp_flags, NULL);
 	}
 
 	exit(0);
@@ -210,7 +210,7 @@ int main(int argc, char **argv)
 		}
 
 		/* bind prog_fd to each interface */
-		ret = bpf_set_link_xdp_fd(ifindex, prog_fd, xdp_flags);
+		ret = bpf_xdp_attach(ifindex, prog_fd, xdp_flags, NULL);
 		if (ret) {
 			printf("Set xdp fd failed on %d\n", ifindex);
 			goto err_out;
diff --git a/tools/testing/selftests/bpf/xdping.c b/tools/testing/selftests/bpf/xdping.c
index baa870a759a2..c567856fd1bc 100644
--- a/tools/testing/selftests/bpf/xdping.c
+++ b/tools/testing/selftests/bpf/xdping.c
@@ -29,7 +29,7 @@ static __u32 xdp_flags = XDP_FLAGS_UPDATE_IF_NOEXIST;
 
 static void cleanup(int sig)
 {
-	bpf_set_link_xdp_fd(ifindex, -1, xdp_flags);
+	bpf_xdp_detach(ifindex, xdp_flags, NULL);
 	if (sig)
 		exit(1);
 }
@@ -203,7 +203,7 @@ int main(int argc, char **argv)
 
 	printf("XDP setup disrupts network connectivity, hit Ctrl+C to quit\n");
 
-	if (bpf_set_link_xdp_fd(ifindex, prog_fd, xdp_flags) < 0) {
+	if (bpf_xdp_attach(ifindex, prog_fd, xdp_flags, NULL) < 0) {
 		fprintf(stderr, "Link set xdp fd failed for %s\n", ifname);
 		goto done;
 	}
-- 
2.30.2

