Return-Path: <bpf+bounces-18893-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0986823553
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 20:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD3711C213E4
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 19:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17CD1CAA5;
	Wed,  3 Jan 2024 19:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TfJkZZuO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EC11CA96
	for <bpf@vger.kernel.org>; Wed,  3 Jan 2024 19:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a2768b78a9eso140835266b.0
        for <bpf@vger.kernel.org>; Wed, 03 Jan 2024 11:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704308780; x=1704913580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+OVFzCDqqF+N4YkAGGHTvQjgrXznPUOGWkDvo39ZQDc=;
        b=TfJkZZuOD2rUWyCdi1Lw/JgzsYemZoMbMA6EFYirjWDQYJdBCrBcHzKreN+sNxxy9N
         wXFFjV0xzc4J5z/JBmCvscCUjgO8TrVwngTAyHh8cWzN2EmDzYETJA+aRCiZb8Si717V
         zXUrr6j2iT3AVAM/pX6pBdv7WYeRQZ2VGcTR6+DbEnyqCa+WbML5KvED1shje/kWpbGE
         upMdIDtNSvoUQuKkOjE7diQXjWxJn8TeMafVD7qlgqwGSrpYcSvVpsXmuFaQxH6pTvWV
         iIX0rFWwbbMuWVBSAkj5h0BeN/Ft1NXpYKbQxi3vhHets7UQK6yQNiOQUGpSrI4KYeJe
         p2Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704308780; x=1704913580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+OVFzCDqqF+N4YkAGGHTvQjgrXznPUOGWkDvo39ZQDc=;
        b=VigBWMf40fE3moJQh7anFhB6ejYDosE1jeJuDmmHFTEkKeET4ALdRjZi0yGcxLT1K0
         FmOXIyJV0bbO/Irvvg0ZcTKD5LAAEua1Lk8EbSoDE5EjlVBsy+4w3mYAOQHsXXYi6vm+
         FtKaSyjI9l7THI4EDZ//wmGEy9lh6v4uHdJEgAC0biaoEuySz0JTZLzKztZ8PBuHkaXf
         +PC9sllcX0EiGSfs+mmxy9T7LBT34B3/j+iFF28C51edY+HjJNJubf4OB+HtalvLeavU
         47FIVW6ZuEWwZ1cOYkzcVhdD+fWF1NrKYNMWUQpemnJAOGGnK5YJvdPQMTmrUc7kiytI
         W7mQ==
X-Gm-Message-State: AOJu0YwCeNKQoXbiErWnNwDsVZcSa8fwYm2wdIzuTHTgwv0kQrMtsvni
	sA+2QVj+/n69mhBkzznQsLoG75I0hdWjOg==
X-Google-Smtp-Source: AGHT+IFIEIkYVjBj1F6wmTLzasjnF/mtPNzpH8CrqCk8xdx/bsD4yx0tZK1MEKqOXOpeJtCVsB04yA==
X-Received: by 2002:a17:906:5198:b0:a28:b7c1:7210 with SMTP id y24-20020a170906519800b00a28b7c17210mr498821ejk.7.1704308780134;
        Wed, 03 Jan 2024 11:06:20 -0800 (PST)
Received: from erthalion.local (dslb-178-005-229-020.178.005.pools.vodafone-ip.de. [178.5.229.20])
        by smtp.gmail.com with ESMTPSA id wj20-20020a170907051400b00a28a8a7de10sm605772ejb.159.2024.01.03.11.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 11:06:19 -0800 (PST)
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
Subject: [PATCH bpf-next v12 2/4] selftests/bpf: Add test for recursive attachment of tracing progs
Date: Wed,  3 Jan 2024 20:05:45 +0100
Message-ID: <20240103190559.14750-3-9erthalion6@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240103190559.14750-1-9erthalion6@gmail.com>
References: <20240103190559.14750-1-9erthalion6@gmail.com>
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
Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
---
Changes in v12:
    - Skip close_progs at the beginning, remove NULL checks when closing
      progs, adjust comments style.

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

 .../bpf/prog_tests/recursive_attach.c         | 107 ++++++++++++++++++
 .../selftests/bpf/progs/fentry_recursive.c    |  16 +++
 .../bpf/progs/fentry_recursive_target.c       |  17 +++
 3 files changed, 140 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/recursive_attach.c
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_recursive.c
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_recursive_target.c

diff --git a/tools/testing/selftests/bpf/prog_tests/recursive_attach.c b/tools/testing/selftests/bpf/prog_tests/recursive_attach.c
new file mode 100644
index 000000000000..4bd0a0e4231e
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/recursive_attach.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Red Hat, Inc. */
+#include <test_progs.h>
+#include "fentry_recursive.skel.h"
+#include "fentry_recursive_target.skel.h"
+#include <bpf/btf.h>
+#include "bpf/libbpf_internal.h"
+
+/* Test recursive attachment of tracing progs with more than one nesting level
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
+		return;
+
+	/* Create an attachment chain with two fentry progs */
+	for (int i = 0; i < 2; i++) {
+		tracing_chain[i] = fentry_recursive__open();
+		if (!ASSERT_OK_PTR(tracing_chain[i], "fentry_recursive__open"))
+			goto close_prog;
+
+		/* The first prog in the chain is going to be attached to the target
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
+				/* Flag attach_tracing_prog should still be set, preventing
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
+		fentry_recursive__destroy(tracing_chain[i]);
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


