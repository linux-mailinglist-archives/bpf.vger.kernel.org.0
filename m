Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA575B34E2
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 12:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbiIIKOO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 06:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbiIIKOJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 06:14:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0212116B40
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 03:13:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFE1361F66
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 10:13:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C03C433D6;
        Fri,  9 Sep 2022 10:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662718438;
        bh=e8bbtFYLVSbybF8R+o1g1uIyD4WWd53GoZ4LOoXZOgg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tGn95YzKLhrlY5DYcb3BzOMhxJvgFg5OqONINN8bGlsUCuBLDgPEY0FCk/bw0NHTM
         FDX9Y2zFbQvGaXt1wRCha9mh+iJuLj34EyIrrSuEz94dXz9BSHDwOqwin91NKElQ6G
         u/hlAP4GkQ9/zS5uu0Ww2xkxm1UGAkGaHqEINiGkFL3BD+xU2D5Gkm8vlkAxlhlk4E
         YgMri3EabN37izQmA+xZHYbIvo7da5jEg7iMAzOUDQIh9eEIQQFo70Yg682IXYT8cb
         mASgha7RQFXDEWON1EUd2cpxJVRpGhmlv+eW3AXGicXELjZCeVWXCBGjEvQW5HdDge
         NkpQyX3Vmnjug==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Martynas Pumputis <m@lambda.lt>
Subject: [PATCHv3 bpf-next 6/6] selftests/bpf: Fix get_func_ip offset test for CONFIG_X86_KERNEL_IBT
Date:   Fri,  9 Sep 2022 12:12:45 +0200
Message-Id: <20220909101245.347173-7-jolsa@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220909101245.347173-1-jolsa@kernel.org>
References: <20220909101245.347173-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

With CONFIG_X86_KERNEL_IBT enabled the test for kprobe with offset
won't work because of the extra endbr instruction.

As suggested by Andrii adding CONFIG_X86_KERNEL_IBT detection
and using appropriate offset value based on that.

Also removing test7 program, because it does the same as test6.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../bpf/prog_tests/get_func_ip_test.c         | 59 +++++++++++++++----
 .../selftests/bpf/progs/get_func_ip_test.c    | 23 ++++----
 2 files changed, 60 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c b/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
index 938dbd4d7c2f..fede8ef58b5b 100644
--- a/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
@@ -2,7 +2,7 @@
 #include <test_progs.h>
 #include "get_func_ip_test.skel.h"
 
-void test_get_func_ip_test(void)
+static void test_function_entry(void)
 {
 	struct get_func_ip_test *skel = NULL;
 	int err, prog_fd;
@@ -12,14 +12,6 @@ void test_get_func_ip_test(void)
 	if (!ASSERT_OK_PTR(skel, "get_func_ip_test__open"))
 		return;
 
-	/* test6 is x86_64 specifc because of the instruction
-	 * offset, disabling it for all other archs
-	 */
-#ifndef __x86_64__
-	bpf_program__set_autoload(skel->progs.test6, false);
-	bpf_program__set_autoload(skel->progs.test7, false);
-#endif
-
 	err = get_func_ip_test__load(skel);
 	if (!ASSERT_OK(err, "get_func_ip_test__load"))
 		goto cleanup;
@@ -43,11 +35,56 @@ void test_get_func_ip_test(void)
 	ASSERT_EQ(skel->bss->test3_result, 1, "test3_result");
 	ASSERT_EQ(skel->bss->test4_result, 1, "test4_result");
 	ASSERT_EQ(skel->bss->test5_result, 1, "test5_result");
+
+cleanup:
+	get_func_ip_test__destroy(skel);
+}
+
+/* test6 is x86_64 specific because of the instruction
+ * offset, disabling it for all other archs
+ */
 #ifdef __x86_64__
+static void test_function_body(void)
+{
+	struct get_func_ip_test *skel = NULL;
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	LIBBPF_OPTS(bpf_kprobe_opts, kopts);
+	struct bpf_link *link6 = NULL;
+	int err, prog_fd;
+
+	skel = get_func_ip_test__open();
+	if (!ASSERT_OK_PTR(skel, "get_func_ip_test__open"))
+		return;
+
+	bpf_program__set_autoload(skel->progs.test6, true);
+
+	err = get_func_ip_test__load(skel);
+	if (!ASSERT_OK(err, "get_func_ip_test__load"))
+		goto cleanup;
+
+	kopts.offset = skel->kconfig->CONFIG_X86_KERNEL_IBT ? 9 : 5;
+
+	link6 = bpf_program__attach_kprobe_opts(skel->progs.test6, "bpf_fentry_test6", &kopts);
+	if (!ASSERT_OK_PTR(link6, "link6"))
+		goto cleanup;
+
+	prog_fd = bpf_program__fd(skel->progs.test1);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_run");
+	ASSERT_EQ(topts.retval, 0, "test_run");
+
 	ASSERT_EQ(skel->bss->test6_result, 1, "test6_result");
-	ASSERT_EQ(skel->bss->test7_result, 1, "test7_result");
-#endif
 
 cleanup:
+	bpf_link__destroy(link6);
 	get_func_ip_test__destroy(skel);
 }
+#else
+#define test_function_body()
+#endif
+
+void test_get_func_ip_test(void)
+{
+	test_function_entry();
+	test_function_body();
+}
diff --git a/tools/testing/selftests/bpf/progs/get_func_ip_test.c b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
index 6db70757bc8b..8559e698b40d 100644
--- a/tools/testing/selftests/bpf/progs/get_func_ip_test.c
+++ b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
@@ -2,6 +2,7 @@
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
+#include <stdbool.h>
 
 char _license[] SEC("license") = "GPL";
 
@@ -13,6 +14,16 @@ extern const void bpf_modify_return_test __ksym;
 extern const void bpf_fentry_test6 __ksym;
 extern const void bpf_fentry_test7 __ksym;
 
+extern bool CONFIG_X86_KERNEL_IBT __kconfig __weak;
+
+/* This function is here to have CONFIG_X86_KERNEL_IBT
+ * used and added to object BTF.
+ */
+int unused(void)
+{
+	return CONFIG_X86_KERNEL_IBT ? 0 : 1;
+}
+
 __u64 test1_result = 0;
 SEC("fentry/bpf_fentry_test1")
 int BPF_PROG(test1, int a)
@@ -64,7 +75,7 @@ int BPF_PROG(test5, int a, int *b, int ret)
 }
 
 __u64 test6_result = 0;
-SEC("kprobe/bpf_fentry_test6+0x5")
+SEC("?kprobe")
 int test6(struct pt_regs *ctx)
 {
 	__u64 addr = bpf_get_func_ip(ctx);
@@ -72,13 +83,3 @@ int test6(struct pt_regs *ctx)
 	test6_result = (const void *) addr == 0;
 	return 0;
 }
-
-__u64 test7_result = 0;
-SEC("kprobe/bpf_fentry_test7+5")
-int test7(struct pt_regs *ctx)
-{
-	__u64 addr = bpf_get_func_ip(ctx);
-
-	test7_result = (const void *) addr == 0;
-	return 0;
-}
-- 
2.37.3

