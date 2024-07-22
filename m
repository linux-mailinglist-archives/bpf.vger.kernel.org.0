Return-Path: <bpf+bounces-35270-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 743DD9394C3
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 22:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CC831C2178C
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 20:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE35288D1;
	Mon, 22 Jul 2024 20:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKkdScs0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC741C280
	for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 20:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721680107; cv=none; b=ogym20j13CmZYiAjxnGoPvdh0XSYKmFquA+QLtRgOOda/1g8855g7lS5o6RcDr1pIu496hEjg4SQZvI2eVHn2LxzMmejM1STOoHzahrzJyiEG37fXrf4ptkBXz62UL4AN19i7lqpkVlZg91abhBPTEyxg/+b6Dvy6EvvAGVZHng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721680107; c=relaxed/simple;
	bh=W/Dfn8fCoukDsbCA3xDqbtpj53CxKNB0/PhFM87OOG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OWSMlN78p07FdalSNocK193HWOhlbGQxM3sZJfKI32v/yddqlSgbnAj7f0fnjpTXPbEgBeQZcuFJogZtYATKHYhaM0t9IrAdC659T3iYg6OMarOZB9Fav2EXF7eP4AtTa6jkXq8VvP71Gf2bC3Ip6nI+JwDTNHAGAeenYiwnY4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKkdScs0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 252FCC116B1;
	Mon, 22 Jul 2024 20:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721680106;
	bh=W/Dfn8fCoukDsbCA3xDqbtpj53CxKNB0/PhFM87OOG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XKkdScs0/Upl27KE3hBAWr0BIJVuJ3znJusOy+UHLPkmrYNHfug91aX1iemBcCp0B
	 j6wuGrh9DnELImjL46/KH3k9VumeyzG+GolqP+XV6OqWPe6RUSKobpTaondbD+6c0v
	 0bZb8sb396uuB3vQ5rzRu3Cw1IOq+ZKknvBSeV/8+I14PutVYPa87CHw73TYaUyGew
	 JC/QYlgzDuNeBIUYMbY5qXEIjv4y0k/aWe2NZHspz4tQr5Ezp5wWzizWWTCUD/FHU3
	 U53BtAVs7hnH3a42TEgOaB2mhztontXQuAStrz9Jg1+0FWormLct986y0Tzv8mXe2V
	 z9VB/ezr6mQXg==
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
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCHv3 bpf-next 2/2] selftests/bpf: Add uprobe multi consumers test
Date: Mon, 22 Jul 2024 22:27:58 +0200
Message-ID: <20240722202758.3889061-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240722202758.3889061-1-jolsa@kernel.org>
References: <20240722202758.3889061-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding test that attaches/detaches multiple consumers on
single uprobe and verifies all were hit as expected.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../bpf/prog_tests/uprobe_multi_test.c        | 213 ++++++++++++++++++
 .../bpf/progs/uprobe_multi_consumers.c        |  39 ++++
 2 files changed, 252 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_consumers.c

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index e6255d4df81d..27708110ea20 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -6,6 +6,7 @@
 #include "uprobe_multi.skel.h"
 #include "uprobe_multi_bench.skel.h"
 #include "uprobe_multi_usdt.skel.h"
+#include "uprobe_multi_consumers.skel.h"
 #include "bpf/libbpf_internal.h"
 #include "testing_helpers.h"
 #include "../sdt.h"
@@ -731,6 +732,216 @@ static void test_link_api(void)
 	__test_link_api(child);
 }
 
