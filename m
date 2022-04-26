Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A7E50EDC4
	for <lists+bpf@lfdr.de>; Tue, 26 Apr 2022 02:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbiDZAsy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 25 Apr 2022 20:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240561AbiDZAsu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Apr 2022 20:48:50 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90913255B3
        for <bpf@vger.kernel.org>; Mon, 25 Apr 2022 17:45:45 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23PHP3ID006554
        for <bpf@vger.kernel.org>; Mon, 25 Apr 2022 17:45:45 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fmdgfxyfn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 25 Apr 2022 17:45:45 -0700
Received: from twshared16308.14.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Apr 2022 17:45:43 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 6299218FD8F73; Mon, 25 Apr 2022 17:45:36 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 10/10] selftests/bpf: add libbpf's log fixup logic selftests
Date:   Mon, 25 Apr 2022 17:45:11 -0700
Message-ID: <20220426004511.2691730-11-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220426004511.2691730-1-andrii@kernel.org>
References: <20220426004511.2691730-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: SdHsTSiiqcZyvsywvDOz33s2WhrOxSFX
X-Proofpoint-GUID: SdHsTSiiqcZyvsywvDOz33s2WhrOxSFX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-25_10,2022-04-25_03,2022-02-23_01
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add tests validating that libbpf is indeed patching up BPF verifier log
with CO-RE relocation details. Also test partial and full truncation
scenarios.

This test might be a bit fragile due to changing BPF verifier log
format. If that proves to be frequently breaking, we can simplify tests
or remove the truncation subtests. But for now it seems useful to test
it in those conditions that are otherwise rarely occuring in practice.

Also test CO-RE relo failure in a subprog as that excercises subprogram CO-RE
relocation mapping logic which doesn't work out of the box without extra
relo storage previously done only for gen_loader case.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/prog_tests/log_fixup.c      | 114 ++++++++++++++++++
 .../selftests/bpf/progs/test_log_fixup.c      |  38 ++++++
 tools/testing/selftests/bpf/test_progs.h      |  11 ++
 3 files changed, 163 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/log_fixup.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_log_fixup.c

