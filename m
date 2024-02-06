Return-Path: <bpf+bounces-21287-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0AD84AE72
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 07:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2EA01C22AD8
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 06:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA168128801;
	Tue,  6 Feb 2024 06:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OlWM4BsA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA35127B73
	for <bpf@vger.kernel.org>; Tue,  6 Feb 2024 06:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707201523; cv=none; b=F/MWRmx47hkPTOJSY0YPzY60iOGaf5aUeK0W2IRMwxPejz0y1WDC9V3BDXZpCgQ86NENIogxJxacR9pxDYcxysS/9fa+TXCr8IqeIbLmKb2gC66bgHLi6bh3DAQuGiBEIN8qbMUzsf0G75w/5uzu/XnfLB+agw9qzL3MDiQzDH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707201523; c=relaxed/simple;
	bh=a0jlfop1Qv+gTC6pGRB6DtDr8UkdNM8YTgEaKyma1so=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F2i2wW4R8ZobR89xrz3o2TS/hoW3g3tSNNgyyad25g9T0AsKtY1hxQOcD31jnNcJjCYpcs7t6dMQLu/o8j71/yGIR1C/JWiP4wnK9nROMoig6Bz5fcCXUSU6Ut/vh6+POXvz5kDpylsg/ldderGIYjo/OpXtStNhn7eZhJkjD9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OlWM4BsA; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6047a616bfeso2935257b3.3
        for <bpf@vger.kernel.org>; Mon, 05 Feb 2024 22:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707201520; x=1707806320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DaFQB1S2OEFC+ncdlZUFtvATDjuRd6DEfxpNjkX8SCI=;
        b=OlWM4BsAN1Lqzom7WqBoBQ682QK6j9XFbc+Lm16qRPBOXh1KYcMGfZdflPQYxWr6hE
         y+4yat/ymR/J65xQ0303GzBtvVVImp0pxmJ30W85JJ1rtjxvY4Eo5N2WeBngaxFvwi52
         UTg+ThXFHsDnS3aA28+fyLXQoQH6L10yKrMV3vMAs1QquGgNkVKSRwkZb+OP2gsuv7BX
         zyWZ7X1Em3BubPV0IhJ69UJ49DGxoEuqpsKfuMn4Dzsb7kD7ESoRyfRsBMOlzCDHVW+Q
         YiMeN+1Qjq9gr9DqCHjTQbp5rmW0w4N8sy3t3sIN7dpimmVmy/D3E19kN5ijDe2F7AjH
         nOGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707201520; x=1707806320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DaFQB1S2OEFC+ncdlZUFtvATDjuRd6DEfxpNjkX8SCI=;
        b=weVTwOhn6fymtLmuU4w0f0azvgMjbkIEM4oQ0B7jeQZyPKzWYyfh2YOq9w/zuwhxbB
         kLeWVUZpdxWdzChTye2FWv08MnSRM+A9mkhf43a5nTV8RGWdR7fuvuNIKgZuwxeWvkXd
         9gwAZ5BRPzNGOx4rCsN/tTVIMiMzWXqrZ9LNVW9uYoEiZAca90vEpWszuK70lNADnupP
         d6cZd1rbvhgMKV2bN2oY/HRLIR0Gobd+aS1sskRjW4o+V4oCShP0cDFonx3Iw2aDgS1J
         g3JBukTyGV2U55HeEIAwK3bVFS7nJfF3YP7fRffvKDE4g3RBRDSVZmgPymPc9yQ05GOO
         tDnA==
X-Gm-Message-State: AOJu0Yz5xgJcBRO5VkRPJQEUTE9HlB5E4cHC5uJCb95PXr5gFEh9Dh2K
	yTJngDh+xxV/m4VVGP3X3YjjqV3JIPxMJvkwmVT/D8h8SF5Q0ctNW2vrcH2WAqA=
