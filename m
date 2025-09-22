Return-Path: <bpf+bounces-69286-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25870B9393A
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 01:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE1AF1907020
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 23:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31342FDC25;
	Mon, 22 Sep 2025 23:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NzfcgTDg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802743168E5
	for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 23:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758583593; cv=none; b=NeiT1ZFEm+lmnSaNh3r4FmKbZtTWvSbzOweOVW83F7HlfQQHJBFaDO4IJa1WeoGd6t9kPixtbgIaRxV1r9mtMNUca/sXQCJmqKuvO3fQtwhTX2TAmW/GK++Kug9jKjSjkf3tv/Dbw/khdRoU6lIgUeTR/p1N9VPDCelR92ukDu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758583593; c=relaxed/simple;
	bh=evdacfZwRlgDC7JgYKu3Ayj+24mLoSicv0Tbl0D7lQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bIa5L1tZu0S9FO89/V3/tR86lwrAbS2GidHKWRq3qeB3C6V7y887NsRgxkEC+OJBskhfsuHWUy79OZf/PR+Wm611gLIDZLUAI9ZUg7EBMgnR3ZBzj0uiwZ1+9Uodz4TCGF3rj4U0vbCUdvdsm4AyLSZdnxFp04RrePgbddNUBVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NzfcgTDg; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-62f0702ef0dso11322192a12.1
        for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 16:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758583590; x=1759188390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Ej+IqPfCCXkujjDk6U64eXr5CXpcq6SG4SjvBftbao=;
        b=NzfcgTDgxIFwEv656Ge2vU0hYz/En3Y/TDYZK+E4RER9ge/isDUxMrgK8/LsBjZh0R
         wE2fEYr5l0ihbthTCEbpNTujOiJS9XuULeAdQFnMY//cVkL7fkEewUo67DJz5CGnItnc
         bghzS5jsGktDuTDwPbCMd+e87+PRc9oXQp7ZDhYUz0xDULKZ3eovG2oESzs5XjLx6dtJ
         kvRXkJ5n/LxuvWMzPluv1//dFrNaHv30SDprZFja01ZlI3h+tcuNUfgMYcMWwu0O3U+N
         /tBP8rtCfsyFDIiayRrqOhLe2/Wh6p7pRQv3tkFUQEM6BrQ18b/zIgkXVlKC0Mk1oqvH
         nTJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758583590; x=1759188390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Ej+IqPfCCXkujjDk6U64eXr5CXpcq6SG4SjvBftbao=;
        b=EpWsBf33b7l474f5jLflttzrhO1t5K5mJf/daCvsk1JFPiIYPlw4OGTHtmlylEJxao
         bayZM5k2R4N2JNYcs66koKaTrMBb/KG6GEwRjyWRu29FxELkxsR3bOflZMssw01D8ghm
         fu3yYpRNkZBSwa/ebf8GAB6jFD0XmZbFk1HjAuje0D9QerVX/dskaCco2FHJEJ8Uv+JJ
         2bQCpZdxl0j56JR1CYxQIi49sUG/sbdzJeLI2GuX3GuM3JNKnx8hK2M4Kh89n0XOBKP5
         x0nwvUOaf9mzq3HP02uaBOvqy8L9girA87Yftn8BNUnOQqYlPCxyD7uHFb7LAks7l7JG
         kNhQ==
X-Gm-Message-State: AOJu0Yy0HcSaODg/JN3ZMs12KpdiB0q+G0fHWzn2rRaY6MKN2jKOYM5l
	mvXiYAPURJCnAJz21NeAp7jJZwLtPpZkmosmtzEctcyRNJ0r1bJOt4v+BtZWsw==
