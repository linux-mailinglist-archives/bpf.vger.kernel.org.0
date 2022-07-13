Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACFA572B19
	for <lists+bpf@lfdr.de>; Wed, 13 Jul 2022 03:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiGMBxX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 12 Jul 2022 21:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiGMBxV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 21:53:21 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52067D4BDE
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 18:53:20 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 26CLjfxD024598
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 18:53:19 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3h9h5es1mv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 18:53:19 -0700
Received: from twshared31479.05.prn5.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 12 Jul 2022 18:53:18 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id E44341C4081DC; Tue, 12 Jul 2022 18:53:09 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 2/5] selftests/bpf: add test of __weak unknown virtual __kconfig extern
Date:   Tue, 12 Jul 2022 18:53:01 -0700
Message-ID: <20220713015304.3375777-3-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220713015304.3375777-1-andrii@kernel.org>
References: <20220713015304.3375777-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: -eOV33j4Zd-A7SAW3UyKXf92RV0P-0M3
X-Proofpoint-GUID: -eOV33j4Zd-A7SAW3UyKXf92RV0P-0M3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-12_14,2022-07-12_01,2022-06-22_01
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Exercise libbpf's logic for unknown __weak virtual __kconfig externs.
USDT selftests are already excercising non-weak known virtual extern
already (LINUX_HAS_BPF_COOKIE), so no need to add explicit tests for it.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/prog_tests/core_extern.c      | 17 +++++++----------
 .../selftests/bpf/progs/test_core_extern.c      |  3 +++
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/core_extern.c b/tools/testing/selftests/bpf/prog_tests/core_extern.c
index 1931a158510e..63a51e9f3630 100644
--- a/tools/testing/selftests/bpf/prog_tests/core_extern.c
+++ b/tools/testing/selftests/bpf/prog_tests/core_extern.c
@@ -39,6 +39,7 @@ static struct test_case {
 		       "CONFIG_STR=\"abracad\"\n"
 		       "CONFIG_MISSING=0",
 		.data = {
+			.unkn_virt_val = 0,
 			.bpf_syscall = false,
 			.tristate_val = TRI_MODULE,
 			.bool_val = true,
@@ -121,7 +122,7 @@ static struct test_case {
 void test_core_extern(void)
 {
 	const uint32_t kern_ver = get_kernel_version();
-	int err, duration = 0, i, j;
+	int err, i, j;
 	struct test_core_extern *skel = NULL;
 	uint64_t *got, *exp;
 	int n = sizeof(*skel->data) / sizeof(uint64_t);
@@ -136,19 +137,17 @@ void test_core_extern(void)
 			continue;
 
 		skel = test_core_extern__open_opts(&opts);
-		if (CHECK(!skel, "skel_open", "skeleton open failed\n"))
+		if (!ASSERT_OK_PTR(skel, "skel_open"))
 			goto cleanup;
 		err = test_core_extern__load(skel);
 		if (t->fails) {
-			CHECK(!err, "skel_load",
-			      "shouldn't succeed open/load of skeleton\n");
+			ASSERT_ERR(err, "skel_load_should_fail");
 			goto cleanup;
-		} else if (CHECK(err, "skel_load",
-				 "failed to open/load skeleton\n")) {
+		} else if (!ASSERT_OK(err, "skel_load")) {
 			goto cleanup;
 		}
 		err = test_core_extern__attach(skel);
-		if (CHECK(err, "attach_raw_tp", "failed attach: %d\n", err))
+		if (!ASSERT_OK(err, "attach_raw_tp"))
 			goto cleanup;
 
 		usleep(1);
@@ -158,9 +157,7 @@ void test_core_extern(void)
 		got = (uint64_t *)skel->data;
 		exp = (uint64_t *)&t->data;
 		for (j = 0; j < n; j++) {
-			CHECK(got[j] != exp[j], "check_res",
-			      "result #%d: expected %llx, but got %llx\n",
-			       j, (__u64)exp[j], (__u64)got[j]);
+			ASSERT_EQ(got[j], exp[j], "result");
 		}
 cleanup:
 		test_core_extern__destroy(skel);
diff --git a/tools/testing/selftests/bpf/progs/test_core_extern.c b/tools/testing/selftests/bpf/progs/test_core_extern.c
index 3ac3603ad53d..a3c7c1042f35 100644
--- a/tools/testing/selftests/bpf/progs/test_core_extern.c
+++ b/tools/testing/selftests/bpf/progs/test_core_extern.c
@@ -11,6 +11,7 @@
 static int (*bpf_missing_helper)(const void *arg1, int arg2) = (void *) 999;
 
 extern int LINUX_KERNEL_VERSION __kconfig;
+extern int LINUX_UNKNOWN_VIRTUAL_EXTERN __kconfig __weak;
 extern bool CONFIG_BPF_SYSCALL __kconfig; /* strong */
 extern enum libbpf_tristate CONFIG_TRISTATE __kconfig __weak;
 extern bool CONFIG_BOOL __kconfig __weak;
@@ -22,6 +23,7 @@ extern const char CONFIG_STR[8] __kconfig __weak;
 extern uint64_t CONFIG_MISSING __kconfig __weak;
 
 uint64_t kern_ver = -1;
+uint64_t unkn_virt_val = -1;
 uint64_t bpf_syscall = -1;
 uint64_t tristate_val = -1;
 uint64_t bool_val = -1;
@@ -38,6 +40,7 @@ int handle_sys_enter(struct pt_regs *ctx)
 	int i;
 
 	kern_ver = LINUX_KERNEL_VERSION;
+	unkn_virt_val = LINUX_UNKNOWN_VIRTUAL_EXTERN;
 	bpf_syscall = CONFIG_BPF_SYSCALL;
 	tristate_val = CONFIG_TRISTATE;
 	bool_val = CONFIG_BOOL;
-- 
2.30.2

