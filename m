Return-Path: <bpf+bounces-76853-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F552CC6F3A
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 11:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 82A2F306EF33
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 09:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFFF343D71;
	Wed, 17 Dec 2025 09:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THbPkt3c"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7633431E4
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 09:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765965349; cv=none; b=a4IgoWp3xlaJaqhiQA4ClWMpoK1SR7XS8klVbpUD9bgXFeO5GYaND7SDjXT3d6H9/AvwuOIPRQIKq97kLlxdAXsZCkuz8NKK3NUr4nvyvbAZlFmh2l/iCasQ+M0VCVmytiJsBGd1G7gItCt8dkRsrZsQJxGjeuvE5yc71HvQPcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765965349; c=relaxed/simple;
	bh=Cr2r8qD8ZWRFZUO9C+91nA66i7GFwEZnV+6CkrHW6vY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ubo5TEienz94lIp2eCFCoTv+UhHbBjEYFp5ec6MJAUMtsvAFGPJa9J9JYfa8mU4cNpeh4gVNcLd95Fmg17nw3AcahIfdXWNzraSerltGoxRYfNhYBYvyEp59EgNOhDIGBU7KgDgVoaDl/tUy0EQpbRmman1j4vad7I1xeOhNOnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THbPkt3c; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2a0c20ee83dso41457365ad.2
        for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 01:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765965346; x=1766570146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0J31z4SW8kSTDfjblM9XS54ZD7hbsR0g1QvNBMlKhxY=;
        b=THbPkt3chSTBeFHnWpTZXydZj30o55wXxMiFG70j7MXXbpn8r1eAsAz/GT64lUTuC6
         DYT7gTIQMwKDvYRKsnpBclgVOXN80WpLN5VPsFuOOh0Sx7wWK2JRB9XT7H97gySTa5Xe
         rJNUB+KRApYdqr0CW9Fdo5n0T4i+X4/LkPyFHDt2sGzqafBAatgjvpdLNYi0wsg5604N
         GgfCYB4d2X3y1Ei56fOyAapHBKa4Wmj6Fp85Yc0/bVHZbZ3ZytDmzhO/9i6P+ldp81p/
         o3WEKR+AKwEUL64pF3dSRzD7UXN9bGubzrT+KI+1WF1wSrs0d8ZlLpVcek4r78R8ttvn
         Vqmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765965346; x=1766570146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0J31z4SW8kSTDfjblM9XS54ZD7hbsR0g1QvNBMlKhxY=;
        b=BL+8BakqRyEUMW9pZTT68Ygjinjb2+NJya3kTQHh45+/Dh/mln0aQqpsFfwTdwe0S1
         OdoaVFBMxVkCaceEpjLDvBrwCsjWmDgjDN/0kfYA28WLP47pj8Zptt0t/fWwyS6wtlBI
         K8GBleZjbim+TzIji0sotB2jIMCg2nRksL/SAbBxS5bQm7l2oqmLofYrJwRY1BRFrNjM
         2SZwkmpVh6QCIfB4cqV/KIpceNPPGwl4/MS9Pk2ggohvqk5P/JQ0yTy17B1ASpDBcSSD
         7089pktHskgEyTE72lpqfPkmAizSgYlT20Q/YCuJfXxP8PI/5M/7o7Y7rTMABMr9ZIIc
         mzfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUg25Vy6LBIe2ov0HcDOjMeN7PiJ73kGYzTQrKGp+lmwxvRPFntP3k660aodHhLOVY3HaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVTJo2G+Yl98jED9ySKNAikAIdiINqbcks8JJt5YPFYKrJBcHJ
	ntLNiXpW9iC0H4PgQayE6q3BT7QHLfYO1ZFzzTMXzI6OomlGXxwj/U/o
