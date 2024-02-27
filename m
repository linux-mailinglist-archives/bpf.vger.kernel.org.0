Return-Path: <bpf+bounces-22792-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EA786A103
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 21:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37F791C2478B
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 20:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B21A14EFDF;
	Tue, 27 Feb 2024 20:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZnyTI09L"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEF314E2E7
	for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 20:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709066797; cv=none; b=lZKnkHfXTdo/jyXnLE6HuA/KVXVgyowCDyB5YM5FO0qFf7pWnyFcgiM6S4t3ly1Sq6T4ie4BvkJ6cEEu6dW1+evGUn+kYeRReN+sbh396YxSC4SnLxMOLcvpmGJU9YCY5JQewEsIka0MPttDR4mZ7yYnpES0dinFePgEU2IGqrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709066797; c=relaxed/simple;
	bh=aPHgAlniB8mYH7lkQgh1G1ID2gwOCNzEOk5VdAFGKI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NlXP0GvbAh4k5wyBuY+QKtlrCkGXNiwfEeCKhDckehvJJlpztyzGLIWjUJHn+A2/bBeiviqVTVklulHkZf56nOZWq0Wno1rc4r6oSGKPNURxtv7x6FtGVzDOgFw+7r2Vj4mz10lK2q7J/BB3s9EyTwXcC2GeikE/rwZm5m8OhuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZnyTI09L; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-564fd9eea75so6063071a12.3
        for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 12:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709066794; x=1709671594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ugm6wlCTGmAs31wehy3V0RDN9q39yLThBREE/iiVQG0=;
        b=ZnyTI09LxUqNkYXOda0sr/GqCo/xjeiIo2YF0tpGKMJ8uvWwUKpNYVbHZAc4lxt4Y0
         KHkDQ9MWIcFrSBZkKMwgK79TRz2xMf+b5u19LhH1Cr3gUXtVRBKztZWwyaCZ+bgoGTux
         j4fFGA3jkHyV0m48h5l4o5TQj/hdXkCQKYH/sfwkv4ugyO7ZQnsbFCPNriHlc8MWsYgT
         1b7vpEoxLWH1nz/aP/GHE8L92rl57p+DofcDpPpc7Yw7E3le2/WwUWCNHZuZOBjNoy8x
         +v82FxRG7pbNgDYgqvTiT4BYYlF9ppwh4d/XHxP1JGOVa4BDpfahosW9yGj+A45wlLkU
         34mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709066794; x=1709671594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ugm6wlCTGmAs31wehy3V0RDN9q39yLThBREE/iiVQG0=;
        b=QOjv+s+qoVPZN0Kzu5mBpUDV30HuEj99RCNYNJjgg38aN1Hx1HzbK0pmm/a+q6Vd+r
         tXFGhOWSZUQwIOXs5lHAvm+WTVwznom1HJT8siSep9js99tIqalCSZDnbLHHiL8fHVQB
         3E/aSakcs4creP2lIDFekxZq+vGpULEgjWF8o0s8k2NpGvpYN2EOeF2rXm9003F4t83X
         cIfVZtD0HgQ1DzYRNnhZn9Fkysr/N2eINf2lubNrzsKpUpZrDeIXK3LdLeZeuoiSV2Sb
         WpNN1RNYnrOdkBUdhbQFNdxe4H8GxL0kBcVP90DAXqylfu8N3uPXqdePmwWDrtUYwpaP
         NyQA==
X-Gm-Message-State: AOJu0YxS6e3JAEx7SbjF+nJU8up8JhP91DBypRlIstOEytDjUCBqGSmr
	NrS62Az7Dg053p40Z6Nan84hI9H9wI3901UiuF9BSmF+TzvdGRji6wY1zu0WE40=
X-Google-Smtp-Source: AGHT+IFYe9DvHJshCuNGw770tMdZz2v7jqt7BdSGlRfsmrGSQqnXWm2n+GdAj9gI/l+UdPfrC7Xfag==
X-Received: by 2002:a17:906:3397:b0:a3f:d797:e6e2 with SMTP id v23-20020a170906339700b00a3fd797e6e2mr6943126eja.28.1709066794210;
        Tue, 27 Feb 2024 12:46:34 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id hb13-20020a170906b88d00b00a3d9e6e9983sm1119832ejb.174.2024.02.27.12.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 12:46:33 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	void@manifault.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1 5/8] selftests/bpf: bad_struct_ops test
