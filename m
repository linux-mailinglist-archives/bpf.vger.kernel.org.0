Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2EBA6ED20F
	for <lists+bpf@lfdr.de>; Mon, 24 Apr 2023 18:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbjDXQH0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Apr 2023 12:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbjDXQHY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Apr 2023 12:07:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED0C6E8A
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 09:07:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DDDF261C12
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 16:07:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99994C433EF;
        Mon, 24 Apr 2023 16:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682352442;
        bh=bLHKTOni5LYedtoiKJFxrtlK2CwKBVTN1otv5L69Bi0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JnpPV0aXuY4buFBBKoUvHIk2WkyOgdpYTb2Fe0xEqA6+UGAUQEkto9hdygu2xdceE
         yBYIDcaSg1xJjWS8be6yGhpunCW1hfsqc8WAWX2nF35dZ37a9RC4XAosh9bAFho8/T
         EI8DrzQaFxc5N9QqOCJCDjHh+5nIXD5tzs061edCMqf6czWcmX0y0cbsHo0AmvUWIg
         /OnmAITygiVjiuwbLBSTGt8Yd3gY5U1+zPjRWUAFQC08zLTKE5lr9WHFgT59XpGGHl
         aYjrWh0AHDl0U/CrCdGBXg3rrR8njoRlGlLXuKrJsPGF70QY7jlNQn77K4ZNKebxLT
         QoEFSL7N9J0ew==
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
Subject: [RFC/PATCH bpf-next 15/20] selftests/bpf: Add uprobe_multi link test
Date:   Mon, 24 Apr 2023 18:04:42 +0200
Message-Id: <20230424160447.2005755-16-jolsa@kernel.org>
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

Adding uprobe_multi test for bpf_link_create attach function.

Testing attachment using the struct bpf_link_create_opts.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../bpf/prog_tests/uprobe_multi_test.c        | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index 179b78a4b711..abe620d844e7 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -110,6 +110,59 @@ static void test_attach_api_syms(void)
 	test_attach_api("/proc/self/exe", NULL, &opts);
 }
 
+void test_link_api(void)
+{
+	int prog_fd, link1_fd = -1, link2_fd = -1;
+	LIBBPF_OPTS(bpf_link_create_opts, opts);
+	struct uprobe_multi *skel = NULL;
+	unsigned long *offsets = NULL;
+	const char *syms[3] = {
+		"uprobe_multi_func_1",
+		"uprobe_multi_func_2",
+		"uprobe_multi_func_3",
+	};
+	const char *paths[3] = {
+		"/proc/self/exe",
+		"/proc/self/exe",
+		"/proc/self/exe",
+	};
+	int err;
+
+	err = elf_find_multi_func_offset(paths[0], 3, syms, (unsigned long **) &offsets);
+	if (!ASSERT_OK(err, "elf_find_multi_func_offset"))
+		return;
+
+	opts.uprobe_multi.paths = paths;
+	opts.uprobe_multi.offsets = offsets;
+	opts.uprobe_multi.cnt = ARRAY_SIZE(syms);
+
+	skel = uprobe_multi__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "uprobe_multi"))
+		goto cleanup;
+
+	prog_fd = bpf_program__fd(skel->progs.test_uprobe);
+	link1_fd = bpf_link_create(prog_fd, 0, BPF_TRACE_UPROBE_MULTI, &opts);
+	if (!ASSERT_GE(link1_fd, 0, "link_fd"))
+		goto cleanup;
+
+	opts.kprobe_multi.flags = BPF_F_UPROBE_MULTI_RETURN;
+	prog_fd = bpf_program__fd(skel->progs.test_uretprobe);
+	link2_fd = bpf_link_create(prog_fd, 0, BPF_TRACE_UPROBE_MULTI, &opts);
+	if (!ASSERT_GE(link2_fd, 0, "link_fd"))
+		goto cleanup;
+
+	uprobe_multi_test_run(skel);
+
+cleanup:
+	if (link1_fd != -1)
+		close(link1_fd);
+	if (link2_fd != -1)
+		close(link2_fd);
+
+	uprobe_multi__destroy(skel);
+	free(offsets);
+}
+
 void test_uprobe_multi_test(void)
 {
 	if (test__start_subtest("skel_api"))
@@ -118,4 +171,6 @@ void test_uprobe_multi_test(void)
 		test_attach_api_pattern();
 	if (test__start_subtest("attach_api_syms"))
 		test_attach_api_syms();
+	if (test__start_subtest("link_api"))
+		test_link_api();
 }
-- 
2.40.0

