Return-Path: <bpf+bounces-7317-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E872E7755CF
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 10:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D8F91C2102C
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 08:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDC918C1B;
	Wed,  9 Aug 2023 08:39:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8276AAB
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 08:39:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9137C433C7;
	Wed,  9 Aug 2023 08:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691570340;
	bh=k2EST5fbOQhh0gdCgEkdv6WNdjO7jnERurmX2Izez+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GJyxgNswipQWsSdiKsK2qsdY44FNlw2oOdLxv3pfzJ5B0YLC78eLzXywMUxOZ0IT3
	 aExUI2wM8SDB/2wXoJR9nCs9P7BU+ubMZRc0J0fhAgAG4sK5fLoz9KEh21MLWZdsvl
	 8NUcEAO/WP7MspPT0H7BMX+d7KVYt+n/NW6st1IkeDrfc4STjClBgC8T8H6biCmOvy
	 i+FkfnRfIeTgxtomuZoli1K1zZsSVE2v+hWyvTFpdWbGD9cHMxUMfkZTX0pwIFRBbV
	 Ikre7Q7Qx9dU+hFGrbxHDJZsggtl+WF+dsWOasAJk9fBX0T5PrqArZq5/q2ypqrt0d
	 TrcmahPvf67yg==
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
Subject: [PATCHv7 bpf-next 25/28] selftests/bpf: Add uprobe_multi usdt bench test
Date: Wed,  9 Aug 2023 10:34:37 +0200
Message-ID: <20230809083440.3209381-26-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809083440.3209381-1-jolsa@kernel.org>
References: <20230809083440.3209381-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
 .../bpf/prog_tests/uprobe_multi_test.c        | 39 +++++++++++++++++++
 .../selftests/bpf/progs/uprobe_multi_usdt.c   | 16 ++++++++
 2 files changed, 55 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_usdt.c

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index 5fa555f4f68d..d7e30934feb9 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -4,6 +4,7 @@
 #include <test_progs.h>
 #include "uprobe_multi.skel.h"
 #include "uprobe_multi_bench.skel.h"
+#include "uprobe_multi_usdt.skel.h"
 #include "bpf/libbpf_internal.h"
 #include "testing_helpers.h"
 
@@ -235,6 +236,42 @@ static void test_bench_attach_uprobe(void)
 	printf("%s: detached in %7.3lfs\n", __func__, detach_delta);
 }
 
+static void test_bench_attach_usdt(void)
+{
+	long attach_start_ns = 0, attach_end_ns = 0;
+	struct uprobe_multi_usdt *skel = NULL;
+	long detach_start_ns, detach_end_ns;
+	double attach_delta, detach_delta;
+
+	skel = uprobe_multi_usdt__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "uprobe_multi__open"))
+		goto cleanup;
+
+	attach_start_ns = get_time_ns();
+
+	skel->links.usdt0 = bpf_program__attach_usdt(skel->progs.usdt0, -1, "./uprobe_multi",
+						     "test", "usdt", NULL);
+	if (!ASSERT_OK_PTR(skel->links.usdt0, "bpf_program__attach_usdt"))
+		goto cleanup;
+
+	attach_end_ns = get_time_ns();
+
+	system("./uprobe_multi usdt");
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
@@ -247,4 +284,6 @@ void test_uprobe_multi_test(void)
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
2.41.0


