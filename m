Return-Path: <bpf+bounces-65788-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 481CCB2864B
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 21:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5B1760696E
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 19:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B5429ACC2;
	Fri, 15 Aug 2025 19:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WsRREE2Y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26316347DD
	for <bpf@vger.kernel.org>; Fri, 15 Aug 2025 19:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755285732; cv=none; b=egxFKXUr3Ip88OawBqhvmWnyY/9DPuR9coEm3SD5TbclOptv4pApdvM+aJKeQu23WB69qp4SKrkG2ScB3oANjD9Xo21Vns1jW3DyA1dvjlEMZQNTQA2ZfCvBcv29eY3WenjdKjFiEimcFL7Ov9rfwIKoW0oWQXuVwPDPZo0+PII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755285732; c=relaxed/simple;
	bh=Ky4nKn+jyI07qd8j2R4lOaOji4/KrEuHbg0v3qqE3AE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sA7LKx7ShkjacBXeDiiTF0vGBCgQ0vzjfA+rXv9wLK82AwUgkHHqK8+pZOVFnglHAkvL2sXU1Wtd7jXa7UqWMwk1rNVlI8XtXXe8Vkv1nC5qF0W/R20UQg3l91SOTuuIMx4BFv8v4/2VBN+Mv/lWTg808el9QJhdq5V7POBzUVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WsRREE2Y; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b9e415a68eso1332725f8f.2
        for <bpf@vger.kernel.org>; Fri, 15 Aug 2025 12:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755285728; x=1755890528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tRVvgqJZy+CidJFBGA0LRyk/iusEh+2LaYjnys2WM2U=;
        b=WsRREE2YlqAA5M3HsWI9ohMFSYVtAsgvkpYFd2TG77RdoNKdukHzr9wfFOl5hDaP6+
         dZgFjD94oFSh/nWrw2SsfVwunuCopsQCgtA4varpLhq5JdWuPs4jHK4VnpG2Q2UG8S1n
         co/Gx5hvb7jTnmx/Zpi5v1cI94Rmv6N/qX9Y/+FMDm9kXLKKDUTimFxvQvnvTM4YuJlk
         YLLuOnPVK1Op3n231bLUFMB75XzizN+pc/YPbL700d2YXxqxlEoZBLQgSFqN5u5oA7ht
         mhGWPWJpu9tac8L1uJviyV/W2/gDoEL/s3/QFRMhD+7QTGE31YU+zTxiMOO8crMZgB3X
         Y/tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755285728; x=1755890528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tRVvgqJZy+CidJFBGA0LRyk/iusEh+2LaYjnys2WM2U=;
        b=CaZO0MFaZVVwZD52HLXir8GWB316zF2EHUBJ13A1mXaKGP2ID1N54fDuUdj6Vwc5o+
         /Jlm+X7w5ghfTrP6qwEnrMh/Oqpv/NRyQFsgpD9LZYIadfnU7wHj6kooinQknZ46dwmk
         X0nanrJ0dJpoMd1Q2WOjSYnuHivH3+ZSWmRwHzs9T0kkSZAKa0a3PxfggqHxOw48LvP8
         4WOcGktzwf7rw69Fi4kakgqQG8zMENOob/QhxZrZKEtWW+t6KgxAAgoYbTYkmieomYDA
         7VPOYTKAYI6y+DKatd3BMnwPdGNf3Ti9Uc74J01X03k6NPaaQNq5Gyz89qi3qGx+Xlqc
         Hu+w==
X-Gm-Message-State: AOJu0Yy26iehSWb8AQ6jzszYYyQ5FYTjyNDcu/DA+nJOzPfTtGfjX1H9
	mC7CcBqNmmHLHwrrj/IsdZBTENzma7pH+lJQmcf2pplZwrmCwEsVlVBLhUij4A==
X-Gm-Gg: ASbGncuSvquS/lxizydrkBy9YHyUmPPi/6Weq2gEk4SdlSNeq503T02LxTBz9roeM+p
	2vdT9AZ8pINFEq8z+q1HgNZHiIQqu4ZY3B/bekM2YhRLY9myNLYbK1BgrzC06fo00WrHJQMRcpm
	ZdAHYQUFvmC9DnisW2PiISpu3NB8fJ7Q9esvPKuAcnItXmMAt7neI3R76jOKXoxUMkt5hMUQPlU
	GYMjncE+6mdC+d2DgJwN16x538+uSQI7izEizes6DWKiMu+7Xi9LrBSu0LdrTguBq4U1OESHon3
	aAgWSM+JRE9jv4qgmnaARvRSviHoxM9Qh/y1JTN8bvhjUSDMo34rMtjJnk6DRKdOA39jg+YWBVC
	y+TQVMjqDtxdDPpVd0ZxA
X-Google-Smtp-Source: AGHT+IFppu5i+fqwNx4avmeHeR/QcDlY3iMww8Me+AppOonj6CBkBs5XL4TtFnFEiQOHHLdXQNIPnw==
X-Received: by 2002:a05:600c:19d3:b0:458:c002:6888 with SMTP id 5b1f17b1804b1-45a218637a8mr21998665e9.32.1755285728391;
        Fri, 15 Aug 2025 12:22:08 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a24e5562csm14787105e9.20.2025.08.15.12.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 12:22:07 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 4/4] selftests/bpf: BPF task work scheduling tests
Date: Fri, 15 Aug 2025 20:21:56 +0100
Message-ID: <20250815192156.272445-5-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815192156.272445-1-mykyta.yatsenko5@gmail.com>
References: <20250815192156.272445-1-mykyta.yatsenko5@gmail.com>
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