Date: Tue, 27 Feb 2024 22:45:53 +0200
Message-ID: <20240227204556.17524-6-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240227204556.17524-1-eddyz87@gmail.com>
References: <20240227204556.17524-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When loading struct_ops programs kernel requires BTF id of the
struct_ops type and member index for attachment point inside that
type. This makes it not possible to have same BPF program used in
struct_ops maps that have different struct_ops type.
Check if libbpf rejects such BPF objects files.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 24 +++++++++++
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |  4 ++
 .../selftests/bpf/prog_tests/bad_struct_ops.c | 42 +++++++++++++++++++
 .../selftests/bpf/progs/bad_struct_ops.c      | 17 ++++++++
 4 files changed, 87 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bad_struct_ops.c
 create mode 100644 tools/testing/selftests/bpf/progs/bad_struct_ops.c

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 0d8437e05f64..69f5eb9ad546 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -601,6 +601,29 @@ struct bpf_struct_ops bpf_bpf_testmod_ops = {
 	.owner = THIS_MODULE,
 };
 
+static int bpf_dummy_reg2(void *kdata)
+{
+	struct bpf_testmod_ops2 *ops = kdata;
+
+	ops->test_1();
+	return 0;
+}
+
+static struct bpf_testmod_ops2 __bpf_testmod_ops2 = {
+	.test_1 = bpf_testmod_test_1,
+};
+
+struct bpf_struct_ops bpf_testmod_ops2 = {
+	.verifier_ops = &bpf_testmod_verifier_ops,
+	.init = bpf_testmod_ops_init,
+	.init_member = bpf_testmod_ops_init_member,
+	.reg = bpf_dummy_reg2,
+	.unreg = bpf_dummy_unreg,
+	.cfi_stubs = &__bpf_testmod_ops2,
+	.name = "bpf_testmod_ops2",
+	.owner = THIS_MODULE,
+};
+
 extern int bpf_fentry_test1(int a);
 
 static int bpf_testmod_init(void)
@@ -612,6 +635,7 @@ static int bpf_testmod_init(void)
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_testmod_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &bpf_testmod_kfunc_set);
 	ret = ret ?: register_bpf_struct_ops(&bpf_bpf_testmod_ops, bpf_testmod_ops);
+	ret = ret ?: register_bpf_struct_ops(&bpf_testmod_ops2, bpf_testmod_ops2);
 	if (ret < 0)
 		return ret;
 	if (bpf_fentry_test1(0) < 0)
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
index c3b0cf788f9f..3183fff7f246 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
@@ -37,4 +37,8 @@ struct bpf_testmod_ops {
 	int (*test_maybe_null)(int dummy, struct task_struct *task);
 };
 
+struct bpf_testmod_ops2 {
+	int (*test_1)(void);
+};
+
 #endif /* _BPF_TESTMOD_H */
diff --git a/tools/testing/selftests/bpf/prog_tests/bad_struct_ops.c b/tools/testing/selftests/bpf/prog_tests/bad_struct_ops.c
new file mode 100644
index 000000000000..9c689db4b05b
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bad_struct_ops.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include "bad_struct_ops.skel.h"
+
+#define EXPECTED_MSG "libbpf: struct_ops reloc"
+
+static libbpf_print_fn_t old_print_cb;
+static bool msg_found;
+
+static int print_cb(enum libbpf_print_level level, const char *fmt, va_list args)
+{
+	old_print_cb(level, fmt, args);
+	if (level == LIBBPF_WARN && strncmp(fmt, EXPECTED_MSG, strlen(EXPECTED_MSG)) == 0)
+		msg_found = true;
+
+	return 0;
+}
+
+static void test_bad_struct_ops(void)
+{
+	struct bad_struct_ops *skel;
+	int err;
+
+	old_print_cb = libbpf_set_print(print_cb);
+	skel = bad_struct_ops__open_and_load();
+	err = errno;
+	libbpf_set_print(old_print_cb);
+	if (!ASSERT_NULL(skel, "bad_struct_ops__open_and_load"))
+		return;
+
+	ASSERT_EQ(err, EINVAL, "errno should be EINVAL");
+	ASSERT_TRUE(msg_found, "expected message");
+
+	bad_struct_ops__destroy(skel);
+}
+
+void serial_test_bad_struct_ops(void)
+{
+	if (test__start_subtest("test_bad_struct_ops"))
+		test_bad_struct_ops();
+}
diff --git a/tools/testing/selftests/bpf/progs/bad_struct_ops.c b/tools/testing/selftests/bpf/progs/bad_struct_ops.c
new file mode 100644
index 000000000000..9c103afbfdb1
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bad_struct_ops.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "../bpf_testmod/bpf_testmod.h"
+
+char _license[] SEC("license") = "GPL";
+
+SEC("struct_ops/test_1")
+int BPF_PROG(test_1) { return 0; }
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops testmod_1 = { .test_1 = (void *)test_1 };
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops2 testmod_2 = { .test_1 = (void *)test_1 };
-- 
2.43.0


