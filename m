Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260EC69C6F7
	for <lists+bpf@lfdr.de>; Mon, 20 Feb 2023 09:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbjBTIss (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Feb 2023 03:48:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbjBTIse (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Feb 2023 03:48:34 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D7793C2;
        Mon, 20 Feb 2023 00:48:32 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id i2so1128747pfd.1;
        Mon, 20 Feb 2023 00:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b+T2G7reDC26uTZgdg5DCDApdgKXuM9a5ZosVtFxu0Q=;
        b=OZshz1W88On1qIGpmHVcCrRVKwonlCAuSQ6xKW3VkXbzBkqlzuHK0oWvhSvlyzGsrn
         A5Suarpzvv8GLQ71A0zukvyf6cuMXbMc+GzjlEzyYsR8e19/uGztTJKEppLZSfOofRyf
         D9I5PPzQDAbu64t336IzFb6dH4gplryKDJxsAc64MhAtGtd15fbcM1CMayF0qHJLxI4h
         Rmf2AJZWuGj1cJZ7oQte6cF11hxJQk/VqlPxeQ37Z9sVcRP/06qAqT52+0vhwpo7ACk4
         R4UoJVOhfmfI9I+VDUjfy/SxAHPeZTcg0yuCrOkRiD3WJ4zSaBnlt7gVqJizN9weqvZ+
         abFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b+T2G7reDC26uTZgdg5DCDApdgKXuM9a5ZosVtFxu0Q=;
        b=Bl8SHU9G08PZsbLEYuq42M5dsnGXba63h4ceBfV3j+QXcMKu1d0A6ExhI6r3IX+t/D
         SgOZ3flDa7HFmhEsb6bZYHpbtCVumse9vrUG5XFcpTj3Ve47zeXoNDEoQDvlHbKqmxG3
         xVUAKfAqNW2P9b+qqnB0L56pjzpKyDZPGnkWlRmhoz1wv3afDRYLASdTWDysjjOtmJ4H
         CjlTaNtP16B+K30CvxOqzRxqXIiUUOu8zOP3PBjrOoxwbfgg0gONcFtlhiJbhKD1E2NR
         oIibWb9KfwaGllrY1IhSY+xmL1VPCnHlMt8ybvHUsrK/wyVuiol20+v88IZW0NKg2SX+
         I8zQ==
X-Gm-Message-State: AO0yUKVzMbssxHGLcwnNuL76rgVtnbxUldI4FnYNVARgVj7fLIUAOaRQ
        trXGHgUKNdTulcjjNUCu8rxwLTrZVhvZtOC7
X-Google-Smtp-Source: AK7set+558Uuxb1f0Ue2Iy01harcn4d5Fl90XiRAJlN9uvzIxbtkB6qmLrOvz8wmvz25BqSw3yjdrA==
X-Received: by 2002:a62:1912:0:b0:5a8:d97d:59d7 with SMTP id 18-20020a621912000000b005a8d97d59d7mr1032903pfz.28.1676882911859;
        Mon, 20 Feb 2023 00:48:31 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.21])
        by smtp.gmail.com with ESMTPSA id n11-20020a62e50b000000b00586fbbdf6e4sm7136378pff.34.2023.02.20.00.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 00:48:31 -0800 (PST)
From:   menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To:     andrii.nakryiko@gmail.com, alan.maguire@oracle.com
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
Subject: [PATCH bpf-next v2 2/3] selftests/bpf: split test_attach_probe into multi subtests
Date:   Mon, 20 Feb 2023 16:47:10 +0800
Message-Id: <20230220084711.261642-3-imagedong@tencent.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230220084711.261642-1-imagedong@tencent.com>
References: <20230220084711.261642-1-imagedong@tencent.com>
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

In order to adapt to the older kernel, now we split the "attach_probe"
testing into multi subtests:

  manual // manual attach tests for kprobe/uprobe
  auto // auto-attach tests for kprobe and uprobe
  kprobe-sleepable // kprobe sleepable test
  uprobe-lib // uprobe tests for library function by name
  uprobe-sleepabel // uprobe sleepable test
  uprobe-ref_ctr // uprobe ref_ctr test

As sleepable kprobe needs to set BPF_F_SLEEPABLE flag before loading,
we need to move it to a stand alone skel file, in case of it is not
supported by kernel and make the whole loading fail.

