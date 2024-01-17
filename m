Return-Path: <bpf+bounces-19706-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9C682FEF2
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 03:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF7E91C24127
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 02:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25494690;
	Wed, 17 Jan 2024 02:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AsHkHNbR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E083D1864
	for <bpf@vger.kernel.org>; Wed, 17 Jan 2024 02:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705459807; cv=none; b=AMyYCVRMmaiLrjToi9ACE326YwOrJvHsw7k13e/krmn8XPaPLEEn57E35uF22cVGqoxDF9RH36jQmkgdGq5fjtms0TxiRMzBPA5ZAJisfC/amJCbSQmmJEWYjV49GjCvj+VepU7hzcohxJOBFaCwN0ZhpWmsM6LhcLpKUQHhVnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705459807; c=relaxed/simple;
	bh=KF56efebQkh6oH1B7SIa9ErLLFE3xO0cpae+vxEbOeE=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=p7ALk7x1K+A94ZKi4K0Uq+4GlgdufOvtJJ0cXD0z3onTD8kdfV1s8DYbTowx1RxGKNNRYrUcW07zOG34llGD9v0i9SiKbyMPrqpqiGNfkqe97Zny3fCQmecyOSXXNbJIFKPYbCObdaqo3ygR07TVc9SAN4ymL+3z1gPfr3oewu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AsHkHNbR; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d5f37cf8c8so7078575ad.2
        for <bpf@vger.kernel.org>; Tue, 16 Jan 2024 18:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705459805; x=1706064605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CA6b+2DZIqcKZkqkcsUnYt8pOVPzq4sUUdqonFgxbw0=;
        b=AsHkHNbRx8ErOybMcHHq8y4BlLP0M6VKPpQapJRz9PvDt2K5bvocqyf3Nx3F7nA5KH
         Ftji1VlpehSfdCgbq33sYVy6MIkmesQeRdj/ZRrPVVYBZPGCi2tKVH1EXrcXcCkxHj+m
         bPwTafRNHys+QYmUnR8TKDDFkXfdCRf5crWDtzp/CCJe02Ar93jM+J0xTsfKiwhnpnpW
         ZvqTCkdEixy6dYeTAzfQ1lMsreJ5t6vaLel8b7GbpCKHS+Idyg8ztz0Ugtt42lQwVmmt
         LcXC1FvHjM/MMic1r/vY9GH9yE7nDZfn39fnJpv3SJJC4B8BUoz1z+/SMpSuq39hhoHs
         7zsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705459805; x=1706064605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CA6b+2DZIqcKZkqkcsUnYt8pOVPzq4sUUdqonFgxbw0=;
        b=UGqGvFwgPASCAIwzVtMEDuEfFd2VJu43LbmrxeYP8EZspHEHoMC4TkTf9pZTw6sC6u
         /DUj4aIK9llpeUkADKUI4b9z+VJsB75Lplno4o5bEGbRbQV3YUhP7JYBWIzJ+NQ1z8Ze
         XSk4KYlaGTWg0J0f9vIPRFc0dnzX1PDj9ttXizO63TkA/HVqkkmXmNmgdMuGL52tLZKs
         KV3PR9XDUfdtOuOrpYjxn1gZ9KtlA7pPP5beUh8EjBZd1sHeRwkV8+La2+ZdNV9Yd9Mc
         QMcpokNPoJrLmrQ1sCEqlDZFsKiCCKqlMPYTIwZyL9JA70wbFkbSLb6MF7I+k6LoqkWD
         e2XQ==
X-Gm-Message-State: AOJu0YyTWVvq7T2rBtz/FKRVP10GDerDuGzGPPPLWJUniaKwEzLOzOtv
	VgU6M0ebRSDG7DmJWM2ZH2c=
X-Google-Smtp-Source: AGHT+IFhWRmsPQ/A8hunx4EPGj7jvlb4EF6HB3JJ/wlLIN81Z/W6SDABqCq4RjLrKwOThSKjY41LsA==
X-Received: by 2002:a17:902:eccd:b0:1d5:c38e:aa4a with SMTP id a13-20020a170902eccd00b001d5c38eaa4amr3594016plh.92.1705459805161;
        Tue, 16 Jan 2024 18:50:05 -0800 (PST)
Received: from vultr.guest ([2001:19f0:ac02:50f:5400:4ff:feba:a83e])
        by smtp.gmail.com with ESMTPSA id w18-20020a170902c79200b001d0cfd7f6b9sm9996883pla.54.2024.01.16.18.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 18:50:04 -0800 (PST)
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
	lkp@intel.com,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v3 bpf-next 3/3] selftests/bpf: Add selftests for cpumask iter
