Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4097D58F9DC
	for <lists+bpf@lfdr.de>; Thu, 11 Aug 2022 11:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234334AbiHKJQp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Aug 2022 05:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234846AbiHKJQp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Aug 2022 05:16:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801DF3DBCD
        for <bpf@vger.kernel.org>; Thu, 11 Aug 2022 02:16:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0EF0F615CE
        for <bpf@vger.kernel.org>; Thu, 11 Aug 2022 09:16:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B88FAC433D6;
        Thu, 11 Aug 2022 09:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660209403;
        bh=nBViZrcRTcxtrC/Hi81Cy8+sjNFVaHklVbGmZsQipdg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LaCRVS9oChX/bgPKhkmG793RgM5hf0zrG33g6G4JMe1wU1F2HubEAnftHACwm3PCZ
         Spe55wIodjqykh8QfJwHwEVvR4MRPGoqxeztEe9uR/+iuG8qlXGtZ1EYmaeVj9P6Rr
         eFo4dQxi8mLcc6072C8/p7UERmA5RhwpdKBStSO3XVL0e8XiPjplxqwv+VAAXBTKPi
         +R4AwGAxo4fMwUaDS14lZiCB0MhX2fxST3kgiElsMAXpqdm+0kgmDblLdi40vAUtHM
         4jis9zLQ1UM9ocNFP1vlOtjBG7AS3RTaDPC9bhZawUBMypDzCfxloXi7sBWOKs9Dpa
         Y+QTu5WqNJIvA==
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
        Peter Zijlstra <peterz@infradead.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: [PATCHv2 bpf-next 6/6] selftests/bpf: Fix get_func_ip offset test for CONFIG_X86_KERNEL_IBT
Date:   Thu, 11 Aug 2022 11:15:26 +0200
Message-Id: <20220811091526.172610-7-jolsa@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220811091526.172610-1-jolsa@kernel.org>
References: <20220811091526.172610-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 .../bpf/prog_tests/get_func_ip_test.c         | 62 +++++++++++++++----
 .../selftests/bpf/progs/get_func_ip_test.c    | 20 +++---
 2 files changed, 60 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c b/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
index 938dbd4d7c2f..a4dab2fa2258 100644
--- a/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
@@ -2,7 +2,9 @@
 #include <test_progs.h>
 #include "get_func_ip_test.skel.h"
 
-void test_get_func_ip_test(void)
+static int config_ibt;
+
+static void test_function_entry(void)
 {
 	struct get_func_ip_test *skel = NULL;
 	int err, prog_fd;
@@ -12,14 +14,6 @@ void test_get_func_ip_test(void)
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
@@ -38,16 +32,62 @@ void test_get_func_ip_test(void)
 
 	ASSERT_OK(err, "test_run");
 
+	config_ibt = skel->bss->config_ibt;
+	ASSERT_TRUE(config_ibt == 0 || config_ibt == 1, "config_ibt");
+	printf("%s:config_ibt %d\n", __func__, config_ibt);
+
 	ASSERT_EQ(skel->bss->test1_result, 1, "test1_result");
 	ASSERT_EQ(skel->bss->test2_result, 1, "test2_result");
 	ASSERT_EQ(skel->bss->test3_result, 1, "test3_result");
 	ASSERT_EQ(skel->bss->test4_result, 1, "test4_result");
 	ASSERT_EQ(skel->bss->test5_result, 1, "test5_result");
+
+cleanup:
+	get_func_ip_test__destroy(skel);
+}
+
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
+	kopts.offset = config_ibt ? 9 : 5;
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
+#define test_function_body(arg)
+#endif
+
+void test_get_func_ip_test(void)
+{
+	test_function_entry();
+	test_function_body();
+}
diff --git a/tools/testing/selftests/bpf/progs/get_func_ip_test.c b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
index 6db70757bc8b..cb8e58183d46 100644
--- a/tools/testing/selftests/bpf/progs/get_func_ip_test.c
+++ b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
@@ -2,6 +2,7 @@
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
+#include <stdbool.h>
 
 char _license[] SEC("license") = "GPL";
 
@@ -13,12 +14,19 @@ extern const void bpf_modify_return_test __ksym;
 extern const void bpf_fentry_test6 __ksym;
 extern const void bpf_fentry_test7 __ksym;
 
+extern bool CONFIG_X86_KERNEL_IBT __kconfig __weak;
+
+bool config_ibt;
+
 __u64 test1_result = 0;
 SEC("fentry/bpf_fentry_test1")
 int BPF_PROG(test1, int a)
 {
 	__u64 addr = bpf_get_func_ip(ctx);
 
+	/* just to propagate config option value to user space */
+	config_ibt = CONFIG_X86_KERNEL_IBT;
+
 	test1_result = (const void *) addr == &bpf_fentry_test1;
 	return 0;
 }
@@ -64,7 +72,7 @@ int BPF_PROG(test5, int a, int *b, int ret)
 }
 
 __u64 test6_result = 0;
-SEC("kprobe/bpf_fentry_test6+0x5")
+SEC("?kprobe/")
 int test6(struct pt_regs *ctx)
 {
 	__u64 addr = bpf_get_func_ip(ctx);
@@ -72,13 +80,3 @@ int test6(struct pt_regs *ctx)
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
2.37.1

