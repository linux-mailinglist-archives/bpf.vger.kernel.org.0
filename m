Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E215660496B
	for <lists+bpf@lfdr.de>; Wed, 19 Oct 2022 16:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbiJSOie (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Oct 2022 10:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbiJSOiT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Oct 2022 10:38:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82401BBEC5
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 07:23:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 400C4617FE
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 13:58:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04439C433D6;
        Wed, 19 Oct 2022 13:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666187879;
        bh=Kkj9D2EVpJyjXSewGKANkdkqPmgJ5975/VZK1i9EliY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=igQz15+fUv+MLTrJNaDX9CyXDXgrAfLBrVOyPNoZJMno/9hY8m45e8xpgCyTtLEcZ
         dxcgtKEodpeghWzsQEoqbwhXVslxBvyl9ExArDl4GoATY9eknCw+PgC8GC8tB3vWPC
         DN5r+uFWqGXxxpHRrgXBuePoEq8Eoa1j0++NGNHeROBznG3x3aZ0kbh4E104UgByzN
         Iy1qPX4clnxgqxLxuHCeAR9fsKqfAkx3rtZu+KiOb1ynnGtlJWCDE/r++9ku83d7SK
         D3C9GCmrjwOpwleezbeG2lLvF5VKQ4enU5hcYn5Et6rrEr2r9DbUqKN9YqGgyH6/33
         XokOQVGE1QcMg==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Song Liu <song@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Christoph Hellwig <hch@lst.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Martynas Pumputis <m@lambda.lt>
Subject: [PATCHv2 bpf-next 8/8] selftests/bpf: Add kprobe_multi kmod attach api tests
Date:   Wed, 19 Oct 2022 15:56:21 +0200
Message-Id: <20221019135621.1480923-9-jolsa@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221019135621.1480923-1-jolsa@kernel.org>
References: <20221019135621.1480923-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding kprobe_multi kmod attach api tests that attach bpf_testmod
functions via bpf_program__attach_kprobe_multi_opts.

Running it as serial test, because we don't want other tests to
reload bpf_testmod while it's running.

Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../prog_tests/kprobe_multi_testmod_test.c    | 89 +++++++++++++++++++
 .../selftests/bpf/progs/kprobe_multi.c        | 50 +++++++++++
 2 files changed, 139 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/kprobe_multi_testmod_test.c

diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_testmod_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_testmod_test.c
new file mode 100644
index 000000000000..1fbe7e4ac00a
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_testmod_test.c
@@ -0,0 +1,89 @@
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
+static void test_testmod_attach_api(struct bpf_kprobe_multi_opts *opts)
+{
+	struct kprobe_multi *skel = NULL;
+
+	skel = kprobe_multi__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "fentry_raw_skel_load"))
+		return;
+
+	skel->bss->pid = getpid();
+
+	skel->links.test_kprobe_testmod = bpf_program__attach_kprobe_multi_opts(
+						skel->progs.test_kprobe_testmod,
+						NULL, opts);
+	if (!skel->links.test_kprobe_testmod)
+		goto cleanup;
+
+	opts->retprobe = true;
+	skel->links.test_kretprobe_testmod = bpf_program__attach_kprobe_multi_opts(
+						skel->progs.test_kretprobe_testmod,
+						NULL, opts);
+	if (!skel->links.test_kretprobe_testmod)
+		goto cleanup;
+
+	ASSERT_OK(trigger_module_test_read(1), "trigger_read");
+	kprobe_multi_testmod_check(skel);
+
+cleanup:
+	kprobe_multi__destroy(skel);
+}
+
+static void test_testmod_attach_api_addrs(void)
+{
+	LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
+	unsigned long long addrs[3];
+
+	addrs[0] = ksym_get_addr("bpf_testmod_fentry_test1");
+	ASSERT_NEQ(addrs[0], 0, "ksym_get_addr");
+	addrs[1] = ksym_get_addr("bpf_testmod_fentry_test2");
+	ASSERT_NEQ(addrs[1], 0, "ksym_get_addr");
+	addrs[2] = ksym_get_addr("bpf_testmod_fentry_test3");
+	ASSERT_NEQ(addrs[2], 0, "ksym_get_addr");
+
+	opts.addrs = (const unsigned long *) addrs;
+	opts.cnt = ARRAY_SIZE(addrs);
+
+	test_testmod_attach_api(&opts);
+}
+
+static void test_testmod_attach_api_syms(void)
+{
+	LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
+	const char *syms[3] = {
+		"bpf_testmod_fentry_test1",
+		"bpf_testmod_fentry_test2",
+		"bpf_testmod_fentry_test3",
+	};
+
+	opts.syms = syms;
+	opts.cnt = ARRAY_SIZE(syms);
+	test_testmod_attach_api(&opts);
+}
+
+void serial_test_kprobe_multi_testmod_test(void)
+{
+	if (!ASSERT_OK(load_kallsyms_refresh(), "load_kallsyms_refresh"))
+		return;
+
+	if (test__start_subtest("testmod_attach_api_syms"))
+		test_testmod_attach_api_syms();
+	if (test__start_subtest("testmod_attach_api_addrs"))
+		test_testmod_attach_api_addrs();
+}
diff --git a/tools/testing/selftests/bpf/progs/kprobe_multi.c b/tools/testing/selftests/bpf/progs/kprobe_multi.c
index 98c3399e15c0..9e1ca8e34913 100644
--- a/tools/testing/selftests/bpf/progs/kprobe_multi.c
+++ b/tools/testing/selftests/bpf/progs/kprobe_multi.c
@@ -110,3 +110,53 @@ int test_kretprobe_manual(struct pt_regs *ctx)
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
+	if (is_return) {
+		if ((const void *) addr == &bpf_testmod_fentry_test1)
+			kretprobe_testmod_test1_result = 1;
+		if ((const void *) addr == &bpf_testmod_fentry_test2)
+			kretprobe_testmod_test2_result = 1;
+		if ((const void *) addr == &bpf_testmod_fentry_test3)
+			kretprobe_testmod_test3_result = 1;
+	} else {
+		if ((const void *) addr == &bpf_testmod_fentry_test1)
+			kprobe_testmod_test1_result = 1;
+		if ((const void *) addr == &bpf_testmod_fentry_test2)
+			kprobe_testmod_test2_result = 1;
+		if ((const void *) addr == &bpf_testmod_fentry_test3)
+			kprobe_testmod_test3_result = 1;
+	}
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

