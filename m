Return-Path: <bpf+bounces-21485-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFD784DA63
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 07:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8C5A1F22521
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 06:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9458E6931B;
	Thu,  8 Feb 2024 06:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I70Dm4Iy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B4A67E7F
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 06:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707375075; cv=none; b=ssX02RIzpuVuQoq9mSBCIynVJCRTccq8jCcjQYaHtmYyFCQy6k0ekP74VxD/Gok2KkrrCjZK59nxLTQwXBXvrCPvhuFL4nftQ2jYpSlStFJ9Br9WE/8btTLQlaO0P0ZMsT2zEMCXXaN94cwG/VO5k2+nkIeSudnE2nU1xTl0FyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707375075; c=relaxed/simple;
	bh=tJaEvUHBGfLHhQQ6Z8IUE3m7lUAI+XObVCJa24vf10U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k86GE8EulpagcO7MjHzigFjOpBur3Wrq0uJ3gyvIrDpGVSR6JDnZ0HhcwF53GP8e73R6flvssqlgOU8ocOSsGnFIrBSoVrjM5qA2q9DeXngwwlbHyYpbybAV55QTQawU0w0H5o6THUG4GcZHfE5Afj/EfqYbGZr3hxpEcB9kiVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I70Dm4Iy; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6049b3deee8so12256807b3.1
        for <bpf@vger.kernel.org>; Wed, 07 Feb 2024 22:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707375072; x=1707979872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KL46QOptrTSppgIc8VdwygxoqnHkFvIWCBIzuCoN1ys=;
        b=I70Dm4Iy4U1/USBxW2VOFFyPnGC2BsksjFNBlPsaGBq0OCx/INvxKr601Fcq/lpgwz
         GiSbywyb6wODKt4kYG4D7Jd4foh+1l9ilIn2afZImvgSAYazmzl9jnbnM7WY6PorooaB
         IlAOD8e8ilIfuY6eAErD+hBTbETC1qC+nJKvApOnkM4FyWT+YsOEzAP/zOdPeusGO5cz
         W2d6hgx1QIjwzMWxEX+aP6GCkMjHFX9sNwSfHc4gbF+wZnK97KQtHAExhoCKkvU03/GB
         KHORm5X7k2VItdvaTQYuCddPD+Q9Rznp/L95O8fW/4rAjWPYEYEwjrayy845jhF5J/XS
         aBhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707375072; x=1707979872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KL46QOptrTSppgIc8VdwygxoqnHkFvIWCBIzuCoN1ys=;
        b=QvkzOzcJS3/JJ7BlVEsBMVEWfYQJ5oTbiJhZY3gEzm/ah1VYUnJvIgGMG7jf2/EAom
         Z0qj9u8Z3l4JXAAreMZG76vlOEr7oiqPziqOQl5KTPAwfA3ET0wtGn4mcDFjB4RmLlpa
         k0y5zxaihVaHURfsxkS7wqK00tQ+V2Q9VauJ/BCJKTyH0tXzLcZ6IDzw3rzCQFi2yrNL
         CH1TiTaPz9m5Wc/xIgazQ7uQI6W0pvt8dK/pT7fYg313En9J9dL0ON1iesUHYOUrKbA/
         4VAMG2l8Jf6rQ9HzfIPGwK5bWC4jlxF2kPPcvagCMOB2JsTu9hkUW9ge538/itjyXNL3
         K3DA==
X-Gm-Message-State: AOJu0YzqHMvfwgM5zsAbcJkIu8shvSjIJpfNlpDCM3OhDDeOmkyZTQoU
	uQLjLj06S19tyICBMtLD02x2a4DlX6U5LuCOkyJjPtplRTZAvx9uy/0+iAs4bg4=
X-Google-Smtp-Source: AGHT+IE5KORFH+J7ZagFNnbduneZJdV0TiT47A690Dgb803DEJf7trLkpMbSedGgf71kRVVBMce19g==
X-Received: by 2002:a81:6c93:0:b0:604:acd9:32ce with SMTP id h141-20020a816c93000000b00604acd932cemr181255ywc.8.1707375071806;
        Wed, 07 Feb 2024 22:51:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWbE47zU2t6yxIkweYlZVPzxxzVtdbF7AWrKJVRWkAEs1vhbVEWuHutFykKn6CqrW62/Q3TOC5B01n2ZJUuGiyy/J/3KGssaqH9WLqkMNxnQ2G0vq3qkn9pLSrpUKusjmFriXJNtu5v2UVe30trfGx1jIDCWuoO33U3dZIyYRaaFX3o0C35mbc785BnIg1CeBwy8cXuLeken4AF0y3ae4zG4wCf/xjzHhUq6aUxm07DjuI32xy+1AJcrnScRWmWTnZW4emCm+b9zRoO/0ITywO4YQdBh4PNP1lV5uNJZaIMdHo=
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:1d02:e957:f461:9a61])
        by smtp.gmail.com with ESMTPSA id u203-20020a8184d4000000b0060467650c64sm596917ywf.62.2024.02.07.22.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 22:51:11 -0800 (PST)
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
Subject: [PATCH bpf-next v6 4/4] selftests/bpf: Test PTR_MAYBE_NULL arguments of struct_ops operators.
Date: Wed,  7 Feb 2024 22:51:03 -0800
Message-Id: <20240208065103.2154768-5-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208065103.2154768-1-thinker.li@gmail.com>
References: <20240208065103.2154768-1-thinker.li@gmail.com>
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


