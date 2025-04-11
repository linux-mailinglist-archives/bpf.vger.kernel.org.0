Return-Path: <bpf+bounces-55727-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 389BAA85CED
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 14:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0598E8C367A
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 12:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B9229B234;
	Fri, 11 Apr 2025 12:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cOCDrYZR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541F929B20E;
	Fri, 11 Apr 2025 12:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744373900; cv=none; b=V2uUtNX1fj25yyUG4VD4k3Ddq6z4nZ0d3i2c+CngYTDcTAXMSv2XTG9Bxm+WonLxFKTkfGIFTK1rmskAjoU+ZQuh2IWkAHAiOkv4YIc+Sy4ow4ZK2h1moYyaxknEOA8YP22JmnN+pjW2VpX7hp+8TqnOfgIEq96VX+eDPF5gRO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744373900; c=relaxed/simple;
	bh=ILfVuLymqUPwgpbXMf4YH+PUBfgIPrXUs3zMoGXuMG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WKy6crTAzenHnNx67kVF6AcT/+n57d4PzcLXMusBgAXPnOOwd3wwKfoLPLKM/YoE+GszfK9mkKiD1+8WRIIKyBtjXgyAbWyev89SCEMleTHuq71l0D+184VUNC35s8BwW52UDGlHFNuyLHodlhavkIS/a4jl2hagk0qxpvHxoXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cOCDrYZR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6115AC4CEE8;
	Fri, 11 Apr 2025 12:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744373899;
	bh=ILfVuLymqUPwgpbXMf4YH+PUBfgIPrXUs3zMoGXuMG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cOCDrYZR6R/5SQR7qt2WRm4ouWUXMr0x8dqu1ptJuSyIhVHnp5a5bWxzhWkoZBy26
	 wzi4WkY31gXKWHj6mgfNi3hst7RBJ9Qln8BPP7E9OzSUOaTARc36DHZ+Danc/I9uiB
	 JM3L6sQAwaeoSj4K63I8TnzBtlv6L4jGjd6lG7tXV0If3344IsGAI9Z2uI4H9aSK44
	 jU113xH8J3am0Gz9iPxpgAEbNoxjxvGvem2dVa1mDgpcn/jb5QC2i/HbihbGJ8N2EU
	 /zl95lNEGWv7iwHdGk1qhpWB7bFFLW1b6szpB7TBtuu8oleZ4JnuwjBjMv9DyV3W5f
	 JtQ2ClK1kC+xA==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
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
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCHv2 perf/core 2/2] selftests/bpf: Add 5-byte nop uprobe trigger bench
Date: Fri, 11 Apr 2025 14:17:56 +0200
Message-ID: <20250411121756.567274-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250411121756.567274-1-jolsa@kernel.org>
References: <20250411121756.567274-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add 5-byte nop uprobe trigger bench (x86_64 specific) to measure
uprobes/uretprobes on top of nop5 instruction.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/bench.c           | 12 ++++++
 .../selftests/bpf/benchs/bench_trigger.c      | 42 +++++++++++++++++++
 .../selftests/bpf/benchs/run_bench_uprobes.sh |  2 +-
 3 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index 1bd403a5ef7b..0fd8c9b0d38f 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -526,6 +526,12 @@ extern const struct bench bench_trig_uprobe_multi_push;
 extern const struct bench bench_trig_uretprobe_multi_push;
 extern const struct bench bench_trig_uprobe_multi_ret;
 extern const struct bench bench_trig_uretprobe_multi_ret;
+#ifdef __x86_64__
+extern const struct bench bench_trig_uprobe_nop5;
+extern const struct bench bench_trig_uretprobe_nop5;
+extern const struct bench bench_trig_uprobe_multi_nop5;
+extern const struct bench bench_trig_uretprobe_multi_nop5;
+#endif
 
 extern const struct bench bench_rb_libbpf;
 extern const struct bench bench_rb_custom;
