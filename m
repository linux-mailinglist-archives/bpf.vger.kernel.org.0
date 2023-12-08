Return-Path: <bpf+bounces-17225-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DD180AC91
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 20:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FA89281AA7
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 19:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3509449F86;
	Fri,  8 Dec 2023 19:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="at1iuqfN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F19123
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 11:00:01 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-a1ef2f5ed02so246506166b.1
        for <bpf@vger.kernel.org>; Fri, 08 Dec 2023 11:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702061999; x=1702666799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+npSO5VrXRYja4620D+qD53+Q+PxXgUKrZXRyIcrmKY=;
        b=at1iuqfNM+V3AYPEtsQctP8m7CKRB0WujKOJwoqaVMJy3LM3RgHqOz+mFYjSpVBss0
         QFnM6MxF9G4huYcPJvR8IVmjE8zqFNb4Tjn+28vqYrHCRfH/vc1aH4GQVdouth9IUFVf
         qrrhXg0v53d63Ovv0dP/VLPTwPx5k2z3Cw1UL6W90bHBpg1lSGOZGncnKxTw7SZSnQ7L
         qwBRXEH2rQSbi6ZNZYlEHnRsHi0fATKAofxl9YP4gURLKNJ76RSzIRjGwUVkMPn4kUCf
         PUJLsq/9yg6P4mVQ4U91TE8DMPATZ+jZ6EcV/4RZUiTE512hZ+J8x3+y3erbRWRzn6Gj
         CqWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702061999; x=1702666799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+npSO5VrXRYja4620D+qD53+Q+PxXgUKrZXRyIcrmKY=;
        b=hrFquh6VSXRCkxC+/IEbEjLpga02mHu0oflOljGqxxYTR8UZc9yp8pBPfwNvxzLo5I
         hz/CkdK6cov9ETLXVR3m2Fmbc19e9z+Z8cJatjWmsVOSbhzG+FUyPXQ7pVv+bHHCW1Vf
         mv2+hx7qEyTczbp9IWXGmV2/b6mxy+8/vxC9yITqSSzoY/74z2x26HSJXlRmX2lwSgO0
         CU+pf2/PR05fwN3ZKGatnffv66MTNTxDlt4ACZRDrebVIC3DhKMbpqGtD1nyHQrlU5rC
         QwxRdqwkgBlHEFBiAV4UCQzf5wR5Umahnb42jfzDsfcJEciNhCC0qwesWNQh6ZyxmVxa
         06BA==
X-Gm-Message-State: AOJu0Yxs4uIHZ1wXi3Dz9Lm1P9K4U8VOiJ7HKwb4w7vhi4lp3IYiO37g
	WcgybrxQjTXa//sjMw80VjL3g4VSxkCQeQ==
X-Google-Smtp-Source: AGHT+IFh/AqKoCLP7U4s3HR+459AulT+u8pUdf4N+douFTVnC3YG1v3HDn8hRo1RwxHLClbRkM1VKg==
X-Received: by 2002:a17:906:2a90:b0:a1e:ef3d:7b70 with SMTP id l16-20020a1709062a9000b00a1eef3d7b70mr227310eje.103.1702061999691;
        Fri, 08 Dec 2023 10:59:59 -0800 (PST)
Received: from erthalion.local (dslb-178-005-231-183.178.005.pools.vodafone-ip.de. [178.5.231.183])
        by smtp.gmail.com with ESMTPSA id le9-20020a170907170900b00a1e2aa3d090sm1295702ejc.206.2023.12.08.10.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 10:59:59 -0800 (PST)
From: Dmitrii Dolgov <9erthalion6@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	dan.carpenter@linaro.org,
	olsajiri@gmail.com,
	asavkov@redhat.com,
	Dmitrii Dolgov <9erthalion6@gmail.com>
Subject: [PATCH bpf-next v7 2/4] selftests/bpf: Add test for recursive attachment of tracing progs
Date: Fri,  8 Dec 2023 19:55:54 +0100
Message-ID: <20231208185557.8477-3-9erthalion6@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231208185557.8477-1-9erthalion6@gmail.com>
References: <20231208185557.8477-1-9erthalion6@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Verify the fact that only one fentry prog could be attached to another
fentry, building up an attachment chain of limited size. Use existing
bpf_testmod as a start of the chain.

Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
---
Changes in v5:
    - Test only one level of attachment

 .../bpf/prog_tests/recursive_attach.c         | 69 +++++++++++++++++++
 .../selftests/bpf/progs/fentry_recursive.c    | 19 +++++
 .../bpf/progs/fentry_recursive_target.c       | 20 ++++++
 3 files changed, 108 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/recursive_attach.c
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_recursive.c
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_recursive_target.c

