Return-Path: <bpf+bounces-72210-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1DCC0A1FC
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 04:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B48418A5A30
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 03:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EF826B942;
	Sun, 26 Oct 2025 03:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K21sRyDk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043F326C3B0
	for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 03:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761447746; cv=none; b=Zk8jO3xWujsxAN8FxEs/gpo0hsf7zXeoH95Wh6Lu9Ubof5DKP20Vwzdj2UN5cmVjMBhvn/aI/OojnNrnw18uLpl64K8expBaF0A841vTb+juvKwIQJgHDhbkMo35px6RdwOF0xlO4x6PmgaVfptbJI/o0K0Il75MgA4HNgH3Cb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761447746; c=relaxed/simple;
	bh=WtEw/cOnIurjZ3m4c1DDzrlB/+T+8TwDeq57Z/EA/sY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gA6ltlhahvfjBQFjoZf0MPQJgepyf0DqloqMZk6AXlQxc8ZAfzqQR+OF0SKk0EW4Sjoyf9LSgZRW5rVy9k8wfL3XbfAdANP3g5PFu5rhPACWio8JzPVWTPNB9CRfV5y7N6dSXQYC5+FngksTNRRLyYd40Je82L96gNqt8M+AjrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K21sRyDk; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-b4fb8d3a2dbso2235556a12.3
        for <bpf@vger.kernel.org>; Sat, 25 Oct 2025 20:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761447744; x=1762052544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Si0SffDooGR2dYlH1den/9FtyvBKYH381FHeTTZ5tGs=;
        b=K21sRyDkPD46xcN941DHsqTvzR/xwkUUt0FXI4L+XfLuLyBoVFC4cUazZtSKofTUgL
         0nFqXG3KDL8JGWiXq5OQtk0CkXWkiF++1aglI3Zp1Ig6IQ3F+UHFKkPGVvW7edSufhdm
         grqZzvcLRGtMF3/Z5lvECS1VVrSvSaIZnJQDWGcdphHiP8TV672IvlUlbP8Xk73XW+pc
         kN43VZgVPAUQjz8gSenW+C51y/1ZQFbIHNhl4dO59+0pZmYGm3AaHv6sNXLziTdqR9ho
         n+rdOKHkRhCbTwQZ3xA4B8WtSGJRKMhLwFJwCdSGrkON4GnN+8FPexgOpc15Xrv6a9m5
         Qyiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761447744; x=1762052544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Si0SffDooGR2dYlH1den/9FtyvBKYH381FHeTTZ5tGs=;
        b=tEGpKHsqq+vnVp5jLkP0LgaEMrKdhQYBnT6ycRH6cBEQ+VYsm0a+YHF4pbPhgd3zFf
         CwqZDjYyr9mWfao3VtBNjUshyPNvdyafRgNZO9YWMg5u+zvoFxnT7c/ve+sY/2McMmV1
         ddi3bMyjN62AGWdpDjL8PjfWkY8CiINV01spODwUWy3Py3o+wdH/BxqD+JmKT/0G6M2r
         CpFKtZg8ehLcWFRye6iTPJWvMYCZkELdwy6W1yX4zvB9DTQXKX/RNPZYDhAOrzNVpla2
         yLchJ+VcX9PvmlDpy1Ac+bfY7+JNcy6u25UJ0txnEn3aoCqzNfnwMDFsou7mCXFhOCMk
         2l1Q==
X-Forwarded-Encrypted: i=1; AJvYcCW2KvlV6E1M/WRag5sG2VOHNQ9BFfuAK/9Z3f/pbX6W5r7V59x/EbeZE26Wd1giJA7bpDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYzwkBSXRQIbKHstUTql6dthGL50FeMvRQAExw515QSH/Jzgu3
	zY3OX6RWnJorJn/wpPMVA8sGMNfDkLH+kIcu+J+ex7PUs1StLBPx3htw
