Return-Path: <bpf+bounces-36447-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CBB948862
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 06:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 747AFB22617
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 04:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438E61BA880;
	Tue,  6 Aug 2024 04:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FC7augT5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0280EADC
	for <bpf@vger.kernel.org>; Tue,  6 Aug 2024 04:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722918578; cv=none; b=aNPXK+ebGb6v/kMjT1F2XPS6QvrvTTEea5L42KWxDnQ9ws2XzMeg1RODuZdEzprl8cj+SLGh118KTwo4FNa8HVUj0IJZjUzHcwGVbURkp5GDFgzOTqxJ33fxSxUvJnVZHgutmbEVyce8ahkItV4YNrzzoAQhUJbr5PRUGjWHE9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722918578; c=relaxed/simple;
	bh=G6lbSKQQwt7qFDxPnKuUAY6sfl+S0LYKC4uyhieYBFA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Wlh8Bp6ekqo9lASBvyUWR6TAwhibndaQOF0n0PCdiTqYNltQR8OpK6OHvhs9XLOGLewe1ntHZ2e9IkvduDCyZxrdlSkanK4U0lzF6O/wUIQUXLBCgWhEIhue5TAEejKLG6qSgvfNXATp9aJ4TEQvKj9snTQ6lKWfjw6wOo5bqk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FC7augT5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29BA8C32786;
	Tue,  6 Aug 2024 04:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722918578;
	bh=G6lbSKQQwt7qFDxPnKuUAY6sfl+S0LYKC4uyhieYBFA=;
	h=From:To:Cc:Subject:Date:From;
	b=FC7augT54csfOWoYVC/IH2w6ndWBZiBRsATG9J9PDFe4u9JfKhhRwFd4rxQwUc07G
	 +TflUl616LAhmdf+KZxUM6h5mXzbKSuOjNKxXom+HSsLN3AxhtHT4PFcDZ5WT8MYxf
	 PoXvUf5fcuT6aLZd7is58Zc7LTHx4K2o+oRCZf1HbZal9KyLNfItrOokQVQs+Om2YI
	 JJSLTws53s8dYDTtKweRA5vzOVZ8NUyuh9bRbrzK7R3VxorWgLPT2vb/EyZq31RJjE
	 fpPShs77omfyiwqoyVpffJNiHpz8elKKvgDUNOePE4bupTkg3wGlM6rfuJ9dYArePM
	 YDNXqqYXdYecw==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next] selftests/bpf: add multi-uprobe benchmarks
Date: Mon,  5 Aug 2024 21:29:35 -0700
Message-ID: <20240806042935.3867862-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add multi-uprobe and multi-uretprobe benchmarks to bench tool.
Multi- and classic uprobes/uretprobes have different low-level
triggering code paths, so it's sometimes important to be able to
benchmark both flavors of uprobes/uretprobes.

Sample examples from my dev machine below. Single-threaded peformance
almost doesn't differ, but with more parallel CPUs triggering the same
uprobe/uretprobe the difference grows. This might be due to [0], but
given the code is slightly different, there could be other sources of
slowdown.

Note, all these numbers will change due to ongoing work to improve
uprobe/uretprobe scalability (e.g., [1]), but having benchmark like this
is useful for measurements and debugging nevertheless.

uprobe-nop            ( 1 cpus):    1.020 ± 0.005M/s  (  1.020M/s/cpu)
uretprobe-nop         ( 1 cpus):    0.515 ± 0.009M/s  (  0.515M/s/cpu)
uprobe-multi-nop      ( 1 cpus):    1.036 ± 0.004M/s  (  1.036M/s/cpu)
uretprobe-multi-nop   ( 1 cpus):    0.512 ± 0.005M/s  (  0.512M/s/cpu)

uprobe-nop            ( 8 cpus):    3.481 ± 0.030M/s  (  0.435M/s/cpu)
uretprobe-nop         ( 8 cpus):    2.222 ± 0.008M/s  (  0.278M/s/cpu)
uprobe-multi-nop      ( 8 cpus):    3.769 ± 0.094M/s  (  0.471M/s/cpu)
uretprobe-multi-nop   ( 8 cpus):    2.482 ± 0.007M/s  (  0.310M/s/cpu)

uprobe-nop            (16 cpus):    2.968 ± 0.011M/s  (  0.185M/s/cpu)
uretprobe-nop         (16 cpus):    1.870 ± 0.002M/s  (  0.117M/s/cpu)
uprobe-multi-nop      (16 cpus):    3.541 ± 0.037M/s  (  0.221M/s/cpu)
uretprobe-multi-nop   (16 cpus):    2.123 ± 0.026M/s  (  0.133M/s/cpu)