Therefore, we can only enable part of the subtests for older kernel.

Signed-off-by: Menglong Dong <imagedong@tencent.com>
---
 .../selftests/bpf/prog_tests/attach_probe.c   | 268 +++++++++++-------
 .../bpf/progs/test_attach_kprobe_sleepable.c  |  23 ++
 .../selftests/bpf/progs/test_attach_probe.c   |  23 +-
 3 files changed, 208 insertions(+), 106 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_attach_kprobe_sleepable.c

diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
index 56374c8b5436..9824a5eb8595 100644
--- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
+++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
+#include "test_attach_kprobe_sleepable.skel.h"
 #include "test_attach_probe.skel.h"
 
 /* this is how USDT semaphore is actually defined, except volatile modifier */
@@ -23,110 +24,63 @@ static noinline void trigger_func3(void)
 	asm volatile ("");
 }
 
+/* attach point for ref_ctr */
+static noinline void trigger_func4(void)
+{
+	asm volatile ("");
+}
+
 static char test_data[] = "test_data";
 
-void test_attach_probe(void)
+/* manual attach kprobe/kretprobe/uprobe/uretprobe testings */
+static void test_attach_probe_manual(struct test_attach_probe *skel)
 {
 	DECLARE_LIBBPF_OPTS(bpf_uprobe_opts, uprobe_opts);
 	struct bpf_link *kprobe_link, *kretprobe_link;
 	struct bpf_link *uprobe_link, *uretprobe_link;
-	struct test_attach_probe* skel;
-	ssize_t uprobe_offset, ref_ctr_offset;
-	struct bpf_link *uprobe_err_link;
-	FILE *devnull;
-	bool legacy;
-
-	/* Check if new-style kprobe/uprobe API is supported.
-	 * Kernels that support new FD-based kprobe and uprobe BPF attachment
-	 * through perf_event_open() syscall expose
-	 * /sys/bus/event_source/devices/kprobe/type and
-	 * /sys/bus/event_source/devices/uprobe/type files, respectively. They
-	 * contain magic numbers that are passed as "type" field of
-	 * perf_event_attr. Lack of such file in the system indicates legacy
-	 * kernel with old-style kprobe/uprobe attach interface through
-	 * creating per-probe event through tracefs. For such cases
-	 * ref_ctr_offset feature is not supported, so we don't test it.
-	 */
-	legacy = access("/sys/bus/event_source/devices/kprobe/type", F_OK) != 0;
+	ssize_t uprobe_offset;
 
 	uprobe_offset = get_uprobe_offset(&trigger_func);
 	if (!ASSERT_GE(uprobe_offset, 0, "uprobe_offset"))
 		return;
 
-	ref_ctr_offset = get_rel_offset((uintptr_t)&uprobe_ref_ctr);
-	if (!ASSERT_GE(ref_ctr_offset, 0, "ref_ctr_offset"))
-		return;
-
-	skel = test_attach_probe__open();
-	if (!ASSERT_OK_PTR(skel, "skel_open"))
-		return;
-
-	/* sleepable kprobe test case needs flags set before loading */
-	if (!ASSERT_OK(bpf_program__set_flags(skel->progs.handle_kprobe_sleepable,
-		BPF_F_SLEEPABLE), "kprobe_sleepable_flags"))
-		goto cleanup;
-
-	if (!ASSERT_OK(test_attach_probe__load(skel), "skel_load"))
-		goto cleanup;
-	if (!ASSERT_OK_PTR(skel->bss, "check_bss"))
-		goto cleanup;
-
 	/* manual-attach kprobe/kretprobe */
 	kprobe_link = bpf_program__attach_kprobe(skel->progs.handle_kprobe,
 						 false /* retprobe */,
 						 SYS_NANOSLEEP_KPROBE_NAME);
 	if (!ASSERT_OK_PTR(kprobe_link, "attach_kprobe"))
-		goto cleanup;
+		return;
 	skel->links.handle_kprobe = kprobe_link;
 
 	kretprobe_link = bpf_program__attach_kprobe(skel->progs.handle_kretprobe,
 						    true /* retprobe */,
 						    SYS_NANOSLEEP_KPROBE_NAME);
 	if (!ASSERT_OK_PTR(kretprobe_link, "attach_kretprobe"))
-		goto cleanup;
+		return;
 	skel->links.handle_kretprobe = kretprobe_link;
 
-	/* auto-attachable kprobe and kretprobe */
-	skel->links.handle_kprobe_auto = bpf_program__attach(skel->progs.handle_kprobe_auto);
-	ASSERT_OK_PTR(skel->links.handle_kprobe_auto, "attach_kprobe_auto");
-
-	skel->links.handle_kretprobe_auto = bpf_program__attach(skel->progs.handle_kretprobe_auto);
-	ASSERT_OK_PTR(skel->links.handle_kretprobe_auto, "attach_kretprobe_auto");
-
-	if (!legacy)
-		ASSERT_EQ(uprobe_ref_ctr, 0, "uprobe_ref_ctr_before");
-
+	/* manual-attach uprobe/uretprobe */
+	uprobe_opts.ref_ctr_offset = 0;
 	uprobe_opts.retprobe = false;
-	uprobe_opts.ref_ctr_offset = legacy ? 0 : ref_ctr_offset;
 	uprobe_link = bpf_program__attach_uprobe_opts(skel->progs.handle_uprobe,
 						      0 /* self pid */,
 						      "/proc/self/exe",
 						      uprobe_offset,
 						      &uprobe_opts);
 	if (!ASSERT_OK_PTR(uprobe_link, "attach_uprobe"))
-		goto cleanup;
+		return;
 	skel->links.handle_uprobe = uprobe_link;
 
-	if (!legacy)
-		ASSERT_GT(uprobe_ref_ctr, 0, "uprobe_ref_ctr_after");
-
-	/* if uprobe uses ref_ctr, uretprobe has to use ref_ctr as well */
 	uprobe_opts.retprobe = true;
-	uprobe_opts.ref_ctr_offset = legacy ? 0 : ref_ctr_offset;
 	uretprobe_link = bpf_program__attach_uprobe_opts(skel->progs.handle_uretprobe,
 							 -1 /* any pid */,
 							 "/proc/self/exe",
 							 uprobe_offset, &uprobe_opts);
 	if (!ASSERT_OK_PTR(uretprobe_link, "attach_uretprobe"))
-		goto cleanup;
+		return;
 	skel->links.handle_uretprobe = uretprobe_link;
 
-	/* verify auto-attach fails for old-style uprobe definition */
-	uprobe_err_link = bpf_program__attach(skel->progs.handle_uprobe_byname);
-	if (!ASSERT_EQ(libbpf_get_error(uprobe_err_link), -EOPNOTSUPP,
-		       "auto-attach should fail for old-style name"))
-		goto cleanup;
-
+	/* attach uprobe by function name manually */
 	uprobe_opts.func_name = "trigger_func2";
 	uprobe_opts.retprobe = false;
 	uprobe_opts.ref_ctr_offset = 0;
@@ -136,13 +90,62 @@ void test_attach_probe(void)
 							"/proc/self/exe",
 							0, &uprobe_opts);
 	if (!ASSERT_OK_PTR(skel->links.handle_uprobe_byname, "attach_uprobe_byname"))
