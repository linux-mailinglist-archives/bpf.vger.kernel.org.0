Return-Path: <bpf+bounces-71692-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B71DBFAC8D
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 10:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11F944633ED
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 08:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6FE3002B6;
	Wed, 22 Oct 2025 08:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OT+7p63A"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4100F2DE6FC
	for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 08:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761120386; cv=none; b=flA+GiHxKlMNj2oFtpoMr34vFeKoGQAgn3JSkk+2fiG4TXUXxsqVWyGxktGROowUithAfOgEqyJhqtdZiBGzQrRf9ajS/ROMzpzYTjYx5gjxasSrf7HgJM7hBubS7fBcRpTWYsjUjfd0VmG/gJyxKP3NgQXNT/xSXDU3gBdVctI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761120386; c=relaxed/simple;
	bh=11h9/7cLSx4w9Nlnk3G5SzB3wO2oo6urxq94rUmhgIo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HVw5+W7Xj6KtHOXaHmt2+juXsu6bstVmTef1doa6vB4eS4rfOJVmL4cHu3d8U/EyM6dVLM9NlKviRon22lyBEAqJe2SYkFThqJooI/0pbCK9tvvZ+lez4fbY/sSwrniWexVAibcP6M3fvQrjamLNRxQ0EJcUQDpQUJwE60HbY/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OT+7p63A; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-33bda2306c5so5256440a91.0
        for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 01:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761120382; x=1761725182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7pd1xamI1Z87Z/xGHN+zpZ0EaiU7Q5JCHed+8W4tHa8=;
        b=OT+7p63A8dISxStTvo9VrMpayqSkKAjaP1vSYqkVnPTCZd63OD5So4W/qdMytcc5JV
         RPpef6kzJf3PsKWDy9CssdnYD1lko9oVffl0irluGLkB0WMoV96K1KMdPX6eYFOpE79R
         uIH+zEh1XQyeWsEIfm1gL4VaQM8FtzNgrMQ7zKLOl7X6d9LIJnk9fSYnf7Vs+mvgGni8
         zx8S8jiIkzlOX7r5Tao4NET6l/ob2SvDodsizlT/EadDIgxFdsjkOmgjJVzsRvoEMe/r
         U7efk7mq6X2fY9bMIN0Sposqgmqt2irN65wIqCQmH8KeYwnZsAAJunp4qHwHwb5bbpiO
         nwAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761120382; x=1761725182;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7pd1xamI1Z87Z/xGHN+zpZ0EaiU7Q5JCHed+8W4tHa8=;
        b=oEAkDIcaVy55sZLdtlgePpwkTvZQUPpSkKPv8kz8cD+suwaZzr2i3HOOTDpQEWZbCh
         1AgarPpEcG6WaFgrl/lt4SwQbrU0c2y+TBqk7sM6WK9uBlAM2YAWRG29+wAnydF53NL6
         z0QqLPjiQA5k1e4dlNOaH/1qmrHLpPEMzi2NS85wRyZBsaCnYDSQkyzgRC9PqL92PS24
         Wkza8Gxivqe2UXHRPLfJmOqQsPiBAlQTgWlwI1zMf+rKgl4fAwDc2UJnZOXLPRlAey4T
         K89DBrgG2pgfx78aJNFW2bEBQXlhuwCXHUkvScG51zGmJiXZ4X1Egb4tq7sXh+bV2iSx
         s98A==
X-Forwarded-Encrypted: i=1; AJvYcCWiZ+y9orGjGG2uwqAU/6riBltTiA8nczvw7uXoXZUVgn/Y9TgwpJD8Mj9/nDs1PL7baX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuqTSE/L36PPd0wAeoyNig0ejoJUTXQIuX66+fSqrJB2t9X2Aa
	0jGuDtTTQ5bZpqRlsrSLL23zYwpXpOxJgyl6gHb081Zn2CTWtZEGCJtC
X-Gm-Gg: ASbGncvf1NhoG8VC+zOTE0xwDNeD7fcdsf7LKZYcRxGpm56WcPYYekqk5GBZbTMGHw8
	S/gBnj8GAvxASL5OFFq7vjeR9LBJ8yFBKqdUriZJbkVj6a+dnK1FMat408yhsmhSH0VmQn9FByT
	he21a2An+O0SHHqJ9Oj54CXJ4p1yhtBs9xeIClUeL5idvxemr9q3YXXLf6ZwL+wpra+2BAVvRTq
	DPIxcq6RNG5uDZg4kH7VTgtU4HnqqA/5jk1pEE53gMZRZBwkgVfS1aiTHgwYV62FiGK7TtPNwq4
	Hi2Jt5mPob5wdXBDEuS4xuvvuqXhLCl6Min175pU8vKurSG7mHUsndaylvl4OBgM5JBTOkrYaDl
	B4Qp4WblUyS1vofZA7UUHezGjWkuPLeQNe6StpJslX10jhiwLBZpfxbwYWtY2BOzyFO1ogDQXXG
	I16c9B8Dc=
