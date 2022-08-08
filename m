Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93EE858CA2D
	for <lists+bpf@lfdr.de>; Mon,  8 Aug 2022 16:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235719AbiHHOJO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 10:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242984AbiHHOJN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 10:09:13 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C7FDFC6
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 07:09:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C340CCE10CC
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 14:09:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE089C433D6;
        Mon,  8 Aug 2022 14:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659967748;
        bh=da56i1Vsz6n9IyT+bK6JKfWXGfNEiQX9+ckdJNYV52w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BIARH5eCUBj7xPnHFdlcZysaBCUO/EHP8zTZnz+PFZgMr41CDTC5XnQa6p8n5OAiV
         FuXAcGXHKOcVzAxZCLG71n+O9VUm7zVgqBaYb4IRPdlzzwApy+57I2SWDn1+kXP3IH
         CVczeNeFvxjzt+x2KxsaQOX3TSN+RqFGyjta+aUC9xh+vf17KOuK+qQKa8H/pqgxts
         VxFG54fXBIeB2k+8QSW9lZQgH/vS3TYGveGyl2mw+32netJhLBBmztCy0aWipWQ2CH
         jUAAxlBLmMKPSVewjzvlhMyWa73fUCsnYUm1myldwoQ3XpvLVOwRfqjL5fz8PgG9FS
         M/rWsC8qoVpCQ==
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
Subject: [RFC PATCH bpf-next 14/17] selftests/bpf: Add fentry tracing multi func test
Date:   Mon,  8 Aug 2022 16:06:23 +0200
Message-Id: <20220808140626.422731-15-jolsa@kernel.org>
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

Adding selftest for fentry multi func test that attaches
to bpf_fentry_test* functions and checks argument values
based on the processed function.

We need to cast to real arguments types in multi_arg_check,
because the checked value can be shorter than u64.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/Makefile          |   3 +-
 .../selftests/bpf/prog_tests/tracing_multi.c  |  34 +++++
 .../selftests/bpf/progs/tracing_multi_check.c | 132 ++++++++++++++++++
 .../bpf/progs/tracing_multi_fentry.c          |  17 +++
 4 files changed, 185 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tracing_multi.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_check.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_fentry.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 8d59ec7f4c2d..24f0ace18af2 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -348,7 +348,7 @@ SKEL_BLACKLIST := btf__% test_pinning_invalid.c test_sk_assign.c
 LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h		\
 		linked_vars.skel.h linked_maps.skel.h 			\
 		test_subskeleton.skel.h test_subskeleton_lib.skel.h	\
-		test_usdt.skel.h
+		test_usdt.skel.h tracing_multi_fentry_test.skel.h
 
 LSKELS := kfunc_call_test.c fentry_test.c fexit_test.c fexit_sleep.c \
 	test_ringbuf.c atomics.c trace_printk.c trace_vprintk.c \
@@ -366,6 +366,7 @@ linked_maps.skel.h-deps := linked_maps1.o linked_maps2.o
 test_subskeleton.skel.h-deps := test_subskeleton_lib2.o test_subskeleton_lib.o test_subskeleton.o
 test_subskeleton_lib.skel.h-deps := test_subskeleton_lib2.o test_subskeleton_lib.o
 test_usdt.skel.h-deps := test_usdt.o test_usdt_multispec.o
+tracing_multi_fentry_test.skel.h-deps := tracing_multi_fentry.o tracing_multi_check.o
 
 LINKED_BPF_SRCS := $(patsubst %.o,%.c,$(foreach skel,$(LINKED_SKELS),$($(skel)-deps)))
 
diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
new file mode 100644
index 000000000000..fbf2108ebb8a
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include "tracing_multi_fentry_test.skel.h"
+#include "trace_helpers.h"
+
+static void multi_fentry_test(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	struct tracing_multi_fentry_test *skel = NULL;
+	int err, prog_fd;
+
+	skel = tracing_multi_fentry_test__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "fentry_multi_skel_load"))
+		goto cleanup;
+
+	err = tracing_multi_fentry_test__attach(skel);
+	if (!ASSERT_OK(err, "fentry_attach"))
+		goto cleanup;
+
+	prog_fd = bpf_program__fd(skel->progs.test);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_run");
+
+	ASSERT_EQ(skel->bss->test_result, 8, "test_result");
+
+cleanup:
+	tracing_multi_fentry_test__destroy(skel);
+}
+
+void test_tracing_multi_test(void)
+{
+	if (test__start_subtest("fentry"))
+		multi_fentry_test();
+}
diff --git a/tools/testing/selftests/bpf/progs/tracing_multi_check.c b/tools/testing/selftests/bpf/progs/tracing_multi_check.c
new file mode 100644
index 000000000000..945dc4d070e1
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tracing_multi_check.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+extern const void bpf_fentry_test1 __ksym;
+extern const void bpf_fentry_test2 __ksym;
+extern const void bpf_fentry_test3 __ksym;
+extern const void bpf_fentry_test4 __ksym;
+extern const void bpf_fentry_test5 __ksym;
+extern const void bpf_fentry_test6 __ksym;
+extern const void bpf_fentry_test7 __ksym;
+extern const void bpf_fentry_test8 __ksym;
+
+void multi_arg_check(__u64 *ctx, __u64 *test_result)
+{
+	void *ip = (void *) bpf_get_func_ip(ctx);
+	__u64 value = 0;
+
+	if (ip == &bpf_fentry_test1) {
+		int a;
+
+		if (bpf_get_func_arg(ctx, 0, &value))
+			return;
+		a = (int) value;
+
+		*test_result += a == 1;
+	} else if (ip == &bpf_fentry_test2) {
+		__u64 b;
+		int a;
+
+		if (bpf_get_func_arg(ctx, 0, &value))
+			return;
+		a = (int) value;
+		if (bpf_get_func_arg(ctx, 1, &value))
+			return;
+		b = value;
+
+		*test_result += a == 2 && b == 3;
+	} else if (ip == &bpf_fentry_test3) {
+		char a, b;
+		__u64 c;
+
+		if (bpf_get_func_arg(ctx, 0, &value))
+			return;
+		a = (int) value;
+		if (bpf_get_func_arg(ctx, 1, &value))
+			return;
+		b = (int) value;
+		if (bpf_get_func_arg(ctx, 2, &value))
+			return;
+		c = value;
+
+		*test_result += a == 4 && b == 5 && c == 6;
+	} else if (ip == &bpf_fentry_test4) {
+		void *a;
+		char b;
+		int c;
+		__u64 d;
+
+		if (bpf_get_func_arg(ctx, 0, &value))
+			return;
+		a = (void *) value;
+		if (bpf_get_func_arg(ctx, 1, &value))
+			return;
+		b = (char) value;
+		if (bpf_get_func_arg(ctx, 2, &value))
+			return;
+		c = (int) value;
+		if (bpf_get_func_arg(ctx, 3, &value))
+			return;
+		d = value;
+
+		*test_result += a == (void *) 7 && b == 8 && c == 9 && d == 10;
+	} else if (ip == &bpf_fentry_test5) {
+		__u64 a;
+		void *b;
+		short c;
+		int d;
+		__u64 e;
+
+		if (bpf_get_func_arg(ctx, 0, &value))
+			return;
+		a = value;
+		if (bpf_get_func_arg(ctx, 1, &value))
+			return;
+		b = (void *) value;
+		if (bpf_get_func_arg(ctx, 2, &value))
+			return;
+		c = (short) value;
+		if (bpf_get_func_arg(ctx, 3, &value))
+			return;
+		d = (int) value;
+		if (bpf_get_func_arg(ctx, 4, &value))
+			return;
+		e = value;
+
+		*test_result += a == 11 && b == (void *) 12 && c == 13 && d == 14 && e == 15;
+	} else if (ip == &bpf_fentry_test6) {
+		__u64 a;
+		void *b;
+		short c;
+		int d;
+		void *e;
+		__u64 f;
+
+		if (bpf_get_func_arg(ctx, 0, &value))
+			return;
+		a = value;
+		if (bpf_get_func_arg(ctx, 1, &value))
+			return;
+		b = (void *) value;
+		if (bpf_get_func_arg(ctx, 2, &value))
+			return;
+		c = (short) value;
+		if (bpf_get_func_arg(ctx, 3, &value))
+			return;
+		d = (int) value;
+		if (bpf_get_func_arg(ctx, 4, &value))
+			return;
+		e = (void *) value;
+		if (bpf_get_func_arg(ctx, 5, &value))
+			return;
+		f = value;
+
+		*test_result += a == 16 && b == (void *) 17 && c == 18 && d == 19 && e == (void *) 20 && f == 21;
+	} else if (ip == &bpf_fentry_test7) {
+		*test_result += 1;
+	} else if (ip == &bpf_fentry_test8) {
+		*test_result += 1;
+	}
+}
diff --git a/tools/testing/selftests/bpf/progs/tracing_multi_fentry.c b/tools/testing/selftests/bpf/progs/tracing_multi_fentry.c
new file mode 100644
index 000000000000..b78d36772aa6
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tracing_multi_fentry.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+__u64 test_result = 0;
+
+__hidden extern void multi_arg_check(__u64 *ctx, __u64 *test_result);
+
+SEC("fentry.multi/bpf_fentry_test*")
+int BPF_PROG(test, __u64 a, __u64 b, __u64 c, __u64 d, __u64 e, __u64 f)
+{
+	multi_arg_check(ctx, &test_result);
+	return 0;
+}
-- 
2.37.1