X-Gm-Gg: AY/fxX52ZpsHDhOOZJtHpFvzHC/l4orDutfNHzrJFLSHQQAgCa3v+9edUNvNk9ky6Vo
	1PD/058LiNH0dsVacWeqmTfrOy0S7di0ljf3m1xh49DTuonhLQ09v8K3HMJrUEw01fBJqbojIUH
	w0tjDYA/JcCp3k4ajAAWGMorZdWkRH+EqE0qma5SkJKOjK7uFDRrQkdtSQ04aJaITm85LrBq/+p
	+G4QuQ9EE0Hpy4fL0RJFidiAflLxKYSkFMXnN38m7ikrwea3EstBy3N8yQrYHClUyCgXkR3DS9Z
	OSjHilbbp/Hx6xdyZRQJk48nEwzmDfgysA+r0xonwUtgMs+Yu1YnPprzCi6drfLx9m9tuAWZbFj
	iCr/W19b8h19m6hEqiKkHskDAQEEa5g83Lj5g65BXWJrypM2S5peKYbNS3ktPcrfjJ7xTpde+1D
	Mrk7FUlyw=
X-Google-Smtp-Source: AGHT+IGKNgea5xK7/Mf38nTbcPf7/sUVgupdhael53Zs4BVPA7pk2NAb9QT1LP+wMqe8Dut8oqyncg==
X-Received: by 2002:a17:902:f549:b0:29f:29ae:8733 with SMTP id d9443c01a7336-29f29ae8938mr168934205ad.53.1765965345836;
        Wed, 17 Dec 2025 01:55:45 -0800 (PST)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a07fa0b1aasm140715945ad.3.2025.12.17.01.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 01:55:45 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	andrii@kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v4 8/9] selftests/bpf: add testcases for tracing session
Date: Wed, 17 Dec 2025 17:54:44 +0800
Message-ID: <20251217095445.218428-9-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251217095445.218428-1-dongml2@chinatelecom.cn>
References: <20251217095445.218428-1-dongml2@chinatelecom.cn>
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
 .../selftests/bpf/prog_tests/fsession_test.c  |  90 ++++++++
 .../selftests/bpf/progs/fsession_test.c       | 192 ++++++++++++++++++
 2 files changed, 282 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fsession_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/fsession_test.c

