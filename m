Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA8C6ED214
	for <lists+bpf@lfdr.de>; Mon, 24 Apr 2023 18:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbjDXQIG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Apr 2023 12:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbjDXQIE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Apr 2023 12:08:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E90E6A6A
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 09:08:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F06C861B3C
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 16:08:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C3C3C433EF;
        Mon, 24 Apr 2023 16:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682352482;
        bh=jeRBYAPrZoVhm4oe2dQRln7UT1N8OBRKJkmPMI4mX/o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PHsU8zOZg3IiiFYPz07xsxiGthg6AqqV0UW8cOra6oO6iGM9pH8AhNMvEZ6mq94QC
         oo0rKBkRpOuHhJhm9hOFhGomxyNEvHnbYBTOxrnMVz71AiI4TrSrzKcBwabrxEF1zO
         KNdGTUpvZmml2lP1k7lDJQrAz/d2zgWQRcyQsi+RlJehHLoWCBQe6oMtB1MJzOA0C2
         YJUEit5ttfi6Lu56z+ZeUArnwnuVcqJSh950FcVJuzBXV3QuobEKkXdMr0lVNlwZHk
         J1vgeq8tvLkD78QtR6T+DBAmEr+TAVpEqCLN3USGA/iOGzciQsiOv25JlclXe83ms4
         MrBj5d1AO6nvQ==
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
Subject: [RFC/PATCH bpf-next 19/20] selftests/bpf: Add usdt_multi bench test
Date:   Mon, 24 Apr 2023 18:04:46 +0200
Message-Id: <20230424160447.2005755-20-jolsa@kernel.org>
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

Adding test that attaches 50k usdt probes in usdt_multi binary.

After the attach is done we run the binary and make sure we get
proper amount of hits.

With current uprobes:

  # perf stat --null ./test_progs -n 254/6
  #254/6   uprobe_multi_test/bench_usdt:OK
  #254     uprobe_multi_test:OK
  Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED

   Performance counter stats for './test_progs -n 254/6':

      1353.659680562 seconds time elapsed

With uprobe_multi link:

  # perf stat --null ./test_progs -n 254/6
  #254/6   uprobe_multi_test/bench_usdt:OK
  #254     uprobe_multi_test:OK
  Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED

   Performance counter stats for './test_progs -n 254/6':

         0.322046364 seconds time elapsed

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../bpf/prog_tests/uprobe_multi_test.c        | 54 +++++++++++++++++++
 .../selftests/bpf/progs/uprobe_multi_usdt.c   | 16 ++++++
 2 files changed, 70 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_usdt.c

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index 9a89c61359a1..ff08d4b8dbfe 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -3,6 +3,7 @@
 #include <unistd.h>
 #include <test_progs.h>
 #include "uprobe_multi.skel.h"
+#include "uprobe_multi_usdt.skel.h"
 
 noinline void uprobe_multi_func_1(void)
 {
@@ -217,6 +218,57 @@ void test_bench_attach_uprobe(void)
 	printf("%s: detached in %7.3lfs\n", __func__, detach_delta);
 }
 
+void test_bench_attach_usdt(void)
+{
+	struct uprobe_multi_usdt *skel = NULL;
+	long attach_start_ns, attach_end_ns;
+	long detach_start_ns, detach_end_ns;
+	double attach_delta, detach_delta;
+	LIBBPF_OPTS(bpf_usdt_opts, opts,
+		.uprobe_multi = true,
+	);
+	struct bpf_program *prog;
+	int err;
+
+	skel = uprobe_multi_usdt__open();
+	if (!ASSERT_OK_PTR(skel, "uprobe_multi__open"))
+		goto cleanup;
+
+	bpf_object__for_each_program(prog, skel->obj)
+		bpf_program__set_autoload(prog, false);
+
+	bpf_program__set_autoload(skel->progs.usdt0, true);
+	bpf_program__set_expected_attach_type(skel->progs.usdt0, BPF_TRACE_UPROBE_MULTI);
+
+	err = uprobe_multi_usdt__load(skel);
+	if (!ASSERT_EQ(err, 0, "strncmp_test load"))
+		goto cleanup;
+
+	attach_start_ns = get_time_ns();
+
+	skel->links.usdt0 = bpf_program__attach_usdt(skel->progs.usdt0, -1, "./usdt_multi",
+						     "test", "usdt", &opts);
+	if (!ASSERT_OK_PTR(skel->links.usdt0, "usdt_link"))
+		goto cleanup;
+
+	attach_end_ns = get_time_ns();
+
+	system("./usdt_multi");
+
+	ASSERT_EQ(skel->bss->count, 50000, "usdt_count");
+
+cleanup:
+	detach_start_ns = get_time_ns();
+	uprobe_multi_usdt__destroy(skel);
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
@@ -229,4 +281,6 @@ void test_uprobe_multi_test(void)
 		test_link_api();
 	if (test__start_subtest("bench_uprobe"))
 		test_bench_attach_uprobe();
+	if (test__start_subtest("bench_usdt"))
+		test_bench_attach_usdt();
 }
diff --git a/tools/testing/selftests/bpf/progs/uprobe_multi_usdt.c b/tools/testing/selftests/bpf/progs/uprobe_multi_usdt.c
new file mode 100644
index 000000000000..9e1c33d0bd2f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/uprobe_multi_usdt.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/usdt.bpf.h>
+
+char _license[] SEC("license") = "GPL";
+
+int count;
+
+SEC("usdt")
+int usdt0(struct pt_regs *ctx)
+{
+	count++;
+	return 0;
+}
-- 
2.40.0

