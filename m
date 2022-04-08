Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05734F9E3F
	for <lists+bpf@lfdr.de>; Fri,  8 Apr 2022 22:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235764AbiDHUg7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 8 Apr 2022 16:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236332AbiDHUg6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Apr 2022 16:36:58 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601CC1066C9
        for <bpf@vger.kernel.org>; Fri,  8 Apr 2022 13:34:53 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 238JaDB1003789
        for <bpf@vger.kernel.org>; Fri, 8 Apr 2022 13:34:52 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3f9tgrw9bq-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 08 Apr 2022 13:34:52 -0700
Received: from twshared20084.04.prn5.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 8 Apr 2022 13:34:51 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id C262316FC5A30; Fri,  8 Apr 2022 13:34:42 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 3/3] selftests/bpf: use target-less SEC() definitions in various tests
Date:   Fri, 8 Apr 2022 13:34:33 -0700
Message-ID: <20220408203433.2988727-4-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220408203433.2988727-1-andrii@kernel.org>
References: <20220408203433.2988727-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 8-GT7rWYP4yDd48dhhnjvt80x3um19gX
X-Proofpoint-ORIG-GUID: 8-GT7rWYP4yDd48dhhnjvt80x3um19gX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-08_08,2022-04-08_01,2022-02-23_01
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add new or modify existing SEC() definitions to be target-less and
validate that libbpf handles such program definitions correctly.

For kprobe/kretprobe we also add explicit test that generic
bpf_program__attach() works in cases when kprobe definition contains
proper target. It wasn't previously tested as selftests code always
explicitly specified the target regardless.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/prog_tests/attach_probe.c   | 10 ++++++++
 .../bpf/prog_tests/kprobe_multi_test.c        | 14 +++++------
 .../selftests/bpf/progs/kprobe_multi.c        | 14 +++++++++++
 .../selftests/bpf/progs/test_attach_probe.c   | 23 ++++++++++++++++---
 .../selftests/bpf/progs/test_module_attach.c  |  2 +-
 5 files changed, 52 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
index c0c6d410751d..08c0601b3e84 100644
--- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
+++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
@@ -55,6 +55,7 @@ void test_attach_probe(void)
 	if (!ASSERT_OK_PTR(skel->bss, "check_bss"))
 		goto cleanup;
 
+	/* manual-attach kprobe/kretprobe */
 	kprobe_link = bpf_program__attach_kprobe(skel->progs.handle_kprobe,
 						 false /* retprobe */,
 						 SYS_NANOSLEEP_KPROBE_NAME);
@@ -69,6 +70,13 @@ void test_attach_probe(void)
 		goto cleanup;
 	skel->links.handle_kretprobe = kretprobe_link;
 
+	/* auto-attachable kprobe and kretprobe */
+	skel->links.handle_kprobe_auto = bpf_program__attach(skel->progs.handle_kprobe_auto);
+	ASSERT_OK_PTR(skel->links.handle_kprobe_auto, "attach_kprobe_auto");
+
+	skel->links.handle_kretprobe_auto = bpf_program__attach(skel->progs.handle_kretprobe_auto);
+	ASSERT_OK_PTR(skel->links.handle_kretprobe_auto, "attach_kretprobe_auto");
+
 	if (!legacy)
 		ASSERT_EQ(uprobe_ref_ctr, 0, "uprobe_ref_ctr_before");
 
@@ -157,7 +165,9 @@ void test_attach_probe(void)
 	trigger_func2();
 
 	ASSERT_EQ(skel->bss->kprobe_res, 1, "check_kprobe_res");
+	ASSERT_EQ(skel->bss->kprobe2_res, 11, "check_kprobe_auto_res");
 	ASSERT_EQ(skel->bss->kretprobe_res, 2, "check_kretprobe_res");
+	ASSERT_EQ(skel->bss->kretprobe2_res, 22, "check_kretprobe_auto_res");
 	ASSERT_EQ(skel->bss->uprobe_res, 3, "check_uprobe_res");
 	ASSERT_EQ(skel->bss->uretprobe_res, 4, "check_uretprobe_res");
 	ASSERT_EQ(skel->bss->uprobe_byname_res, 5, "check_uprobe_byname_res");
diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
index b9876b55fc0c..c56db65d4c15 100644
--- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
@@ -140,14 +140,14 @@ test_attach_api(const char *pattern, struct bpf_kprobe_multi_opts *opts)
 		goto cleanup;
 
 	skel->bss->pid = getpid();
