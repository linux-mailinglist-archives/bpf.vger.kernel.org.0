Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08F3235CA33
	for <lists+bpf@lfdr.de>; Mon, 12 Apr 2021 17:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243181AbhDLPic (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Apr 2021 11:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243117AbhDLPiZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Apr 2021 11:38:25 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AD0C061349
        for <bpf@vger.kernel.org>; Mon, 12 Apr 2021 08:38:06 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id s7so13298398wru.6
        for <bpf@vger.kernel.org>; Mon, 12 Apr 2021 08:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LDBRTVwC0javmeAAY2NKan0r3dVftRGxpYXcgw4nO4U=;
        b=UaYbxJnGfvh6WT53HHOwbp6ArYa8y+T1R6zqrN31jdyLCTt9x1Sv56kFFZrxzbxPTv
         UmVLQTLOCi4DxQUyyxz1D0cmOIL/wH26GSB4yfv+2dFS8cf1dmax0s0s1TdxrUQVDF+F
         j6hp/vGCEv5hf7CVYmGiPZgNrwlUlMV+d097c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LDBRTVwC0javmeAAY2NKan0r3dVftRGxpYXcgw4nO4U=;
        b=PpVTMTp6RXxq8PyjHTJS4cj4sfWA0Nj1f1kERn9ASZWhd8QmA8qDwUc/Zs0af9VwJf
         TGAQ78aoHF2GVF77ZkVRlSGpXP7UlwJnxWDjM5RzEf08M9XqQrF6JJdZbJzGD05S4+Zj
         5/gtBXbryZgoGMmK+8pA7lKBTRK9WB4W+xx326B7kBt/Wke//wLyGhRr7wNZbm8o4Md/
         VGMsk53q2Gn0QvtaO6FoegWI4Mz7katxCXf72pjakmD8Q0lM4BLQP0gBFbPPg9pSiF6g
         sBdTF4kG3jG82O48W0EXR+vxTYcm5RFS5cETtctV4GcOXlDZ/Yf2MZtTpGvSpoDqdNmd
         Fs7g==
X-Gm-Message-State: AOAM530z6Sh4mjtLAVq8Ev0FpYh+zUc93hSp+QEHtvR9lv2A4FF1W4SG
        UyD8MWL924MTAavJScBHlIlCen0Y596hRA==
X-Google-Smtp-Source: ABdhPJwTIwCsHYH0HJsKVTXFy+wZaI/vFRfQCX+wR3smmsgo13dcjGXg4V0UPaoHfo4b+51IqP3vMA==
X-Received: by 2002:adf:eec1:: with SMTP id a1mr26872515wrp.81.1618241884929;
        Mon, 12 Apr 2021 08:38:04 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:a372:3c3b:eeb:ad14])
        by smtp.gmail.com with ESMTPSA id i4sm2501449wrx.56.2021.04.12.08.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 08:38:04 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, jackmanb@chromium.org,
        linux-kernel@vger.kernel.org, Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v3 6/6] selftests/bpf: Add a series of tests for bpf_snprintf
Date:   Mon, 12 Apr 2021 17:37:54 +0200
Message-Id: <20210412153754.235500-7-revest@chromium.org>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
In-Reply-To: <20210412153754.235500-1-revest@chromium.org>
References: <20210412153754.235500-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This exercises most of the format specifiers.

Signed-off-by: Florent Revest <revest@chromium.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/prog_tests/snprintf.c       | 81 +++++++++++++++++++
 .../selftests/bpf/progs/test_snprintf.c       | 74 +++++++++++++++++
 2 files changed, 155 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/snprintf.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_snprintf.c

diff --git a/tools/testing/selftests/bpf/prog_tests/snprintf.c b/tools/testing/selftests/bpf/prog_tests/snprintf.c
new file mode 100644
index 000000000000..3ad1ee885273
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/snprintf.c
@@ -0,0 +1,81 @@
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
+#define EXP_PAD_OUT "    4 000"
+#define EXP_PAD_RET 900007
+
+#define EXP_NO_ARG_OUT "simple case"
+#define EXP_NO_ARG_RET 12
+
+#define EXP_NO_BUF_RET 29
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
diff --git a/tools/testing/selftests/bpf/progs/test_snprintf.c b/tools/testing/selftests/bpf/progs/test_snprintf.c
new file mode 100644
index 000000000000..4c36f355dfca
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_snprintf.c
@@ -0,0 +1,74 @@
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
+	const char str1[] = "str1";
+	const char longstr[] = "longstr";
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
-- 
2.31.1.295.g9ea45b61b8-goog

