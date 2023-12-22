Return-Path: <bpf+bounces-18618-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 676E681CC02
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 16:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC9A41F27FF9
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 15:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9288A28DB1;
	Fri, 22 Dec 2023 15:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3+nD4/Y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B88250E7
	for <bpf@vger.kernel.org>; Fri, 22 Dec 2023 15:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a2335397e64so243811566b.2
        for <bpf@vger.kernel.org>; Fri, 22 Dec 2023 07:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703257926; x=1703862726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gWF+cAJg7iu/2c+kvtMo5DKd9nS9IpqRdJ9lmKhkyWs=;
        b=h3+nD4/YUaavzasurveYWk9Gj116I/mlt5uVo++k0nCzHKEDEjpyA2Zs40PbyrAFZ7
         FD5V+FJkfwYpcGBujOQLCY3v68OQoHNNgCatrO2qWLt4GddLBES/4+0nuwUILktPy0h2
         y/bnS8Lkl5kX2P6Wb3yPE3vy35+I9Yb1YJ53F4G25uwQccQEgW1vUgAUTGkMnvXCcuuT
         9KLsoGKpnOEe8LwpRsrzcm3fGolQsX5zvMLZ63zOQPsZiaKazU/68OeaT16RYUvJTWUP
         9GKstl1c2ibT9fJgwvIDDqYfXIy2WqjvygFy7vdiy/bWvw7Mt5DzVaRXQVVZnFdn7Mr0
         RLQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703257926; x=1703862726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gWF+cAJg7iu/2c+kvtMo5DKd9nS9IpqRdJ9lmKhkyWs=;
        b=TnaJrlP/0sSq3RreX3qMhWUkUaQmJYaxxHNoi4YISK+NdXVOgpk7k2O9t2UMkaezuX
         KEoLGbeRXDQwb4NtVnKpjhNpvehBTAJZX4OHSlXH5shLwLasNIgY7LQ0fP/U8/hNvbzk
         L6dy94QFZ+cQRTWBgQrZKRCjtv4hvBk4KhaRl1wS/JhQB4K06JHw57ZU0F4/64KYxIVi
         AKZzqZ9QTX7qyXfnZJlfrbElvwv5cWBT9/Qmu3+nMit4TgWOpvuidcl8IFhsY6brXf0B
         eOvTxIoaZW+8zPHsFkPs2zJy42yyWGiRL7glYTE2QTYhgNFIhiH+8haPkFjkABPRweQ7
         S7Mw==
X-Gm-Message-State: AOJu0YxII5S9l8dKQvk+VewIIzcEp67dUp4BkHdw2V9rSBsvYekfDdaB
	5ddHweA1tSJhgfkYGZBvXbMgLuHbS4ST6A==
X-Google-Smtp-Source: AGHT+IFmNHc+tC+CnCa+SXfWHe0O987wp1w3O2koooEFFr+weq486Rcn2wIEnVIjtu4jWAvkDgFwXw==
X-Received: by 2002:a17:906:c358:b0:a23:5a57:1793 with SMTP id ci24-20020a170906c35800b00a235a571793mr789052ejb.56.1703257926180;
        Fri, 22 Dec 2023 07:12:06 -0800 (PST)
Received: from erthalion.local (dslb-178-005-229-020.178.005.pools.vodafone-ip.de. [178.5.229.20])
        by smtp.gmail.com with ESMTPSA id br18-20020a170906d15200b00a236f815a1fsm2111162ejb.200.2023.12.22.07.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 07:12:05 -0800 (PST)
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
Subject: [PATCH bpf-next v11 2/4] selftests/bpf: Add test for recursive attachment of tracing progs
Date: Fri, 22 Dec 2023 16:11:48 +0100
Message-ID: <20231222151153.31291-3-9erthalion6@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231222151153.31291-1-9erthalion6@gmail.com>
References: <20231222151153.31291-1-9erthalion6@gmail.com>
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

Acked-by: Jiri Olsa <olsajiri@gmail.com>
Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
---
Changes in v11:
    - Use subtests, reduce code duplication

Changes in v10:
    - Add tests for loading tracing progs without attaching, and
      detaching tracing progs.

