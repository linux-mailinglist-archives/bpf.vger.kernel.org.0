Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0547F69D909
	for <lists+bpf@lfdr.de>; Tue, 21 Feb 2023 03:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbjBUCzU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Feb 2023 21:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233470AbjBUCzD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Feb 2023 21:55:03 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474991B300;
        Mon, 20 Feb 2023 18:54:40 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id i1-20020a17090ad34100b00234463de251so3201579pjx.3;
        Mon, 20 Feb 2023 18:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HvPIsy8SH2IRGr58SOz+sqiEbtzVAf9Sko8zRYehlzM=;
        b=mcLlsHX5xxUVohAatV9QdZqvGMtW+ohpid0E6f4heBJsryqeZ70Y+3rjUrL1PzjU4I
         Qdlo5tLKC6ekvXOnuMDgTXpKL7yqlRGoKtFIPluD9/FVx0o+lH20DNomQuu9wJx/SotV
         RzQP03W7wIJQxpFskcOKSJ4NCSuz4d5hjTd3WookuqxHoI6hKvcDgLX9PMCx9Cpj/ptb
         T5v3qPoyac5XaCtqG5bhwXkJ7cL/htf7uxI2tuwOC2ZXnSba8AbwXn8nDyE05TQoW2uy
         IPt/K/cRyKYzyWA4+PgIKDU0GoTwiiCx0AMYh5jUpYmdUMp4YkUpJ8e+II1SM8/nwHa2
         ouug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HvPIsy8SH2IRGr58SOz+sqiEbtzVAf9Sko8zRYehlzM=;
        b=uxr8yTjjNRCnijGAztb+XGuUGuOpGRLsVPyOq69NAbFPqLTj2uY3bsmWSpz7wEdpfy
         vMbRIbwPtQrCzXfvkKFJCnHlvvCKCjCDtq/OiSqilmJ6Dv/Nkgkyp4tz8C1eSuQxzND3
         A32clBxJkc+m3re0+Qxc1Zq3/LwJI795hEdXhrRCJAigE+qdLNhHX8KYvCsprCJvhzQ9
         qr6CjO7D3eIIMcFFdRjuKTnE8+AB8RRvFSVsRzmOO4+EhMzdy/sA3fW/9SAs13RhVzmG
         7M27w8il+crj+5fOwcRVxQ4aIfgSKERQM6lk6sZ1rD9AyYdYesvmnVyAJKjIYT6li4uQ
         /E+A==
X-Gm-Message-State: AO0yUKXioXmO1s2wtSX1RsmmI5LSRzV19oec0Vk7MVNoDS6I2IzxMRWK
        KRhiolGPd4HCLKYgwINkT456629WcNHATXhZ
X-Google-Smtp-Source: AK7set9cEvB8W+yti+i3PfCxh6gv1aCVw2iOFtZYdT3SUoQppnpG9pJAo1sIawwe4M+teMk2QDR20g==
X-Received: by 2002:a17:903:687:b0:196:5f76:1e51 with SMTP id ki7-20020a170903068700b001965f761e51mr4333897plb.64.1676948079671;
        Mon, 20 Feb 2023 18:54:39 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.16])
        by smtp.gmail.com with ESMTPSA id k3-20020a170902e90300b0019a837be977sm8590156pld.271.2023.02.20.18.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 18:54:39 -0800 (PST)
From:   menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To:     andrii.nakryiko@gmail.com, alan.maguire@oracle.com
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, benbjiang@tencent.com,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Menglong Dong <imagedong@tencent.com>
Subject: [PATCH bpf-next v3 3/3] selftests/bpf: add test for legacy/perf kprobe/uprobe attach mode
Date:   Tue, 21 Feb 2023 10:53:47 +0800
Message-Id: <20230221025347.389047-4-imagedong@tencent.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230221025347.389047-1-imagedong@tencent.com>
References: <20230221025347.389047-1-imagedong@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Menglong Dong <imagedong@tencent.com>

Add the testing for kprobe/uprobe attaching in default, legacy, perf and
link mode. And the testing passed:

./test_progs -t attach_probe
$5/1     attach_probe/manual-default:OK
$5/2     attach_probe/manual-legacy:OK
$5/3     attach_probe/manual-perf:OK
$5/4     attach_probe/manual-link:OK
$5/5     attach_probe/auto:OK
$5/6     attach_probe/kprobe-sleepable:OK
$5/7     attach_probe/uprobe-lib:OK
$5/8     attach_probe/uprobe-sleepable:OK
$5/9     attach_probe/uprobe-ref_ctr:OK
$5       attach_probe:OK
Summary: 1/9 PASSED, 0 SKIPPED, 0 FAILED

Reviewed-by: Biao Jiang <benbjiang@tencent.com>
Signed-off-by: Menglong Dong <imagedong@tencent.com>
Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
---
 .../selftests/bpf/prog_tests/attach_probe.c   | 54 ++++++++++++++-----
 .../selftests/bpf/progs/test_attach_probe.c   | 32 -----------
 .../bpf/progs/test_attach_probe_manual.c      | 53 ++++++++++++++++++
 3 files changed, 93 insertions(+), 46 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_attach_probe_manual.c

diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
index 8afd3e6066b8..e71cb44bf2e7 100644
--- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
+++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
 #include "test_attach_kprobe_sleepable.skel.h"
+#include "test_attach_probe_manual.skel.h"
 #include "test_attach_probe.skel.h"
 
 /* this is how USDT semaphore is actually defined, except volatile modifier */
@@ -33,33 +34,48 @@ static noinline void trigger_func4(void)
 static char test_data[] = "test_data";
 
 /* manual attach kprobe/kretprobe/uprobe/uretprobe testings */
-static void test_attach_probe_manual(struct test_attach_probe *skel)
+static void test_attach_probe_manual(enum probe_attach_mode attach_mode)
 {
 	DECLARE_LIBBPF_OPTS(bpf_uprobe_opts, uprobe_opts);
+	DECLARE_LIBBPF_OPTS(bpf_kprobe_opts, kprobe_opts);
 	struct bpf_link *kprobe_link, *kretprobe_link;
 	struct bpf_link *uprobe_link, *uretprobe_link;
+	struct test_attach_probe_manual *skel;
 	ssize_t uprobe_offset;
 
+	skel = test_attach_probe_manual__open();
+	if (!ASSERT_OK_PTR(skel, "skel_kprobe_manual_open"))
+		return;
+
+	if (!ASSERT_OK(test_attach_probe_manual__load(skel), "skel_manual_load"))
+		goto cleanup;
+	if (!ASSERT_OK_PTR(skel->bss, "manual_check_bss"))
+		goto cleanup;
+
 	uprobe_offset = get_uprobe_offset(&trigger_func);
 	if (!ASSERT_GE(uprobe_offset, 0, "uprobe_offset"))
-		return;
+		goto cleanup;
 
 	/* manual-attach kprobe/kretprobe */
-	kprobe_link = bpf_program__attach_kprobe(skel->progs.handle_kprobe,
-						 false /* retprobe */,
-						 SYS_NANOSLEEP_KPROBE_NAME);
+	kprobe_opts.attach_mode = attach_mode;
+	kprobe_opts.retprobe = false;
+	kprobe_link = bpf_program__attach_kprobe_opts(skel->progs.handle_kprobe,
+						      SYS_NANOSLEEP_KPROBE_NAME,
+						      &kprobe_opts);
 	if (!ASSERT_OK_PTR(kprobe_link, "attach_kprobe"))
-		return;
+		goto cleanup;
 	skel->links.handle_kprobe = kprobe_link;
 
-	kretprobe_link = bpf_program__attach_kprobe(skel->progs.handle_kretprobe,
-						    true /* retprobe */,
-						    SYS_NANOSLEEP_KPROBE_NAME);
+	kprobe_opts.retprobe = true;
+	kretprobe_link = bpf_program__attach_kprobe_opts(skel->progs.handle_kretprobe,
+							 SYS_NANOSLEEP_KPROBE_NAME,
+							 &kprobe_opts);
 	if (!ASSERT_OK_PTR(kretprobe_link, "attach_kretprobe"))
-		return;
+		goto cleanup;
 	skel->links.handle_kretprobe = kretprobe_link;
 
 	/* manual-attach uprobe/uretprobe */
+	uprobe_opts.attach_mode = attach_mode;
 	uprobe_opts.ref_ctr_offset = 0;
 	uprobe_opts.retprobe = false;
 	uprobe_link = bpf_program__attach_uprobe_opts(skel->progs.handle_uprobe,
@@ -68,7 +84,7 @@ static void test_attach_probe_manual(struct test_attach_probe *skel)
 						      uprobe_offset,
 						      &uprobe_opts);
 	if (!ASSERT_OK_PTR(uprobe_link, "attach_uprobe"))
-		return;
+		goto cleanup;
 	skel->links.handle_uprobe = uprobe_link;
 
 	uprobe_opts.retprobe = true;
@@ -77,7 +93,7 @@ static void test_attach_probe_manual(struct test_attach_probe *skel)
 							 "/proc/self/exe",
 							 uprobe_offset, &uprobe_opts);
 	if (!ASSERT_OK_PTR(uretprobe_link, "attach_uretprobe"))
-		return;
+		goto cleanup;
 	skel->links.handle_uretprobe = uretprobe_link;
 
 	/* attach uprobe by function name manually */
@@ -106,6 +122,9 @@ static void test_attach_probe_manual(struct test_attach_probe *skel)
 	ASSERT_EQ(skel->bss->uprobe_res, 3, "check_uprobe_res");
 	ASSERT_EQ(skel->bss->uretprobe_res, 4, "check_uretprobe_res");
 	ASSERT_EQ(skel->bss->uprobe_byname_res, 5, "check_uprobe_byname_res");
