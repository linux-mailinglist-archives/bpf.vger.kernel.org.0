Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E210D58CA33
	for <lists+bpf@lfdr.de>; Mon,  8 Aug 2022 16:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243274AbiHHOJp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 10:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243151AbiHHOJo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 10:09:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F99101ED
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 07:09:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96E8460DE0
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 14:09:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D777DC4347C;
        Mon,  8 Aug 2022 14:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659967782;
        bh=S6sIv3GtWDSFe1NEh5ra4nz+G3St4P7VHuJCX+AA4DI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MeRun3OeBu7a6tFbdnzYi+ir8Wj+g/weYjptGJSgYsGgqw+TNWy3z72uoKFaWQ/qg
         yu7LigaoqSwzAX6n5oXv6R0gX8w2hfgCHUaBtd6HcyEUPZlYukdqwRYZNv2vZ5n06P
         HJ9MIxCj3K8bMRT54nCBF02NYJ/8DOwoFfsDnlEbI7s2XeHHXwa+Talsp0HShKBvyK
         /8UfpHW/CFpUSo0Nru6mamsnIgdEc4/WccthOhUgij9XBfXwQjEN0ba/NjjgeGLcEA
         USVedRjF437mQTs6lOnP2gpL+XZ4AGnblUeQMY1ye48eb97qbJOsyY+d/wtmUBmA83
         VP+hWIFE4+G/g==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: [RFC PATCH bpf-next 17/17] selftests/bpf: Add mixed tracing multi func test
Date:   Mon,  8 Aug 2022 16:06:26 +0200
Message-Id: <20220808140626.422731-18-jolsa@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220808140626.422731-1-jolsa@kernel.org>
References: <20220808140626.422731-1-jolsa@kernel.org>
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

Adding selftest for fentry/fexit multi func tests that attaches
to bpf_fentry_test* functions, where some of them have already
attached single trampoline.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/Makefile          |  4 +-
 .../selftests/bpf/prog_tests/tracing_multi.c  | 67 +++++++++++++++++++
 .../selftests/bpf/progs/tracing_multi_mixed.c | 43 ++++++++++++
 3 files changed, 113 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_mixed.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index a231cca9882f..9d507615383b 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -350,7 +350,8 @@ LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h		\
 		test_subskeleton.skel.h test_subskeleton_lib.skel.h	\
 		test_usdt.skel.h tracing_multi_fentry_test.skel.h	\
 		tracing_multi_fexit_test.skel.h				\
-		tracing_multi_fentry_fexit_test.skel.h
+		tracing_multi_fentry_fexit_test.skel.h			\
+		tracing_multi_mixed_test.skel.h
 
 LSKELS := kfunc_call_test.c fentry_test.c fexit_test.c fexit_sleep.c \
 	test_ringbuf.c atomics.c trace_printk.c trace_vprintk.c \
@@ -371,6 +372,7 @@ test_usdt.skel.h-deps := test_usdt.o test_usdt_multispec.o
 tracing_multi_fentry_test.skel.h-deps := tracing_multi_fentry.o tracing_multi_check.o
 tracing_multi_fexit_test.skel.h-deps := tracing_multi_fexit.o tracing_multi_check.o
 tracing_multi_fentry_fexit_test.skel.h-deps := tracing_multi_fentry_fexit.o tracing_multi_check.o
+tracing_multi_mixed_test.skel.h-deps := tracing_multi_mixed.o tracing_multi_check.o
 
 LINKED_BPF_SRCS := $(patsubst %.o,%.c,$(foreach skel,$(LINKED_SKELS),$($(skel)-deps)))
 
diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
index 409bcf1e3653..416940dcde48 100644
--- a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
@@ -3,6 +3,7 @@
 #include "tracing_multi_fentry_test.skel.h"
 #include "tracing_multi_fexit_test.skel.h"
 #include "tracing_multi_fentry_fexit_test.skel.h"
+#include "tracing_multi_mixed_test.skel.h"
 #include "trace_helpers.h"
 
 static void multi_fentry_test(void)
@@ -80,6 +81,70 @@ static void multi_fentry_fexit_test(void)
 	tracing_multi_fentry_fexit_test__destroy(skel);
 }
 
