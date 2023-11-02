Return-Path: <bpf+bounces-13982-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5465A7DF804
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 17:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFCCEB211BE
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 16:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CC61CABC;
	Thu,  2 Nov 2023 16:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="isRJZQDe"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56046134A5;
	Thu,  2 Nov 2023 16:55:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 751FFC433C8;
	Thu,  2 Nov 2023 16:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698944130;
	bh=YsPV5/V0usatEtmx3OOF87u1CEwJ7V2A5bFAv2iUvrg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=isRJZQDennq/Q8IpWeZWXtdFd/91757xuMG+ar4TKu77NN6TmiSSuXL30FMv4USfs
	 1Qjx5xJH912SSggzytOrStCY1MQ/fNm9kYGG0hzx2YSchKDa2f83cp8IP4cnUegROS
	 DkQZ705FaVvJ9SGgmOpxg7ApAp+78SgSksNQDY7TQ4e0eMVyNOrAqIMEZIH5U1AFw1
	 YBaCXJudswuI013Smi+Y30acYlytyIFXi1pQ/Oy+JcTQVZMp2CzsEGlY42rP2pFpUd
	 1i2/XQnb8oN/3dst/JTlGgLWGtIAyZ5uUInnawRvTSlZV31T3MtwNjkTltCstWeaHP
	 LdaXBnW/uXAJA==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org,
	fsverity@lists.linux.dev
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	kernel-team@meta.com,
	ebiggers@kernel.org,
	tytso@mit.edu,
	roberto.sassu@huaweicloud.com,
	kpsingh@kernel.org,
	Song Liu <song@kernel.org>
Subject: [PATCH v7 bpf-next 8/9] selftests/bpf: Add tests for filesystem kfuncs
Date: Thu,  2 Nov 2023 09:54:31 -0700
Message-Id: <20231102165432.1769965-9-song@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102165432.1769965-1-song@kernel.org>
References: <20231102165432.1769965-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add selftests for two new filesystem kfuncs:
  1. bpf_get_file_xattr
  2. bpf_get_fsverity_digest

These tests simply make sure the two kfuncs work. Another selftest will be
added to demonstrate how to use these kfuncs to verify file signature.

CONFIG_FS_VERITY is added to selftests config. However, this is not
sufficient to guarantee bpf_get_fsverity_digest works. This is because
fsverity need to be enabled at file system level (for example, with tune2fs
on ext4). If local file system doesn't have this feature enabled, just skip
the test.

Signed-off-by: Song Liu <song@kernel.org>
---
 tools/testing/selftests/bpf/bpf_kfuncs.h      |   3 +
 tools/testing/selftests/bpf/config            |   1 +
 .../selftests/bpf/prog_tests/fs_kfuncs.c      | 132 ++++++++++++++++++
 .../selftests/bpf/progs/test_fsverity.c       |  46 ++++++
 .../selftests/bpf/progs/test_get_xattr.c      |  37 +++++
 5 files changed, 219 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_fsverity.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_get_xattr.c

diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/selftests/bpf/bpf_kfuncs.h
index 5ca68ff0b59f..c2c084a44eae 100644
--- a/tools/testing/selftests/bpf/bpf_kfuncs.h
+++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
@@ -55,4 +55,7 @@ void *bpf_cast_to_kern_ctx(void *) __ksym;
 
 void *bpf_rdonly_cast(void *obj, __u32 btf_id) __ksym;
 
+extern int bpf_get_file_xattr(struct file *file, const char *name,
+			      struct bpf_dynptr *value_ptr) __ksym;
+extern int bpf_get_fsverity_digest(struct file *file, struct bpf_dynptr *digest_ptr) __ksym;
 #endif
diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 782876452acf..c125c441abc7 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -23,6 +23,7 @@ CONFIG_FPROBE=y
 CONFIG_FTRACE_SYSCALLS=y
 CONFIG_FUNCTION_ERROR_INJECTION=y
 CONFIG_FUNCTION_TRACER=y
+CONFIG_FS_VERITY=y
 CONFIG_GENEVE=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
