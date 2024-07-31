Return-Path: <bpf+bounces-36120-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA4194270C
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 08:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 852D71F21534
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 06:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5C516EB5A;
	Wed, 31 Jul 2024 06:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="N3NDpm1i"
X-Original-To: bpf@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A656916D30E;
	Wed, 31 Jul 2024 06:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722407866; cv=none; b=O+CI8WLnwGoPil5HG9ci2ElARvx3RYhnUK87HEJeapcqdtE4sXQhSZHhdjUNhba8DImK+7xtXOO4bEVA2/hSrP8L3pF3h5015QQYHQ2SUmzdM8EXMl3g1LMvRQ9AVLY/yG3HUP2W8EhbEO2hmZpkCN6HOE+nVZmSFVL1LPTFPzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722407866; c=relaxed/simple;
	bh=jca59ogydPv9TSmCIKiqlliJuj4QArG+pWOInKX+p7g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AyAX1ydqwUFlTxBKq2Djtop4PWLGbFw87b3JvjQdf5EsxtYPpddezarFB5geVnQTi84zDhc6EH1AFA0gT2mjjO4f30fomx4x6xqXrhW5LGq5bVqfx7+ZXLc9pozv5ljtPn9BnldoSzvzxY14kNqSjO4O5KYAo8hokSNKU0/mTh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=N3NDpm1i; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4D8AFC0009;
	Wed, 31 Jul 2024 06:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722407856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p6S80ZwlSz4sFctUIVxv4uX63/mv1w9A3PnVIYruag8=;
	b=N3NDpm1ilVygIaQkkosBUQCnah1+MnCnSaP7Fc+dYos48dG0RLMdhqpJ06pBBjDCpSQN35
	CscKTRLvX11kFvpcbB6HMUN6Z0mLX0exzrjWMrmZl7+F6dxSiTWEaJZAj9EDacPWNE7aLH
	dbdfonZavaL1Y0+kNGXl+wJGLdOM8jpojTnB9lIDnzqBZT2zSWjB8rkbUnzx+6wdA7A90p
	lKJEhCfNL5J40XBLOs85VxHzHovlL8MRCR1A7u5r3TRqW4xTP+A0KUX9i7PvrOd8bkQxFa
	Pl27X4VYYHOtCAuShnUbt45rT6/g6RXa8gq1S3ytRw/6e0t15GqCtdZbV0QXtA==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Wed, 31 Jul 2024 08:37:26 +0200
Subject: [PATCH bpf-next v4 2/3] selftests/bpf: convert test_dev_cgroup to
 test_progs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240731-convert_dev_cgroup-v4-2-849425d90de6@bootlin.com>
References: <20240731-convert_dev_cgroup-v4-0-849425d90de6@bootlin.com>
In-Reply-To: <20240731-convert_dev_cgroup-v4-0-849425d90de6@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Alan Maguire <alan.maguire@oracle.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.1
X-GND-Sasl: alexis.lothore@bootlin.com

test_dev_cgroup is defined as a standalone test program, and so is not
executed in CI.

Convert it to test_progs framework so it is tested automatically in CI, and
remove the old test. In order to be able to run it in test_progs, /dev/null
must remain usable, so change the new test to test operations on devices
1:3 as valid, and operations on devices 1:5 (/dev/zero) as invalid.

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Changes in v4:
- split ret and errno testing

Changes in v3:
- delete mknod file only when is has been created
- use bpf_program__attach_cgroup instead of bpf_prog_attach
- reorder subtests
- collect review/ack tags

Changes in v2:
- pass expected return code to subtest function instead of boolean pass/not
  pass
- also pass buffer and buffer size for read/write subtests
- fix faulty fd check on read/write tests expected to fail
---
 tools/testing/selftests/bpf/.gitignore             |   1 -
 tools/testing/selftests/bpf/Makefile               |   2 -
 .../testing/selftests/bpf/prog_tests/cgroup_dev.c  | 121 +++++++++++++++++++++
 tools/testing/selftests/bpf/test_dev_cgroup.c      |  85 ---------------
 4 files changed, 121 insertions(+), 88 deletions(-)

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index 4e4aae8aa7ec..8f14d8faeb0b 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -9,7 +9,6 @@ test_lpm_map
 test_tag
 FEATURE-DUMP.libbpf
 fixdep