@@ -586,6 +592,12 @@ static const struct bench *benchs[] = {
 	&bench_trig_uretprobe_multi_push,
 	&bench_trig_uprobe_multi_ret,
 	&bench_trig_uretprobe_multi_ret,
+#ifdef __x86_64__
+	&bench_trig_uprobe_nop5,
+	&bench_trig_uretprobe_nop5,
+	&bench_trig_uprobe_multi_nop5,
+	&bench_trig_uretprobe_multi_nop5,
+#endif
 	/* ringbuf/perfbuf benchmarks */
 	&bench_rb_libbpf,
 	&bench_rb_custom,
diff --git a/tools/testing/selftests/bpf/benchs/bench_trigger.c b/tools/testing/selftests/bpf/benchs/bench_trigger.c
index 32e9f194d449..82327657846e 100644
--- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
+++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
@@ -333,6 +333,20 @@ static void *uprobe_producer_ret(void *input)
 	return NULL;
 }
 
+#ifdef __x86_64__
+__nocf_check __weak void uprobe_target_nop5(void)
+{
+	asm volatile (".byte 0x0f, 0x1f, 0x44, 0x00, 0x00");
+}
+
+static void *uprobe_producer_nop5(void *input)
+{
+	while (true)
+		uprobe_target_nop5();
+	return NULL;
+}
+#endif
+
 static void usetup(bool use_retprobe, bool use_multi, void *target_addr)
 {
 	size_t uprobe_offset;
@@ -448,6 +462,28 @@ static void uretprobe_multi_ret_setup(void)
 	usetup(true, true /* use_multi */, &uprobe_target_ret);
 }
 
+#ifdef __x86_64__
+static void uprobe_nop5_setup(void)
+{
+	usetup(false, false /* !use_multi */, &uprobe_target_nop5);
+}
+
+static void uretprobe_nop5_setup(void)
+{
+	usetup(true, false /* !use_multi */, &uprobe_target_nop5);
+}
+
+static void uprobe_multi_nop5_setup(void)
+{
+	usetup(false, true /* use_multi */, &uprobe_target_nop5);
+}
+
+static void uretprobe_multi_nop5_setup(void)
+{
+	usetup(true, true /* use_multi */, &uprobe_target_nop5);
+}
+#endif
+
 const struct bench bench_trig_syscall_count = {
 	.name = "trig-syscall-count",
 	.validate = trigger_validate,
@@ -506,3 +542,9 @@ BENCH_TRIG_USERMODE(uprobe_multi_ret, ret, "uprobe-multi-ret");
 BENCH_TRIG_USERMODE(uretprobe_multi_nop, nop, "uretprobe-multi-nop");
 BENCH_TRIG_USERMODE(uretprobe_multi_push, push, "uretprobe-multi-push");
 BENCH_TRIG_USERMODE(uretprobe_multi_ret, ret, "uretprobe-multi-ret");
+#ifdef __x86_64__
+BENCH_TRIG_USERMODE(uprobe_nop5, nop5, "uprobe-nop5");
+BENCH_TRIG_USERMODE(uretprobe_nop5, nop5, "uretprobe-nop5");
+BENCH_TRIG_USERMODE(uprobe_multi_nop5, nop5, "uprobe-multi-nop5");
+BENCH_TRIG_USERMODE(uretprobe_multi_nop5, nop5, "uretprobe-multi-nop5");
+#endif
diff --git a/tools/testing/selftests/bpf/benchs/run_bench_uprobes.sh b/tools/testing/selftests/bpf/benchs/run_bench_uprobes.sh
index af169f831f2f..03f55405484b 100755
--- a/tools/testing/selftests/bpf/benchs/run_bench_uprobes.sh
+++ b/tools/testing/selftests/bpf/benchs/run_bench_uprobes.sh
@@ -2,7 +2,7 @@
 
 set -eufo pipefail
 
-for i in usermode-count syscall-count {uprobe,uretprobe}-{nop,push,ret}
+for i in usermode-count syscall-count {uprobe,uretprobe}-{nop,push,ret,nop5}
 do
 	summary=$(sudo ./bench -w2 -d5 -a trig-$i | tail -n1 | cut -d'(' -f1 | cut -d' ' -f3-)
 	printf "%-15s: %s\n" $i "$summary"
-- 
2.49.0


