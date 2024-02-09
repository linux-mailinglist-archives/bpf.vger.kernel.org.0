Return-Path: <bpf+bounces-21573-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6190B84EEC9
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 03:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13B67281E22
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 02:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7636015AF;
	Fri,  9 Feb 2024 02:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xai/Gfum"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AA9139E
	for <bpf@vger.kernel.org>; Fri,  9 Feb 2024 02:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707444064; cv=none; b=s4obII/4wbzKCWJdqUDXiIPwd5kDAJpTOD838gFn3gn6UZ0PvBuPdicAy3wjx2+Q4nyHAag77i1Gr1o5YU4EpPMxE7QQoxoxnK0LLtZfFvtYY7iByi1s08DUCB6ucZTrYeZfmpxYOu2AC2HsCwQ5bihLo0gFX8gZe/hIPVInl5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707444064; c=relaxed/simple;
	bh=tJaEvUHBGfLHhQQ6Z8IUE3m7lUAI+XObVCJa24vf10U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nO+eG4UkbRFOuDw/peTXlghqmG8TXkcjvaP+TJQqQy1KLFSY6ERs1FbkxWzUBnCzAso4QJp5tU8M78B+kdkAJum4YiOoRoqsAsEPNtkg2ZHC4jbeF5duAxuK8IFi0UmPykGLT6SZ+zZTo4zVKRw5dz57545q3faHOnYwUgUsJEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xai/Gfum; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-604a1581cffso5561937b3.3
        for <bpf@vger.kernel.org>; Thu, 08 Feb 2024 18:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707444061; x=1708048861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KL46QOptrTSppgIc8VdwygxoqnHkFvIWCBIzuCoN1ys=;
        b=Xai/Gfum+8fK/bctOLtWXPh+UBF2M93WTaBEwMwZHR3KRHHJAozN2U+FufMzFL7Z0f
         InWbOmp/icTVAjgvocXvQUkN2TyqHFzSD7BLKj9bdySDeRsoKIlYBVab4r8Gqxq/A2FC
         sOYi1P9+WkcstOB7tmeQRibhmkYnLO2I9/04+xRBfaOh9axzOa3wEuXdKUJCpc6HR7te
         aLXE+GY+ewTNWBrzD+fxNbvNaNP5pO52LJPo+f0q8biT3BAdscwrvM63mZvkJHPzFrtQ
         PjdOu/LeC+P73cc5LXYrqWnEuKK6UoP/5hhKRQEZrV/XgjxkFMrWLsC+VWeEhJVyuon2
         qmgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707444061; x=1708048861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KL46QOptrTSppgIc8VdwygxoqnHkFvIWCBIzuCoN1ys=;
        b=enjaeAqQir5Az7zRqhDKbCz63kUAKkNPfyG1jeimplR9sEWGMHB9NaBPUwkUiwOf9s
         3WkMPR6GmOsovrzTElbkT/D5JfhkigzA+8B/1bKsEo5tl69ls1G19l3ej48DRLvA1Cod
         DWz47pNPjI+jyccWfdCuvYkhQ3Avl5f0wwFClGFaQlzgpcNqK/0WQK/UkHmx5IaYStOI
         LdQS/NuYBoEZjxjQ43BuKR2emXMP/UGQcIsV4a7WovTlWgCkviPkJeXh4oYA9GjgzL/S
         IcpVYODErt1NJaciugZx1v5DqtTMSglbHJizZetETcTZA7vs7WpDucgl1ibUd6cNRlK5
         1Lzw==
X-Gm-Message-State: AOJu0Ywf7Cn4kqMg2BUaiq3ChDqmhprMNMGqL22XkdyejdqXMbt6a1tt
	qOOZq9DIXWB8f+GR+FR5HYujoYvTX0hAqpSmE0mkc0L9+gH65axop5xXd7/B870=