X-Gm-Gg: ASbGncvpe2Gop4kUAPrDAUFQ0ESi8NgM6i2rtNvUuRDBxPbVsX4OuSESeVf85s2wYG1
	jicWBDAMaAsI+xGimzJxumGRyY9kqpCYy/ScONS/GVe9sUUMUxzMTl376q2i5AXaisAUd0oS5EY
	F50JcMjSbtIhFZFLpE8yDEwem4RaWHJEiWze/dxefbUoTh3CLtq4eJwhjn+/B6Hw1skAzLNCV41
	P0wj/brDRdbpvLGiJg9tz/bBqV7HF4uhvQGoKOUeoeVjyUqRegdry/0CLMo1xxS1aPepzsWTnQT
	ZOBqvUVpGM9KpzUvkO5CyccvA59BgStACiPTmpJM6w0+LMw8cKmc/wMPje3O8pKAM07x7HnOEU/
	OvARt34O2bEc4ak3GKjUXDbAihXkTsNRuGrjdXaSrrRVOPp6IfhaeZuRgN0Ey+0VezCN7T+eY3y
	8+Ncdn553irRc=
X-Google-Smtp-Source: AGHT+IHlzYi1dMbND3J1xueB/jEv3yr7i0N8IqA07LDawWDPwJ+iwjzjlbdeHd3+1ADunZ4o9urv7g==
X-Received: by 2002:a17:903:19e6:b0:273:31fb:a872 with SMTP id d9443c01a7336-290c9c89c81mr423036545ad.6.1761447744266;
        Sat, 25 Oct 2025 20:02:24 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d40b1esm38100645ad.73.2025.10.25.20.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 20:02:23 -0700 (PDT)
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
	leon.hwang@linux.dev,
	jiang.biao@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 6/7] selftests/bpf: add testcases for tracing session
Date: Sun, 26 Oct 2025 11:01:42 +0800
Message-ID: <20251026030143.23807-7-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251026030143.23807-1-dongml2@chinatelecom.cn>
References: <20251026030143.23807-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add testcases for BPF_TRACE_SESSION. The function arguments and return
value are tested both in the entry and exit. And the kfunc
bpf_tracing_is_exit() is also tested.

As the layout of the stack changed for fsession, so we also test
bpf_get_func_ip() for it.

Session cookie for fsession is also tested. Multiple fsession BPF progs is
attached to bpf_fentry_test1() and session cookie is read and write in
the testcase.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v3:
- restructure the testcase by combine the testcases for session cookie and
  get_func_ip into one patch
---
 .../selftests/bpf/prog_tests/fsession_test.c  |  95 ++++++++
 .../selftests/bpf/progs/fsession_test.c       | 230 ++++++++++++++++++
 2 files changed, 325 insertions(+)
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
index 000000000000..8f266d8e4b55
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/fsession_test.c
@@ -0,0 +1,230 @@
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
+
+__u64 test10_entry_result = 0;
+__u64 test10_exit_result = 0;
+SEC("fsession/bpf_fentry_test1")
+int BPF_PROG(test10, int a)
+{
+	__u64 addr = bpf_get_func_ip(ctx);
+
+	if (bpf_tracing_is_exit(ctx))
+		test10_exit_result = (const void *) addr == &bpf_fentry_test1;
+	else
+		test10_entry_result = (const void *) addr == &bpf_fentry_test1;
+	return 0;
+}
+
+__u64 test11_entry_ok = 0;
+__u64 test11_exit_ok = 0;
+SEC("fsession/bpf_fentry_test1")
+int BPF_PROG(test11, int a)
+{
+	__u64 *cookie = bpf_fsession_cookie(ctx);
+
+	if (!bpf_tracing_is_exit(ctx)) {
+		if (cookie) {
+			*cookie = 0xAAAABBBBCCCCDDDDull;
+			test11_entry_ok = *cookie == 0xAAAABBBBCCCCDDDDull;
+		}
+		return 0;
+	}
+
+	if (cookie)
+		test11_exit_ok = *cookie == 0xAAAABBBBCCCCDDDDull;
+	return 0;
+}
+
+__u64 test12_entry_ok = 0;
+__u64 test12_exit_ok = 0;
+
+SEC("fsession/bpf_fentry_test1")
+int BPF_PROG(test12, int a)
+{
+	__u64 *cookie = bpf_fsession_cookie(ctx);
+
+	if (!bpf_tracing_is_exit(ctx)) {
+		if (cookie) {
+			*cookie = 0x1111222233334444ull;
+			test12_entry_ok = *cookie == 0x1111222233334444ull;
+		}
+		return 0;
+	}
+
+	if (cookie)
+		test12_exit_ok = *cookie == 0x1111222233334444ull;
+	return 0;
+}
-- 
2.51.1