-		goto cleanup;
+		return;
+
+	/* trigger & validate kprobe && kretprobe */
+	usleep(1);
+
+	/* trigger & validate uprobe & uretprobe */
+	trigger_func();
+
+	/* trigger & validate uprobe attached by name */
+	trigger_func2();
+
+	ASSERT_EQ(skel->bss->kprobe_res, 1, "check_kprobe_res");
+	ASSERT_EQ(skel->bss->kretprobe_res, 2, "check_kretprobe_res");
+	ASSERT_EQ(skel->bss->uprobe_res, 3, "check_uprobe_res");
+	ASSERT_EQ(skel->bss->uretprobe_res, 4, "check_uretprobe_res");
+	ASSERT_EQ(skel->bss->uprobe_byname_res, 5, "check_uprobe_byname_res");
+}
+
+static void test_attach_probe_auto(struct test_attach_probe *skel)
+{
+	struct bpf_link *uprobe_err_link;
+
+	/* auto-attachable kprobe and kretprobe */
+	skel->links.handle_kprobe_auto = bpf_program__attach(skel->progs.handle_kprobe_auto);
+	ASSERT_OK_PTR(skel->links.handle_kprobe_auto, "attach_kprobe_auto");
+
+	skel->links.handle_kretprobe_auto = bpf_program__attach(skel->progs.handle_kretprobe_auto);
+	ASSERT_OK_PTR(skel->links.handle_kretprobe_auto, "attach_kretprobe_auto");
+
+	/* verify auto-attach fails for old-style uprobe definition */
+	uprobe_err_link = bpf_program__attach(skel->progs.handle_uprobe_byname);
+	if (!ASSERT_EQ(libbpf_get_error(uprobe_err_link), -EOPNOTSUPP,
+		       "auto-attach should fail for old-style name"))
+		return;
 
 	/* verify auto-attach works */
 	skel->links.handle_uretprobe_byname =
 			bpf_program__attach(skel->progs.handle_uretprobe_byname);
 	if (!ASSERT_OK_PTR(skel->links.handle_uretprobe_byname, "attach_uretprobe_byname"))
-		goto cleanup;
+		return;
+
+	/* trigger & validate kprobe && kretprobe */
+	usleep(1);
+
+	/* trigger & validate uprobe attached by name */
+	trigger_func2();
+
+	ASSERT_EQ(skel->bss->kprobe2_res, 11, "check_kprobe_auto_res");
+	ASSERT_EQ(skel->bss->kretprobe2_res, 22, "check_kretprobe_auto_res");
+	ASSERT_EQ(skel->bss->uretprobe_byname_res, 6, "check_uretprobe_byname_res");
+}
+
+static void test_uprobe_lib(struct test_attach_probe *skel)
+{
+	DECLARE_LIBBPF_OPTS(bpf_uprobe_opts, uprobe_opts);
+	FILE *devnull;
 
 	/* test attach by name for a library function, using the library
 	 * as the binary argument. libc.so.6 will be resolved via dlopen()/dlinfo().
@@ -155,7 +158,7 @@ void test_attach_probe(void)
 							"libc.so.6",
 							0, &uprobe_opts);
 	if (!ASSERT_OK_PTR(skel->links.handle_uprobe_byname2, "attach_uprobe_byname2"))
-		goto cleanup;
+		return;
 
 	uprobe_opts.func_name = "fclose";
 	uprobe_opts.retprobe = true;
@@ -165,62 +168,137 @@ void test_attach_probe(void)
 							"libc.so.6",
 							0, &uprobe_opts);
 	if (!ASSERT_OK_PTR(skel->links.handle_uretprobe_byname2, "attach_uretprobe_byname2"))
+		return;
+
+	/* trigger & validate shared library u[ret]probes attached by name */
+	devnull = fopen("/dev/null", "r");
+	fclose(devnull);
+
+	ASSERT_EQ(skel->bss->uprobe_byname2_res, 7, "check_uprobe_byname2_res");
+	ASSERT_EQ(skel->bss->uretprobe_byname2_res, 8, "check_uretprobe_byname2_res");
+}
+
+static void test_uporbe_ref_ctr(struct test_attach_probe *skel)
+{
+	DECLARE_LIBBPF_OPTS(bpf_uprobe_opts, uprobe_opts);
+	struct bpf_link *uprobe_link, *uretprobe_link;
+	ssize_t uprobe_offset, ref_ctr_offset;
+
+	uprobe_offset = get_uprobe_offset(&trigger_func4);
+	if (!ASSERT_GE(uprobe_offset, 0, "uprobe_offset_ref_ctr"))
+		return;
+
+	ref_ctr_offset = get_rel_offset((uintptr_t)&uprobe_ref_ctr);
+	if (!ASSERT_GE(ref_ctr_offset, 0, "ref_ctr_offset"))
+		return;
+
+	ASSERT_EQ(uprobe_ref_ctr, 0, "uprobe_ref_ctr_before");
+
+	uprobe_opts.retprobe = false;
+	uprobe_opts.ref_ctr_offset = ref_ctr_offset;
+	uprobe_link = bpf_program__attach_uprobe_opts(skel->progs.handle_uprobe_ref_ctr,
+						      0 /* self pid */,
+						      "/proc/self/exe",
+						      uprobe_offset,
+						      &uprobe_opts);
+	if (!ASSERT_OK_PTR(uprobe_link, "attach_uprobe_ref_ctr"))
+		return;
+	skel->links.handle_uprobe_ref_ctr = uprobe_link;
+
+	ASSERT_GT(uprobe_ref_ctr, 0, "uprobe_ref_ctr_after");
+
+	/* if uprobe uses ref_ctr, uretprobe has to use ref_ctr as well */
+	uprobe_opts.retprobe = true;
+	uprobe_opts.ref_ctr_offset = ref_ctr_offset;
+	uretprobe_link = bpf_program__attach_uprobe_opts(skel->progs.handle_uretprobe_ref_ctr,
+							 -1 /* any pid */,
+							 "/proc/self/exe",
+							 uprobe_offset, &uprobe_opts);
+	if (!ASSERT_OK_PTR(uretprobe_link, "attach_uretprobe_ref_ctr"))
+		return;
+	skel->links.handle_uretprobe_ref_ctr = uretprobe_link;
+}
+
+static void test_kprobe_sleepable(void)
+{
+	struct test_attach_kprobe_sleepable *skel;
+
+	skel = test_attach_kprobe_sleepable__open();
+	if (!ASSERT_OK_PTR(skel, "skel_kprobe_sleepable_open"))
+		return;
+
+	/* sleepable kprobe test case needs flags set before loading */
+	if (!ASSERT_OK(bpf_program__set_flags(skel->progs.handle_kprobe_sleepable,
+		BPF_F_SLEEPABLE), "kprobe_sleepable_flags"))
+		goto cleanup;
+
+	if (!ASSERT_OK(test_attach_kprobe_sleepable__load(skel),
+		       "skel_kprobe_sleepable_load"))
 		goto cleanup;
 
 	/* sleepable kprobes should not attach successfully */
 	skel->links.handle_kprobe_sleepable = bpf_program__attach(skel->progs.handle_kprobe_sleepable);
-	if (!ASSERT_ERR_PTR(skel->links.handle_kprobe_sleepable, "attach_kprobe_sleepable"))
-		goto cleanup;
+	ASSERT_ERR_PTR(skel->links.handle_kprobe_sleepable, "attach_kprobe_sleepable");
+
+cleanup:
+	test_attach_kprobe_sleepable__destroy(skel);
+}
 
