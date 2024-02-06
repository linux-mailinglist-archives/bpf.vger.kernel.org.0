Return-Path: <bpf+bounces-21295-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FDD84AFBF
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 09:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 884E5287B30
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 08:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE2912A179;
	Tue,  6 Feb 2024 08:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/cuD3il"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80427C099
	for <bpf@vger.kernel.org>; Tue,  6 Feb 2024 08:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707207350; cv=none; b=iuJ1imV8nlXDBAnTaadM5dFKXpMa1C0xyL5n3lUyPasX4WBkAL14mIjZEg/ea3XeU7TBt2WAdrwY8KJxH/u5bDQ10gFWfRWnuub2ww1KyYGQ3xh8EBpgcaxmejvCZahWMT+XpA5oylb53/uTp6t/aqvZmopXYE6JTQw0GdqDp3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707207350; c=relaxed/simple;
	bh=8bflKmxMgoB7fH0nbK5bg1yqTEuUsx80TZVYDp+j3eQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VfQWF71izfP09+o5nVH5GGH9Ob1zlm0XRw06RuHRxL20Z2AvMOI9UqG97MUc2KESOExRMNRs7zVzLH4yS4jo60Atas5WexnMnll3SLsRjwmoeKjdEWLhRLbExNsSYI1Fzy+q+oCOVfYCZUFPfGjag4HBKUJ2BZJcBJyrlShH03w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/cuD3il; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6e117eec348so331778a34.2
        for <bpf@vger.kernel.org>; Tue, 06 Feb 2024 00:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707207348; x=1707812148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=93sJpduZ+PfWWK0FIrMlFr/mZh1WpgsGF0yQ12B38Ng=;
        b=F/cuD3ildR74MovfksmZ3YJMJKNyr1BO6T1Si6JvPfey3dSpuMCQ6FYh1TtO6sEEbG
         4g0Bf8V0U0YTgRw+ff3PwApNY7QDf385M5ygNXu+pNQMduqkZJ4HrFv1fAhHSc2GWJ75
         dIEJuCubv+nQnuAgzPB6L2BFpqSjsn1xsRJJkwR5fBQvQnX715rEXYPFyOPqJp5qHkoq
         ZCB1XU+7orUP8Tm1KLu6vg/FXXPx3cVfGF5Yo0zpekH44s5/49CG8cQOkoDo6LGy/PI6
         wG0O11SBZfetewAhEnXUEtSS603OGb41emQIh+6yGL4PO28LJYW88iBenCrk/sVEYuJy
         wZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707207348; x=1707812148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=93sJpduZ+PfWWK0FIrMlFr/mZh1WpgsGF0yQ12B38Ng=;
        b=kVcxEkkoWqkS6dBr6/jpJaoP6JEGoZn4LUHGNS3T46lFywkek/9ga7mTuRxQJC/3Lw
         bOLlFcZTvk1Ac7j7EQEZ2P0LYQoUue9wU59dI2ZO5oTd5Sxl/VsXVssg67T5IGdt9X/7
         uM67X4CYaZgga1VA1vJRWrzP44GI1ULqs3h1VoOl/ZXM5RrGhUJ3PuE6Ds4IMThrOvSU
         qkkh82kCE/i70BxJ2EhMTiVLa78IYeYrsEtAQw97aVeWlhHEyTUs9okqxCvvB6JqSMvk
         G+c8kMRsNA+HQOj6bMuupoJbKMbk/dss5kZ9G+iWoKMLhbbWfVzhSIeXEX/ixM8dkWM0
         yBRg==
X-Gm-Message-State: AOJu0YzBX0He2+ULe98hmyWpQe8BImkw6QNY6A+6Gxj8qsCmI3r/tGZl
	J9NBt9f+ShaWQ5Z+9ZPMAsexiH/iYfW/3KnjO71T2dxc7mIeDnae
