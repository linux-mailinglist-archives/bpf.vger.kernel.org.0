Return-Path: <bpf+bounces-78627-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B397FD157C3
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 22:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 31ECF3009D64
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 21:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFC83446B6;
	Mon, 12 Jan 2026 21:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KUEGGosz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F6E342512;
	Mon, 12 Jan 2026 21:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768254636; cv=none; b=rJZYGZNMPaMNsdMG2jGZS9/f/e9dcFC0mzU4ocH+/1ibBH3nQe4mTcbLxJz/FvJMEzRKTbZnTvA1iow71a7LtyKaQHu4wbLxJ4f75CyTPYR55DKuzIXAB/oFW1ipCR7D5Idxv5THCATOxmGVktecGwdTVWSfxgpuYdbO0Ar/uTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768254636; c=relaxed/simple;
	bh=BKAlzB8ae2rvFp3J172DYzy+dW8gueCU5Wr5zuoFG4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BcB3XWJ7BB+GjHraEdVJTSoPkpRVPRGgfy1iLe9rEAKnqCHtLkbKCtzr3PYihjh4KIyWiwxPFRyY7F5UReJLy7s41C28Brq0NAfoWQnGCaBawEqZHFeDLv//ecvuXJgvh8nFodnxY9Iv9/WoFMSzQXNajiZtZtQuWPQjJB7Tr7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KUEGGosz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A17FFC116D0;
	Mon, 12 Jan 2026 21:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768254635;
	bh=BKAlzB8ae2rvFp3J172DYzy+dW8gueCU5Wr5zuoFG4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KUEGGoszgb39p5yxBxjRZuXhqc+KyUrbgP2661umrAaXaIPGIC5EMpbB9WZgK7I5A
	 UU790JY3I2pym8voY7SRD0C2L9GGq/nBSItFPT4z7cWI1dTXWk/OGG0XmWwti+YHQ/
	 iel2xoC53DFFCn152UuaDfeXaYRaeUqXRPV4oyjBvAdNo4tH+kBuiTV5Q45qV22QOj
	 rspM0Jydi2p5Z1UbBMgqQ60FEBnbsjEVz+MHJgQOyRbVWwxaB09dFfjNePWTA09c2z
	 gRoJBepVJNfn/ZVg4TSYSmhiDrNVMO+xGECPlNCbAGl57L1R1wE7jxXBZVW1hpSQxo
	 Qjj1L1arY33Zw==
From: Jiri Olsa <jolsa@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org,
	Yonghong Song <yhs@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next 4/4] selftests/bpf: Allow to benchmark trigger with stacktrace
Date: Mon, 12 Jan 2026 22:49:40 +0100
Message-ID: <20260112214940.1222115-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112214940.1222115-1-jolsa@kernel.org>
References: <20260112214940.1222115-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding support to call bpf_get_stackid helper from trigger programs,
so far added for kprobe multi.

Adding the --stacktrace/-g option to enable it.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/bench.c            |  4 ++++
 tools/testing/selftests/bpf/bench.h            |  1 +
 .../selftests/bpf/benchs/bench_trigger.c       |  1 +
 .../selftests/bpf/progs/trigger_bench.c        | 18 ++++++++++++++++++
 4 files changed, 24 insertions(+)

diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index bd29bb2e6cb5..8dadd9c928ec 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -265,6 +265,7 @@ static const struct argp_option opts[] = {
 	{ "verbose", 'v', NULL, 0, "Verbose debug output"},
 	{ "affinity", 'a', NULL, 0, "Set consumer/producer thread affinity"},
 	{ "quiet", 'q', NULL, 0, "Be more quiet"},
+	{ "stacktrace", 'g', NULL, 0, "Get stack trace"},
 	{ "prod-affinity", ARG_PROD_AFFINITY_SET, "CPUSET", 0,
 	  "Set of CPUs for producer threads; implies --affinity"},
 	{ "cons-affinity", ARG_CONS_AFFINITY_SET, "CPUSET", 0,
@@ -350,6 +351,9 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
 	case 'q':
 		env.quiet = true;
 		break;
+	case 'g':
+		env.stacktrace = true;
+		break;
 	case ARG_PROD_AFFINITY_SET:
 		env.affinity = true;
 		if (parse_num_list(arg, &env.prod_cpus.cpus,
diff --git a/tools/testing/selftests/bpf/bench.h b/tools/testing/selftests/bpf/bench.h
index bea323820ffb..7cf21936e7ed 100644
--- a/tools/testing/selftests/bpf/bench.h
+++ b/tools/testing/selftests/bpf/bench.h
@@ -26,6 +26,7 @@ struct env {
 	bool list;
 	bool affinity;
 	bool quiet;
+	bool stacktrace;
 	int consumer_cnt;
 	int producer_cnt;
 	int nr_cpus;
diff --git a/tools/testing/selftests/bpf/benchs/bench_trigger.c b/tools/testing/selftests/bpf/benchs/bench_trigger.c
index 34018fc3927f..aeec9edd3851 100644
--- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
+++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
@@ -146,6 +146,7 @@ static void setup_ctx(void)
 	bpf_program__set_autoload(ctx.skel->progs.trigger_driver, true);
 
 	ctx.skel->rodata->batch_iters = args.batch_iters;
+	ctx.skel->rodata->stacktrace = env.stacktrace;
 }
 
 static void load_ctx(void)
diff --git a/tools/testing/selftests/bpf/progs/trigger_bench.c b/tools/testing/selftests/bpf/progs/trigger_bench.c
index 2898b3749d07..479400d96fa4 100644
--- a/tools/testing/selftests/bpf/progs/trigger_bench.c
+++ b/tools/testing/selftests/bpf/progs/trigger_bench.c
@@ -25,6 +25,23 @@ static __always_inline void inc_counter(void)
 	__sync_add_and_fetch(&hits[cpu & CPU_MASK].value, 1);
 }
 
+volatile const int stacktrace;
+
+typedef __u64 stack_trace_t[128];
+
+struct {
+	__uint(type, BPF_MAP_TYPE_STACK_TRACE);
+	__uint(max_entries, 16384);
+	__type(key, __u32);
+	__type(value, stack_trace_t);
+} stackmap SEC(".maps");
+
+static __always_inline void do_stacktrace(void *ctx)
+{
+	if (stacktrace)
+		bpf_get_stackid(ctx, &stackmap, 0);
+}
+
 SEC("?uprobe")
 int bench_trigger_uprobe(void *ctx)
 {
@@ -96,6 +113,7 @@ SEC("?kprobe.multi/bpf_get_numa_node_id")
 int bench_trigger_kprobe_multi(void *ctx)
 {
 	inc_counter();
+	do_stacktrace(ctx);
 	return 0;
 }
 
-- 
2.52.0


