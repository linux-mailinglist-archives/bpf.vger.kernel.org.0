Return-Path: <bpf+bounces-22650-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4158629EE
	for <lists+bpf@lfdr.de>; Sun, 25 Feb 2024 11:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85781B2123A
	for <lists+bpf@lfdr.de>; Sun, 25 Feb 2024 10:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB75F9F2;
	Sun, 25 Feb 2024 10:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AnQ9v9n1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBCCF9DA
	for <bpf@vger.kernel.org>; Sun, 25 Feb 2024 10:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708855642; cv=none; b=Iax8qJGYG4PhlIj3fl3NHffv8lXMu7QmGVngemdN24sSsdMgyD0ZettNppYFVkbLMtN1JmAmL3JjSuL7SGWQlcHDAYrnuh9DinmOAkU8os0FzP3DWzGhZ8mH+rk/sjxtt/NcO109aNFM26RqKmescuu4Xbq4oet8QWoK1I3Vy5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708855642; c=relaxed/simple;
	bh=AZJSjP87qKhjMLH028pVoUqOqeb57Zn1szhsOh1z0Ic=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GCEy7EdxynwQjn19JzrAOO7Ho2EouqqvHFGkoinj0TeBFTcvU6h6JXlvDt7ZiUnhptDFBsURCjyYaRdjz+FBXHz+JCHL3KAZHiWU/oGE3jFgLIZ6zgSQ4eVlCnGqhPududp5G1fbEpNgU2X9b7AmktD+nsacZSIJqahwdvhkZTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AnQ9v9n1; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e3ffafa708so2305930b3a.1
        for <bpf@vger.kernel.org>; Sun, 25 Feb 2024 02:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708855640; x=1709460440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xIGYWE4BkfjBrM2/dGiNBlOGp6jwlpv0dixgSB4hP4Q=;
        b=AnQ9v9n1HKXcTatJjXtvHVy5tQFd0b3aUozfBMLz7RdX9JqhnwR8mda+2MXlTsaJgD
         BhNVzI8lPMePMipBfuJs8Sau2kgiUZthVkvKyAkDDLAqG8kDW0BlW+1i4skpFJwMSBmd
         TFAJZG1Pm/jYIOCni5xostAK8HNXL/+urn+9D3/ycF/vxKtSQ9B2dkQrWI86vkzxhFAq
         jVn5JW3TLNanpeOVdbmZYJCfo7YxQES5PzCYDdUi24Twh34xCg7jeurv+p6rQFAgmHtv
         d3jeWqpQmRt+1CUwE9MymFDZMytbfGbkhPP/TQ0oB+TPyrdQtBUuCFqVW/kt9uIqoj6e
         FwFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708855640; x=1709460440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xIGYWE4BkfjBrM2/dGiNBlOGp6jwlpv0dixgSB4hP4Q=;
        b=Xar4bpuFugYLl6qqCimsliLsP2HK80GxnNHWRdZdP8/J2N8pTKV0G6mgaxQsp76xgg
         npD50CQOeCiwmWivIKDJzfkwiouotN1v1cXQOH4Yc43Hrhj9uJgffMN+8ED/jUG9wKmj
         6SvvAVvGZM/Rt+P/jUP6qqXAaola3Z/Q4WqMyWqakOAUxOJd5KPod8OqUDrcCIYA2MjA
         qB8mU9ownvsKRLvbWDOL0RWS4nXDv6AzK8/6TFrIJTQdCw6RRs66IePCqE5Pa8x7hGQa
         RYduXOOWAKQC/M6iS1pAMoPyCwBM7Vk0s1BhmauEGKuJtRGVYSN2kPVQqD7HmjC6APgw
         Xkvg==
X-Gm-Message-State: AOJu0Yw6l6EbFINgvc9zCP2fmBLm2uf3NDR3mQ6vqyNUfnaYwA09YI/X
	LQxBCl5AMJFfovxv7ZUWfoJjLo7hI+PkPHqaxMBjy5W0t9iDgTPT
X-Google-Smtp-Source: AGHT+IF/HE5DD0aGX3OcSEsIMLan2lleKInfYQ/kdw+NHgoBpHXSmDDiloEb7vdEx9TrvW9cSqjGhQ==
X-Received: by 2002:a05:6a00:3305:b0:6e4:79af:78dd with SMTP id cq5-20020a056a00330500b006e479af78ddmr5620325pfb.10.1708855640473;
        Sun, 25 Feb 2024 02:07:20 -0800 (PST)
