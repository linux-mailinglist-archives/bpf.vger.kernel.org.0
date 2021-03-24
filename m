Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78F71346F71
	for <lists+bpf@lfdr.de>; Wed, 24 Mar 2021 03:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234856AbhCXCXY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Mar 2021 22:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234875AbhCXCXL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Mar 2021 22:23:11 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A837C061765
        for <bpf@vger.kernel.org>; Tue, 23 Mar 2021 19:23:11 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id c8so9925191wrq.11
        for <bpf@vger.kernel.org>; Tue, 23 Mar 2021 19:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ypwDPCx98zAc5CG/YcMRqXN6R3Vb91xHH9Cz6NHtnOI=;
        b=iDLjn7gTZTY+s7TP/pEr3EPixNk+TQ3wGwOFwHpqrk5nekqmtCPYCBpxYsRfGewwny
         2uOS4rRvPCsg3OlAmIYKWgC2dgFYulA9soxfsjQ7BZ4lywo1dzFakVEwfqtXbMnR8Nym
         dhWJkFEME69UNizkUI9FZTdGqDNiWX+2bOdMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ypwDPCx98zAc5CG/YcMRqXN6R3Vb91xHH9Cz6NHtnOI=;
        b=C1k9zfNgJubWCGNoIMU8xCy6bwPs3E9M+oKcQPZqYS5XUwtNVRzrobOyLnkAvLs5fj
         JX0PahOwnwRnDySijOJuU4NXhXfB9yLWyE823VONwbhPx3h2rIUSNW588hdNnqAOixtJ
         +m0z5gBeHrqtCDguaO3EhD5OwL0+8wlMQqnTFO+gVzWbHiDRLVC+FVPYXUhKfw+k/dTZ
         GJq6ex2ak7O/YBjHw85pAwZy63CrmclWvmaqi+fnAj8BqSVPXvQGYX7zv6LLJxKEhrLm
         rGeCebBDLtD51Dbml14XAem2NR3wGMLdU3FpgPycMI2LTy5lqcyUudRtWF1bKG/5WVUy
         PinQ==
X-Gm-Message-State: AOAM533y760nmOaPsPa2t2Wwtk8eQv609ijgEXTWmA+VDtMUUhf9M1uF
        /Qg9cPoIC4FdN0XbPbuM/Rtql8PokhLKGg==
X-Google-Smtp-Source: ABdhPJydB+SkgWEXBQtVbBCDvs1Ah9fF+eIjKuI3a+Zqp1zcXFRq5HVQMcq67xzJGJS9jKk+wNASAw==
X-Received: by 2002:adf:fec5:: with SMTP id q5mr810257wrs.43.1616552589900;
        Tue, 23 Mar 2021 19:23:09 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:ccba:9601:929c:dbcb])
        by smtp.gmail.com with ESMTPSA id n9sm74219wrx.46.2021.03.23.19.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 19:23:09 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, jackmanb@chromium.org,
        linux-kernel@vger.kernel.org, Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v2 6/6] selftests/bpf: Add a series of tests for bpf_snprintf
Date:   Wed, 24 Mar 2021 03:22:11 +0100
Message-Id: <20210324022211.1718762-7-revest@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210324022211.1718762-1-revest@chromium.org>
References: <20210324022211.1718762-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This exercises most of the format specifiers when things go well.

Signed-off-by: Florent Revest <revest@chromium.org>
---
 .../selftests/bpf/prog_tests/snprintf.c       | 65 +++++++++++++++++++
 .../selftests/bpf/progs/test_snprintf.c       | 59 +++++++++++++++++
 2 files changed, 124 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/snprintf.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_snprintf.c

diff --git a/tools/testing/selftests/bpf/prog_tests/snprintf.c b/tools/testing/selftests/bpf/prog_tests/snprintf.c
new file mode 100644
index 000000000000..948a05e6b2cb
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/snprintf.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Google LLC. */
+
+#include <test_progs.h>
+#include "test_snprintf.skel.h"
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
+void test_snprintf(void)
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
+cleanup:
+	test_snprintf__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_snprintf.c b/tools/testing/selftests/bpf/progs/test_snprintf.c
new file mode 100644
index 000000000000..e18709055fad
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_snprintf.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Google LLC. */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_endian.h>
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
+SEC("raw_tp/sys_enter")
+int handler(const void *ctx)
+{
+	/* Convenient values to pretty-print */
+	const __u8 ex_ipv4[] = {127, 0, 0, 1};
+	const __u8 ex_ipv6[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1};
+	const char str1[] = "str1";
+	const char longstr[] = "longstr";
+	extern const void schedule __ksym;
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
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.31.0.291.g576ba9dcdaf-goog

