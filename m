Return-Path: <bpf+bounces-17580-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F01E80F750
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 20:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 426771C20C35
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 19:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E65C5276C;
	Tue, 12 Dec 2023 19:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIc85AfV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51B9A0
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 11:58:12 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40c580ba223so4203765e9.3
        for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 11:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702411091; x=1703015891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FpqoOKeqTPoCEa/Ld4mp9d41lia+9p3idiThCycC25U=;
        b=QIc85AfVjHyzdLv5WeLX43rr1N9cZ9R+RJ9+IT69XkSCSTHjPxPud95AS+WsLUA4M0
         /iwCoVqmcnY6WTHi5ngPJLflA6R4T2wDJ9hPIYkAZrJSfegobMdhHAr2H6rVWj5FNDdG
         2gcCrHLcoR2VLrKv1T8x78DhjRNBF7WwjZHb7K6wpPHc+YUBuYXwiqCySf/8LcHSkyC0
         zvguzQ83yfARkRvPZESrb0nXbAZrWrOsK7nJ3olup7WEaAdleQcJmB6ORaNZnO1OdMEg
         kPTg7Y+m88BZ5ZX29ZimG6y2xvPue3DKCRX6RacsXT5HvuC7HCE32QXIHC1cOA22TtbZ
         Mxcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702411091; x=1703015891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FpqoOKeqTPoCEa/Ld4mp9d41lia+9p3idiThCycC25U=;
        b=AYfITbk4w9d+AT1MNOrKaZ/5DBWEmQ98mtp7ousn9kZyz/on5ngimOh6kByF/c2iek
         AHVjed6k9E9O3jUdiHu14nytkT5fFR1FNvuVAIKObnTnPLxn7JLNarImLd88a1ZClLow
         zmuSYH/XSzk0tu7Uy93IgZm2WSLvei6lY7de8a/f3r9fh0UViug8dUjefSBg+9pltD30
         L6TOLTrdryHUaH9LEZF8YEsmsokxqQRNdLxigTqlzcnt+Y7H6xJ+wDWmK11+yUY7K4sR
         tJJBLPLaol6mC6Hyb8RyvtgZ7mjBWQVKVokI1glrGLI+IFjxDrjgrWjIAmV00KSCLLQ1
         2YOw==
X-Gm-Message-State: AOJu0YzHwDAbBw8k7d1SwVLl4sQFPVJ15u57hHsBNeBGChsuCJetNI3F
	58YxARJPoLLjmo2dqFVN6nA47rxITGoXnQ==
X-Google-Smtp-Source: AGHT+IFhQ/mLnuDTFC4jYdWw0UnwIuS8HvvxesOpS9rFuORgys4w6TkfXql0tXz6/RJZyIQujfo8ZA==
X-Received: by 2002:a05:600c:1f1a:b0:40c:16ee:3219 with SMTP id bd26-20020a05600c1f1a00b0040c16ee3219mr4066130wmb.165.1702411091079;
        Tue, 12 Dec 2023 11:58:11 -0800 (PST)
Received: from localhost.localdomain ([2a00:20:608d:69b3:fa16:54ff:fe6e:2940])
        by smtp.gmail.com with ESMTPSA id tm6-20020a170907c38600b00a1db955c809sm6677386ejc.73.2023.12.12.11.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 11:58:10 -0800 (PST)
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
Subject: [PATCH bpf-next v8 2/4] selftests/bpf: Add test for recursive attachment of tracing progs
Date: Tue, 12 Dec 2023 20:54:07 +0100
Message-ID: <20231212195413.23942-3-9erthalion6@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231212195413.23942-1-9erthalion6@gmail.com>
References: <20231212195413.23942-1-9erthalion6@gmail.com>
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