diff --git a/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c b/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
new file mode 100644
index 000000000000..3084872ad1f4
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+
+#include <stdlib.h>
+#include <sys/types.h>
+#include <sys/xattr.h>
+#include <linux/fsverity.h>
+#include <unistd.h>
+#include <test_progs.h>
+#include "test_get_xattr.skel.h"
+#include "test_fsverity.skel.h"
+
+static const char testfile[] = "/tmp/test_progs_fs_kfuncs";
+
+static void test_xattr(void)
+{
+	struct test_get_xattr *skel = NULL;
+	int fd = -1, err;
+
+	fd = open(testfile, O_CREAT | O_RDONLY, 0644);
+	if (!ASSERT_GE(fd, 0, "create_file"))
+		return;
+
+	close(fd);
+	fd = -1;
+
+	err = setxattr(testfile, "user.kfuncs", "hello", sizeof("hello"), 0);
+	if (!ASSERT_OK(err, "setxattr"))
+		goto out;
+
+	skel = test_get_xattr__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_get_xattr__open_and_load"))
+		goto out;
+
+	skel->bss->monitored_pid = getpid();
+	err = test_get_xattr__attach(skel);
+
+	if (!ASSERT_OK(err, "test_get_xattr__attach"))
+		goto out;
+
+	fd = open(testfile, O_RDONLY, 0644);
+	if (!ASSERT_GE(fd, 0, "open_file"))
+		goto out;
+
+	ASSERT_EQ(skel->bss->found_xattr, 1, "found_xattr");
+
+out:
+	close(fd);
+	test_get_xattr__destroy(skel);
+	remove(testfile);
+}
+
+#ifndef SHA256_DIGEST_SIZE
+#define SHA256_DIGEST_SIZE      32
+#endif
+
+static void test_fsverity(void)
+{
+	struct fsverity_enable_arg arg = {0};
+	struct test_fsverity *skel = NULL;
+	struct fsverity_digest *d;
+	int fd, err;
+	char buffer[4096];
+
+	fd = open(testfile, O_CREAT | O_RDWR, 0644);
+	if (!ASSERT_GE(fd, 0, "create_file"))
+		return;
+
+	/* Write random buffer, so the file is not empty */
+	err = write(fd, buffer, 4096);
+	if (!ASSERT_EQ(err, 4096, "write_file"))
+		goto out;
+	close(fd);
+
+	/* Reopen read-only, otherwise FS_IOC_ENABLE_VERITY will fail */
+	fd = open(testfile, O_RDONLY, 0644);
+	if (!ASSERT_GE(fd, 0, "open_file1"))
+		return;
+
+	/* Enable fsverity for the file.
+	 * If the file system doesn't support verity, this will fail. Skip
+	 * the test in such case.
+	 */
+	arg.version = 1;
+	arg.hash_algorithm = FS_VERITY_HASH_ALG_SHA256;
+	arg.block_size = 4096;
+	err = ioctl(fd, FS_IOC_ENABLE_VERITY, &arg);
+	if (err) {
+		printf("%s:SKIP:local fs doesn't support fsverity (%d)\n", __func__, errno);
+		test__skip();
+		goto out;
+	}
+
+	skel = test_fsverity__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_fsverity__open_and_load"))
+		goto out;
+
+	/* Get fsverity_digest from ioctl */
+	d = (struct fsverity_digest *)skel->bss->expected_digest;
+	d->digest_algorithm = FS_VERITY_HASH_ALG_SHA256;
+	d->digest_size = SHA256_DIGEST_SIZE;
+	err = ioctl(fd, FS_IOC_MEASURE_VERITY, skel->bss->expected_digest);
+	if (!ASSERT_OK(err, "ioctl_FS_IOC_MEASURE_VERITY"))
+		goto out;
+
+	skel->bss->monitored_pid = getpid();
+	err = test_fsverity__attach(skel);
+	if (!ASSERT_OK(err, "test_fsverity__attach"))
+		goto out;
+
+	/* Reopen the file to trigger the program */
+	close(fd);
+	fd = open(testfile, O_RDONLY);
+	if (!ASSERT_GE(fd, 0, "open_file2"))
+		goto out;
+
+	ASSERT_EQ(skel->bss->got_fsverity, 1, "got_fsverity");
+	ASSERT_EQ(skel->bss->digest_matches, 1, "digest_matches");
+out:
+	close(fd);
+	test_fsverity__destroy(skel);
+	remove(testfile);
+}
+
+void test_fs_kfuncs(void)
+{
+	if (test__start_subtest("xattr"))
+		test_xattr();
+
+	if (test__start_subtest("fsverity"))
+		test_fsverity();
+}
diff --git a/tools/testing/selftests/bpf/progs/test_fsverity.c b/tools/testing/selftests/bpf/progs/test_fsverity.c
new file mode 100644
index 000000000000..ddba2edc8e7a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_fsverity.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_kfuncs.h"
+
+char _license[] SEC("license") = "GPL";
+
+#ifndef SHA256_DIGEST_SIZE
+#define SHA256_DIGEST_SIZE      32
+#endif
+
+__u32 monitored_pid;
+char expected_digest[sizeof(struct fsverity_digest) + SHA256_DIGEST_SIZE];
+char digest[sizeof(struct fsverity_digest) + SHA256_DIGEST_SIZE];
+__u32 got_fsverity;
+__u32 digest_matches;
+
+SEC("lsm.s/file_open")
+int BPF_PROG(test_file_open, struct file *f)
+{
+	struct bpf_dynptr digest_ptr;
+	__u32 pid;
+	int ret;
+	int i;
+
+	pid = bpf_get_current_pid_tgid() >> 32;
+	if (pid != monitored_pid)
+		return 0;
+
+	bpf_dynptr_from_mem(digest, sizeof(digest), 0, &digest_ptr);
+	ret = bpf_get_fsverity_digest(f, &digest_ptr);
+	if (ret < 0)
+		return 0;
+	got_fsverity = 1;
+
+	for (i = 0; i < sizeof(digest); i++) {
+		if (digest[i] != expected_digest[i])
+			return 0;
+	}
+
+	digest_matches = 1;
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/test_get_xattr.c b/tools/testing/selftests/bpf/progs/test_get_xattr.c
new file mode 100644
index 000000000000..7eb2a4e5a3e5
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_get_xattr.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_kfuncs.h"
+
+char _license[] SEC("license") = "GPL";
+
+__u32 monitored_pid;
+__u32 found_xattr;
+
+static const char expected_value[] = "hello";
+char value[32];
+
+SEC("lsm.s/file_open")
+int BPF_PROG(test_file_open, struct file *f)
+{
+	struct bpf_dynptr value_ptr;
+	__u32 pid;
+	int ret;
+
+	pid = bpf_get_current_pid_tgid() >> 32;
+	if (pid != monitored_pid)
+		return 0;
+
+	bpf_dynptr_from_mem(value, sizeof(value), 0, &value_ptr);
+
+	ret = bpf_get_file_xattr(f, "user.kfuncs", &value_ptr);
+	if (ret != sizeof(expected_value))
+		return 0;
+	if (bpf_strncmp(value, ret, expected_value))
+		return 0;
+	found_xattr = 1;
+	return 0;
+}
-- 
2.34.1


