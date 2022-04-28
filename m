Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E058512A5C
	for <lists+bpf@lfdr.de>; Thu, 28 Apr 2022 06:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242651AbiD1ETB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 28 Apr 2022 00:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242698AbiD1ES6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Apr 2022 00:18:58 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6862A71A
        for <bpf@vger.kernel.org>; Wed, 27 Apr 2022 21:15:43 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23S49dF6032171
        for <bpf@vger.kernel.org>; Wed, 27 Apr 2022 21:15:43 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fqkncr0ms-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 27 Apr 2022 21:15:43 -0700
Received: from twshared13345.18.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Apr 2022 21:15:40 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id CFBDE192F88DF; Wed, 27 Apr 2022 21:15:32 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 4/4] selftests/bpf: test bpf_map__set_autocreate() and related log fixup logic
Date:   Wed, 27 Apr 2022 21:15:23 -0700
Message-ID: <20220428041523.4089853-5-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220428041523.4089853-1-andrii@kernel.org>
References: <20220428041523.4089853-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: rkTMfX8V9Pr9iJDpT3mtn7Jp42KbUWcs
X-Proofpoint-GUID: rkTMfX8V9Pr9iJDpT3mtn7Jp42KbUWcs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-27_04,2022-04-27_01,2022-02-23_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a subtest that excercises bpf_map__set_autocreate() API and
validates that libbpf properly fixes up BPF verifier log with correct
map information.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/prog_tests/log_fixup.c      | 37 ++++++++++++++++++-
 .../selftests/bpf/progs/test_log_fixup.c      | 26 +++++++++++++
 2 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/log_fixup.c b/tools/testing/selftests/bpf/prog_tests/log_fixup.c
index be3a956cb3a5..f4ffdcabf4e4 100644
--- a/tools/testing/selftests/bpf/prog_tests/log_fixup.c
+++ b/tools/testing/selftests/bpf/prog_tests/log_fixup.c
@@ -85,7 +85,6 @@ static void bad_core_relo_subprog(void)
 	if (!ASSERT_ERR(err, "load_fail"))
 		goto cleanup;
 
-	/* there should be no prog loading log because we specified per-prog log buf */
 	ASSERT_HAS_SUBSTR(log_buf,
 			  ": <invalid CO-RE relocation>\n"
 			  "failed to resolve CO-RE relocation <byte_off> ",
@@ -101,6 +100,40 @@ static void bad_core_relo_subprog(void)
 	test_log_fixup__destroy(skel);
 }
 
+static void missing_map(void)
+{
+	char log_buf[8 * 1024];
+	struct test_log_fixup* skel;
+	int err;
+
+	skel = test_log_fixup__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	bpf_map__set_autocreate(skel->maps.missing_map, false);
+
+	bpf_program__set_autoload(skel->progs.use_missing_map, true);
+	bpf_program__set_log_buf(skel->progs.use_missing_map, log_buf, sizeof(log_buf));
+
+	err = test_log_fixup__load(skel);
+	if (!ASSERT_ERR(err, "load_fail"))
+		goto cleanup;
+
+	ASSERT_TRUE(bpf_map__autocreate(skel->maps.existing_map), "existing_map_autocreate");
+	ASSERT_FALSE(bpf_map__autocreate(skel->maps.missing_map), "missing_map_autocreate");
+
+	ASSERT_HAS_SUBSTR(log_buf,
+			  "8: <invalid BPF map reference>\n"
+			  "BPF map 'missing_map' is referenced but wasn't created\n",
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
@@ -111,4 +144,6 @@ void test_log_fixup(void)
 		bad_core_relo(250, TRUNC_FULL  /* truncate also libbpf's message patch */);
 	if (test__start_subtest("bad_core_relo_subprog"))
 		bad_core_relo_subprog();
+	if (test__start_subtest("missing_map"))
+		missing_map();
 }
diff --git a/tools/testing/selftests/bpf/progs/test_log_fixup.c b/tools/testing/selftests/bpf/progs/test_log_fixup.c
index a78980d897b3..60450cb0e72e 100644
--- a/tools/testing/selftests/bpf/progs/test_log_fixup.c
+++ b/tools/testing/selftests/bpf/progs/test_log_fixup.c
@@ -35,4 +35,30 @@ int bad_relo_subprog(const void *ctx)
 	return bad_subprog() + bpf_core_field_size(t->pid);
 }
 
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, int);
+} existing_map SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, int);
+} missing_map SEC(".maps");
+
+SEC("?raw_tp/sys_enter")
+int use_missing_map(const void *ctx)
+{
+	int zero = 0, *value;
+
+	value = bpf_map_lookup_elem(&existing_map, &zero);
+
+	value = bpf_map_lookup_elem(&missing_map, &zero);
+
+	return value != NULL;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.30.2

