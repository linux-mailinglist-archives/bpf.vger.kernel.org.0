Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A583635FB2E
	for <lists+bpf@lfdr.de>; Wed, 14 Apr 2021 20:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353152AbhDNSzE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Apr 2021 14:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348477AbhDNSyo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Apr 2021 14:54:44 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3580AC06138E
        for <bpf@vger.kernel.org>; Wed, 14 Apr 2021 11:54:22 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id k26so4449152wrc.8
        for <bpf@vger.kernel.org>; Wed, 14 Apr 2021 11:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZrguiEZQBncRoBtaNZyBwb8KxAudSocLCfIdylJjreQ=;
        b=lehCtb1Tgya4NICc9Ai4JSrUUbJ32q8UU0LBorVBDVkY76NJ/n0NaDbe7+ADhODkEA
         K8S5+cE+hbvQISlvebNzrwgZQIKrTkApi8wVTsmurOecQITj6lKCnXKaGgjpE2C3AB5X
         fFocM6nvYkboc9zxuN7hkWEsyrOF7lKmaILSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZrguiEZQBncRoBtaNZyBwb8KxAudSocLCfIdylJjreQ=;
        b=Q5ug5j83pfiht4UvUeAgvpnzJEh/gPWKCYpy6hNtyPqc5x4j5C1ebN+OYNXvgHpPA1
         9jk6uxWRRfDCLTldI9tYn8juOs7H+BrlpaKEPAShF09JZTO6GDL+GkP1Ez+RL+7k4rtO
         +EUMORav+EcsnRmOH+eLIlXkc7OHqSXvPd/zYoD2CXkgfTU2jYG1jeTbFs5+/kYzknvb
         OmxYc1hEpko1HtfK18PpK2bGI7zupUBtvlc2jCeqAy96hTiLGE2XADj5GZgiPLZJAPXB
         Joa0n5hFZuhrEMIfOc/nKkvC13Fs1JUxZm/sOeC07nISIAx3gF6nKXGFFek+bcMeID1N
         ZZ6g==
X-Gm-Message-State: AOAM533zEWciCnGaKeef07Jakn4cpX/e0SVBprvl6T1E0pi81oIxgcqD
        furwtOvuzz0Ga9WlW6Eg5kE2ax8tn6A42Q==
X-Google-Smtp-Source: ABdhPJxn5FTTNvsxEwwEHR2sz43bvRkK/fxlGIQ64P4w38wlfAQioCT0ZgFzJek+ZDUgleYl0habtg==
X-Received: by 2002:adf:da4f:: with SMTP id r15mr9985927wrl.411.1618426460600;
        Wed, 14 Apr 2021 11:54:20 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:8b2a:41bd:9d62:10d5])
        by smtp.gmail.com with ESMTPSA id f12sm253131wrr.61.2021.04.14.11.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 11:54:20 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, jackmanb@chromium.org,
        linux-kernel@vger.kernel.org, Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v4 6/6] selftests/bpf: Add a series of tests for bpf_snprintf
Date:   Wed, 14 Apr 2021 20:54:06 +0200
Message-Id: <20210414185406.917890-7-revest@chromium.org>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
In-Reply-To: <20210414185406.917890-1-revest@chromium.org>
References: <20210414185406.917890-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The "positive" part tests all format specifiers when things go well.

The "negative" part makes sure that incorrect format strings fail at
load time.

Signed-off-by: Florent Revest <revest@chromium.org>
---
 .../selftests/bpf/prog_tests/snprintf.c       | 124 ++++++++++++++++++
 .../selftests/bpf/progs/test_snprintf.c       |  73 +++++++++++
 .../bpf/progs/test_snprintf_single.c          |  20 +++
 3 files changed, 217 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/snprintf.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_snprintf.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_snprintf_single.c

