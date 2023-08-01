Return-Path: <bpf+bounces-6563-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4B176B783
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 16:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEBBC1C20EEF
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 14:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3D026B6A;
	Tue,  1 Aug 2023 14:29:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0FF25149
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 14:29:37 +0000 (UTC)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766CFE9
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 07:29:31 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-686efb9ee0cso5578061b3a.3
        for <bpf@vger.kernel.org>; Tue, 01 Aug 2023 07:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690900171; x=1691504971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2sUkC4jkUYFldvTGZxhhk+zWylwTGWzdpzJvGKnftz8=;
        b=Gg449gmapyYiLQ8s3HS4nEvdO/DISkPqXZMTP6R5fWs+jJ1PkbOq29ksYsdMDK4u07
         P/LX/Gdz3JaJMSQcG383Ltb1OJ00quo9MNoENlSyOfu1VfN3XOEdk0Ujd2XCsKt9AjKe
         5X8r1yGkYJecY289iQ9GDTnh+UJKgNjYsSTr9hqhmJudPt5ObQsXtk3r3dnpRFXHfERg
         OKRj0miQiEMVqmZnfd/kgGuFMbPOBcCFYHyyLfDgeDbwNvMNE+cshCActEBnoJ8ecDDS
         76T2/QzPlQ3KD/H/xIci8/flxu3go37LZcqBTViXJ2V2q2eY+xBkGGGiXXEmGVnFknG5
         jPOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690900171; x=1691504971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2sUkC4jkUYFldvTGZxhhk+zWylwTGWzdpzJvGKnftz8=;
        b=HXmG4/0izPhyTCpA+l5D2octqn4oozNe1b+S0HJoB7ntBNV5DNClkGWkJ8yLzTr/JT
         h7XVv1BZEnEVIP9dnM++/GDDeYzXXBJFevvCVkeVh4WbF1VP5viH47l3Dq7zaUzXQhSc
         Q6ef2hIAmjgZu3Baql7Tyfwka4OHlFy3l2PG/gG4/JG929azElnTej0az4Rdv9WtXjm0
         r6Jcq2eulRwUSqWq9ap570dwwfIhLXOFVuctu4KbdxlouFXrlTDcV4cbyNrwRoY9NKyp
         ecWvvEuRRTKNvCHSskrxW57YrDwteadcNK6IfzsQjslmm+YWZOIghXRIY8TDumRIqz2b
         zY7w==
X-Gm-Message-State: ABy/qLbJ2V3Tp2godIamlMD37N2ZxgfvsMCeU+IdVapT8F4HVGMcwoND
	4RZsGWMCFOkTF6kN1m1QE14=
X-Google-Smtp-Source: APBJJlHlaoRIIWzQgtLqFfhb5SJmkZZox7XGcH+5v/H48hp0SkVo1/zsNjQIPCvNZvw9GhLfLxDpjA==
X-Received: by 2002:a05:6a00:b8a:b0:687:494c:2ebf with SMTP id g10-20020a056a000b8a00b00687494c2ebfmr4980186pfj.7.1690900170895;
        Tue, 01 Aug 2023 07:29:30 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:1409:5400:4ff:fe86:cf7a])
        by smtp.gmail.com with ESMTPSA id n2-20020aa79042000000b00686a80f431dsm9391491pfo.126.2023.08.01.07.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 07:29:30 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 3/3] selftests/bpf: Add selftest for for_each_cpu
Date: Tue,  1 Aug 2023 14:29:12 +0000
Message-Id: <20230801142912.55078-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230801142912.55078-1-laoar.shao@gmail.com>
References: <20230801142912.55078-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add selftest for the new for_each_cpu helper.

The result:
  $ tools/testing/selftests/bpf/test_progs --name=for_each_cpu
  #84/1    for_each_cpu/psi_system:OK
  #84/2    for_each_cpu/psi_cgroup:OK
  #84/3    for_each_cpu/invalid_cpumask:OK
  #84      for_each_cpu:OK
  Summary: 1/3 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 .../selftests/bpf/prog_tests/for_each_cpu.c        | 137 +++++++++++++++++++++
 .../selftests/bpf/progs/test_for_each_cpu.c        |  63 ++++++++++
 2 files changed, 200 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/for_each_cpu.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_for_each_cpu.c