X-Gm-Gg: ASbGncvWjU+fZa4SlpSA2UT6fsMIhFaNN7ZUoMag9q9vrgMuKMFDAHXCP5PQ55Y090C
	nerjSG2ERTX8PWg8AsDGyKLD5jQzu3czlphwUZa6wX37LbulooTVhseiLiijHcOLOhuqQwNok9e
	S+5KZqg6lEpAoM6xMTZwqOZQB/rv/UD3bFSDJmgdL7W8aSmlZW8l27HvBXMBKZPdJrqHaz1Oksd
	P70TbuRv8XWfrmh7QuJYsMMZwo/9jtgsQz6fONsYOyznK3AB2jCGQHR8f8r3y+TQeTXxrglzHcK
	jPDD2ZMmjdHUq7bCzi7kCdqYbk/iwZ/9a4wo8rBfaeOrCJl5fjEEMqrKSgVTeAiZNMsYLLRRAl+
	lXCf2wsZFZ0zvFa3MVTAa
X-Google-Smtp-Source: AGHT+IFSiUnyd98Z65VbnZ6Q2H3Fvljodu7fvi4sLjgYoY5t5O+V24Xf4/Xg0IL0S/ulNlBnDkUI4w==
X-Received: by 2002:a50:d51e:0:b0:62f:9091:ff30 with SMTP id 4fb4d7f45d1cf-63467bfae95mr272954a12.3.1758583589642;
        Mon, 22 Sep 2025 16:26:29 -0700 (PDT)
Received: from localhost ([2a02:8109:a307:d900:29a2:6d8:baf5:4284])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62fa5f1221fsm9903567a12.32.2025.09.22.16.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 16:26:29 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v7 8/9] selftests/bpf: BPF task work scheduling tests
Date: Tue, 23 Sep 2025 00:26:09 +0100
Message-ID: <20250922232611.614512-9-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922232611.614512-1-mykyta.yatsenko5@gmail.com>
References: <20250922232611.614512-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Introducing selftests that check BPF task work scheduling mechanism.
Validate that verifier does not accepts incorrect calls to
bpf_task_work_schedule kfunc.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/test_task_work.c | 150 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/task_work.c | 107 +++++++++++++
 .../selftests/bpf/progs/task_work_fail.c      |  96 +++++++++++
 3 files changed, 353 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_task_work.c
 create mode 100644 tools/testing/selftests/bpf/progs/task_work.c
 create mode 100644 tools/testing/selftests/bpf/progs/task_work_fail.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_task_work.c b/tools/testing/selftests/bpf/prog_tests/test_task_work.c