+static void test_uprobe_sleepable(struct test_attach_probe *skel)
+{
 	/* test sleepable uprobe and uretprobe variants */
 	skel->links.handle_uprobe_byname3_sleepable = bpf_program__attach(skel->progs.handle_uprobe_byname3_sleepable);
 	if (!ASSERT_OK_PTR(skel->links.handle_uprobe_byname3_sleepable, "attach_uprobe_byname3_sleepable"))
-		goto cleanup;
+		return;
 
 	skel->links.handle_uprobe_byname3 = bpf_program__attach(skel->progs.handle_uprobe_byname3);
 	if (!ASSERT_OK_PTR(skel->links.handle_uprobe_byname3, "attach_uprobe_byname3"))
-		goto cleanup;
+		return;
 
 	skel->links.handle_uretprobe_byname3_sleepable = bpf_program__attach(skel->progs.handle_uretprobe_byname3_sleepable);
 	if (!ASSERT_OK_PTR(skel->links.handle_uretprobe_byname3_sleepable, "attach_uretprobe_byname3_sleepable"))
-		goto cleanup;
+		return;
 
 	skel->links.handle_uretprobe_byname3 = bpf_program__attach(skel->progs.handle_uretprobe_byname3);
 	if (!ASSERT_OK_PTR(skel->links.handle_uretprobe_byname3, "attach_uretprobe_byname3"))
-		goto cleanup;
+		return;
 
 	skel->bss->user_ptr = test_data;
 
-	/* trigger & validate kprobe && kretprobe */
-	usleep(1);
-
-	/* trigger & validate shared library u[ret]probes attached by name */
-	devnull = fopen("/dev/null", "r");
-	fclose(devnull);
-
-	/* trigger & validate uprobe & uretprobe */
-	trigger_func();
-
-	/* trigger & validate uprobe attached by name */
-	trigger_func2();
-
 	/* trigger & validate sleepable uprobe attached by name */
 	trigger_func3();
 
-	ASSERT_EQ(skel->bss->kprobe_res, 1, "check_kprobe_res");
-	ASSERT_EQ(skel->bss->kprobe2_res, 11, "check_kprobe_auto_res");
-	ASSERT_EQ(skel->bss->kretprobe_res, 2, "check_kretprobe_res");
-	ASSERT_EQ(skel->bss->kretprobe2_res, 22, "check_kretprobe_auto_res");
-	ASSERT_EQ(skel->bss->uprobe_res, 3, "check_uprobe_res");
-	ASSERT_EQ(skel->bss->uretprobe_res, 4, "check_uretprobe_res");
-	ASSERT_EQ(skel->bss->uprobe_byname_res, 5, "check_uprobe_byname_res");
-	ASSERT_EQ(skel->bss->uretprobe_byname_res, 6, "check_uretprobe_byname_res");
-	ASSERT_EQ(skel->bss->uprobe_byname2_res, 7, "check_uprobe_byname2_res");
-	ASSERT_EQ(skel->bss->uretprobe_byname2_res, 8, "check_uretprobe_byname2_res");
 	ASSERT_EQ(skel->bss->uprobe_byname3_sleepable_res, 9, "check_uprobe_byname3_sleepable_res");
 	ASSERT_EQ(skel->bss->uprobe_byname3_res, 10, "check_uprobe_byname3_res");
 	ASSERT_EQ(skel->bss->uretprobe_byname3_sleepable_res, 11, "check_uretprobe_byname3_sleepable_res");
 	ASSERT_EQ(skel->bss->uretprobe_byname3_res, 12, "check_uretprobe_byname3_res");
+}
+
+void test_attach_probe(void)
+{
+	struct test_attach_probe *skel;
+
+	skel = test_attach_probe__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	if (!ASSERT_OK(test_attach_probe__load(skel), "skel_load"))
+		goto cleanup;
+	if (!ASSERT_OK_PTR(skel->bss, "check_bss"))
+		goto cleanup;
+
+	if (test__start_subtest("manual"))
+		test_attach_probe_manual(skel);
+	if (test__start_subtest("auto"))
+		test_attach_probe_auto(skel);
+	if (test__start_subtest("kprobe-sleepable"))
+		test_kprobe_sleepable();
+	if (test__start_subtest("uprobe-lib"))
+		test_uprobe_lib(skel);
+	if (test__start_subtest("uprobe-sleepable"))
+		test_uprobe_sleepable(skel);
+	if (test__start_subtest("uprobe-ref_ctr"))
+		test_uporbe_ref_ctr(skel);
 
 cleanup:
 	test_attach_probe__destroy(skel);
diff --git a/tools/testing/selftests/bpf/progs/test_attach_kprobe_sleepable.c b/tools/testing/selftests/bpf/progs/test_attach_kprobe_sleepable.c
new file mode 100644
index 000000000000..f548b7446218
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_attach_kprobe_sleepable.c
@@ -0,0 +1,23 @@
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
+
+/**
+ * This program will be manually made sleepable on the userspace side
+ * and should thus be unattachable.
+ */
+SEC("kprobe/" SYS_PREFIX "sys_nanosleep")
+int handle_kprobe_sleepable(struct pt_regs *ctx)
+{
+	kprobe_res = 1;
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/test_attach_probe.c b/tools/testing/selftests/bpf/progs/test_attach_probe.c
index 3b5dc34d23e9..9e1e7163bb67 100644
--- a/tools/testing/selftests/bpf/progs/test_attach_probe.c
+++ b/tools/testing/selftests/bpf/progs/test_attach_probe.c
@@ -37,17 +37,6 @@ int BPF_KSYSCALL(handle_kprobe_auto, struct __kernel_timespec *req, struct __ker
 	return 0;
 }
 
-/**
- * This program will be manually made sleepable on the userspace side
- * and should thus be unattachable.
- */
-SEC("kprobe/" SYS_PREFIX "sys_nanosleep")
-int handle_kprobe_sleepable(struct pt_regs *ctx)
-{
-	kprobe_res = 2;
-	return 0;
-}
-
 SEC("kretprobe")
 int handle_kretprobe(struct pt_regs *ctx)
 {
@@ -76,6 +65,18 @@ int handle_uretprobe(struct pt_regs *ctx)
 	return 0;
 }
 
+SEC("uprobe")
+int handle_uprobe_ref_ctr(struct pt_regs *ctx)
+{
+	return 0;
+}
+
+SEC("uretprobe")
+int handle_uretprobe_ref_ctr(struct pt_regs *ctx)
+{
+	return 0;
+}
+
 SEC("uprobe")
 int handle_uprobe_byname(struct pt_regs *ctx)
 {
-- 
2.39.0

