Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 988702C59B8
	for <lists+bpf@lfdr.de>; Thu, 26 Nov 2020 18:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403927AbgKZQ7H (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Nov 2020 11:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403923AbgKZQ7G (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Nov 2020 11:59:06 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E074C0617A7
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2020 08:59:05 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id 3so334188wmj.4
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2020 08:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yiihBYT29r/F8u49HtrLNtVGlhzIYUGfbvVDX4SQ4Us=;
        b=JbwJAnnczSMj8Bkfb75JNqFiES00+ZMEGcmdQTL3NapeB7Ia86rKrZ+Mg5Uhjk4qtZ
         vlAakh+huJ0GfKOIgxXjKgs+9c/lmlJDT875SshAPOpcyP7K9igd08TovQGfwPaiBJtd
         NvPDNnoVnbWDAoFqVsrSdcO2wgyn+g8yvrnng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yiihBYT29r/F8u49HtrLNtVGlhzIYUGfbvVDX4SQ4Us=;
        b=nJJTuj7nuLL1Ym23iK7skyzLr6qhOXtsNUPpYfOObfiHEGOp4W8JNefJGSyAe5YHAt
         eVUMLUrFqQTpuyMk7HcZIt74vKN0TGm62VfCmDY+DB+m8QmrsADMUvsx96bslpUWd/XR
         yTZK+7rgcrRi2T+9lm1zsNz+Qu66j9ahD1TaP57N8Wg7+NgfuWGAhCT4k39YNzqTHY51
         9jCoEPBBnJLRoGU2PyMIUylE5cWld4CQ2Vl2Q86bLoaADoeYenGRrglXCkijMu0Ap6jc
         ScXk0oMzeehwj5Es28/0+lnGbTIsvg8m1yLq2Fn3QH4XqVYzFm/2F+zLAaxXY/xDhw1a
         9ejA==
X-Gm-Message-State: AOAM53275ZARz8PWKvBNj9JHEFobfMv89AtbUTbOOEZcPpSK8/N7/n2x
        hazoDOjwXGXFjwdDz5nMOYjIX632eINdQ+qd
X-Google-Smtp-Source: ABdhPJxIrqvMoXZzhTP8EI1BkupGBVYUC0Y2SeBVcJDR5a6h+t8bHPKs9RaJGjUL/5zPm4o1reLqrg==
X-Received: by 2002:a1c:7318:: with SMTP id d24mr4453757wmb.39.1606409944007;
        Thu, 26 Nov 2020 08:59:04 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:f693:9fff:fef4:a569])
        by smtp.gmail.com with ESMTPSA id 17sm8768032wmf.48.2020.11.26.08.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 08:59:03 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
X-Google-Original-From: Florent Revest <revest@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@chromium.org, revest@google.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add bpf_kallsyms_lookup test
Date:   Thu, 26 Nov 2020 17:57:48 +0100
Message-Id: <20201126165748.1748417-2-revest@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
In-Reply-To: <20201126165748.1748417-1-revest@google.com>
References: <20201126165748.1748417-1-revest@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This piggybacks on the existing "ksyms" test because this test also
relies on a __ksym symbol and requires CONFIG_KALLSYMS.

Signed-off-by: Florent Revest <revest@google.com>
---
 tools/testing/selftests/bpf/config            |  1 +
 .../testing/selftests/bpf/prog_tests/ksyms.c  | 46 ++++++++++++++++++-
 .../bpf/progs/test_kallsyms_lookup.c          | 38 +++++++++++++++
 3 files changed, 84 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_kallsyms_lookup.c

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 365bf9771b07..791a46e5d013 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -43,3 +43,4 @@ CONFIG_IMA=y
 CONFIG_SECURITYFS=y
 CONFIG_IMA_WRITE_POLICY=y
 CONFIG_IMA_READ_POLICY=y
+CONFIG_KALLSYMS=y
diff --git a/tools/testing/selftests/bpf/prog_tests/ksyms.c b/tools/testing/selftests/bpf/prog_tests/ksyms.c
index b295969b263b..0478b67a92ae 100644
--- a/tools/testing/selftests/bpf/prog_tests/ksyms.c
+++ b/tools/testing/selftests/bpf/prog_tests/ksyms.c
@@ -3,11 +3,12 @@
 
 #include <test_progs.h>
 #include "test_ksyms.skel.h"
