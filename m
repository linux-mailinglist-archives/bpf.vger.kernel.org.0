Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11CBC41D5DB
	for <lists+bpf@lfdr.de>; Thu, 30 Sep 2021 11:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349150AbhI3JBp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Sep 2021 05:01:45 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:23343 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349130AbhI3JBo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Sep 2021 05:01:44 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HKnC25hdFzRb6v;
        Thu, 30 Sep 2021 16:55:42 +0800 (CST)
Received: from dggpeml500025.china.huawei.com (7.185.36.35) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 30 Sep 2021 17:00:00 +0800
Received: from huawei.com (10.175.124.27) by dggpeml500025.china.huawei.com
 (7.185.36.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 30 Sep
 2021 16:59:59 +0800
From:   Hou Tao <houtao1@huawei.com>
To:     Alexei Starovoitov <ast@kernel.org>
CC:     Yonghong Song <yhs@fb.com>, Daniel Borkmann <daniel@iogearbox.net>,
        "Andrii Nakryiko" <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <houtao1@huawei.com>
Subject: [PATCH bpf-next v4 3/3] bpf/selftests: add test for writable bare tracepoint
Date:   Thu, 30 Sep 2021 17:13:54 +0800
Message-ID: <20210930091355.2794601-4-houtao1@huawei.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210930091355.2794601-1-houtao1@huawei.com>
References: <20210930091355.2794601-1-houtao1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a writable bare tracepoint in bpf_testmod module, and
trigger its calling when reading /sys/kernel/bpf_testmod
with a specific buffer length. The reading will return
the value in writable context if the early return flag
is enabled in writable context.

Signed-off-by: Hou Tao <houtao1@huawei.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../bpf/bpf_testmod/bpf_testmod-events.h      | 15 ++++++++
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 10 ++++++
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |  5 +++
 .../selftests/bpf/prog_tests/module_attach.c  | 35 +++++++++++++++++++
 .../selftests/bpf/progs/test_module_attach.c  | 14 ++++++++
 tools/testing/selftests/bpf/test_progs.c      |  4 +--
 tools/testing/selftests/bpf/test_progs.h      |  2 ++
 7 files changed, 83 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod-events.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod-events.h
index 89c6d58e5dd6..11ee801e75e7 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod-events.h
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod-events.h
@@ -34,6 +34,21 @@ DECLARE_TRACE(bpf_testmod_test_write_bare,
 	TP_ARGS(task, ctx)
 );
 
+#undef BPF_TESTMOD_DECLARE_TRACE
+#ifdef DECLARE_TRACE_WRITABLE
+#define BPF_TESTMOD_DECLARE_TRACE(call, proto, args, size) \
+	DECLARE_TRACE_WRITABLE(call, PARAMS(proto), PARAMS(args), size)
+#else
+#define BPF_TESTMOD_DECLARE_TRACE(call, proto, args, size) \
+	DECLARE_TRACE(call, PARAMS(proto), PARAMS(args))
+#endif
+
+BPF_TESTMOD_DECLARE_TRACE(bpf_testmod_test_writable_bare,
+	TP_PROTO(struct bpf_testmod_test_writable_ctx *ctx),
+	TP_ARGS(ctx),
+	sizeof(struct bpf_testmod_test_writable_ctx)
+);
+
 #endif /* _BPF_TESTMOD_EVENTS_H */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 50fc5561110a..1cc1d315ccf5 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -42,6 +42,16 @@ bpf_testmod_test_read(struct file *file, struct kobject *kobj,
 	if (bpf_testmod_loop_test(101) > 100)
 		trace_bpf_testmod_test_read(current, &ctx);
 
+	/* Magic number to enable writable tp */
+	if (len == 64) {
+		struct bpf_testmod_test_writable_ctx writable = {
+			.val = 1024,
+		};
+		trace_bpf_testmod_test_writable_bare(&writable);
+		if (writable.early_ret)
+			return snprintf(buf, len, "%d\n", writable.val);
+	}
+
 	return -EIO; /* always fail */
 }
 EXPORT_SYMBOL(bpf_testmod_test_read);
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
index b3892dc40111..0d71e2607832 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
@@ -17,4 +17,9 @@ struct bpf_testmod_test_write_ctx {
 	size_t len;
 };
 
+struct bpf_testmod_test_writable_ctx {
+	bool early_ret;
+	int val;
+};
+
 #endif /* _BPF_TESTMOD_H */
diff --git a/tools/testing/selftests/bpf/prog_tests/module_attach.c b/tools/testing/selftests/bpf/prog_tests/module_attach.c
index 1797a6e4d6d8..6d0e50dcf47c 100644
--- a/tools/testing/selftests/bpf/prog_tests/module_attach.c
+++ b/tools/testing/selftests/bpf/prog_tests/module_attach.c
@@ -2,10 +2,36 @@
 /* Copyright (c) 2020 Facebook */
 
 #include <test_progs.h>