Changes in v8:
    - Cleanup test bpf progs and the content of first/second condition
      in the loop.

Changes in v5:
    - Test only one level of attachment

 .../bpf/prog_tests/recursive_attach.c         | 111 ++++++++++++++++++
 .../selftests/bpf/progs/fentry_recursive.c    |  16 +++
 .../bpf/progs/fentry_recursive_target.c       |  17 +++
 3 files changed, 144 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/recursive_attach.c
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_recursive.c
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_recursive_target.c

diff --git a/tools/testing/selftests/bpf/prog_tests/recursive_attach.c b/tools/testing/selftests/bpf/prog_tests/recursive_attach.c
new file mode 100644
index 000000000000..e9e576de6723
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/recursive_attach.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Red Hat, Inc. */
+#include <test_progs.h>
+#include "fentry_recursive.skel.h"
+#include "fentry_recursive_target.skel.h"
+#include <bpf/btf.h>
+#include "bpf/libbpf_internal.h"
+
+/*
+ * Test recursive attachment of tracing progs with more than one nesting level
+ * is not possible. Create a chain of attachment, verify that the last prog
+ * will fail. Depending on the arguments, following cases are tested:
+ *
+ * - Recursive loading of tracing progs, without attaching (attach = false,
+ *   detach = false). The chain looks like this:
+ *       load target
+ *       load fentry1 -> target
+ *       load fentry2 -> fentry1 (fail)
+ *
+ * - Recursive attach of tracing progs (attach = true, detach = false). The
+ *   chain looks like this:
+ *       load target
+ *       load fentry1 -> target
+ *       attach fentry1 -> target
+ *       load fentry2 -> fentry1 (fail)
+ *
+ * - Recursive attach and detach of tracing progs (attach = true, detach =
+ *   true). This validates that attach_tracing_prog flag will be set throughout
+ *   the whole lifecycle of an fentry prog, independently from whether it's
+ *   detached. The chain looks like this:
+ *       load target
+ *       load fentry1 -> target
+ *       attach fentry1 -> target
+ *       detach fentry1
+ *       load fentry2 -> fentry1 (fail)
+ */
+static void test_recursive_fentry_chain(bool attach, bool detach)
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
+		prog = tracing_chain[i]->progs.recursive_attach;
+		if (i == 0) {
+			prev_fd = bpf_program__fd(target_skel->progs.test1);
+			err = bpf_program__set_attach_target(prog, prev_fd, "test1");
+		} else {
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
+			if (attach) {
+				err = fentry_recursive__attach(tracing_chain[i]);
+				if (!ASSERT_OK(err, "fentry_recursive__attach"))
+					goto close_prog;
+			}
+
+			if (detach) {
+				/*
+				 * Flag attach_tracing_prog should still be set, preventing
+				 * attachment of the following prog.
+				 */
+				fentry_recursive__detach(tracing_chain[i]);
+			}
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
+
+void test_recursive_fentry(void)
+{
+	if (test__start_subtest("attach"))
+		test_recursive_fentry_chain(true, false);
+	if (test__start_subtest("load"))
+		test_recursive_fentry_chain(false, false);
+	if (test__start_subtest("detach"))
+		test_recursive_fentry_chain(true, true);
+}
diff --git a/tools/testing/selftests/bpf/progs/fentry_recursive.c b/tools/testing/selftests/bpf/progs/fentry_recursive.c
new file mode 100644
index 000000000000..b9e4d35ac597
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/fentry_recursive.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Red Hat, Inc. */
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+/*
+ * Dummy fentry bpf prog for testing fentry attachment chains
+ */
+SEC("fentry/XXX")
+int BPF_PROG(recursive_attach, int a)
+{
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/fentry_recursive_target.c b/tools/testing/selftests/bpf/progs/fentry_recursive_target.c
new file mode 100644
index 000000000000..6e0b5c716f8e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/fentry_recursive_target.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Red Hat, Inc. */
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+/*
+ * Dummy fentry bpf prog for testing fentry attachment chains. It's going to be
+ * a start of the chain.
+ */
+SEC("fentry/bpf_testmod_fentry_test1")
+int BPF_PROG(test1, int a)
+{
+	return 0;
+}
-- 
2.41.0