X-Google-Smtp-Source: AGHT+IEctNCCVoUWVJo1qGVmF9GzWnD6WYyrP5zdnUH7cZuOqzjMswUEJchc3uhBfRzTf6VfpY3Fng==
X-Received: by 2002:a05:6830:185:b0:6de:6ad0:d34c with SMTP id q5-20020a056830018500b006de6ad0d34cmr2250118ota.9.1707207347667;
        Tue, 06 Feb 2024 00:15:47 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUF46L5VKx3mfnoMA9j94lBOUOjslGSAW+AGXZdSExLYZiQbqA6OJnQa6O/HghDsl7YvNMYUIiirofXhF1TOvorT3RCKY0jCB3h5zgJ1cWsTXiNF4KDCNpJF7IRPOlqaqjjuAwgPczUqWOpOkI68S0I2kRRSSy04uHgT0C08OYJ18NT4HNAdGjOUnszs0C5rYvAlr65r7btvySIFbZPe0PlttPibVUsFj2Ei+xI3BaEJ8mpvbA+HBd06uj8xiypSL3Hnnb3qxH2lYERJHQbPEuysGu6xkkGwulLGzqCUhQgDKTEoUicotDUT65Gty2JGzwb6YHhkHFli/sP5r0wO6CHhu9S9lu5YPOI0/ObdWAJYUwEXNCi8D1ggqfXWcogdei6vXx6uEtY1qqLmUbrR5aM8/epJVQSZ04c513f9e9GKkSpI+TIcA==
Received: from localhost.localdomain ([39.144.105.129])
        by smtp.gmail.com with ESMTPSA id 3-20020a630c43000000b005d7c02994c4sm1381660pgm.60.2024.02.06.00.15.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Feb 2024 00:15:47 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	tj@kernel.org,
	void@manifault.com
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v6 bpf-next 5/5] selftests/bpf: Add selftests for cpumask iter
Date: Tue,  6 Feb 2024 16:14:16 +0800
Message-Id: <20240206081416.26242-6-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240206081416.26242-1-laoar.shao@gmail.com>
References: <20240206081416.26242-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add selftests for the newly added cpumask iter.
- cpumask_iter_success
  - The number of CPUs should be expected when iterating over the cpumask
  - percpu data extracted from the percpu struct should be expected
  - It can work in both non-sleepable and sleepable prog
  - RCU lock is only required by bpf_iter_cpumask_new()
  - It is fine without calling bpf_iter_cpumask_next()

- cpumask_iter_failure
  - RCU lock is required in sleepable prog
  - The cpumask to be iterated over can't be NULL
  - bpf_iter_cpumask_destroy() is required after calling
    bpf_iter_cpumask_new()
  - bpf_iter_cpumask_destroy() can only destroy an initialized iter
  - bpf_iter_cpumask_next() must use an initialized iter

The result as follows,

  #64/37   cpumask/test_cpumask_iter:OK
  #64/38   cpumask/test_cpumask_iter_sleepable:OK
  #64/39   cpumask/test_cpumask_iter_sleepable:OK
  #64/40   cpumask/test_cpumask_iter_next_no_rcu:OK
  #64/41   cpumask/test_cpumask_iter_no_next:OK
  #64/42   cpumask/test_cpumask_iter:OK
  #64/43   cpumask/test_cpumask_iter_no_rcu:OK
  #64/44   cpumask/test_cpumask_iter_no_destroy:OK
  #64/45   cpumask/test_cpumask_iter_null_pointer:OK
  #64/46   cpumask/test_cpumask_iter_next_uninit:OK
  #64/47   cpumask/test_cpumask_iter_destroy_uninit:OK
  #64      cpumask:OK

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 tools/testing/selftests/bpf/config            |   1 +
 .../selftests/bpf/prog_tests/cpumask.c        | 152 ++++++++++++++++++
 .../selftests/bpf/progs/cpumask_common.h      |   3 +
 .../bpf/progs/cpumask_iter_failure.c          |  99 ++++++++++++
 .../bpf/progs/cpumask_iter_success.c          | 126 +++++++++++++++
 5 files changed, 381 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/cpumask_iter_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/cpumask_iter_success.c

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 01f241ea2c67..dd4b0935e35f 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -78,6 +78,7 @@ CONFIG_NF_CONNTRACK_MARK=y
 CONFIG_NF_DEFRAG_IPV4=y
 CONFIG_NF_DEFRAG_IPV6=y
 CONFIG_NF_NAT=y
