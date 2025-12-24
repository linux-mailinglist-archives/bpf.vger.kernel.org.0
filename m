Return-Path: <bpf+bounces-77415-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00522CDC520
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 14:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8B9CF302D9CD
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 13:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A11345CC2;
	Wed, 24 Dec 2025 13:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvW/FKtc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E681345722
	for <bpf@vger.kernel.org>; Wed, 24 Dec 2025 13:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766581782; cv=none; b=s2Ppbw8asBnIjvOlgZfABxyBrGwLG33/Hiwy/Uzb8z39/urdFE7yK7HwybTc8PcvZogweMh48wjCsAemJPhKnSbCobN+43liED1grNHTMmJuy7uu82yFsUdx9hhxLgYU3/0oR9oX0wySSqOi7RtdyphOjuAMRaQBNKFA78XTTso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766581782; c=relaxed/simple;
	bh=Bmazx6R7HTgrZAAci2Hgxnnq07VZy40dkV/5oC73DrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DAXoUaIn2Yjl8k7/Ur8hsqHVE4bQ1QYg6cV3RWnJHV4eqF5+1/2UkprskB37x+uLXHoqyNw51wxNKyke9t162xgowxqJOP/St0UKxkSomt3IzjkXnjsWoAcVGEAY+i0H73VbadAWBlYlefLS45ZXy4/cFcdSZksKMP/WYT4L7yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EvW/FKtc; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2a09a3bd9c5so52546615ad.3
        for <bpf@vger.kernel.org>; Wed, 24 Dec 2025 05:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766581780; x=1767186580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/XzCDYEI0ITxaGC+HfLOBIfCYLkIH8T7xQ7CvHDcOk=;
        b=EvW/FKtcSDvLvFDsSsdODm5X0k7pjEPthbe2DOYZartxQGRh5gZnEma0WeOxWvr9W6
         nQhNKK9Pcb2t4mQ2VEeEmAPFuKpz+rDIu8aEp1uyiicmUlZ3vwsskuLBKX3JQCQ/NySD
         9qq9+XQGQZsNlYwTtXUFjTare+XN/L6m6PgU4o1mjip7Zli84XXKPj5AJ5Mhh9m21vSU
         n0RXTRoxijPws+rsVSCWK3aZet3siDS2JKbwIYOj8uphJUmvUbY9DljRiKobgPap64dZ
         gcanwLlEisEHvAWY4HalLWTS9jPtQhBAUYg1U4QzNaZECqhTCtcrHbWko19a86gJ4eLu
         3C9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766581780; x=1767186580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P/XzCDYEI0ITxaGC+HfLOBIfCYLkIH8T7xQ7CvHDcOk=;
        b=UvvV5rfhIzUrsaK2o2ifExCpSoYWMWkkqOQzcGZ7FXSw5xtbfEQOR4Vk8WDBkEQa3U
         6Pn1HQ1IQUW6z0nQkSPIHF2AbdnHJozA5E++e5xBkUGn8pHfV3p1c3BLWuNIygYaVsrh
         XVc2aKd+q9oa7gL0/2d9JRB6j+16+7a0dSlHd4gBA9QrSQ0L5o+YmlEXAEbKN9I3J2s4
         0Fw6oBi+t/D8re49FT3r8NfvpzqAFRGHYQNOB2RLjeR3BJBYDIW+L8SmbPUNZz3ThnvW
         bZw6jdLEMogSrXZuL6n9CtQCPWP1BNW3oDrq3/ZDwkahTGNFWp1M1BEA4VdVVnuS/3eP
         bnYw==
X-Forwarded-Encrypted: i=1; AJvYcCUKcpD5iFx8/Mcl9pjWywxSKe/FtaUrQLlQ3aqe7yF0/SpDaobDjE47S8muJHVR94kCsfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnvHnTHn5/AVt2jJuXbj6aMsUJKVobSZ/IxZ3vPEply51fp4H9
	cCBZJz5ESgS4JBQbiffZYqJFn/22SSDkN15WFTUp1+Om2F0Z2FiUd7n/
X-Gm-Gg: AY/fxX71om2ENryw8tWYZYuvbQVIKBYmbFUg9itSdBu0s1muAF93taGr/EKPLNbjE+/
	s2fKLUMXBCTONK7UY6ixPZTNnbOP2F0ZwNHuzff3LdF7/H7uU4e3xg8WR2EBHxOcAIA/ofY4/vk
	b8OZa90p3z+ysSMJeoUGUYAPRpoYeRi1Evyyo3idf/QpIZxG8eqtvS6p+A27wHcNz2X0WkpH9Eh
	cTSL8iUZW5LdbQZ8Jb3/ltV81lK/3F3RNCsP3JQTFDxzLnSsOEVjqo7VHNnuzEDW+wmYSp5yOtT
	Jx7awlhFsPaC4hjjFb5u6qcVEClBcWtYJBSKIicZzh7FQ1dFpMOnRdgGYG8z80JQx/V4pPlrdOW
	PtjLmvSlQVXVNJXzVMVsdhOU0DoRVKyERgLLsWtT5pN/1wubajr64SOv6lmQ8OGx7NNpysJbIq4
	B+dPHJKnWcjYAAucwl4Q==
X-Google-Smtp-Source: AGHT+IGf1imjHRE+ghCg/KJNQShasOaQNtbDozqmyux9+RUBrJ9Pqo/VwgFHn/aR49SnKMnCqVtx3g==
X-Received: by 2002:a17:903:4b28:b0:2a0:ed13:398e with SMTP id d9443c01a7336-2a2f2a4f222mr181527185ad.49.1766581780271;
        Wed, 24 Dec 2025 05:09:40 -0800 (PST)
Received: from 7950hx ([160.187.0.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7dfac28fsm16841173b3a.32.2025.12.24.05.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 05:09:39 -0800 (PST)
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
Subject: [PATCH bpf-next v5 08/10] selftests/bpf: add testcases for fsession
Date: Wed, 24 Dec 2025 21:07:33 +0800
Message-ID: <20251224130735.201422-9-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224130735.201422-1-dongml2@chinatelecom.cn>
References: <20251224130735.201422-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add testcases for BPF_TRACE_FSESSION. The function arguments and return
value are tested both in the entry and exit. And the kfunc
bpf_fsession_is_ret() is also tested.

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
index 000000000000..b180e339c17f
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
+	bool is_exit = bpf_fsession_is_return(ctx);
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
+SEC("fsession/bpf_fentry_test1")
+int BPF_PROG(test6, int a)
+{
+	__u64 addr = bpf_get_func_ip(ctx);
+
+	if (bpf_fsession_is_return(ctx))
+		test6_exit_result = (const void *) addr == &bpf_fentry_test1;
+	else
+		test6_entry_result = (const void *) addr == &bpf_fentry_test1;
+	return 0;
+}
-- 
2.52.0