+#include <stdbool.h>
 #include "test_module_attach.skel.h"
 
 static int duration;
 
+static int trigger_module_test_writable(int *val)
+{
+	int fd, err;
+	char buf[65];
+	ssize_t rd;
+
+	fd = open(BPF_TESTMOD_TEST_FILE, O_RDONLY);
+	err = -errno;
+	if (!ASSERT_GE(fd, 0, "testmode_file_open"))
+		return err;
+
+	rd = read(fd, buf, sizeof(buf) - 1);
+	err = -errno;
+	if (!ASSERT_GT(rd, 0, "testmod_file_rd_val")) {
+		close(fd);
+		return err;
+	}
+
+	buf[rd] = '\0';
+	*val = strtol(buf, NULL, 0);
+	close(fd);
+
+	return 0;
+}
+
 static int delete_module(const char *name, int flags)
 {
 	return syscall(__NR_delete_module, name, flags);
@@ -19,6 +45,7 @@ void test_module_attach(void)
 	struct test_module_attach__bss *bss;
 	struct bpf_link *link;
 	int err;
+	int writable_val = 0;
 
 	skel = test_module_attach__open();
 	if (CHECK(!skel, "skel_open", "failed to open skeleton\n"))
@@ -51,6 +78,14 @@ void test_module_attach(void)
 	ASSERT_EQ(bss->fexit_ret, -EIO, "fexit_tet");
 	ASSERT_EQ(bss->fmod_ret_read_sz, READ_SZ, "fmod_ret");
 
+	bss->raw_tp_writable_bare_early_ret = true;
+	bss->raw_tp_writable_bare_out_val = 0xf1f2f3f4;
+	ASSERT_OK(trigger_module_test_writable(&writable_val),
+		  "trigger_writable");
+	ASSERT_EQ(bss->raw_tp_writable_bare_in_val, 1024, "writable_test_in");
+	ASSERT_EQ(bss->raw_tp_writable_bare_out_val, writable_val,
+		  "writable_test_out");
+
 	test_module_attach__detach(skel);
 
 	/* attach fentry/fexit and make sure it get's module reference */
diff --git a/tools/testing/selftests/bpf/progs/test_module_attach.c b/tools/testing/selftests/bpf/progs/test_module_attach.c
index bd37ceec5587..b36857093f71 100644
--- a/tools/testing/selftests/bpf/progs/test_module_attach.c
+++ b/tools/testing/selftests/bpf/progs/test_module_attach.c
@@ -27,6 +27,20 @@ int BPF_PROG(handle_raw_tp_bare,
 	return 0;
 }
 
+int raw_tp_writable_bare_in_val = 0;
+int raw_tp_writable_bare_early_ret = 0;
+int raw_tp_writable_bare_out_val = 0;
+
+SEC("raw_tp.w/bpf_testmod_test_writable_bare")
+int BPF_PROG(handle_raw_tp_writable_bare,
+	     struct bpf_testmod_test_writable_ctx *writable)
+{
+	raw_tp_writable_bare_in_val = writable->val;
+	writable->early_ret = raw_tp_writable_bare_early_ret;
+	writable->val = raw_tp_writable_bare_out_val;
+	return 0;
+}
+
 __u32 tp_btf_read_sz = 0;
 
 SEC("tp_btf/bpf_testmod_test_read")
diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 2ed01f615d20..007b4ff85fea 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -747,7 +747,7 @@ int trigger_module_test_read(int read_sz)
 {
 	int fd, err;
 
-	fd = open("/sys/kernel/bpf_testmod", O_RDONLY);
+	fd = open(BPF_TESTMOD_TEST_FILE, O_RDONLY);
 	err = -errno;
 	if (!ASSERT_GE(fd, 0, "testmod_file_open"))
 		return err;
@@ -769,7 +769,7 @@ int trigger_module_test_write(int write_sz)
 	memset(buf, 'a', write_sz);
 	buf[write_sz-1] = '\0';
 
-	fd = open("/sys/kernel/bpf_testmod", O_WRONLY);
+	fd = open(BPF_TESTMOD_TEST_FILE, O_WRONLY);
 	err = -errno;
 	if (!ASSERT_GE(fd, 0, "testmod_file_open")) {
 		free(buf);
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index 94bef0aa74cf..9b8a1810b700 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -301,3 +301,5 @@ int trigger_module_test_write(int write_sz);
 #else
 #define SYS_NANOSLEEP_KPROBE_NAME "sys_nanosleep"
 #endif
+
+#define BPF_TESTMOD_TEST_FILE "/sys/kernel/bpf_testmod"
-- 
2.29.2

