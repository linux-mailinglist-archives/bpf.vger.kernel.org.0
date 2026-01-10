Return-Path: <bpf+bounces-78471-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED869D0D754
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 15:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4428130A131E
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 14:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE50346AC3;
	Sat, 10 Jan 2026 14:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2Fllsc1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA573451AE
	for <bpf@vger.kernel.org>; Sat, 10 Jan 2026 14:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768054388; cv=none; b=H7HiNIpaAB1KA/XuvVT+nO7r9FlDtQjvCrvSAz5CTA/kj5nbHqWuPiFDV87biZmqYUIK/Fx3Z/X2f6adye8nDsMVBJnFeuQwQnW+9fpmb1LpjOqwQBv7iFVs9R86ew8KjlHVG8e4oRpDttafM2TSvQDdM1OMB60XDh3gxhmVI8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768054388; c=relaxed/simple;
	bh=Okg9SIzWIdxMYL9OMbZo8y/oAOt76F10doefVGdAQU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lC4I6YO+Xy/VsEcGsknHuqeAASMPdyIzQowM2lfMFjQFH1WOu8dc6OtVW+uqJUSGJKyzBjKtoUk9ZlMX8311d7/bcIkvO8DzNo0souZgyDMC6IBPuPHg9LYQ8P/+7MY8S88lNLFBJA88IUGbDxpnw4HKXaF8O4iJej0ogo9YCrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2Fllsc1; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-34c9edf63a7so4165516a91.1
        for <bpf@vger.kernel.org>; Sat, 10 Jan 2026 06:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768054386; x=1768659186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QR5rrRd0ZsuEPPqW5q3lZCBR9ClfGRJ1620B6u4R4tA=;
        b=P2Fllsc17PcUMbduVMft5KaW+uAJL0sG6QdDhvD5mhUZfFBPxMOo46tQqzsQFTjMD+
         0NnIJoAePKKf+/HEw6AxAeo6MPBN3bc/IUsy4fxV0jQh+ELctfLovroNupqYgDRY5K5/
         q7oPXd9xgxVGFpo24nVm1TUgmoNUvjXqG5sMWrK6YLHlNTyK0w/wx5hKTkY+wWoiV+o9
         h4S4tigcDfXWpgs3HHb6fIMEKYLVwNnDbI/SUqracpygpoXDB1YFfWM6h1i4xsnqMytT
         fg+Tj2C6Kh4L0px6T0tjbJV9/0glkiBHdXC3xppsS7yVhYrAAkpvhdsXfGtI4VYmKbbz
         GAUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768054386; x=1768659186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QR5rrRd0ZsuEPPqW5q3lZCBR9ClfGRJ1620B6u4R4tA=;
        b=lSxmZAYx0DXfORO3n0fgTuEpC5kSeETNMUqCjwvVlZYIqR3mMDYStLr3jz0JGFOCDS
         4jB8dDzfxfWf5Yoo2SrUTnPce8gdksh8dgvHEYi39f32+oeB2GXsfUp2H931TIw6Av0J
         iOIKtHMhYKRY+KMzKOD5coV1OVOJ5DOJagZBTEJpBljO7C7my/dSdeMwCjLqVwxvB1b3
         yv0Uut80iAXcRJj4FviYVgQUUHGvF4eLNokBTbuH8L9rhYLzL6ySiDa5QbNvt/SAff7J
         B41WVFZ1Q2irkYVi2SRr3ObqWYgkJAXUGgAK4gndAwYXjc/Li6EdSDubp6n+VqN7sEoD
         Hz6w==
X-Forwarded-Encrypted: i=1; AJvYcCUH+p2y/NUzcnnbv0+Biv5x+sZ/yEDILrM347Jy1dpi2i7iwZydhiDEiG0KPo/hNmuqUGo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+OPxHCfZQoT23pHr99CSlbGdjnoszp7sBvRMYYI7JsovpI3ai
	u25+5vvUHfCMOMpQ8EQFZFuqaOCW+vfuoC/AaBVm31NCqE3NIk8giX5K
X-Gm-Gg: AY/fxX7CvJBArICGVhvRQJ8f9gzJuILeXG60apj6sC7uTij/vK3FQ+R6os27MoJkZdB
	67hnEa75Qs24+n8KRpiZOsbQYky4O7ogGOzmtvNIZHpTzDbtMONO9UTic/ZsTxQIY/yEsiT+X+o
	f/ppQWAOoccgLdl9EG6/zaaxSKbZIE8z5lL+C7WiRZ8g+RtCD5tNVUWb+aSfzOaG7vWA75ZReQf
	fALmXFaiNIsOr+y6K3AHHps/tndw3k3/vkefXrrjQkexWXIb8lts67Y7EneDd38B4RMRPMrDzvj
	3eRshU5vIYhF0R7jOxLpx6U91OM7q5Hqo5nkbkQGaKuogwBRkOBgG5mWm0fiE8Yyt1+HUXEg70B
	wgautE78Fucu1hn3Vr12YnTZCemix8VtghKAb0SwP72C2mKhOkCSqd2RdjM2G//2WZtQg+bg40h
	URg2SmgcMBTN0jNN/D8w==
X-Google-Smtp-Source: AGHT+IEn+HozHWZxnnFJhS/KnptuMtU1nPh2Q3TwlqhZv2EqRCTWGbbvXEux/xaLbJxhfikKFzUSsw==
X-Received: by 2002:a17:90b:57e6:b0:340:2a59:45c6 with SMTP id 98e67ed59e1d1-34f68c7a89fmr13085852a91.4.1768054386458;
        Sat, 10 Jan 2026 06:13:06 -0800 (PST)
Received: from 7950hx ([160.187.0.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81f42658f03sm1481079b3a.20.2026.01.10.06.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 06:13:06 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	jiang.biao@linux.dev,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v9 09/11] selftests/bpf: add testcases for fsession
Date: Sat, 10 Jan 2026 22:11:13 +0800
Message-ID: <20260110141115.537055-10-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260110141115.537055-1-dongml2@chinatelecom.cn>
References: <20260110141115.537055-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add testcases for BPF_TRACE_FSESSION. The function arguments and return
value are tested both in the entry and exit. And the kfunc
bpf_session_is_ret() is also tested.

As the layout of the stack changed for fsession, so we also test
bpf_get_func_ip() for it.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v3:
- restructure the testcase by combine the testcases for session cookie and
  get_func_ip into one patch
---
 .../selftests/bpf/prog_tests/fsession_test.c  |  90 ++++++++++++++
 .../selftests/bpf/progs/fsession_test.c       | 110 ++++++++++++++++++
 2 files changed, 200 insertions(+)
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
index 000000000000..f504984d42f2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/fsession_test.c
@@ -0,0 +1,110 @@
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
+	bool is_exit = bpf_session_is_return(ctx);
+
+	if (!is_exit) {
+		test1_entry_result = a == 1 && ret == 0;
+		return 0;
+	}
+
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
+	bool is_exit = bpf_session_is_return(ctx);
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
+	bool is_exit = bpf_session_is_return(ctx);
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
+	bool is_exit = bpf_session_is_return(ctx);
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
+	bool is_exit = bpf_session_is_return(ctx);
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
+SEC("fsession/bpf_fentry_test1")
+int BPF_PROG(test6, int a)
+{
+	__u64 addr = bpf_get_func_ip(ctx);
+
+	if (bpf_session_is_return(ctx))
+		test6_exit_result = (const void *) addr == &bpf_fentry_test1;
+	else
+		test6_entry_result = (const void *) addr == &bpf_fentry_test1;
+	return 0;
+}
-- 
2.52.0