uprobe-nop            (32 cpus):    2.524 ± 0.026M/s  (  0.079M/s/cpu)
uretprobe-nop         (32 cpus):    1.572 ± 0.003M/s  (  0.049M/s/cpu)
uprobe-multi-nop      (32 cpus):    2.717 ± 0.003M/s  (  0.085M/s/cpu)
uretprobe-multi-nop   (32 cpus):    1.687 ± 0.007M/s  (  0.053M/s/cpu)

  [0] https://lore.kernel.org/linux-trace-kernel/20240805202803.1813090-1-andrii@kernel.org/
  [1] https://lore.kernel.org/linux-trace-kernel/20240731214256.3588718-1-andrii@kernel.org/

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/bench.c           | 12 +++
 .../selftests/bpf/benchs/bench_trigger.c      | 81 +++++++++++++++----
 .../selftests/bpf/progs/trigger_bench.c       |  7 ++
 3 files changed, 85 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index 90dc3aca32bd..1bd403a5ef7b 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -520,6 +520,12 @@ extern const struct bench bench_trig_uprobe_push;
 extern const struct bench bench_trig_uretprobe_push;
 extern const struct bench bench_trig_uprobe_ret;
 extern const struct bench bench_trig_uretprobe_ret;
+extern const struct bench bench_trig_uprobe_multi_nop;
+extern const struct bench bench_trig_uretprobe_multi_nop;
+extern const struct bench bench_trig_uprobe_multi_push;
+extern const struct bench bench_trig_uretprobe_multi_push;
+extern const struct bench bench_trig_uprobe_multi_ret;
+extern const struct bench bench_trig_uretprobe_multi_ret;
 
 extern const struct bench bench_rb_libbpf;
 extern const struct bench bench_rb_custom;
@@ -574,6 +580,12 @@ static const struct bench *benchs[] = {
 	&bench_trig_uretprobe_push,
 	&bench_trig_uprobe_ret,
 	&bench_trig_uretprobe_ret,
+	&bench_trig_uprobe_multi_nop,
+	&bench_trig_uretprobe_multi_nop,
+	&bench_trig_uprobe_multi_push,
+	&bench_trig_uretprobe_multi_push,
+	&bench_trig_uprobe_multi_ret,
+	&bench_trig_uretprobe_multi_ret,
 	/* ringbuf/perfbuf benchmarks */
 	&bench_rb_libbpf,
 	&bench_rb_custom,
diff --git a/tools/testing/selftests/bpf/benchs/bench_trigger.c b/tools/testing/selftests/bpf/benchs/bench_trigger.c
index 4b05539f167d..a220545a3238 100644
--- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
+++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
@@ -332,7 +332,7 @@ static void *uprobe_producer_ret(void *input)
 	return NULL;
 }
 
-static void usetup(bool use_retprobe, void *target_addr)
+static void usetup(bool use_retprobe, bool use_multi, void *target_addr)
 {
 	size_t uprobe_offset;
 	struct bpf_link *link;
@@ -346,7 +346,10 @@ static void usetup(bool use_retprobe, void *target_addr)
 		exit(1);
 	}
 
-	bpf_program__set_autoload(ctx.skel->progs.bench_trigger_uprobe, true);
+	if (use_multi)
+		bpf_program__set_autoload(ctx.skel->progs.bench_trigger_uprobe_multi, true);
+	else
+		bpf_program__set_autoload(ctx.skel->progs.bench_trigger_uprobe, true);
 
 	err = trigger_bench__load(ctx.skel);
 	if (err) {
@@ -355,16 +358,28 @@ static void usetup(bool use_retprobe, void *target_addr)
 	}
 
 	uprobe_offset = get_uprobe_offset(target_addr);
-	link = bpf_program__attach_uprobe(ctx.skel->progs.bench_trigger_uprobe,
-					  use_retprobe,
-					  -1 /* all PIDs */,
-					  "/proc/self/exe",
-					  uprobe_offset);
+	if (use_multi) {
+		LIBBPF_OPTS(bpf_uprobe_multi_opts, opts,
+			.retprobe = use_retprobe,
+			.cnt = 1,
+			.offsets = &uprobe_offset,
+		);
+		link = bpf_program__attach_uprobe_multi(
+			ctx.skel->progs.bench_trigger_uprobe_multi,
+			-1 /* all PIDs */, "/proc/self/exe", NULL, &opts);
+		ctx.skel->links.bench_trigger_uprobe_multi = link;
+	} else {
+		link = bpf_program__attach_uprobe(ctx.skel->progs.bench_trigger_uprobe,
+						  use_retprobe,
+						  -1 /* all PIDs */,
+						  "/proc/self/exe",
+						  uprobe_offset);
+		ctx.skel->links.bench_trigger_uprobe = link;
+	}
 	if (!link) {
-		fprintf(stderr, "failed to attach uprobe!\n");
+		fprintf(stderr, "failed to attach %s!\n", use_multi ? "multi-uprobe" : "uprobe");
 		exit(1);
 	}
