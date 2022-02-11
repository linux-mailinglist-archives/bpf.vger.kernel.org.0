Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3BE04B2F29
	for <lists+bpf@lfdr.de>; Fri, 11 Feb 2022 22:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238212AbiBKVP3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 11 Feb 2022 16:15:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiBKVP3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Feb 2022 16:15:29 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21AF9C4E
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 13:15:27 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21BI914R001458
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 13:15:26 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e5vtqht1y-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 13:15:26 -0800
Received: from twshared45270.41.prn1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Feb 2022 13:15:24 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 735BB10BBA512; Fri, 11 Feb 2022 13:15:13 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 bpf-next 3/3] selftests/bpf: add custom SEC() handling selftest
Date:   Fri, 11 Feb 2022 13:14:50 -0800
Message-ID: <20220211211450.2224877-4-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220211211450.2224877-1-andrii@kernel.org>
References: <20220211211450.2224877-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: VDcVKnHJ8G_UXkdzWwBR631rd7thoye_
X-Proofpoint-GUID: VDcVKnHJ8G_UXkdzWwBR631rd7thoye_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-11_05,2022-02-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 mlxscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 suspectscore=0 adultscore=0
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202110107
X-FB-Internal: deliver
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,PDS_OTHER_BAD_TLD,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a selftest validating various aspects of libbpf's handling of custom
SEC() handlers. It also demonstrates how libraries can ensure very early
callbacks registration and unregistration using
__attribute__((constructor))/__attribute__((destructor)) functions.

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../bpf/prog_tests/custom_sec_handlers.c      | 176 ++++++++++++++++++
 .../bpf/progs/test_custom_sec_handlers.c      |  63 +++++++
 2 files changed, 239 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/custom_sec_handlers.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_custom_sec_handlers.c

