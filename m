Return-Path: <bpf+bounces-20828-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6299C844287
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 16:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 432DDB2DE3B
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 15:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203B512F59E;
	Wed, 31 Jan 2024 14:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bK9IRsxg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C349D5A7A1
	for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 14:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706712951; cv=none; b=RrZRYCl59dr5rwXhMMDjXSchoZq3oqxIb+IaB7n+h+d9yXVtDHudCv/fgFrOT8eccPvlRzLAflP+ZSenuou2XLpUHIGp91eDh6O1MzbSiAuUjHL0w+vkqJWZV63SLBAoUJvTXs+OX42VIZDNKnKIirhY90g6D7f1Z5P/MaKnrf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706712951; c=relaxed/simple;
	bh=QO5MIjxJ7/x8+8ylOf3p3QOCyCIxltZM6GSyZXgPXEA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S8BM/ybHuDQm84vxrHRGZ7hFxMy2PKnFkiL6xUAowJsNLUl8eiYp+5HCK4ZADcZV2Z7kViJW8qTVqM1xD3Z8KY+J4ZHsNGt1LgpX/AvKM04BCPnc+PkUUnhlxVXeYvz9wp8gsILV/P0D6RrjxOpBUvYkPNHwJb2ySvUfJl90Rc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bK9IRsxg; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d911c9240dso13929485ad.2
        for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 06:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706712949; x=1707317749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oSzFTJ0yiPmz775UN9q2r6hu07LtuGqAxTUcHaz+IlI=;
        b=bK9IRsxgOYINgoRjAFVckLVR1GUUDgD4UVhOujgJ7VJt5PLCt5nOlf+YJKAWKPzlJG
         RJpa6N8TFmP0hL7ZwzFMWNX36DoIYkpW8iIrTfOj3558u1e2rgvqjbWhmmZnYcapuwU+
         NF2O36WizN1cDVxPEgmdj/owYHSuo8fTDosLaamM85GC149F9I739zCFqeH4m/DAUT9+
         K8IaNWYs0FlocZQmMS+14bqcgfFgv/P+C14dWOyfqXZtWAhLMchU0ZMej5IxFGAHPhhG
         I+txIV+7JRtI7+Z+lDaOWbsS/SSteSZaVLhe6R8pHKwyfTPbogeljPuAWcw4XJ7/KIFv
         v3MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706712949; x=1707317749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oSzFTJ0yiPmz775UN9q2r6hu07LtuGqAxTUcHaz+IlI=;
        b=EFWP0QJi6wSFC/SLMOUAY40SDbGnLbnoiNnPtUaqtXF1QhUdkPughaw6GZVHlm2GOn
         C3s3lRqoyX6b4lfDjTSh9VUqnkhqUhf+zVIw8UNk45mviBEafwin2+gN8mYFtdmPsfOS
         HWy+2B1q5fwtZZqrcJ6e7fYtwvFR+uqfHqfqDNPI0kI5EGD7IPqA58BaWuT+nDyi44q4
         pDOb4I89pGUN8M5NQOIwMxfpAdkbcoaGzYwc69VV1/UfacCduvehqSPPp2kMxJpqHPBs
         ewee27KLz/VKKISHHpQgXfhtvbDhg3QTwNgQB2NzuSZfgdrEsgFN9gteVf/MH4LCuAy9
         jEVg==
X-Gm-Message-State: AOJu0YwK0eBhbN4R0xCsaJpMrY2dhtzUCHLMcBap5JTB8Q8aJRso/ZOE
	CXsvI6p2V6btyBHt/NW8ydr1xhJs/PvkNtr2bulcrfQYpgv5RDpB
X-Google-Smtp-Source: AGHT+IFEOsqUO6HTqtMz6F1EKFa57X3q0cnCdIJGTF6DHnZk7h4m4iZEChQtkll6NUyenNOAJdJShw==
X-Received: by 2002:a17:902:e804:b0:1d7:357c:b87 with SMTP id u4-20020a170902e80400b001d7357c0b87mr2005780plg.51.1706712948772;
        Wed, 31 Jan 2024 06:55:48 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU4F0NUtkFsJfyd/1r5ay6qJZyMpi2dierEuFAhDf3whtFgveayOHEeD+JuvWcvpbXLmxkA95SepB1wFDE3F31T+B87RLxmnJlilLPCoTp650NykXw2ZJX/vMVEA3W86l8VH9bmD8+a3IHkDYJhYQx7TIDlr1UtIxVwq8tX47w8pDmGo9oFmj38rw5qyAOgYzRH+xbXAGGr5dZ2lYmE+3bcUkWZq0mQBYVusF5ImrnyPg14XzZkKjvPCR++epE+4hWiM13ABIlqn7WbWiUgKYULPf2jVAsAaUrWwUHdPp2jLwB1Xxcl1ZJcAoK3wOMuzUg6X3766Ja1gbHbIxXBXEBsctmtSoqnhmWmpQg36iKaLcnDeJGSnIE9VjtOM7VpFMZziXsD++x9Jn/8Zfj+pkYeBreL
Received: from localhost.localdomain ([183.193.177.147])
        by smtp.gmail.com with ESMTPSA id s5-20020a170902a50500b001d8fe6cd0aasm3901335plq.286.2024.01.31.06.55.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jan 2024 06:55:48 -0800 (PST)
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
	tj@kernel.org,
	void@manifault.com
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v5 bpf-next 4/4] selftests/bpf: Add selftests for cpumask iter
Date: Wed, 31 Jan 2024 22:54:54 +0800
Message-Id: <20240131145454.86990-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240131145454.86990-1-laoar.shao@gmail.com>
References: <20240131145454.86990-1-laoar.shao@gmail.com>
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
  - bpf_iter_cpumask_destroy() can only destroy an initilialized iter
  - bpf_iter_cpumask_next() must use an initilialized iter

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
index 000000000000..4ce14ef98451
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
+#define READ_PERCPU_DATA(meta, cgrp, mask)							\
+{												\
+	u32 nr_running = 0, psi_nr_running = 0, nr_cpus = 0;					\
+	struct psi_group_cpu *groupc;								\
+	struct rq *rq;										\
+	int *cpu;										\
+												\
+	bpf_for_each(cpumask, cpu, mask) {							\
+		rq = (struct rq *)bpf_per_cpu_ptr(&runqueues, *cpu);				\
+		if (!rq) {									\
+			err += 1;								\
+			continue;								\
+		}										\
+		nr_running += rq->nr_running;							\
+		nr_cpus += 1;									\
+												\
+		groupc = (struct psi_group_cpu *)bpf_per_cpu_ptr(&system_group_pcpu, *cpu);	\
+		if (!groupc) {									\
+			err += 1;								\
+			continue;								\
+		}										\
+		psi_nr_running += groupc->tasks[NR_RUNNING];					\
+	}											\
+	BPF_SEQ_PRINTF(meta->seq, "nr_running %u nr_cpus %u psi_running %u\n",			\
+		       nr_running, nr_cpus, psi_nr_running);					\
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
+	READ_PERCPU_DATA(meta, cgrp, p->cpus_ptr);
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
+	READ_PERCPU_DATA(meta, cgrp, p->cpus_ptr);
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