diff --git a/tools/testing/selftests/bpf/prog_tests/for_each_cpu.c b/tools/testing/selftests/bpf/prog_tests/for_each_cpu.c
new file mode 100644
index 0000000..b0eaaec
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/for_each_cpu.c
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Yafang Shao <laoar.shao@gmail.com> */
+
+#include <test_progs.h>
+#include <bpf/libbpf.h>
+#include "cgroup_helpers.h"
+#include "test_for_each_cpu.skel.h"
+
+static void verify_percpu_psi_value(struct test_for_each_cpu *skel, int fd, __u32 running, int res)
+{
+	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
+	union bpf_iter_link_info linfo;
+	int len, iter_fd, result;
+	struct bpf_link *link;
+	static char buf[128];
+	__u32 nr_running;
+	size_t left;
+	char *p;
+
+	memset(&linfo, 0, sizeof(linfo));
+	linfo.cgroup.cgroup_fd = fd;
+	linfo.cgroup.order = BPF_CGROUP_ITER_SELF_ONLY;
+	opts.link_info = &linfo;
+	opts.link_info_len = sizeof(linfo);
+
+	link = bpf_program__attach_iter(skel->progs.psi_cgroup, &opts);
+	if (!ASSERT_OK_PTR(link, "attach_iter"))
+		return;
+
+	iter_fd = bpf_iter_create(bpf_link__fd(link));
+	if (!ASSERT_GE(iter_fd, 0, "iter_fd"))
+		goto free_link;
+
+	memset(buf, 0, sizeof(buf));
+	left = ARRAY_SIZE(buf);
+	p = buf;
+	while ((len = read(iter_fd, p, left)) > 0) {
+		p += len;
+		left -= len;
+	}
+
+	ASSERT_EQ(sscanf(buf, "nr_running %u ret %d\n", &nr_running, &result), 2, "seq_format");
+	ASSERT_EQ(result, res, "for_each_cpu_result");
+	if (running)
+		ASSERT_GE(nr_running, running, "nr_running");
+	else
+		ASSERT_EQ(nr_running, running, "nr_running");
+
+	/* read() after iter finishes should be ok. */
+	if (len == 0)
+		ASSERT_OK(read(iter_fd, buf, sizeof(buf)), "second_read");
+	close(iter_fd);
+free_link:
+	bpf_link__destroy(link);
+}
+
+void test_root_cgroup(struct test_for_each_cpu *skel)
+{
+	int cgrp_fd, nr_cpus;
+
+	cgrp_fd = get_root_cgroup();
+	if (!ASSERT_GE(cgrp_fd, 0, "create cgrp"))
+		return;
+
+	skel->bss->cpu_mask = CPU_MASK_POSSIBLE;
+	skel->bss->pid = 0;
+	nr_cpus = bpf_num_possible_cpus();
+	/* At least current is running */
+	verify_percpu_psi_value(skel, cgrp_fd, 1, nr_cpus);
+	close(cgrp_fd);
+}
+
+void test_child_cgroup(struct test_for_each_cpu *skel)
+{
+	int cgrp_fd, nr_cpus;
+
+	cgrp_fd = create_and_get_cgroup("for_each_cpu");
+	if (!ASSERT_GE(cgrp_fd, 0, "create cgrp"))
+		return;
+
+	skel->bss->cpu_mask = CPU_MASK_POSSIBLE;
+	skel->bss->pid = 0;
+	nr_cpus = bpf_num_possible_cpus();
+	/* No tasks in the cgroup */
+	verify_percpu_psi_value(skel, cgrp_fd, 0, nr_cpus);
+	close(cgrp_fd);
+	remove_cgroup("for_each_cpu");
+}
+
+void verify_invalid_cpumask(struct test_for_each_cpu *skel, int fd, __u32 cpumask, __u32 pid)
+{
+	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
+
+	skel->bss->cpu_mask = cpumask;
+	skel->bss->pid = pid;
+	verify_percpu_psi_value(skel, fd, 0, -EINVAL);
+}
+
+void test_invalid_cpumask(struct test_for_each_cpu *skel)
+{
+	int cgrp_fd;
+
+	cgrp_fd = create_and_get_cgroup("for_each_cpu");
+	if (!ASSERT_GE(cgrp_fd, 0, "create cgrp"))
+		return;
+
+	verify_invalid_cpumask(skel, cgrp_fd, CPU_MASK_POSSIBLE, 1);
+	verify_invalid_cpumask(skel, cgrp_fd, CPU_MASK_PRESENT, 1);
+	verify_invalid_cpumask(skel, cgrp_fd, CPU_MASK_ONLINE, 1);
+	verify_invalid_cpumask(skel, cgrp_fd, CPU_MASK_TASK, 0);
+	verify_invalid_cpumask(skel, cgrp_fd, -1, 0);
+	verify_invalid_cpumask(skel, cgrp_fd, -1, 1);
+	close(cgrp_fd);
+	remove_cgroup("for_each_cpu");
+}
+
+void test_for_each_cpu(void)
+{
+	struct test_for_each_cpu *skel = NULL;
+
+	skel = test_for_each_cpu__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_for_each_cpu__open_and_load"))
+		return;
+
+	if (setup_cgroup_environment())
+		return;
+
+	if (test__start_subtest("psi_system"))
+		test_root_cgroup(skel);
+	if (test__start_subtest("psi_cgroup"))
+		test_child_cgroup(skel);
+	if (test__start_subtest("invalid_cpumask"))
+		test_invalid_cpumask(skel);
+
+	test_for_each_cpu__destroy(skel);
+	cleanup_cgroup_environment();
+}
diff --git a/tools/testing/selftests/bpf/progs/test_for_each_cpu.c b/tools/testing/selftests/bpf/progs/test_for_each_cpu.c
new file mode 100644
index 0000000..1554895
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_for_each_cpu.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2023 Yafang Shao <laoar.shao@gmail.com> */
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#define __percpu __attribute__((btf_type_tag("percpu")))
+
+enum bpf_cpu_mask_type cpu_mask;
+__u32 pid;
+
+struct callback_ctx {
+	__u32 nr_running;
+	__u32 id;
+};
+
+static uint64_t cgroup_id(struct cgroup *cgrp)
+{
+	return cgrp->kn->id;
+}
+
+static int callback(__u32 cpu, void *ctx, const void *ptr)
+{
+	unsigned int tasks[NR_PSI_TASK_COUNTS];
+	const struct psi_group_cpu *groupc = ptr;
+	struct callback_ctx *data = ctx;
+
+	bpf_probe_read_kernel(&tasks, sizeof(tasks), &groupc->tasks);
+	data->nr_running += tasks[NR_RUNNING];
+	return 0;
+}
+
+SEC("iter.s/cgroup")
+int BPF_PROG(psi_cgroup, struct bpf_iter_meta *meta, struct cgroup *cgrp)
+{
+	struct seq_file *seq = (struct seq_file *)meta->seq;
+	struct psi_group_cpu __percpu *pcpu_ptr;
+	struct callback_ctx data;
+	struct psi_group *psi;
+	__u64 cg_id;
+	int ret;
+
+	cg_id = cgrp ? cgroup_id(cgrp) : 0;
+	if (!cg_id)
+		return 1;
+
+	psi = cgrp->psi;
+	if (!psi)
+		return 1;
+
+	pcpu_ptr = psi->pcpu;
+	if (!pcpu_ptr)
+		return 1;
+
+	data.nr_running = 0;
+	data.id = cg_id;
+	ret = bpf_for_each_cpu(callback, &data, pcpu_ptr, cpu_mask, pid);
+	BPF_SEQ_PRINTF(seq, "nr_running %d ret %d\n", data.nr_running, ret);
+
+	return ret ? 1 : 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
1.8.3.1