diff --git a/tools/testing/selftests/bpf/prog_tests/snprintf.c b/tools/testing/selftests/bpf/prog_tests/snprintf.c
new file mode 100644
index 000000000000..661ffb390b4a
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/snprintf.c
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Google LLC. */
+
+#include <test_progs.h>
+#include "test_snprintf.skel.h"
+#include "test_snprintf_single.skel.h"
+
+#define EXP_NUM_OUT  "-8 9 96 -424242 1337 DABBAD00"
+#define EXP_NUM_RET  sizeof(EXP_NUM_OUT)
+
+#define EXP_IP_OUT   "127.000.000.001 0000:0000:0000:0000:0000:0000:0000:0001"
+#define EXP_IP_RET   sizeof(EXP_IP_OUT)
+
+/* The third specifier, %pB, depends on compiler inlining so don't check it */
+#define EXP_SYM_OUT  "schedule schedule+0x0/"
+#define MIN_SYM_RET  sizeof(EXP_SYM_OUT)
+
+/* The third specifier, %p, is a hashed pointer which changes on every reboot */
+#define EXP_ADDR_OUT "0000000000000000 ffff00000add4e55 "
+#define EXP_ADDR_RET sizeof(EXP_ADDR_OUT "unknownhashedptr")
+
+#define EXP_STR_OUT  "str1 longstr"
+#define EXP_STR_RET  sizeof(EXP_STR_OUT)
+
+#define EXP_OVER_OUT "%over"
+#define EXP_OVER_RET 10
+
+#define EXP_PAD_OUT "    4 000"
+#define EXP_PAD_RET 900007
+
+#define EXP_NO_ARG_OUT "simple case"
+#define EXP_NO_ARG_RET 12
+
+#define EXP_NO_BUF_RET 29
+
+void test_snprintf_positive(void)
+{
+	char exp_addr_out[] = EXP_ADDR_OUT;
+	char exp_sym_out[]  = EXP_SYM_OUT;
+	struct test_snprintf *skel;
+
+	skel = test_snprintf__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	if (!ASSERT_OK(test_snprintf__attach(skel), "skel_attach"))
+		goto cleanup;
+
+	/* trigger tracepoint */
+	usleep(1);
+
+	ASSERT_STREQ(skel->bss->num_out, EXP_NUM_OUT, "num_out");
+	ASSERT_EQ(skel->bss->num_ret, EXP_NUM_RET, "num_ret");
+
+	ASSERT_STREQ(skel->bss->ip_out, EXP_IP_OUT, "ip_out");
+	ASSERT_EQ(skel->bss->ip_ret, EXP_IP_RET, "ip_ret");
+
+	ASSERT_OK(memcmp(skel->bss->sym_out, exp_sym_out,
+			 sizeof(exp_sym_out) - 1), "sym_out");
+	ASSERT_LT(MIN_SYM_RET, skel->bss->sym_ret, "sym_ret");
+
+	ASSERT_OK(memcmp(skel->bss->addr_out, exp_addr_out,
+			 sizeof(exp_addr_out) - 1), "addr_out");
+	ASSERT_EQ(skel->bss->addr_ret, EXP_ADDR_RET, "addr_ret");
+
+	ASSERT_STREQ(skel->bss->str_out, EXP_STR_OUT, "str_out");
+	ASSERT_EQ(skel->bss->str_ret, EXP_STR_RET, "str_ret");
+
+	ASSERT_STREQ(skel->bss->over_out, EXP_OVER_OUT, "over_out");
+	ASSERT_EQ(skel->bss->over_ret, EXP_OVER_RET, "over_ret");
+
+	ASSERT_STREQ(skel->bss->pad_out, EXP_PAD_OUT, "pad_out");
+	ASSERT_EQ(skel->bss->pad_ret, EXP_PAD_RET, "pad_ret");
+
+	ASSERT_STREQ(skel->bss->noarg_out, EXP_NO_ARG_OUT, "no_arg_out");
+	ASSERT_EQ(skel->bss->noarg_ret, EXP_NO_ARG_RET, "no_arg_ret");
+
+	ASSERT_EQ(skel->bss->nobuf_ret, EXP_NO_BUF_RET, "no_buf_ret");
+
+cleanup:
+	test_snprintf__destroy(skel);
+}
+
+#define min(a, b) ((a) < (b) ? (a) : (b))
+
+/* Loads an eBPF object calling bpf_snprintf with up to 10 characters of fmt */
+static int load_single_snprintf(char *fmt)
+{
+	struct test_snprintf_single *skel;
+	int ret;
+
+	skel = test_snprintf_single__open();
+	if (!skel)
+		return -EINVAL;
+
+	memcpy(skel->rodata->fmt, fmt, min(strlen(fmt) + 1, 10));
+
+	ret = test_snprintf_single__load(skel);
+	if (!ret)
+		test_snprintf_single__destroy(skel);
+
+	return ret;
+}
+
+void test_snprintf_negative(void)
+{
+	ASSERT_OK(load_single_snprintf("valid %d"), "valid usage");
+
+	ASSERT_ERR(load_single_snprintf("0123456789"), "no terminating zero");
+	ASSERT_ERR(load_single_snprintf("%d %d"), "too many specifiers");
+	ASSERT_ERR(load_single_snprintf("%pi5"), "invalid specifier 1");
+	ASSERT_ERR(load_single_snprintf("%a"), "invalid specifier 2");
+	ASSERT_ERR(load_single_snprintf("%"), "invalid specifier 3");
+	ASSERT_ERR(load_single_snprintf("\x80"), "non ascii character");
+	ASSERT_ERR(load_single_snprintf("\x1"), "non printable character");
+}
+
+void test_snprintf(void)
+{
+	if (test__start_subtest("snprintf_positive"))
+		test_snprintf_positive();
+	if (test__start_subtest("snprintf_negative"))
+		test_snprintf_negative();
+}
diff --git a/tools/testing/selftests/bpf/progs/test_snprintf.c b/tools/testing/selftests/bpf/progs/test_snprintf.c
new file mode 100644
index 000000000000..951a0301c553
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_snprintf.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Google LLC. */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char num_out[64] = {};
+long num_ret = 0;
+
+char ip_out[64] = {};
+long ip_ret = 0;
+
+char sym_out[64] = {};
+long sym_ret = 0;
+
+char addr_out[64] = {};
+long addr_ret = 0;
+
+char str_out[64] = {};
+long str_ret = 0;
+
+char over_out[6] = {};
+long over_ret = 0;
+
+char pad_out[10] = {};
+long pad_ret = 0;
+
+char noarg_out[64] = {};
+long noarg_ret = 0;
+
+long nobuf_ret = 0;
+
+extern const void schedule __ksym;
+
+SEC("raw_tp/sys_enter")
+int handler(const void *ctx)
+{
+	/* Convenient values to pretty-print */
+	const __u8 ex_ipv4[] = {127, 0, 0, 1};
+	const __u8 ex_ipv6[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1};
+	static const char str1[] = "str1";
+	static const char longstr[] = "longstr";
+
+	/* Integer types */
+	num_ret  = BPF_SNPRINTF(num_out, sizeof(num_out),
+				"%d %u %x %li %llu %lX",
+				-8, 9, 150, -424242, 1337, 0xDABBAD00);
+	/* IP addresses */
+	ip_ret   = BPF_SNPRINTF(ip_out, sizeof(ip_out), "%pi4 %pI6",
+				&ex_ipv4, &ex_ipv6);
+	/* Symbol lookup formatting */
+	sym_ret  = BPF_SNPRINTF(sym_out,  sizeof(sym_out), "%ps %pS %pB",
+				&schedule, &schedule, &schedule);
+	/* Kernel pointers */
+	addr_ret = BPF_SNPRINTF(addr_out, sizeof(addr_out), "%pK %px %p",
+				0, 0xFFFF00000ADD4E55, 0xFFFF00000ADD4E55);
+	/* Strings embedding */
+	str_ret  = BPF_SNPRINTF(str_out, sizeof(str_out), "%s %+05s",
+				str1, longstr);
+	/* Overflow */
+	over_ret = BPF_SNPRINTF(over_out, sizeof(over_out), "%%overflow");
+	/* Padding of fixed width numbers */
+	pad_ret = BPF_SNPRINTF(pad_out, sizeof(pad_out), "%5d %0900000X", 4, 4);
+	/* No args */
+	noarg_ret = BPF_SNPRINTF(noarg_out, sizeof(noarg_out), "simple case");
+	/* No buffer */
+	nobuf_ret = BPF_SNPRINTF(NULL, 0, "only interested in length %d", 60);
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/test_snprintf_single.c b/tools/testing/selftests/bpf/progs/test_snprintf_single.c
new file mode 100644
index 000000000000..15ccc5c43803
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_snprintf_single.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Google LLC. */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+// The format string is filled from the userspace side such that loading fails
+static const char fmt[10];
+
+SEC("raw_tp/sys_enter")
+int handler(const void *ctx)
+{
+	unsigned long long arg = 42;
+
+	bpf_snprintf(NULL, 0, fmt, &arg, sizeof(arg));
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.31.1.295.g9ea45b61b8-goog