-	link1 = bpf_program__attach_kprobe_multi_opts(skel->progs.test_kprobe,
+	link1 = bpf_program__attach_kprobe_multi_opts(skel->progs.test_kprobe_manual,
 						      pattern, opts);
 	if (!ASSERT_OK_PTR(link1, "bpf_program__attach_kprobe_multi_opts"))
 		goto cleanup;
 
 	if (opts) {
 		opts->retprobe = true;
-		link2 = bpf_program__attach_kprobe_multi_opts(skel->progs.test_kretprobe,
+		link2 = bpf_program__attach_kprobe_multi_opts(skel->progs.test_kretprobe_manual,
 							      pattern, opts);
 		if (!ASSERT_OK_PTR(link2, "bpf_program__attach_kprobe_multi_opts"))
 			goto cleanup;
@@ -232,7 +232,7 @@ static void test_attach_api_fails(void)
 	skel->bss->pid = getpid();
 
 	/* fail_1 - pattern and opts NULL */
-	link = bpf_program__attach_kprobe_multi_opts(skel->progs.test_kprobe,
+	link = bpf_program__attach_kprobe_multi_opts(skel->progs.test_kprobe_manual,
 						     NULL, NULL);
 	if (!ASSERT_ERR_PTR(link, "fail_1"))
 		goto cleanup;
@@ -246,7 +246,7 @@ static void test_attach_api_fails(void)
 	opts.cnt = ARRAY_SIZE(syms);
 	opts.cookies = NULL;
 
-	link = bpf_program__attach_kprobe_multi_opts(skel->progs.test_kprobe,
+	link = bpf_program__attach_kprobe_multi_opts(skel->progs.test_kprobe_manual,
 						     NULL, &opts);
 	if (!ASSERT_ERR_PTR(link, "fail_2"))
 		goto cleanup;
@@ -260,7 +260,7 @@ static void test_attach_api_fails(void)
 	opts.cnt = ARRAY_SIZE(syms);
 	opts.cookies = NULL;
 
-	link = bpf_program__attach_kprobe_multi_opts(skel->progs.test_kprobe,
+	link = bpf_program__attach_kprobe_multi_opts(skel->progs.test_kprobe_manual,
 						     "ksys_*", &opts);
 	if (!ASSERT_ERR_PTR(link, "fail_3"))
 		goto cleanup;
@@ -274,7 +274,7 @@ static void test_attach_api_fails(void)
 	opts.cnt = ARRAY_SIZE(syms);
 	opts.cookies = NULL;
 
-	link = bpf_program__attach_kprobe_multi_opts(skel->progs.test_kprobe,
+	link = bpf_program__attach_kprobe_multi_opts(skel->progs.test_kprobe_manual,
 						     "ksys_*", &opts);
 	if (!ASSERT_ERR_PTR(link, "fail_4"))
 		goto cleanup;
@@ -288,7 +288,7 @@ static void test_attach_api_fails(void)
 	opts.cnt = 0;
 	opts.cookies = cookies;
 
-	link = bpf_program__attach_kprobe_multi_opts(skel->progs.test_kprobe,
+	link = bpf_program__attach_kprobe_multi_opts(skel->progs.test_kprobe_manual,
 						     "ksys_*", &opts);
 	if (!ASSERT_ERR_PTR(link, "fail_5"))
 		goto cleanup;
diff --git a/tools/testing/selftests/bpf/progs/kprobe_multi.c b/tools/testing/selftests/bpf/progs/kprobe_multi.c
index 600be50800f8..93510f4f0f3a 100644
--- a/tools/testing/selftests/bpf/progs/kprobe_multi.c
+++ b/tools/testing/selftests/bpf/progs/kprobe_multi.c
@@ -98,3 +98,17 @@ int test_kretprobe(struct pt_regs *ctx)
 	kprobe_multi_check(ctx, true);
 	return 0;
 }
+
+SEC("kprobe.multi")
+int test_kprobe_manual(struct pt_regs *ctx)
+{
+	kprobe_multi_check(ctx, false);
+	return 0;
+}
+
+SEC("kretprobe.multi")
+int test_kretprobe_manual(struct pt_regs *ctx)
+{
+	kprobe_multi_check(ctx, true);
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/test_attach_probe.c b/tools/testing/selftests/bpf/progs/test_attach_probe.c
index af994d16bb10..ce9acf4db8d2 100644
--- a/tools/testing/selftests/bpf/progs/test_attach_probe.c
+++ b/tools/testing/selftests/bpf/progs/test_attach_probe.c
@@ -5,9 +5,12 @@
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
 
 int kprobe_res = 0;
+int kprobe2_res = 0;
 int kretprobe_res = 0;
+int kretprobe2_res = 0;
 int uprobe_res = 0;
 int uretprobe_res = 0;
 int uprobe_byname_res = 0;
@@ -15,20 +18,34 @@ int uretprobe_byname_res = 0;
 int uprobe_byname2_res = 0;
 int uretprobe_byname2_res = 0;
 
-SEC("kprobe/sys_nanosleep")
+SEC("kprobe")
 int handle_kprobe(struct pt_regs *ctx)
 {
 	kprobe_res = 1;
 	return 0;
 }
 
-SEC("kretprobe/sys_nanosleep")
-int BPF_KRETPROBE(handle_kretprobe)
+SEC("kprobe/" SYS_PREFIX "sys_nanosleep")
+int BPF_KPROBE(handle_kprobe_auto)
+{
+	kprobe2_res = 11;
+	return 0;
+}
+
+SEC("kretprobe")
+int handle_kretprobe(struct pt_regs *ctx)
 {
 	kretprobe_res = 2;
 	return 0;
 }
 
+SEC("kretprobe/" SYS_PREFIX "sys_nanosleep")
+int BPF_KRETPROBE(handle_kretprobe_auto)
+{
+	kretprobe2_res = 22;
+	return 0;
+}
+
 SEC("uprobe")
 int handle_uprobe(struct pt_regs *ctx)
 {
diff --git a/tools/testing/selftests/bpf/progs/test_module_attach.c b/tools/testing/selftests/bpf/progs/test_module_attach.c
index 50ce16d02da7..08628afedb77 100644
--- a/tools/testing/selftests/bpf/progs/test_module_attach.c
+++ b/tools/testing/selftests/bpf/progs/test_module_attach.c
@@ -64,7 +64,7 @@ int BPF_PROG(handle_fentry,
 
 __u32 fentry_manual_read_sz = 0;
 
-SEC("fentry/placeholder")
+SEC("fentry")
 int BPF_PROG(handle_fentry_manual,
 	     struct file *file, struct kobject *kobj,
 	     struct bin_attribute *bin_attr, char *buf, loff_t off, size_t len)
-- 
2.30.2