diff --git a/tools/testing/selftests/bpf/prog_tests/fsession_test.c b/tools/testing/selftests/bpf/prog_tests/fsession_test.c
new file mode 100644
index 000000000000..83f3953a1ff6
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/fsession_test.c
@@ -0,0 +1,90 @@
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
index 000000000000..f7c96ef1c7a9
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/fsession_test.c
@@ -0,0 +1,192 @@
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
+	bool is_exit = bpf_fsession_is_return(ctx);
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
+__u64 test2_exit_result = 0;
+
+SEC("fsession/bpf_fentry_test3")
+int BPF_PROG(test2, char a, int b, __u64 c, int ret)
+{
+	bool is_exit = bpf_fsession_is_return(ctx);
+
+	if (!is_exit) {
+		test2_entry_result = a == 4 && b == 5 && c == 6 && ret == 0;
+		return 0;
+	}
+
+	test2_exit_result = a == 4 && b == 5 && c == 6 && ret == 15;
+	return 0;
+}
+
+__u64 test3_entry_result = 0;
+__u64 test3_exit_result = 0;
+
+SEC("fsession/bpf_fentry_test4")
+int BPF_PROG(test3, void *a, char b, int c, __u64 d, int ret)
+{
+	bool is_exit = bpf_fsession_is_return(ctx);
+
+	if (!is_exit) {
+		test3_entry_result = a == (void *)7 && b == 8 && c == 9 && d == 10 && ret == 0;
+		return 0;
+	}
+
+	test3_exit_result = a == (void *)7 && b == 8 && c == 9 && d == 10 && ret == 34;
+	return 0;
+}
+
+__u64 test4_entry_result = 0;
+__u64 test4_exit_result = 0;
+
+SEC("fsession/bpf_fentry_test5")
+int BPF_PROG(test4, __u64 a, void *b, short c, int d, __u64 e, int ret)
+{
+	bool is_exit = bpf_fsession_is_return(ctx);
+
+	if (!is_exit) {
+		test4_entry_result = a == 11 && b == (void *)12 && c == 13 && d == 14 &&
+			e == 15 && ret == 0;
+		return 0;
+	}
+
+	test4_exit_result = a == 11 && b == (void *)12 && c == 13 && d == 14 &&
+		e == 15 && ret == 65;
+	return 0;
+}
+
+__u64 test5_entry_result = 0;
+__u64 test5_exit_result = 0;
+
+SEC("fsession/bpf_fentry_test7")
+int BPF_PROG(test5, struct bpf_fentry_test_t *arg, int ret)
+{
+	bool is_exit = bpf_fsession_is_return(ctx);
+
+	if (!is_exit) {
+		if (!arg)
+			test5_entry_result = ret == 0;
+		return 0;
+	}
+
+	if (!arg)
+		test5_exit_result = 1;
+	return 0;
+}
+
+__u64 test6_entry_result = 0;
+__u64 test6_exit_result = 0;
+/*
+ * test1, test8 and test9 hook the same target to verify the "ret" is always
+ * 0 in the entry.
+ */
+SEC("fsession/bpf_fentry_test1")
+int BPF_PROG(test6, int a, int ret)
+{
+	bool is_exit = bpf_fsession_is_return(ctx);
+
+	if (!is_exit) {
+		test6_entry_result = a == 1 && ret == 0;
+		return 0;
+	}
+
+	/* This is exit */
+	test6_exit_result = 1;
+	return 0;
+}
+
+__u64 test7_entry_result = 0;
+__u64 test7_exit_result = 0;
+
+SEC("fsession/bpf_fentry_test1")
+int BPF_PROG(test7, int a, int ret)
+{
+	bool is_exit = bpf_fsession_is_return(ctx);
+
+	if (!is_exit) {
+		test7_entry_result = a == 1 && ret == 0;
+		return 0;
+	}
+
+	test7_exit_result = 1;
+	return 0;
+}
+
+__u64 test8_entry_result = 0;
+__u64 test8_exit_result = 0;
+SEC("fsession/bpf_fentry_test1")
+int BPF_PROG(test8, int a)
+{
+	__u64 addr = bpf_get_func_ip(ctx);
+
+	if (bpf_fsession_is_return(ctx))
+		test8_exit_result = (const void *) addr == &bpf_fentry_test1;
+	else
+		test8_entry_result = (const void *) addr == &bpf_fentry_test1;
+	return 0;
+}
+
+__u64 test9_entry_ok = 0;
+__u64 test9_exit_ok = 0;
+SEC("fsession/bpf_fentry_test1")
+int BPF_PROG(test9, int a)
+{
+	__u64 *cookie = bpf_fsession_cookie(ctx);
+
+	if (!bpf_fsession_is_return(ctx)) {
+		if (cookie) {
+			*cookie = 0xAAAABBBBCCCCDDDDull;
+			test9_entry_ok = *cookie == 0xAAAABBBBCCCCDDDDull;
+		}
+		return 0;
+	}
+
+	if (cookie)
+		test9_exit_ok = *cookie == 0xAAAABBBBCCCCDDDDull;
+	return 0;
+}
+
+__u64 test10_entry_ok = 0;
+__u64 test10_exit_ok = 0;
+
+SEC("fsession/bpf_fentry_test1")
+int BPF_PROG(test10, int a)
+{
+	__u64 *cookie = bpf_fsession_cookie(ctx);
+
+	if (!bpf_fsession_is_return(ctx)) {
+		if (cookie) {
+			*cookie = 0x1111222233334444ull;
+			test10_entry_ok = *cookie == 0x1111222233334444ull;
+		}
+		return 0;
+	}
+
+	if (cookie)
+		test10_exit_ok = *cookie == 0x1111222233334444ull;
+	return 0;
+}
-- 
2.52.0


