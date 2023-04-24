Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35FBE6ED20E
	for <lists+bpf@lfdr.de>; Mon, 24 Apr 2023 18:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbjDXQHT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Apr 2023 12:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbjDXQHS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Apr 2023 12:07:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778EC4C2E
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 09:07:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1321061C12
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 16:07:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD64C4339E;
        Mon, 24 Apr 2023 16:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682352432;
        bh=Yua+mSx3jhG2H/ndNz/mXoRUf/3XrDIomHGmvzz0K44=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nV1oU4aeCBaifn7uNKNTvXgQgWSHzfMyl51eBBWt9A960DBKV+sulc8CrAZMyjDkG
         2M9NGrqCI9kdLYMAjfLTyHGWHi4BHmBP3HZ+6VAoWJf+Jc4xuDsVzqByhHrny1v2ug
         Mn9C/h01Dw+5MLz+OCnrcvcdptbtD5SV8uvpzAYpiSeBdXh5uhRrF4mTavH9noOKbE
         7kNQ/qTAxDJZD+1gYud4SGivN6a8pefwOhmltQ6/sEe2aKcE0rBqwekMMnZ5qj+wRH
         Yw8jOHqKvlgyowF7F+/WKgNg3pZUV8Cu6uAR3H6PqfFdJ5NtsQ64IuBErGRlXOVL3I
         reoQWezGiAb0A==
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
Subject: [RFC/PATCH bpf-next 14/20] selftests/bpf: Add uprobe_multi api test
Date:   Mon, 24 Apr 2023 18:04:41 +0200
Message-Id: <20230424160447.2005755-15-jolsa@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230424160447.2005755-1-jolsa@kernel.org>
References: <20230424160447.2005755-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding uprobe_multi test for bpf_program__attach_uprobe_multi_opts
attach function.

Testing attachment using glob patterns and via bpf_uprobe_multi_opts
paths/syms fields.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../bpf/prog_tests/uprobe_multi_test.c        | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index f68cda122ac2..179b78a4b711 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -59,8 +59,63 @@ static void test_skel_api(void)
 	uprobe_multi__destroy(skel);
 }
 
+static void
+test_attach_api(const char *binary, const char *pattern, struct bpf_uprobe_multi_opts *opts)
+{
+	struct bpf_link *link1 = NULL, *link2 = NULL;
+	struct uprobe_multi *skel = NULL;
+
+	skel = uprobe_multi__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "uprobe_multi"))
+		goto cleanup;
+
+	link1 = bpf_program__attach_uprobe_multi_opts(skel->progs.test_uprobe,
+						      binary, pattern, opts);
+	if (!ASSERT_OK_PTR(link1, "bpf_program__attach_uprobe_multi_opts"))
+		goto cleanup;
+
+	opts->retprobe = true;
+	link2 = bpf_program__attach_uprobe_multi_opts(skel->progs.test_uretprobe,
+						      binary, pattern, opts);
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
+static void test_attach_api_pattern(void)
+{
+	LIBBPF_OPTS(bpf_uprobe_multi_opts, opts);
+
+	test_attach_api("/proc/self/exe", "uprobe_multi_func_*", &opts);
+	test_attach_api("/proc/self/exe", "uprobe_multi_func_?", &opts);
+}
+
+static void test_attach_api_syms(void)
+{
+	LIBBPF_OPTS(bpf_uprobe_multi_opts, opts);
+	const char *syms[3] = {
+		"uprobe_multi_func_1",
+		"uprobe_multi_func_2",
+		"uprobe_multi_func_3",
+	};
+
+	opts.syms = syms;
+	opts.cnt = ARRAY_SIZE(syms);
+	test_attach_api("/proc/self/exe", NULL, &opts);
+}
+
 void test_uprobe_multi_test(void)
 {
 	if (test__start_subtest("skel_api"))
 		test_skel_api();
+	if (test__start_subtest("attach_api_pattern"))
+		test_attach_api_pattern();
+	if (test__start_subtest("attach_api_syms"))
+		test_attach_api_syms();
 }
-- 
2.40.0

