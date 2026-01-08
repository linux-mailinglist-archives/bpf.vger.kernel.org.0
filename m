Return-Path: <bpf+bounces-78185-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2F8D00AD3
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 03:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 081CA3018C91
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 02:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB59299927;
	Thu,  8 Jan 2026 02:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f56cDIqp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A52292918
	for <bpf@vger.kernel.org>; Thu,  8 Jan 2026 02:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767839196; cv=none; b=Fia+IlCtavD562rwVynaVWWs6F1MSz9M5w6AJfauF1xdahRx9jkV7G5PNCVc5L+DkldmwkeHCShdtQ+0keesULEllLSQdqgsQHzjBF6MEsIlU6pmyISNMkAsoA8gzORIMTFrA+n93xvoiBllNGrf039JXs4INoyOR5gQABLTbfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767839196; c=relaxed/simple;
	bh=Okg9SIzWIdxMYL9OMbZo8y/oAOt76F10doefVGdAQU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OfQTZkZ25R3/ut+S82PWttD7moN2zLUUE3vOpxzsHD5PkDNdq4kVgpI05Ac5w2DAW9xtAXwd/+8IapXh5q8534DbybUE8sJ2gr6EZbLpfnIjuLdWLse0GvflIscS3xmJSJnZhG+QqLVIUBaIYd7SiHibV9gYfNg6j5Fcqw4kBdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f56cDIqp; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-78fba1a1b1eso24169347b3.1
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 18:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767839193; x=1768443993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QR5rrRd0ZsuEPPqW5q3lZCBR9ClfGRJ1620B6u4R4tA=;
        b=f56cDIqposY8TTtpUjoQmH5uAN4SjQBwBlIjtYZL4ukGgp0ZufhxraAHSZjOnodgxZ
         2zfFOwaeJbxkvxCq7MkeZ+c+pUJWyJxVxEKpTrd2rvL0jLj8xnv2GgHLOO2u/6cML/qV
         4hXezlkP2YPnEKKEa5//6U2VKg/fvVtVrQLUtGbTiy79d7P3zl5DoTBfeNOYVjRIN348
         dbZo5kjXjDrNe+1CyhchSJI/ywf9873lUYnh3SFb8ykLLQFgRUMnE2Z54/erQGmpgBh3
         BxwAZWjvzT0waBLdB+2fu5HlnNLBUr2WlUk2wni5A36amWWaDiqOoso+wghrSq9byni4
         5R5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767839193; x=1768443993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QR5rrRd0ZsuEPPqW5q3lZCBR9ClfGRJ1620B6u4R4tA=;
        b=U9RM/K4iyRf7CgU9oL93o4ZXfqP3PHhhl3zGNfpUdEpBT9hs6KMApX4VuwqzJ2SRf9
         XE6onJoTebFnHbWqzO0VpKiKTqT1gHI2fdPUVNCSmCutFepu5P2LG+ZNXRjJQowaXI+r
         NQ19mI+UJYdh/B2TGNeQIGoV+2Vvtb66e3tscGZ9ya06OWZTo1ze9Pg1XEw62T9kG70b
         /7qayTrfetBfIcYSxDemFT6+srXukg+WLwIpAX248CssrgeN8W474OQ4JxDyvVhLQ4yC
         rwAiEn6sUIufT/65KD36WJWnSfWWFI/JO+PuKppV9qLNXGI71EGTgygehQzSVc1Vr/C6
         dsFw==
X-Forwarded-Encrypted: i=1; AJvYcCVrlwcOuMDT+vomMJGwxOg5ph3g0+sy6SJaeashrzuodsDrRPYVdjubkXWGwGCKcUwoO5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLWQwE+8WQG0keDjUEM4uV9kRPAv/QWFJUK4ZGWmv97hGgBAtu
	uBGJLTyU7dkeNfWPWDuzwsGDHkfaebo46M1DajJQ9jUnVogqjwEU9XYp
X-Gm-Gg: AY/fxX60tMxnWR31y3ZlC3u13UYq/pDYzxB/57ZT2mQ3wwK6fTIleWdErBh3X+k5azs
	R0GdZiwgowsoouHQwiwVqgw+QOJyX+b3/l0BrBQhbCXhE1M8EXVWkQM/FnKi/AgbLBBnQz2tmed
	41JBdZeZ/03XtvNdOug+TXnQLWNF9CNJPMnlyNF1K7ZhHIubAZPGWrIxu/b6ottfg74zJZjDeDA
	tcPjnG3/CfPaEHI6QeO3n1pJmeqFiKsa7zPdO0dOBK2U05w0DKOmm0EBCpSCCkLCHDyr5KN6WJz
	9nDOd/YRWwMiYctT0irFweBjR//dWRjMOiBVbx0ZBP552KPMvWNYn/evV4ANzJWO14wTCmLTDt0
	yrHAaUzxUz5e5YgpcKQaYVE+xjn50r86WmmEgCMjvgaG1DE1z6LUjs/EoVhQo9LwS6xCsODUYzp
	aoN07xipE=
X-Google-Smtp-Source: AGHT+IHYt/NSsWiwYrShu4LW0TgHMyVPqE+MzoE8v+YAizyN89kI7nh1A994x+edUWqmXfwkVWzRQw==
X-Received: by 2002:a05:690c:6012:b0:786:68da:26ee with SMTP id 00721157ae682-790b574a439mr42878137b3.8.1767839192836;
        Wed, 07 Jan 2026 18:26:32 -0800 (PST)
Received: from 7940hx ([23.94.188.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa57deacsm24855027b3.20.2026.01.07.18.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 18:26:32 -0800 (PST)
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
Subject: [PATCH bpf-next v8 09/11] selftests/bpf: add testcases for fsession
Date: Thu,  8 Jan 2026 10:24:48 +0800
Message-ID: <20260108022450.88086-10-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108022450.88086-1-dongml2@chinatelecom.cn>
References: <20260108022450.88086-1-dongml2@chinatelecom.cn>
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


