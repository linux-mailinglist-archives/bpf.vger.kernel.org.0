Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522366ED211
	for <lists+bpf@lfdr.de>; Mon, 24 Apr 2023 18:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbjDXQHp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Apr 2023 12:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbjDXQHo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Apr 2023 12:07:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B276E8A
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 09:07:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E962361BD1
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 16:07:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5A1C433D2;
        Mon, 24 Apr 2023 16:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682352462;
        bh=cVv/wzPlAy0jrt61MxpQKs4w2jYP0P8rHhJTbXwVcBE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b80RBupCThnNFnjQT34Y5Ih2BQA8cMKpqqPx0oLPSMvbjY1S/hsmlYho5AaG46BmW
         rZXN1XAMnWS3jUs6rfNz/2Z/2dfBqsheAmZ9EgXGx1N8YG74Ep/twtOHdv9pMxTK5f
         RmaNgml9e3XxxiyEQ+9iJ8b/Ea/NLwdEWudm9gRqFH97DBgb04sdCYZPfYa744lZQK
         +11nKSbEHPX/HOOHavpdfTMymkbXQZ1utvh23jeWK8clL2zxBZBVrmvi7h+apILFV/
         yeMoAgABLBnY/fts9HveuleVHBtRwyLPWVpgtYG2EczUoafBlGanm6VF4PCflWD38o
         U2sgLaFb3g6Yg==
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
Subject: [RFC/PATCH bpf-next 17/20] selftests/bpf: Add uprobe_multi bench test
Date:   Mon, 24 Apr 2023 18:04:44 +0200
Message-Id: <20230424160447.2005755-18-jolsa@kernel.org>
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

Adding test that attaches 50k uprobes in uprobe_multi binary.

After the attach is done we run the binary and make sure we
get proper amount of hits.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../bpf/prog_tests/uprobe_multi_test.c        | 56 +++++++++++++++++++
 .../selftests/bpf/progs/uprobe_multi.c        |  9 +++
 2 files changed, 65 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index abe620d844e7..9a89c61359a1 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -163,6 +163,60 @@ void test_link_api(void)
 	free(offsets);
 }
 
+static inline __u64 get_time_ns(void)
+{
+	struct timespec t;
+
+	clock_gettime(CLOCK_MONOTONIC, &t);
+	return (__u64) t.tv_sec * 1000000000 + t.tv_nsec;
+}
+
+void test_bench_attach_uprobe(void)
+{
+	long attach_start_ns, attach_end_ns;
+	long detach_start_ns, detach_end_ns;
+	double attach_delta, detach_delta;
+	struct uprobe_multi *skel = NULL;
+	struct bpf_program *prog;
+	int err;
+
+	skel = uprobe_multi__open();
+	if (!ASSERT_OK_PTR(skel, "uprobe_multi__open"))
+		goto cleanup;
+
+	bpf_object__for_each_program(prog, skel->obj)
+		bpf_program__set_autoload(prog, false);
+
+	bpf_program__set_autoload(skel->progs.test_uprobe_bench, true);
+
+	err = uprobe_multi__load(skel);
+	if (!ASSERT_EQ(err, 0, "strncmp_test load"))
+		goto cleanup;
+
+	attach_start_ns = get_time_ns();
+
+	err = uprobe_multi__attach(skel);
+	if (!ASSERT_OK(err, "uprobe_multi__attach"))
+		goto cleanup;
+
+	attach_end_ns = get_time_ns();
+
+	system("./uprobe_multi");
+
+	ASSERT_EQ(skel->bss->count, 50000, "uprobes_count");
+
+cleanup:
+	detach_start_ns = get_time_ns();
+	uprobe_multi__destroy(skel);
+	detach_end_ns = get_time_ns();
+
+	attach_delta = (attach_end_ns - attach_start_ns) / 1000000000.0;
+	detach_delta = (detach_end_ns - detach_start_ns) / 1000000000.0;
+
+	printf("%s: attached in %7.3lfs\n", __func__, attach_delta);
+	printf("%s: detached in %7.3lfs\n", __func__, detach_delta);
+}
+
 void test_uprobe_multi_test(void)
 {
 	if (test__start_subtest("skel_api"))
@@ -173,4 +227,6 @@ void test_uprobe_multi_test(void)
 		test_attach_api_syms();
 	if (test__start_subtest("link_api"))
 		test_link_api();
+	if (test__start_subtest("bench_uprobe"))
+		test_bench_attach_uprobe();
 }
diff --git a/tools/testing/selftests/bpf/progs/uprobe_multi.c b/tools/testing/selftests/bpf/progs/uprobe_multi.c
index a5dc00938217..126abd5aef89 100644
--- a/tools/testing/selftests/bpf/progs/uprobe_multi.c
+++ b/tools/testing/selftests/bpf/progs/uprobe_multi.c
@@ -61,3 +61,12 @@ int test_uretprobe(struct pt_regs *ctx)
 	uprobe_multi_check(ctx, true);
 	return 0;
 }
+
+int count;
+
+SEC("?uprobe.multi/./uprobe_multi:uprobe_multi_func_*")
+int test_uprobe_bench(struct pt_regs *ctx)
+{
+	count++;
+	return 0;
+}
-- 
2.40.0

