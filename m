Return-Path: <bpf+bounces-68562-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F3DB5A451
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 23:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D617174F0A
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 21:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F16323F42;
	Tue, 16 Sep 2025 21:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DC3qlbM5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB38831FECA;
	Tue, 16 Sep 2025 21:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758059653; cv=none; b=kQjTtHvRN2W6T1y5nCl3y6ICXU068BzdIoeTtFsOtlQ0S5IVV4TgHqfcJ9DI80QZccZsC+TCuey8+O+ocyD93PzZjWn8+T6TX4yLHkgaSlNKd+56ugrQTQjnkYjUpfDb5QHR02eVD1o0PiExkmzk5iIeEIktoSipaJZXPqxJZHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758059653; c=relaxed/simple;
	bh=3FUoyGo6gpe1EDiqzFebiGwDkOSbbFfT+w5WR8teloU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L9+tUjWhcrCYZdjEr7bKacuE7S9ylRx45OrZsll8wc3k9R57rY2WJ6GbkDq+c8pZptAhaf2OcHZBm4v7z9ABuB/hlmSXAtmPO4eQP91iTzKDnrVVied7hJXlPmdMPrAK0GrigMEnrF2imLIfZ0KVg2i/5EyiACxFpK3jjKmVUKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DC3qlbM5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A35F6C4CEEB;
	Tue, 16 Sep 2025 21:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758059651;
	bh=3FUoyGo6gpe1EDiqzFebiGwDkOSbbFfT+w5WR8teloU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DC3qlbM5hL4Cjs5ASWpcK0XIWYJwfLMHr4smL270DuHLoRX1PVKlg9fEv+M2Erkev
	 VdnCFHnpl2B6qdHDvC4LTNCErVzDMm+QZOzD5rlDR2A9bmRyGODdSuy5MI1ipxAEQw
	 MzfkcvQSx9eYSKAuNBX4z2cZrOmsjejgqXYc06gVR70b+uufPBog8+yJ6amxRtcWZ+
	 A+R1fGBuX4S6Iciw2f+IoOKvWZOMWsQcNdslnAmGEaHd05WGasOFRfmsk3I3moDPuv
	 08uBYafVlx6fnsORDhD4OAhBD7p4inoiKH9g2YA31V5Vb6Zup6LXwXW5AxJ24HeJNT
	 mWOpX91VYWv+w==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCHv4 bpf-next 5/6] selftests/bpf: Add kprobe write ctx attach test
Date: Tue, 16 Sep 2025 23:53:00 +0200
Message-ID: <20250916215301.664963-6-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916215301.664963-1-jolsa@kernel.org>
References: <20250916215301.664963-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding test to check we can't attach standard kprobe program that
writes to the context.

It's x86_64 specific test.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/attach_probe.c   | 28 +++++++++++++++++++
 .../selftests/bpf/progs/kprobe_write_ctx.c    | 15 ++++++++++
 2 files changed, 43 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/kprobe_write_ctx.c

diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
index cabc51c2ca6b..9e77e5da7097 100644
--- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
+++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
@@ -3,6 +3,7 @@
 #include "test_attach_kprobe_sleepable.skel.h"
 #include "test_attach_probe_manual.skel.h"
 #include "test_attach_probe.skel.h"
+#include "kprobe_write_ctx.skel.h"
 
 /* this is how USDT semaphore is actually defined, except volatile modifier */
 volatile unsigned short uprobe_ref_ctr __attribute__((unused)) __attribute((section(".probes")));
@@ -201,6 +202,31 @@ static void test_attach_kprobe_long_event_name(void)
 	test_attach_probe_manual__destroy(skel);
 }
 
+#ifdef __x86_64__
+/* attach kprobe/kretprobe long event name testings */
+static void test_attach_kprobe_write_ctx(void)
+{
+	struct kprobe_write_ctx *skel = NULL;
+	struct bpf_link *link = NULL;
+
+	skel = kprobe_write_ctx__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "kprobe_write_ctx__open_and_load"))
+		return;
+
+	link = bpf_program__attach_kprobe_opts(skel->progs.kprobe_write_ctx,
+					     "bpf_fentry_test1", NULL);
+	if (!ASSERT_ERR_PTR(link, "bpf_program__attach_kprobe_opts"))
+		bpf_link__destroy(link);
+
+	kprobe_write_ctx__destroy(skel);
+}
+#else
+static void test_attach_kprobe_write_ctx(void)
+{
+	test__skip();
+}
+#endif
+
 static void test_attach_probe_auto(struct test_attach_probe *skel)
 {
 	struct bpf_link *uprobe_err_link;
@@ -406,6 +432,8 @@ void test_attach_probe(void)
 		test_attach_uprobe_long_event_name();
 	if (test__start_subtest("kprobe-long_name"))
 		test_attach_kprobe_long_event_name();
+	if (test__start_subtest("kprobe-write-ctx"))
+		test_attach_kprobe_write_ctx();
 
 cleanup:
 	test_attach_probe__destroy(skel);
diff --git a/tools/testing/selftests/bpf/progs/kprobe_write_ctx.c b/tools/testing/selftests/bpf/progs/kprobe_write_ctx.c
new file mode 100644
index 000000000000..4621a5bef4e2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/kprobe_write_ctx.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+#if defined(__TARGET_ARCH_x86)
+SEC("kprobe")
+int kprobe_write_ctx(struct pt_regs *ctx)
+{
+	ctx->ax = 0;
+	return 0;
+}
+#endif
-- 
2.51.0


