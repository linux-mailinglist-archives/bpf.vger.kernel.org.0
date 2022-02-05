Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEBFA4AA548
	for <lists+bpf@lfdr.de>; Sat,  5 Feb 2022 02:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358009AbiBEB1W convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 4 Feb 2022 20:27:22 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:18150 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S239745AbiBEB1V (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 4 Feb 2022 20:27:21 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 2150pSQi007046
        for <bpf@vger.kernel.org>; Fri, 4 Feb 2022 17:27:21 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3e0utmphug-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 04 Feb 2022 17:27:21 -0800
Received: from twshared3399.25.prn2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 4 Feb 2022 17:27:19 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 7B7881051D314; Fri,  4 Feb 2022 17:27:13 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next 1/1] selftests/bpf: add custom SEC() handling selftest
Date:   Fri, 4 Feb 2022 17:27:03 -0800
Message-ID: <20220205012705.1077708-3-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220205012705.1077708-1-andrii@kernel.org>
References: <20220205012705.1077708-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 0ul7Um5izu34P2npFFhjnOhjp9JczgI1
X-Proofpoint-GUID: 0ul7Um5izu34P2npFFhjnOhjp9JczgI1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-04_07,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 suspectscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 mlxlogscore=999 phishscore=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202050004
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a selftest validating various aspects of libbpf's handling of custom
SEC() handlers. It also demonstrates how libraries can ensure very early
callbacks registration and unregistration using
__attribute__((constructor))/__attribute__((destructor)) functions.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../bpf/prog_tests/custom_sec_handlers.c      | 136 ++++++++++++++++++
 .../bpf/progs/test_custom_sec_handlers.c      |  51 +++++++
 2 files changed, 187 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/custom_sec_handlers.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_custom_sec_handlers.c

