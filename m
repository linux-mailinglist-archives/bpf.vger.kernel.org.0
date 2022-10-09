Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4341A5F8F53
	for <lists+bpf@lfdr.de>; Mon, 10 Oct 2022 00:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiJIWA7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 9 Oct 2022 18:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbiJIWA6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 9 Oct 2022 18:00:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970EF1D0F8
        for <bpf@vger.kernel.org>; Sun,  9 Oct 2022 15:00:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 54585B80D33
        for <bpf@vger.kernel.org>; Sun,  9 Oct 2022 22:00:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57EC7C433D6;
        Sun,  9 Oct 2022 22:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665352854;
        bh=iscNLVX3PM8di4MiFmvq3IcbTrhFxVQrjfucGTftyVQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cq5W2OzwZ6/ilKX5Lgno8mk7xd6qMquD1S6V+NmkJ7B+SjsgzLJVUPnbzcjHB9pFo
         J10zGRZLoJTYUa0HX9t2Njhs5RObAz8HXmsTPFA6XUFm1RSVC9qIM9NxHrqRw3KIPt
         V/QN9nOR/FVesV/AtrNa0V71uGiXEU2DlRGaPBN0ISR2TJ8EQxY4k41NTD3yddlDnH
         jjFeA0i0d9Q5uHuX/fKcC2KJyl2xQ2UYMOIEr0S6zVmtgHpgaHYrwIhSfnsFsPzF0b
         XP79xB4MDcNkVNb4kTI8YDQC1ZFBfZXoRvs6KV6gCOXtfKniD9I4W1jj9WhmTbSAKy
         uZB6GP2hiYWdw==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Christoph Hellwig <hch@lst.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Martynas Pumputis <m@lambda.lt>
Subject: [PATCH bpf-next 7/8] selftests/bpf: Add kprobe_multi kmod link api tests
Date:   Sun,  9 Oct 2022 23:59:25 +0200
Message-Id: <20221009215926.970164-8-jolsa@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221009215926.970164-1-jolsa@kernel.org>
References: <20221009215926.970164-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding kprobe_multi kmod link api tests that attach bpf_testmod
functions via kprobe_multi link API.

Running it as serial test, because we don't want other tests to
reload bpf_testmod while it's running.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../prog_tests/kprobe_multi_testmod_test.c    | 94 +++++++++++++++++++
 .../selftests/bpf/progs/kprobe_multi.c        | 51 ++++++++++
 2 files changed, 145 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/kprobe_multi_testmod_test.c

diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_testmod_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_testmod_test.c
new file mode 100644
index 000000000000..5fe02572650a
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_testmod_test.c
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include "kprobe_multi.skel.h"
+#include "trace_helpers.h"
+#include "bpf/libbpf_internal.h"
+
+static void kprobe_multi_testmod_check(struct kprobe_multi *skel)
+{
+	ASSERT_EQ(skel->bss->kprobe_testmod_test1_result, 1, "kprobe_test1_result");
+	ASSERT_EQ(skel->bss->kprobe_testmod_test2_result, 1, "kprobe_test2_result");
+	ASSERT_EQ(skel->bss->kprobe_testmod_test3_result, 1, "kprobe_test3_result");
+
+	ASSERT_EQ(skel->bss->kretprobe_testmod_test1_result, 1, "kretprobe_test1_result");
+	ASSERT_EQ(skel->bss->kretprobe_testmod_test2_result, 1, "kretprobe_test2_result");
+	ASSERT_EQ(skel->bss->kretprobe_testmod_test3_result, 1, "kretprobe_test3_result");
+}
+
+static void test_testmod_link_api(struct bpf_link_create_opts *opts)
+{
+	int prog_fd, link1_fd = -1, link2_fd = -1;
+	struct kprobe_multi *skel = NULL;
+
+	skel = kprobe_multi__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "fentry_raw_skel_load"))
+		goto cleanup;
+
+	skel->bss->pid = getpid();
+	prog_fd = bpf_program__fd(skel->progs.test_kprobe_testmod);
+	link1_fd = bpf_link_create(prog_fd, 0, BPF_TRACE_KPROBE_MULTI, opts);
+	if (!ASSERT_GE(link1_fd, 0, "link_fd1"))
+		goto cleanup;
+
+	opts->kprobe_multi.flags = BPF_F_KPROBE_MULTI_RETURN;
+	prog_fd = bpf_program__fd(skel->progs.test_kretprobe_testmod);
+	link2_fd = bpf_link_create(prog_fd, 0, BPF_TRACE_KPROBE_MULTI, opts);
+	if (!ASSERT_GE(link2_fd, 0, "link_fd2"))
+		goto cleanup;
+
+	ASSERT_OK(trigger_module_test_read(1), "trigger_read");
+	kprobe_multi_testmod_check(skel);
+
+cleanup:
+	if (link1_fd != -1)
+		close(link1_fd);
+	if (link2_fd != -1)
+		close(link2_fd);
+	kprobe_multi__destroy(skel);
+}
+
+#define GET_ADDR(__sym, __addr) ({					\
+	__addr = ksym_get_addr(__sym);					\
+	if (!ASSERT_NEQ(__addr, 0, "kallsyms load failed for " #__sym))	\
+		return;							\
+})
+
+static void test_testmod_link_api_addrs(void)
+{
+	LIBBPF_OPTS(bpf_link_create_opts, opts);
+	unsigned long long addrs[3];
+
+	GET_ADDR("bpf_testmod_fentry_test1", addrs[0]);
+	GET_ADDR("bpf_testmod_fentry_test2", addrs[1]);
+	GET_ADDR("bpf_testmod_fentry_test3", addrs[2]);
+
+	opts.kprobe_multi.addrs = (const unsigned long *) addrs;
+	opts.kprobe_multi.cnt = ARRAY_SIZE(addrs);
+
+	test_testmod_link_api(&opts);
+}
+
+static void test_testmod_link_api_syms(void)
+{
+	LIBBPF_OPTS(bpf_link_create_opts, opts);
+	const char *syms[3] = {
+		"bpf_testmod_fentry_test1",
+		"bpf_testmod_fentry_test2",
+		"bpf_testmod_fentry_test3",
+	};
+
+	opts.kprobe_multi.syms = syms;
+	opts.kprobe_multi.cnt = ARRAY_SIZE(syms);
+	test_testmod_link_api(&opts);
+}
+
+void serial_test_kprobe_multi_testmod_test(void)
+{
+	if (!ASSERT_OK(load_kallsyms_refresh(), "load_kallsyms_refresh"))
+		return;
+
+	if (test__start_subtest("testmod_link_api_syms"))
+		test_testmod_link_api_syms();
+	if (test__start_subtest("testmod_link_api_addrs"))
+		test_testmod_link_api_addrs();
+}
diff --git a/tools/testing/selftests/bpf/progs/kprobe_multi.c b/tools/testing/selftests/bpf/progs/kprobe_multi.c
index 98c3399e15c0..b3c54ec13a45 100644
--- a/tools/testing/selftests/bpf/progs/kprobe_multi.c
+++ b/tools/testing/selftests/bpf/progs/kprobe_multi.c
@@ -110,3 +110,54 @@ int test_kretprobe_manual(struct pt_regs *ctx)
 	kprobe_multi_check(ctx, true);
 	return 0;
 }
+
+extern const void bpf_testmod_fentry_test1 __ksym;
+extern const void bpf_testmod_fentry_test2 __ksym;
+extern const void bpf_testmod_fentry_test3 __ksym;
+
+__u64 kprobe_testmod_test1_result = 0;
+__u64 kprobe_testmod_test2_result = 0;
+__u64 kprobe_testmod_test3_result = 0;
+
+__u64 kretprobe_testmod_test1_result = 0;
+__u64 kretprobe_testmod_test2_result = 0;
+__u64 kretprobe_testmod_test3_result = 0;
+
+static void kprobe_multi_testmod_check(void *ctx, bool is_return)
+{
+	if (bpf_get_current_pid_tgid() >> 32 != pid)
+		return;
+
+	__u64 addr = bpf_get_func_ip(ctx);
+
+#define SET(__var, __addr) ({				\
+	if ((const void *) addr == __addr)		\
+		__var = 1;				\
+})
+
+	if (is_return) {
+		SET(kretprobe_testmod_test1_result, &bpf_testmod_fentry_test1);
+		SET(kretprobe_testmod_test2_result, &bpf_testmod_fentry_test2);
+		SET(kretprobe_testmod_test3_result, &bpf_testmod_fentry_test3);
+	} else {
+		SET(kprobe_testmod_test1_result, &bpf_testmod_fentry_test1);
+		SET(kprobe_testmod_test2_result, &bpf_testmod_fentry_test2);
+		SET(kprobe_testmod_test3_result, &bpf_testmod_fentry_test3);
+	}
+
+#undef SET
+}
+
+SEC("kprobe.multi")
+int test_kprobe_testmod(struct pt_regs *ctx)
+{
+	kprobe_multi_testmod_check(ctx, false);
+	return 0;
+}
+
+SEC("kretprobe.multi")
+int test_kretprobe_testmod(struct pt_regs *ctx)
+{
+	kprobe_multi_testmod_check(ctx, true);
+	return 0;
+}
-- 
2.37.3