-test_dev_cgroup
 /test_progs
 /test_progs-no_alu32
 /test_progs-bpf_gcc
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 564e1fdf80b6..bb02a3540d7a 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -69,7 +69,6 @@ endif
 
 # Order correspond to 'make run_tests' order
 TEST_GEN_PROGS = test_verifier test_tag test_maps test_lru_map test_lpm_map test_progs \
-	test_dev_cgroup \
 	test_sock test_sockmap get_cgroup_id_user \
 	test_cgroup_storage \
 	test_tcpnotify_user test_sysctl \
@@ -294,7 +293,6 @@ JSON_WRITER		:= $(OUTPUT)/json_writer.o
 CAP_HELPERS	:= $(OUTPUT)/cap_helpers.o
 NETWORK_HELPERS := $(OUTPUT)/network_helpers.o
 
-$(OUTPUT)/test_dev_cgroup: $(CGROUP_HELPERS) $(TESTING_HELPERS)
 $(OUTPUT)/test_skb_cgroup_id_user: $(CGROUP_HELPERS) $(TESTING_HELPERS)
 $(OUTPUT)/test_sock: $(CGROUP_HELPERS) $(TESTING_HELPERS)
 $(OUTPUT)/test_sockmap: $(CGROUP_HELPERS) $(TESTING_HELPERS)
diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_dev.c b/tools/testing/selftests/bpf/prog_tests/cgroup_dev.c
new file mode 100644
index 000000000000..8661e145ba84
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_dev.c
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <sys/stat.h>
+#include <sys/sysmacros.h>
+#include <errno.h>
+#include "test_progs.h"
+#include "cgroup_helpers.h"
+#include "dev_cgroup.skel.h"
+
+#define TEST_CGROUP "/test-bpf-based-device-cgroup/"
+#define TEST_BUFFER_SIZE 64
+
+static void test_mknod(const char *path, mode_t mode, int dev_major,
+		       int dev_minor, int expected_ret, int expected_errno)
+{
+	int ret;
+
+	unlink(path);
+	ret = mknod(path, mode, makedev(dev_major, dev_minor));
+	ASSERT_EQ(ret, expected_ret, "mknod");
+	if (expected_ret)
+		ASSERT_EQ(errno, expected_errno, "mknod errno");
+	else
+		unlink(path);
+}
+
+static void test_read(const char *path, char *buf, int buf_size,
+		      int expected_ret, int expected_errno)
+{
+	int ret, fd;
+
+	fd = open(path, O_RDONLY);
+
+	/* A bare open on unauthorized device should fail */
+	if (expected_ret < 0) {
+		ASSERT_EQ(fd, expected_ret, "open ret for read");
+		ASSERT_EQ(errno, expected_errno, "open errno for read");
+		if (fd >= 0)
+			close(fd);
+		return;
+	}
+
+	if (!ASSERT_OK_FD(fd, "open ret for read"))
+		return;
+
+	ret = read(fd, buf, buf_size);
+	ASSERT_EQ(ret, expected_ret, "read");
+
+	close(fd);
+}
+
+static void test_write(const char *path, char *buf, int buf_size,
+		       int expected_ret, int expected_errno)
+{
+	int ret, fd;
+
+	fd = open(path, O_WRONLY);
+
+	/* A bare open on unauthorized device should fail */
+	if (expected_ret < 0) {
+		ASSERT_EQ(fd, expected_ret, "open ret for write");
+		ASSERT_EQ(errno, expected_errno, "open errno for write");
+		if (fd >= 0)
+			close(fd);
+		return;
+	}
+
+	if (!ASSERT_OK_FD(fd, "open ret for write"))
+		return;
+
+	ret = write(fd, buf, buf_size);
+	ASSERT_EQ(ret, expected_ret, "write");
+
+	close(fd);
+}
+
+void test_cgroup_dev(void)
+{
+	char buf[TEST_BUFFER_SIZE] = "some random test data";
+	struct dev_cgroup *skel;
+	int cgroup_fd;
+
+	cgroup_fd = cgroup_setup_and_join(TEST_CGROUP);
+	if (!ASSERT_OK_FD(cgroup_fd, "cgroup switch"))
+		return;
+
+	skel = dev_cgroup__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "load program"))
+		goto cleanup_cgroup;
+
+	skel->links.bpf_prog1 =
+		bpf_program__attach_cgroup(skel->progs.bpf_prog1, cgroup_fd);
+	if (!ASSERT_OK_PTR(skel->links.bpf_prog1, "attach_program"))
+		goto cleanup_progs;
+
+	if (test__start_subtest("allow-mknod"))
+		test_mknod("/dev/test_dev_cgroup_null", S_IFCHR, 1, 3, 0, 0);
+
+	if (test__start_subtest("allow-read"))
+		test_read("/dev/urandom", buf, TEST_BUFFER_SIZE,
+			  TEST_BUFFER_SIZE, 0);
+
+	if (test__start_subtest("allow-write"))
+		test_write("/dev/null", buf, TEST_BUFFER_SIZE,
+			   TEST_BUFFER_SIZE, 0);
+
+	if (test__start_subtest("deny-mknod"))
+		test_mknod("/dev/test_dev_cgroup_zero", S_IFCHR, 1, 5, -1,
+			   EPERM);
+
+	if (test__start_subtest("deny-read"))
+		test_read("/dev/random", buf, TEST_BUFFER_SIZE, -1, EPERM);
+
+	if (test__start_subtest("deny-write"))
+		test_write("/dev/zero", buf, TEST_BUFFER_SIZE, -1, EPERM);
+
+cleanup_progs:
+	dev_cgroup__destroy(skel);
+cleanup_cgroup:
+	cleanup_cgroup_environment();
+}
diff --git a/tools/testing/selftests/bpf/test_dev_cgroup.c b/tools/testing/selftests/bpf/test_dev_cgroup.c
deleted file mode 100644
index 33f544f0005a..000000000000
--- a/tools/testing/selftests/bpf/test_dev_cgroup.c
+++ /dev/null
@@ -1,85 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/* Copyright (c) 2017 Facebook
- */
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <errno.h>
-#include <assert.h>
-#include <sys/time.h>
-
-#include <linux/bpf.h>
-#include <bpf/bpf.h>
-#include <bpf/libbpf.h>
-
-#include "cgroup_helpers.h"
-#include "testing_helpers.h"
-
-#define DEV_CGROUP_PROG "./dev_cgroup.bpf.o"
-
-#define TEST_CGROUP "/test-bpf-based-device-cgroup/"
-
-int main(int argc, char **argv)
-{
-	struct bpf_object *obj;
-	int error = EXIT_FAILURE;
-	int prog_fd, cgroup_fd;
-	__u32 prog_cnt;
-
-	/* Use libbpf 1.0 API mode */
-	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
-
-	if (bpf_prog_test_load(DEV_CGROUP_PROG, BPF_PROG_TYPE_CGROUP_DEVICE,
-			  &obj, &prog_fd)) {
-		printf("Failed to load DEV_CGROUP program\n");
-		goto out;
-	}
-
-	cgroup_fd = cgroup_setup_and_join(TEST_CGROUP);
-	if (cgroup_fd < 0) {
-		printf("Failed to create test cgroup\n");
-		goto out;
-	}
-
-	/* Attach bpf program */
-	if (bpf_prog_attach(prog_fd, cgroup_fd, BPF_CGROUP_DEVICE, 0)) {
-		printf("Failed to attach DEV_CGROUP program");
-		goto err;
-	}
-
-	if (bpf_prog_query(cgroup_fd, BPF_CGROUP_DEVICE, 0, NULL, NULL,
-			   &prog_cnt)) {
-		printf("Failed to query attached programs");
-		goto err;
-	}
-
-	/* All operations with /dev/null and /dev/urandom are allowed,
-	 * everything else is forbidden.
-	 */
-	assert(system("rm -f /tmp/test_dev_cgroup_zero") == 0);
-	assert(system("mknod /tmp/test_dev_cgroup_zero c 1 5"));
-	assert(system("rm -f /tmp/test_dev_cgroup_zero") == 0);
-
-	/* /dev/null is whitelisted */
-	assert(system("rm -f /tmp/test_dev_cgroup_null") == 0);
-	assert(system("mknod /tmp/test_dev_cgroup_null c 1 3") == 0);
-	assert(system("rm -f /tmp/test_dev_cgroup_null") == 0);
-
-	assert(system("dd if=/dev/urandom of=/dev/null count=64") == 0);
-
-	/* src is allowed, target is forbidden */
-	assert(system("dd if=/dev/urandom of=/dev/full count=64"));
-
-	/* src is forbidden, target is allowed */
-	assert(system("dd if=/dev/random of=/dev/null count=64"));
-
-	error = 0;
-	printf("test_dev_cgroup:PASS\n");
-
-err:
-	cleanup_cgroup_environment();
-
-out:
-	return error;
-}

-- 
2.45.2


