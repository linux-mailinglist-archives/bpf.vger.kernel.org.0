Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 567E8334AE1
	for <lists+bpf@lfdr.de>; Wed, 10 Mar 2021 23:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234212AbhCJWDP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Mar 2021 17:03:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234271AbhCJWCr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Mar 2021 17:02:47 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9F2C0613DA
        for <bpf@vger.kernel.org>; Wed, 10 Mar 2021 14:02:32 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id l11so21661533wrp.7
        for <bpf@vger.kernel.org>; Wed, 10 Mar 2021 14:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kvULu6wQqvVvCSIiS2jIB0soaoJgdRgxlx9E1MVIok4=;
        b=kG+dofg6FiOzD4Z7qcCs1lAynZh6scqcZVq1/t9JhKvXAUtP2itqsrkWoCVzq2ZCKK
         4qb2mmx1Fc6cmP25PLk1GBcGwELkPwTSWcVQeoXtbVEQcuRIez9BF61z1ohpeDocFJK9
         NQMFEiS07rRtFx96nvFwXDnXe8n64k5UzQej0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kvULu6wQqvVvCSIiS2jIB0soaoJgdRgxlx9E1MVIok4=;
        b=S/zHX1/QewXnUsm55UQiU21ZND77SOvRCcMMpelB1fbmDII5iwZw29ftM3bQALpXpz
         rYgYnvQ2KmdUVjNjldLO0qwj7I1JC0ZjGmvStHCVhWGHG+MICy98P+qf2K+dsvLteEDh
         XK26DKmjb2dA2+fz9/j5MNtw1gOzklqY796khtOvqL1d2ILkfH/3+Rl7YedXLKfyJ3XG
         ya1W3JAymCcbKm758I1aMi/+VVpsRyPUcC0+pehFGPrkf3rqDAb4Ir36bYS7grxuM4cX
         Ix7O/KgLqddd5ASp4V1+rTdTqpYSh39mAYQu7uYWW9JhEgpaj3525D2fcxtZQFeK8ChO
         /14Q==
X-Gm-Message-State: AOAM5307yghzuNhOBGC2Y0nqhYTv8G/cWkNY7mRf2WVBfnCErMTYujgv
        RyweMjfW+tqacluj5hbQn3VN0INRUlSMLQ==
X-Google-Smtp-Source: ABdhPJyeu1V5+w5viGBt4njm65B0BKluUNYql60eGXK3hOj1b/IsJgt4+NSAuEW9eY7K/wKFa7hNog==
X-Received: by 2002:adf:e441:: with SMTP id t1mr5507996wrm.21.1615413751375;
        Wed, 10 Mar 2021 14:02:31 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:e08c:1e90:4e6b:365a])
        by smtp.gmail.com with ESMTPSA id y16sm699234wrh.3.2021.03.10.14.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 14:02:31 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, jackmanb@chromium.org,
        linux-kernel@vger.kernel.org, Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next 5/5] selftests/bpf: Add a series of tests for bpf_snprintf
Date:   Wed, 10 Mar 2021 23:02:11 +0100
Message-Id: <20210310220211.1454516-6-revest@chromium.org>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
In-Reply-To: <20210310220211.1454516-1-revest@chromium.org>
References: <20210310220211.1454516-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This exercices most of the format specifiers when things go well.

Signed-off-by: Florent Revest <revest@chromium.org>
---
 .../selftests/bpf/prog_tests/snprintf.c       | 71 +++++++++++++++++++
 .../selftests/bpf/progs/test_snprintf.c       | 71 +++++++++++++++++++
 2 files changed, 142 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/snprintf.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_snprintf.c

