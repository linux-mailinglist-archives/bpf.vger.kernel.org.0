Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 767112CB185
	for <lists+bpf@lfdr.de>; Wed,  2 Dec 2020 01:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbgLBAZN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 1 Dec 2020 19:25:13 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43750 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727417AbgLBAZM (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 1 Dec 2020 19:25:12 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B20F9tt012189
        for <bpf@vger.kernel.org>; Tue, 1 Dec 2020 16:24:31 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 355qvjkt7h-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 01 Dec 2020 16:24:31 -0800
Received: from intmgw002.08.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 1 Dec 2020 16:24:30 -0800
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 395752ECA70C; Tue,  1 Dec 2020 16:24:26 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v4 bpf-next 14/14] selftests/bpf: add fentry/fexit/fmod_ret selftest for kernel module
Date:   Tue, 1 Dec 2020 16:16:16 -0800
Message-ID: <20201202001616.3378929-15-andrii@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201202001616.3378929-1-andrii@kernel.org>
References: <20201202001616.3378929-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-01_12:2020-11-30,2020-12-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 clxscore=1034 impostorscore=0 suspectscore=8 malwarescore=0 adultscore=0
 spamscore=0 mlxlogscore=999 priorityscore=1501 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012020000
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add new selftest checking attachment of fentry/fexit/fmod_ret (and raw
tracepoint ones for completeness) BPF programs to kernel module function.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/prog_tests/module_attach.c  | 53 +++++++++++++++
 .../selftests/bpf/progs/test_module_attach.c  | 66 +++++++++++++++++++
 2 files changed, 119 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/module_attach.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_module_attach.c

diff --git a/tools/testing/selftests/bpf/prog_tests/module_attach.c b/tools/testing/selftests/bpf/prog_tests/module_attach.c
new file mode 100644
index 000000000000..4b65e9918764
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/module_attach.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2020 Facebook */
+
+#include <test_progs.h>
+#include "test_module_attach.skel.h"
+
+static int duration;
+
+static int trigger_module_test_read(int read_sz)
+{
+	int fd, err;
+
+	fd = open("/sys/kernel/bpf_testmod", O_RDONLY);
+	err = -errno;
+	if (CHECK(fd < 0, "testmod_file_open", "failed: %d\n", err))
+		return err;
+
+	read(fd, NULL, read_sz);
+	close(fd);
+
+	return 0;
+}
+
+void test_module_attach(void)
+{
+	const int READ_SZ = 456;
+	struct test_module_attach* skel;
+	struct test_module_attach__bss *bss;
+	int err;
+
+	skel = test_module_attach__open_and_load();
+	if (CHECK(!skel, "skel_open", "failed to open skeleton\n"))
+		return;
+
+	bss = skel->bss;
+
+	err = test_module_attach__attach(skel);
+	if (CHECK(err, "skel_attach", "skeleton attach failed: %d\n", err))
+		goto cleanup;
+
+	/* trigger tracepoint */
+	ASSERT_OK(trigger_module_test_read(READ_SZ), "trigger_read");
+
+	ASSERT_EQ(bss->raw_tp_read_sz, READ_SZ, "raw_tp");
+	ASSERT_EQ(bss->tp_btf_read_sz, READ_SZ, "tp_btf");
+	ASSERT_EQ(bss->fentry_read_sz, READ_SZ, "fentry");
+	ASSERT_EQ(bss->fexit_read_sz, READ_SZ, "fexit");
+	ASSERT_EQ(bss->fexit_ret, -EIO, "fexit_tet");
+	ASSERT_EQ(bss->fmod_ret_read_sz, READ_SZ, "fmod_ret");
+
+cleanup:
+	test_module_attach__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_module_attach.c b/tools/testing/selftests/bpf/progs/test_module_attach.c
new file mode 100644
index 000000000000..b563563df172
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_module_attach.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2020 Facebook */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+#include "../bpf_testmod/bpf_testmod.h"
+
+__u32 raw_tp_read_sz = 0;
+
+SEC("raw_tp/bpf_testmod_test_read")
+int BPF_PROG(handle_raw_tp,
+	     struct task_struct *task, struct bpf_testmod_test_read_ctx *read_ctx)
+{
+	raw_tp_read_sz = BPF_CORE_READ(read_ctx, len);
+	return 0;
+}
+
+__u32 tp_btf_read_sz = 0;
+
+SEC("tp_btf/bpf_testmod_test_read")
+int BPF_PROG(handle_tp_btf,
+	     struct task_struct *task, struct bpf_testmod_test_read_ctx *read_ctx)
+{
+	tp_btf_read_sz = read_ctx->len;
+	return 0;
+}
+
+__u32 fentry_read_sz = 0;
+
+SEC("fentry/bpf_testmod_test_read")
+int BPF_PROG(handle_fentry,
+	     struct file *file, struct kobject *kobj,
+	     struct bin_attribute *bin_attr, char *buf, loff_t off, size_t len)
+{
+	fentry_read_sz = len;
+	return 0;
+}
+
+__u32 fexit_read_sz = 0;
+int fexit_ret = 0;
+
+SEC("fexit/bpf_testmod_test_read")
+int BPF_PROG(handle_fexit,
+	     struct file *file, struct kobject *kobj,
+	     struct bin_attribute *bin_attr, char *buf, loff_t off, size_t len,
+	     int ret)
+{
+	fexit_read_sz = len;
+	fexit_ret = ret;
+	return 0;
+}
+
+__u32 fmod_ret_read_sz = 0;
+
+SEC("fmod_ret/bpf_testmod_test_read")
+int BPF_PROG(handle_fmod_ret,
+	     struct file *file, struct kobject *kobj,
+	     struct bin_attribute *bin_attr, char *buf, loff_t off, size_t len)
+{
+	fmod_ret_read_sz = len;
+	return 0; /* don't override the exit code */
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.24.1

