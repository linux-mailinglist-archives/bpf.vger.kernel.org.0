Return-Path: <bpf+bounces-74726-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DD35AC64385
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 13:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 466CD382F50
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 12:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FAC53370E2;
	Mon, 17 Nov 2025 12:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ere/j32l"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DFD331A7D;
	Mon, 17 Nov 2025 12:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763383336; cv=none; b=aJZovIw89RNHbnlS6IsaZWQe95FXC36VDGgGWl/SMAR05WzU/RNcgaU3YXcg4GyX9frKV++5ybAblfwrrrmkfYyAuXMF4oDxTGJUXeOhblOh1XRtDIomKvquc+1l+VrOXpDhWdSF18y3N2D2tcNI3wFpoqGJhCM3WADyJ5agnqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763383336; c=relaxed/simple;
	bh=x6+UjMw+bXbFJFqVCo4FzgPK65NoY/tAW0D2C8W9Rq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BiawTbPP5zY1BjkxZ+EbcQJDwZ0y/ubfgAR/I6NHQa5tnvEAq+O33arx51Bom6jRlIAcH3JRtBtSavH+sk0O9Ud5kUdUsDgqctjQ4Ozvc/JFI33ghDKuAzlTZ/ak16qlAm5lFrq0Qa3yqVXVYroJ1/5ECT/QTk8SpC+Ool5g1As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ere/j32l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C3BC4CEFB;
	Mon, 17 Nov 2025 12:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763383336;
	bh=x6+UjMw+bXbFJFqVCo4FzgPK65NoY/tAW0D2C8W9Rq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ere/j32l6mc/RYI/bbNiqAEQStc6TQs9PA2CuhKAx42TorQ8itmmTC25qMMOhAmpo
	 fS/S48HgnrpIJ5yFtPiIkrIyfwjAh6qr3OCg6k2YeSawZUTdhfk10HTcDTrccEEdp5
	 S/XwWgJkQ9Ue4DNz30Ecr8k7tha/7y/wULfzctv2Kmr9qZvVs+sqF7kXKDMHLBcgnl
	 EnhlhjOfbulso0PPJy+qvOxxDMFU4myjm0G64aZKo5jpu9F1Ef8jH03qtsWFEFu0MO
	 lD3jRnhAUXnSw6kRhDEukWE0lbYKmIklHzMTBiPEGAwTOfYC1S59wVTTrKPCZtQXFh
	 JE7cxV3P45HCw==
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
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	David Laight <David.Laight@ACULAB.COM>
Subject: [RFC PATCH 6/8] selftests/bpf: Add test for mov and sub emulation
Date: Mon, 17 Nov 2025 13:40:55 +0100
Message-ID: <20251117124057.687384-7-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251117124057.687384-1-jolsa@kernel.org>
References: <20251117124057.687384-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding test code for mov and sub instructions emulation.

TODO add test for sub flags value emulation.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/uprobe_syscall.c | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
index 955a37751b52..27fa6f309188 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -765,6 +765,54 @@ static void test_uprobe_error(void)
 	ASSERT_EQ(errno, ENXIO, "errno");
 }
 
+__attribute__((aligned(16)))
+__nocf_check __weak __naked unsigned long emulate_mov_trigger(void)
+{
+	asm volatile (
+		"pushq %rbp\n"
+		"movq  %rsp,%rbp\n"
+		"subq  $0xb0,%rsp\n"
+		"addq  $0xb0,%rsp\n"
+		"pop %rbp\n"
+		"ret\n"
+	);
+}
+
+static void test_emulate(void)
+{
+	struct uprobe_syscall *skel = NULL;
+	unsigned long offset;
+
+	offset = get_uprobe_offset(&emulate_mov_trigger);
+	if (!ASSERT_GE(offset, 0, "get_uprobe_offset"))
+		return;
+
+	skel = uprobe_syscall__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "uprobe_syscall__open_and_load"))
+		goto cleanup;
+
+	/* mov */
+	skel->links.probe = bpf_program__attach_uprobe_opts(skel->progs.probe,
+				0, "/proc/self/exe", offset + 1, NULL);
+	if (!ASSERT_OK_PTR(skel->links.probe, "bpf_program__attach_uprobe_opts"))
+		goto cleanup;
+
+	emulate_mov_trigger();
+
+	bpf_link__destroy(skel->links.probe);
+
+	/* sub */
+	skel->links.probe = bpf_program__attach_uprobe_opts(skel->progs.probe,
+				0, "/proc/self/exe", offset + 4, NULL);
+	if (!ASSERT_OK_PTR(skel->links.probe, "bpf_program__attach_uprobe_opts"))
+		goto cleanup;
+
+	emulate_mov_trigger();
+
+cleanup:
+	uprobe_syscall__destroy(skel);
+}
+
 static void __test_uprobe_syscall(void)
 {
 	if (test__start_subtest("uretprobe_regs_equal"))
@@ -789,6 +837,8 @@ static void __test_uprobe_syscall(void)
 		test_uprobe_regs_equal(false);
 	if (test__start_subtest("regs_change"))
 		test_regs_change();
+	if (test__start_subtest("emulate_mov"))
+		test_emulate();
 }
 #else
 static void __test_uprobe_syscall(void)
-- 
2.51.1