-	ctx.skel->links.bench_trigger_uprobe = link;
 }
 
 static void usermode_count_setup(void)
@@ -374,32 +389,62 @@ static void usermode_count_setup(void)
 
 static void uprobe_nop_setup(void)
 {
-	usetup(false, &uprobe_target_nop);
+	usetup(false, false /* !use_multi */, &uprobe_target_nop);
 }
 
 static void uretprobe_nop_setup(void)
 {
-	usetup(true, &uprobe_target_nop);
+	usetup(true, false /* !use_multi */, &uprobe_target_nop);
 }
 
 static void uprobe_push_setup(void)
 {
-	usetup(false, &uprobe_target_push);
+	usetup(false, false /* !use_multi */, &uprobe_target_push);
 }
 
 static void uretprobe_push_setup(void)
 {
-	usetup(true, &uprobe_target_push);
+	usetup(true, false /* !use_multi */, &uprobe_target_push);
 }
 
 static void uprobe_ret_setup(void)
 {
-	usetup(false, &uprobe_target_ret);
+	usetup(false, false /* !use_multi */, &uprobe_target_ret);
 }
 
 static void uretprobe_ret_setup(void)
 {
-	usetup(true, &uprobe_target_ret);
+	usetup(true, false /* !use_multi */, &uprobe_target_ret);
+}
+
+static void uprobe_multi_nop_setup(void)
+{
+	usetup(false, true /* use_multi */, &uprobe_target_nop);
+}
+
+static void uretprobe_multi_nop_setup(void)
+{
+	usetup(true, true /* use_multi */, &uprobe_target_nop);
+}
+
+static void uprobe_multi_push_setup(void)
+{
+	usetup(false, true /* use_multi */, &uprobe_target_push);
+}
+
+static void uretprobe_multi_push_setup(void)
+{
+	usetup(true, true /* use_multi */, &uprobe_target_push);
+}
+
+static void uprobe_multi_ret_setup(void)
+{
+	usetup(false, true /* use_multi */, &uprobe_target_ret);
+}
+
+static void uretprobe_multi_ret_setup(void)
+{
+	usetup(true, true /* use_multi */, &uprobe_target_ret);
 }
 
 const struct bench bench_trig_syscall_count = {
@@ -454,3 +499,9 @@ BENCH_TRIG_USERMODE(uprobe_ret, ret, "uprobe-ret");
 BENCH_TRIG_USERMODE(uretprobe_nop, nop, "uretprobe-nop");
 BENCH_TRIG_USERMODE(uretprobe_push, push, "uretprobe-push");
 BENCH_TRIG_USERMODE(uretprobe_ret, ret, "uretprobe-ret");
+BENCH_TRIG_USERMODE(uprobe_multi_nop, nop, "uprobe-multi-nop");
+BENCH_TRIG_USERMODE(uprobe_multi_push, push, "uprobe-multi-push");
+BENCH_TRIG_USERMODE(uprobe_multi_ret, ret, "uprobe-multi-ret");
+BENCH_TRIG_USERMODE(uretprobe_multi_nop, nop, "uretprobe-multi-nop");
+BENCH_TRIG_USERMODE(uretprobe_multi_push, push, "uretprobe-multi-push");
+BENCH_TRIG_USERMODE(uretprobe_multi_ret, ret, "uretprobe-multi-ret");
diff --git a/tools/testing/selftests/bpf/progs/trigger_bench.c b/tools/testing/selftests/bpf/progs/trigger_bench.c
index 2619ed193c65..044a6d78923e 100644
--- a/tools/testing/selftests/bpf/progs/trigger_bench.c
+++ b/tools/testing/selftests/bpf/progs/trigger_bench.c
@@ -32,6 +32,13 @@ int bench_trigger_uprobe(void *ctx)
 	return 0;
 }
 
+SEC("?uprobe.multi")
+int bench_trigger_uprobe_multi(void *ctx)
+{
+	inc_counter();
+	return 0;
+}
+
 const volatile int batch_iters = 0;
 
 SEC("?raw_tp")
-- 
2.43.5


