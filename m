Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482626E55B6
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 02:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjDRAWP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 17 Apr 2023 20:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbjDRAWK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Apr 2023 20:22:10 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8E14EE9
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 17:22:08 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 33HLJPr5018711
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 17:22:07 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3q0ehp128w-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 17:22:07 -0700
Received: from twshared25760.37.frc1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 17 Apr 2023 17:22:04 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id E77122E4F3595; Mon, 17 Apr 2023 17:21:57 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 4/6] selftests/bpf: add missing __weak kfunc log fixup test
Date:   Mon, 17 Apr 2023 17:21:46 -0700
Message-ID: <20230418002148.3255690-5-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230418002148.3255690-1-andrii@kernel.org>
References: <20230418002148.3255690-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: nKStm-WMGAgBioxb9eNCpxiX6PZKcvF4
X-Proofpoint-GUID: nKStm-WMGAgBioxb9eNCpxiX6PZKcvF4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_14,2023-04-17_01,2023-02-09_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add test validating that libbpf correctly poisons and reports __weak
unresolved kfuncs in post-processed verifier log.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/prog_tests/log_fixup.c      | 31 +++++++++++++++++++
 .../selftests/bpf/progs/test_log_fixup.c      | 10 ++++++
 2 files changed, 41 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/log_fixup.c b/tools/testing/selftests/bpf/prog_tests/log_fixup.c
index bc27170bdeb0..dba71d98a227 100644
--- a/tools/testing/selftests/bpf/prog_tests/log_fixup.c
+++ b/tools/testing/selftests/bpf/prog_tests/log_fixup.c
@@ -135,6 +135,35 @@ static void missing_map(void)
 	test_log_fixup__destroy(skel);
 }
 
+static void missing_kfunc(void)
+{
+	char log_buf[8 * 1024];
+	struct test_log_fixup* skel;
+	int err;
+
+	skel = test_log_fixup__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	bpf_program__set_autoload(skel->progs.use_missing_kfunc, true);
+	bpf_program__set_log_buf(skel->progs.use_missing_kfunc, log_buf, sizeof(log_buf));
+
+	err = test_log_fixup__load(skel);
+	if (!ASSERT_ERR(err, "load_fail"))
+		goto cleanup;
+
+	ASSERT_HAS_SUBSTR(log_buf,
+			  "0: <invalid kfunc call>\n"
+			  "kfunc 'bpf_nonexistent_kfunc' is referenced but wasn't resolved\n",
+			  "log_buf");
+
+	if (env.verbosity > VERBOSE_NONE)
+		printf("LOG:   \n=================\n%s=================\n", log_buf);
+
+cleanup:
+	test_log_fixup__destroy(skel);
+}
+
 void test_log_fixup(void)
 {
 	if (test__start_subtest("bad_core_relo_trunc_none"))
@@ -147,4 +176,6 @@ void test_log_fixup(void)
 		bad_core_relo_subprog();
 	if (test__start_subtest("missing_map"))
 		missing_map();
+	if (test__start_subtest("missing_kfunc"))
+		missing_kfunc();
 }
diff --git a/tools/testing/selftests/bpf/progs/test_log_fixup.c b/tools/testing/selftests/bpf/progs/test_log_fixup.c
index 60450cb0e72e..1bd48feaaa42 100644
--- a/tools/testing/selftests/bpf/progs/test_log_fixup.c
+++ b/tools/testing/selftests/bpf/progs/test_log_fixup.c
@@ -61,4 +61,14 @@ int use_missing_map(const void *ctx)
 	return value != NULL;
 }
 
+extern int bpf_nonexistent_kfunc(void) __ksym __weak;
+
+SEC("?raw_tp/sys_enter")
+int use_missing_kfunc(const void *ctx)
+{
+	bpf_nonexistent_kfunc();
+
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.34.1