+static struct bpf_program *
+get_program(struct uprobe_multi_consumers *skel, int prog)
+{
+	switch (prog) {
+	case 0:
+		return skel->progs.uprobe_0;
+	case 1:
+		return skel->progs.uprobe_1;
+	case 2:
+		return skel->progs.uprobe_2;
+	case 3:
+		return skel->progs.uprobe_3;
+	default:
+		ASSERT_FAIL("get_program");
+		return NULL;
+	}
+}
+
+static struct bpf_link **
+get_link(struct uprobe_multi_consumers *skel, int link)
+{
+	switch (link) {
+	case 0:
+		return &skel->links.uprobe_0;
+	case 1:
+		return &skel->links.uprobe_1;
+	case 2:
+		return &skel->links.uprobe_2;
+	case 3:
+		return &skel->links.uprobe_3;
+	default:
+		ASSERT_FAIL("get_link");
+		return NULL;
+	}
+}
+
+static int uprobe_attach(struct uprobe_multi_consumers *skel, int idx)
+{
+	struct bpf_program *prog = get_program(skel, idx);
+	struct bpf_link **link = get_link(skel, idx);
+	LIBBPF_OPTS(bpf_uprobe_multi_opts, opts);
+
+	if (!prog || !link)
+		return -1;
+
+	/*
+	 * bit/prog: 0,1 uprobe entry
+	 * bit/prog: 2,3 uprobe return
+	 */
+	opts.retprobe = idx == 2 || idx == 3;
+
+	*link = bpf_program__attach_uprobe_multi(prog, 0, "/proc/self/exe",
+						"uprobe_consumer_test",
+						&opts);
+	if (!ASSERT_OK_PTR(*link, "bpf_program__attach_uprobe_multi"))
+		return -1;
+	return 0;
+}
+
+static void uprobe_detach(struct uprobe_multi_consumers *skel, int idx)
+{
+	struct bpf_link **link = get_link(skel, idx);
+
+	bpf_link__destroy(*link);
+	*link = NULL;
+}
+
+static bool test_bit(int bit, unsigned long val)
+{
+	return val & (1 << bit);
+}
+
+noinline int
+uprobe_consumer_test(struct uprobe_multi_consumers *skel,
+		     unsigned long before, unsigned long after)
+{
+	int idx;
+
+	/* detach uprobe for each unset programs in 'before' state ... */
+	for (idx = 0; idx < 4; idx++) {
+		if (test_bit(idx, before) && !test_bit(idx, after))
+			uprobe_detach(skel, idx);
+	}
+
+	/* ... and attach all new programs in 'after' state */
+	for (idx = 0; idx < 4; idx++) {
+		if (!test_bit(idx, before) && test_bit(idx, after)) {
+			if (!ASSERT_OK(uprobe_attach(skel, idx), "uprobe_attach_after"))
+				return -1;
+		}
+	}
+	return 0;
+}
+
+static void consumer_test(struct uprobe_multi_consumers *skel,
+			  unsigned long before, unsigned long after)
+{
+	int err, idx;
+
+	printf("consumer_test before %lu after %lu\n", before, after);
+
+	/* 'before' is each, we attach uprobe for every set idx */
+	for (idx = 0; idx < 4; idx++) {
+		if (test_bit(idx, before)) {
+			if (!ASSERT_OK(uprobe_attach(skel, idx), "uprobe_attach_before"))
+				goto cleanup;
+		}
+	}
+
+	err = uprobe_consumer_test(skel, before, after);
+	if (!ASSERT_EQ(err, 0, "uprobe_consumer_test"))
+		goto cleanup;
+
+	for (idx = 0; idx < 4; idx++) {
+		const char *fmt = "BUG";
+		__u64 val = 0;
+
+		if (idx < 2) {
+			/*
+			 * uprobe entry
+			 *   +1 if define in 'before'
+			 */
+			if (test_bit(idx, before))
+				val++;
+			fmt = "prog 0/1: uprobe";
+		} else {
+			/*
+			 * uprobe return is tricky ;-)
+			 *
+			 * to trigger uretprobe consumer, the uretprobe needs to be installed,
+			 * which means one of the 'return' uprobes was alive when probe was hit:
+			 *
+			 *   idxs: 2/3 uprobe return in 'installed' mask
+			 *
+			 * in addition if 'after' state removes everything that was installed in
+			 * 'before' state, then uprobe kernel object goes away and return uprobe
+			 * is not installed and we won't hit it even if it's in 'after' state.
+			 */
+			unsigned long had_uretprobes  = before & 0b1100; // is uretprobe installed
+			unsigned long probe_preserved = before & after;  // did uprobe go away
+
+			if (had_uretprobes && probe_preserved && test_bit(idx, after))
+				val++;
+			fmt = "idx 2/3: uretprobe";
+		}
+
+		ASSERT_EQ(skel->bss->uprobe_result[idx], val, fmt);
+		skel->bss->uprobe_result[idx] = 0;
+	}
+
+cleanup:
+	for (idx = 0; idx < 4; idx++)
+		uprobe_detach(skel, idx);
+}
+
+static void test_consumers(void)
+{
+	struct uprobe_multi_consumers *skel;
+	int before, after;
+
+	skel = uprobe_multi_consumers__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "uprobe_multi_consumers__open_and_load"))
+		return;
+
+	/*
+	 * The idea of this test is to try all possible combinations of
+	 * uprobes consumers attached on single function.
+	 *
+	 *  - 2 uprobe entry consumer
+	 *  - 2 uprobe exit consumers
+	 *
+	 * The test uses 4 uprobes attached on single function, but that
+	 * translates into single uprobe with 4 consumers in kernel.
+	 *
+	 * The before/after values present the state of attached consumers
+	 * before and after the probed function:
+	 *
+	 *  bit/prog 0,1 : uprobe entry
+	 *  bit/prog 2,3 : uprobe return
+	 *
+	 * For example for:
+	 *
+	 *   before = 0b0101
+	 *   after  = 0b0110
+	 *
+	 * it means that before we call 'uprobe_consumer_test' we attach
+	 * uprobes defined in 'before' value:
+	 *
+	 *   - bit/prog 0: uprobe entry
+	 *   - bit/prog 2: uprobe return
+	 *
+	 * uprobe_consumer_test is called and inside it we attach and detach
+	 * uprobes based on 'after' value:
+	 *
+	 *   - bit/prog 0: stays untouched
+	 *   - bit/prog 2: uprobe return is detached
+	 *
+	 * uprobe_consumer_test returns and we check counters values increased
+	 * by bpf programs on each uprobe to match the expected count based on
+	 * before/after bits.
+	 */
+
+	for (before = 0; before < 16; before++) {
+		for (after = 0; after < 16; after++)
+			consumer_test(skel, before, after);
+	}
+
+	uprobe_multi_consumers__destroy(skel);
+}
+
 static void test_bench_attach_uprobe(void)
 {
 	long attach_start_ns = 0, attach_end_ns = 0;
@@ -821,4 +1032,6 @@ void test_uprobe_multi_test(void)
 		test_attach_api_fails();
 	if (test__start_subtest("attach_uprobe_fails"))
 		test_attach_uprobe_fails();
+	if (test__start_subtest("consumers"))
+		test_consumers();
 }
diff --git a/tools/testing/selftests/bpf/progs/uprobe_multi_consumers.c b/tools/testing/selftests/bpf/progs/uprobe_multi_consumers.c
new file mode 100644
index 000000000000..7e0fdcbbd242
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/uprobe_multi_consumers.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <stdbool.h>
+#include "bpf_kfuncs.h"
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+__u64 uprobe_result[4];
+
+SEC("uprobe.multi")
+int uprobe_0(struct pt_regs *ctx)
+{
+	uprobe_result[0]++;
+	return 0;
+}
+
+SEC("uprobe.multi")
+int uprobe_1(struct pt_regs *ctx)
+{
+	uprobe_result[1]++;
+	return 0;
+}
+
+SEC("uprobe.multi")
+int uprobe_2(struct pt_regs *ctx)
+{
+	uprobe_result[2]++;
+	return 0;
+}
+
+SEC("uprobe.multi")
+int uprobe_3(struct pt_regs *ctx)
+{
+	uprobe_result[3]++;
+	return 0;
+}
-- 
2.45.2


