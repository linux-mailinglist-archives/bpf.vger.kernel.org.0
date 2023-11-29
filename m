Return-Path: <bpf+bounces-16186-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0857FE090
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 20:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36B8D282D4E
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 19:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE7F5EE80;
	Wed, 29 Nov 2023 19:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lawpvSZI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1749B12F
	for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 11:56:52 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-a184d717de1so11213366b.1
        for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 11:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701287810; x=1701892610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y7cZeYFylMaxtzJfPZHbirUIFCzRX6DWKIf3smwQVOE=;
        b=lawpvSZIC1RpcIHsnbFESjsWb9WmHG9NL8NF1XEpojfLt3O7Kb/NxTyA4KlPlnfsmU
         ZmTb2E2nI2EwgZ9zVqY+I9Wfm6DKcT1Igfc/EgvB8hw2pWDWGsfwWsll4KO0G33b2O6g
         U6YWHn16pu2DADgc4CEN0C/JTF288OhrbMACoQhnEPflXvHRLFbSbg0rvTQ7sXdqONGf
         FQsKFLiJkdMvTT/+9RYjZq1/7dZ2gbcIsPDvwB0BnnTFNl2X/JnzgM8YiGDfhyn8KPBu
         dTCOWX3F8UAeFEmhXnooIQJMDWFAoqIwc0D+q1ZNE3RKNbsXjVXaQM3Kb8FAOWdvKekQ
         4yPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701287810; x=1701892610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y7cZeYFylMaxtzJfPZHbirUIFCzRX6DWKIf3smwQVOE=;
        b=MgNmTPIB46rzqMrgo0hkdJ9mG/IqwWBoAKOAg6B5nKcFmRCqAvGBjtKzMS0mChFf0J
         6nx5LzlYex9Y8NtKKpV4Z9cDARQYEwlHrY05Cq5dZLLx5uTNacYqMNpS5pyCkTPGJIVQ
         tIvpRNZFuGgQrU2zx81p1Q+h1XP9XwR9Yxqk/rK+FAZePyVPRD7QKoqeTHpkkCQjY5x5
         KOBxvD2F5GYkY0f1LXYtJsi9Wqt2XwLv0MAgeapplafVROm2tMykqgF5TceXG5GGkIja
         F/pI9modGhbZsZXQ35zo8vMVICA9rZVanfbRiQyw41wyYJaePJhMv2ZwV5ONFggkEJDq
         Ts4w==
X-Gm-Message-State: AOJu0Yx3z8LTGsOEBtXJ5wLrpCcLpvYEglhIBSQm15hhWS3MPfqlALk/
	RpnxXAGXLOzrMbPIdDKvjd/D2jT+i/hQYw==
X-Google-Smtp-Source: AGHT+IF1s3Yxi6tLcDDQdhHk7hLqa1rpEw9DLIxDkvQ1/WkSFFp9RcmBMINruoezbrXxvKKpUKLA+w==
X-Received: by 2002:a17:906:20dd:b0:a0c:f253:a901 with SMTP id c29-20020a17090620dd00b00a0cf253a901mr10242430ejc.39.1701287810222;
        Wed, 29 Nov 2023 11:56:50 -0800 (PST)
Received: from erthalion.local (dslb-178-005-231-183.178.005.pools.vodafone-ip.de. [178.5.231.183])
        by smtp.gmail.com with ESMTPSA id p4-20020a170906b20400b009ddaf5ebb6fsm8287742ejz.177.2023.11.29.11.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 11:56:50 -0800 (PST)
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
	Dmitrii Dolgov <9erthalion6@gmail.com>
Subject: [PATCH bpf-next v4 2/3] selftests/bpf: Add test for recursive attachment of tracing progs
Date: Wed, 29 Nov 2023 20:52:37 +0100
Message-ID: <20231129195240.19091-3-9erthalion6@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231129195240.19091-1-9erthalion6@gmail.com>
References: <20231129195240.19091-1-9erthalion6@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Verify the fact that an fentry prog could be attached to another one,
building up an attachment chain of limited size. Use existing
bpf_testmod as a start of the chain.

Note, that currently it's not possible to:
* form a cycle within an attachment chain
* splice two attachment chains

