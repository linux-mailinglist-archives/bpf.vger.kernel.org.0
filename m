Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46552455A56
	for <lists+bpf@lfdr.de>; Thu, 18 Nov 2021 12:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344037AbhKRLcR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Nov 2021 06:32:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49834 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344041AbhKRLaS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Nov 2021 06:30:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637234837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x9XHLN69dMYL16w7embbO4+Aae5TE1ecNy2oyFj9C+I=;
        b=U/uTPB7wB8G12qwdQyeAqxpZTG+/KSr7FwORCdQ+ci9HXicknH1qJ71RSAA4op3rf3RnVg
        1AYOpJTIRpd/rQMK1K7H3W6gi9P58PLv5zJZcmV4RS2tWGcUZsTt9w/mfbDGPE5y5xWugQ
        NpipQ6+yTKU6H2X/J59Dj7bC8DlGLR4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-BQwrOkpoNyS0RAbhkru7CA-1; Thu, 18 Nov 2021 06:27:16 -0500
X-MC-Unique: BQwrOkpoNyS0RAbhkru7CA-1
Received: by mail-ed1-f71.google.com with SMTP id r16-20020a056402019000b003e6cbb77ed2so4996057edv.10
        for <bpf@vger.kernel.org>; Thu, 18 Nov 2021 03:27:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x9XHLN69dMYL16w7embbO4+Aae5TE1ecNy2oyFj9C+I=;
        b=mhJMXb0sCntYedHZLMs9S/+/VgWCUmGISRmguledlyXCCjFd6NbhES1OUiUyTUVq1/
         Sa2SF3kgwfydXwB9WTdMne+CHdMzl3laajzygHKPeT7M2bap7EUGvkpDj5Ar0Fh149lh
         RfifibFUFlzWrtgamXRhchj9vFAZEin9+g2nEr0/HvM8JTMdAf+etsEQ1sf6EUKYGEaD
         NpM4/XHBSEEO8uZt+gZUnT2e7kiAwCwuF92080pAsAM9dTRcqLUIYJ/1xyR4gnYNJN1d
         an5R9I59cv5QHAFaocHA88cnvoXgiKN/OSr4rhk4TvWc4gItAzhQog890IOGdd51JpcQ
         MX9A==
X-Gm-Message-State: AOAM530sotQF6cynIi0lEWrjGp20QMwBGHqU33MqsL/VOjhGymoN0/tV
        8dWxbqdDgmY8cAGxWzqRsPtmI9IQgzCG1RjUdhvq9L8yef179usokD4JDAShFD40t8rll1yXWOX
        C1/V9MjMKoRUn
X-Received: by 2002:a17:907:7d89:: with SMTP id oz9mr32106285ejc.450.1637234835244;
        Thu, 18 Nov 2021 03:27:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxKZvEuUwu+FksxFjKTVn0La4xirfYOertt9DeRVat7py3YVHTo0B7rY1K6/fJpo/KnT+8RDg==
X-Received: by 2002:a17:907:7d89:: with SMTP id oz9mr32106258ejc.450.1637234835060;
        Thu, 18 Nov 2021 03:27:15 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id hr11sm1230357ejc.108.2021.11.18.03.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 03:27:14 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Subject: [PATCH bpf-next 23/29] selftests/bpf: Add bpf_arg/bpf_ret_value test
Date:   Thu, 18 Nov 2021 12:24:49 +0100
Message-Id: <20211118112455.475349-24-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211118112455.475349-1-jolsa@kernel.org>
References: <20211118112455.475349-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding tests for bpf_arg/bpf_ret_value helpers on
both fentry and fexit programs.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/args_test.c      | 34 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/args_test.c | 30 ++++++++++++++++
 2 files changed, 64 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/args_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/args_test.c

diff --git a/tools/testing/selftests/bpf/prog_tests/args_test.c b/tools/testing/selftests/bpf/prog_tests/args_test.c
new file mode 100644
index 000000000000..1938f2616ee9
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/args_test.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include "args_test.skel.h"
+
+void test_args_test(void)
+{
+	struct args_test *skel = NULL;
+	__u32 duration = 0, retval;
+	int err, prog_fd;
+
+	skel = args_test__open();
+	if (!ASSERT_OK_PTR(skel, "args_test__open"))
+		return;
+
+	err = args_test__load(skel);
+	if (!ASSERT_OK(err, "args_test__load"))
+		goto cleanup;
+
+	err = args_test__attach(skel);
+	if (!ASSERT_OK(err, "args_test__attach"))
+		goto cleanup;
+
+	prog_fd = bpf_program__fd(skel->progs.test1);
+	err = bpf_prog_test_run(prog_fd, 1, NULL, 0,
+				NULL, NULL, &retval, &duration);
+	ASSERT_OK(err, "test_run");
+	ASSERT_EQ(retval, 0, "test_run");
+
+	ASSERT_EQ(skel->bss->test1_result, 1, "test1_result");
+	ASSERT_EQ(skel->bss->test2_result, 1, "test2_result");
+
+cleanup:
+	args_test__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/args_test.c b/tools/testing/selftests/bpf/progs/args_test.c
new file mode 100644
index 000000000000..7fc8e9fb41bd
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/args_test.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+__u64 test1_result = 0;
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(test1)
+{
+	__u64 a = bpf_arg(ctx, 0);
+	__u64 x = bpf_arg(ctx, 1);
+
+	test1_result = (int) a == 1 && x == 0;
+	return 0;
+}
+
+__u64 test2_result = 0;
+SEC("fexit/bpf_fentry_test2")
+int BPF_PROG(test2)
+{
+	__u64 ret = bpf_ret_value(ctx);
+	__u64 a = bpf_arg(ctx, 0);
+	__u64 b = bpf_arg(ctx, 1);
+	__u64 x = bpf_arg(ctx, 2);
+
+	test2_result = (int) a == 2 && b == 3 && ret == 5 && x == 0;
+	return 0;
+}
-- 
2.31.1

