Return-Path: <bpf+bounces-44042-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 063BA9BCE09
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 14:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1E8F1F228BE
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 13:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C5B1D9359;
	Tue,  5 Nov 2024 13:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FjjVto4i"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B8C1D7E28;
	Tue,  5 Nov 2024 13:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730813747; cv=none; b=g6S+KjEh8wwPa6msR9v9bUkpSfT9TRxoVrWlldpo99lJ643JFU1oLJLfgfHbT7BY/lzqbloCbTdV3Rui2wY/3aV12pIZnx8ZuRGhC7SE9ClAXjzoG5Lb/V5bPl+tY+ER5MplRpupcmxwkzteEEwoIvRlE6ZwoTb0UpARZyf2Ayw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730813747; c=relaxed/simple;
	bh=d3uhH5n9FcMxQYCQCXwHMSzfHGCPMLxnVC89hpazmwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZBALyU2flWczhrEHbRPIfht9dW/L/DPEEsHXWXjawf03Q5nRGGdt1BPryAVSVRyqxmaPcGKInEfi5l7XCIJRKJJojybxenItvK57HPKP7v9qo1ptG6CAxDTAWKiUnhC1nnpXB3lKvUDLEj/yQ5tNcYUzZHnivKGOCcTP4UxlYag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FjjVto4i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F646C4CECF;
	Tue,  5 Nov 2024 13:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730813747;
	bh=d3uhH5n9FcMxQYCQCXwHMSzfHGCPMLxnVC89hpazmwc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FjjVto4izTQ/zq3KWjkBieMmke3derMvt0KOTGA+6a0MzvOLE+1f7IQgc/K1aWiai
	 FwoICuI/qxkKieBOeupDw/TeDS3VTrX2h9p7Atz6y/54Kx/U/z1VHRbKXRo0h8xrYF
	 GTNtrNYzHqNV14zHILkObjKE+BmI/WaIUYRCudb/UAg83Z4h+E/YtdVCFvp6aTHeWy
	 v7PgUCG7Tgk03vmhaFHHoH8lBaAiHYDEOQW9c/7CRIMKlWiofFWJb2o+mIv8i5DdYm
	 c4r8ZUp1WoAAM9M29YsFbaDKdlZlNWltIlv6PBg8jKCKm7eZusx4OntKnMQwZlZp6d
	 WK7W1R/3Ikepg==
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
Subject: [RFC bpf-next 09/11] selftests/bpf: Add usdt trigger bench
Date: Tue,  5 Nov 2024 14:34:03 +0100
Message-ID: <20241105133405.2703607-10-jolsa@kernel.org>
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

Adding usdt trigger bench to meassure optimized usdt probes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/bench.c           |  2 +
 .../selftests/bpf/benchs/bench_trigger.c      | 45 +++++++++++++++++++
 .../selftests/bpf/progs/trigger_bench.c       | 10 ++++-
 3 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index 1bd403a5ef7b..dc5121e49623 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -526,6 +526,7 @@ extern const struct bench bench_trig_uprobe_multi_push;
 extern const struct bench bench_trig_uretprobe_multi_push;
 extern const struct bench bench_trig_uprobe_multi_ret;
 extern const struct bench bench_trig_uretprobe_multi_ret;
+extern const struct bench bench_trig_usdt;
 
 extern const struct bench bench_rb_libbpf;
 extern const struct bench bench_rb_custom;
@@ -586,6 +587,7 @@ static const struct bench *benchs[] = {
 	&bench_trig_uretprobe_multi_push,
 	&bench_trig_uprobe_multi_ret,
 	&bench_trig_uretprobe_multi_ret,
+	&bench_trig_usdt,
 	/* ringbuf/perfbuf benchmarks */
 	&bench_rb_libbpf,
 	&bench_rb_custom,
diff --git a/tools/testing/selftests/bpf/benchs/bench_trigger.c b/tools/testing/selftests/bpf/benchs/bench_trigger.c
index 32e9f194d449..bdee8b8362d0 100644
--- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
+++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
@@ -8,6 +8,7 @@
 #include "bench.h"
 #include "trigger_bench.skel.h"
 #include "trace_helpers.h"
+#include "../sdt.h"
 
 #define MAX_TRIG_BATCH_ITERS 1000
 
@@ -333,6 +334,13 @@ static void *uprobe_producer_ret(void *input)
 	return NULL;
 }
 