+CONFIG_PSI=y
 CONFIG_RC_CORE=y
 CONFIG_SECURITY=y
 CONFIG_SECURITYFS=y
diff --git a/tools/testing/selftests/bpf/prog_tests/cpumask.c b/tools/testing/selftests/bpf/prog_tests/cpumask.c
index ecf89df78109..78423745689c 100644
--- a/tools/testing/selftests/bpf/prog_tests/cpumask.c
+++ b/tools/testing/selftests/bpf/prog_tests/cpumask.c
@@ -1,9 +1,15 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
 
+#define _GNU_SOURCE
+#include <sched.h>
+
 #include <test_progs.h>
 #include "cpumask_failure.skel.h"
 #include "cpumask_success.skel.h"
+#include "cpumask_iter_success.skel.h"
+#include "cpumask_iter_failure.skel.h"
+#include "cgroup_helpers.h"
 
 static const char * const cpumask_success_testcases[] = {
 	"test_alloc_free_cpumask",
@@ -61,6 +67,142 @@ static void verify_success(const char *prog_name)
 	cpumask_success__destroy(skel);
 }
 
+static const char * const cpumask_iter_success_testcases[] = {
+	"test_cpumask_iter",
+	"test_cpumask_iter_sleepable",
+};
+
+static int read_percpu_data(struct bpf_link *link, int nr_cpu_exp, int nr_running_exp)
+{
+	int iter_fd, len, item, nr_running, psi_running, nr_cpus, err = -1;
+	char buf[128];
+	size_t left;
+	char *p;
+
+	iter_fd = bpf_iter_create(bpf_link__fd(link));
+	if (!ASSERT_GE(iter_fd, 0, "iter_fd"))
+		return -1;
+
+	memset(buf, 0, sizeof(buf));
+	left = ARRAY_SIZE(buf);
+	p = buf;
+	while ((len = read(iter_fd, p, left)) > 0) {
+		p += len;
+		left -= len;
+	}
+
+	item = sscanf(buf, "nr_running %u nr_cpus %u psi_running %u\n",
+		      &nr_running, &nr_cpus, &psi_running);
+	if (!ASSERT_EQ(item, 3, "seq_format"))
+		goto out;
+	if (!ASSERT_EQ(nr_cpus, nr_cpu_exp, "nr_cpus"))
+		goto out;
+	if (!ASSERT_GE(nr_running, nr_running_exp, "nr_running"))
+		goto out;
+	if (!ASSERT_GE(psi_running, nr_running_exp, "psi_running"))
+		goto out;
+
+	err = 0;
+out:
+	close(iter_fd);
+	return err;
+}
+
+static void verify_iter_success(const char *prog_name)
+{
+	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
+	int cgrp_fd, nr_cpus, err, i, chosen = 0;
+	struct cpumask_iter_success *skel;
+	union bpf_iter_link_info linfo;
+	struct bpf_program *prog;
+	struct bpf_link *link;
+	cpu_set_t set;
+
+	if (setup_cgroup_environment())
+		return;
+
+	/* Utilize the cgroup iter */
+	cgrp_fd = get_root_cgroup();
+	if (!ASSERT_GE(cgrp_fd, 0, "create_cgrp"))
+		goto cleanup;
+
+	skel = cpumask_iter_success__open();
+	if (!ASSERT_OK_PTR(skel, "cpumask_iter_success__open"))
+		goto close_fd;
+
+	skel->bss->pid = getpid();
+	nr_cpus = libbpf_num_possible_cpus();
+
+	err = cpumask_iter_success__load(skel);
+	if (!ASSERT_OK(err, "cpumask_iter_success__load"))
+		goto destroy;
+
+	prog = bpf_object__find_program_by_name(skel->obj, prog_name);
+	if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
+		goto destroy;
+
+	memset(&linfo, 0, sizeof(linfo));
+	linfo.cgroup.cgroup_fd = cgrp_fd;
+	linfo.cgroup.order = BPF_CGROUP_ITER_SELF_ONLY;
+	opts.link_info = &linfo;
+	opts.link_info_len = sizeof(linfo);
+	link = bpf_program__attach_iter(prog, &opts);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach"))
+		goto destroy;
+
+	/* Case 1): Enable all possible CPUs */
+	CPU_ZERO(&set);
+	for (i = 0; i < nr_cpus; i++)
+		CPU_SET(i, &set);
+	err = sched_setaffinity(skel->bss->pid, sizeof(set), &set);
+	if (!ASSERT_OK(err, "setaffinity_all_cpus"))
+		goto free_link;
+	err = read_percpu_data(link, nr_cpus, 1);
+	if (!ASSERT_OK(err, "read_percpu_data"))
+		goto free_link;
+	if (!ASSERT_OK(skel->bss->err, "null_rq"))
+		goto free_link;
+
+	/* Case 2): CPU0 only */
+	CPU_ZERO(&set);
+	CPU_SET(0, &set);
+	err = sched_setaffinity(skel->bss->pid, sizeof(set), &set);
+	if (!ASSERT_OK(err, "setaffinity_cpu0"))
+		goto free_link;
+	err = read_percpu_data(link, 1, 1);
+	if (!ASSERT_OK(err, "read_percpu_data"))
+		goto free_link;
+	if (!ASSERT_OK(skel->bss->err, "null_rq_psi"))
+		goto free_link;
+
+	/* Case 3): Partial CPUs */
+	CPU_ZERO(&set);
+	for (i = 0; i < nr_cpus; i++) {
+		if (i < 4 && i & 0x1)
+			continue;
+		if (i > 8 && i & 0x2)
+			continue;
+		CPU_SET(i, &set);
+		chosen++;
+	}
+	err = sched_setaffinity(skel->bss->pid, sizeof(set), &set);
+	if (!ASSERT_OK(err, "setaffinity_partial_cpus"))
+		goto free_link;
+	err = read_percpu_data(link, chosen, 1);
+	if (!ASSERT_OK(err, "read_percpu_data"))
+		goto free_link;
+	ASSERT_OK(skel->bss->err, "null_rq_psi");
+
+free_link:
+	bpf_link__destroy(link);
+destroy:
+	cpumask_iter_success__destroy(skel);
+close_fd:
+	close(cgrp_fd);
+cleanup:
+	cleanup_cgroup_environment();
+}
+
 void test_cpumask(void)
 {
 	int i;
@@ -74,4 +216,14 @@ void test_cpumask(void)
 
 	RUN_TESTS(cpumask_success);
 	RUN_TESTS(cpumask_failure);
+
+	for (i = 0; i < ARRAY_SIZE(cpumask_iter_success_testcases); i++) {
+		if (!test__start_subtest(cpumask_iter_success_testcases[i]))
+			continue;
+
+		verify_iter_success(cpumask_iter_success_testcases[i]);
+	}
+
+	RUN_TESTS(cpumask_iter_success);
+	RUN_TESTS(cpumask_iter_failure);
 }