diff --git a/tools/testing/selftests/bpf/prog_tests/snprintf.c b/tools/testing/selftests/bpf/prog_tests/snprintf.c
new file mode 100644
index 000000000000..23af1dbd1eeb
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/snprintf.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Google LLC. */
+
+#include <test_progs.h>
+#include "test_snprintf.skel.h"
+
+static int duration;
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
+#define EXP_OVER_OUT {'%', 'o', 'v', 'e', 'r'}
+#define EXP_OVER_RET 10
+
+void test_snprintf(void)
+{
+	char exp_addr_out[] = EXP_ADDR_OUT;
+	char exp_over_out[] = EXP_OVER_OUT;
+	char exp_sym_out[]  = EXP_SYM_OUT;
+	struct test_snprintf *skel;
+	int err;
+
+	skel = test_snprintf__open_and_load();
+	if (CHECK(!skel, "skel_open", "failed to open and load skeleton\n"))
+		return;
+
+	err = test_snprintf__attach(skel);
+	if (CHECK(err, "skel_attach", "skeleton attach failed: %d\n", err))
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
+	ASSERT_OK(memcmp(skel->bss->over_out, exp_over_out,
+			 sizeof(exp_over_out)), "over_out");
+	ASSERT_EQ(skel->bss->over_ret, EXP_OVER_RET, "over_ret");
+
+cleanup:
+	test_snprintf__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_snprintf.c b/tools/testing/selftests/bpf/progs/test_snprintf.c
new file mode 100644
index 000000000000..6c8aa4988e69
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_snprintf.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Google LLC. */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_endian.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#define OUT_LEN 64
+
+/* Integer types */
+static const char num_fmt[] = "%d %u %x %li %llu %lX";
+#define NUMBERS -8, 9, 150, -424242, 1337, 0xDABBAD00
+
+char num_out[OUT_LEN] = {};
+long num_ret = 0;
+
+/* IP addresses */
+static const char ip_fmt[] = "%pi4 %pI6";
+static const __u8 dummy_ipv4[] = {127, 0, 0, 1}; /* 127.0.0.1 */
+static const __u32 dummy_ipv6[] = {0, 0, 0, bpf_htonl(1)}; /* ::1/128 */
+#define IPS &dummy_ipv4, &dummy_ipv6
+
+char ip_out[OUT_LEN] = {};
+long ip_ret = 0;
+
+/* Symbol lookup formatting */
+static const char sym_fmt[] = "%ps %pS %pB";
+extern const void schedule __ksym;
+#define SYMBOLS &schedule, &schedule, &schedule
+
+char sym_out[OUT_LEN] = {};
+long sym_ret = 0;
+
+/* Kernel pointers */
+static const char addr_fmt[] = "%pK %px %p";
+#define ADDRESSES 0, 0xFFFF00000ADD4E55, 0xFFFF00000ADD4E55
+
+char addr_out[OUT_LEN] = {};
+long addr_ret = 0;
+
+/* Strings embedding */
+static const char str_fmt[] = "%s %+05s";
+static const char str1[] = "str1";
+static const char longstr[] = "longstr";
+#define STRINGS str1, longstr
+
+char str_out[OUT_LEN] = {};
+long str_ret = 0;
+
+/* Overflow */
+static const char over_fmt[] = "%%overflow";
+
+#define OVER_OUT_LEN 6
+char over_out[OVER_OUT_LEN] = {};
+long over_ret = 0;
+
+SEC("raw_tp/sys_enter")
+int handler(const void *ctx)
+{
+	num_ret  = BPF_SNPRINTF(num_out,  OUT_LEN, num_fmt,  NUMBERS);
+	ip_ret   = BPF_SNPRINTF(ip_out,   OUT_LEN, ip_fmt,   IPS);
+	sym_ret  = BPF_SNPRINTF(sym_out,  OUT_LEN, sym_fmt,  SYMBOLS);
+	addr_ret = BPF_SNPRINTF(addr_out, OUT_LEN, addr_fmt, ADDRESSES);
+	str_ret  = BPF_SNPRINTF(str_out,  OUT_LEN, str_fmt,  STRINGS);
+	over_ret = BPF_SNPRINTF(over_out, OVER_OUT_LEN, over_fmt);
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.30.1.766.gb4fecdf3b7-goog