diff --git a/tools/testing/selftests/bpf/prog_tests/custom_sec_handlers.c b/tools/testing/selftests/bpf/prog_tests/custom_sec_handlers.c
new file mode 100644
index 000000000000..8e43c5f21878
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/custom_sec_handlers.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Facebook */
+
+#include <test_progs.h>
+#include "test_custom_sec_handlers.skel.h"
+
+#define COOKIE_ABC1 1
+#define COOKIE_ABC2 2
+#define COOKIE_CUSTOM 3
+#define COOKIE_FALLBACK 4
+
+static int custom_init_prog(struct bpf_program *prog, long cookie)
+{
+	if (cookie == COOKIE_ABC1)
+		bpf_program__set_autoload(prog, false);
+
+	return 0;
+}
+
+static int custom_preload_prog(struct bpf_program *prog,
+			       struct bpf_prog_load_opts *opts, long cookie)
+{
+	return 0;
+}
+
+static int custom_attach_prog(const struct bpf_program *prog, long cookie,
+			      struct bpf_link **link)
+{
+	switch (cookie) {
+	case COOKIE_ABC2:
+		*link = bpf_program__attach_raw_tracepoint(prog, "sys_enter");
+		return libbpf_get_error(*link);
+	case COOKIE_CUSTOM:
+		*link = bpf_program__attach_tracepoint(prog, "syscalls", "sys_enter_nanosleep");
+		return libbpf_get_error(*link);
+	case COOKIE_FALLBACK:
+		/* no auto-attach for SEC("xyz") */
+		*link = NULL;
+		return 0;
+	default:
+		ASSERT_FALSE(true, "unexpected cookie");
+		return -EINVAL;
+	}
+}
+
+static int abc1_id;
+static int abc2_id;
+static int custom_id;
+static int fallback_id;
+
+__attribute__((constructor))
+static void register_sec_handlers(void)
+{
+	abc1_id = libbpf_register_prog_handler("abc",
+					       BPF_PROG_TYPE_RAW_TRACEPOINT, 0,
+					       custom_init_prog, custom_preload_prog,
+					       custom_attach_prog,
+					       COOKIE_ABC1, NULL);
+	abc2_id = libbpf_register_prog_handler("abc/",
+					       BPF_PROG_TYPE_RAW_TRACEPOINT, 0,
+					       custom_init_prog, custom_preload_prog,
+					       custom_attach_prog,
+					       COOKIE_ABC2, NULL);
+	custom_id = libbpf_register_prog_handler("custom+",
+						 BPF_PROG_TYPE_TRACEPOINT, 0,
+						 custom_init_prog, custom_preload_prog,
+						 custom_attach_prog,
+						 COOKIE_CUSTOM, NULL);
+}
+
+__attribute__((destructor))
+static void unregister_sec_handlers(void)
+{
+	libbpf_unregister_prog_handler(abc1_id);
+	libbpf_unregister_prog_handler(abc2_id);
+	libbpf_unregister_prog_handler(custom_id);
+}
+
+void test_custom_sec_handlers(void)
+{
+	struct test_custom_sec_handlers* skel;
+	int err;
+
+	ASSERT_GT(abc1_id, 0, "abc1_id");
+	ASSERT_GT(abc2_id, 0, "abc2_id");
+	ASSERT_GT(custom_id, 0, "custom_id");
+
+	fallback_id = libbpf_register_prog_handler(NULL, /* fallback handler */
+						   BPF_PROG_TYPE_KPROBE, 0,
+						   custom_init_prog, custom_preload_prog,
+						   custom_attach_prog,
+						   COOKIE_FALLBACK, NULL);
+	if (!ASSERT_GT(fallback_id, 0, "fallback_id"))
+		return;
+
+	/* open skeleton and validate assumptions */
+	skel = test_custom_sec_handlers__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		goto cleanup;
+
+	ASSERT_EQ(bpf_program__type(skel->progs.abc1), BPF_PROG_TYPE_RAW_TRACEPOINT, "abc1_type");
+	ASSERT_FALSE(bpf_program__autoload(skel->progs.abc1), "abc1_autoload");
+
+	ASSERT_EQ(bpf_program__type(skel->progs.abc2), BPF_PROG_TYPE_RAW_TRACEPOINT, "abc2_type");
+	ASSERT_EQ(bpf_program__type(skel->progs.custom1), BPF_PROG_TYPE_TRACEPOINT, "custom1_type");
+	ASSERT_EQ(bpf_program__type(skel->progs.custom2), BPF_PROG_TYPE_TRACEPOINT, "custom2_type");
+	ASSERT_EQ(bpf_program__type(skel->progs.xyz), BPF_PROG_TYPE_KPROBE, "xyz_type");
+
+	skel->rodata->my_pid = getpid();
+
+	/* now attempt to load everything */
+	err = test_custom_sec_handlers__load(skel);
+	if (!ASSERT_OK(err, "skel_load"))
+		goto cleanup;
+
+	/* now try to auto-attach everything */
+	err = test_custom_sec_handlers__attach(skel);
+	if (!ASSERT_OK(err, "skel_attach"))
+		goto cleanup;
+
+	/* trigger programs */
+	usleep(1);
+
+	/* SEC("abc") is set to not auto-loaded */
+	ASSERT_FALSE(skel->bss->abc1_called, "abc1_called");
+	ASSERT_TRUE(skel->bss->abc2_called, "abc2_called");
+	ASSERT_TRUE(skel->bss->custom1_called, "custom1_called");
+	ASSERT_TRUE(skel->bss->custom2_called, "custom2_called");
+	/* SEC("xyz") shouldn't be auto-attached */
+	ASSERT_FALSE(skel->bss->xyz_called, "xyz_called");
+
+cleanup:
+	test_custom_sec_handlers__destroy(skel);
+
+	ASSERT_OK(libbpf_unregister_prog_handler(fallback_id), "unregister_fallback");
+}
diff --git a/tools/testing/selftests/bpf/progs/test_custom_sec_handlers.c b/tools/testing/selftests/bpf/progs/test_custom_sec_handlers.c
new file mode 100644
index 000000000000..2df368783678
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_custom_sec_handlers.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Facebook */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+const volatile int my_pid;
+
+bool abc1_called;
+bool abc2_called;
+bool custom1_called;
+bool custom2_called;
+bool xyz_called;
+
+SEC("abc")
+int abc1(void *ctx)
+{
+	abc1_called = true;
+	return 0;
+}
+
+SEC("abc/whatever")
+int abc2(void *ctx)
+{
+	abc2_called = true;
+	return 0;
+}
+
+SEC("custom")
+int custom1(void *ctx)
+{
+	custom1_called = true;
+	return 0;
+}
+
+SEC("custom/something")
+int custom2(void *ctx)
+{
+	custom2_called = true;
+	return 0;
+}
+
+SEC("xyz/blah")
+int xyz(void *ctx)
+{
+	xyz_called = true;
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.30.2

