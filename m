Return-Path: <bpf+bounces-40037-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B55F497AD34
	for <lists+bpf@lfdr.de>; Tue, 17 Sep 2024 10:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D03F283437
	for <lists+bpf@lfdr.de>; Tue, 17 Sep 2024 08:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20790160883;
	Tue, 17 Sep 2024 08:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ichzMza1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932EF158550;
	Tue, 17 Sep 2024 08:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726563202; cv=none; b=pucX2nVC1wnCorUFR6678W7T5MzqWAd+1AWSaBRhMIfDeL+LYstGtjx6IM0xVp2kOX61ZTuQDQGyNi4Bf5QBKUiHxvu3/Un97QNxD4z9V2tNjKziPCO6p+sIlnYyDDxvBviRhb1z2HsFtxxOvumP/MC9tKiHHOM1y9BeUTWvIXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726563202; c=relaxed/simple;
	bh=7A9EdOCx4qTXb70yo06M1I8B1//8v5dhcqxszDj04s4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qKz/yhdkgvkzK6Md0Nr8eAqTQz8l0S4GE345/cFVE/LBpV1di13UPHOtp7hmRFX3arsXF15YMk2m07czZxkwhPTnhdKo9/y93glCPhNS9LO32oaXfDe6lBlRDz+z/OF7om7S30l8SirajEmAbcM2yzavv5AmRv940FNfGbpnOaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ichzMza1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE37BC4CEC5;
	Tue, 17 Sep 2024 08:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726563202;
	bh=7A9EdOCx4qTXb70yo06M1I8B1//8v5dhcqxszDj04s4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ichzMza1gv5xa4YKI8apJxzftQFN1F+c8zALITGUBXsfUh4JTuP9hE0xFY8d+YRuO
	 5enrQiEzuvbl/lfetN+Vn8Y5IRsz56oSJF0NCu9FAzeuh+C3GkMoAaME7ZoUp+PKnb
	 z7D/JCrySOAB9YQ2cBKi0dA6uWU7iyLKfSQzNQjJ0S9Hn00+qg1KHXtimcfqMaFnzs
	 nW7mMCu4O4TkvFlCdECDEse2XOKp7lpVlqDPHMMgjUvnnC3Qg38pEuQJQKT0a+fafp
	 lHtu0fZ65EU0m2RpQSPo9btMlab14NymHx058wSRvRUrnoTxDuSRlmLSD3tWkmRPmn
	 tUzFw1VZqmEkA==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv4 14/14] selftests/bpf: Add consumers stress test on single uprobe
Date: Tue, 17 Sep 2024 10:50:24 +0200
Message-ID: <20240917085024.765883-15-jolsa@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240917085024.765883-1-jolsa@kernel.org>
References: <20240917085024.765883-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We create multiple threads each trying to attach and detach uprobe
consumers on the same uprobe, while main thread is hitting on that
uprobe. All that for 5 seconds.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../bpf/prog_tests/uprobe_multi_test.c        | 82 +++++++++++++++++++
 .../bpf/progs/uprobe_multi_consumer_stress.c  | 29 +++++++
 2 files changed, 111 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_consumer_stress.c

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index 594aa8c06f58..dcc128507212 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -3,6 +3,7 @@
 #include <unistd.h>
 #include <pthread.h>
 #include <test_progs.h>
+#include <time.h>
 #include "uprobe_multi.skel.h"
 #include "uprobe_multi_bench.skel.h"
 #include "uprobe_multi_usdt.skel.h"
@@ -10,6 +11,7 @@
 #include "uprobe_multi_session_single.skel.h"
 #include "uprobe_multi_session_cookie.skel.h"
 #include "uprobe_multi_session_recursive.skel.h"
+#include "uprobe_multi_consumer_stress.skel.h"
 #include "uprobe_multi_verifier.skel.h"
 #include "bpf/libbpf_internal.h"
 #include "testing_helpers.h"
@@ -848,6 +850,84 @@ static void test_bench_attach_usdt(void)
 	printf("%s: detached in %7.3lfs\n", __func__, detach_delta);
 }
 
+static int done;
+
+static void *worker(void *p)
+{
+	struct uprobe_multi_consumer_stress *skel = p;
+	struct bpf_link *link = NULL;
+
+	srand(time(NULL));
+
+	while (!done) {
+		LIBBPF_OPTS(bpf_uprobe_multi_opts, opts);
+		struct bpf_program *prog;
+
+		switch (rand() % 4) {
+		case 0:
+			prog = skel->progs.uprobe_session_0;
+			opts.session = true;
+			break;
+		case 1:
+			prog = skel->progs.uprobe_session_1;
+			opts.session = true;
+			break;
+		case 2:
+			prog = skel->progs.uprobe;
+			break;
+		case 3:
+			prog = skel->progs.uretprobe;
+			opts.retprobe = true;
+			break;
+		}
+
+		link = bpf_program__attach_uprobe_multi(prog, -1, "/proc/self/exe",
+							"uprobe_multi_func_1", &opts);
+		bpf_link__destroy(link);
+	}
+
+	return NULL;
+}
+
+#define THREAD_COUNT 4
+
+static void test_session_consumer_stress(void)
+{
+	struct uprobe_multi_consumer_stress *skel;
+	pthread_t threads[THREAD_COUNT];
+	time_t start;
+	int i, err;
+
+	/*
+	 * We create multiple threads each trying to attach and detach uprobe
+	 * consumer on the same uprobe, while main thread is hitting on that
+	 * uprobe. All that for 5 seconds.
+	 */
+	skel = uprobe_multi_consumer_stress__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "uprobe_multi_consumer_stress"))
+		goto cleanup;
+
+	for (i = 0; i < THREAD_COUNT; i++) {
+		err = pthread_create(threads + i, NULL, worker, skel);
+		if (!ASSERT_OK(err, "pthread_create"))
+			goto join;
+	}
+
+	start = time(NULL);
+
+	while (start + 5 > time(NULL))
+		uprobe_multi_func_1();
+
+	done = 1;
+
+join:
+	for (i = 0; i < THREAD_COUNT; i++)
+		pthread_join(threads[i], NULL);
+
+cleanup:
+	uprobe_multi_consumer_stress__destroy(skel);
+}
+
 void test_uprobe_multi_test(void)
 {
 	if (test__start_subtest("skel_api"))
@@ -872,5 +952,7 @@ void test_uprobe_multi_test(void)
 		test_session_cookie_skel_api();
 	if (test__start_subtest("session_cookie_recursive"))
 		test_session_recursive_skel_api();
+	if (test__start_subtest("consumer_stress"))
+		test_session_consumer_stress();
 	RUN_TESTS(uprobe_multi_verifier);
 }
diff --git a/tools/testing/selftests/bpf/progs/uprobe_multi_consumer_stress.c b/tools/testing/selftests/bpf/progs/uprobe_multi_consumer_stress.c
new file mode 100644
index 000000000000..5390108a21ff
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/uprobe_multi_consumer_stress.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+SEC("uprobe.session")
+int uprobe_session_0(struct pt_regs *ctx)
+{
+	return 0;
+}
+
+SEC("uprobe.session")
+int uprobe_session_1(struct pt_regs *ctx)
+{
+	return 1;
+}
+
+SEC("uprobe.multi")
+int uprobe(struct pt_regs *ctx)
+{
+	return 0;
+}
+
+SEC("uprobe.multi")
+int uretprobe(struct pt_regs *ctx)
+{
+	return 0;
+}
-- 
2.46.0


