Return-Path: <bpf+bounces-19312-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51392829386
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 07:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69A8D1C25626
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 06:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B47232C76;
	Wed, 10 Jan 2024 06:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4wRwM8t"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A955320E
	for <bpf@vger.kernel.org>; Wed, 10 Jan 2024 06:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-28b82dc11e6so2100905a91.1
        for <bpf@vger.kernel.org>; Tue, 09 Jan 2024 22:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704866447; x=1705471247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ha3kmEZb+Z+oMAQIYW0pwTQy6r4g4WaQOe0ZYiLVL/U=;
        b=Z4wRwM8tChD1aRSksdFCN8uSfMVlEwVmdtr5eGSipIPL0X1hNiMSxhUeZtViIqSBUu
         lIadPChJqNxDvjdns1KqjYc3qKOfuoAIjJWIQbrjalQp8CGe0JIAGS08aOyLHNKDaUvx
         aKWwyWUB5nVAkPZdovLMhuCBZHT45EWZthfBb1TtBovv725rXiGvHvEjqTMRanririBt
         rxfR0cpDO/9gtD5g9B6kvoBQh5qpXJFRjdMzCj7LZHIiKyk0+qlgjLyBNhrfV6NqbmuD
         1VaJmcSl5EcmqO5E/kiWxVYS9xWbgc3gWM+rV/0I7NVTz+nK+2l1TDx8vryPOq+8aL+O
         dQ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704866447; x=1705471247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ha3kmEZb+Z+oMAQIYW0pwTQy6r4g4WaQOe0ZYiLVL/U=;
        b=Koin26uTTrivEF9qU5Orly1bRIT6nQ2a/OlClYMrY1n7qaS2ZDZ5uUM93IPEJpd5ft
         RALPoFreVyg7nGhZoBKbiTBnHmEZjxrXBMRnQHOan56hFVxAV4EBgSyUWi/eSsqJxUkB
         LXQh3VR/N510JyXkMLFLfEq6tIUgkO5oSiorYTS8NVcN9kmtMLQ6iRkwqzPb3c5nS0It
         e7NAep+g+olC3q7CnOuP3+U+9Wdd9QlU4NqP7DjC26Jh/ybapXvk5zo5Nrem41RXgvEs
         vJRiYBW99ABV2SAMYwcqtX46ASql6w+jQBdL5QjMgLzGgma4Ea686KjYzbXZyofVuUJD
         PTdQ==
X-Gm-Message-State: AOJu0YyrDAmHSp/eico+8WpwMcYHmqxgd88m5O+YvDKlrVkMRwtkSj/E
	/v7eE5Ukb7TpzleQkzyNgPBgBK/OSaO944jL
X-Google-Smtp-Source: AGHT+IE5a90Kfk5Yk9u1BLTOekuw14LNZXyKKOrSN7A1RM6lszUngXMcVdi0V0o2YfnjpuG5RkI20Q==
X-Received: by 2002:a17:90a:b390:b0:28d:34d0:1240 with SMTP id e16-20020a17090ab39000b0028d34d01240mr247587pjr.95.1704866446640;
        Tue, 09 Jan 2024 22:00:46 -0800 (PST)
Received: from vultr.guest ([149.28.194.201])
        by smtp.gmail.com with ESMTPSA id sx4-20020a17090b2cc400b0028ce9c709e4sm540923pjb.26.2024.01.09.22.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 22:00:46 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	tj@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v2 bpf-next 2/2] selftests/bpf: Add selftests for cpumask iter
Date: Wed, 10 Jan 2024 06:00:37 +0000
Message-Id: <20240110060037.4202-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240110060037.4202-1-laoar.shao@gmail.com>
References: <20240110060037.4202-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Within the BPF program, we leverage the cgroup iterator to iterate through
percpu runqueue data, specifically the 'nr_running' metric. Subsequently
 we expose this data to userspace by means of a sequence file.

The CPU affinity for the cpumask is determined by the PID of a task:

- PID of the init task (PID 1)
  We typically don't set CPU affinity for init task and thus we can iterate
  across all possible CPUs. However, in scenarios where you've set CPU
  affinity for the init task, you should set the cpumask of your current
  task to full-F. Then proceed to iterate through all possible CPUs using
  the current task.
- PID of a task with defined CPU affinity
  The aim here is to iterate through a specific cpumask. This scenario
  aligns with tasks residing within a cpuset cgroup.
- Invalid PID (e.g., PID -1)
  No cpumask is available in this case.

