Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17AAD58CA31
	for <lists+bpf@lfdr.de>; Mon,  8 Aug 2022 16:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243114AbiHHOJd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 10:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235851AbiHHOJc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 10:09:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8DDE02F
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 07:09:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD2AA60D24
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 14:09:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FCBAC433C1;
        Mon,  8 Aug 2022 14:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659967771;
        bh=8My5wtRdf4PvLuvJToWbcolGBgbXJ26kjBbvqc7N86s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nJxjI4qUgGVEPMnq3Y9KANaSd67kPmCv+rE273YaukABlELSgSHSgmEFGRfvYasNX
         0cixvkJU2uDCjPn0QqrGnIG4LoILCzN5xRU+hhWy+tJCRp8e3ckJY8Z5TNhY8OJsmd
         HmOeXJTQTqZtMS6LSGy7WnvUYQY/fzydL7ShgIHfogvmnC9u7EqyZYJRG18WTv9MAP
         cpmlfnkw22XaYzw8PsotVG51tkUl/49CZNcOYRUM4BJycEs/1ZB6KBa7x0qH+O1IDI
         8d+095KoSVklOPpD/eZH78mr8pcynhR+Ldqni00ALaBgn6hNxcKxz0/xNXofkvAVv0
         mu6Xfis7dYXTQ==
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
Subject: [RFC PATCH bpf-next 16/17] selftests/bpf: Add fentry/fexit tracing multi func test
Date:   Mon,  8 Aug 2022 16:06:25 +0200
Message-Id: <20220808140626.422731-17-jolsa@kernel.org>
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
to bpf_fentry_test* functions and checks argument values based
on the processed function.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/Makefile          |  4 ++-
 .../selftests/bpf/prog_tests/tracing_multi.c  | 29 +++++++++++++++++++
 .../bpf/progs/tracing_multi_fentry_fexit.c    | 28 ++++++++++++++++++
 3 files changed, 60 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_fentry_fexit.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 9c0b26e6e645..a231cca9882f 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -349,7 +349,8 @@ LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h		\
 		linked_vars.skel.h linked_maps.skel.h 			\
 		test_subskeleton.skel.h test_subskeleton_lib.skel.h	\
 		test_usdt.skel.h tracing_multi_fentry_test.skel.h	\
-		tracing_multi_fexit_test.skel.h
+		tracing_multi_fexit_test.skel.h				\
+		tracing_multi_fentry_fexit_test.skel.h
 
 LSKELS := kfunc_call_test.c fentry_test.c fexit_test.c fexit_sleep.c \
 	test_ringbuf.c atomics.c trace_printk.c trace_vprintk.c \
@@ -369,6 +370,7 @@ test_subskeleton_lib.skel.h-deps := test_subskeleton_lib2.o test_subskeleton_lib
 test_usdt.skel.h-deps := test_usdt.o test_usdt_multispec.o
 tracing_multi_fentry_test.skel.h-deps := tracing_multi_fentry.o tracing_multi_check.o
 tracing_multi_fexit_test.skel.h-deps := tracing_multi_fexit.o tracing_multi_check.o
+tracing_multi_fentry_fexit_test.skel.h-deps := tracing_multi_fentry_fexit.o tracing_multi_check.o
 
 LINKED_BPF_SRCS := $(patsubst %.o,%.c,$(foreach skel,$(LINKED_SKELS),$($(skel)-deps)))
 
diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
index b7b1e42754da..409bcf1e3653 100644
--- a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
@@ -2,6 +2,7 @@
 #include <test_progs.h>
 #include "tracing_multi_fentry_test.skel.h"
 #include "tracing_multi_fexit_test.skel.h"
+#include "tracing_multi_fentry_fexit_test.skel.h"
 #include "trace_helpers.h"
 
 static void multi_fentry_test(void)
@@ -53,10 +54,38 @@ static void multi_fexit_test(void)
 	tracing_multi_fexit_test__destroy(skel);
 }
 
+static void multi_fentry_fexit_test(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	struct tracing_multi_fentry_fexit_test *skel = NULL;
+	int err, prog_fd;
+
+	skel = tracing_multi_fentry_fexit_test__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "tracing_multi_fentry_fexit_test__open_and_load"))
+		goto cleanup;
+
+	err = tracing_multi_fentry_fexit_test__attach(skel);
+	if (!ASSERT_OK(err, "tracing_multi_fentry_fexit_test__attach"))
+		goto cleanup;
+
+	prog_fd = bpf_program__fd(skel->progs.test2);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_run");
+
+	ASSERT_EQ(skel->bss->test1_arg_result, 8, "test1_arg_result");
+	ASSERT_EQ(skel->bss->test2_arg_result, 8, "test2_arg_result");
+	ASSERT_EQ(skel->bss->test2_ret_result, 8, "test2_ret_result");
+
+cleanup:
+	tracing_multi_fentry_fexit_test__destroy(skel);
+}
+
 void test_tracing_multi_test(void)
 {
 	if (test__start_subtest("fentry"))
 		multi_fentry_test();
 	if (test__start_subtest("fexit"))
 		multi_fexit_test();
+	if (test__start_subtest("fentry_fexit"))
+		multi_fentry_fexit_test();
 }
diff --git a/tools/testing/selftests/bpf/progs/tracing_multi_fentry_fexit.c b/tools/testing/selftests/bpf/progs/tracing_multi_fentry_fexit.c
new file mode 100644
index 000000000000..54ee94d060b2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tracing_multi_fentry_fexit.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+__u64 test1_arg_result = 0;
+__u64 test2_arg_result = 0;
+__u64 test2_ret_result = 0;
+
+__hidden extern void multi_arg_check(__u64 *ctx, __u64 *test_result);
+__hidden extern void multi_ret_check(void *ctx, __u64 *test_result);
+
+SEC("fentry.multi/bpf_fentry_test*")
+int BPF_PROG(test1, __u64 a, __u64 b, __u64 c, __u64 d, __u64 e, __u64 f)
+{
+	multi_arg_check(ctx, &test1_arg_result);
+	return 0;
+}
+
+SEC("fexit.multi/bpf_fentry_test*")
+int BPF_PROG(test2, __u64 a, __u64 b, __u64 c, __u64 d, __u64 e, __u64 f, int ret)
+{
+	multi_arg_check(ctx, &test2_arg_result);
+	multi_ret_check(ctx, &test2_ret_result);
+	return 0;
+}
-- 
2.37.1

