Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42989449F90
	for <lists+bpf@lfdr.de>; Tue,  9 Nov 2021 01:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241228AbhKIAeC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Nov 2021 19:34:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234045AbhKIAeC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Nov 2021 19:34:02 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0E7C061570
        for <bpf@vger.kernel.org>; Mon,  8 Nov 2021 16:31:17 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id r11-20020a170902be0b00b0013f4f30d71cso7412135pls.21
        for <bpf@vger.kernel.org>; Mon, 08 Nov 2021 16:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cpQzAa3EBOvVvuHvvTdB14x957PA1348N8TM5uerBGM=;
        b=ta9+n+de+AMLdMBwzc5GfH3Yg1sVQ3atTdWVBIEFwhRz6tz+x1RYckdcxtpRhjDLaV
         8wccn+h0TRhq+LIkmq5/Cm2JwwA7jBatFdzbSREriTTYy6kiMycHyuHsjiclS4mv2KeR
         7rk4x3IDEiR1yBnQLlpKOuv/8zZNv6dxiT92FpeaAUlu6LPeHYS1oa5hWSGb4gNAP8Iz
         8xNOz9DlTEtlia6kxlNqN1NIL8Ltlu37/lZx5PHDs5zogKR7JkSLZreAYJDqUYUHEhXt
         0pPWGpMFbixBiqvIb6DsEzjASGTFb7m47jyr9M/bSceGi8hcxWPAoET0aWonZe9SXl8L
         TS4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cpQzAa3EBOvVvuHvvTdB14x957PA1348N8TM5uerBGM=;
        b=Kzz4oorwHRnKwYgEiKt86h+9DINdyePW2L9A8G9OsLCBASexAFab9eH2PvQos6CGWM
         XjjZCUV2QNP79MYt+xzV6E+XKXuoVLfasKmXRJhHMEJTITe0LitqdSodvXxGaakm09oX
         OGnrgkNmuzll4YU0OK4TUCy1iFWoJ0aEwy/+CX4mByz3XFNfuxqbSYnXtX+wGQVdsKiM
         t7E+DGchYR7NS9ETvWCZlF0orkDJNvOVpcDuRRpyQhDzVt+f2AhjcrNMRd2m7zfNazD5
         AFh21/tW8BbHXXaVUIUvfisIR/ucx01iwrvzAx6KFacGLR2Pb+wOLWpAVo/LlzjsAiJz
         b/QQ==
X-Gm-Message-State: AOAM532k7TxW4pdlEuR8PogczqMmI070Bhlg5MTr7VYLoeiGrHYgIVpA
        s2G3Gyr0/R3LbT1OPaMTNMYMwDe8+Mw=
X-Google-Smtp-Source: ABdhPJzSLtAdRu1IgVtcGYMhtCP9dDVHWOzQ1y5SXZa8KMi26VOsF9PZFyuMfOWzQmrbSwvGLHTMSFG4ybY=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:4c6:4bbe:e4c5:ff76])
 (user=haoluo job=sendgmr) by 2002:a17:90a:17a5:: with SMTP id
 q34mr2621049pja.122.1636417876712; Mon, 08 Nov 2021 16:31:16 -0800 (PST)
Date:   Mon,  8 Nov 2021 16:30:52 -0800
In-Reply-To: <20211109003052.3499225-1-haoluo@google.com>
Message-Id: <20211109003052.3499225-4-haoluo@google.com>
Mime-Version: 1.0
References: <20211109003052.3499225-1-haoluo@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH v3 bpf-next 3/3] bpf/selftests: Test PTR_TO_RDONLY_MEM
From:   Hao Luo <haoluo@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This test verifies that a ksym of non-struct can not be directly
updated.

Signed-off-by: Hao Luo <haoluo@google.com>
---
 Changes since v2:
  - Rebase

 Changes since v1:
  - Replaced CHECK() with ASSERT_ERR_PTR()
  - Commented in the test for the reason of verification failure.

 .../selftests/bpf/prog_tests/ksyms_btf.c      | 14 +++++++++
 .../bpf/progs/test_ksyms_btf_write_check.c    | 29 +++++++++++++++++++
 2 files changed, 43 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/test_ksyms_btf_write_check.c

diff --git a/tools/testing/selftests/bpf/prog_tests/ksyms_btf.c b/tools/testing/selftests/bpf/prog_tests/ksyms_btf.c
index 79f6bd1e50d6..f6933b06daf8 100644
--- a/tools/testing/selftests/bpf/prog_tests/ksyms_btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/ksyms_btf.c
@@ -8,6 +8,7 @@
 #include "test_ksyms_btf_null_check.skel.h"
 #include "test_ksyms_weak.skel.h"
 #include "test_ksyms_weak.lskel.h"
+#include "test_ksyms_btf_write_check.skel.h"
 
 static int duration;
 
@@ -137,6 +138,16 @@ static void test_weak_syms_lskel(void)
 	test_ksyms_weak_lskel__destroy(skel);
 }
 
+static void test_write_check(void)
+{
+	struct test_ksyms_btf_write_check *skel;
+
+	skel = test_ksyms_btf_write_check__open_and_load();
+	ASSERT_ERR_PTR(skel, "unexpected load of a prog writing to ksym memory\n");
+
+	test_ksyms_btf_write_check__destroy(skel);
+}
+
 void test_ksyms_btf(void)
 {
 	int percpu_datasec;
@@ -167,4 +178,7 @@ void test_ksyms_btf(void)
 
 	if (test__start_subtest("weak_ksyms_lskel"))
 		test_weak_syms_lskel();
+
+	if (test__start_subtest("write_check"))
+		test_write_check();
 }
diff --git a/tools/testing/selftests/bpf/progs/test_ksyms_btf_write_check.c b/tools/testing/selftests/bpf/progs/test_ksyms_btf_write_check.c
new file mode 100644
index 000000000000..2180c41cd890
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_ksyms_btf_write_check.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Google */
+
+#include "vmlinux.h"
+
+#include <bpf/bpf_helpers.h>
+
+extern const int bpf_prog_active __ksym; /* int type global var. */
+
+SEC("raw_tp/sys_enter")
+int handler(const void *ctx)
+{
+	int *active;
+	__u32 cpu;
+
+	cpu = bpf_get_smp_processor_id();
+	active = (int *)bpf_per_cpu_ptr(&bpf_prog_active, cpu);
+	if (active) {
+		/* Kernel memory obtained from bpf_{per,this}_cpu_ptr
+		 * is read-only, should _not_ pass verification.
+		 */
+		/* WRITE_ONCE */
+		*(volatile int *)active = -1;
+	}
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.34.0.rc0.344.g81b53c2807-goog

