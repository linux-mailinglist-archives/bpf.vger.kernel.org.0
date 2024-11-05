Return-Path: <bpf+bounces-44043-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F1B9BCE0B
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 14:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 029651F22B8D
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 13:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6EA1D9684;
	Tue,  5 Nov 2024 13:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omaE+UqN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7471D63C1;
	Tue,  5 Nov 2024 13:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730813758; cv=none; b=uJRK82hP27h5WDeVtI45bwy7Cui2OIgn3+iq7kQN1LrAIn4+qrvAJody9F4faTN9psMiUXDNFLHGr4aUwCQAmp4ubSzsLIH/efGPfk+Nj829fMOfAGygYyY32plTYLAA1yIF5mc3yoOIvwthCUFe9nDMJ2I4NFE/rzC2L6FfQEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730813758; c=relaxed/simple;
	bh=lKhoL/3wTEc44+r1qIMCHJuyUtca9Ay2cYmrQPDuSwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HBkzhmUfzRLZGnSpYlvSF+AvLIfBAgoH6q4Z1FzDiZVwHIKeAv1bxX3drf/UletLy1j9GwOM9Fw89hVl/Wu7KHW4Gq1Yn9KYjDfYWOIoN5NSTuxz0fhKFL1BCzu4+BbBCbxIgKw19atHChHKB1bVCg4pWkCMBktq/d3Tjr8Urj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omaE+UqN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C3E1C4CECF;
	Tue,  5 Nov 2024 13:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730813757;
	bh=lKhoL/3wTEc44+r1qIMCHJuyUtca9Ay2cYmrQPDuSwU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=omaE+UqNFhXFNNZlZsv4V/S9mywio1rd2CCn/oLBU+oBYlCZ0h5rQV52ElTgxZ4Gy
	 emTCxFCHj8avngEpayPTTM6Isfs4SRCYHXJO8E+tRVS6a8qN7fm48PNM3sJVPpr6em
	 IxRNhmZaS93rvy0cNWgH2lif1XPSqQ5aZ8cE7+3H5hDjNTqX/ZQk4L3rqDiDTzzcng
	 nZ8tQ6bCjDlNTGr13V7mAAmexJBLwiV4snpFWV7kDs19nCUTWrS8t9IQDPys89MYSi
	 A3VIFkwCwRvIN9wM4TgClc44B3vWZlY2QPHlqfjSrl0Zu+GDKHKwYnxPLYjWbBIUlY
	 aFIAPZH1AbSOw==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [RFC bpf-next 10/11] selftests/bpf: Add uprobe/usdt optimized test
Date: Tue,  5 Nov 2024 14:34:04 +0100
Message-ID: <20241105133405.2703607-11-jolsa@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241105133405.2703607-1-jolsa@kernel.org>
References: <20241105133405.2703607-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding tests for optimized uprobe/usdt probes.