X-Google-Smtp-Source: AGHT+IGNQrdKf5nxxEn+Bc2qVNgwX8jmQPOK20ISlMMYzsFh64SE6q1dsfUwjNgE1rT1OpXHwrJk3w==
X-Received: by 2002:a0d:e444:0:b0:604:5a7b:19cf with SMTP id n65-20020a0de444000000b006045a7b19cfmr780015ywe.38.1707201520077;
        Mon, 05 Feb 2024 22:38:40 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU4I2+3x5CMtrTLenM0NiQwzv67XWYyfmN0Md0g6dr7eN5AmQhfCtXoNCCgBga8qQlRPm1IykpsafxwTCCnBQaDnjM4im395GG+kd8eHMFAtgnGgFgwGIs9CpjBS8YT9jHrurvkYLdsHF+EmPUQqANXEsCU0ce/CgYWc2co0QQfGp+u/t72pcA/9IWhLcNlbZPWtmTuFNBzpblJOiWpgJmNaH3PotQRYTBTcW2VjnciYMvyXd2/SbCANzzmnX6dSb2/veCc26PvvQdJ1dvm0qSu+s+7NHNSLCGZcWcveVr901U=
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:3a27:6d1a:7c79:c81e])
        by smtp.gmail.com with ESMTPSA id ez9-20020a05690c308900b005ffb91a94e6sm64277ywb.59.2024.02.05.22.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 22:38:39 -0800 (PST)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	davemarchevsky@meta.com,
	dvernet@meta.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v5 3/3] selftests/bpf: Test PTR_MAYBE_NULL arguments of struct_ops operators.
Date: Mon,  5 Feb 2024 22:38:33 -0800
Message-Id: <20240206063833.2520479-4-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206063833.2520479-1-thinker.li@gmail.com>
References: <20240206063833.2520479-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

Test if the verifier verifies nullable pointer arguments correctly for BPF
struct_ops programs.

"test_maybe_null" in struct bpf_testmod_ops is the operator defined for the
test cases here. It has several pointer arguments to various types. These
pointers are majorly classified to 3 categories; pointers to struct types,
pointers to scalar types, and pointers to array types. They are handled
sightly differently.

A BPF program should check a pointer for NULL beforehand to access the
value pointed by the nullable pointer arguments, or the verifier should
reject the programs. The test here includes two parts; the programs
checking pointers properly and the programs not checking pointers
beforehand. The test checks if the verifier accepts the programs checking
properly and rejects the programs not checking at all.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 12 ++++-
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |  7 +++
 .../prog_tests/test_struct_ops_maybe_null.c   | 47 +++++++++++++++++++
 .../bpf/progs/struct_ops_maybe_null.c         | 31 ++++++++++++
 .../bpf/progs/struct_ops_maybe_null_fail.c    | 25 ++++++++++
 5 files changed, 121 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_maybe_null.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_maybe_null.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_maybe_null_fail.c

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index a06daebc75c9..891a2b5f422c 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -555,7 +555,10 @@ static int bpf_dummy_reg(void *kdata)
 {
 	struct bpf_testmod_ops *ops = kdata;
 
-	ops->test_2(4, 3);
+	if (ops->test_maybe_null)
+		ops->test_maybe_null(0, NULL);
+	else
+		ops->test_2(4, 3);
 
 	return 0;
 }
@@ -573,9 +576,16 @@ static void bpf_testmod_test_2(int a, int b)
 {
 }
 
