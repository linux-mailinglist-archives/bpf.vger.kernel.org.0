Return-Path: <bpf+bounces-16398-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B20800ED2
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 16:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 146B21C20F54
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 15:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FE24BA8C;
	Fri,  1 Dec 2023 15:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyDBTo4l"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D76C170F
	for <bpf@vger.kernel.org>; Fri,  1 Dec 2023 07:51:22 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-54c4433e98bso1592988a12.3
        for <bpf@vger.kernel.org>; Fri, 01 Dec 2023 07:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701445881; x=1702050681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+npSO5VrXRYja4620D+qD53+Q+PxXgUKrZXRyIcrmKY=;
        b=DyDBTo4lcGjld88Xdz7DI7iUmJxYSGVXXyPwjp9vEKHM3Hhj7tqOYXBYk9WgRq7I/L
         qgBL5LAEUMEmYk7dBMiNJwyK2ez9RSorzZ1es0s6kt0KbQPFZq2cj5cLEGPO/6JAhSwX
         JjNzl2law+bUPPmC4TzLB+XgfL4RlpSzTLVaW3enR4Zhx6hX/pOKa/oUJ2+karslYGPn
         sgi9ZSHDje2DlbbIMwvuJWIGzjGN6Ehk4G9NUeA6zT7rzGBBpnjdsgcFeo539kncu1fU
         GW3vyNYYMfv1+d8q6optnbOTka9aahZfS73ZgObkkKXRV+PNHSzGMwGSskCKckayq8VF
         cTag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701445881; x=1702050681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+npSO5VrXRYja4620D+qD53+Q+PxXgUKrZXRyIcrmKY=;
        b=PKBByXKOGGrJkIyhOVxnTpSrA8vAmWxIeHoRqQyri7DcltRBGnKUvtOcUD1IPlxcFA
         sb/1QhA0Ydq4jMGCPZv6wS6Ip/S4RYXZQSyKH9hD92RIm5duhmcFbNpnDmH08bDLDsvS
         LnW9WB7qKd60VTjGqd5hXUvHBjbc88C8kiCEh2+sIWsKMx3NfvIYto+t2B62hr++Sks6
         GpPMY/+gZXr8khk9GwNwD00Z1Gke7VDjrWrPTOrfCIUSpU4E2gxM7BxYX5rsuvjBKRXu
         cjpM30TdVKNzr7TrsKyKVs6r+s/gF4lvHS/glVDG0i26TzbV9DGEe1V+Ih0JdB+10RS2
         OoBQ==
X-Gm-Message-State: AOJu0YxPqqhAkmpon88UGAXj81Fb6rfSVtgEAt5ZqZPPq2JpbtfBSNKM
	FvPKNwFeSLRDGP7plCirHWATEQl7IbOTlQ==
X-Google-Smtp-Source: AGHT+IEzjxvfyBvmZyBmBxHHcKgqV1qyRgm+caRVwigLcVXUh1yoeILWo9yWeuhMTRbqlNJGEWpPJw==
X-Received: by 2002:a17:906:cc8e:b0:a19:d40a:d256 with SMTP id oq14-20020a170906cc8e00b00a19d40ad256mr476912ejb.290.1701445880679;
        Fri, 01 Dec 2023 07:51:20 -0800 (PST)
Received: from erthalion.local (dslb-178-005-231-183.178.005.pools.vodafone-ip.de. [178.5.231.183])
        by smtp.gmail.com with ESMTPSA id k22-20020a170906159600b00a16c1716a20sm2033118ejd.115.2023.12.01.07.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 07:51:20 -0800 (PST)
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
Subject: [PATCH bpf-next v5 2/4] selftests/bpf: Add test for recursive attachment of tracing progs
Date: Fri,  1 Dec 2023 16:47:31 +0100
Message-ID: <20231201154734.8545-3-9erthalion6@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231201154734.8545-1-9erthalion6@gmail.com>
References: <20231201154734.8545-1-9erthalion6@gmail.com>
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