Received: from localhost.localdomain ([39.144.104.176])
        by smtp.gmail.com with ESMTPSA id f26-20020aa79d9a000000b006e1464e71f9sm2119775pfq.47.2024.02.25.02.07.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Feb 2024 02:07:19 -0800 (PST)
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
Subject: [PATCH v2 bpf-next 2/2] selftests/bpf: Add selftest for bits iter
Date: Sun, 25 Feb 2024 18:06:37 +0800
Message-Id: <20240225100637.48394-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240225100637.48394-1-laoar.shao@gmail.com>
References: <20240225100637.48394-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add selftests for the newly added bits iter.
- bits_iter_success
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
 .../selftests/bpf/prog_tests/bits_iter.c      | 132 ++++++++++++++++++
 .../bpf/progs/test_bits_iter_failure.c        |  54 +++++++
 .../bpf/progs/test_bits_iter_success.c        | 112 +++++++++++++++
 3 files changed, 298 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bits_iter.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_bits_iter_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_bits_iter_success.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bits_iter.c b/tools/testing/selftests/bpf/prog_tests/bits_iter.c
new file mode 100644
index 000000000000..8148b8991276
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bits_iter.c
@@ -0,0 +1,132 @@
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
+};
+
+static int read_percpu_data(struct bpf_link *link)
+{
+	int iter_fd, len;
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
+	close(iter_fd);
+	return 0;
+}
+
+static void verify_iter_success(const char *prog_name, bool negative)
+{
+	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
+	struct test_bits_iter_success *skel;
+	union bpf_iter_link_info linfo;
+	struct bpf_program *prog;
+	struct bpf_link *link;
+	int cgrp_fd, err, i;
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
+	if (negative)
+		goto negative;
+
+	CPU_ZERO(&set);
+	for (i = 0; i < libbpf_num_possible_cpus(); i++)
+		CPU_SET(i, &set);
+	err = sched_setaffinity(skel->bss->pid, sizeof(set), &set);
+	if (!ASSERT_OK(err, "setaffinity_all_cpus"))
+		goto free_link;
+	err = read_percpu_data(link);
+	if (!ASSERT_OK(err, "read_percpu_data"))
+		goto free_link;
+
+negative:
+	ASSERT_OK(skel->bss->err, "not_zero");
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
+		verify_iter_success(positive_testcases[i], true);
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
index 000000000000..974d0b7a540e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_bits_iter_failure.c
@@ -0,0 +1,54 @@
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
+int bpf_iter_bits_new(struct bpf_iter_bits *it, const void *unsafe_ptr__ign,
+		      u32 nr_bits) __ksym __weak;
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
index 000000000000..aaa14e491c0c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_bits_iter_success.c
@@ -0,0 +1,112 @@
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
+extern const struct rq runqueues __ksym __weak;
+
+int bpf_iter_bits_new(struct bpf_iter_bits *it, const void *unsafe_ptr__ign,
+		      u32 nr_bits) __ksym __weak;
+int *bpf_iter_bits_next(struct bpf_iter_bits *it) __ksym __weak;
+void bpf_iter_bits_destroy(struct bpf_iter_bits *it) __ksym __weak;
+
+int pid, err;
+
+SEC("iter.s/cgroup")
+int BPF_PROG(cpumask_iter, struct bpf_iter_meta *meta, struct cgroup *cgrp)
+{
+	struct task_struct *p;
+	u32 nr_running = 0;
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
+	bpf_for_each(bits, cpu, p->cpus_ptr, 8192) {
+		rq = (struct rq *)bpf_per_cpu_ptr(&runqueues, *cpu);
+		/* Each valid CPU must have a runqueue, even if it is offline. */
+		if (!rq)
+			break;
+
+		nr_running += rq->nr_running;
+	}
+	if (nr_running == 0)
+		err = 1;
+	bpf_task_release(p);
+	return 0;
+}
+
+SEC("iter.s/cgroup")
+int BPF_PROG(null_pointer, struct bpf_iter_meta *meta, struct cgroup *cgrp)
+{
+	int *cpu;
+
+	bpf_for_each(bits, cpu, NULL, 8192)
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


