Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B9D4A7B60
	for <lists+bpf@lfdr.de>; Wed,  2 Feb 2022 23:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242439AbiBBW7z convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 2 Feb 2022 17:59:55 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48794 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233672AbiBBW7y (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 2 Feb 2022 17:59:54 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 212LX4Mg019015
        for <bpf@vger.kernel.org>; Wed, 2 Feb 2022 14:59:54 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3dybqp8bvc-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 02 Feb 2022 14:59:53 -0800
Received: from twshared1259.42.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Feb 2022 14:59:38 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 53B32103F6E6B; Wed,  2 Feb 2022 14:59:30 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 5/6] selftests/bpf: redo the switch to new libbpf XDP APIs
Date:   Wed, 2 Feb 2022 14:59:15 -0800
Message-ID: <20220202225916.3313522-6-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220202225916.3313522-1-andrii@kernel.org>
References: <20220202225916.3313522-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 3yFZKIm7I0qFWmj1l_Ibf1QsGrF7JfCS
X-Proofpoint-ORIG-GUID: 3yFZKIm7I0qFWmj1l_Ibf1QsGrF7JfCS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-02_11,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 malwarescore=0 mlxlogscore=515 mlxscore=0 impostorscore=0 bulkscore=0
 adultscore=0 phishscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020124
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Switch to using new bpf_xdp_*() APIs across all selftests. Take
advantage of a more straightforward and user-friendly semantics of
old_prog_fd (0 means "don't care") in few places.

This is a redo of 544356524dd6 ("selftests/bpf: switch to new libbpf XDP
APIs"), which was previously reverted to minimize conflicts during bpf
and bpf-next tree merge.

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
index 13aabb3b6cf2..b353e1f3acb5 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c
@@ -24,11 +24,11 @@ void test_xdp_with_cpumap_helpers(void)
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
@@ -46,9 +46,9 @@ void test_xdp_with_cpumap_helpers(void)
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
index 2a784ccd3136..463a72fc3e70 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c
@@ -26,11 +26,11 @@ static void test_xdp_with_devmap_helpers(void)
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
@@ -48,9 +48,9 @@ static void test_xdp_with_devmap_helpers(void)
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
index b2b357f8c74c..3e9d5c5521f0 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_link.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_link.c
@@ -8,9 +8,9 @@
 
 void serial_test_xdp_link(void)
 {
-	DECLARE_LIBBPF_OPTS(bpf_xdp_set_link_opts, opts, .old_fd = -1);
 	struct test_xdp_link *skel1 = NULL, *skel2 = NULL;
 	__u32 id1, id2, id0 = 0, prog_fd1, prog_fd2;
+	LIBBPF_OPTS(bpf_xdp_attach_opts, opts);
 	struct bpf_link_info link_info;
 	struct bpf_prog_info prog_info;
 	struct bpf_link *link;
@@ -41,12 +41,12 @@ void serial_test_xdp_link(void)
 	id2 = prog_info.id;
 
 	/* set initial prog attachment */
-	err = bpf_set_link_xdp_fd_opts(IFINDEX_LO, prog_fd1, XDP_FLAGS_REPLACE, &opts);
+	err = bpf_xdp_attach(IFINDEX_LO, prog_fd1, XDP_FLAGS_REPLACE, &opts);
 	if (!ASSERT_OK(err, "fd_attach"))
 		goto cleanup;
 
 	/* validate prog ID */
-	err = bpf_get_link_xdp_id(IFINDEX_LO, &id0, 0);
+	err = bpf_xdp_query_id(IFINDEX_LO, 0, &id0);
 	if (!ASSERT_OK(err, "id1_check_err") || !ASSERT_EQ(id0, id1, "id1_check_val"))
 		goto cleanup;
 
@@ -55,14 +55,14 @@ void serial_test_xdp_link(void)
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
 	if (!ASSERT_OK(err, "prog_detach"))
 		goto cleanup;
 
@@ -73,23 +73,23 @@ void serial_test_xdp_link(void)
 	skel1->links.xdp_handler = link;
 
 	/* validate prog ID */
-	err = bpf_get_link_xdp_id(IFINDEX_LO, &id0, 0);
+	err = bpf_xdp_query_id(IFINDEX_LO, 0, &id0);
 	if (!ASSERT_OK(err, "id1_check_err") || !ASSERT_EQ(id0, id1, "id1_check_val"))
 		goto cleanup;
 
 	/* BPF prog attach is not allowed to replace BPF link */
-	opts.old_fd = prog_fd1;
-	err = bpf_set_link_xdp_fd_opts(IFINDEX_LO, prog_fd2, XDP_FLAGS_REPLACE, &opts);
+	opts.old_prog_fd = prog_fd1;
+	err = bpf_xdp_attach(IFINDEX_LO, prog_fd2, XDP_FLAGS_REPLACE, &opts);
 	if (!ASSERT_ERR(err, "prog_attach_fail"))
 		goto cleanup;
 
 	/* Can't force-update when BPF link is active */
-	err = bpf_set_link_xdp_fd(IFINDEX_LO, prog_fd2, 0);
+	err = bpf_xdp_attach(IFINDEX_LO, prog_fd2, 0, NULL);
 	if (!ASSERT_ERR(err, "prog_update_fail"))
 		goto cleanup;
 
 	/* Can't force-detach when BPF link is active */
-	err = bpf_set_link_xdp_fd(IFINDEX_LO, -1, 0);
+	err = bpf_xdp_detach(IFINDEX_LO, 0, NULL);
 	if (!ASSERT_ERR(err, "prog_detach_fail"))
 		goto cleanup;
 
@@ -109,7 +109,7 @@ void serial_test_xdp_link(void)
 		goto cleanup;
 	skel2->links.xdp_handler = link;
 
-	err = bpf_get_link_xdp_id(IFINDEX_LO, &id0, 0);
+	err = bpf_xdp_query_id(IFINDEX_LO, 0, &id0);
 	if (!ASSERT_OK(err, "id2_check_err") || !ASSERT_EQ(id0, id2, "id2_check_val"))
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

