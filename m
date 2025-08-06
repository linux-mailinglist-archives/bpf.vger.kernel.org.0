Return-Path: <bpf+bounces-65132-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3D8B1C7D9
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 16:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7714518A4339
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 14:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E731A3166;
	Wed,  6 Aug 2025 14:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SaoyIXi/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623F315B135
	for <bpf@vger.kernel.org>; Wed,  6 Aug 2025 14:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754491583; cv=none; b=ne+d4C5/iL1s2AqF+Ffd/d+uBcHE3bhujXntCLY2OY6veZTARnuJQYSqOhEhSz/zSy54jEEfyd0rN3zZBBjSzlRaZt7StJXywB7W4EmELO/7T81lfy4WEbi8ShW3boFk/yvUXWtrWq57spJf1rd8R72HGOzA1d3mugX05UU9u9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754491583; c=relaxed/simple;
	bh=Ky4nKn+jyI07qd8j2R4lOaOji4/KrEuHbg0v3qqE3AE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VM+Ea9Mih2cakEPbVpQTl7XeEZfW5+FIL1C+g/kmtoDmB9HwjNJ8hwEaveT2x7TszN3I7SA0ACA3/J+aT7bqnAV+DADQMHpAo5pbKcG0AZCmqxiBVNRWKUB01GeCfTQuRZ9j3RHBMFDgf6Ciswk+QURe8p9+loKTD2V7qNrb7eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SaoyIXi/; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-458bdde7dedso16845e9.0
        for <bpf@vger.kernel.org>; Wed, 06 Aug 2025 07:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754491580; x=1755096380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tRVvgqJZy+CidJFBGA0LRyk/iusEh+2LaYjnys2WM2U=;
        b=SaoyIXi/Iw4Ndl4dGvpYHux7c6F6CP85LuEHjnuXpzDDfaEAh/BaXDZQ1XMkJS8FVq
         xoKKzfZncDEmnIP//qmPygKSYeR0lreq23tTllUf9Jpb675+WoMT++RZilSZL2qwuANU
         rmrVD6+2nGxP+6z2II6TTTjs7VZ+j7ocqInz9Yy6emmEwz8ozP5b/KQ+QeBSTu78/tw0
         yI0yVCRc1Z33GY360+Ze/aEm7ut73zDma2UXp0x/4ilnjLJOkp+U3gxhAlZXvKoA1gmF
         qhq9TwlWkYnfhz3RkRbgkiwW9xsaWy3q9Zukbael9q1m+jo1HXMfWfyk+5KVshi4+imt
         Y1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754491580; x=1755096380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tRVvgqJZy+CidJFBGA0LRyk/iusEh+2LaYjnys2WM2U=;
        b=wk4AQsXP7do3jipjHbZbnqOQUyA+DzpgoGw+Uspgxp+gMK4BnXX/SFpUprpmM3Sqbw
         J79EuSJ8JuxvP1qeyHjzam/dicQKev11vY8efc47t3vybNnBRGD6/CxguAtXLfXvgBtL
         FwZBjr+vIMu/3xWomkahGwfeDUQxXkIZEInwJMUrIQ4Ulle+MsKa02HlgX72HZj55mCa
         AMSqhatIbvh3BMyutJagJCNu9wB1Cx3Mc2fe26PrfIxtnc9tqLOtSGTuRS9MMHXQEgKX
         16yKcIoa6ra6k0w+21RvbMSD/9NgEjjYD0cASYHRUQU9sc4PKMVw68YDor/j+slhuP9q
         Up9g==
X-Gm-Message-State: AOJu0Yz+24iV8tepmGCGSJVAgh2D4dC7vTYgLQhLBNkkoOmDXrwUHwcG
	vvJOsfnSVmDxB86pxCbgF0cFJ2wgrjAKiThZwWHqi2JgInsOy8KtK+u3wFSphQ==
