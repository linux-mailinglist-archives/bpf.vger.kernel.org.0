Return-Path: <bpf+bounces-69287-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AC9B9393D
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 01:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55D2D19075FD
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 23:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A343128AC;
	Mon, 22 Sep 2025 23:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5jfoG8R"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C978E2F8BE7
	for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 23:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758583594; cv=none; b=bELk8vSKwR7xtT4ufHP/2Vx/WBt6gGiVNGitSD2WfnAvKYj/2K9deLOuGI/zzqk48+VDiCpZPYJWPHSirs8fuf7Tl3vlQi/O9Ay7lc6f0BRzVXh1km/eUP3qpN4zxxZ0lLKkCxtZCPkWOfaDhb1JOU8PjVufSZ+RG0zz9H6k0Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758583594; c=relaxed/simple;
	bh=jOv6FJhSXW7zSqQ6ZFJsveSwG6TrdXwTCfR6Vnu8bi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RxzPEjb3SC4vcOt1BIctXayNuDVLb/uOfhFaMt6mPZaZalxbfwG2BE7Esk+l0cU6j2ZtTh6geWcxhi9MsMImjaOthy7O3hv9Dca8DFB+msEGHP+sb5dMSZbrrMtDKRKzfiob2kdsa/O2m0/5SG6HyfXxdepbqnRrgNMAEgC6qfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5jfoG8R; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afcb78ead12so754508866b.1
        for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 16:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758583591; x=1759188391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N0FXMcJdBrsoc6XCfW7QthBXIc3QuzJPPn0xJO64Mj8=;
        b=P5jfoG8RYlqCYQF8PQkRFj9i6/ZqJAbZsYI/1lEcjvwdFajfZ2N2ILyLLy8MlDv3OL
         yFzsotYLhgaR8oqgmhRIHenCgQEUhYYtcyE8/M7n/wFmkS8fLV/zwmbR7CevWJqzSq9x
         de7E9qup+HcbEwQuziRrbRuCQ7MM6TQMdIpghx702MdfZcV17IrdXWddopyMSyN8OxJR
         OhlpJOXOrYlIL2MrYhVn9tD9zRRAThClRar4qal368NnL4EkW3GxNaleAy0uoeQAm5ZC
         sUyiTMrac4oZwJFSNA2ExdLzynB6NKi7Tj9RucoB41yvAoggEmdwjUB5bENFgMU3IFkr
         d3GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758583591; x=1759188391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N0FXMcJdBrsoc6XCfW7QthBXIc3QuzJPPn0xJO64Mj8=;
        b=lu0bgYesip+U5a1ImVRqJbS7sfsvurnrGKJpPzD77yjUfaTv5UyfAUFqSgXwQcqqo9
         J3eoMZtt+GDkLq5yiBvWFwRgpCWrhmWPP0CXyHdcnmGt0Mhz6CwrFyNBX02xPJi2zKDk
         4o/klggJ9fmc6oCwVwPMwi3xp+yrlqnKgCf1Uq18TvPmCO7aG0+ME6iiYSEhaoWOHezN
         kBubUTtS0RbYU7Cbwklkp7wNgtFDiu3AD4DMnlFdWOMkAPsY5CEiDNMiQEQOpIotLurp
         7jlD7+jjPkn46RaW8wihEhd4BSYKl5/akwc/TlZUjTLHVKMBLtpe50iWj/iLgPYp4auz
         Deiw==
X-Gm-Message-State: AOJu0YwiMup2Zcy30DyFlTCNT4tiUwxiABUAWWYTQTxUqI/cm52XHFb+
	3s0bPYWnOIGzq319tx0ZxLo4N7nXychShBZE2LcgNPr5tCP3lvkbhiF31h2wSQ==
X-Gm-Gg: ASbGncvhMKAZTCsHFotlmyUjq4LA045tv7YPzFPH/LsfwHJMX/SiPTYTJNRHuXjkyyt
	Fb8EE0nQN4F0WdRMaokgs3v3Ixx7xxATBosvvveIlWvrrhgj0FSKLFh0Nb6azpCXC6KJGBZ3vEt
	UBT4o7CLC4XiIVC0d0b8bgcmpwl4n/a0EXeLQJrTL+G58uAxa7uV2VM6TmO8laRVHB7MdQ9t1U4
	HEr2cM87aLUn86taiwmGD6/PQZIbvTDVzm5QgCvFGz8ssaAyoCykJITM1hINnpqFlPxySckzvP+
	269xL3t70TI3wGOO9mQAnQjBLHAbjPGcYpLlKDc51BDSSG9cEFh1wsqXvnaCunjwruSTEFprCmf
	8Cy0S7m0LTJ84Ccpws7Xt
