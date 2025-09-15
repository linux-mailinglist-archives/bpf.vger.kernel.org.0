Return-Path: <bpf+bounces-68434-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4CDB585F3
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 22:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 454D43A6FFB
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 20:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2A8298CC7;
	Mon, 15 Sep 2025 20:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CiC+MHh/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF35296BD6
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 20:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757967516; cv=none; b=EQhNxoB0U/Rb2Gi7T5DkgCL8ojDuqB1w4JrXAQ05O9lPy83CyO2UArKoSeXNpeR7SNr2NLc4hOA3gF1jr2DVeWNJuXvQzPZO9SwlZ1UoA6Xx7qdBTAPjWBg7CF1tO0Gr15nz8V7I/aNRmY9lwhCXHMBglNMkSu9Jlg2WycAZPkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757967516; c=relaxed/simple;
	bh=bisDtLmGTd7hjh2/yHq3xkqUzaevxEzNFEOKLdClfN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QkpDEYClPo9Rdchm+fbV7uCIA5Kc69LnWA0LjNfj5AuzDrOuIF74FbSg+DVeDFXgCb5Q01eaw21wCSO8XGPiLGvFqXybysXbNeahMCSzgwRqQGlKL/5TpXQO+ta/twleIbephIiOgJJwfqL3d1L/hK4sMsub4gwLRkrOKWP+YJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CiC+MHh/; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45decc9e83eso50757585e9.3
        for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 13:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757967513; x=1758572313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mLJczSyM7sIYJDuOQQUp4M/avZzfGxRapeU1LcflZ30=;
        b=CiC+MHh/KHzSqwMVzrdPP2hR1hq78Sz/z9SMDCJXgJ9YjP5L3S+yQZCtFgtBzzMr3s
         yAtJW8cCnc4nqiH8inwIuM3mKcOrQR2ldas6iS9aNEwzR/tbEJYXUqfIFMrGePTYTOAt
         siUHZ3dgdvu8g4fZmH97GiLv3CjxMk7OsLMuB+/YvlKYncWHb1T0loLZ4H7rue9hBi0k
         Y9WVbsB/1Sb+xruEQTBoFOdRTRyWaMuvL5c3uEBDvJxKLXJ1Wp1h0MeKsWsBOrXpSm0D
         LivfLQhqxEY6jRsSctVUkhDs3ZFnlJfadq1/85KpXbx5zGenk8ye2MNE2hYMIxN7LRa6
         DLIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757967513; x=1758572313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mLJczSyM7sIYJDuOQQUp4M/avZzfGxRapeU1LcflZ30=;
        b=rz2X1W1i1abbgx1Mu8uZ7AHuJwK1Fz6R5Rhjggl6fie1gG4goM9M4WsAiEs5FWx+UQ
         jgMjFWkv54U+6TaCaEP+QLy+UHjeS5QiUr2HZMR8DOZixysO6UAysZR7PQhxAHH+Q/2r
         tmtStEUYi7LouL1riQaLoD1i5U5n9B/pZWpgiAGqWAHRVsCEgMurMLVTi0/Qk8TMVDPn
         PTTaEO+E/NMDQdbelWOdsi2iJZ7mPQIh0+8ZY1Poyukl1byDcfZo6Sn/mtw5dDBMTsen
         19BxM9Yk9oLQqQnSMLp2dQBhSXRAUQRv/B5jI8p48FuoXsNjZBPxy9++Yur4uBFWa3lL
         jacA==
X-Gm-Message-State: AOJu0Yw6Y4t5sQtBteFSHTQaqip7lx3wCym9t1sGPmCri9SRtMx5QyIV
	N4Ql+d08mz9YWcytJ/yw9Ovie0QFdYFMx+ePL9DDNeJv5D6ytGNVlQz7NCUpsw==
X-Gm-Gg: ASbGncvgKUAPuUzFnk05g/dW6W14v3b0OpKDi24h+O/iYCwpjbKNXkdfGGqhXxcoX8i
	uCr8rSnIt9rbWPjUyHoE9lSX30XeYEENt7HQESiCrDjps0oRj2USRyfidFi9MjMYdIHtodAw+6U
	s+CwVJJ6NkuUSoBXDpKkrHGv7/k+DC3hE65StqfDxPDVySyqhm++iiMXza1mgyc5omKwj5QrC+R
	I/SBcLaTPTXoqhIZI9ODMUy/PukN9ouXbc1FM+Zz1lysveQmDsSpDKdskj1Foaeob72yV4ou/+N
	OewMLhDXMWY+LybE5Ox8SvekTL6qVyHOXTDIMlf3/vJuKXuyuZnM2bSyJbSsnPGwxSGwyi64Kiw
	HNIHv75pnj//MAg==
X-Google-Smtp-Source: AGHT+IE4L+O3xMrf4EDPt92zlnCp5xeCGI+1DuEBtm9WQbkoYXmSfujkq7zJJFPQh/jgOsj7aCqg/g==
X-Received: by 2002:a05:600c:1384:b0:458:b01c:8f with SMTP id 5b1f17b1804b1-45f211cc941mr141418695e9.8.1757967512939;
        Mon, 15 Sep 2025 13:18:32 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::6:388e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e017bfd14sm192341445e9.21.2025.09.15.13.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 13:18:32 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 8/8] selftests/bpf: BPF task work scheduling tests
Date: Mon, 15 Sep 2025 21:18:16 +0100
Message-ID: <20250915201820.248977-9-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250915201820.248977-1-mykyta.yatsenko5@gmail.com>
References: <20250915201820.248977-1-mykyta.yatsenko5@gmail.com>
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
 tools/testing/selftests/bpf/progs/task_work.c | 107 +++++++++++++
 .../selftests/bpf/progs/task_work_fail.c      |  96 +++++++++++
 3 files changed, 352 insertions(+)
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