diff --git a/tools/testing/selftests/bpf/progs/cpumask_common.h b/tools/testing/selftests/bpf/progs/cpumask_common.h
index c705d8112a35..fb65943ef130 100644
--- a/tools/testing/selftests/bpf/progs/cpumask_common.h
+++ b/tools/testing/selftests/bpf/progs/cpumask_common.h
@@ -56,6 +56,9 @@ u32 bpf_cpumask_any_distribute(const struct cpumask *src) __ksym __weak;
 u32 bpf_cpumask_any_and_distribute(const struct cpumask *src1,
 				   const struct cpumask *src2) __ksym __weak;
 u32 bpf_cpumask_weight(const struct cpumask *cpumask) __ksym __weak;
+int bpf_iter_cpumask_new(struct bpf_iter_cpumask *it, const struct cpumask *mask) __ksym __weak;
+int *bpf_iter_cpumask_next(struct bpf_iter_cpumask *it) __ksym __weak;
+void bpf_iter_cpumask_destroy(struct bpf_iter_cpumask *it) __ksym __weak;
 
 void bpf_rcu_read_lock(void) __ksym __weak;
 void bpf_rcu_read_unlock(void) __ksym __weak;
diff --git a/tools/testing/selftests/bpf/progs/cpumask_iter_failure.c b/tools/testing/selftests/bpf/progs/cpumask_iter_failure.c
new file mode 100644
index 000000000000..3d304cee0a72
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/cpumask_iter_failure.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2024 Yafang Shao <laoar.shao@gmail.com> */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#include "bpf_misc.h"
+#include "task_kfunc_common.h"
+#include "cpumask_common.h"
+
+char _license[] SEC("license") = "GPL";
+
+SEC("iter.s/cgroup")
+__failure __msg("R2 must be a rcu pointer")
+int BPF_PROG(test_cpumask_iter_no_rcu, struct bpf_iter_meta *meta, struct cgroup *cgrp)
+{
+	struct task_struct *p;
+	int *cpu;
+
+	p = bpf_task_from_pid(1);
+	if (!p)
+		return 1;
+
+	bpf_for_each(cpumask, cpu, p->cpus_ptr) {
+	}
+	bpf_task_release(p);
+	return 0;
+}
+
+SEC("iter/cgroup")
+__failure __msg("Possibly NULL pointer passed to trusted arg1")
+int BPF_PROG(test_cpumask_iter_null_pointer, struct bpf_iter_meta *meta, struct cgroup *cgrp)
+{
+	struct cpumask *mask = NULL;
+	int *cpu;
+
+	bpf_for_each(cpumask, cpu, mask) {
+	}
+	return 0;
+}
+
+SEC("iter.s/cgroup")
+__failure __msg("Unreleased reference id=3 alloc_insn=10")
+int BPF_PROG(test_cpumask_iter_no_destroy, struct bpf_iter_meta *meta, struct cgroup *cgrp)
+{
+	struct bpf_iter_cpumask it;
+	struct task_struct *p;
+
+	p = bpf_task_from_pid(1);
+	if (!p)
+		return 1;
+
+	bpf_rcu_read_lock();
+	bpf_iter_cpumask_new(&it, p->cpus_ptr);
+	bpf_rcu_read_unlock();
+
+	bpf_iter_cpumask_next(&it);
+	bpf_task_release(p);
+	return 0;
+}
+
+SEC("iter/cgroup")
+__failure __msg("expected an initialized iter_cpumask as arg #1")
+int BPF_PROG(test_cpumask_iter_next_uninit, struct bpf_iter_meta *meta, struct cgroup *cgrp)
+{
+	struct bpf_iter_cpumask *it = NULL;
+
+	bpf_iter_cpumask_next(it);
+	return 0;
+}
+
+SEC("iter/cgroup")
+__failure __msg("expected an initialized iter_cpumask as arg #1")
+int BPF_PROG(test_cpumask_iter_next_uninit2, struct bpf_iter_meta *meta, struct cgroup *cgrp)
+{
+	struct bpf_iter_cpumask it = {};
+
+	bpf_iter_cpumask_next(&it);
+	return 0;
+}
+
+SEC("iter/cgroup")
+__failure __msg("expected an initialized iter_cpumask as arg #1")
+int BPF_PROG(test_cpumask_iter_destroy_uninit, struct bpf_iter_meta *meta, struct cgroup *cgrp)
+{
+	struct bpf_iter_cpumask_kern it = {.cpu = -1};
+	struct bpf_cpumask *mask;
+
+	mask = bpf_cpumask_create();
+	if (!mask)
+		return 1;
+
+	bpf_cpumask_setall(mask);
+	it.mask = &mask->cpumask;
+	bpf_iter_cpumask_destroy((struct bpf_iter_cpumask *)&it);
+	bpf_cpumask_release(mask);
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/cpumask_iter_success.c b/tools/testing/selftests/bpf/progs/cpumask_iter_success.c
new file mode 100644
index 000000000000..a71db42cc38a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/cpumask_iter_success.c
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2024 Yafang Shao <laoar.shao@gmail.com> */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#include "task_kfunc_common.h"
+#include "cpumask_common.h"
+
+char _license[] SEC("license") = "GPL";
+
+extern const struct psi_group_cpu system_group_pcpu __ksym __weak;
+extern const struct rq runqueues __ksym __weak;
+
+int pid;
+
+static void read_percpu_data(struct bpf_iter_meta *meta, struct cgroup *cgrp, const cpumask_t *mask)
+{
+	u32 nr_running = 0, psi_nr_running = 0, nr_cpus = 0;
+	struct psi_group_cpu *groupc;
+	struct rq *rq;
+	int *cpu;
+
+	bpf_for_each(cpumask, cpu, mask) {
+		rq = (struct rq *)bpf_per_cpu_ptr(&runqueues, *cpu);
+		if (!rq) {
+			err += 1;
+			continue;
+		}
+		nr_running += rq->nr_running;
+		nr_cpus += 1;
+
+		groupc = (struct psi_group_cpu *)bpf_per_cpu_ptr(&system_group_pcpu, *cpu);
+		if (!groupc) {
+			err += 1;
+			continue;
+		}
+		psi_nr_running += groupc->tasks[NR_RUNNING];
+	}
+	BPF_SEQ_PRINTF(meta->seq, "nr_running %u nr_cpus %u psi_running %u\n",
+		       nr_running, nr_cpus, psi_nr_running);
+}
+
+SEC("iter.s/cgroup")
+int BPF_PROG(test_cpumask_iter_sleepable, struct bpf_iter_meta *meta, struct cgroup *cgrp)
+{
+	struct task_struct *p;
+
+	/* epilogue */
+	if (!cgrp)
+		return 0;
+
+	bpf_rcu_read_lock();
+	p = bpf_task_from_pid(pid);
+	if (!p) {
+		bpf_rcu_read_unlock();
+		return 1;
+	}
+
+	read_percpu_data(meta, cgrp, p->cpus_ptr);
+	bpf_task_release(p);
+	bpf_rcu_read_unlock();
+	return 0;
+}
+
+SEC("iter/cgroup")
+int BPF_PROG(test_cpumask_iter, struct bpf_iter_meta *meta, struct cgroup *cgrp)
+{
+	struct task_struct *p;
+
+	/* epilogue */
+	if (!cgrp)
+		return 0;
+
+	p = bpf_task_from_pid(pid);
+	if (!p)
+		return 1;
+
+	read_percpu_data(meta, cgrp, p->cpus_ptr);
+	bpf_task_release(p);
+	return 0;
+}
+
+SEC("iter.s/cgroup")
+int BPF_PROG(test_cpumask_iter_next_no_rcu, struct bpf_iter_meta *meta, struct cgroup *cgrp)
+{
+	struct bpf_iter_cpumask it;
+	struct task_struct *p;
+
+	p = bpf_task_from_pid(1);
+	if (!p)
+		return 1;
+
+	/* RCU is only required by bpf_iter_cpumask_new(). */
+	bpf_rcu_read_lock();
+	bpf_iter_cpumask_new(&it, p->cpus_ptr);
+	bpf_rcu_read_unlock();
+
+	bpf_iter_cpumask_next(&it);
+	bpf_iter_cpumask_destroy(&it);
+
+	bpf_task_release(p);
+	return 0;
+}
+
+SEC("iter.s/cgroup")
+int BPF_PROG(test_cpumask_iter_no_next, struct bpf_iter_meta *meta, struct cgroup *cgrp)
+{
+	struct bpf_iter_cpumask it;
+	struct task_struct *p;
+
+	p = bpf_task_from_pid(1);
+	if (!p)
+		return 1;
+
+	bpf_rcu_read_lock();
+	bpf_iter_cpumask_new(&it, p->cpus_ptr);
+	bpf_rcu_read_unlock();
+
+	/* It is fine without calling bpf_iter_cpumask_next(). */
+
+	bpf_iter_cpumask_destroy(&it);
+	bpf_task_release(p);
+	return 0;
+}
-- 
2.39.1