The result as follows,
  #62/1    cpumask_iter/init_pid:OK
  #62/2    cpumask_iter/invalid_pid:OK
  #62/3    cpumask_iter/self_pid_one_cpu:OK
  #62/4    cpumask_iter/self_pid_multi_cpus:OK
  #62      cpumask_iter:OK
  Summary: 1/4 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 .../selftests/bpf/prog_tests/cpumask_iter.c   | 134 ++++++++++++++++++
 .../selftests/bpf/progs/cpumask_common.h      |   3 +
 .../selftests/bpf/progs/test_cpumask_iter.c   |  62 ++++++++
 3 files changed, 199 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cpumask_iter.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_cpumask_iter.c

diff --git a/tools/testing/selftests/bpf/prog_tests/cpumask_iter.c b/tools/testing/selftests/bpf/prog_tests/cpumask_iter.c
new file mode 100644
index 000000000000..689ccc4d3c3b
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/cpumask_iter.c
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Yafang Shao <laoar.shao@gmail.com> */
+
+#define _GNU_SOURCE
+#include <sched.h>
+#include <stdio.h>
+#include <unistd.h>
+
+#include <test_progs.h>
+#include "cgroup_helpers.h"
+#include "test_cpumask_iter.skel.h"
+
+static void verify_percpu_data(struct bpf_link *link, int nr_cpu_exp, int nr_running_exp)
+{
+	int iter_fd, len, item, nr_running, psi_running, nr_cpus;
+	static char buf[128];
+	size_t left;
+	char *p;
+
+	iter_fd = bpf_iter_create(bpf_link__fd(link));
+	if (!ASSERT_GE(iter_fd, 0, "iter_fd"))
+		return;
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
+	if (nr_cpu_exp == -1) {
+		ASSERT_EQ(item, -1, "seq_format");
+		goto out;
+	}
+
+	ASSERT_EQ(item, 3, "seq_format");
+	ASSERT_GE(nr_running, nr_running_exp, "nr_running");
+	ASSERT_GE(psi_running, nr_running_exp, "nr_running");
+	ASSERT_EQ(nr_cpus, nr_cpu_exp, "nr_cpus");
+
+	/* read() after iter finishes should be ok. */
+	if (len == 0)
+		ASSERT_OK(read(iter_fd, buf, sizeof(buf)), "second_read");
+
+out:
+	close(iter_fd);
+}
+
+void test_cpumask_iter(void)
+{
+	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
+	int nr_possible, cgrp_fd, pid, err, cnt, i;
+	struct test_cpumask_iter *skel = NULL;
+	union bpf_iter_link_info linfo;
+	int cpu_ids[] = {1, 3, 4, 5};
+	struct bpf_link *link;
+	cpu_set_t set;
+
+	skel = test_cpumask_iter__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_for_each_cpu__open_and_load"))
+		return;
+
+	if (setup_cgroup_environment())
+		goto destroy;
+
+	/* Utilize the cgroup iter */
+	cgrp_fd = get_root_cgroup();
+	if (!ASSERT_GE(cgrp_fd, 0, "create cgrp"))
+		goto cleanup;
+
+	memset(&linfo, 0, sizeof(linfo));
+	linfo.cgroup.cgroup_fd = cgrp_fd;
+	linfo.cgroup.order = BPF_CGROUP_ITER_SELF_ONLY;
+	opts.link_info = &linfo;
+	opts.link_info_len = sizeof(linfo);
+
+	link = bpf_program__attach_iter(skel->progs.cpu_cgroup, &opts);
+	if (!ASSERT_OK_PTR(link, "attach_iter"))
+		goto close_fd;
+
+	skel->bss->target_pid = 1;
+	/* In case init task is set CPU affinity */
+	err = sched_getaffinity(1, sizeof(set), &set);
+	if (!ASSERT_OK(err, "setaffinity"))
+		goto close_fd;
+
+	cnt = CPU_COUNT(&set);
+	nr_possible = bpf_num_possible_cpus();
+	if (test__start_subtest("init_pid"))
+		/* curent task is running. */
+		verify_percpu_data(link, cnt, cnt == nr_possible ? 1 : 0);
+
+	skel->bss->target_pid = -1;
+	if (test__start_subtest("invalid_pid"))
+		verify_percpu_data(link, -1, -1);
+
+	pid = getpid();
+	skel->bss->target_pid = pid;
+	CPU_ZERO(&set);
+	CPU_SET(0, &set);
+	err = sched_setaffinity(pid, sizeof(set), &set);
+	if (!ASSERT_OK(err, "setaffinity"))
+		goto free_link;
+
+	if (test__start_subtest("self_pid_one_cpu"))
+		verify_percpu_data(link, 1, 1);
+
+	/* Assume there are at least 8 CPUs on the testbed */
+	if (nr_possible < 8)
+		goto free_link;
+
+	CPU_ZERO(&set);
+	/* Set the CPU affinitiy: 1,3-5 */
+	for (i = 0; i < ARRAY_SIZE(cpu_ids); i++)
+		CPU_SET(cpu_ids[i], &set);
+	err = sched_setaffinity(pid, sizeof(set), &set);
+	if (!ASSERT_OK(err, "setaffinity"))
+		goto free_link;
+
+	if (test__start_subtest("self_pid_multi_cpus"))
+		verify_percpu_data(link, ARRAY_SIZE(cpu_ids), 1);
+
+free_link:
+	bpf_link__destroy(link);
+close_fd:
+	close(cgrp_fd);
+cleanup:
+	cleanup_cgroup_environment();
+destroy:
+	test_cpumask_iter__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/cpumask_common.h b/tools/testing/selftests/bpf/progs/cpumask_common.h
index 0cd4aebb97cf..5f2f44eca4c4 100644
--- a/tools/testing/selftests/bpf/progs/cpumask_common.h
+++ b/tools/testing/selftests/bpf/progs/cpumask_common.h
@@ -55,6 +55,9 @@ void bpf_cpumask_copy(struct bpf_cpumask *dst, const struct cpumask *src) __ksym
 u32 bpf_cpumask_any_distribute(const struct cpumask *src) __ksym;
 u32 bpf_cpumask_any_and_distribute(const struct cpumask *src1, const struct cpumask *src2) __ksym;
 u32 bpf_cpumask_weight(const struct cpumask *cpumask) __ksym;
+int bpf_iter_cpumask_new(struct bpf_iter_cpumask *it, struct cpumask *mask) __ksym;
+int *bpf_iter_cpumask_next(struct bpf_iter_cpumask *it) __ksym;
+void bpf_iter_cpumask_destroy(struct bpf_iter_cpumask *it) __ksym;
 
 void bpf_rcu_read_lock(void) __ksym;
 void bpf_rcu_read_unlock(void) __ksym;
diff --git a/tools/testing/selftests/bpf/progs/test_cpumask_iter.c b/tools/testing/selftests/bpf/progs/test_cpumask_iter.c
new file mode 100644
index 000000000000..68ebfa0963c7
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_cpumask_iter.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2023 Yafang Shao <laoar.shao@gmail.com> */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#include "task_kfunc_common.h"
+#include "cpumask_common.h"
+
+extern const struct psi_group_cpu system_group_pcpu __ksym __weak;
+extern const struct rq runqueues __ksym __weak;
+
+int target_pid;
+
+SEC("iter/cgroup")
+int BPF_PROG(cpu_cgroup, struct bpf_iter_meta *meta, struct cgroup *cgrp)
+{
+	u32 *cpu, nr_running = 0, psi_nr_running = 0, nr_cpus = 0;
+	unsigned int tasks[NR_PSI_TASK_COUNTS];
+	struct psi_group_cpu *groupc;
+	struct bpf_cpumask *mask;
+	struct task_struct *p;
+	struct rq *rq;
+
+	/* epilogue */
+	if (cgrp == NULL)
+		return 0;
+
+	mask = bpf_cpumask_create();
+	if (!mask)
+		return 1;
+
+	p = bpf_task_from_pid(target_pid);
+	if (!p) {
+		bpf_cpumask_release(mask);
+		return 1;
+	}
+
+	bpf_cpumask_copy(mask, p->cpus_ptr);
+	bpf_for_each(cpumask, cpu, &mask->cpumask) {
+		rq = (struct rq *)bpf_per_cpu_ptr(&runqueues, *cpu);
+		if (!rq)
+			continue;
+		nr_running += rq->nr_running;
+		nr_cpus += 1;
+
+		groupc = (struct psi_group_cpu *)bpf_per_cpu_ptr(&system_group_pcpu, *cpu);
+		if (!groupc)
+			continue;
+		bpf_probe_read_kernel(&tasks, sizeof(tasks), &groupc->tasks);
+		psi_nr_running += tasks[NR_RUNNING];
+	}
+	BPF_SEQ_PRINTF(meta->seq, "nr_running %u nr_cpus %u psi_running %u\n",
+		       nr_running, nr_cpus, psi_nr_running);
+
+	bpf_task_release(p);
+	bpf_cpumask_release(mask);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.30.1 (Apple Git-130)