new file mode 100644
index 000000000000..666585270fbf
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_task_work.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+#include <string.h>
+#include <stdio.h>
+#include "task_work.skel.h"
+#include "task_work_fail.skel.h"
+#include <linux/bpf.h>
+#include <linux/perf_event.h>
+#include <sys/syscall.h>
+#include <time.h>
+
+static int perf_event_open(__u32 type, __u64 config, int pid)
+{
+	struct perf_event_attr attr = {
+		.type = type,
+		.config = config,
+		.size = sizeof(struct perf_event_attr),
+		.sample_period = 100000,
+	};
+
+	return syscall(__NR_perf_event_open, &attr, pid, -1, -1, 0);
+}
+
+struct elem {
+	char data[128];
+	struct bpf_task_work tw;
+};
+
+static int verify_map(struct bpf_map *map, const char *expected_data)
+{
+	int err;
+	struct elem value;
+	int processed_values = 0;
+	int k, sz;
+
+	sz = bpf_map__max_entries(map);
+	for (k = 0; k < sz; ++k) {
+		err = bpf_map__lookup_elem(map, &k, sizeof(int), &value, sizeof(struct elem), 0);
+		if (err)
+			continue;
+		if (!ASSERT_EQ(strcmp(expected_data, value.data), 0, "map data")) {
+			fprintf(stderr, "expected '%s', found '%s' in %s map", expected_data,
+				value.data, bpf_map__name(map));
+			return 2;
+		}
+		processed_values++;
+	}
+
+	return processed_values == 0;
+}
+
+static void task_work_run(const char *prog_name, const char *map_name)
+{
+	struct task_work *skel;
+	struct bpf_program *prog;
+	struct bpf_map *map;
+	struct bpf_link *link;
+	int err, pe_fd = 0, pid, status, pipefd[2];
+	char user_string[] = "hello world";
+
+	if (!ASSERT_NEQ(pipe(pipefd), -1, "pipe"))
+		return;
+
+	pid = fork();
+	if (pid == 0) {
+		__u64 num = 1;
+		int i;
+		char buf;
+
+		close(pipefd[1]);
+		read(pipefd[0], &buf, sizeof(buf));
+		close(pipefd[0]);
+
+		for (i = 0; i < 10000; ++i)
+			num *= time(0) % 7;
+		(void)num;
+		exit(0);
+	}
+	ASSERT_GT(pid, 0, "fork() failed");
+
+	skel = task_work__open();
+	if (!ASSERT_OK_PTR(skel, "task_work__open"))
+		return;
+
+	bpf_object__for_each_program(prog, skel->obj) {
+		bpf_program__set_autoload(prog, false);
+	}
+
+	prog = bpf_object__find_program_by_name(skel->obj, prog_name);
+	if (!ASSERT_OK_PTR(prog, "prog_name"))
+		goto cleanup;
+	bpf_program__set_autoload(prog, true);
+	skel->bss->user_ptr = (char *)user_string;
+
+	err = task_work__load(skel);
+	if (!ASSERT_OK(err, "skel_load"))
+		goto cleanup;
+
+	pe_fd = perf_event_open(PERF_TYPE_HARDWARE, PERF_COUNT_HW_CPU_CYCLES, pid);
+	if (pe_fd == -1 && (errno == ENOENT || errno == EOPNOTSUPP)) {
+		printf("%s:SKIP:no PERF_COUNT_HW_CPU_CYCLES\n", __func__);
+		test__skip();
+		goto cleanup;
+	}
+	if (!ASSERT_NEQ(pe_fd, -1, "pe_fd")) {
+		fprintf(stderr, "perf_event_open errno: %d, pid: %d\n", errno, pid);
+		goto cleanup;
+	}
+
+	link = bpf_program__attach_perf_event(prog, pe_fd);
+	if (!ASSERT_OK_PTR(link, "attach_perf_event"))
+		goto cleanup;
+
+	close(pipefd[0]);
+	write(pipefd[1], user_string, 1);
+	close(pipefd[1]);
+	/* Wait to collect some samples */
+	waitpid(pid, &status, 0);
+	pid = 0;
+	map = bpf_object__find_map_by_name(skel->obj, map_name);
+	if (!ASSERT_OK_PTR(map, "find map_name"))
+		goto cleanup;
+	if (!ASSERT_OK(verify_map(map, user_string), "verify map"))
+		goto cleanup;
+cleanup:
+	if (pe_fd >= 0)
+		close(pe_fd);
+	task_work__destroy(skel);
+	if (pid) {
+		close(pipefd[0]);
+		write(pipefd[1], user_string, 1);
+		close(pipefd[1]);
+		waitpid(pid, &status, 0);
+	}
+}
+
+void test_task_work(void)
+{
+	if (test__start_subtest("test_task_work_hash_map"))
+		task_work_run("oncpu_hash_map", "hmap");
+
+	if (test__start_subtest("test_task_work_array_map"))
+		task_work_run("oncpu_array_map", "arrmap");
+
+	if (test__start_subtest("test_task_work_lru_map"))
+		task_work_run("oncpu_lru_map", "lrumap");
+
+	RUN_TESTS(task_work_fail);
+}
diff --git a/tools/testing/selftests/bpf/progs/task_work.c b/tools/testing/selftests/bpf/progs/task_work.c
new file mode 100644
index 000000000000..23217f06a3ec
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/task_work.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <string.h>
+#include <stdbool.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+#include "errno.h"
+
+char _license[] SEC("license") = "GPL";
+
+const void *user_ptr = NULL;
+
+struct elem {
+	char data[128];
+	struct bpf_task_work tw;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct elem);
+} hmap SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct elem);
+} arrmap SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_LRU_HASH);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct elem);
+} lrumap SEC(".maps");
+
+static int process_work(struct bpf_map *map, void *key, void *value)
+{
+	struct elem *work = value;
+
+	bpf_copy_from_user_str(work->data, sizeof(work->data), (const void *)user_ptr, 0);
+	return 0;
+}
+
+int key = 0;
+
+SEC("perf_event")
+int oncpu_hash_map(struct pt_regs *args)
+{
+	struct elem empty_work = { .data = { 0 } };
+	struct elem *work;
+	struct task_struct *task;
+	int err;
+
+	task = bpf_get_current_task_btf();
+	err = bpf_map_update_elem(&hmap, &key, &empty_work, BPF_NOEXIST);
+	if (err)
+		return 0;
+	work = bpf_map_lookup_elem(&hmap, &key);
+	if (!work)
+		return 0;
+
+	bpf_task_work_schedule_resume(task, &work->tw, &hmap, process_work, NULL);
+	return 0;
+}
+
+SEC("perf_event")
+int oncpu_array_map(struct pt_regs *args)
+{
+	struct elem *work;
+	struct task_struct *task;
+
+	task = bpf_get_current_task_btf();
+	work = bpf_map_lookup_elem(&arrmap, &key);
+	if (!work)
+		return 0;
+	bpf_task_work_schedule_signal(task, &work->tw, &arrmap, process_work, NULL);
+	return 0;
+}
+
+SEC("perf_event")
+int oncpu_lru_map(struct pt_regs *args)
+{
+	struct elem empty_work = { .data = { 0 } };
+	struct elem *work;
+	struct task_struct *task;
+	int err;
+
+	task = bpf_get_current_task_btf();
+	work = bpf_map_lookup_elem(&lrumap, &key);
+	if (work)
+		return 0;
+	err = bpf_map_update_elem(&lrumap, &key, &empty_work, BPF_NOEXIST);
+	if (err)
+		return 0;
+	work = bpf_map_lookup_elem(&lrumap, &key);
+	if (!work || work->data[0])
+		return 0;
+	bpf_task_work_schedule_resume(task, &work->tw, &lrumap, process_work, NULL);
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/task_work_fail.c b/tools/testing/selftests/bpf/progs/task_work_fail.c
new file mode 100644
index 000000000000..77fe8f28facd
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/task_work_fail.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <string.h>
+#include <stdbool.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+const void *user_ptr = NULL;
+
+struct elem {
+	char data[128];
+	struct bpf_task_work tw;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct elem);
+} hmap SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct elem);
+} arrmap SEC(".maps");
+
+static int process_work(struct bpf_map *map, void *key, void *value)
+{
+	struct elem *work = value;
+
+	bpf_copy_from_user_str(work->data, sizeof(work->data), (const void *)user_ptr, 0);
+	return 0;
+}
+
+int key = 0;
+
+SEC("perf_event")
+__failure __msg("doesn't match map pointer in R3")
+int mismatch_map(struct pt_regs *args)
+{
+	struct elem *work;
+	struct task_struct *task;
+
+	task = bpf_get_current_task_btf();
+	work = bpf_map_lookup_elem(&arrmap, &key);
+	if (!work)
+		return 0;
+	bpf_task_work_schedule_resume(task, &work->tw, &hmap, process_work, NULL);
+	return 0;
+}
+
+SEC("perf_event")
+__failure __msg("arg#1 doesn't point to a map value")
+int no_map_task_work(struct pt_regs *args)
+{
+	struct task_struct *task;
+	struct bpf_task_work tw;
+
+	task = bpf_get_current_task_btf();
+	bpf_task_work_schedule_resume(task, &tw, &hmap, process_work, NULL);
+	return 0;
+}
+
+SEC("perf_event")
+__failure __msg("Possibly NULL pointer passed to trusted arg1")
+int task_work_null(struct pt_regs *args)
+{
+	struct task_struct *task;
+
+	task = bpf_get_current_task_btf();
+	bpf_task_work_schedule_resume(task, NULL, &hmap, process_work, NULL);
+	return 0;
+}
+
+SEC("perf_event")
+__failure __msg("Possibly NULL pointer passed to trusted arg2")
+int map_null(struct pt_regs *args)
+{
+	struct elem *work;
+	struct task_struct *task;
+
+	task = bpf_get_current_task_btf();
+	work = bpf_map_lookup_elem(&arrmap, &key);
+	if (!work)
+		return 0;
+	bpf_task_work_schedule_resume(task, &work->tw, NULL, process_work, NULL);
+	return 0;
+}
-- 
2.51.0


