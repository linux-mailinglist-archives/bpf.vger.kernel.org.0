Return-Path: <bpf+bounces-78057-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 777A7CFC3BA
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 07:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D9B2B3031696
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 06:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C9A279324;
	Wed,  7 Jan 2026 06:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNnU4Kjx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF6A284665
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 06:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767768345; cv=none; b=EdIE/vBCa3JLUYVJb5NKcrcnbzTVd0YUJ355eMO5hNPQQGMFORMVxnVxvMyk+hrZufenROurCjAXvO4SOhttUGy83MWde/mx6UCXQ90XSm7lOaYj6jg7A87KTEu4i4Avqbrow/VA0ssB6uwW//vnMpYu9KkcXrd66jbUMm1oCh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767768345; c=relaxed/simple;
	bh=Okg9SIzWIdxMYL9OMbZo8y/oAOt76F10doefVGdAQU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JXEsOeMF6gnFLXRu5Ox4FNMLboZvofPPwMg2d1MbJcbuG4oodQiRB5ygsCHyQXVK5tIo5TjFQvt5kolxJQxuG8r1i8zJUqGjayuJN9bfx/ThojPRG5dKQxnKgcS6HzRq+SZ/ne448AMaGSew/dsgxgFVMoUad2IuSBwqB8eNaEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iNnU4Kjx; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-790b7b3e581so4101647b3.0
        for <bpf@vger.kernel.org>; Tue, 06 Jan 2026 22:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767768341; x=1768373141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QR5rrRd0ZsuEPPqW5q3lZCBR9ClfGRJ1620B6u4R4tA=;
        b=iNnU4KjxTg9BpN7YgV2IoulY9mDKYeI52syYf1cGyHH7iFrlBkzvnUKZK8z+3DSOg+
         /ijgL8cpOPvIWZzdcMwNpgmJ+7J/MadqSlMV5ajJ8rGyrKTmV0sg3tAmCCaXgsZpmpsf
         YLieVpi7JoQIhSf1tNS8SCjd5Kx31gTiZ0qxrqgpQZO8DymFmcqC/dkBzLnIBAF5LvFy
         Y9fcRqdH92+OzVkkodACkbLbJrSBs5Lo51m27VXTk0L0yuaS6k9Ko678okw6+XoBTZ88
         KqIWDc5xM2xpF4z/MCS0ULRQUEjfbh7Xxaev0o5S0/XEXJUI7zmJO46phLBjeeo1Rqzb
         kUkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767768341; x=1768373141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QR5rrRd0ZsuEPPqW5q3lZCBR9ClfGRJ1620B6u4R4tA=;
        b=YUf/9B1+CXKPjk1ncLg811D07swUdjUi0xRjxyuRE0Vlg0a80z9sEFmTPaIKBIRChU
         b9sH4OT1avLDZA+NbQLPJKjZS91jI47nqvKOP850UmjRGOaOYXM1WNdhl+XZBvBY3meT
         BP9YDv9Bf7yZheisj7urcfdSkZHUA56i8TueWqkv7JS9BtI8BBapR8BB689LMTFDEMGV
         MGw9IvAd4InrmYDlxslnf0xHzlRL32oXhzRU8c4pcaXWkFxO3IZIY1fQt7hzDZyV5kyo
         GIiAKHfKCxB5rRNYclXv4KpQ5MvjcW66HLZ+CobiutYKvE/POMlxn1Zy6TW3UINa7eBd
         Kwjw==
X-Forwarded-Encrypted: i=1; AJvYcCUdHTydLiO3hVuOnW+3TTgejtjBUc/X8TveDp47AsRcJQAboISQNY2/F8ywjGfm8UU/f+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLj82b5vtjGtLvjeVV+4tuU6voEIssJZnn5Dz+UjMGuDIXtKtr
	nglqE58grnHo4uGGtcxpeySJRMQ6r3aNS/LCmclf08VLZUFPky6JyFkD
X-Gm-Gg: AY/fxX73AmidB1z+whCD3Wky5FQ5gBfuDwRULziA52FbW25E/oq5OLKIctAb7bLHljx
	LoS9ku/SvWF5kDjMCdUwKBITQMx/yGs5wSxZl3o1pG46jzLswGOYRCqS4bRGFtw/BZrDZON2eUp
	UXuuhek9HPhKpotiNa9fphUAhxE2D5aKz3KE/oRNw8njJrD2s4D9uuoYAUXt7D2waPqsQ+gGxWg
	ErQZovN47kCRoEGr7CVSXeqmW9+iayNxetqUGGSWLZkCbn+woEjptSyoM1FxOA6Ob401Tlmz15C
	4dk27CTZWPVfJVCBWQNCr38RwYckH3TzyMSV/rR+ykISgGXjLTBhzTTn+TbIS4dWK+hhcT2XDJp
	5lijmk8w1DsrSIT/rYfSXPVZkYx7tqX+Ft26IrWPgxWzMPLUHige7KNerNNOE3zyWieQghpHgRe
	KCotm78Nk=
X-Google-Smtp-Source: AGHT+IGSawnCd1w8NLNeXq8X76q4ov6YkS5+hhYjNtOJFH0IbJy38YLLa8nhZKa7aXJeFe/5VPkNTw==
X-Received: by 2002:a05:690c:64c4:b0:78f:c2f3:16d with SMTP id 00721157ae682-790b57fb6camr13847587b3.20.1767768341325;
        Tue, 06 Jan 2026 22:45:41 -0800 (PST)
Received: from 7940hx ([23.94.188.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790b1be88dcsm9635047b3.47.2026.01.06.22.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 22:45:40 -0800 (PST)
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
Subject: [PATCH bpf-next v7 09/11] selftests/bpf: add testcases for fsession
Date: Wed,  7 Jan 2026 14:43:50 +0800
Message-ID: <20260107064352.291069-10-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107064352.291069-1-dongml2@chinatelecom.cn>
References: <20260107064352.291069-1-dongml2@chinatelecom.cn>
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


