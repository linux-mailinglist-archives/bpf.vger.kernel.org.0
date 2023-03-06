Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494466AB68B
	for <lists+bpf@lfdr.de>; Mon,  6 Mar 2023 07:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjCFGtM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Mar 2023 01:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjCFGtJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Mar 2023 01:49:09 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651E51E2B4;
        Sun,  5 Mar 2023 22:49:07 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id a9so9153936plh.11;
        Sun, 05 Mar 2023 22:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678085347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Ybiyh+cemddEvNf1Vk9mMQ97ZbFMZLjU1JZ5sRPJ00=;
        b=d/5xrsEu2UpqF3UAplrTW5HolFkEPhT7NX69LsOgNVw+9Wfjk1uGZx5Y6hf36Z7RIY
         cxplQgdrMsg8nrQpxKXcZQm+PIuVBjaZeriC4ETal0zHBlOJUkV566fNVaq5qJK6vKMU
         4ejUqWi82e58w7hkzVw7R6uAm9DDywwhmkNUz2M6xEpMWiItUoFPE0W852WOf9AeElwa
         7QUk+/65PdLrfFcqSEcsudecZEUPCF56p4Xzj5mBzyhCnc8r5rS1N3c5g7WEJUk+Tokb
         yPgWrxS9dy3opxsXaG8TtwYcoUJNFULiE08b/LeQfvyS+0vFqeA7ayVuHLdf2iZuFbnI
         3geA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678085347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Ybiyh+cemddEvNf1Vk9mMQ97ZbFMZLjU1JZ5sRPJ00=;
        b=RRPRuzTxLpiwQRBWldNw2SNQxRonRCWG2wzZlsFTumbL1U3Nb+5Xmp9s1vRJt5i+VW
         /aGgPuXendS2XQtNk6S5UwJqyhSX2+7No1F03Ckb6AnaBVwejABLokLRTOZ/LaawxccU
         ULBZXF+Tj7HhqfGZnUJZMBVocLeCk6kaZOdLcjgTaUkdLsYh0vppvQV7VuOQp9ilrehd
         OqC2Whb2XOosSnIR7YU8HfE8kNybR/p6FZX4ZkFJXK/z4yfA4XbtGtX7DWRPASUVS0f+
         LOZdFLvjqZ98rKCI3gkRRT56mkXU1D+V9U3V5IDtm3kn289HeO1WbnLMK06jLYuuTqOr
         RPVw==
X-Gm-Message-State: AO0yUKXpJNFf6uBD8DhIQk01ix6WjwXG6XkjP8MJ/zI/oISSjHShwNmu
        R9PMhF4TG9tXYDFIrvxwOUo=
X-Google-Smtp-Source: AK7set8fbwbwmMTMRAFgcI2R5NVGVHsbOjYjsRGoLBKGB5E87sXGAChjh4cKHsPdOs+SoyTxwWfAoQ==
X-Received: by 2002:a05:6a20:394b:b0:b8:c6ec:a269 with SMTP id r11-20020a056a20394b00b000b8c6eca269mr11757778pzg.16.1678085346869;
        Sun, 05 Mar 2023 22:49:06 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.82])
        by smtp.gmail.com with ESMTPSA id g9-20020aa78189000000b0061a942c8b62sm2378184pfi.43.2023.03.05.22.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 22:49:06 -0800 (PST)
From:   menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To:     andrii.nakryiko@gmail.com, alan.maguire@oracle.com
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, benbjiang@tencent.com,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Menglong Dong <imagedong@tencent.com>
Subject: [PATCH bpf-next v4 3/3] selftests/bpf: add test for legacy/perf kprobe/uprobe attach mode
Date:   Mon,  6 Mar 2023 14:48:33 +0800
Message-Id: <20230306064833.7932-4-imagedong@tencent.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230306064833.7932-1-imagedong@tencent.com>
References: <20230306064833.7932-1-imagedong@tencent.com>
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
---
v4:
- use test_attach_probe_manual__open_and_load() directly
---
 .../selftests/bpf/prog_tests/attach_probe.c   | 37 +++++++++----
 .../selftests/bpf/progs/test_attach_probe.c   | 32 -----------
 .../bpf/progs/test_attach_probe_manual.c      | 53 +++++++++++++++++++
 3 files changed, 81 insertions(+), 41 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_attach_probe_manual.c

diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
index c374759f39ce..7175af39134f 100644
--- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
+++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
 #include "test_attach_kprobe_sleepable.skel.h"
+#include "test_attach_probe_manual.skel.h"
 #include "test_attach_probe.skel.h"
 
 /* this is how USDT semaphore is actually defined, except volatile modifier */
@@ -33,33 +34,43 @@ static noinline void trigger_func4(void)
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
 
+	skel = test_attach_probe_manual__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_kprobe_manual_open_and_load"))
+		return;
+
 	uprobe_offset = get_uprobe_offset(&trigger_func);
 	if (!ASSERT_GE(uprobe_offset, 0, "uprobe_offset"))
 		goto cleanup;
 
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
 		goto cleanup;
 	skel->links.handle_kprobe = kprobe_link;
 
-	kretprobe_link = bpf_program__attach_kprobe(skel->progs.handle_kretprobe,
-						    true /* retprobe */,
-						    SYS_NANOSLEEP_KPROBE_NAME);
+	kprobe_opts.retprobe = true;
+	kretprobe_link = bpf_program__attach_kprobe_opts(skel->progs.handle_kretprobe,
+							 SYS_NANOSLEEP_KPROBE_NAME,
+							 &kprobe_opts);
 	if (!ASSERT_OK_PTR(kretprobe_link, "attach_kretprobe"))
 		goto cleanup;
 	skel->links.handle_kretprobe = kretprobe_link;
 
 	/* manual-attach uprobe/uretprobe */
+	uprobe_opts.attach_mode = attach_mode;
 	uprobe_opts.ref_ctr_offset = 0;
 	uprobe_opts.retprobe = false;
 	uprobe_link = bpf_program__attach_uprobe_opts(skel->progs.handle_uprobe,
@@ -108,6 +119,7 @@ static void test_attach_probe_manual(struct test_attach_probe *skel)
 	ASSERT_EQ(skel->bss->uprobe_byname_res, 5, "check_uprobe_byname_res");
 
 cleanup:
+	test_attach_probe_manual__destroy(skel);
 }
 
 static void test_attach_probe_auto(struct test_attach_probe *skel)
@@ -289,8 +301,15 @@ void test_attach_probe(void)
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