Date: Wed, 17 Jan 2024 02:48:23 +0000
Message-Id: <20240117024823.4186-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240117024823.4186-1-laoar.shao@gmail.com>
References: <20240117024823.4186-1-laoar.shao@gmail.com>
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
  #65/1    cpumask_iter/init_pid:OK
  #65/2    cpumask_iter/invalid_pid:OK
  #65/3    cpumask_iter/self_pid_one_cpu:OK
  #65/4    cpumask_iter/self_pid_multi_cpus:OK
  #65      cpumask_iter:OK
  Summary: 1/4 PASSED, 0 SKIPPED, 0 FAILED

CONFIG_PSI=y is required for this testcase.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 tools/testing/selftests/bpf/config            |   1 +
 .../selftests/bpf/prog_tests/cpumask_iter.c   | 134 ++++++++++++++++++
 .../selftests/bpf/progs/cpumask_common.h      |   3 +
 .../selftests/bpf/progs/test_cpumask_iter.c   |  56 ++++++++
 4 files changed, 194 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cpumask_iter.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_cpumask_iter.c

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index c125c441abc7..9c42568ed376 100644
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
diff --git a/tools/testing/selftests/bpf/prog_tests/cpumask_iter.c b/tools/testing/selftests/bpf/prog_tests/cpumask_iter.c
new file mode 100644
index 000000000000..984d01d09d79
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/cpumask_iter.c
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Yafang Shao <laoar.shao@gmail.com> */
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
+	ASSERT_GE(psi_running, nr_running_exp, "psi_running");
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
index 0cd4aebb97cf..cdb9dc95e9d9 100644
--- a/tools/testing/selftests/bpf/progs/cpumask_common.h
+++ b/tools/testing/selftests/bpf/progs/cpumask_common.h
@@ -55,6 +55,9 @@ void bpf_cpumask_copy(struct bpf_cpumask *dst, const struct cpumask *src) __ksym
 u32 bpf_cpumask_any_distribute(const struct cpumask *src) __ksym;
 u32 bpf_cpumask_any_and_distribute(const struct cpumask *src1, const struct cpumask *src2) __ksym;
 u32 bpf_cpumask_weight(const struct cpumask *cpumask) __ksym;
+int bpf_iter_cpumask_new(struct bpf_iter_cpumask *it, const struct cpumask *mask) __ksym;
+int *bpf_iter_cpumask_next(struct bpf_iter_cpumask *it) __ksym;
+void bpf_iter_cpumask_destroy(struct bpf_iter_cpumask *it) __ksym;
 
 void bpf_rcu_read_lock(void) __ksym;
 void bpf_rcu_read_unlock(void) __ksym;
diff --git a/tools/testing/selftests/bpf/progs/test_cpumask_iter.c b/tools/testing/selftests/bpf/progs/test_cpumask_iter.c
new file mode 100644
index 000000000000..cb8b8359516b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_cpumask_iter.c
@@ -0,0 +1,56 @@
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
+extern const struct psi_group_cpu system_group_pcpu __ksym __weak;
+extern const struct rq runqueues __ksym __weak;
+
+int target_pid;
+
+SEC("iter.s/cgroup")
+int BPF_PROG(cpu_cgroup, struct bpf_iter_meta *meta, struct cgroup *cgrp)
+{
+	u32 nr_running = 0, psi_nr_running = 0, nr_cpus = 0;
+	struct psi_group_cpu *groupc;
+	struct task_struct *p;
+	struct rq *rq;
+	int *cpu;
+
+	/* epilogue */
+	if (cgrp == NULL)
+		return 0;
+
+	bpf_rcu_read_lock();
+	p = bpf_task_from_pid(target_pid);
+	if (!p) {
+		bpf_rcu_read_unlock();
+		return 1;
+	}
+
+	bpf_for_each(cpumask, cpu, p->cpus_ptr) {
+		rq = (struct rq *)bpf_per_cpu_ptr(&runqueues, *cpu);
+		if (!rq)
+			continue;
+		nr_running += rq->nr_running;
+		nr_cpus += 1;
+
+		groupc = (struct psi_group_cpu *)bpf_per_cpu_ptr(&system_group_pcpu, *cpu);
+		if (!groupc)
+			continue;
+		psi_nr_running += groupc->tasks[NR_RUNNING];
+	}
+	BPF_SEQ_PRINTF(meta->seq, "nr_running %u nr_cpus %u psi_running %u\n",
+		       nr_running, nr_cpus, psi_nr_running);
+
+	bpf_task_release(p);
+	bpf_rcu_read_unlock();
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.39.1