+static void *uprobe_producer_usdt(void *input)
+{
+	while (true)
+		STAP_PROBE(trigger, usdt);
+	return NULL;
+}
+
 static void usetup(bool use_retprobe, bool use_multi, void *target_addr)
 {
 	size_t uprobe_offset;
@@ -383,6 +391,37 @@ static void usetup(bool use_retprobe, bool use_multi, void *target_addr)
 	}
 }
 
+static void __usdt_setup(const char *provider, const char *name)
+{
+	struct bpf_link *link;
+	int err;
+
+	setup_libbpf();
+
+	ctx.skel = trigger_bench__open();
+	if (!ctx.skel) {
+		fprintf(stderr, "failed to open skeleton\n");
+		exit(1);
+	}
+
+	bpf_program__set_autoload(ctx.skel->progs.bench_trigger_usdt, true);
+
+	err = trigger_bench__load(ctx.skel);
+	if (err) {
+		fprintf(stderr, "failed to load skeleton\n");
+		exit(1);
+	}
+
+	link = bpf_program__attach_usdt(ctx.skel->progs.bench_trigger_usdt,
+					-1 /* all PIDs */, "/proc/self/exe",
+					provider, name, NULL);
+	if (!link) {
+		fprintf(stderr, "failed to attach uprobe!\n");
+		exit(1);
+	}
+	ctx.skel->links.bench_trigger_usdt = link;
+}
+
 static void usermode_count_setup(void)
 {
 	ctx.usermode_counters = true;
@@ -448,6 +487,11 @@ static void uretprobe_multi_ret_setup(void)
 	usetup(true, true /* use_multi */, &uprobe_target_ret);
 }
 
+static void usdt_setup(void)
+{
+	__usdt_setup("trigger", "usdt");
+}
+
 const struct bench bench_trig_syscall_count = {
 	.name = "trig-syscall-count",
 	.validate = trigger_validate,
@@ -506,3 +550,4 @@ BENCH_TRIG_USERMODE(uprobe_multi_ret, ret, "uprobe-multi-ret");
 BENCH_TRIG_USERMODE(uretprobe_multi_nop, nop, "uretprobe-multi-nop");
 BENCH_TRIG_USERMODE(uretprobe_multi_push, push, "uretprobe-multi-push");
 BENCH_TRIG_USERMODE(uretprobe_multi_ret, ret, "uretprobe-multi-ret");
+BENCH_TRIG_USERMODE(usdt, usdt, "usdt");
diff --git a/tools/testing/selftests/bpf/progs/trigger_bench.c b/tools/testing/selftests/bpf/progs/trigger_bench.c
index 044a6d78923e..7b7d4a71e7d4 100644
--- a/tools/testing/selftests/bpf/progs/trigger_bench.c
+++ b/tools/testing/selftests/bpf/progs/trigger_bench.c
@@ -1,8 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2020 Facebook
-#include <linux/bpf.h>
+#include "vmlinux.h"
 #include <asm/unistd.h>
 #include <bpf/bpf_helpers.h>
+#include <bpf/usdt.bpf.h>
 #include <bpf/bpf_tracing.h>
 #include "bpf_misc.h"
 
@@ -138,3 +139,10 @@ int bench_trigger_rawtp(void *ctx)
 	inc_counter();
 	return 0;
 }
+
+SEC("?usdt")
+int bench_trigger_usdt(struct pt_regs *ctx)
+{
+	inc_counter();
+	return 0;
+}
-- 
2.47.0