X-Google-Smtp-Source: AGHT+IEtkgE+P8McL/rS6MDeILDu2lBSqUV4opkaK/rB9tihS9Ie8DVnudT8VXqEfOCTV/oWMcBDkg==
X-Received: by 2002:a17:907:3f99:b0:af1:f259:254d with SMTP id a640c23a62f3a-b302679e5bdmr31240266b.8.1758583590992;
        Mon, 22 Sep 2025 16:26:30 -0700 (PDT)
Received: from localhost ([2a02:8109:a307:d900:29a2:6d8:baf5:4284])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fd1102d7asm1208942866b.76.2025.09.22.16.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 16:26:30 -0700 (PDT)
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
Subject: [PATCH bpf-next v7 9/9] selftests/bpf: add bpf task work stress tests
Date: Tue, 23 Sep 2025 00:26:10 +0100
Message-ID: <20250922232611.614512-10-mykyta.yatsenko5@gmail.com>
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

Add stress tests for BPF task-work scheduling kfuncs. The tests spawn
multiple threads that concurrently schedule task_work callbacks against
the same and different map values to exercise the kfuncs under high
contention.
Verify callbacks are reliably enqueued and executed with no drops.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 .../bpf/prog_tests/task_work_stress.c         | 130 ++++++++++++++++++
 .../selftests/bpf/progs/task_work_stress.c    |  73 ++++++++++
 2 files changed, 203 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/task_work_stress.c
 create mode 100644 tools/testing/selftests/bpf/progs/task_work_stress.c

