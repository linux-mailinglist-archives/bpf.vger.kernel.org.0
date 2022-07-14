Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE62D5755BA
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 21:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239738AbiGNTS2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 15:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239650AbiGNTS1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 15:18:27 -0400
Received: from sinmsgout01.his.huawei.com (sinmsgout01.his.huawei.com [119.8.177.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FCA42ADC
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 12:18:26 -0700 (PDT)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.156.208])
        by sinmsgout01.his.huawei.com (SkyGuard) with ESMTP id 4LkPKR2vXXz9ttCw;
        Fri, 15 Jul 2022 03:13:31 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 14 Jul 2022 21:18:19 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <ast@kernel.org>, <daniel@iogearbox.net>,
        <john.fastabend@gmail.com>, <andrii@kernel.org>,
        <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
        <kpsingh@kernel.org>
CC:     <bpf@vger.kernel.org>, Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH v8 11/12] selftests/bpf: Add additional test for bpf_lookup_user_key()
Date:   Thu, 14 Jul 2022 21:14:54 +0200
Message-ID: <20220714191455.2101834-12-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220714191455.2101834-1-roberto.sassu@huawei.com>
References: <20220714191455.2101834-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.63.22]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add an additional test to ensure that bpf_lookup_user_key() creates a
referenced special keyring when the KEY_LOOKUP_CREATE flag is passed to
this function.

Also ensure that the kfunc rejects invalid flags.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 .../bpf/prog_tests/lookup_user_key.c          | 98 +++++++++++++++++++
 .../bpf/progs/test_lookup_user_key.c          | 38 +++++++
 2 files changed, 136 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lookup_user_key.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_lookup_user_key.c

diff --git a/tools/testing/selftests/bpf/prog_tests/lookup_user_key.c b/tools/testing/selftests/bpf/prog_tests/lookup_user_key.c
new file mode 100644
index 000000000000..e53686932785
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/lookup_user_key.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (C) 2022 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ */
+
+#include <linux/keyctl.h>
+#include <test_progs.h>
+
+#include "test_lookup_user_key.skel.h"
+
+#define KEY_LOOKUP_CREATE	0x01
+#define KEY_LOOKUP_PARTIAL	0x02
+
+static bool kfunc_not_supported;
+
+static int libbpf_print_cb(enum libbpf_print_level level, const char *fmt,
+			   va_list args)
+{
+	char *func;
+
+	if (strcmp(fmt, "libbpf: extern (func ksym) '%s': not found in kernel or module BTFs\n"))
+		return 0;
+
+	func = va_arg(args, char *);
+
+	if (strcmp(func, "bpf_lookup_user_key") && strcmp(func, "bpf_key_put"))
+		return 0;
+
+	kfunc_not_supported = true;
+	return 0;
+}
+
+void test_lookup_user_key(void)
+{
+	libbpf_print_fn_t old_print_cb;
+	struct test_lookup_user_key *skel = NULL;
+	u32 next_id;
+	int ret;
+
+	skel = test_lookup_user_key__open();
+	if (!ASSERT_OK_PTR(skel, "test_lookup_user_key__open"))
+		return;
+
+	old_print_cb = libbpf_set_print(libbpf_print_cb);
+	ret = test_lookup_user_key__load(skel);
+	libbpf_set_print(old_print_cb);
+
+	if (ret < 0 && kfunc_not_supported) {
+		printf("%s:SKIP:bpf_lookup_user_key() kfunc not supported\n",
+		       __func__);
+		test__skip();
+		goto close_prog;
+	}
+
+	if (!ASSERT_OK(ret, "test_lookup_user_key__load"))
+		goto close_prog;
+
+	ret = test_lookup_user_key__attach(skel);
+	if (!ASSERT_OK(ret, "test_lookup_user_key__attach"))
+		goto close_prog;
+
+	skel->bss->monitored_pid = getpid();
+	skel->bss->key_serial = KEY_SPEC_THREAD_KEYRING;
+
+	/* The thread-specific keyring does not exist, this test fails. */
+	skel->bss->flags = 0;
+
+	ret = bpf_prog_get_next_id(0, &next_id);
+	if (!ASSERT_LT(ret, 0, "bpf_prog_get_next_id"))
+		goto close_prog;
+
+	/* Force creation of the thread-specific keyring, this test succeeds. */
+	skel->bss->flags = KEY_LOOKUP_CREATE;
+
+	ret = bpf_prog_get_next_id(0, &next_id);
+	if (!ASSERT_OK(ret, "bpf_prog_get_next_id"))
+		goto close_prog;
+
+	/* Pass both lookup flags for parameter validation. */
+	skel->bss->flags = KEY_LOOKUP_CREATE | KEY_LOOKUP_PARTIAL;
+
+	ret = bpf_prog_get_next_id(0, &next_id);
+	if (!ASSERT_OK(ret, "bpf_prog_get_next_id"))
+		goto close_prog;
+
+	/* Pass invalid flags. */
+	skel->bss->flags = UINT64_MAX;
+
+	ret = bpf_prog_get_next_id(0, &next_id);
+	ASSERT_LT(ret, 0, "bpf_prog_get_next_id");
+
+close_prog:
+	skel->bss->monitored_pid = 0;
+	test_lookup_user_key__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_lookup_user_key.c b/tools/testing/selftests/bpf/progs/test_lookup_user_key.c
new file mode 100644
index 000000000000..29d963055834
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_lookup_user_key.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (C) 2022 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ */
+
+#include "vmlinux.h"
+#include <errno.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+__u32 monitored_pid;
+__u32 key_serial;
+__u64 flags;
+
+extern struct key *bpf_lookup_user_key(__u32 serial, __u64 flags) __ksym;
+extern void bpf_key_put(struct key *key) __ksym;
+
+SEC("lsm.s/bpf")
+int BPF_PROG(bpf, int cmd, union bpf_attr *attr, unsigned int size)
+{
+	struct key *key;
+	__u32 pid;
+
+	pid = bpf_get_current_pid_tgid() >> 32;
+	if (pid != monitored_pid)
+		return 0;
+
+	key = bpf_lookup_user_key(key_serial, flags);
+	if (key)
+		bpf_key_put(key);
+
+	return (key) ? 0 : -ENOENT;
+}
-- 
2.25.1

