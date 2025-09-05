Return-Path: <bpf+bounces-67586-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39353B45E8C
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 18:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D491A3BC5BD
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 16:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2670C259CB3;
	Fri,  5 Sep 2025 16:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDYp6SzH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90549306B0F
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 16:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757090724; cv=none; b=p7Ec1TEngLfc16qL2fF3t3OUdsb1WIh5IieUJR/w4Jjovxp5hxzevTiwPQ3ybosSl+BGLt8q8Q2XyZB3d0t0TGPoE9Ifyb7c+Zfrly1vEcV1zo3FIzs5Qckuc+VCO/Ml/HSST19T8QetndAMWQYTziqKML2iHBOGObD9teNVs6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757090724; c=relaxed/simple;
	bh=JrLGJLOqAGStpXmuVQ6SkmTBxBhogoUAW1jVZWoStu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UQ6vjefznVEov9l8OqILW+korhexXlajt8mj1DClvwNrNkM2ERp4g6w2bP4yhBAiUfb3mn2Pb0SFfWpwft/deelofGZ6GaGCuSMTk7+SOG+U9ADqlOAZY3jsnE0zVt/kk1hQCocP0JoFw5ClxNItZDuSuYOQalfp3qsmdtodLTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDYp6SzH; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45ddcb1f495so1938435e9.1
        for <bpf@vger.kernel.org>; Fri, 05 Sep 2025 09:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757090721; x=1757695521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=54C7bbGE1ZQ2anV01yV4tOoJlWI5hYlXk799uE+shuM=;
        b=DDYp6SzHT09hX48ybKJE8jGmQwePBWCtNccFnECZ+XHZb4jw0tYSc5YQLbf+FBRvpN
         od/urDORAH9K1dnfo/pxrzI3zBLXzO/GDoRAfEKvU73Ds/eXEs7ONXDS3OQRkEMqCldj
         jAQ/z96Tfc1ikf+qs5xyXpDyklf2EiH1cFlObwVkOPkZgDBbPh3BGOauxbf49aLIsTZ+
         QrcDzhyq9GKne3X5sIP4IItpmHJymsP3jQj5WCXuAWAXfrSkqX1jJEDMsquRbzMXpF1X
         AdVSKQ6cNZ0duseUFdEu1b01vl6zkZiMyI6i3y7si5qX7gyiwNI6/mOfYQM6KJagx42P
         jzWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757090721; x=1757695521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=54C7bbGE1ZQ2anV01yV4tOoJlWI5hYlXk799uE+shuM=;
        b=Ia+sstsomNHbfPuzTGpULFF2Cz4GVuED9Vgr9BWfggBSKP7UFYPTHIx2SvJaiC0iy9
         UVFTjNu5EBwmdw4B4wqCVuj3NyVCYBtTYT49zE+rQwRamgwsvnk0sDiHll1NJ/NYG1zx
         dpfdfj8i8Zkh4nLaO2UYDpalJ6jRcEFCL0e6EY0rUexFggoJFFYv1I6lBRQL082TttVr
         SPSnw/2DL1S8pBN2BZ76YPay2RodhrWrauNaI1V2IMfmfuVRW2PzCn/tXFo6fmxLf7aw
         QFTeONBXd6WDMKGOCHPqnbvMTRYo8UouWKHsrhCrCYHdiM5eR07Sg/i7DwXP0jQkZnxs
         RUuA==
X-Gm-Message-State: AOJu0YwEop8Pu3P9FWkgPl1KuueA8CWj813QoLD0fzEIN90NZL0EB+SV
	ktcYL5p0PHU4u+XlGFvGELS/u9r6i7VZxt+G22PLLQkMu3MjYOZ8GKIY4V2BTg==
X-Gm-Gg: ASbGncveiwL5qIUCAbO1dadfVdRflzdT0bWbP35XwQR8XCs6uTM9z0q+T5FHzEF1KNh
	V+is6nLhDvVxFS6Q1F0N+2oSZxAf77D9euy4FTC45Osu/f2u4+26T/MtltTrVofPe1fHm1Uica2
	nfTbWynFAWyEZYXJrS0sK2R5p6AOd1qeOGHiQb0qxaG8htHt6bu2F/vmqmV4vx5/RPrmnDuayLL
	0O2sqGgcoBRq12AgrPqLaEb0q0rKhOFt+VczawQ/64KlhciNOKdY9wY43d7m6lpdTd0zEujrFMX
	dOm19AReGMSEijAZb5EQDDFNS/NVLSD+0soDJ9AbW0Su9dAJTgaBeIdL+f40P2n4sbCCOhD6eaN
	nUCItF3Rk6t3WNjCGArA3FhAasD1G7Pk=
X-Google-Smtp-Source: AGHT+IHYZKApIcmBc5pHT3LJZ3CIHtDBMEVNTPi4XbUVEMFpHjU8Pyg1JGi2gdNWTATCsAiqu9AGHA==
X-Received: by 2002:a05:600c:8b42:b0:45b:79fd:cb3d with SMTP id 5b1f17b1804b1-45b8558b522mr181854735e9.36.1757090720828;
        Fri, 05 Sep 2025 09:45:20 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dcfcc2f54sm42468055e9.2.2025.09.05.09.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 09:45:20 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 7/7] selftests/bpf: BPF task work scheduling tests
Date: Fri,  5 Sep 2025 17:45:05 +0100
Message-ID: <20250905164508.1489482-8-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905164508.1489482-1-mykyta.yatsenko5@gmail.com>
References: <20250905164508.1489482-1-mykyta.yatsenko5@gmail.com>
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
2.51.0