+#include "test_kallsyms_lookup.skel.h"
 #include <sys/stat.h>
 
 static int duration;
 
-void test_ksyms(void)
+void test_ksyms_variables(void)
 {
 	const char *btf_path = "/sys/kernel/btf/vmlinux";
 	struct test_ksyms *skel;
@@ -59,3 +60,46 @@ void test_ksyms(void)
 cleanup:
 	test_ksyms__destroy(skel);
 }
+
+void test_kallsyms_lookup(void)
+{
+	struct test_kallsyms_lookup *skel;
+	int err;
+
+	skel = test_kallsyms_lookup__open_and_load();
+	if (CHECK(!skel, "skel_open", "failed to open and load skeleton\n"))
+		return;
+
+	err = test_kallsyms_lookup__attach(skel);
+	if (CHECK(err, "skel_attach", "skeleton attach failed: %d\n", err))
+		goto cleanup;
+
+	/* trigger tracepoint */
+	usleep(1);
+
+	CHECK(strcmp(skel->bss->name, "schedule"), "name",
+	      "got \"%s\", exp \"schedule\"\n", skel->bss->name);
+	CHECK(strcmp(skel->bss->name_truncated, "sched"), "name_truncated",
+	      "got \"%s\", exp \"sched\"\n", skel->bss->name_truncated);
+	CHECK(strcmp(skel->bss->name_invalid, ""), "name_invalid",
+	      "got \"%s\", exp \"\"\n", skel->bss->name_invalid);
+	CHECK(strcmp(skel->bss->module_name, ""), "module_name",
+	      "got \"%s\", exp \"\"\n", skel->bss->module_name);
+	CHECK(skel->bss->schedule_ret != 9, "schedule_ret",
+	      "got %d, exp 0\n", skel->bss->schedule_ret);
+	CHECK(skel->bss->sched_ret != 9, "sched_ret",
+	      "got %d, exp 0\n", skel->bss->sched_ret);
+	CHECK(skel->bss->invalid_ret != -EINVAL, "invalid_ret",
+	      "got %d, exp %d\n", skel->bss->invalid_ret, -EINVAL);
+
+cleanup:
+	test_kallsyms_lookup__destroy(skel);
+}
+
+void test_ksyms(void)
+{
+	if (test__start_subtest("ksyms_variables"))
+		test_ksyms_variables();
+	if (test__start_subtest("kallsyms_lookup"))
+		test_kallsyms_lookup();
+}
diff --git a/tools/testing/selftests/bpf/progs/test_kallsyms_lookup.c b/tools/testing/selftests/bpf/progs/test_kallsyms_lookup.c
new file mode 100644
index 000000000000..4f15f1527ab4
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_kallsyms_lookup.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2020 Google LLC. */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+extern const void schedule __ksym;
+
+#define SYMBOL_NAME_LEN			10
+char name[SYMBOL_NAME_LEN];
+char name_invalid[SYMBOL_NAME_LEN];
+
+#define SYMBOL_TRUNCATED_NAME_LEN	6
+char name_truncated[SYMBOL_TRUNCATED_NAME_LEN];
+
+#define MODULE_NAME_LEN			64
+char module_name[MODULE_NAME_LEN];
+
+long schedule_ret;
+long sched_ret;
+long invalid_ret;
+
+SEC("raw_tp/sys_enter")
+int handler(const void *ctx)
+{
+	schedule_ret = bpf_kallsyms_lookup((__u64)&schedule,
+					   name, SYMBOL_NAME_LEN,
+					   module_name, MODULE_NAME_LEN);
+	invalid_ret = bpf_kallsyms_lookup(0,
+					  name_invalid, SYMBOL_NAME_LEN,
+					  module_name, MODULE_NAME_LEN);
+	sched_ret = bpf_kallsyms_lookup((__u64)&schedule, name_truncated,
+					SYMBOL_TRUNCATED_NAME_LEN,
+					module_name, MODULE_NAME_LEN);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.29.2.454.gaff20da3a2-goog

