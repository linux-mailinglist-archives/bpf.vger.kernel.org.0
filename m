Return-Path: <bpf+bounces-4910-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E01E75168E
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 04:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDD0C281C3E
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 02:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59574688;
	Thu, 13 Jul 2023 02:56:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA767C
	for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 02:56:57 +0000 (UTC)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B19B4
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 19:56:56 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-5440e98616cso1008367a12.0
        for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 19:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689217016; x=1691809016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LRG+txNOklikmj/6gt3nAaksj7+xieHkr1+Yn0dyVw4=;
        b=kQ8nqoF3g04EBfdnZa8xa1L5P0PYx/Ih2ISj2VkXCEuR6ca7kxrnKCKuxsS1yurB+R
         Gt2zHapcWj/9UMAgXNTDAtLFzmegEHbH4b6AtluIgV8CvZIdYexAL2WLOeVeRAdFi1xW
         /hv7CBPmYmwobtsKpsydduvcPil5hw/4ng6Zndlbet41hzzFWzDtVd4nSPQlaxvKnMef
         mCDDOqlko1V4vldlSX/ohJoTlUdqH4FF1JeNZ8mylJ+uAI2s29u6whkYfs9fM5s+YAxE
         V9adDSHc5DjEgPovKBCM2usrzeqRnePz9t96+T/rb9uIX19LRrIjQNXYsEat44k4K6iN
         yMlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689217016; x=1691809016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LRG+txNOklikmj/6gt3nAaksj7+xieHkr1+Yn0dyVw4=;
        b=UqikRZpPgW1ixNU2I2Z3dE4E7DVoPg0dV/Vu9jNyjeyy0fbdmP6p+pKjaIZb29Ymmy
         JT1jl2py6R/3B4YFP9trufjsjxu0kLXI5xF+syNcM/daoDu6mQmM+q3gj+j4GZHnIwC0
         akPJHvygCx2wEKTjFuFTS/4CziuoO0w38DmWow3idf2jQrll1//6eMFQk6RrFouPbMaz
         zyikWLT3VGziekAWHpRW1w8rXOCiPbZ/SQL02wYqfG3xplkZjzI+HTvPmMnhk0+B3l7v
         LGu3oq56JgQGVDrc8fB3m1vNKpo1oGIRlP8lltVIl9zYmXn/07Pvv4hiLrnkF6SvZ0Tt
         2bbw==
X-Gm-Message-State: ABy/qLa4VL6D149zkLJoLkjrYRk7Jsa8/YRuC5AYhqqHoscdVMZR2Fn1
	g0SU3H+lo/oYyguJItEk60w=
X-Google-Smtp-Source: APBJJlG4FBnnJCuQMF7URqWQgdNiqVdEKmP+m3kjgNT9PbuyMaJ+d/YAIxiTNlXzbx6qtjKFEOexjA==
X-Received: by 2002:a17:90b:3a86:b0:256:675f:1d49 with SMTP id om6-20020a17090b3a8600b00256675f1d49mr938057pjb.0.1689217015675;
        Wed, 12 Jul 2023 19:56:55 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac02:a97:5400:4ff:fe81:66ad])
        by smtp.gmail.com with ESMTPSA id lr3-20020a17090b4b8300b00260a5ecd273sm4416681pjb.1.2023.07.12.19.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 19:56:55 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v2 bpf-next 4/4] selftests/bpf: Add selftest for PTR_UNTRUSTED
Date: Thu, 13 Jul 2023 02:56:42 +0000
Message-Id: <20230713025642.27477-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230713025642.27477-1-laoar.shao@gmail.com>
References: <20230713025642.27477-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a new selftest to check the PTR_UNTRUSTED condition. Below is the
result,

 #160     ptr_untrusted:OK

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 .../selftests/bpf/prog_tests/ptr_untrusted.c  | 36 +++++++++++++++++++
 .../selftests/bpf/progs/test_ptr_untrusted.c  | 29 +++++++++++++++
 2 files changed, 65 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ptr_untrusted.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_ptr_untrusted.c

diff --git a/tools/testing/selftests/bpf/prog_tests/ptr_untrusted.c b/tools/testing/selftests/bpf/prog_tests/ptr_untrusted.c
new file mode 100644
index 000000000000..8d077d150c56
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/ptr_untrusted.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2023 Yafang Shao <laoar.shao@gmail.com> */
+
+#include <string.h>
+#include <linux/bpf.h>
+#include <test_progs.h>
+#include "test_ptr_untrusted.skel.h"
+
+#define TP_NAME "sched_switch"
+
+void serial_test_ptr_untrusted(void)
+{
+	struct test_ptr_untrusted *skel;
+	int err;
+
+	skel = test_ptr_untrusted__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		goto cleanup;
+
+	/* First, attach lsm prog */
+	skel->links.lsm_run = bpf_program__attach_lsm(skel->progs.lsm_run);
+	if (!ASSERT_OK_PTR(skel->links.lsm_run, "lsm_attach"))
+		goto cleanup;
+
+	/* Second, attach raw_tp prog. The lsm prog will be triggered. */
+	skel->links.raw_tp_run = bpf_program__attach_raw_tracepoint(skel->progs.raw_tp_run,
+								    TP_NAME);
+	if (!ASSERT_OK_PTR(skel->links.raw_tp_run, "raw_tp_attach"))
+		goto cleanup;
+
+	err = strncmp(skel->bss->tp_name, TP_NAME, strlen(TP_NAME));
+	ASSERT_EQ(err, 0, "cmp_tp_name");
+
+cleanup:
+	test_ptr_untrusted__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_ptr_untrusted.c b/tools/testing/selftests/bpf/progs/test_ptr_untrusted.c
new file mode 100644
index 000000000000..4bdd65b5aa2d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_ptr_untrusted.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2023 Yafang Shao <laoar.shao@gmail.com> */
+
+#include "vmlinux.h"
+#include <bpf/bpf_tracing.h>
+
+char tp_name[128];
+
+SEC("lsm/bpf")
+int BPF_PROG(lsm_run, int cmd, union bpf_attr *attr, unsigned int size)
+{
+	switch (cmd) {
+	case BPF_RAW_TRACEPOINT_OPEN:
+		bpf_probe_read_user_str(tp_name, sizeof(tp_name) - 1,
+					(void *)attr->raw_tracepoint.name);
+		break;
+	default:
+		break;
+	}
+	return 0;
+}
+
+SEC("raw_tracepoint")
+int BPF_PROG(raw_tp_run)
+{
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.39.3


