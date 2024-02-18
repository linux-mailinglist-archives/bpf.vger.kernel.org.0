Return-Path: <bpf+bounces-22230-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8A78596B7
	for <lists+bpf@lfdr.de>; Sun, 18 Feb 2024 12:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F5DAB21F23
	for <lists+bpf@lfdr.de>; Sun, 18 Feb 2024 11:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A1E633E7;
	Sun, 18 Feb 2024 11:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iiuyvBhC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563A84EB41
	for <bpf@vger.kernel.org>; Sun, 18 Feb 2024 11:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708256948; cv=none; b=Ez1JiS30VVtOVjs2iHzMRTFO96Lit3+EUR53brAZUlKYLWW6xnfWHI7Rt9S/HOyzr93e4pXPVcEfRPmg3J7ym080j+OTz8Q6x1rXDyoXW+RRHshjKrlQ7nN0JGcS6LT6pw1lV4Ax8zvXcA47JglFbn9jitr7LL0bFA5V6mJ6mFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708256948; c=relaxed/simple;
	bh=3WaNp7qmkJ9WPmz1dOL0Kot/z30M8cGEzLsty2daexA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nngll+n2LlqvoO7dZNABZIu5OB7os46GsBiTUdGWUo8JDXH6zxl2JMC48ih78APe2s5cOYg20O1yafLAj3M+tyczFzq17K//b/grxAfdRG18lQO4kI/mIXJGgck2IzfMfx84U1KSUU+lSFIOzJfMKgyRa2aM/sohj/OfJmOcWIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iiuyvBhC; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7c745af8f1cso18885439f.1
        for <bpf@vger.kernel.org>; Sun, 18 Feb 2024 03:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708256945; x=1708861745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h2tMCAdIMGkoJHjGZWIft4gPYp2SoUh78o9uKIOLnqQ=;
        b=iiuyvBhChLKqz8QHuivUTtLNAE/B/sRK/44GrJA1/COVTxGEajxWhFDC8HBXg/9VLj
         p1EdNQpms67nQPaoMWV1nc/KmX2xShBEUQSlnkdGNiZA/N1v3/R5XzO7tOQkdF84082p
         8h1xekmQVtWbYhVDdpZiX02VSMaX0isY2vvqIkOnZWtHfCuceLdcMb08aS5Ujy++6qA9
         r6SwFysi5TuoYQXJfHbQ4kYDmdTHUfNuXCKO1j42VFLP5FwoTdpbWamjwkiS2Fh86y1f
         QBXCmdazU7wse1QcTh/NeOj6L0XiLGC5CMXwVHrQClkjj2RNCmsRMee69bzHOoOx5Awu
         J24A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708256945; x=1708861745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h2tMCAdIMGkoJHjGZWIft4gPYp2SoUh78o9uKIOLnqQ=;
        b=UPp18TgSpIiSKgjyDVue2AWrPTcJ6OlJ1W52HOOUSREuOuXlnyK2ZAlMrli2JzPPZz
         +PwloFlMrQN0qttY3zy5OjkQo2Y6gsMcx7SPvldzO94nBiatkFCAA6NdNLDS5YRR6EMg
         AKRnXnzp2fyAqxQgoiJ86t/YMuJubCbygi6voEjj5STbXoAPtT2gbkf1jxppshUHM66T
         4nccjxwmljaoxBTM+1Hxr3A4OCzzcJ0CLgNdYZnq2YUcFgp7cjEpAuuBGYNgvPmGC2fL
         GARfOqPTmBpxgj2dbUnajFOPa7Np4CsnGcLQPmYo3hTbwLe1fkQz1muO7DFTdW3ZZ5rE
         pSmg==
X-Gm-Message-State: AOJu0Yy1W7oAcORWmnWkO8SbSaxFkCoudpGzfrC1bre/fhwkFTLVpmfC
	LtOic4NVlZsRZXHktnlFzOrXQtpTFBYESuBes/CMQilUYEOimCSnL/NfBQkIaJqmr+SZ
X-Google-Smtp-Source: AGHT+IH7NCMHQcdyxrm8HHUefh2QQZ3n8rWF9HhPE7tTt5KFHf/OOtmnOFo33rnU8pIdTmfRaaJV9Q==
X-Received: by 2002:a05:6602:1238:b0:7c3:6323:306b with SMTP id z24-20020a056602123800b007c36323306bmr11891846iot.12.1708256945414;
        Sun, 18 Feb 2024 03:49:05 -0800 (PST)
Received: from localhost.localdomain ([39.144.106.222])
        by smtp.gmail.com with ESMTPSA id 203-20020a6302d4000000b005dc832ed816sm2857551pgc.59.2024.02.18.03.48.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Feb 2024 03:49:04 -0800 (PST)
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
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add selftest for bits iter
Date: Sun, 18 Feb 2024 19:48:18 +0800
Message-Id: <20240218114818.13585-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240218114818.13585-1-laoar.shao@gmail.com>
References: <20240218114818.13585-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add selftests for the newly added bits iter.
- bits_iter_success
  - The number of CPUs should be expected when iterating over a cpumask
  - percpu data extracted from the percpu struct should be expected
  - RCU lock is not required
  - It is fine without calling bpf_iter_cpumask_next()
  - It can work as expected when invalid arguments are passed