+static int bpf_testmod_ops__test_maybe_null(int dummy,
+					    struct task_struct *task__nullable)
+{
+	return 0;
+}
+
 static struct bpf_testmod_ops __bpf_testmod_ops = {
 	.test_1 = bpf_testmod_test_1,
 	.test_2 = bpf_testmod_test_2,
+	.test_maybe_null = bpf_testmod_ops__test_maybe_null,
 };
 
 struct bpf_struct_ops bpf_bpf_testmod_ops = {
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
index 537beca42896..c51580c9119d 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
@@ -5,6 +5,8 @@
 
 #include <linux/types.h>
 
+struct task_struct;
+
 struct bpf_testmod_test_read_ctx {
 	char *buf;
 	loff_t off;
@@ -28,9 +30,14 @@ struct bpf_iter_testmod_seq {
 	int cnt;
 };
 
+typedef u32 (*ar_t)[2];
+typedef u32 (*ar2_t)[];
+
 struct bpf_testmod_ops {
 	int (*test_1)(void);
 	void (*test_2)(int a, int b);
+	/* Used to test nullable arguments. */
+	int (*test_maybe_null)(int dummy, struct task_struct *task);
 };
 
 #endif /* _BPF_TESTMOD_H */
diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_maybe_null.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_maybe_null.c
new file mode 100644
index 000000000000..1c057c62d893
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_maybe_null.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+#include <time.h>
+
+#include "struct_ops_maybe_null.skel.h"
+#include "struct_ops_maybe_null_fail.skel.h"
+
+/* Test that the verifier accepts a program that access a nullable pointer
+ * with a proper check.
+ */
+static void maybe_null(void)
+{
+	struct struct_ops_maybe_null *skel;
+
+	skel = struct_ops_maybe_null__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_module_open_and_load"))
+		return;
+
+	struct_ops_maybe_null__destroy(skel);
+}
+
+/* Test that the verifier rejects a program that access a nullable pointer
+ * without a check beforehand.
+ */
+static void maybe_null_fail(void)
+{
+	struct struct_ops_maybe_null_fail *skel;
+
+	skel = struct_ops_maybe_null_fail__open_and_load();
+	if (ASSERT_ERR_PTR(skel, "struct_ops_module_fail__open_and_load"))
+		return;
+
+	struct_ops_maybe_null_fail__destroy(skel);
+}
+
+void test_struct_ops_maybe_null(void)
+{
+	/* The verifier verifies the programs at load time, so testing both
+	 * programs in the same compile-unit is complicated. We run them in
+	 * separate objects to simplify the testing.
+	 */
+	if (test__start_subtest("maybe_null"))
+		maybe_null();
+	if (test__start_subtest("maybe_null_fail"))
+		maybe_null_fail();
+}
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_maybe_null.c b/tools/testing/selftests/bpf/progs/struct_ops_maybe_null.c
new file mode 100644
index 000000000000..c5769c742900
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_maybe_null.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "../bpf_testmod/bpf_testmod.h"
+
+char _license[] SEC("license") = "GPL";
+
+u64 tgid = 0;
+
+/* This is a test BPF program that uses struct_ops to access an argument
+ * that may be NULL. This is a test for the verifier to ensure that it can
+ * rip PTR_MAYBE_NULL correctly. There are tree pointers; task, scalar, and
+ * ar. They are used to test the cases of PTR_TO_BTF_ID, PTR_TO_BUF, and array.
+ */
+SEC("struct_ops/test_maybe_null")
+int BPF_PROG(test_maybe_null, int dummy,
+	     struct task_struct *task)
+{
+	if (task)
+		tgid = task->tgid;
+
+	return 0;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops testmod_1 = {
+	.test_maybe_null = (void *)test_maybe_null,
+};
+
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_maybe_null_fail.c b/tools/testing/selftests/bpf/progs/struct_ops_maybe_null_fail.c
new file mode 100644
index 000000000000..566be47fb40b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_maybe_null_fail.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "../bpf_testmod/bpf_testmod.h"
+
+char _license[] SEC("license") = "GPL";
+
+int tgid = 0;
+
+SEC("struct_ops/test_maybe_null_struct_ptr")
+int BPF_PROG(test_maybe_null_struct_ptr, int dummy,
+	     struct task_struct *task)
+{
+	tgid = task->tgid;
+
+	return 0;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops testmod_struct_ptr = {
+	.test_maybe_null = (void *)test_maybe_null_struct_ptr,
+};
+
-- 
2.34.1


