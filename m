Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226F758CA2E
	for <lists+bpf@lfdr.de>; Mon,  8 Aug 2022 16:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242984AbiHHOJ0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 10:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242764AbiHHOJX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 10:09:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E6CDFC6
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 07:09:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AAA08B8049B
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 14:09:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6690C433D6;
        Mon,  8 Aug 2022 14:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659967759;
        bh=KTCmzJUSMjJ0vUvuZqtfQzzCdRbrVfPPqubfBxYmCFo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ze8J5EeFrPCQKHZsQmZBljWiLDLUckPR78c6MIuTySDsVof8YCyUtcP1xMtM8V3ie
         VTqNcS6MbaRkGGnJgJp4ujdFqPyzh+ZB1UR8DfvMJxYafzuWwMgj636hokBvQ0yT/U
         Y0CJN/TgFaWesOxRmAcOiGlZ/O6NvV0Qb/P7woFSNtd1nKjKbbPzVQgQtboABO5R4s
         8JMlTv1VCmRYg4tC2jEUWCl3SE2DQoKvKMevCF+dVLpYhB+J512NCpjCoRjGTm1IeQ
         EPIq7Ef9TKtXwv9hejxZck8l9SD7ttaXr+oRqe09pGxDPYzyxEl5Z6wVDIBVZbGnVL
         3dWS830O6F+Qg==
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
Subject: [RFC PATCH bpf-next 15/17] selftests/bpf: Add fexit tracing multi func test
Date:   Mon,  8 Aug 2022 16:06:24 +0200
Message-Id: <20220808140626.422731-16-jolsa@kernel.org>
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

Adding selftest for fexit multi func test that attaches
to bpf_fentry_test* functions and checks argument values
based on the processed function.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/Makefile          |  4 ++-
 .../selftests/bpf/prog_tests/tracing_multi.c  | 28 +++++++++++++++++++
 .../selftests/bpf/progs/tracing_multi_check.c | 26 +++++++++++++++++
 .../selftests/bpf/progs/tracing_multi_fexit.c | 20 +++++++++++++
 4 files changed, 77 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_fexit.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 24f0ace18af2..9c0b26e6e645 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -348,7 +348,8 @@ SKEL_BLACKLIST := btf__% test_pinning_invalid.c test_sk_assign.c
 LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h		\
 		linked_vars.skel.h linked_maps.skel.h 			\
 		test_subskeleton.skel.h test_subskeleton_lib.skel.h	\
-		test_usdt.skel.h tracing_multi_fentry_test.skel.h
+		test_usdt.skel.h tracing_multi_fentry_test.skel.h	\
+		tracing_multi_fexit_test.skel.h
 
 LSKELS := kfunc_call_test.c fentry_test.c fexit_test.c fexit_sleep.c \
 	test_ringbuf.c atomics.c trace_printk.c trace_vprintk.c \
@@ -367,6 +368,7 @@ test_subskeleton.skel.h-deps := test_subskeleton_lib2.o test_subskeleton_lib.o t
 test_subskeleton_lib.skel.h-deps := test_subskeleton_lib2.o test_subskeleton_lib.o
 test_usdt.skel.h-deps := test_usdt.o test_usdt_multispec.o
 tracing_multi_fentry_test.skel.h-deps := tracing_multi_fentry.o tracing_multi_check.o
+tracing_multi_fexit_test.skel.h-deps := tracing_multi_fexit.o tracing_multi_check.o
 
 LINKED_BPF_SRCS := $(patsubst %.o,%.c,$(foreach skel,$(LINKED_SKELS),$($(skel)-deps)))
 
diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
index fbf2108ebb8a..b7b1e42754da 100644
--- a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
 #include "tracing_multi_fentry_test.skel.h"
+#include "tracing_multi_fexit_test.skel.h"
 #include "trace_helpers.h"
 
 static void multi_fentry_test(void)
@@ -27,8 +28,35 @@ static void multi_fentry_test(void)
 	tracing_multi_fentry_test__destroy(skel);
 }
 
+static void multi_fexit_test(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	struct tracing_multi_fexit_test *skel = NULL;
+	int err, prog_fd;
+
+	skel = tracing_multi_fexit_test__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "tracing_multi_fentry_test__open_and_load"))
+		goto cleanup;
+
+	err = tracing_multi_fexit_test__attach(skel);
+	if (!ASSERT_OK(err, "tracing_multi_fentry_test__attach"))
+		goto cleanup;
+
+	prog_fd = bpf_program__fd(skel->progs.test);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_run");
+
+	ASSERT_EQ(skel->bss->test_arg_result, 8, "test_arg_result");
+	ASSERT_EQ(skel->bss->test_ret_result, 8, "test_ret_result");
+
+cleanup:
+	tracing_multi_fexit_test__destroy(skel);
+}
+
 void test_tracing_multi_test(void)
 {
 	if (test__start_subtest("fentry"))
 		multi_fentry_test();
+	if (test__start_subtest("fexit"))
+		multi_fexit_test();
 }
diff --git a/tools/testing/selftests/bpf/progs/tracing_multi_check.c b/tools/testing/selftests/bpf/progs/tracing_multi_check.c
index 945dc4d070e1..7144df65607e 100644
--- a/tools/testing/selftests/bpf/progs/tracing_multi_check.c
+++ b/tools/testing/selftests/bpf/progs/tracing_multi_check.c
@@ -130,3 +130,29 @@ void multi_arg_check(__u64 *ctx, __u64 *test_result)
 		*test_result += 1;
 	}
 }
+
+void multi_ret_check(void *ctx, __u64 *test_result)
+{
+	void *ip = (void *) bpf_get_func_ip(ctx);
+	__u64 ret = 0;
+	int err;
+
+	if (bpf_get_func_ret(ctx, &ret))
+		return;
+	if (ip == &bpf_fentry_test1)
+		*test_result += ret == 2;
+	else if (ip == &bpf_fentry_test2)
+		*test_result += ret == 5;
+	else if (ip == &bpf_fentry_test3)
+		*test_result += ret == 15;
+	else if (ip == &bpf_fentry_test4)
+		*test_result += ret == 34;
+	else if (ip == &bpf_fentry_test5)
+		*test_result += ret == 65;
+	else if (ip == &bpf_fentry_test6)
+		*test_result += ret == 111;
+	else if (ip == &bpf_fentry_test7)
+		*test_result += ret == 0;
+	else if (ip == &bpf_fentry_test8)
+		*test_result += ret == 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/tracing_multi_fexit.c b/tools/testing/selftests/bpf/progs/tracing_multi_fexit.c
new file mode 100644
index 000000000000..54624acc7071
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tracing_multi_fexit.c
@@ -0,0 +1,20 @@
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
+__u64 test_arg_result = 0;
+__u64 test_ret_result = 0;
+
+SEC("fexit.multi/bpf_fentry_test*")
+int BPF_PROG(test)
+{
+	multi_arg_check(ctx, &test_arg_result);
+	multi_ret_check(ctx, &test_ret_result);
+	return 0;
+}
-- 
2.37.1

