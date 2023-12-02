Return-Path: <bpf+bounces-16516-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40960801E34
	for <lists+bpf@lfdr.de>; Sat,  2 Dec 2023 20:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0F501F21196
	for <lists+bpf@lfdr.de>; Sat,  2 Dec 2023 19:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4838C208D3;
	Sat,  2 Dec 2023 19:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kB0nyE3V"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FEF8119
	for <bpf@vger.kernel.org>; Sat,  2 Dec 2023 11:19:48 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-a184d717de1so449009266b.1
        for <bpf@vger.kernel.org>; Sat, 02 Dec 2023 11:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701544787; x=1702149587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+npSO5VrXRYja4620D+qD53+Q+PxXgUKrZXRyIcrmKY=;
        b=kB0nyE3Vu1mTW+5mA5FOSu3YuRRv/NZ5i5/qj+9FI+PInUp9ExwXUrUKVLsOA/qHqi
         fQaIOFdARM6R/PWBftdRgypbfmvtxmKkWhMn/lFwQskaYybNq7UNt4DA0GbwSarCodRO
         ahWBqcS2i2MECFB4vemJgWwnPbNne/2mu6ZXafr/BNsZQpp6cGXmxkkqbwkrNLDhtsph
         MofZOv96tD5DDYN5GduFyGqn4H5rWZdyBpwMYE0jEyNIQn4VUZ+yoyQloqOqOm+uV3gK
         VInKtu3A7tdhm/pcwSNNAPElkSz53YpbNJPYPakJ2pNe3scdVonX5/oGSxxQ+6frZ9xh
         PhBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701544787; x=1702149587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+npSO5VrXRYja4620D+qD53+Q+PxXgUKrZXRyIcrmKY=;
        b=DbikEkdcEKcYptmakq5r/OWSM3W4LwR1thC5g2kzyRLrMRJs6NLbNtfx0xJ223rwEV
         G4ZYbbTadD+Zmdbxr5CGmZG/iZhfLJz579yhzFvPCiZ8a5exZMwh47nZ0AcdM2h35DQg
         K7tooh2OVo83ag+gWx+4YQrPaTIsXYGpnn8YtMRZPoO/Dk7nqR8fBe5U1+JBbFBG30hX
         pDPGhENJVxl8yev6Ocns2nC2F0/uYw4FT5yuQliphxc+wOFxAKeHV7kJENwwQPYM6dhr
         +aNdb9rpC40mfvgCwLuT1YiPCG5cC8x2YRJJAbwWcc6l0IdCSi+gjPSPOjdIaxUkf6Cj
         argw==
X-Gm-Message-State: AOJu0YwnEAFu/R3u8mcY4lzLabjIThyo0hRtk9F3uMvmX5kxVVciBqPm
	M5Mi0p5F8M7Qjnq+ljIk7drMnhKtgyl2ww==
X-Google-Smtp-Source: AGHT+IEP9f37vFAxDuMIl4+2a3iHoajFG93IJ4s+GDB74S0tjA8uchI2cIdOxUKUQbVStLYcsROWdA==
X-Received: by 2002:a17:907:2da8:b0:a19:a19b:4232 with SMTP id gt40-20020a1709072da800b00a19a19b4232mr1846516ejc.157.1701544787021;
        Sat, 02 Dec 2023 11:19:47 -0800 (PST)
Received: from localhost.localdomain ([2a00:20:6008:6fb9:fa16:54ff:fe6e:2940])
        by smtp.gmail.com with ESMTPSA id i23-20020a170906115700b00a18ed83ce42sm3127814eja.15.2023.12.02.11.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 11:19:46 -0800 (PST)
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
Subject: [PATCH bpf-next v6 2/4] selftests/bpf: Add test for recursive attachment of tracing progs
Date: Sat,  2 Dec 2023 20:15:48 +0100
Message-ID: <20231202191556.30997-3-9erthalion6@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231202191556.30997-1-9erthalion6@gmail.com>
References: <20231202191556.30997-1-9erthalion6@gmail.com>
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


