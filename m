Return-Path: <bpf+bounces-33521-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F5891E5AC
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 18:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A86991C216D9
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 16:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56CF16DEC7;
	Mon,  1 Jul 2024 16:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0l2RFqt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5784C16DC21;
	Mon,  1 Jul 2024 16:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719852248; cv=none; b=cmEMQ8BIqog1IPFyd0mK80d23nBcoo2lvrP4vAk1+PdQiaqR0/d7ts+eYPjqCUJpFZ1Uj5r9ipQ3ZcvYHjOikGARvefmf3li14Jt1bZBkhh7f4Aohgd2Fx/nSNE3nrgOYxWtq0SyXA7JJ4nN0+5vw3BuujnlRHBhcAFBBrD8O0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719852248; c=relaxed/simple;
	bh=jCfeYzbsQH5gHSzmVaEYEvXxdC2wLU2zO//1JKdlqMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cN2+nQ3bx7Cb0KxbJXKSfF8qLOshz8kzPD0M2uhC0GsV1R1DHyU+3XzaoIO9AJmi3EF2Im4XTXaQqVKfoeDi9vT8QSS9w1OctyVnWJNmh1vpEdv4nXBiTGQ7H4uTswrOAYTBfAUuE9S8GNPmmPWl9dhTQZgJ5TD1VTcAJ3SCYlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0l2RFqt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5569C116B1;
	Mon,  1 Jul 2024 16:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719852247;
	bh=jCfeYzbsQH5gHSzmVaEYEvXxdC2wLU2zO//1JKdlqMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K0l2RFqtWN/aFN6px7+2ScwlEdOgYJ4hu+gGJTgWeHOmmmlbe5RvsdnNgwQeOFQUf
	 6rhX17TDZ6/pr74VpWxUZUuv4p5WhYH4tcwK3fsE1moDGmfimZA6s9LuU4A34pPV2J
	 q3CEyGdYWLK5ptRKvdAruM3/OHijmQ2uwRLQlGeXH/VFwwgFwsvxawl+ocLwGHfMh+
	 7/ZsOijRtW+/PuM+uXOhF0G6awlzHDRIiSxXhP8pKYOADnjLQbQL8e0WVOfxhu5hwA
	 7lZDrfkcZ4GZ70QqhBu1t4Q+pHTwnVHUU1zchAOqTHAz0NRyynHe99tWd4s+zDuFZG
	 D7/XK76f2UNdg==
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
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv2 bpf-next 9/9] selftests/bpf: Add uprobe session consumers test
Date: Mon,  1 Jul 2024 18:41:15 +0200
Message-ID: <20240701164115.723677-10-jolsa@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240701164115.723677-1-jolsa@kernel.org>
References: <20240701164115.723677-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding test that attached/detaches multiple consumers on
single uprobe and verifies all were hit as expected.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../bpf/prog_tests/uprobe_multi_test.c        | 203 ++++++++++++++++++
 .../progs/uprobe_multi_session_consumers.c    |  53 +++++
 2 files changed, 256 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_session_consumers.c

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index b521590fdbb9..83eac954cf00 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -9,6 +9,7 @@
 #include "uprobe_multi_session.skel.h"
 #include "uprobe_multi_session_cookie.skel.h"
 #include "uprobe_multi_session_recursive.skel.h"
+#include "uprobe_multi_session_consumers.skel.h"
 #include "bpf/libbpf_internal.h"
 #include "testing_helpers.h"
 #include "../sdt.h"
@@ -739,6 +740,206 @@ static void test_session_recursive_skel_api(void)
 	uprobe_multi_session_recursive__destroy(skel);
 }
 
