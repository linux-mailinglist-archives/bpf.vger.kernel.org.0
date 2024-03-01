Return-Path: <bpf+bounces-23195-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A47F86EB59
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 22:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E7B42802AA
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 21:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3078858AA5;
	Fri,  1 Mar 2024 21:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sb9ecBlR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B056A57322
	for <bpf@vger.kernel.org>; Fri,  1 Mar 2024 21:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709329553; cv=none; b=cx8IXq7TbUi7rzRa+DwdnI/IWPCJIQxKansTYPgVEHimSueT9BtQsDG1lPTMlSRnRouhtwb9e0L2KDlwStlfOW6B9qinnXyDQtfUMiknrzF90cjKn7rsDJKE/f0Mjojp8n0RO4TuFkkiiMYQCuUEjzNROJ7t5MrBwsUvxDyP4jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709329553; c=relaxed/simple;
	bh=Y6bbkdYXbmOKTnG8bEVf/aiR1GJmU1i9EEa3nMxeF8s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VqlZNejhsh4n209a323g3BWelMI1u1ZKfqn6pXljDyjkpvgnXB8AkpTOQAsq1yQuUNpw+3Qkkb9Mobz09CjhSv3+FMDjPM30DHElVqml6XdueFOvaqsXFVD7jM41iz76KqGaMBgSed7okZR9h1KISpLcW9s7pcj5Gv7P+kXwEMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sb9ecBlR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3026C433F1;
	Fri,  1 Mar 2024 21:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709329553;
	bh=Y6bbkdYXbmOKTnG8bEVf/aiR1GJmU1i9EEa3nMxeF8s=;
	h=From:To:Cc:Subject:Date:From;
	b=sb9ecBlRrHbGufPdTE+xKXc3GkmieEdd7Vn6jss22NEerdvGKy2yYXlU+CX3TVlGf
	 iH53Qxe5+t9oRUPOPgvAeYX3JSUec2bD3Y03wBDz9ZtE6W3HxUELt6J68VsH7m0AVn
	 AW4GKeqzkGlt0gbVCGIcOXAlPfcOU8gGS8YhgODwXuDHX31gRkTlsOFAID1H7X23Ue
	 gctihvIhCFMkcKerAX7Nh1onC1s9PxBQWZIq6cu37dr7bHlzDAoPjxXFJyxN2CTG7G
	 LuJCOosuJxeZCP41NT3lfjdKtWXKTPJYqkPEOfvF3oVYB/jrSovalDogvLYHCEuAxz
	 iUqbEp+dW3RQQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next] selftests/bpf: extend uprobe/uretprobe triggering benchmarks
Date: Fri,  1 Mar 2024 13:45:51 -0800
Message-ID: <20240301214551.1686095-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Settle on three "flavors" of uprobe/uretprobe, installed on different
kinds of instruction: nop, push, and ret. All three are testing
different internal code paths emulating or single-stepping instructions,
so are interesting to compare and benchmark separately.

To ensure `push rbp` instruction we ensure that uprobe_target_push() is
not a leaf function by calling (global __weak) noop function and
returning something afterwards (if we don't do that, compiler will just
do a tail call optimization).

Also, we need to make sure that compiler isn't skipping frame pointer
generation, so let's add `-fno-omit-frame-pointers` to Makefile.

Just to give an idea of where we currently stand in terms of relative
performance of different uprobe/uretprobe cases vs a cheap syscall
(getpgid()) baseline, here are results from my local machine:

$ benchs/run_bench_uprobes.sh
base           :    1.561 ± 0.020M/s
uprobe-nop     :    0.947 ± 0.007M/s
uprobe-push    :    0.951 ± 0.004M/s
uprobe-ret     :    0.443 ± 0.007M/s
uretprobe-nop  :    0.471 ± 0.013M/s
uretprobe-push :    0.483 ± 0.004M/s
uretprobe-ret  :    0.306 ± 0.007M/s

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/Makefile          |   2 +-
 tools/testing/selftests/bpf/bench.c           |  20 +--
 .../selftests/bpf/benchs/bench_trigger.c      | 118 ++++++++++++------
 .../selftests/bpf/benchs/run_bench_uprobes.sh |   9 ++
 4 files changed, 103 insertions(+), 46 deletions(-)
 create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_uprobes.sh

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index a38a3001527c..eccba9f3a77d 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -34,7 +34,7 @@ LIBELF_CFLAGS	:= $(shell $(PKG_CONFIG) libelf --cflags 2>/dev/null)
 LIBELF_LIBS	:= $(shell $(PKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)
 
 CFLAGS += -g $(OPT_FLAGS) -rdynamic					\
-	  -Wall -Werror 						\
+	  -Wall -Werror -fno-omit-frame-pointer				\
 	  $(GENFLAGS) $(SAN_CFLAGS) $(LIBELF_CFLAGS)			\
 	  -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)		\
 	  -I$(TOOLSINCDIR) -I$(APIDIR) -I$(OUTPUT)
diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index 73ce11b0547d..c632811f9171 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -499,10 +499,12 @@ extern const struct bench bench_trig_fentry;
 extern const struct bench bench_trig_fentry_sleep;
 extern const struct bench bench_trig_fmodret;
 extern const struct bench bench_trig_uprobe_base;
-extern const struct bench bench_trig_uprobe_with_nop;
-extern const struct bench bench_trig_uretprobe_with_nop;
-extern const struct bench bench_trig_uprobe_without_nop;
-extern const struct bench bench_trig_uretprobe_without_nop;
+extern const struct bench bench_trig_uprobe_nop;
+extern const struct bench bench_trig_uretprobe_nop;
+extern const struct bench bench_trig_uprobe_push;
+extern const struct bench bench_trig_uretprobe_push;
+extern const struct bench bench_trig_uprobe_ret;
+extern const struct bench bench_trig_uretprobe_ret;
 extern const struct bench bench_rb_libbpf;
 extern const struct bench bench_rb_custom;
 extern const struct bench bench_pb_libbpf;
@@ -541,10 +543,12 @@ static const struct bench *benchs[] = {
 	&bench_trig_fentry_sleep,
 	&bench_trig_fmodret,
 	&bench_trig_uprobe_base,
-	&bench_trig_uprobe_with_nop,
-	&bench_trig_uretprobe_with_nop,
-	&bench_trig_uprobe_without_nop,
-	&bench_trig_uretprobe_without_nop,
+	&bench_trig_uprobe_nop,
+	&bench_trig_uretprobe_nop,
+	&bench_trig_uprobe_push,
+	&bench_trig_uretprobe_push,
+	&bench_trig_uprobe_ret,
+	&bench_trig_uretprobe_ret,
 	&bench_rb_libbpf,
 	&bench_rb_custom,
 	&bench_pb_libbpf,
diff --git a/tools/testing/selftests/bpf/benchs/bench_trigger.c b/tools/testing/selftests/bpf/benchs/bench_trigger.c
index dbd362771d6a..a8ed8afff0b3 100644
--- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
+++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
@@ -113,12 +113,25 @@ static void trigger_fmodret_setup(void)
  * GCC doesn't generate stack setup preample for these functions due to them
  * having no input arguments and doing nothing in the body.
  */
-__weak void uprobe_target_with_nop(void)
+__weak void uprobe_target_nop(void)
 {
 	asm volatile ("nop");
 }
 
-__weak void uprobe_target_without_nop(void)
+__weak void opaque_noop_func()
+{
+}
+
+__weak int uprobe_target_push(void)
+{
+	/* overhead of function call is negligible compared to uprobe
+	 * triggering, so this shouldn't affect benchmark results much
+	 */
+	opaque_noop_func();
+	return 1;
+}
+
+__weak void uprobe_target_ret(void)
 {
 	asm volatile ("");
 }
@@ -126,27 +139,34 @@ __weak void uprobe_target_without_nop(void)
 static void *uprobe_base_producer(void *input)
 {
 	while (true) {
-		uprobe_target_with_nop();
+		uprobe_target_nop();
 		atomic_inc(&base_hits.value);
 	}
 	return NULL;
 }
 
-static void *uprobe_producer_with_nop(void *input)
+static void *uprobe_producer_nop(void *input)
+{
+	while (true)
+		uprobe_target_nop();
+	return NULL;
+}
+
+static void *uprobe_producer_push(void *input)
 {
 	while (true)
-		uprobe_target_with_nop();
+		uprobe_target_push();
 	return NULL;
 }
 
-static void *uprobe_producer_without_nop(void *input)
+static void *uprobe_producer_ret(void *input)
 {
 	while (true)
-		uprobe_target_without_nop();
+		uprobe_target_ret();
 	return NULL;
 }
 
-static void usetup(bool use_retprobe, bool use_nop)
+static void usetup(bool use_retprobe, void *target_addr)
 {
 	size_t uprobe_offset;
 	struct bpf_link *link;
@@ -159,11 +179,7 @@ static void usetup(bool use_retprobe, bool use_nop)
 		exit(1);
 	}
 
-	if (use_nop)
-		uprobe_offset = get_uprobe_offset(&uprobe_target_with_nop);
-	else
-		uprobe_offset = get_uprobe_offset(&uprobe_target_without_nop);
-
+	uprobe_offset = get_uprobe_offset(target_addr);
 	link = bpf_program__attach_uprobe(ctx.skel->progs.bench_trigger_uprobe,
 					  use_retprobe,
 					  -1 /* all PIDs */,
@@ -176,24 +192,34 @@ static void usetup(bool use_retprobe, bool use_nop)
 	ctx.skel->links.bench_trigger_uprobe = link;
 }
 
-static void uprobe_setup_with_nop(void)
+static void uprobe_setup_nop(void)
+{
+	usetup(false, &uprobe_target_nop);
+}
+
+static void uretprobe_setup_nop(void)
+{
+	usetup(true, &uprobe_target_nop);
+}
+
+static void uprobe_setup_push(void)
 {
-	usetup(false, true);
+	usetup(false, &uprobe_target_push);
 }
 
-static void uretprobe_setup_with_nop(void)
+static void uretprobe_setup_push(void)
 {
-	usetup(true, true);
+	usetup(true, &uprobe_target_push);
 }
 
-static void uprobe_setup_without_nop(void)
+static void uprobe_setup_ret(void)
 {
-	usetup(false, false);
+	usetup(false, &uprobe_target_ret);
 }
 
-static void uretprobe_setup_without_nop(void)
+static void uretprobe_setup_ret(void)
 {
-	usetup(true, false);
+	usetup(true, &uprobe_target_ret);
 }
 
 const struct bench bench_trig_base = {
@@ -274,37 +300,55 @@ const struct bench bench_trig_uprobe_base = {
 	.report_final = hits_drops_report_final,
 };
 
-const struct bench bench_trig_uprobe_with_nop = {
-	.name = "trig-uprobe-with-nop",
-	.setup = uprobe_setup_with_nop,
-	.producer_thread = uprobe_producer_with_nop,
+const struct bench bench_trig_uprobe_nop = {
+	.name = "trig-uprobe-nop",
+	.setup = uprobe_setup_nop,
+	.producer_thread = uprobe_producer_nop,
+	.measure = trigger_measure,
+	.report_progress = hits_drops_report_progress,
+	.report_final = hits_drops_report_final,
+};
+
+const struct bench bench_trig_uretprobe_nop = {
+	.name = "trig-uretprobe-nop",
+	.setup = uretprobe_setup_nop,
+	.producer_thread = uprobe_producer_nop,
+	.measure = trigger_measure,
+	.report_progress = hits_drops_report_progress,
+	.report_final = hits_drops_report_final,
+};
+
+const struct bench bench_trig_uprobe_push = {
+	.name = "trig-uprobe-push",
+	.setup = uprobe_setup_push,
+	.producer_thread = uprobe_producer_push,
 	.measure = trigger_measure,
 	.report_progress = hits_drops_report_progress,
 	.report_final = hits_drops_report_final,
 };
 
-const struct bench bench_trig_uretprobe_with_nop = {
-	.name = "trig-uretprobe-with-nop",
-	.setup = uretprobe_setup_with_nop,
-	.producer_thread = uprobe_producer_with_nop,
+const struct bench bench_trig_uretprobe_push = {
+	.name = "trig-uretprobe-push",
+	.setup = uretprobe_setup_push,
+	.producer_thread = uprobe_producer_push,
 	.measure = trigger_measure,
 	.report_progress = hits_drops_report_progress,
 	.report_final = hits_drops_report_final,
 };
 
-const struct bench bench_trig_uprobe_without_nop = {
-	.name = "trig-uprobe-without-nop",
-	.setup = uprobe_setup_without_nop,
-	.producer_thread = uprobe_producer_without_nop,
+const struct bench bench_trig_uprobe_ret = {
+	.name = "trig-uprobe-ret",
+	.setup = uprobe_setup_ret,
+	.producer_thread = uprobe_producer_ret,
 	.measure = trigger_measure,
 	.report_progress = hits_drops_report_progress,
 	.report_final = hits_drops_report_final,
 };
 
-const struct bench bench_trig_uretprobe_without_nop = {
-	.name = "trig-uretprobe-without-nop",
-	.setup = uretprobe_setup_without_nop,
-	.producer_thread = uprobe_producer_without_nop,
+const struct bench bench_trig_uretprobe_ret = {
+	.name = "trig-uretprobe-ret",
+	.setup = uretprobe_setup_ret,
+	.producer_thread = uprobe_producer_ret,
 	.measure = trigger_measure,
 	.report_progress = hits_drops_report_progress,
 	.report_final = hits_drops_report_final,
diff --git a/tools/testing/selftests/bpf/benchs/run_bench_uprobes.sh b/tools/testing/selftests/bpf/benchs/run_bench_uprobes.sh
new file mode 100755
index 000000000000..9bdcc74e03a4
--- /dev/null
+++ b/tools/testing/selftests/bpf/benchs/run_bench_uprobes.sh
@@ -0,0 +1,9 @@
+#!/bin/bash
+
+set -eufo pipefail
+
+for i in base {uprobe,uretprobe}-{nop,push,ret}
+do
+	summary=$(sudo ./bench -w2 -d5 -a trig-$i | tail -n1 | cut -d'(' -f1 | cut -d' ' -f3-)
+	printf "%-15s: %s\n" $i "$summary"
+done
-- 
2.43.0


