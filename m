Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 319B46ED216
	for <lists+bpf@lfdr.de>; Mon, 24 Apr 2023 18:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbjDXQIO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Apr 2023 12:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbjDXQIO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Apr 2023 12:08:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5214A6A6B
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 09:08:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E38E660C7A
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 16:08:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 899CBC4339E;
        Mon, 24 Apr 2023 16:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682352492;
        bh=DOqitYxEBJmzYF5oGx5UAJL4LhJhfOlSHLkMOOk4GB4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VMPUPF7lEYpEpf2gULsB+Rc8LUiC+s6DgOcwe6N7C+rLgYu6zRKPOpJ93DLkUU1h3
         QJGEzSMZKFWKqSwfV2ISm7oqUgIxWSYbfGVcsG7X/52IYgVLaFhyCUKhgkQmsE7vRK
         2OotoGapHUyeglLsnt6wMfSJ5oV2LsJ0NZC4CMZbY6XkBkXIKvi6MH+pTtOe0oz2+6
         SqzYd6p/rKilaUMdhn6j7YNh1R0iT80TKsHKJMcV3W4S/Mk1DpxS2nTGpLzWlgTTL5
         OU087Fip6z+3Kf31DhvRegJFErZnFHfUkXnzdYOJjoQVN66j8UM5pdvRW8FnSZWYSp
         t+rP2DH2sgeTg==
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
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [RFC/PATCH bpf-next 20/20] selftests/bpf: Add uprobe_multi cookie test
Date:   Mon, 24 Apr 2023 18:04:47 +0200
Message-Id: <20230424160447.2005755-21-jolsa@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230424160447.2005755-1-jolsa@kernel.org>
References: <20230424160447.2005755-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding test for cookies setup/retrieval in uprobe_link uprobes
and making sure bpf_get_attach_cookie works properly.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/bpf_cookie.c     | 78 +++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
index 26b2d1bffdfd..0e2d9ebe9258 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
@@ -11,6 +11,7 @@
 #include <bpf/btf.h>
 #include "test_bpf_cookie.skel.h"
 #include "kprobe_multi.skel.h"
+#include "uprobe_multi.skel.h"
 
 /* uprobe attach point */
 static noinline void trigger_func(void)
@@ -239,6 +240,81 @@ static void kprobe_multi_attach_api_subtest(void)
 	bpf_link__destroy(link1);
 	kprobe_multi__destroy(skel);
 }
+
+/* defined in prog_tests/uprobe_multi_test.c */
+void uprobe_multi_func_1(void);
+void uprobe_multi_func_2(void);
+void uprobe_multi_func_3(void);
+
+static void uprobe_multi_test_run(struct uprobe_multi *skel)
+{
+	skel->bss->uprobe_multi_func_1_addr = (u64) uprobe_multi_func_1;
+	skel->bss->uprobe_multi_func_2_addr = (u64) uprobe_multi_func_2;
+	skel->bss->uprobe_multi_func_3_addr = (u64) uprobe_multi_func_3;
+
+	skel->bss->pid = getpid();
+	skel->bss->test_cookie = true;
+
+	uprobe_multi_func_1();
+	uprobe_multi_func_2();
+	uprobe_multi_func_3();
+
+	ASSERT_EQ(skel->bss->uprobe_multi_func_1_result, 1, "uprobe_multi_func_1_result");
+	ASSERT_EQ(skel->bss->uprobe_multi_func_2_result, 1, "uprobe_multi_func_2_result");
+	ASSERT_EQ(skel->bss->uprobe_multi_func_3_result, 1, "uprobe_multi_func_3_result");
+
+	ASSERT_EQ(skel->bss->uretprobe_multi_func_1_result, 1, "uretprobe_multi_func_1_result");
+	ASSERT_EQ(skel->bss->uretprobe_multi_func_2_result, 1, "uretprobe_multi_func_2_result");
+	ASSERT_EQ(skel->bss->uretprobe_multi_func_3_result, 1, "uretprobe_multi_func_3_result");
+}
+
+static void uprobe_multi_attach_api_subtest(void)
+{
+	struct bpf_link *link1 = NULL, *link2 = NULL;
+	struct uprobe_multi *skel = NULL;
+	LIBBPF_OPTS(bpf_uprobe_multi_opts, opts);
+	const char *syms[3] = {
+		"uprobe_multi_func_1",
+		"uprobe_multi_func_2",
+		"uprobe_multi_func_3",
+	};
+	__u64 cookies[3];
+
+	cookies[0] = 3; /* uprobe_multi_func_1 */
+	cookies[1] = 1; /* uprobe_multi_func_2 */
+	cookies[2] = 2; /* uprobe_multi_func_3 */
+
+	opts.syms = syms;
+	opts.cnt = ARRAY_SIZE(syms);
+	opts.cookies = &cookies[0];
+
+	skel = uprobe_multi__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "uprobe_multi"))
+		goto cleanup;
+
+	link1 = bpf_program__attach_uprobe_multi_opts(skel->progs.test_uprobe,
+						      "/proc/self/exe", NULL, &opts);
+	if (!ASSERT_OK_PTR(link1, "bpf_program__attach_uprobe_multi_opts"))
+		goto cleanup;
+
+	cookies[0] = 2; /* uprobe_multi_func_1 */
+	cookies[1] = 3; /* uprobe_multi_func_2 */
+	cookies[2] = 1; /* uprobe_multi_func_3 */
+
+	opts.retprobe = true;
+	link2 = bpf_program__attach_uprobe_multi_opts(skel->progs.test_uretprobe,
+						      "/proc/self/exe", NULL, &opts);
+	if (!ASSERT_OK_PTR(link2, "bpf_program__attach_uprobe_multi_opts_retprobe"))
+		goto cleanup;
+
+	uprobe_multi_test_run(skel);
+
+cleanup:
+	bpf_link__destroy(link2);
+	bpf_link__destroy(link1);
+	uprobe_multi__destroy(skel);
+}
+
 static void uprobe_subtest(struct test_bpf_cookie *skel)
 {
 	DECLARE_LIBBPF_OPTS(bpf_uprobe_opts, opts);
@@ -515,6 +591,8 @@ void test_bpf_cookie(void)
 		kprobe_multi_attach_api_subtest();
 	if (test__start_subtest("uprobe"))
 		uprobe_subtest(skel);
+	if (test__start_subtest("multi_uprobe_attach_api"))
+		uprobe_multi_attach_api_subtest();
 	if (test__start_subtest("tracepoint"))
 		tp_subtest(skel);
 	if (test__start_subtest("perf_event"))
-- 
2.40.0