- bits_iter_failure
  - bpf_iter_bits_destroy() is required after calling
    bpf_iter_bits_new()
  - bpf_iter_bits_destroy() can only destroy an initialized iter
  - bpf_iter_bits_next() must use an initialized iter

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 tools/testing/selftests/bpf/config            |   1 +
 .../selftests/bpf/prog_tests/bits_iter.c      | 180 ++++++++++++++++++
 .../bpf/progs/test_bits_iter_failure.c        |  53 ++++++
 .../bpf/progs/test_bits_iter_success.c        | 146 ++++++++++++++
 4 files changed, 380 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bits_iter.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_bits_iter_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_bits_iter_success.c

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
diff --git a/tools/testing/selftests/bpf/prog_tests/bits_iter.c b/tools/testing/selftests/bpf/prog_tests/bits_iter.c
new file mode 100644
index 000000000000..778a7c942dba
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bits_iter.c
@@ -0,0 +1,180 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Yafang Shao <laoar.shao@gmail.com> */
+
+#define _GNU_SOURCE
+#include <sched.h>
+
+#include <test_progs.h>
+#include "test_bits_iter_success.skel.h"
+#include "test_bits_iter_failure.skel.h"
+#include "cgroup_helpers.h"
+
+static const char * const positive_testcases[] = {
+	"cpumask_iter",
+};
+
+static const char * const negative_testcases[] = {
+	"null_pointer",
+	"zero_bit",
+	"no_mem",
+	"invalid_bits"
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
+static void verify_iter_success(const char *prog_name, bool negtive)
+{
+	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
+	int cgrp_fd, nr_cpus, err, i, chosen = 0;
+	struct test_bits_iter_success *skel;
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
+	skel = test_bits_iter_success__open();
+	if (!ASSERT_OK_PTR(skel, "cpumask_iter_success__open"))
+		goto close_fd;
+
+	skel->bss->pid = getpid();
+	nr_cpus = libbpf_num_possible_cpus();
+	skel->bss->total_nr_cpus = nr_cpus;
+
+	err = test_bits_iter_success__load(skel);
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
+	if (negtive)
+		goto negtive;
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
+
+negtive:
+	ASSERT_OK(skel->bss->err, "null_rq_psi");
+
+free_link:
+	bpf_link__destroy(link);
+destroy:
+	test_bits_iter_success__destroy(skel);
+close_fd:
+	close(cgrp_fd);
+cleanup:
+	cleanup_cgroup_environment();
+}
+
+void test_bits_iter(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(positive_testcases); i++) {
+		if (!test__start_subtest(positive_testcases[i]))
+			continue;
+
+		verify_iter_success(positive_testcases[i], false);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(negative_testcases); i++) {
+		if (!test__start_subtest(negative_testcases[i]))
+			continue;
+
+		verify_iter_success(negative_testcases[i], true);
+	}
+
+	RUN_TESTS(test_bits_iter_success);
+	RUN_TESTS(test_bits_iter_failure);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_bits_iter_failure.c b/tools/testing/selftests/bpf/progs/test_bits_iter_failure.c
new file mode 100644
index 000000000000..c51f18f4f334
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_bits_iter_failure.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2024 Yafang Shao <laoar.shao@gmail.com> */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#include "bpf_misc.h"
+#include "task_kfunc_common.h"
+
+char _license[] SEC("license") = "GPL";
+
+int bpf_iter_bits_new(struct bpf_iter_bits *it, const void *unsafe_ptr, u32 nr_bits) __ksym __weak;
+int *bpf_iter_bits_next(struct bpf_iter_bits *it) __ksym __weak;
+void bpf_iter_bits_destroy(struct bpf_iter_bits *it) __ksym __weak;
+
+SEC("iter.s/cgroup")
+__failure __msg("Unreleased reference id=3 alloc_insn=10")
+int BPF_PROG(no_destroy, struct bpf_iter_meta *meta, struct cgroup *cgrp)
+{
+	struct bpf_iter_bits it;
+	struct task_struct *p;
+
+	p = bpf_task_from_pid(1);
+	if (!p)
+		return 1;
+
+	bpf_iter_bits_new(&it, p->cpus_ptr, 8192);
+
+	bpf_iter_bits_next(&it);
+	bpf_task_release(p);
+	return 0;
+}
+
+SEC("iter/cgroup")
+__failure __msg("expected an initialized iter_bits as arg #1")
+int BPF_PROG(next_uninit, struct bpf_iter_meta *meta, struct cgroup *cgrp)
+{
+	struct bpf_iter_bits *it = NULL;
+
+	bpf_iter_bits_next(it);
+	return 0;
+}
+
+SEC("iter/cgroup")
+__failure __msg("expected an initialized iter_bits as arg #1")
+int BPF_PROG(destroy_uninit, struct bpf_iter_meta *meta, struct cgroup *cgrp)
+{
+	struct bpf_iter_bits it = {};
+
+	bpf_iter_bits_destroy(&it);
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/test_bits_iter_success.c b/tools/testing/selftests/bpf/progs/test_bits_iter_success.c
new file mode 100644
index 000000000000..6e5f12ad17ce
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_bits_iter_success.c
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2024 Yafang Shao <laoar.shao@gmail.com> */
+
+#include "vmlinux.h"
+#include <linux/const.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#include "task_kfunc_common.h"
+
+char _license[] SEC("license") = "GPL";
+
+extern const struct psi_group_cpu system_group_pcpu __ksym __weak;
+extern const struct rq runqueues __ksym __weak;
+
+int bpf_iter_bits_new(struct bpf_iter_bits *it, const void *unsafe_ptr, u32 nr_bits) __ksym __weak;
+int *bpf_iter_bits_next(struct bpf_iter_bits *it) __ksym __weak;
+void bpf_iter_bits_destroy(struct bpf_iter_bits *it) __ksym __weak;
+
+int pid, err, total_nr_cpus;
+
+SEC("iter.s/cgroup")
+int BPF_PROG(cpumask_iter, struct bpf_iter_meta *meta, struct cgroup *cgrp)
+{
+	u32 nr_running = 0, psi_nr_running = 0, nr_cpus = 0;
+	struct psi_group_cpu *groupc;
+	struct task_struct *p;
+	struct rq *rq;
+	int *cpu;
+
+	/* epilogue */
+	if (!cgrp)
+		return 0;
+
+	p = bpf_task_from_pid(pid);
+	if (!p)
+		return 1;
+
+	bpf_for_each(bits, cpu, p->cpus_ptr, total_nr_cpus) {
+		rq = (struct rq *)bpf_per_cpu_ptr(&runqueues, *cpu);
+		/* Each valid CPU must have a runqueue, even if it is offline. */
+		if (!rq) {
+			err++;
+			continue;
+		}
+
+		nr_running += rq->nr_running;
+		nr_cpus++;
+
+		groupc = (struct psi_group_cpu *)bpf_per_cpu_ptr(&system_group_pcpu, *cpu);
+		if (!groupc) {
+			err++;
+			continue;
+		}
+		psi_nr_running += groupc->tasks[NR_RUNNING];
+	}
+	BPF_SEQ_PRINTF(meta->seq, "nr_running %u nr_cpus %u psi_running %u\n",
+		       nr_running, nr_cpus, psi_nr_running);
+	bpf_task_release(p);
+	return 0;
+}
+
+SEC("iter.s/cgroup")
+int BPF_PROG(null_pointer, struct bpf_iter_meta *meta, struct cgroup *cgrp)
+{
+	int *cpu;
+
+	bpf_for_each(bits, cpu, NULL, total_nr_cpus)
+		err++;
+	return 0;
+}
+
+SEC("iter.s/cgroup")
+int BPF_PROG(zero_bit, struct bpf_iter_meta *meta, struct cgroup *cgrp)
+{
+	struct task_struct *p;
+	int *cpu;
+
+	p = bpf_task_from_pid(pid);
+	if (!p)
+		return 1;
+
+	bpf_for_each(bits, cpu, p->cpus_ptr, 0)
+		err++;
+	bpf_task_release(p);
+	return 0;
+}
+
+SEC("iter.s/cgroup")
+int BPF_PROG(no_mem, struct bpf_iter_meta *meta, struct cgroup *cgrp)
+{
+	struct task_struct *p;
+	int *cpu;
+
+	p = bpf_task_from_pid(pid);
+	if (!p)
+		return 1;
+
+	/* The max size of memalloc is 4096, so it will fail to allocate (8192 * 8) */
+	bpf_for_each(bits, cpu, p->cpus_ptr, 8192 * 8)
+		err++;
+	bpf_task_release(p);
+	return 0;
+}
+
+SEC("iter/cgroup")
+int BPF_PROG(invalid_bits, struct bpf_iter_meta *meta, struct cgroup *cgrp)
+{
+	struct task_struct *p;
+	struct rq *rq;
+	int *cpu;
+
+	p = bpf_task_from_pid(pid);
+	if (!p)
+		return 1;
+
+	bpf_for_each(bits, cpu, p->cpus_ptr, 8192) {
+		rq = (struct rq *)bpf_per_cpu_ptr(&runqueues, *cpu);
+		/* For invalid CPU IDs, the rq must be NULL. */
+		if (!rq)
+			err++;
+	}
+	if (err)
+		err -= 8192 - total_nr_cpus;
+	bpf_task_release(p);
+	return 0;
+}
+
+SEC("iter.s/cgroup")
+int BPF_PROG(no_next, struct bpf_iter_meta *meta, struct cgroup *cgrp)
+{
+	struct bpf_iter_bits it;
+	struct task_struct *p;
+
+	p = bpf_task_from_pid(1);
+	if (!p)
+		return 1;
+
+	bpf_iter_bits_new(&it, p->cpus_ptr, 8192);
+
+	/* It is fine without calling bpf_iter_bits_next(). */
+
+	bpf_iter_bits_destroy(&it);
+	bpf_task_release(p);
+	return 0;
+}
-- 
2.39.1