+
+cleanup:
+	test_attach_probe_manual__destroy(skel);
 }
 
 static void test_attach_probe_auto(struct test_attach_probe *skel)
@@ -287,8 +306,15 @@ void test_attach_probe(void)
 	if (!ASSERT_OK_PTR(skel->bss, "check_bss"))
 		goto cleanup;
 
-	if (test__start_subtest("manual"))
-		test_attach_probe_manual(skel);
+	if (test__start_subtest("manual-default"))
+		test_attach_probe_manual(PROBE_ATTACH_MODE_DEFAULT);
+	if (test__start_subtest("manual-legacy"))
+		test_attach_probe_manual(PROBE_ATTACH_MODE_LEGACY);
+	if (test__start_subtest("manual-perf"))
+		test_attach_probe_manual(PROBE_ATTACH_MODE_PERF);
+	if (test__start_subtest("manual-link"))
+		test_attach_probe_manual(PROBE_ATTACH_MODE_LINK);
+
 	if (test__start_subtest("auto"))
 		test_attach_probe_auto(skel);
 	if (test__start_subtest("kprobe-sleepable"))
diff --git a/tools/testing/selftests/bpf/progs/test_attach_probe.c b/tools/testing/selftests/bpf/progs/test_attach_probe.c
index 9e1e7163bb67..68466a6ad18c 100644
--- a/tools/testing/selftests/bpf/progs/test_attach_probe.c
+++ b/tools/testing/selftests/bpf/progs/test_attach_probe.c
@@ -7,12 +7,8 @@
 #include <bpf/bpf_core_read.h>
 #include "bpf_misc.h"
 
-int kprobe_res = 0;
 int kprobe2_res = 0;
-int kretprobe_res = 0;
 int kretprobe2_res = 0;
-int uprobe_res = 0;
-int uretprobe_res = 0;
 int uprobe_byname_res = 0;
 int uretprobe_byname_res = 0;
 int uprobe_byname2_res = 0;
@@ -23,13 +19,6 @@ int uretprobe_byname3_sleepable_res = 0;
 int uretprobe_byname3_res = 0;
 void *user_ptr = 0;
 
-SEC("kprobe")
-int handle_kprobe(struct pt_regs *ctx)
-{
-	kprobe_res = 1;
-	return 0;
-}
-
 SEC("ksyscall/nanosleep")
 int BPF_KSYSCALL(handle_kprobe_auto, struct __kernel_timespec *req, struct __kernel_timespec *rem)
 {
@@ -37,13 +26,6 @@ int BPF_KSYSCALL(handle_kprobe_auto, struct __kernel_timespec *req, struct __ker
 	return 0;
 }
 
-SEC("kretprobe")
-int handle_kretprobe(struct pt_regs *ctx)
-{
-	kretprobe_res = 2;
-	return 0;
-}
-
 SEC("kretsyscall/nanosleep")
 int BPF_KRETPROBE(handle_kretprobe_auto, int ret)
 {
@@ -51,20 +33,6 @@ int BPF_KRETPROBE(handle_kretprobe_auto, int ret)
 	return ret;
 }
 
-SEC("uprobe")
-int handle_uprobe(struct pt_regs *ctx)
-{
-	uprobe_res = 3;
-	return 0;
-}
-
-SEC("uretprobe")
-int handle_uretprobe(struct pt_regs *ctx)
-{
-	uretprobe_res = 4;
-	return 0;
-}
-
 SEC("uprobe")
 int handle_uprobe_ref_ctr(struct pt_regs *ctx)
 {
diff --git a/tools/testing/selftests/bpf/progs/test_attach_probe_manual.c b/tools/testing/selftests/bpf/progs/test_attach_probe_manual.c
new file mode 100644
index 000000000000..7f08bce94596
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_attach_probe_manual.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2017 Facebook
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+#include "bpf_misc.h"
+
+int kprobe_res = 0;
+int kretprobe_res = 0;
+int uprobe_res = 0;
+int uretprobe_res = 0;
+int uprobe_byname_res = 0;
+void *user_ptr = 0;
+
+SEC("kprobe")
+int handle_kprobe(struct pt_regs *ctx)
+{
+	kprobe_res = 1;
+	return 0;
+}
+
+SEC("kretprobe")
+int handle_kretprobe(struct pt_regs *ctx)
+{
+	kretprobe_res = 2;
+	return 0;
+}
+
+SEC("uprobe")
+int handle_uprobe(struct pt_regs *ctx)
+{
+	uprobe_res = 3;
+	return 0;
+}
+
+SEC("uretprobe")
+int handle_uretprobe(struct pt_regs *ctx)
+{
+	uretprobe_res = 4;
+	return 0;
+}
+
+SEC("uprobe")
+int handle_uprobe_byname(struct pt_regs *ctx)
+{
+	uprobe_byname_res = 5;
+	return 0;
+}
+
+
+char _license[] SEC("license") = "GPL";
-- 
2.39.0

