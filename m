Return-Path: <bpf+bounces-18036-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0438150E6
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 21:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E0EB1C21444
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 20:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204BF45BF1;
	Fri, 15 Dec 2023 20:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAm4mksq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C91835883
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 20:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a1c8512349dso128790066b.2
        for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 12:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702671068; x=1703275868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FpqoOKeqTPoCEa/Ld4mp9d41lia+9p3idiThCycC25U=;
        b=FAm4mksq+R0XY0AE1ThpEm58KgBNvqziZQanBWU3GKYOhpy565dOfnC7n9FiRFVzJW
         cX2MfyYmfN/Bg4qFXmq20JM1g4XbhLGv6PBsA2gebWDWPnFRRmpKkbvE7ox4Pgl87WsY
         bHKucZpiiu8KHMZgqpbb5Ay+CPkyjXXI2vrb60mnDlHfKoYD4EDwlLoV7HO4SX5OGrul
         1a1b8QbRJEVrW34L8CqO/rKtAeUpSWfsw0sWZQ4+6snVEG9Ckyw+sfoMiEu0Ia9IpU+R
         PhOgzfq7lIElQ/lPQeLEC5MxcaBMtKaqJHmKsF5mkYE1FtS7ZZXdwHWW+1WlLL8fwwkY
         0Gfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702671068; x=1703275868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FpqoOKeqTPoCEa/Ld4mp9d41lia+9p3idiThCycC25U=;
        b=px7lawNzwPbQAqW+JQDYX8IJASJWbSjib7bFAb2vUr7S7KuKb15RbSqJHN04XhvaZS
         Z4D7BNlXnTiMBMjg7UoHBvF6K73bQ7zioSQhDSfyX35Am8QWCwAuy0xBTBajGOVKJOGx
         SaUgwQvEIqgQ1oUAOhcK14z89z56boyShqPYwJSjJ6u8OlPwkBttn+Qbta07JqfQLcIv
         YcrwxcqEa0yVRhCLFvDFnArApJSEDcYK34c6GmgomXQENaRwuWAbIHr9gFGqJ98Q72Ip
         DbWPz9xCBVRm9wmRUi0pknktYeACClDCEnvClbtYhlZOycHuK7SZuCBwBjBKbALRHNtA
         VYYg==
X-Gm-Message-State: AOJu0Yyi/35oE54/AuOlP5+SqVDLjppzDHYSpGWNlYsm3TjGSeiC10td
	JHQXpwCYks0y0VQyjEI24298OLk0cON/Ow==
X-Google-Smtp-Source: AGHT+IFbBcRpFMRubjvXVSlhrHKwiKYUSklG34hvgKCK5b+yjOhn99IFSlcuN9F0ti4qd3trn5tuPA==
X-Received: by 2002:a17:906:b793:b0:a1c:be13:f0bc with SMTP id dt19-20020a170906b79300b00a1cbe13f0bcmr6762491ejb.109.1702671068017;
        Fri, 15 Dec 2023 12:11:08 -0800 (PST)
Received: from erthalion.local (dslb-178-005-229-020.178.005.pools.vodafone-ip.de. [178.5.229.20])
        by smtp.gmail.com with ESMTPSA id cx11-20020a170907168b00b00a1d5ebe8871sm11031490ejd.28.2023.12.15.12.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 12:11:07 -0800 (PST)
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
Subject: [PATCH bpf-next v9 2/4] selftests/bpf: Add test for recursive attachment of tracing progs
Date: Fri, 15 Dec 2023 21:07:08 +0100
Message-ID: <20231215200712.17222-3-9erthalion6@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231215200712.17222-1-9erthalion6@gmail.com>
References: <20231215200712.17222-1-9erthalion6@gmail.com>
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
Changes in v8:
    - Cleanup test bpf progs and the content of first/second condition
      in the loop.

Changes in v5:
    - Test only one level of attachment

 .../bpf/prog_tests/recursive_attach.c         | 68 +++++++++++++++++++
 .../selftests/bpf/progs/fentry_recursive.c    | 16 +++++
 .../bpf/progs/fentry_recursive_target.c       | 17 +++++
 3 files changed, 101 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/recursive_attach.c
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_recursive.c
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_recursive_target.c

diff --git a/tools/testing/selftests/bpf/prog_tests/recursive_attach.c b/tools/testing/selftests/bpf/prog_tests/recursive_attach.c
new file mode 100644
index 000000000000..5b38783bcd16
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/recursive_attach.c
@@ -0,0 +1,68 @@
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


