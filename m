Return-Path: <bpf+bounces-67295-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03711B4231E
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 16:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B2087BE620
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 14:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7EF30EF6B;
	Wed,  3 Sep 2025 14:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WL/gpBL0"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE04E2C21E1
	for <bpf@vger.kernel.org>; Wed,  3 Sep 2025 14:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756908305; cv=none; b=fhYrtGlQpNAt1NjLI6JoODb8MUBYtvuTHNhrqEcaGDnfMpm3tkIVTvvzxv5ZYjiJOQ9r57nEPGkz4DulK7Ntn4Hx70dOWwDWpaiDd2OcxUx7a7NwKHY8hl1WwiFNwI4LX+GmGoc7wBIs/YGKuhw3yFx7SqgUwkbDUnw5WrFCcfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756908305; c=relaxed/simple;
	bh=/4IioYM7RfTcIkRryrZZz1i94WxHEcIYyGLmMmYRpg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZMf7OcbHzBSzivORutMmhqlAKuif1wpDq399b4/tAM+CcRf/M8BKd3etzF+ljvlIb6W9xviix9o+LbF6YiCPBgeT5lP0rEHRKL3jgXyq1u8pMIWAMyFquQT687YN3wxkHq/RB/ing2kTYtGBRKRVvMOyDFtHni9fywGiYaRF+l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WL/gpBL0; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756908301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e6nxrlqRMtFeHnZoqd20NO5GeXFFEYe5HOjLj6zAn9Y=;
	b=WL/gpBL046bRup6eWP0zel+f8FTXHYjFeqJsmCcbNoR82c1s87/AiGYX3JDRXVmpPdvT+L
	EA3dqQHwGRA11051LZG6ma6NLcMWtcywY62gvo+AXMt1XYYjjjMzvlDBSW4BQQulv/rlZa
	gi70CCjix2xFDeUmBBFlDptoBVGqalQ=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kernel-patches-bot@fb.com,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: Add case to test bpf_in_interrupt()
Date: Wed,  3 Sep 2025 22:04:38 +0800
Message-ID: <20250903140438.59517-3-leon.hwang@linux.dev>
In-Reply-To: <20250903140438.59517-1-leon.hwang@linux.dev>
References: <20250903140438.59517-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add a timer test case to test 'bpf_in_interrupt()'.

cd tools/testing/selftests/bpf
./test_progs -t timer_interrupt
462     timer_interrupt:OK
Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../testing/selftests/bpf/prog_tests/timer.c  | 30 ++++++++++++
 .../selftests/bpf/progs/timer_interrupt.c     | 48 +++++++++++++++++++
 2 files changed, 78 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/timer_interrupt.c

diff --git a/tools/testing/selftests/bpf/prog_tests/timer.c b/tools/testing/selftests/bpf/prog_tests/timer.c
index d66687f1ee6a..049efb5e7823 100644
--- a/tools/testing/selftests/bpf/prog_tests/timer.c
+++ b/tools/testing/selftests/bpf/prog_tests/timer.c
@@ -3,6 +3,7 @@
 #include <test_progs.h>
 #include "timer.skel.h"
 #include "timer_failure.skel.h"
+#include "timer_interrupt.skel.h"

 #define NUM_THR 8

@@ -95,3 +96,32 @@ void serial_test_timer(void)

 	RUN_TESTS(timer_failure);
 }
+
+void test_timer_interrupt(void)
+{
+	struct timer_interrupt *skel = NULL;
+	int err, prog_fd;
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+
+	skel = timer_interrupt__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "timer_interrupt__open_and_load"))
+		return;
+
+	err = timer_interrupt__attach(skel);
+	if (!ASSERT_OK(err, "timer_interrupt__attach"))
+		goto out;
+
+	prog_fd = bpf_program__fd(skel->progs.test_timer_interrupt);
+	err = bpf_prog_test_run_opts(prog_fd, &opts);
+	if (!ASSERT_OK(err, "bpf_prog_test_run_opts"))
+		goto out;
+
+	usleep(50);
+
+	ASSERT_EQ(skel->bss->in_interrupt, 0, "in_interrupt");
+	if (skel->bss->preempt_count)
+		ASSERT_NEQ(skel->bss->in_interrupt_cb, 0, "in_interrupt_cb");
+
+out:
+	timer_interrupt__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/timer_interrupt.c b/tools/testing/selftests/bpf/progs/timer_interrupt.c
new file mode 100644
index 000000000000..19180a455f40
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/timer_interrupt.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_experimental.h"
+
+char _license[] SEC("license") = "GPL";
+
+#define CLOCK_MONOTONIC		1
+
+int preempt_count;
+int in_interrupt;
+int in_interrupt_cb;
+
+struct elem {
+	struct bpf_timer t;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct elem);
+} array SEC(".maps");
+
+static int timer_in_interrupt(void *map, int *key, struct bpf_timer *timer)
+{
+	preempt_count = get_preempt_count();
+	in_interrupt_cb = bpf_in_interrupt();
+	return 0;
+}
+
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(test_timer_interrupt)
+{
+	struct bpf_timer *timer;
+	int key = 0;
+
+	timer = bpf_map_lookup_elem(&array, &key);
+	if (!timer)
+		return 0;
+
+	in_interrupt = bpf_in_interrupt();
+	bpf_timer_init(timer, &array, CLOCK_MONOTONIC);
+	bpf_timer_set_callback(timer, timer_in_interrupt);
+	bpf_timer_start(timer, 0, 0);
+	return 0;
+}
--
2.51.0


