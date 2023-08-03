Return-Path: <bpf+bounces-6818-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C55B976E1F8
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 09:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 018951C214A3
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 07:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1462E13AC6;
	Thu,  3 Aug 2023 07:38:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE179454
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 07:38:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8ABFC433C9;
	Thu,  3 Aug 2023 07:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691048298;
	bh=RsG0+eIJY13KgKfxG8/5H81hPP4PgtSkJieElCnqtRU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UbKj9d+VQ5yD3vr8tXbhQ1tLxBpV4EyzWUCtJNthHfkRilv0oJOz+JvqakcVzF+nN
	 lTyaNuj0ESJNe+UK7N5mC8rwA6kzafbWZj4QUzHCLn1YA4gffdIqv/AGlv7TGNVaae
	 rh3Y8ZQcuGaguf3bqYiyp9Fv0BQ3dLW5wgFNgJw8i63JEB3tP37XmATd3vkPcKZN85
	 MsxhrTEsl/dchvTfq8OnVxM2gYiVF5ktZBx9Vo/Xp/TjyfUX8E87Lj0Q3oMk/AspuI
	 ym6c9AE9yJv9hXSB0mktupVsFJtoz6iX2Nu3wKhsvXA27dc8f2xABdYT8TadpHv3Y/
	 t8GW952GMP52A==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCHv6 bpf-next 23/28] selftests/bpf: Add uprobe_multi bench test
Date: Thu,  3 Aug 2023 09:34:15 +0200
Message-ID: <20230803073420.1558613-24-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803073420.1558613-1-jolsa@kernel.org>
References: <20230803073420.1558613-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding test that attaches 50k uprobes in uprobe_multi binary.

After the attach is done we run the binary and make sure we
get proper amount of hits.

The resulting attach/detach times on my setup:

  test_bench_attach_uprobe:PASS:uprobe_multi__open 0 nsec
  test_bench_attach_uprobe:PASS:uprobe_multi__attach 0 nsec
  test_bench_attach_uprobe:PASS:uprobes_count 0 nsec
  test_bench_attach_uprobe: attached in   0.346s
  test_bench_attach_uprobe: detached in   0.419s
  #262/5   uprobe_multi_test/bench_uprobe:OK

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../bpf/prog_tests/uprobe_multi_test.c        | 40 +++++++++++++++++++
 .../selftests/bpf/progs/uprobe_multi_bench.c  | 15 +++++++
 2 files changed, 55 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_bench.c

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index 3860beda82c8..5fa555f4f68d 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -3,7 +3,9 @@
 #include <unistd.h>
 #include <test_progs.h>
 #include "uprobe_multi.skel.h"
+#include "uprobe_multi_bench.skel.h"
 #include "bpf/libbpf_internal.h"
+#include "testing_helpers.h"
 
 static char test_data[] = "test_data";
 
@@ -197,6 +199,42 @@ static void test_link_api(void)
 	free(offsets);
 }
 
+static void test_bench_attach_uprobe(void)
+{
+	long attach_start_ns = 0, attach_end_ns = 0;
+	struct uprobe_multi_bench *skel = NULL;
+	long detach_start_ns, detach_end_ns;
+	double attach_delta, detach_delta;
+	int err;
+
+	skel = uprobe_multi_bench__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "uprobe_multi_bench__open_and_load"))
+		goto cleanup;
+
+	attach_start_ns = get_time_ns();
+
+	err = uprobe_multi_bench__attach(skel);
+	if (!ASSERT_OK(err, "uprobe_multi_bench__attach"))
+		goto cleanup;
+
+	attach_end_ns = get_time_ns();
+
+	system("./uprobe_multi bench");
+
+	ASSERT_EQ(skel->bss->count, 50000, "uprobes_count");
+
+cleanup:
+	detach_start_ns = get_time_ns();
+	uprobe_multi_bench__destroy(skel);
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
@@ -207,4 +245,6 @@ void test_uprobe_multi_test(void)
 		test_attach_api_syms();
 	if (test__start_subtest("link_api"))
 		test_link_api();
+	if (test__start_subtest("bench_uprobe"))
+		test_bench_attach_uprobe();
 }
diff --git a/tools/testing/selftests/bpf/progs/uprobe_multi_bench.c b/tools/testing/selftests/bpf/progs/uprobe_multi_bench.c
new file mode 100644
index 000000000000..5367f6105e30
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/uprobe_multi_bench.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+int count;
+
+SEC("uprobe.multi/./uprobe_multi:uprobe_multi_func_*")
+int uprobe_bench(struct pt_regs *ctx)
+{
+	count++;
+	return 0;
+}
-- 
2.41.0