diff --git a/tools/testing/selftests/bpf/prog_tests/log_fixup.c b/tools/testing/selftests/bpf/prog_tests/log_fixup.c
new file mode 100644
index 000000000000..be3a956cb3a5
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/log_fixup.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+#include <bpf/btf.h>
+
+#include "test_log_fixup.skel.h"
+
+enum trunc_type {
+	TRUNC_NONE,
+	TRUNC_PARTIAL,
+	TRUNC_FULL,
+};
+
+static void bad_core_relo(size_t log_buf_size, enum trunc_type trunc_type)
+{
+	char log_buf[8 * 1024];
+	struct test_log_fixup* skel;
+	int err;
+
+	skel = test_log_fixup__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	bpf_program__set_autoload(skel->progs.bad_relo, true);
+	memset(log_buf, 0, sizeof(log_buf));
+	bpf_program__set_log_buf(skel->progs.bad_relo, log_buf, log_buf_size ?: sizeof(log_buf));
+
+	err = test_log_fixup__load(skel);
+	if (!ASSERT_ERR(err, "load_fail"))
+		goto cleanup;
+
+	ASSERT_HAS_SUBSTR(log_buf,
+			  "0: <invalid CO-RE relocation>\n"
+			  "failed to resolve CO-RE relocation <byte_sz> ",
+			  "log_buf_part1");
+
+	switch (trunc_type) {
+	case TRUNC_NONE:
+		ASSERT_HAS_SUBSTR(log_buf,
+				  "struct task_struct___bad.fake_field (0:1 @ offset 4)\n",
+				  "log_buf_part2");
+		ASSERT_HAS_SUBSTR(log_buf,
+				  "max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0\n",
+				  "log_buf_end");
+		break;
+	case TRUNC_PARTIAL:
+		/* we should get full libbpf message patch */
+		ASSERT_HAS_SUBSTR(log_buf,
+				  "struct task_struct___bad.fake_field (0:1 @ offset 4)\n",
+				  "log_buf_part2");
+		/* we shouldn't get full end of BPF verifier log */
+		ASSERT_NULL(strstr(log_buf, "max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0\n"),
+			    "log_buf_end");
+		break;
+	case TRUNC_FULL:
+		/* we shouldn't get second part of libbpf message patch */
+		ASSERT_NULL(strstr(log_buf, "struct task_struct___bad.fake_field (0:1 @ offset 4)\n"),
+			    "log_buf_part2");
+		/* we shouldn't get full end of BPF verifier log */
+		ASSERT_NULL(strstr(log_buf, "max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0\n"),
+			    "log_buf_end");
+		break;
+	}
+
+	if (env.verbosity > VERBOSE_NONE)
+		printf("LOG:   \n=================\n%s=================\n", log_buf);
+cleanup:
+	test_log_fixup__destroy(skel);
+}
+
+static void bad_core_relo_subprog(void)
+{
+	char log_buf[8 * 1024];
+	struct test_log_fixup* skel;
+	int err;
+
+	skel = test_log_fixup__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	bpf_program__set_autoload(skel->progs.bad_relo_subprog, true);
+	bpf_program__set_log_buf(skel->progs.bad_relo_subprog, log_buf, sizeof(log_buf));
+
+	err = test_log_fixup__load(skel);
+	if (!ASSERT_ERR(err, "load_fail"))
+		goto cleanup;
+
+	/* there should be no prog loading log because we specified per-prog log buf */
+	ASSERT_HAS_SUBSTR(log_buf,
+			  ": <invalid CO-RE relocation>\n"
+			  "failed to resolve CO-RE relocation <byte_off> ",
+			  "log_buf");
+	ASSERT_HAS_SUBSTR(log_buf,
+			  "struct task_struct___bad.fake_field_subprog (0:2 @ offset 8)\n",
+			  "log_buf");
+
+	if (env.verbosity > VERBOSE_NONE)
+		printf("LOG:   \n=================\n%s=================\n", log_buf);
+
+cleanup:
+	test_log_fixup__destroy(skel);
+}
+
+void test_log_fixup(void)
+{
+	if (test__start_subtest("bad_core_relo_trunc_none"))
+		bad_core_relo(0, TRUNC_NONE /* full buf */);
+	if (test__start_subtest("bad_core_relo_trunc_partial"))
+		bad_core_relo(300, TRUNC_PARTIAL /* truncate original log a bit */);
+	if (test__start_subtest("bad_core_relo_trunc_full"))
+		bad_core_relo(250, TRUNC_FULL  /* truncate also libbpf's message patch */);
+	if (test__start_subtest("bad_core_relo_subprog"))
+		bad_core_relo_subprog();
+}
diff --git a/tools/testing/selftests/bpf/progs/test_log_fixup.c b/tools/testing/selftests/bpf/progs/test_log_fixup.c
new file mode 100644
index 000000000000..a78980d897b3
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_log_fixup.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+
+struct task_struct___bad {
+	int pid;
+	int fake_field;
+	void *fake_field_subprog;
+} __attribute__((preserve_access_index));
+
+SEC("?raw_tp/sys_enter")
+int bad_relo(const void *ctx)
+{
+	static struct task_struct___bad *t;
+
+	return bpf_core_field_size(t->fake_field);
+}
+
+static __noinline int bad_subprog(void)
+{
+	static struct task_struct___bad *t;
+
+	/* ugliness below is a field offset relocation */
+	return (void *)&t->fake_field_subprog - (void *)t;
+}
+
+SEC("?raw_tp/sys_enter")
+int bad_relo_subprog(const void *ctx)
+{
+	static struct task_struct___bad *t;
+
+	return bad_subprog() + bpf_core_field_size(t->pid);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index 0a102ce460d6..d3fee3b98888 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -292,6 +292,17 @@ int test__join_cgroup(const char *path);
 	___ok;								\
 })
 
+#define ASSERT_HAS_SUBSTR(str, substr, name) ({				\
+	static int duration = 0;					\
+	const char *___str = str;					\
+	const char *___substr = substr;					\
+	bool ___ok = strstr(___str, ___substr) != NULL;			\
+	CHECK(!___ok, (name),						\
+	      "unexpected %s: '%s' is not a substring of '%s'\n",	\
+	      (name), ___substr, ___str);				\
+	___ok;								\
+})
+
 #define ASSERT_OK(res, name) ({						\
 	static int duration = 0;					\
 	long long ___res = (res);					\
-- 
2.30.2

