Return-Path: <bpf+bounces-77776-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C60EECF0F0B
	for <lists+bpf@lfdr.de>; Sun, 04 Jan 2026 13:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03C4C302AFBB
	for <lists+bpf@lfdr.de>; Sun,  4 Jan 2026 12:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C842F999F;
	Sun,  4 Jan 2026 12:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxyI1OfM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C572EA159
	for <bpf@vger.kernel.org>; Sun,  4 Jan 2026 12:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767529820; cv=none; b=Yec63M93ex3Gk4UD8dLOuXgjAtgNKCDUf1OC7yMQz8sKxY8x25R/LBhXnxcs7M4giIeBSIPVTU8nRfrlrK7EWeKMeroBXYxthqVAS9Ow9fzIt96JZIUqEgZfk/ateC8JcAoTWutuVAIzlYvmPNjITPZauK4mu7KH3T9zf2ucQHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767529820; c=relaxed/simple;
	bh=30IrruSBttNJv11mnhPPFrDbo5C5jVGpYPadqyOEUcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=afyCBaWHEKodn9dOTnYvNv88UtzNtqbixo1P+igSwupHEwWLe0Kvx3aMCKDCzfyY4ZUeWk29+mP1811c8HNvnlFQyTxc6Nb2OE3Pvx52QctD3dxou7he/QXh1lbI7zNCcdp8h8/2HrvqDtMNVY3uMVI/cGbqMS/mHqqZ2FSZqrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bxyI1OfM; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-78fc0f33998so86385987b3.0
        for <bpf@vger.kernel.org>; Sun, 04 Jan 2026 04:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767529818; x=1768134618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i4Bxr4OZff+AEQ0Kvht+WX5RF8ZeS18xbuX/dUJTalk=;
        b=bxyI1OfMRLesF6qlo60Jj8Gu8mJ6w8FhRMqlL/MS0XcJGmr8kxBII9nUgkDuRsclOK
         UALToxRGu+KuuKHkL1WxfRxYuEHT8Pse23BqLmV7o3WvNwnESnjzcZEvcVBJdkciHduF
         SYPa0xUUJvNI49loWwNVq7P+feX659v7Rf6JbsfvwJkXzL9ydn/qJLN5QyoifVilkdIA
         xxdcEMt5bh2O7GNZVWQ+CZogQL3o7kdgOH6iNn+w/IRoVhDiMVcO6g1bsX3+STIhR6zd
         peDF7MLmkUuK2e+y3oxj1mF2bWb60vx43oZB9jTFNA4kGiGE4JRfQIo5S8HCvAdZpeFp
         LRIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767529818; x=1768134618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i4Bxr4OZff+AEQ0Kvht+WX5RF8ZeS18xbuX/dUJTalk=;
        b=djXIhn1BzxjVRLhpMPdVzNQmhQoMgakLHJAUKcfaHEZZyr/hUtsjsak8sMBkQmaZtY
         CEhdOxoMcIMX3NBsUnhuJSaHN44HZ3ZNT7usDHuRR2Rk1prWEvnvDuPLYheBT9DPTDKh
         /WO4RwUF3rNjOL7qJqGjObe/Z2VqeiYMSiOYRueJwfKoHgyXmV4aNeW71u9Im7/99OJM
         OrEVFofr25qUrhisjzUtLfPdlfenP2Eue2gnS1/gLD5rsQFZl+74Z0kGVSiv6WHu+hYh
         qzPChomctzvO5xkUJE6vUVxWjq+NS5W/44bz/tvC89OUAIFAijRjNHhAYskQ7oIDkv1B
         H7Ag==
X-Forwarded-Encrypted: i=1; AJvYcCWhGsDgzgqHcrVlmp4+GfQT+FasDtoo0TzDhfbQHGNFp+9WWpxriu9A1HFkxyLFUbiOi88=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUHf0p/5tRRUJxmTVQ+0PsQKERMl08CIXAmrkPVsbFQwkzncFh
	XEKF2bXa0HlCR/dJyF3U3mr8pRYtQKagPl7Hx1GSlOcDlYYW9BTCC4Yy
X-Gm-Gg: AY/fxX4lk311q/XrqaSFym5YMtUGC7WX3hvKlwIz8ROGjuba/IkYNEruVA7l7plPBtS
	WNI7qw4xXDRE+IQZd1ck8IDGfRpaHpU3KG1cNe1lAFgawz5EumvJ1ZqJ253sMxmUGpOgrvfgDv1
	md2BlTp4yroOCez3R9l7UwQLAMmC9Jp1uALyauf0tfpSl/2/v2MnloL41IJJO5E/4li34JvshWR
	YXCSGIFNbXM8NS72Od1zhcc2jyk37MqKvymVgXLtCfooOa9+++6BINexKR6m734EOVwowPZrYC+
	hGTJMnZLfJxwIyz5569pRf0l0AxeRBonN5uxBN/4KaNzgNo3qM5xfOdUkf+Xi6nJvpLz4uu/h9s
	1OmZHv91a9QT5FzFSycLfwMPpv3sFwRpQNxT5XboXkvx3zog0jpcc8sA2FvswqkfwxcW/nvneOS
	SRPd4pPHY=
X-Google-Smtp-Source: AGHT+IEttVPCWCvk8Pr0apQez8fgF7tG1sqIw2qS7xEH+hRKidNyasenyD8alWTfRCkhKagcAfR5Cg==
X-Received: by 2002:a05:690c:2703:b0:789:61ca:88f6 with SMTP id 00721157ae682-78fb3f02ce1mr844762997b3.4.1767529817694;
        Sun, 04 Jan 2026 04:30:17 -0800 (PST)
Received: from 7940hx ([23.94.188.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb4378372sm175449427b3.12.2026.01.04.04.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 04:30:17 -0800 (PST)
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
Subject: [PATCH bpf-next v6 08/10] selftests/bpf: add testcases for fsession
Date: Sun,  4 Jan 2026 20:28:12 +0800
Message-ID: <20260104122814.183732-9-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260104122814.183732-1-dongml2@chinatelecom.cn>
References: <20260104122814.183732-1-dongml2@chinatelecom.cn>
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


