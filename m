Return-Path: <bpf+bounces-18409-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 170A881A6AE
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 19:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C17CA288194
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 18:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB35482E2;
	Wed, 20 Dec 2023 18:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTpJz8Vp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D908A481D3
	for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 18:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2cc843af59fso25163811fa.0
        for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 10:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703095702; x=1703700502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=geCSGBH5RbQe+fvHFKCKqVJsE1KseYsRl2tX4rdcqqc=;
        b=RTpJz8VpjzYUWc5fSfdYUhf5dMEz5DkXq74NmrSzdslCIeNL0zOy9tidkUNmr9QyFs
         rUn0iyczyJTbhm5gvV/vd/k0ox+Ss7H16LZsx7nq9PVnOHTXsYoQaeoi/0LCJwMiHwvv
         N0ZvhKESSmKdXCyHdZhMnuqKtGDcr2BMGT9yxC17J+EKCCJBweLLCD5CROQDBJ7NumbJ
         /5lNRQhwZ3wPTZim1SgGOSD3HiUV6oMOFOs167TDwG2aGwLeC4iXpAzGR+Lg4ann56bC
         o/EAbFfNUlsDUyiy2e0kC8jSOe9IOJ67xCnyT9gOqjHGC1Iw5jO2iulscx4mckHXtYVQ
         O3Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703095702; x=1703700502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=geCSGBH5RbQe+fvHFKCKqVJsE1KseYsRl2tX4rdcqqc=;
        b=e7cbKonkZ/3x7IekY9WaJfh8c6lzQRpgABxLN+0uqaSFWUnUm7kX1S9rBQKaxMMfmh
         RmUtwUxq5Ogc/rue5p/cTIDFvfVRCg4ZaUHtfnabBiWqyJZIPndmolcAlbUGpSIB2Gda
         uRJ7nh/cgs2TE7JW+BldYHaLk/b+2Y03OhiLmu4J8LTHPm0mvvc43vhlnLj4j4vIi3Cx
         xGYPN7ki9fg3/v7uv92r0Ebl1kb2EmtEQEEdQKKjOYlGOKVVU4TICF4jZCddbn0ij/11
         HY8yfXRJwVls6n2G/utyl/wL0S0/utjjlif0kagx9eZbBmJpGpCPL3lES/Qjd9jYBj6c
         JbRg==
X-Gm-Message-State: AOJu0YygZQVjhkhzpYaGkvuh4PQbdXwMSjOuAohhHf17EhTDsYCzkh62
	lWKth3Yh9EBdUKw956X5fmtzfrCmHU5w1Q==
X-Google-Smtp-Source: AGHT+IGkzcDvENY5/L3bpvzbaRuFB+CAZYgoscRf/efw3kleidWdxPfUFyrkrabMhsNCqgcfMTxo7Q==
X-Received: by 2002:a2e:2e12:0:b0:2cc:8dda:c979 with SMTP id u18-20020a2e2e12000000b002cc8ddac979mr904789lju.51.1703095701563;
        Wed, 20 Dec 2023 10:08:21 -0800 (PST)
Received: from erthalion.local (dslb-178-005-229-020.178.005.pools.vodafone-ip.de. [178.5.229.20])
        by smtp.gmail.com with ESMTPSA id b3-20020aa7d483000000b0054c7dfc63b4sm83786edr.43.2023.12.20.10.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 10:08:21 -0800 (PST)
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
Subject: [PATCH bpf-next v10 2/4] selftests/bpf: Add test for recursive attachment of tracing progs
Date: Wed, 20 Dec 2023 19:04:17 +0100
Message-ID: <20231220180422.8375-3-9erthalion6@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231220180422.8375-1-9erthalion6@gmail.com>
References: <20231220180422.8375-1-9erthalion6@gmail.com>
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
Changes in v10:
    - Add tests for loading tracing progs without attaching, and
      detaching tracing progs.

Changes in v8:
    - Cleanup test bpf progs and the content of first/second condition
      in the loop.

Changes in v5:
    - Test only one level of attachment

 .../bpf/prog_tests/recursive_attach.c         | 192 ++++++++++++++++++
 .../selftests/bpf/progs/fentry_recursive.c    |  16 ++
 .../bpf/progs/fentry_recursive_target.c       |  17 ++
 3 files changed, 225 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/recursive_attach.c
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_recursive.c
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_recursive_target.c

diff --git a/tools/testing/selftests/bpf/prog_tests/recursive_attach.c b/tools/testing/selftests/bpf/prog_tests/recursive_attach.c
new file mode 100644
index 000000000000..4b46dc358925
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/recursive_attach.c
@@ -0,0 +1,192 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Red Hat, Inc. */
+#include <test_progs.h>
+#include "fentry_recursive.skel.h"
+#include "fentry_recursive_target.skel.h"
+#include <bpf/btf.h>
+#include "bpf/libbpf_internal.h"
+
+/*
+ * Test that recursive attachment of tracing progs with more than one nesting
+ * level is not possible. Create a chain of attachment, verify that the last
+ * prog will fail.
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
+
+/*
+ * Test that recursive loading of tracing progs with more than one nesting
+ * level is not possible either. Identical to the previous one, but without
+ * fentry attach.
+ */
+void test_recursive_fentry_load(void)
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
+/*
+ * Test that attach_tracing_prog flag will be set throughout the whole
+ * lifecycle of an fentry prog, independently from whether it's detached.
+ */
+void test_recursive_fentry_detach(void)
+{
+	struct fentry_recursive_target *target_skel = NULL;
+	struct fentry_recursive *tracing_chain[2] = {};
+	struct bpf_program *prog;
+	int prev_fd, err;
+
+	/* Load the target fentry */
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
+
+			/*
+			 * Flag attach_tracing_prog should still be set, preventing
+			 * attachment of the following prog.
+			 */
+			fentry_recursive__detach(tracing_chain[i]);
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