X-Google-Smtp-Source: AGHT+IGWwKXbXVtmO8AxiKoZrF0cS9OTHxJtv6MlH2CCeMsUFJTK1B6cGXd60s7Ff94/oDhhAfBEsw==
X-Received: by 2002:a0d:dac2:0:b0:603:c656:5e31 with SMTP id c185-20020a0ddac2000000b00603c6565e31mr238177ywe.28.1707444060788;
        Thu, 08 Feb 2024 18:01:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXUUnD0ORsXrw3yP0UapBdcfw2nhn8tCXvkhgt45qudWmYzsCUNO9UIkDLB1n1JHjcg5qcFsufGj5RP4mk5vylHIPcZsikA19m+akgrQK+vPXOvXWyG3MZVdFavLabo23cx9l2qTJEUKWaT9fGaR3nyWRSv8Q8FQOnVATIoADOCtIPkMtwGPD8rDWDi4G7M/OUWmmKzRkssd/iDQhe1Xbeuj0fR4xTK43RGoLEblblFT7dGmTdcA+6ZE9PBKN6SM0aV2fwADQLTrMzdP6QDYxji89hN8sZSIOS+TbafdBZMdi4=
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:1c58:82ab:ea0c:f407])
        by smtp.gmail.com with ESMTPSA id h123-20020a0dc581000000b006041f5a308esm134982ywd.133.2024.02.08.18.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 18:01:00 -0800 (PST)
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
Subject: [PATCH bpf-next v7 4/4] selftests/bpf: Test PTR_MAYBE_NULL arguments of struct_ops operators.
Date: Thu,  8 Feb 2024 18:00:53 -0800
Message-Id: <20240209020053.1132710-5-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240209020053.1132710-1-thinker.li@gmail.com>
References: <20240209020053.1132710-1-thinker.li@gmail.com>
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
test cases here.

A BPF program should check a pointer for NULL beforehand to access the
value pointed by the nullable pointer arguments, or the verifier should
reject the programs. The test here includes two parts; the programs
checking pointers properly and the programs not checking pointers
beforehand. The test checks if the verifier accepts the programs checking
properly and rejects the programs not checking at all.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 13 +++++-
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |  4 ++
 .../prog_tests/test_struct_ops_maybe_null.c   | 46 +++++++++++++++++++
 .../bpf/progs/struct_ops_maybe_null.c         | 29 ++++++++++++
 .../bpf/progs/struct_ops_maybe_null_fail.c    | 24 ++++++++++
 5 files changed, 115 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_maybe_null.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_maybe_null.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_maybe_null_fail.c

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index a06daebc75c9..66787e99ba1b 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -555,7 +555,11 @@ static int bpf_dummy_reg(void *kdata)
 {
 	struct bpf_testmod_ops *ops = kdata;
 
-	ops->test_2(4, 3);
+	/* Some test cases (ex. struct_ops_maybe_null) may not have test_2
+	 * initialized, so we need to check for NULL.
+	 */
+	if (ops->test_2)
+		ops->test_2(4, 3);
 
 	return 0;
 }
@@ -573,9 +577,16 @@ static void bpf_testmod_test_2(int a, int b)
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
index 537beca42896..c3b0cf788f9f 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
@@ -5,6 +5,8 @@
 
 #include <linux/types.h>
 
+struct task_struct;
+
 struct bpf_testmod_test_read_ctx {
 	char *buf;
 	loff_t off;
@@ -31,6 +33,8 @@ struct bpf_iter_testmod_seq {
 struct bpf_testmod_ops {
 	int (*test_1)(void);
 	void (*test_2)(int a, int b);
+	/* Used to test nullable arguments. */
+	int (*test_maybe_null)(int dummy, struct task_struct *task);
 };
 
 #endif /* _BPF_TESTMOD_H */
diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_maybe_null.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_maybe_null.c
new file mode 100644
index 000000000000..01dc2613c8a5
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_maybe_null.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
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
index 000000000000..b450f72e744a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_maybe_null.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include "../bpf_testmod/bpf_testmod.h"
+
+char _license[] SEC("license") = "GPL";
+
+pid_t tgid = 0;
+
+/* This is a test BPF program that uses struct_ops to access an argument
+ * that may be NULL. This is a test for the verifier to ensure that it can
+ * rip PTR_MAYBE_NULL correctly.
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
index 000000000000..6283099ec383
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_maybe_null_fail.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include "../bpf_testmod/bpf_testmod.h"
+
+char _license[] SEC("license") = "GPL";
+
+pid_t tgid = 0;
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