Those limitations are coming from the fact that attach_prog_fd is
specified at the prog load (thus making it impossible to attach to a
program loaded after it in this way), as well as tracing progs not
implementing link_detach. This is the reason there is only one test for
the chain length.

Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
---
 .../bpf/prog_tests/recursive_attach.c         | 85 +++++++++++++++++++
 .../selftests/bpf/progs/fentry_recursive.c    | 19 +++++
 .../bpf/progs/fentry_recursive_target.c       | 20 +++++
 3 files changed, 124 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/recursive_attach.c
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_recursive.c
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_recursive_target.c

diff --git a/tools/testing/selftests/bpf/prog_tests/recursive_attach.c b/tools/testing/selftests/bpf/prog_tests/recursive_attach.c
new file mode 100644
index 000000000000..9c422dd92c4e
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/recursive_attach.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Red Hat, Inc. */
+#include <test_progs.h>
+#include "fentry_recursive.skel.h"
+#include "fentry_recursive_target.skel.h"
+#include <bpf/btf.h>
+#include "bpf/libbpf_internal.h"
+
+#define ATTACH_DEPTH 33
+
+/*
+ * Test following scenarios:
+ * - one can attach fentry progs recursively, one fentry to another one
+ * - an attachment chain generated this way is limited, after 32 attachment no
+ *   more progs could be added
+ */
+void test_recursive_fentry_attach(void)
+{
+	struct fentry_recursive_target *target_skel = NULL;
+	struct fentry_recursive *tracing_chain[ATTACH_DEPTH + 1] = {};
+	struct bpf_program *prog;
+	int prev_fd, err;
+
+	target_skel = fentry_recursive_target__open_and_load();
+	if (!ASSERT_OK_PTR(target_skel, "fentry_recursive_target__open_and_load"))
+		goto close_prog;
+
+	/* This is going to be the start of the chain */
+	tracing_chain[0] = fentry_recursive__open();
+	if (!ASSERT_OK_PTR(tracing_chain[0], "fentry_recursive__open"))
+		goto close_prog;
+
+	prog = tracing_chain[0]->progs.recursive_attach;
+	prev_fd = bpf_program__fd(target_skel->progs.test1);
+	err = bpf_program__set_attach_target(prog, prev_fd, "test1");
+	if (!ASSERT_OK(err, "bpf_program__set_attach_target"))
+		goto close_prog;
+
+	err = fentry_recursive__load(tracing_chain[0]);
+	if (!ASSERT_OK(err, "fentry_recursive__load"))
+		goto close_prog;
+
+	/* Create an attachment chain to exhaust the limit */
+	for (int i = 1; i < ATTACH_DEPTH; i++) {
+		tracing_chain[i] = fentry_recursive__open();
+		if (!ASSERT_OK_PTR(tracing_chain[i], "fentry_recursive__open"))
+			goto close_prog;
+
+		prog = tracing_chain[i]->progs.recursive_attach;
+		prev_fd = bpf_program__fd(tracing_chain[i-1]->progs.recursive_attach);
+		err = bpf_program__set_attach_target(prog, prev_fd, "recursive_attach");
+		if (!ASSERT_OK(err, "bpf_program__set_attach_target"))
+			goto close_prog;
+
+		err = fentry_recursive__load(tracing_chain[i]);
+		if (!ASSERT_OK(err, "fentry_recursive__load"))
+			goto close_prog;
+
+		err = fentry_recursive__attach(tracing_chain[i]);
+		if (!ASSERT_OK(err, "fentry_recursive__attach"))
+			goto close_prog;
+	}
+
+	/* The next attachment would fail */
+	tracing_chain[ATTACH_DEPTH] = fentry_recursive__open();
+	if (!ASSERT_OK_PTR(tracing_chain[ATTACH_DEPTH], "last fentry_recursive__open"))
+		goto close_prog;
+
+	prog = tracing_chain[ATTACH_DEPTH]->progs.recursive_attach;
+	prev_fd = bpf_program__fd(tracing_chain[ATTACH_DEPTH - 1]->progs.recursive_attach);
+	err = bpf_program__set_attach_target(prog, prev_fd, "recursive_attach");
+	if (!ASSERT_OK(err, "last bpf_program__set_attach_target"))
+		goto close_prog;
+
+	err = fentry_recursive__load(tracing_chain[ATTACH_DEPTH]);
+	if (!ASSERT_ERR(err, "last fentry_recursive__load"))
+		goto close_prog;
+
+close_prog:
+	fentry_recursive_target__destroy(target_skel);
+	for (int i = 1; i < ATTACH_DEPTH + 1; i++) {
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