diff --git a/tools/testing/selftests/bpf/prog_tests/task_work_stress.c b/tools/testing/selftests/bpf/prog_tests/task_work_stress.c
new file mode 100644
index 000000000000..6acd276f10e0
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/task_work_stress.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+#include <string.h>
+#include <stdio.h>
+#include "task_work_stress.skel.h"
+#include <linux/bpf.h>
+#include <linux/perf_event.h>
+#include <sys/syscall.h>
+#include <time.h>
+#include <stdlib.h>
+#include <stdatomic.h>
+
+struct test_data {
+	int prog_fd;
+	atomic_int exit;
+};
+
+void *runner(void *test_data)
+{
+	struct test_data *td = test_data;
+	int err = 0;
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+
+	while (!err && !atomic_load(&td->exit))
+		err = bpf_prog_test_run_opts(td->prog_fd, &opts);
+
+	return NULL;
+}
+
+static int get_env_int(const char *str, int def)
+{
+	const char *s = getenv(str);
+	char *end;
+	int retval;
+
+	if (!s || !*s)
+		return def;
+	errno = 0;
+	retval = strtol(s, &end, 10);
+	if (errno || *end || retval < 0)
+		return def;
+	return retval;
+}
+
+static void task_work_run(bool enable_delete)
+{
+	struct task_work_stress *skel;
+	struct bpf_program *scheduler, *deleter;
+	int nthreads = 16;
+	int test_time_s = get_env_int("BPF_TASK_WORK_TEST_TIME", 2);
+	pthread_t tid[nthreads], tid_del;
+	bool started[nthreads], started_del = false;
+	struct test_data td_sched = { .exit = 0 }, td_del = { .exit = 1 };
+	int i, err;
+
+	skel = task_work_stress__open();
+	if (!ASSERT_OK_PTR(skel, "task_work__open"))
+		return;
+
+	scheduler = bpf_object__find_program_by_name(skel->obj, "schedule_task_work");
+	bpf_program__set_autoload(scheduler, true);
+
+	deleter = bpf_object__find_program_by_name(skel->obj, "delete_task_work");
+	bpf_program__set_autoload(deleter, true);
+
+	err = task_work_stress__load(skel);
+	if (!ASSERT_OK(err, "skel_load"))
+		goto cleanup;
+
+	for (i = 0; i < nthreads; ++i)
+		started[i] = false;
+
+	td_sched.prog_fd = bpf_program__fd(scheduler);
+	for (i = 0; i < nthreads; ++i) {
+		if (pthread_create(&tid[i], NULL, runner, &td_sched) != 0) {
+			fprintf(stderr, "could not start thread");
+			goto cancel;
+		}
+		started[i] = true;
+	}
+
+	if (enable_delete)
+		atomic_store(&td_del.exit, 0);
+
+	td_del.prog_fd = bpf_program__fd(deleter);
+	if (pthread_create(&tid_del, NULL, runner, &td_del) != 0) {
+		fprintf(stderr, "could not start thread");
+		goto cancel;
+	}
+	started_del = true;
+
+	/* Run stress test for some time */
+	sleep(test_time_s);
+
+cancel:
+	atomic_store(&td_sched.exit, 1);
+	atomic_store(&td_del.exit, 1);
+	for (i = 0; i < nthreads; ++i) {
+		if (started[i])
+			pthread_join(tid[i], NULL);
+	}
+
+	if (started_del)
+		pthread_join(tid_del, NULL);
+
+	ASSERT_GT(skel->bss->callback_scheduled, 0, "work scheduled");
+	/* Some scheduling attempts should have failed due to contention */
+	ASSERT_GT(skel->bss->schedule_error, 0, "schedule error");
+
+	if (enable_delete) {
+		/* If delete thread is enabled, it has cancelled some callbacks */
+		ASSERT_GT(skel->bss->delete_success, 0, "delete success");
+		ASSERT_LT(skel->bss->callback_success, skel->bss->callback_scheduled, "callbacks");
+	} else {
+		/* Without delete thread number of scheduled callbacks is the same as fired */
+		ASSERT_EQ(skel->bss->callback_success, skel->bss->callback_scheduled, "callbacks");
+	}
+
+cleanup:
+	task_work_stress__destroy(skel);
+}
+
+void test_task_work_stress(void)
+{
+	if (test__start_subtest("no_delete"))
+		task_work_run(false);
+	if (test__start_subtest("with_delete"))
+		task_work_run(true);
+}
diff --git a/tools/testing/selftests/bpf/progs/task_work_stress.c b/tools/testing/selftests/bpf/progs/task_work_stress.c
new file mode 100644
index 000000000000..90fca06fff56
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/task_work_stress.c
@@ -0,0 +1,73 @@
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
+#define ENTRIES 128
+
+char _license[] SEC("license") = "GPL";
+
+__u64 callback_scheduled = 0;
+__u64 callback_success = 0;
+__u64 schedule_error = 0;
+__u64 delete_success = 0;
+
+struct elem {
+	__u32 count;
+	struct bpf_task_work tw;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__uint(max_entries, ENTRIES);
+	__type(key, int);
+	__type(value, struct elem);
+} hmap SEC(".maps");
+
+static int process_work(struct bpf_map *map, void *key, void *value)
+{
+	__sync_fetch_and_add(&callback_success, 1);
+	return 0;
+}
+
+SEC("syscall")
+int schedule_task_work(void *ctx)
+{
+	struct elem empty_work = {.count = 0};
+	struct elem *work;
+	int key = 0, err;
+
+	key = bpf_ktime_get_ns() % ENTRIES;
+	work = bpf_map_lookup_elem(&hmap, &key);
+	if (!work) {
+		bpf_map_update_elem(&hmap, &key, &empty_work, BPF_NOEXIST);
+		work = bpf_map_lookup_elem(&hmap, &key);
+		if (!work)
+			return 0;
+	}
+	err = bpf_task_work_schedule_signal(bpf_get_current_task_btf(), &work->tw, &hmap,
+					    process_work, NULL);
+	if (err)
+		__sync_fetch_and_add(&schedule_error, 1);
+	else
+		__sync_fetch_and_add(&callback_scheduled, 1);
+	return 0;
+}
+
+SEC("syscall")
+int delete_task_work(void *ctx)
+{
+	int key = 0, err;
+
+	key = bpf_get_prandom_u32() % ENTRIES;
+	err = bpf_map_delete_elem(&hmap, &key);
+	if (!err)
+		__sync_fetch_and_add(&delete_success, 1);
+	return 0;
+}
-- 
2.51.0