+static void multi_mixed_test(void)
+{
+	struct bpf_link *linkm1 = NULL, *linkm2 = NULL;
+	struct bpf_link *link1 = NULL, *link2 = NULL;
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	struct tracing_multi_mixed_test *skel = NULL;
+	int err, prog_fd;
+
+	skel = tracing_multi_mixed_test__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "tracing_multi_mixed_test__open_and_load"))
+		goto cleanup;
+
+	link1 = bpf_program__attach_trace(skel->progs.test1);
+	if (!ASSERT_OK_PTR(link1, "attach_trace"))
+		goto cleanup;
+
+	link2 = bpf_program__attach_trace(skel->progs.test2);
+	if (!ASSERT_OK_PTR(link2, "attach_trace"))
+		goto cleanup;
+
+	linkm1 = bpf_program__attach_tracing_multi(skel->progs.test3,
+						  "bpf_fentry_test*", NULL);
+	if (!ASSERT_OK_PTR(linkm1, "attach_tracing_multi"))
+		goto cleanup;
+
+	linkm2 = bpf_program__attach_tracing_multi(skel->progs.test4,
+						  "bpf_fentry_test*", NULL);
+	if (!ASSERT_OK_PTR(linkm2, "attach_tracing_multi"))
+		goto cleanup;
+
+	prog_fd = bpf_program__fd(skel->progs.test1);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_run");
+
+	ASSERT_EQ(skel->bss->test1_result, 1, "test1_result");
+	ASSERT_EQ(skel->bss->test2_result, 1, "test2_result");
+	ASSERT_EQ(skel->bss->test3_arg_result, 8, "test3_arg_result");
+	ASSERT_EQ(skel->bss->test4_arg_result, 8, "test4_arg_result");
+	ASSERT_EQ(skel->bss->test4_ret_result, 8, "test4_ret_result");
+
+	bpf_link__destroy(link1);
+	bpf_link__destroy(link2);
+	bpf_link__destroy(linkm1);
+	bpf_link__destroy(linkm2);
+
+	linkm2 = link1 = link2 = NULL;
+
+	linkm1 = bpf_program__attach_tracing_multi(skel->progs.test3,
+						  "bpf_fentry_test*", NULL);
+	if (!ASSERT_OK_PTR(linkm1, "attach_tracing_multi"))
+		goto cleanup;
+
+	link1 = bpf_program__attach_trace(skel->progs.test1);
+	if (!ASSERT_ERR_PTR(link1, "attach_trace"))
+		goto cleanup;
+
+cleanup:
+	bpf_link__destroy(link1);
+	bpf_link__destroy(link2);
+	bpf_link__destroy(linkm1);
+	bpf_link__destroy(linkm2);
+	tracing_multi_mixed_test__destroy(skel);
+}
+
 void test_tracing_multi_test(void)
 {
 	if (test__start_subtest("fentry"))
@@ -88,4 +153,6 @@ void test_tracing_multi_test(void)
 		multi_fexit_test();
 	if (test__start_subtest("fentry_fexit"))
 		multi_fentry_fexit_test();
+	if (test__start_subtest("mixed"))
+		multi_mixed_test();
 }
diff --git a/tools/testing/selftests/bpf/progs/tracing_multi_mixed.c b/tools/testing/selftests/bpf/progs/tracing_multi_mixed.c
new file mode 100644
index 000000000000..468a044753e9
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tracing_multi_mixed.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+__hidden extern void multi_arg_check(__u64 *ctx, __u64 *test_result);
+__hidden extern void multi_ret_check(void *ctx, __u64 *test_result);
+
+__u64 test1_result = 0;
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(test1, int a)
+{
+	test1_result += a == 1;
+	return 0;
+}
+
+__u64 test2_result = 0;
+SEC("fexit/bpf_fentry_test2")
+int BPF_PROG(test2, int a, __u64 b, int ret)
+{
+	test2_result += a == 2 && b == 3;
+	return 0;
+}
+
+__u64 test3_arg_result = 0;
+SEC("fentry.multi/bpf_fentry_test*")
+int BPF_PROG(test3, __u64 a, __u64 b, __u64 c, __u64 d, __u64 e, __u64 f)
+{
+	multi_arg_check(ctx, &test3_arg_result);
+	return 0;
+}
+
+__u64 test4_arg_result = 0;
+__u64 test4_ret_result = 0;
+SEC("fexit.multi/bpf_fentry_test*")
+int BPF_PROG(test4, __u64 a, __u64 b, __u64 c, __u64 d, __u64 e, __u64 f, int ret)
+{
+	multi_arg_check(ctx, &test4_arg_result);
+	multi_ret_check(ctx, &test4_ret_result);
+	return 0;
+}
-- 
2.37.1