X-Google-Smtp-Source: AGHT+IE70+TREWXzMJPqDOGvy7TIW4dMzKInSqb2lFkSA22INPn9248XY9+0iTdOyzuydSqJYdoiQQ==
X-Received: by 2002:a17:90b:3942:b0:336:b60f:3936 with SMTP id 98e67ed59e1d1-33bcf87ab20mr29204108a91.12.1761120382423;
        Wed, 22 Oct 2025 01:06:22 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e223c7fb5sm1805330a91.2.2025.10.22.01.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 01:06:21 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	jolsa@kernel.org
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	mattbobrowski@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	leon.hwang@linux.dev,
	jiang.biao@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 08/10] selftests/bpf: add testcases for tracing session
Date: Wed, 22 Oct 2025 16:06:11 +0800
Message-ID: <20251022080613.555463-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.1.dirty
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add testcases for BPF_TRACE_SESSION.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 .../selftests/bpf/prog_tests/fsession_test.c  |  95 ++++++++++
 .../selftests/bpf/progs/fsession_test.c       | 175 ++++++++++++++++++
 2 files changed, 270 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fsession_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/fsession_test.c

diff --git a/tools/testing/selftests/bpf/prog_tests/fsession_test.c b/tools/testing/selftests/bpf/prog_tests/fsession_test.c
new file mode 100644
index 000000000000..d70bdb683691
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/fsession_test.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 ChinaTelecom */
+#include <test_progs.h>
+#include "fsession_test.skel.h"
+
+static int check_result(struct fsession_test *skel)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	int err, prog_fd;
+
+	/* Trigger test function calls */
+	prog_fd = bpf_program__fd(skel->progs.test1);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	if (!ASSERT_OK(err, "test_run_opts err"))
+		return err;
+	if (!ASSERT_OK(topts.retval, "test_run_opts retval"))
+		return topts.retval;
+
+	for (int i = 0; i < sizeof(*skel->bss) / sizeof(__u64); i++) {
+		if (!ASSERT_EQ(((__u64 *)skel->bss)[i], 1, "test_result"))
+			return -EINVAL;
+	}
+
+	/* some fields go to the "data" sections, not "bss" */
+	for (int i = 0; i < sizeof(*skel->data) / sizeof(__u64); i++) {
+		if (!ASSERT_EQ(((__u64 *)skel->data)[i], 1, "test_result"))
+			return -EINVAL;
+	}
+	return 0;
+}
+
+static void test_fsession_basic(void)
+{
+	struct fsession_test *skel = NULL;
+	int err;
+
+	skel = fsession_test__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "fsession_test__open_and_load"))
+		goto cleanup;
+
+	err = fsession_test__attach(skel);
+	if (!ASSERT_OK(err, "fsession_attach"))
+		goto cleanup;
+
+	check_result(skel);
+cleanup:
+	fsession_test__destroy(skel);
+}
+
+static void test_fsession_reattach(void)
+{
+	struct fsession_test *skel = NULL;
+	int err;
+
+	skel = fsession_test__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "fsession_test__open_and_load"))
+		goto cleanup;
+
+	/* First attach */
+	err = fsession_test__attach(skel);
+	if (!ASSERT_OK(err, "fsession_first_attach"))
+		goto cleanup;
+
+	if (check_result(skel))
+		goto cleanup;
+
+	/* Detach */
+	fsession_test__detach(skel);
+
+	/* Reset counters */
+	memset(skel->bss, 0, sizeof(*skel->bss));
+
+	/* Second attach */
+	err = fsession_test__attach(skel);
+	if (!ASSERT_OK(err, "fsession_second_attach"))
+		goto cleanup;
+
+	if (check_result(skel))
+		goto cleanup;
+
+cleanup:
+	fsession_test__destroy(skel);
+}
+
+void test_fsession_test(void)
+{
+#if !defined(__x86_64__)
+	test__skip();
+	return;
+#endif
+	if (test__start_subtest("fsession_basic"))
+		test_fsession_basic();
+	if (test__start_subtest("fsession_reattach"))
+		test_fsession_reattach();
+}
diff --git a/tools/testing/selftests/bpf/progs/fsession_test.c b/tools/testing/selftests/bpf/progs/fsession_test.c
new file mode 100644
index 000000000000..3a756272374d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/fsession_test.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 ChinaTelecom */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+__u64 test1_entry_result = 0;
+__u64 test1_exit_result = 0;
+
+SEC("fsession/bpf_fentry_test1")
+int BPF_PROG(test1, int a, int ret)
+{
+	bool is_exit = bpf_tracing_is_exit(ctx);
+
+	if (!is_exit) {
+		/* This is entry */
+		test1_entry_result = a == 1 && ret == 0;
+		/* Return 0 to allow exit to be called */
+		return 0;
+	}
+
+	/* This is exit */
+	test1_exit_result = a == 1 && ret == 2;
+	return 0;
+}
+
+__u64 test2_entry_result = 0;
+__u64 test2_exit_result = 1;
+
+SEC("fsession/bpf_fentry_test2")
+int BPF_PROG(test2, int a, __u64 b, int ret)
+{
+	bool is_exit = bpf_tracing_is_exit(ctx);
+
+	if (!is_exit) {
+		/* This is entry */
+		test2_entry_result = a == 2 && b == 3 && ret == 0;
+		/* Return non-zero value to block exit call */
+		return 1;
+	}
+
+	/* This is exit - should not be called due to blocking */
+	test2_exit_result = 0;
+	return 0;
+}
+
+__u64 test3_entry_result = 0;
+__u64 test3_exit_result = 0;
+
+SEC("fsession/bpf_fentry_test3")
+int BPF_PROG(test3, char a, int b, __u64 c, int ret)
+{
+	bool is_exit = bpf_tracing_is_exit(ctx);
+
+	if (!is_exit) {
+		test3_entry_result = a == 4 && b == 5 && c == 6 && ret == 0;
+		return 0;
+	}
+
+	test3_exit_result = a == 4 && b == 5 && c == 6 && ret == 15;
+	return 0;
+}
+
+__u64 test4_entry_result = 0;
+__u64 test4_exit_result = 0;
+
+SEC("fsession/bpf_fentry_test4")
+int BPF_PROG(test4, void *a, char b, int c, __u64 d, int ret)
+{
+	bool is_exit = bpf_tracing_is_exit(ctx);
+
+	if (!is_exit) {
+		test4_entry_result = a == (void *)7 && b == 8 && c == 9 && d == 10 && ret == 0;
+		return 0;
+	}
+
+	test4_exit_result = a == (void *)7 && b == 8 && c == 9 && d == 10 && ret == 34;
+	return 0;
+}
+
+__u64 test5_entry_result = 0;
+__u64 test5_exit_result = 0;
+
+SEC("fsession/bpf_fentry_test5")
+int BPF_PROG(test5, __u64 a, void *b, short c, int d, __u64 e, int ret)
+{
+	bool is_exit = bpf_tracing_is_exit(ctx);
+
+	if (!is_exit) {
+		test5_entry_result = a == 11 && b == (void *)12 && c == 13 && d == 14 &&
+			e == 15 && ret == 0;
+		return 0;
+	}
+
+	test5_exit_result = a == 11 && b == (void *)12 && c == 13 && d == 14 &&
+		e == 15 && ret == 65;
+	return 0;
+}
+
+__u64 test6_entry_result = 0;
+__u64 test6_exit_result = 1;
+
+SEC("fsession/bpf_fentry_test6")
+int BPF_PROG(test6, __u64 a, void *b, short c, int d, void *e, __u64 f, int ret)
+{
+	bool is_exit = bpf_tracing_is_exit(ctx);
+
+	if (!is_exit) {
+		test6_entry_result = a == 16 && b == (void *)17 && c == 18 && d == 19 &&
+			e == (void *)20 && f == 21 && ret == 0;
+		return 1;
+	}
+
+	test6_exit_result = 0;
+	return 0;
+}
+
+__u64 test7_entry_result = 0;
+__u64 test7_exit_result = 0;
+
+SEC("fsession/bpf_fentry_test7")
+int BPF_PROG(test7, struct bpf_fentry_test_t *arg, int ret)
+{
+	bool is_exit = bpf_tracing_is_exit(ctx);
+
+	if (!is_exit) {
+		if (!arg)
+			test7_entry_result = ret == 0;
+		return 0;
+	}
+
+	if (!arg)
+		test7_exit_result = 1;
+	return 0;
+}
+
+__u64 test8_entry_result = 0;
+__u64 test8_exit_result = 1;
+/*
+ * test1, test8 and test9 hook the same target to verify the "ret" is always
+ * 0 in the entry.
+ */
+SEC("fsession/bpf_fentry_test1")
+int BPF_PROG(test8, int a, int ret)
+{
+	bool is_exit = bpf_tracing_is_exit(ctx);
+
+	if (!is_exit) {
+		test8_entry_result = a == 1 && ret == 0;
+		return -21;
+	}
+
+	/* This is exit */
+	test8_exit_result = 0;
+	return 0;
+}
+
+__u64 test9_entry_result = 0;
+__u64 test9_exit_result = 1;
+
+SEC("fsession/bpf_fentry_test1")
+int BPF_PROG(test9, int a, int ret)
+{
+	bool is_exit = bpf_tracing_is_exit(ctx);
+
+	if (!is_exit) {
+		test9_entry_result = a == 1 && ret == 0;
+		return -22;
+	}
+
+	test9_exit_result = 0;
+	return 0;
+}
-- 
2.51.1.dirty


