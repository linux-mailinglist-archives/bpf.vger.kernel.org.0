Return-Path: <bpf+bounces-69395-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F736B95A0C
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 13:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04EEC3AC25B
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 11:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB69E322524;
	Tue, 23 Sep 2025 11:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0L6kjCF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FDD32145E
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 11:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758626665; cv=none; b=kOrsSCkpiotCqr2QJqL7dd8pnHgdW9SvzTV6m7gVGevsgHFtlrcVzvP1JK4U0OuXDnYBN9UH+c2omYsoIs2gCbew1WS4BwiEiOyAQmmRuiR6uxnzN5BGkkl1VsCkJgJEXGIs4b95L/CiGRY4Bons/8QO4YCStLS6yqxzsI05SYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758626665; c=relaxed/simple;
	bh=P9KAjnbiaen3kqe/tXK/XCEt0kJ2oprkw8QOWRu3MIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HPd2ZuGhzeEO3CnEPnryMSmaryoP1gAB0uUzzhMXS34SaVwolCSjD76KowHTYPnot0c3JVCZVHmPMjMSCHjFRWVB/efNg6txY4JjTnE6XiXsAZ21k+9ogAagCl9RugtmX/B1ohxxd/HiXSO9s7Aiy8V7UMv3SoiJjIgCertb6ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0L6kjCF; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-63163a6556bso6921933a12.1
        for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 04:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758626662; x=1759231462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=843J+AU78MdTh4nTu8oWNSqonAKMPSjnYCOBKOIfvc8=;
        b=N0L6kjCF2FvzsCx5C+YTrI46saRjLDK5VHkHItUMpsRpDJEVd5e+BG67PM+SDBAyPZ
         FlgImAMIm4JFNMG1EElW8hMR0UyO3i0EBYc+0rc5cLZG9G/63UmVTPTmlbHlvYCBANMM
         EJMdlHYdyM2TTn9qyr0ubxLoVp1KzK44ukL04xvkD3VkQWimuJELWWghlKiglxAGML/d
         hzJKfEzVhWwg1ZvX68Cl4yxIemQJx076PJrtd+Z41EwxYRc1hVvfgM+HCo7KpovdGUA5
         UdgK0zdxyyxJZVNkJPTjBZ3t4fqAo6FecGvEIE+6a4LWgTw5vnhrmZuNEvxyJ6F+puYK
         Hfgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758626662; x=1759231462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=843J+AU78MdTh4nTu8oWNSqonAKMPSjnYCOBKOIfvc8=;
        b=E/qSoj5eTD890HRraBhE3MlnE3SonZTxBLRc1esa2ahTmBB9b0uPgpWmjEncJgZxCn
         VfMtuFLiBLeu1RoOGYfxHaDM6YKoJlF/nWu62S8qNSJF0luhsVGSutaaGs3UJlsmldqv
         ApehB8xt95dwmfisJQ3N7oVFVtGn0pFe5pBKU2DQV+05TYFXk+9ntx5ztO62CZTz5Yo8
         rouRKQD8Q90Q3y6w5JaNn852EVxFEhfK+0IiDtDFlDWZZK3szm2t85o+B4jMPq2edvaq
         NaSNKQUfm+cF7U4QviFx23HuAoip6RTXZC49hj57RZN3kkeIjjWMiWxbVnqBbwj/KYGG
         6OVg==
X-Gm-Message-State: AOJu0YyelqTiRHeKsJ0p+iptwke1LKa0YOf7r5eo+omeqJMuX1zUqHbk
	2vUiiDMYYleFEtH+zBpt4QTdq64LrHmDcw7B/Ny8sFuuOxkXugIcMAdlr8CELg==
X-Gm-Gg: ASbGncs7yiVuLjqW82qYrr6+TiLjgMTuw2zB6kem2ROSvHxc/KWn8PwCUOquNrA6bMx
	0lLOxIS8T9KvRu/FsFmyTP4BeizQz3irTnuKSKI8pVtUDmqcMAsik2DoYRjnrcyOT3gxYZxfo5P
	soDd8L8hGpOjMiVPzYoQRoSCtLIGMB9VNN4Y3ioncoRkD7mEv1XY0M2eLDWobC/4weptilSD2pP
	UYDCzZtWOp4eLu9FABUhnHr7SgHsZOKiH8gOqlmGI6KvV17uFWtx+xZcQLsIVJHj7VaA5/h+6g8
	22vGZ6UpAPKZzHtefrmtsfTBVdK5VuKIpW0Zj6LP1082xXkdu1IPNM7rTeC5QT0M5Aoq1wZsdHd
	WyZSCjcxUUFb6yT4FGK/qJED882nn6kQ=
X-Google-Smtp-Source: AGHT+IHcWtoqsMRnoBQ4W8PZBW81numpkkntyX29Q4ew239aYw+0jxmqem0RAJDIrWYLo3TcBNzxxw==
X-Received: by 2002:a17:906:4fca:b0:ae3:b2b7:7f2f with SMTP id a640c23a62f3a-b302a36d276mr249054866b.40.1758626661714;
        Tue, 23 Sep 2025 04:24:21 -0700 (PDT)
Received: from localhost ([2a02:8109:a307:d900:29a2:6d8:baf5:4284])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b293fa077desm715623066b.55.2025.09.23.04.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 04:24:21 -0700 (PDT)
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
Subject: [PATCH bpf-next v8 9/9] selftests/bpf: add bpf task work stress tests
Date: Tue, 23 Sep 2025 12:24:04 +0100
Message-ID: <20250923112404.668720-10-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250923112404.668720-1-mykyta.yatsenko5@gmail.com>
References: <20250923112404.668720-1-mykyta.yatsenko5@gmail.com>
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
index 000000000000..450d17d91a56
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
+	int test_time_s = get_env_int("BPF_TASK_WORK_TEST_TIME", 1);
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