diff --git a/tools/testing/selftests/bpf/prog_tests/custom_sec_handlers.c b/tools/testing/selftests/bpf/prog_tests/custom_sec_handlers.c
new file mode 100644
index 000000000000..28264528280d
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/custom_sec_handlers.c
@@ -0,0 +1,176 @@
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
+#define COOKIE_KPROBE 5
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
+	if (cookie == COOKIE_FALLBACK)
+		opts->prog_flags |= BPF_F_SLEEPABLE;
+	else if (cookie == COOKIE_ABC1)
+		ASSERT_FALSE(true, "unexpected preload for abc");
+
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
+	case COOKIE_KPROBE:
+	case COOKIE_FALLBACK:
+		/* no auto-attach for SEC("xyz") and SEC("kprobe") */
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
+static int kprobe_id;
+
+__attribute__((constructor))
+static void register_sec_handlers(void)
+{
+	LIBBPF_OPTS(libbpf_prog_handler_opts, abc1_opts,
+		.cookie = COOKIE_ABC1,
+		.init_fn = custom_init_prog,
+		.preload_fn = custom_preload_prog,
+		.attach_fn = NULL,
+	);
+	LIBBPF_OPTS(libbpf_prog_handler_opts, abc2_opts,
+		.cookie = COOKIE_ABC2,
+		.init_fn = custom_init_prog,
+		.preload_fn = custom_preload_prog,
+		.attach_fn = custom_attach_prog,
+	);
+	LIBBPF_OPTS(libbpf_prog_handler_opts, custom_opts,
+		.cookie = COOKIE_CUSTOM,
+		.init_fn = NULL,
+		.preload_fn = NULL,
+		.attach_fn = custom_attach_prog,
+	);
+
+	abc1_id = libbpf_register_prog_handler("abc", BPF_PROG_TYPE_RAW_TRACEPOINT, 0, &abc1_opts);
+	abc2_id = libbpf_register_prog_handler("abc/", BPF_PROG_TYPE_RAW_TRACEPOINT, 0, &abc2_opts);
+	custom_id = libbpf_register_prog_handler("custom+", BPF_PROG_TYPE_TRACEPOINT, 0, &custom_opts);
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
+	LIBBPF_OPTS(libbpf_prog_handler_opts, opts,
+		.init_fn = custom_init_prog,
+		.preload_fn = custom_preload_prog,
+		.attach_fn = custom_attach_prog,
+	);
+	struct test_custom_sec_handlers* skel;
+	int err;
+
+	ASSERT_GT(abc1_id, 0, "abc1_id");
+	ASSERT_GT(abc2_id, 0, "abc2_id");
+	ASSERT_GT(custom_id, 0, "custom_id");
+
+	/* override libbpf's handle of SEC("kprobe/...") but also allow pure
+	 * SEC("kprobe") due to "kprobe+" specifier. Register it as
+	 * TRACEPOINT, just for fun.
+	 */
+	opts.cookie = COOKIE_KPROBE;
+	kprobe_id = libbpf_register_prog_handler("kprobe+", BPF_PROG_TYPE_TRACEPOINT, 0, &opts);
+	/* fallback treats everything as BPF_PROG_TYPE_SYSCALL program to test
+	 * setting custom BPF_F_SLEEPABLE bit in preload handler
+	 */
+	opts.cookie = COOKIE_FALLBACK;
+	fallback_id = libbpf_register_prog_handler(NULL, BPF_PROG_TYPE_SYSCALL, 0, &opts);
+
+	if (!ASSERT_GT(fallback_id, 0, "fallback_id") /* || !ASSERT_GT(kprobe_id, 0, "kprobe_id")*/) {
+		if (fallback_id > 0)
+			libbpf_unregister_prog_handler(fallback_id);
+		if (kprobe_id > 0)
+			libbpf_unregister_prog_handler(kprobe_id);
+		return;
+	}
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
+	ASSERT_EQ(bpf_program__type(skel->progs.kprobe1), BPF_PROG_TYPE_TRACEPOINT, "kprobe1_type");
+	ASSERT_EQ(bpf_program__type(skel->progs.xyz), BPF_PROG_TYPE_SYSCALL, "xyz_type");
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
+	skel->links.xyz = bpf_program__attach(skel->progs.kprobe1);
+	ASSERT_EQ(errno, EOPNOTSUPP, "xyz_attach_err");
+	ASSERT_ERR_PTR(skel->links.xyz, "xyz_attach");
+
+	/* trigger programs */
+	usleep(1);
+
+	/* SEC("abc") is set to not auto-loaded */
+	ASSERT_FALSE(skel->bss->abc1_called, "abc1_called");
+	ASSERT_TRUE(skel->bss->abc2_called, "abc2_called");
+	ASSERT_TRUE(skel->bss->custom1_called, "custom1_called");
+	ASSERT_TRUE(skel->bss->custom2_called, "custom2_called");
+	/* SEC("kprobe") shouldn't be auto-attached */
+	ASSERT_FALSE(skel->bss->kprobe1_called, "kprobe1_called");
+	/* SEC("xyz") shouldn't be auto-attached */
+	ASSERT_FALSE(skel->bss->xyz_called, "xyz_called");
+
+cleanup:
+	test_custom_sec_handlers__destroy(skel);
+
+	ASSERT_OK(libbpf_unregister_prog_handler(fallback_id), "unregister_fallback");
+	ASSERT_OK(libbpf_unregister_prog_handler(kprobe_id), "unregister_kprobe");
+}
diff --git a/tools/testing/selftests/bpf/progs/test_custom_sec_handlers.c b/tools/testing/selftests/bpf/progs/test_custom_sec_handlers.c
new file mode 100644
index 000000000000..4061f701ca50
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_custom_sec_handlers.c
@@ -0,0 +1,63 @@
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
+bool kprobe1_called;
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
+SEC("kprobe")
+int kprobe1(void *ctx)
+{
+	kprobe1_called = true;
+	return 0;
+}
+
+SEC("xyz/blah")
+int xyz(void *ctx)
+{
+	int whatever;
+
+	/* use sleepable helper, custom handler should set sleepable flag */
+	bpf_copy_from_user(&whatever, sizeof(whatever), NULL);
+	xyz_called = true;
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.30.2