X-Gm-Gg: ASbGncsTy4aN6rULO5hvsKVTLtIN+vEreP3Aj+ulwZzeGzs70MIhPCIqA4LsIVq+/3U
	oLZwJfAE2VHIJw+fb274Lb0iXnIk+hCtt0qPLSX565ig9GSEO0P5Q6NtOhtWZBGtcRD1HcWPzvs
	0yrif1A0fKgWKxp6R6vAW6bbkpdqF65ij8fS5bCeCZbK43SW/Ul6lWzSkRcLPHuAh1TD5drIP0o
	ogwFhHzWsTp2wSOgFADBQhbXuPj0leL4h4lo8xgo5lbmqZNLNZ52Nx514zl1KIuljiy0Wd3E+Fj
	Lw543xGo4clt3C3KycuBP0EAcz8jVAj8lg7Qi9NYKhgjTSkznPxiQNWmq1o3SRBWZKx1Qtkm4ix
	W
X-Google-Smtp-Source: AGHT+IF/q9d8ZYnXLPsZQ8CoRKzJnqpwYjYLFszNqr3aanWfRHQ0EUKYIBTMENCbcOd9pH+CaHzs6w==
X-Received: by 2002:a05:6000:2885:b0:3b7:58be:8fc with SMTP id ffacd0b85a97d-3b8f41b4fb4mr2565172f8f.43.1754491579580;
        Wed, 06 Aug 2025 07:46:19 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::7:ba0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8e04c7407sm13572015f8f.13.2025.08.06.07.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 07:46:19 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next 4/4] selftests/bpf: BPF task work scheduling tests
Date: Wed,  6 Aug 2025 15:45:24 +0100
Message-ID: <20250806144554.576706-5-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250806144554.576706-1-mykyta.yatsenko5@gmail.com>
References: <20250806144554.576706-1-mykyta.yatsenko5@gmail.com>
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
---
 .../selftests/bpf/prog_tests/test_task_work.c | 149 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/task_work.c | 108 +++++++++++++
 .../selftests/bpf/progs/task_work_fail.c      |  98 ++++++++++++
 3 files changed, 355 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_task_work.c
 create mode 100644 tools/testing/selftests/bpf/progs/task_work.c
 create mode 100644 tools/testing/selftests/bpf/progs/task_work_fail.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_task_work.c b/tools/testing/selftests/bpf/prog_tests/test_task_work.c
new file mode 100644
index 000000000000..9c3c7a46a827
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_task_work.c
@@ -0,0 +1,149 @@
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
+	bpf_program__set_type(prog, BPF_PROG_TYPE_PERF_EVENT);
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
index 000000000000..5e761b4a5fd1
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/task_work.c
@@ -0,0 +1,108 @@
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
+static void process_work(struct bpf_map *map, void *key, void *value)
+{
+	struct elem *work = value;
+
+	bpf_copy_from_user_str(work->data, sizeof(work->data), (const void *)user_ptr, 0);
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
+	bpf_task_work_schedule_resume(task, &work->tw, (struct bpf_map *)&hmap, process_work, NULL);
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
+	bpf_task_work_schedule_signal(task, &work->tw, (struct bpf_map *)&arrmap, process_work,
+				      NULL);
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
+	bpf_task_work_schedule_resume(task, &work->tw, (struct bpf_map *)&lrumap, process_work,
+				      NULL);
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/task_work_fail.c b/tools/testing/selftests/bpf/progs/task_work_fail.c
new file mode 100644
index 000000000000..fca7052b805e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/task_work_fail.c
@@ -0,0 +1,98 @@
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
+static void process_work(struct bpf_map *map, void *key, void *value)
+{
+	struct elem *work = value;
+
+	bpf_copy_from_user_str(work->data, sizeof(work->data), (const void *)user_ptr, 0);
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
+	bpf_task_work_schedule_resume(task, &work->tw, (struct bpf_map *)&hmap,
+				      process_work, NULL);
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
+	bpf_task_work_schedule_resume(task, &tw, (struct bpf_map *)&hmap,
+				      process_work, NULL);
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
+	bpf_task_work_schedule_resume(task, NULL, (struct bpf_map *)&hmap,
+				      process_work, NULL);
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
2.50.1