+static int uprobe_attach(struct uprobe_multi_session_consumers *skel, int bit)
+{
+	struct bpf_program **prog = &skel->progs.uprobe_0 + bit;
+	struct bpf_link **link = &skel->links.uprobe_0 + bit;
+	LIBBPF_OPTS(bpf_uprobe_multi_opts, opts);
+
+	/*
+	 * bit: 0,1 uprobe session
+	 * bit: 2,3 uprobe entry
+	 * bit: 4,5 uprobe return
+	 */
+	opts.session = bit < 2;
+	opts.retprobe = bit == 4 || bit == 5;
+
+	*link = bpf_program__attach_uprobe_multi(*prog, 0, "/proc/self/exe",
+						 "uprobe_session_consumer_test",
+						 &opts);
+	if (!ASSERT_OK_PTR(*link, "bpf_program__attach_uprobe_multi"))
+		return -1;
+	return 0;
+}
+
+static void uprobe_detach(struct uprobe_multi_session_consumers *skel, int bit)
+{
+	struct bpf_link **link = &skel->links.uprobe_0 + bit;
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
+uprobe_session_consumer_test(struct uprobe_multi_session_consumers *skel,
+			     unsigned long before, unsigned long after)
+{
+	int bit;
+
+	/* detach uprobe for each unset bit in 'before' state ... */
+	for (bit = 0; bit < 6; bit++) {
+		if (test_bit(bit, before) && !test_bit(bit, after))
+			uprobe_detach(skel, bit);
+	}
+
+	/* ... and attach all new bits in 'after' state */
+	for (bit = 0; bit < 6; bit++) {
+		if (!test_bit(bit, before) && test_bit(bit, after)) {
+			if (!ASSERT_OK(uprobe_attach(skel, bit), "uprobe_attach_after"))
+				return -1;
+		}
+	}
+	return 0;
+}
+
+static void session_consumer_test(struct uprobe_multi_session_consumers *skel,
+				  unsigned long before, unsigned long after)
+{
+	int err, bit;
+
+	/* 'before' is each, we attach uprobe for every set bit */
+	for (bit = 0; bit < 6; bit++) {
+		if (test_bit(bit, before)) {
+			if (!ASSERT_OK(uprobe_attach(skel, bit), "uprobe_attach_before"))
+				goto cleanup;
+		}
+	}
+
+	err = uprobe_session_consumer_test(skel, before, after);
+	if (!ASSERT_EQ(err, 0, "uprobe_session_consumer_test"))
+		goto cleanup;
+
+	for (bit = 0; bit < 6; bit++) {
+		const char *fmt = "BUG";
+		__u64 val = 0;
+
+		if (bit == 0) {
+			/*
+			 * session with return
+			 *  +1 if defined in 'before'
+			 *  +1 if defined in 'after'
+			 */
+			if (test_bit(bit, before)) {
+				val++;
+				if (test_bit(bit, after))
+					val++;
+			}
+			fmt = "bit 0  : session with return";
+		} else if (bit == 1) {
+			/*
+			 * session without return
+			 *   +1 if defined in 'before'
+			 */
+			if (test_bit(bit, before))
+				val++;
+			fmt = "bit 1  : session with NO return";
+		} else if (bit < 4) {
+			/*
+			 * uprobe entry
+			 *   +1 if define in 'before'
+			 */
+			if (test_bit(bit, before))
+				val++;
+			fmt = "bit 3/4: uprobe";
+		} else {
+			/* uprobe return is tricky ;-)
+			 *
+			 * to trigger uretprobe consumer, the uretprobe needs to be installed,
+			 * which means one of the 'return' uprobes was alive when probe was hit:
+			 *
+			 *   bits: 0 (session with return) 4/5 uprobe return in 'installed' mask
+			 *
+			 * in addition if 'after' state removes everything that was installed in
+			 * 'before' state, then uprobe kernel object goes away and return uprobe
+			 * is not installed and we won't hit it even if it's in 'after' state.
+			 */
+			unsigned long installed = before & 0b110001; // is uretprobe installed
+			unsigned long exists    = before & after;    // did uprobe go away
+
+			if (installed && exists && test_bit(bit, after))
+				val++;
+			fmt = "bit 5/6: uretprobe";
+		}
+
+		ASSERT_EQ(skel->bss->uprobe_result[bit], val, fmt);
+		skel->bss->uprobe_result[bit] = 0;
+	}
+
+cleanup:
+	for (bit = 0; bit < 6; bit++) {
+		struct bpf_link **link = &skel->links.uprobe_0 + bit;
+
+		if (*link)
+			uprobe_detach(skel, bit);
+	}
+}
+
+static void test_session_consumers(void)
+{
+	struct uprobe_multi_session_consumers *skel;
+	int before, after;
+
+	skel = uprobe_multi_session_consumers__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "uprobe_multi_session_consumers__open_and_load"))
+		return;
+
+	/*
+	 * The idea of this test is to try all possible combinations of
+	 * uprobes consumers attached on single function.
+	 *
+	 *  - 1 uprobe session with return handler called
+	 *  - 1 uprobe session without return handler called
+	 *  - 2 uprobe entry consumer
+	 *  - 2 uprobe exit consumers
+	 *
+	 * The test uses 6 uprobes attached on single function, but that
+	 * translates into single uprobe with 6 consumers in kernel.
+	 *
+	 * The before/after values present the state of attached consumers
+	 * before and after the probed function:
+	 *
+	 *  bit 0   : uprobe session with return
+	 *  bit 1   : uprobe session with no return
+	 *  bit 2,3 : uprobe entry
+	 *  bit 4,5 : uprobe return
+	 *
+	 * For example for:
+	 *
+	 *   before = 0b10101
+	 *   after  = 0b00110
+	 *
+	 * it means that before we call 'uprobe_session_consumer_test' we
+	 * attach uprobes defined in 'before' value:
+	 *
+	 *   - bit 0: uprobe session with return
+	 *   - bit 2: uprobe entry
+	 *   - bit 4: uprobe return
+	 *
+	 * uprobe_session_consumer_test is called and inside it we attach
+	 * and detach * uprobes based on 'after' value:
+	 *
+	 *   - bit 0: uprobe session with return is detached
+	 *   - bit 1: uprobe session without return is attached
+	 *   - bit 2: stays untouched
+	 *   - bit 4: uprobe return is detached
+	 *
+	 * uprobe_session_consumer_test returs and we check counters values
+	 * increased by bpf programs on each uprobe to match the expected
+	 * count based on before/after bits.
+	 */
+	for (before = 0; before < 64; before++) {
+		for (after = 0; after < 64; after++)
+			session_consumer_test(skel, before, after);
+	}
+
+	uprobe_multi_session_consumers__destroy(skel);
+}
+
 static void test_bench_attach_uprobe(void)
 {
 	long attach_start_ns = 0, attach_end_ns = 0;
@@ -833,4 +1034,6 @@ void test_uprobe_multi_test(void)
 		test_session_cookie_skel_api();
 	if (test__start_subtest("session_cookie_recursive"))
 		test_session_recursive_skel_api();
+	if (test__start_subtest("session/consumers"))
+		test_session_consumers();
 }
diff --git a/tools/testing/selftests/bpf/progs/uprobe_multi_session_consumers.c b/tools/testing/selftests/bpf/progs/uprobe_multi_session_consumers.c
new file mode 100644
index 000000000000..035d31a0a7f8
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/uprobe_multi_session_consumers.c
@@ -0,0 +1,53 @@
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
+__u64 uprobe_result[6];
+
+SEC("uprobe.session")
+int uprobe_0(struct pt_regs *ctx)
+{
+	uprobe_result[0]++;
+	return 0;
+}
+
+SEC("uprobe.session")
+int uprobe_1(struct pt_regs *ctx)
+{
+	uprobe_result[1]++;
+	return 1;
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
+
+SEC("uprobe.multi")
+int uprobe_4(struct pt_regs *ctx)
+{
+	uprobe_result[4]++;
+	return 0;
+}
+
+SEC("uprobe.multi")
+int uprobe_5(struct pt_regs *ctx)
+{
+	uprobe_result[5]++;
+	return 0;
+}
-- 
2.45.2


