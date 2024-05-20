Return-Path: <bpf+bounces-30068-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 370158CA538
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 01:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7DC81F22C7D
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 23:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93928137C3C;
	Mon, 20 May 2024 23:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Om8NjCbp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1356A1847
	for <bpf@vger.kernel.org>; Mon, 20 May 2024 23:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716248860; cv=none; b=KkhRDzy88JskLIxPXSfc8KGFkS6AuxQ9/LQsyudn+QZecuLarBcf+8az74l7envGBIryBGBr/vNMhpSEgafKQhxmBWcA+PPZx6iXp/dIWMEvkx9MWgzxHnr6k/xMrdNtx0D8gb0qGkNfosoCEQkfSZaF8T4j1pvnPhNq3asYjCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716248860; c=relaxed/simple;
	bh=wJAlmsH7mPusMdRPHY2KL5CQXOX6UHj8JNK4/Q0FACM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bY3GQ9C2VuIFfB19wc56T95BUQfaCLjb6rFfRgxY4pEhs5eDYYDR3jia4/hQwVSM6aYEzu1ztkuYdueor3uLlmzPK5z10ZPM+BFVznxUu5BsV/Ekr8LDdbvV9jQEnxlzQRvxuxh4HAQNedgiAPGF1xZpSbtT4YBZZfcshnvBx3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Om8NjCbp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B374C2BD10;
	Mon, 20 May 2024 23:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716248859;
	bh=wJAlmsH7mPusMdRPHY2KL5CQXOX6UHj8JNK4/Q0FACM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Om8NjCbpR6nzm1BNua7xxNoXWmp560NUA8JSNllyN55kqy+eDf8HdIc4QHITluuGQ
	 1qvr76mz0J8pp1+/Myi56G9ltGQNR9LueK4swCyKCOis6bZXocuOQWFiFHS+d+dtJg
	 jw3rV1N36edBXLrUssUdcgJ70BWS1IsVS9KJktvN2mQ8zm4WGksHY3NiXK9G+bozgX
	 MAdhGYdDwnq5n24B7hL2RbwyJDdteD0kclKSAGBpw2Q/DqViZ6a0ppXSw98uJL/8i2
	 YG54z2/MBrDy9SiKgDnbcSCZ3eQNxVNx22O2djrMY9cBYDRAo1LMf2sTG88e9IEGoC
	 2zu5KM7CztLww==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf 5/5] selftests/bpf: extend multi-uprobe tests with USDTs
Date: Mon, 20 May 2024 16:47:20 -0700
Message-ID: <20240520234720.1748918-6-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240520234720.1748918-1-andrii@kernel.org>
References: <20240520234720.1748918-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Validate libbpf's USDT-over-multi-uprobe logic by adding USDTs to
existing multi-uprobe tests. This checks correct libbpf fallback to
singular uprobes (when run on older kernels with buggy PID filtering).
We reuse already established child process and child thread testing
infrastructure, so additions are minimal. These test fail on either
older kernels or older version of libbpf that doesn't detect PID
filtering problems.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../bpf/prog_tests/uprobe_multi_test.c        | 22 +++++++++++++
 .../selftests/bpf/progs/uprobe_multi.c        | 33 +++++++++++++++++--
 2 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index 677232d31432..85d46e568e90 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -8,6 +8,7 @@
 #include "uprobe_multi_usdt.skel.h"
 #include "bpf/libbpf_internal.h"
 #include "testing_helpers.h"
+#include "../sdt.h"
 
 static char test_data[] = "test_data";
 
@@ -26,6 +27,11 @@ noinline void uprobe_multi_func_3(void)
 	asm volatile ("");
 }
 
+noinline void usdt_trigger(void)
+{
+	STAP_PROBE(test, pid_filter_usdt);
+}
+
 struct child {
 	int go[2];
 	int c2p[2]; /* child -> parent channel */
@@ -269,8 +275,24 @@ __test_attach_api(const char *binary, const char *pattern, struct bpf_uprobe_mul
 	if (!ASSERT_OK_PTR(skel->links.uprobe_extra, "bpf_program__attach_uprobe_multi"))
 		goto cleanup;
 
+	/* Attach (uprobe-backed) USDTs */
+	skel->links.usdt_pid = bpf_program__attach_usdt(skel->progs.usdt_pid, pid, binary,
+							"test", "pid_filter_usdt", NULL);
+	if (!ASSERT_OK_PTR(skel->links.usdt_pid, "attach_usdt_pid"))
+		goto cleanup;
+
+	skel->links.usdt_extra = bpf_program__attach_usdt(skel->progs.usdt_extra, -1, binary,
+							  "test", "pid_filter_usdt", NULL);
+	if (!ASSERT_OK_PTR(skel->links.usdt_extra, "attach_usdt_extra"))
+		goto cleanup;
+
 	uprobe_multi_test_run(skel, child);
 
+	ASSERT_FALSE(skel->bss->bad_pid_seen_usdt, "bad_pid_seen_usdt");
+	if (child) {
+		ASSERT_EQ(skel->bss->child_pid_usdt, child->pid, "usdt_multi_child_pid");
+		ASSERT_EQ(skel->bss->child_tid_usdt, child->tid, "usdt_multi_child_tid");
+	}
 cleanup:
 	uprobe_multi__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/uprobe_multi.c b/tools/testing/selftests/bpf/progs/uprobe_multi.c
index 86a7ff5d3726..44190efcdba2 100644
--- a/tools/testing/selftests/bpf/progs/uprobe_multi.c
+++ b/tools/testing/selftests/bpf/progs/uprobe_multi.c
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/bpf.h>
+#include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
-#include <stdbool.h>
+#include <bpf/usdt.bpf.h>
 
 char _license[] SEC("license") = "GPL";
 
@@ -23,9 +23,12 @@ __u64 uprobe_multi_sleep_result = 0;
 int pid = 0;
 int child_pid = 0;
 int child_tid = 0;
+int child_pid_usdt = 0;
+int child_tid_usdt = 0;
 
 int expect_pid = 0;
 bool bad_pid_seen = false;
+bool bad_pid_seen_usdt = false;
 
 bool test_cookie = false;
 void *user_ptr = 0;
@@ -112,3 +115,29 @@ int uprobe_extra(struct pt_regs *ctx)
 	/* we need this one just to mix PID-filtered and global uprobes */
 	return 0;
 }
+
+SEC("usdt")
+int usdt_pid(struct pt_regs *ctx)
+{
+	__u64 cur_pid_tgid = bpf_get_current_pid_tgid();
+	__u32 cur_pid;
+
+	cur_pid = cur_pid_tgid >> 32;
+	if (pid && cur_pid != pid)
+		return 0;
+
+	if (expect_pid && cur_pid != expect_pid)
+		bad_pid_seen_usdt = true;
+
+	child_pid_usdt = cur_pid_tgid >> 32;
+	child_tid_usdt = (__u32)cur_pid_tgid;
+
+	return 0;
+}
+
+SEC("usdt")
+int usdt_extra(struct pt_regs *ctx)
+{
+	/* we need this one just to mix PID-filtered and global USDT probes */
+	return 0;
+}
-- 
2.43.0


