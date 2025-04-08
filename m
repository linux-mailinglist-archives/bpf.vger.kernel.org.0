Return-Path: <bpf+bounces-55487-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF625A81776
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 23:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB01A3B325D
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 21:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AC7254872;
	Tue,  8 Apr 2025 21:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENEsh+Vz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CFF23E34A;
	Tue,  8 Apr 2025 21:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744146811; cv=none; b=V5cXiZeTaNFrPpLPCz4pVJ494iLRRrqKyhpaRjaz9ZVZVlGvCvh5SadFJUisvLawv3ZuZYL12YdcxwNV5d6l0rN0jTdpDOAEUVxuyRyKxYeXIIbblULII3JJsIyfkdw7n25rpfhiaT7dIEHEev3yhS8KwiggaMoq6Gbd7waJbm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744146811; c=relaxed/simple;
	bh=ILfVuLymqUPwgpbXMf4YH+PUBfgIPrXUs3zMoGXuMG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pMCBpECzr79h64FBIRp6I9ZhjD/kuiJlb6zS7sLAob9GqL9dQ4ft4LtQ9ujLnlRiWTRVVhUFuX22TmVg8sWIN/PU+V+fpATKaGISaJKDyLkHqON/6mNDBCpG0oKrAbkCLBKvJwlEg6UjMj9H25lS/KdMSERz+6QR5Vy4wXvbuAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ENEsh+Vz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38383C4CEE5;
	Tue,  8 Apr 2025 21:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744146810;
	bh=ILfVuLymqUPwgpbXMf4YH+PUBfgIPrXUs3zMoGXuMG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ENEsh+VzuzIhPCsEeaeTB/LwS9l2I5lCTSUa0s9kW/wRflw3wb74mXu7vRH88LTvT
	 0lgmT5rkiG13hQqOhuoisBXKAoozc5ShSLkElOMT+j0XY4GAcoiqyZVY9EfKhJDr2w
	 KhPwlEacG0dbfg/wZV5sLlLLAN7mvTK7a2onHbyeREMGGrhUK/jcWlMDEdrMKaLp6w
	 xYrHkIGBYHkvJ55bIA8uFHeM0zffysTKIxJBRQjKDuNONvZD3+7d4s8z65WrnAnAST
	 Nh8o6qEvy4IppfL+DhyDGoejH9fi6IVjRFkC8snO8d6FPDCR0b4yAgukRmN/i4Vq2U
	 7E663lyCTcoNQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
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
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH 2/2] selftests/bpf: Add 5-byte nop uprobe trigger bench
Date: Tue,  8 Apr 2025 23:13:10 +0200
Message-ID: <20250408211310.51491-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408211310.51491-1-jolsa@kernel.org>
References: <20250408211310.51491-1-jolsa@kernel.org>
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