diff --git a/tools/testing/selftests/bpf/prog_tests/recursive_attach.c b/tools/testing/selftests/bpf/prog_tests/recursive_attach.c
new file mode 100644
index 000000000000..7248d0661ee9
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/recursive_attach.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Red Hat, Inc. */
+#include <test_progs.h>
+#include "fentry_recursive.skel.h"
+#include "fentry_recursive_target.skel.h"
+#include <bpf/btf.h>
+#include "bpf/libbpf_internal.h"
+
+/*
+ * Test following scenarios:
+ * - attach one fentry progs to another one
+ * - more than one nesting levels are not allowed
+ */
+void test_recursive_fentry_attach(void)
+{
+	struct fentry_recursive_target *target_skel = NULL;
+	struct fentry_recursive *tracing_chain[2] = {};
+	struct bpf_program *prog;
+	int prev_fd, err;
+
+	target_skel = fentry_recursive_target__open_and_load();
+	if (!ASSERT_OK_PTR(target_skel, "fentry_recursive_target__open_and_load"))
+		goto close_prog;
+
+	/* Create an attachment chain with two fentry progs */
+	for (int i = 0; i < 2; i++) {
+		tracing_chain[i] = fentry_recursive__open();
+		if (!ASSERT_OK_PTR(tracing_chain[i], "fentry_recursive__open"))
+			goto close_prog;
+
+		/*
+		 * The first prog in the chain is going to be attached to the target
+		 * fentry program, the second one to the previous in the chain.
+		 */
+		if (i == 0) {
+			prog = tracing_chain[0]->progs.recursive_attach;
+			prev_fd = bpf_program__fd(target_skel->progs.test1);
+			err = bpf_program__set_attach_target(prog, prev_fd, "test1");
+		} else {
+			prog = tracing_chain[i]->progs.recursive_attach;
+			prev_fd = bpf_program__fd(tracing_chain[i-1]->progs.recursive_attach);
+			err = bpf_program__set_attach_target(prog, prev_fd, "recursive_attach");
+		}
+
+		if (!ASSERT_OK(err, "bpf_program__set_attach_target"))
+			goto close_prog;
+
+		err = fentry_recursive__load(tracing_chain[i]);
+		/* The first attach should succeed, the second fail */
+		if (i == 0) {
+			if (!ASSERT_OK(err, "fentry_recursive__load"))
+				goto close_prog;
+
+			err = fentry_recursive__attach(tracing_chain[i]);
+			if (!ASSERT_OK(err, "fentry_recursive__attach"))
+				goto close_prog;
+		} else {
+			if (!ASSERT_ERR(err, "fentry_recursive__load"))
+				goto close_prog;
+		}
+	}
+
+close_prog:
+	fentry_recursive_target__destroy(target_skel);
+	for (int i = 0; i < 2; i++) {
+		if (tracing_chain[i])
+			fentry_recursive__destroy(tracing_chain[i]);
+	}
+}
diff --git a/tools/testing/selftests/bpf/progs/fentry_recursive.c b/tools/testing/selftests/bpf/progs/fentry_recursive.c
new file mode 100644
index 000000000000..1df490230344
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/fentry_recursive.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Red Hat, Inc. */
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+__u64 test1_result = 0;
+
+/*
+ * Dummy fentry bpf prog for testing fentry attachment chains
+ */
+SEC("fentry/XXX")
+int BPF_PROG(recursive_attach, int a)
+{
+	test1_result = a == 1;
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/fentry_recursive_target.c b/tools/testing/selftests/bpf/progs/fentry_recursive_target.c
new file mode 100644
index 000000000000..b6fb8ebd598d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/fentry_recursive_target.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Red Hat, Inc. */
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+__u64 test1_result = 0;
+
+/*
+ * Dummy fentry bpf prog for testing fentry attachment chains. It's going to be
+ * a start of the chain.
+ */
+SEC("fentry/bpf_testmod_fentry_test1")
+int BPF_PROG(test1, int a)
+{
+	test1_result = a == 1;
+	return 0;
+}
-- 
2.41.0