Checking that we get expected trampoline and attached bpf programs
get executed properly.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../bpf/prog_tests/uprobe_optimized.c         | 192 ++++++++++++++++++
 .../selftests/bpf/progs/uprobe_optimized.c    |  29 +++
 2 files changed, 221 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/uprobe_optimized.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_optimized.c

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_optimized.c b/tools/testing/selftests/bpf/prog_tests/uprobe_optimized.c
new file mode 100644
index 000000000000..f6eb4089b1e2
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_optimized.c
@@ -0,0 +1,192 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+
+#ifdef __x86_64__
+
+#include "sdt.h"
+#include "uprobe_optimized.skel.h"
+
+#define TRAMP "[uprobes-trampoline]"
+
+__naked noinline void uprobe_test(void)
+{
+	asm volatile (".byte 0x0f, 0x1f, 0x44, 0x00, 0x00\n\t"
+		      "ret\n\t");
+}
+
+static int find_uprobes_trampoline(void **start, void **end)
+{
+	char line[128];
+	int ret = -1;
+	FILE *maps;
+
+	maps = fopen("/proc/self/maps", "r");
+	if (!maps) {
+		fprintf(stderr, "cannot open maps\n");
+		return -1;
+	}
+
+	while (fgets(line, sizeof(line), maps)) {
+		int m = -1;
+
+		/* We care only about private r-x mappings. */
+		if (sscanf(line, "%p-%p r-xp %*x %*x:%*x %*u %n", start, end, &m) != 2)
+			continue;
+		if (m < 0)
+			continue;
+		if (!strncmp(&line[m], TRAMP, sizeof(TRAMP)-1)) {
+			ret = 0;
+			break;
+		}
+	}
+
+	fclose(maps);
+	return ret;
+}
+
+static void check_attach(struct uprobe_optimized *skel, void (*trigger)(void))
+{
+	void *tramp_start, *tramp_end;
+	struct __arch_relative_insn {
+		u8 op;
+		s32 raddr;
+	} __packed *call;
+
+	unsigned long delta;
+
+	/* Uprobe gets optimized after first trigger, so let's press twice. */
+	trigger();
+	trigger();
+
+	if (!ASSERT_OK(find_uprobes_trampoline(&tramp_start, &tramp_end), "uprobes_trampoline"))
+		return;
+
+	/* Make sure bpf program got executed.. */
+	ASSERT_EQ(skel->bss->executed, 2, "executed");
+
+	/* .. and check the trampoline is as expected. */
+	call = (struct __arch_relative_insn *) trigger;
+
+	delta = tramp_start > (void *) trigger ?
+		tramp_start - (void *) trigger :
+		(void *) trigger - tramp_start;
+
+	/* and minus call instruction size itself */
+	delta -= 5;
+
+	ASSERT_EQ(call->op, 0xe8, "call");
+	ASSERT_EQ(call->raddr, delta, "delta");
+	ASSERT_EQ(tramp_end - tramp_start, 4096, "size");
+}
+
+static void check_detach(struct uprobe_optimized *skel, void (*trigger)(void))
+{
+	unsigned char nop5[5] = { 0x0f, 0x1f, 0x44, 0x00, 0x00 };
+	void *tramp_start, *tramp_end;
+
+	/* [uprobes_trampoline] stays after detach */
+	ASSERT_OK(find_uprobes_trampoline(&tramp_start, &tramp_end), "uprobes_trampoline");
+	ASSERT_OK(memcmp(trigger, nop5, 5), "nop5");
+}
+
+static void check(struct uprobe_optimized *skel, struct bpf_link *link,
+		  void (*trigger)(void))
+{
+	check_attach(skel, trigger);
+	bpf_link__destroy(link);
+	check_detach(skel, uprobe_test);
+}
+
+static void test_uprobe(void)
+{
+	struct uprobe_optimized *skel;
+	unsigned long offset;
+
+	skel = uprobe_optimized__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "uprobe_optimized__open_and_load"))
+		return;
+
+	offset = get_uprobe_offset(&uprobe_test);
+	if (!ASSERT_GE(offset, 0, "get_uprobe_offset"))
+		goto cleanup;
+
+	skel->links.test_1 = bpf_program__attach_uprobe_opts(skel->progs.test_1,
+					0, "/proc/self/exe", offset, NULL);
+	if (!ASSERT_OK_PTR(skel->links.test_1, "bpf_program__attach_uprobe_opts"))
+		goto cleanup;
+
+	check(skel, skel->links.test_1, uprobe_test);
+	skel->links.test_1 = NULL;
+
+cleanup:
+	uprobe_optimized__destroy(skel);
+}
+
+static void test_uprobe_multi(void)
+{
+	struct uprobe_optimized *skel;
+
+	skel = uprobe_optimized__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "uprobe_optimized__open_and_load"))
+		return;
+
+	skel->links.test_2 = bpf_program__attach_uprobe_multi(skel->progs.test_2,
+						0, "/proc/self/exe", "uprobe_test", NULL);
+	if (!ASSERT_OK_PTR(skel->links.test_2, "bpf_program__attach_uprobe_multi"))
+		goto cleanup;
+
+	check(skel, skel->links.test_2, uprobe_test);
+	skel->links.test_2 = NULL;
+
+cleanup:
+	uprobe_optimized__destroy(skel);
+}
+
+__naked noinline void usdt_test(void)
+{
+	STAP_PROBE(optimized_uprobe, usdt);
+	asm volatile ("ret\n");
+}
+
+static void test_usdt(void)
+{
+	struct uprobe_optimized *skel;
+
+	skel = uprobe_optimized__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "uprobe_optimized__open_and_load"))
+		return;
+
+	skel->links.test_3 = bpf_program__attach_usdt(skel->progs.test_3,
+						-1 /* all PIDs */, "/proc/self/exe",
+						"optimized_uprobe", "usdt", NULL);
+	if (!ASSERT_OK_PTR(skel->links.test_3, "bpf_program__attach_usdt"))
+		goto cleanup;
+
+	check(skel, skel->links.test_3, usdt_test);
+	skel->links.test_3 = NULL;
+
+cleanup:
+	uprobe_optimized__destroy(skel);
+}
+
+static void test_optimized(void)
+{
+	if (test__start_subtest("uprobe"))
+		test_uprobe();
+	if (test__start_subtest("uprobe_multi"))
+		test_uprobe_multi();
+	if (test__start_subtest("usdt"))
+		test_usdt();
+}
+#else
+static void test_optimized(void)
+{
+	test__skip();
+}
+#endif /* __x86_64__ */
+
+void test_uprobe_optimized(void)
+{
+	test_optimized();
+}
diff --git a/tools/testing/selftests/bpf/progs/uprobe_optimized.c b/tools/testing/selftests/bpf/progs/uprobe_optimized.c
new file mode 100644
index 000000000000..7f29c968b7c4
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/uprobe_optimized.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_tracing.h>
+#include <bpf/usdt.bpf.h>
+
+char _license[] SEC("license") = "GPL";
+int executed = 0;
+
+SEC("uprobe")
+int BPF_UPROBE(test_1)
+{
+	executed++;
+	return 0;
+}
+
+SEC("uprobe.multi")
+int BPF_UPROBE(test_2)
+{
+	executed++;
+	return 0;
+}
+
+SEC("usdt")
+int test_3(struct pt_regs *ctx)
+{
+	executed++;
+	return 0;
+}
-- 
2.47.0


