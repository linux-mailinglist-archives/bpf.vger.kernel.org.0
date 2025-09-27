Return-Path: <bpf+bounces-69907-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B96BA6372
	for <lists+bpf@lfdr.de>; Sat, 27 Sep 2025 22:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 361AD17E4F8
	for <lists+bpf@lfdr.de>; Sat, 27 Sep 2025 20:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14ECC23643E;
	Sat, 27 Sep 2025 20:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFp0dnv9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841F535950
	for <bpf@vger.kernel.org>; Sat, 27 Sep 2025 20:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759006397; cv=none; b=GOpWiZKIX97gZZ5gaIMiL4k1CzVNxjah81W0wlMN2T7YIPDdFW1Itz9MD6Q7ARn0RXE2rhloxCrxzlA7wCfMjZ9kGyiAUmVh5GyPwZxMj8iYfM1nI3BT0RDGG56UOocCshbt/d9tMAuvGO6lgnVVZx9WwABWImEUI/niSksX1+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759006397; c=relaxed/simple;
	bh=n9MCJPqrGmnHEhKm8gxiFYU3GquoxkfRzbgOJzsVatk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jNBrOjLpl32q/MgpcE6hZhnm7zjSuSh+ehM8UmSTc92wADfMmTsSmr/bKr3Ba5RkTUHUCGqMtXVj2C0AUn8d+Qch45adjMNymMFJIsVYlAWbykV3iDcmX87inCQjAi3nIiCDBA91EKGEr8LLv0uURjoBRKn/TXQcHt6Je8hRd+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WFp0dnv9; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-b3d196b7eeeso2580766b.0
        for <bpf@vger.kernel.org>; Sat, 27 Sep 2025 13:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759006393; x=1759611193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XpVnLdX/Ll7IyWPIkBY0cLOvO07tEsNmYpQVo3D62fk=;
        b=WFp0dnv9W2rkK49+F11ZRp+RvC8eH0hpzwfR6AX04fmt/Zn+7RahCfldlB2ze5VEpw
         aLZlMk2VoH3V3Y1Qs74iyEnN0+HT+VpGgi3zaanu0kKMYQi7TKWlGS0dymo8KU1jJO57
         Ren1RrPqOYJOheL9gARITDqBaBud3QpqvdjRToJwmSt8AE3F8vzmaVbyVruaf1Q4JOVv
         1NYl14Hz7bb8o8X77jOqPLW3ESHhPmSfoW5sZZJzuN3+BZX5qUDdMcTPWhFdy/ISYSo8
         qdnLbCrGQB2xwqKuk2AO8cBgoPs2fFlj+6+RzVPo4utzC1r4i7tHLPHXBCrlajGXiHg3
         5f5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759006393; x=1759611193;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XpVnLdX/Ll7IyWPIkBY0cLOvO07tEsNmYpQVo3D62fk=;
        b=Kmj2Et0P+KHK1p3SxpZuTuE7AUpTf6jgZfIxB4DGQjAlrWbhhYrEEaMtnNE2YeFcKH
         cZRfW/X0b3LppY7bsUNUm3OgdGGKjiTWoZvy9V2mzanh7F438qU6yLZYnZlQNkYcjlxp
         awuVxx3zZyPWH9Ga+DEsW4MKLPlhRD8B4CM1HTvUi+pomZ0ngvi8cKuguITE6joGxe9v
         Fl7UGRQbJjN9WjIHhQZJ8j/nYvH/5lOReIfgALLT/zFLWBmY9Szhcymn2z3XAMXWmp8z
         BwH249O+Mc1AkvQOl3ECMwHXUqKZhMlxbdoSDAfnquBMmiLVOUI+hpQs/6Yh4SFGHCBE
         dVGg==
X-Gm-Message-State: AOJu0YxLI/ugc2//Mb6xpijjxEgW1qtXOJK5jUUy4lJrzwT1aIadza1z
	KX2CPAGnGa9dDU6cPKIPkJE4O8O++l+05MIZU86ECpeysw3EY68gd1EBlXGv6FWR
X-Gm-Gg: ASbGncsEHekO2IGuGHIPm8UlV1jcPCaFeRxgr31gvkpQeu3TO5smvH+ueQ5BvFFXsxA
	ajXHIU1nNa00bXWdP0CS866ZdzpOJ5JLaekGn4S43mpApDqmNOZ9VVyCe760hcceS9YqnLy4A+x
	rh8woYnAe5lOnAWZAx7fwnzFiccQNjPU4Z5jtW5YVNwbF6gZazMKWz5W9fOU+DuWEOQ+EX15xlc
	DjYpCrSTeplG4LJhX9EMdiOnL+GZts4q17YCMkNsdsuj9jcxKPRk94h/N7CKVA6PTFfx6/qkhiJ
	lpsLvucO1vx/LXObeJFLYcaxGIqu4TJkHeSfFjDXTSxz9ynYAdIJsCvSbtvuOOk+i3FbuOq2akM
	ohVHtZXvzGiBt8XZ3aZuunZ1k1UsSh7OcJq+mc50SoVI4lMPynb44A64=
X-Google-Smtp-Source: AGHT+IE9YOYwE1qVtJndYC4bj5drBYXwHXcDhJSsBeL9YO6gTUZNCP0hiugplJen7k1FZ5GGGWazRQ==
X-Received: by 2002:a17:907:2da7:b0:b33:d10a:535c with SMTP id a640c23a62f3a-b34bd932331mr1261697966b.64.1759006393195;
        Sat, 27 Sep 2025 13:53:13 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b353e5cf32asm634860166b.1.2025.09.27.13.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 13:53:12 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2] selftests/bpf: Add stress test for rqspinlock in NMI
Date: Sat, 27 Sep 2025 20:53:04 +0000
Message-ID: <20250927205304.199760-1-memxor@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a kernel module that will exercise lock acquisition in the NMI
path, and bias toward creating contention such that NMI waiters end up
being non-head waiters. Prior to the rqspinlock fix made in the commit
0d80e7f951be ("rqspinlock: Choose trylock fallback for NMI waiters"), it
was possible for the queueing path of non-head waiters to get stuck in
NMI, which this stress test reproduces fairly easily with just 3 CPUs.

Both AA and ABBA flavors are supported, and it will serve as a test case
for future fixes that address this corner case. More information about
the problem in question is available in the commit cited above. When the
fix is reverted, this stress test will lock up the system.

To enable this test automatically through the test_progs infrastructure,
add a load_module_params API to exercise both AA and ABBA cases when
running the test.

Note that the test runs for at most 5 seconds, and becomes a noop after
that, in order to allow the system to make forward progress. In
addition, CPU 0 is always kept untouched by the created threads and
NMIs. The test will automatically scale to the number of available
online CPUs.

Note that at least 3 CPUs are necessary to run this test, hence skip the
selftest in case the environment has less than 3 CPUs available.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
Changelog:
v1 -> v2
v1: https://lore.kernel.org/bpf/20250926235907.3357831-1-memxor@gmail.com

 * Fix unfreed perf events in case of error. (BPF CI AI bot)
---
 tools/testing/selftests/bpf/Makefile          |   2 +-
 .../selftests/bpf/prog_tests/res_spin_lock.c  |  16 ++
 .../testing/selftests/bpf/test_kmods/Makefile |   2 +-
 .../bpf/test_kmods/bpf_test_rqspinlock.c      | 209 ++++++++++++++++++
 tools/testing/selftests/bpf/testing_helpers.c |  14 +-
 tools/testing/selftests/bpf/testing_helpers.h |   1 +
 6 files changed, 240 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/test_kmods/bpf_test_rqspinlock.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 0b6ee902bce5..f00587d4ede6 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -120,7 +120,7 @@ TEST_PROGS_EXTENDED := \
 	test_bpftool.py

 TEST_KMODS := bpf_testmod.ko bpf_test_no_cfi.ko bpf_test_modorder_x.ko \
-	bpf_test_modorder_y.ko
+	bpf_test_modorder_y.ko bpf_test_rqspinlock.ko
 TEST_KMOD_TARGETS = $(addprefix $(OUTPUT)/,$(TEST_KMODS))

 # Compile but not part of 'make run_tests'
diff --git a/tools/testing/selftests/bpf/prog_tests/res_spin_lock.c b/tools/testing/selftests/bpf/prog_tests/res_spin_lock.c
index 0703e987df89..8c6c2043a432 100644
--- a/tools/testing/selftests/bpf/prog_tests/res_spin_lock.c
+++ b/tools/testing/selftests/bpf/prog_tests/res_spin_lock.c
@@ -99,3 +99,19 @@ void test_res_spin_lock_success(void)
 	res_spin_lock__destroy(skel);
 	return;
 }
+
+void serial_test_res_spin_lock_stress(void)
+{
+	if (libbpf_num_possible_cpus() < 3) {
+		test__skip();
+		return;
+	}
+
+	ASSERT_OK(load_module("bpf_test_rqspinlock.ko", false), "load module AA");
+	sleep(5);
+	unload_module("bpf_test_rqspinlock", false);
+
+	ASSERT_OK(load_module_params("bpf_test_rqspinlock.ko", "test_ab=1", false), "load module ABBA");
+	sleep(5);
+	unload_module("bpf_test_rqspinlock", false);
+}
diff --git a/tools/testing/selftests/bpf/test_kmods/Makefile b/tools/testing/selftests/bpf/test_kmods/Makefile
index d4e50c4509c9..63c4d3f6a12f 100644
--- a/tools/testing/selftests/bpf/test_kmods/Makefile
+++ b/tools/testing/selftests/bpf/test_kmods/Makefile
@@ -8,7 +8,7 @@ Q = @
 endif

 MODULES = bpf_testmod.ko bpf_test_no_cfi.ko bpf_test_modorder_x.ko \
-	bpf_test_modorder_y.ko
+	bpf_test_modorder_y.ko bpf_test_rqspinlock.ko

 $(foreach m,$(MODULES),$(eval obj-m += $(m:.ko=.o)))

diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_test_rqspinlock.c b/tools/testing/selftests/bpf/test_kmods/bpf_test_rqspinlock.c
new file mode 100644
index 000000000000..769206fc70e4
--- /dev/null
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_test_rqspinlock.c
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+#include <linux/sched.h>
+#include <linux/smp.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/prandom.h>
+#include <asm/rqspinlock.h>
+#include <linux/perf_event.h>
+#include <linux/kthread.h>
+#include <linux/atomic.h>
+#include <linux/slab.h>
+
+static struct perf_event_attr hw_attr = {
+	.type		= PERF_TYPE_HARDWARE,
+	.config		= PERF_COUNT_HW_CPU_CYCLES,
+	.size		= sizeof(struct perf_event_attr),
+	.pinned		= 1,
+	.disabled	= 1,
+	.sample_period	= 100000,
+};
+
+static rqspinlock_t lock_a;
+static rqspinlock_t lock_b;
+
+static struct perf_event **rqsl_evts;
+static int rqsl_nevts;
+
+static bool test_ab = false;
+module_param(test_ab, bool, 0644);
+MODULE_PARM_DESC(test_ab, "Test ABBA situations instead of AA situations");
+
+static struct task_struct **rqsl_threads;
+static int rqsl_nthreads;
+static atomic_t rqsl_ready_cpus = ATOMIC_INIT(0);
+
+static int pause = 0;
+
+static bool nmi_locks_a(int cpu)
+{
+	return (cpu & 1) && test_ab;
+}
+
+static int rqspinlock_worker_fn(void *arg)
+{
+	int cpu = smp_processor_id();
+	unsigned long flags;
+	int ret;
+
+	if (cpu) {
+		atomic_inc(&rqsl_ready_cpus);
+
+		while (!kthread_should_stop()) {
+			if (READ_ONCE(pause)) {
+				msleep(1000);
+				continue;
+			}
+			if (nmi_locks_a(cpu))
+				ret = raw_res_spin_lock_irqsave(&lock_b, flags);
+			else
+				ret = raw_res_spin_lock_irqsave(&lock_a, flags);
+			mdelay(20);
+			if (nmi_locks_a(cpu) && !ret)
+				raw_res_spin_unlock_irqrestore(&lock_b, flags);
+			else if (!ret)
+				raw_res_spin_unlock_irqrestore(&lock_a, flags);
+			cpu_relax();
+		}
+		return 0;
+	}
+
+	while (!kthread_should_stop()) {
+		int expected = rqsl_nthreads > 0 ? rqsl_nthreads - 1 : 0;
+		int ready = atomic_read(&rqsl_ready_cpus);
+
+		if (ready == expected && !READ_ONCE(pause)) {
+			for (int i = 0; i < rqsl_nevts; i++)
+				perf_event_enable(rqsl_evts[i]);
+			pr_err("Waiting 5 secs to pause the test\n");
+			msleep(1000 * 5);
+			WRITE_ONCE(pause, 1);
+			pr_err("Paused the test\n");
+		} else {
+			msleep(1000);
+			cpu_relax();
+		}
+	}
+	return 0;
+}
+
+static void nmi_cb(struct perf_event *event, struct perf_sample_data *data,
+		   struct pt_regs *regs)
+{
+	int cpu = smp_processor_id();
+	unsigned long flags;
+	int ret;
+
+	if (!cpu || READ_ONCE(pause))
+		return;
+
+	if (nmi_locks_a(cpu))
+		ret = raw_res_spin_lock_irqsave(&lock_a, flags);
+	else
+		ret = raw_res_spin_lock_irqsave(test_ab ? &lock_b : &lock_a, flags);
+
+	mdelay(10);
+
+	if (nmi_locks_a(cpu) && !ret)
+		raw_res_spin_unlock_irqrestore(&lock_a, flags);
+	else if (!ret)
+		raw_res_spin_unlock_irqrestore(test_ab ? &lock_b : &lock_a, flags);
+}
+
+static void free_rqsl_threads(void)
+{
+	int i;
+
+	if (rqsl_threads) {
+		for_each_online_cpu(i) {
+			if (rqsl_threads[i])
+				kthread_stop(rqsl_threads[i]);
+		}
+		kfree(rqsl_threads);
+	}
+}
+
+static void free_rqsl_evts(void)
+{
+	int i;
+
+	if (rqsl_evts) {
+		for (i = 0; i < rqsl_nevts; i++) {
+			if (rqsl_evts[i])
+				perf_event_release_kernel(rqsl_evts[i]);
+		}
+		kfree(rqsl_evts);
+	}
+}
+
+static int bpf_test_rqspinlock_init(void)
+{
+	int i, ret;
+	int ncpus = num_online_cpus();
+
+	pr_err("Mode = %s\n", test_ab ? "ABBA" : "AA");
+
+	if (ncpus < 3)
+		return -ENOTSUPP;
+
+	raw_res_spin_lock_init(&lock_a);
+	raw_res_spin_lock_init(&lock_b);
+
+	rqsl_evts = kcalloc(ncpus - 1, sizeof(*rqsl_evts), GFP_KERNEL);
+	if (!rqsl_evts)
+		return -ENOMEM;
+	rqsl_nevts = ncpus - 1;
+
+	for (i = 1; i < ncpus; i++) {
+		struct perf_event *e;
+
+		e = perf_event_create_kernel_counter(&hw_attr, i, NULL, nmi_cb, NULL);
+		if (IS_ERR(e)) {
+			ret = PTR_ERR(e);
+			goto err_perf_events;
+		}
+		rqsl_evts[i - 1] = e;
+	}
+
+	rqsl_threads = kcalloc(ncpus, sizeof(*rqsl_threads), GFP_KERNEL);
+	if (!rqsl_threads) {
+		ret = -ENOMEM;
+		goto err_perf_events;
+	}
+	rqsl_nthreads = ncpus;
+
+	for_each_online_cpu(i) {
+		struct task_struct *t;
+
+		t = kthread_create(rqspinlock_worker_fn, NULL, "rqsl_w/%d", i);
+		if (IS_ERR(t)) {
+			ret = PTR_ERR(t);
+			goto err_threads_create;
+		}
+		kthread_bind(t, i);
+		rqsl_threads[i] = t;
+		wake_up_process(t);
+	}
+	return 0;
+
+err_threads_create:
+	free_rqsl_threads();
+err_perf_events:
+	free_rqsl_evts();
+	return ret;
+}
+
+module_init(bpf_test_rqspinlock_init);
+
+static void bpf_test_rqspinlock_exit(void)
+{
+	free_rqsl_threads();
+	free_rqsl_evts();
+}
+
+module_exit(bpf_test_rqspinlock_exit);
+
+MODULE_AUTHOR("Kumar Kartikeya Dwivedi");
+MODULE_DESCRIPTION("BPF rqspinlock stress test module");
+MODULE_LICENSE("GPL");
diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testing/selftests/bpf/testing_helpers.c
index 5e9f16683be5..16eb37e5bad6 100644
--- a/tools/testing/selftests/bpf/testing_helpers.c
+++ b/tools/testing/selftests/bpf/testing_helpers.c
@@ -399,7 +399,7 @@ int unload_module(const char *name, bool verbose)
 	return 0;
 }

-int load_module(const char *path, bool verbose)
+static int __load_module(const char *path, const char *param_values, bool verbose)
 {
 	int fd;

@@ -411,7 +411,7 @@ int load_module(const char *path, bool verbose)
 		fprintf(stdout, "Can't find %s kernel module: %d\n", path, -errno);
 		return -ENOENT;
 	}
-	if (finit_module(fd, "", 0)) {
+	if (finit_module(fd, param_values, 0)) {
 		fprintf(stdout, "Failed to load %s into the kernel: %d\n", path, -errno);
 		close(fd);
 		return -EINVAL;
@@ -423,6 +423,16 @@ int load_module(const char *path, bool verbose)
 	return 0;
 }

+int load_module_params(const char *path, const char *param_values, bool verbose)
+{
+	return __load_module(path, param_values, verbose);
+}
+
+int load_module(const char *path, bool verbose)
+{
+	return __load_module(path, "", verbose);
+}
+
 int unload_bpf_testmod(bool verbose)
 {
 	return unload_module("bpf_testmod", verbose);
diff --git a/tools/testing/selftests/bpf/testing_helpers.h b/tools/testing/selftests/bpf/testing_helpers.h
index 46d7f7089f63..eb20d3772218 100644
--- a/tools/testing/selftests/bpf/testing_helpers.h
+++ b/tools/testing/selftests/bpf/testing_helpers.h
@@ -39,6 +39,7 @@ int kern_sync_rcu(void);
 int finit_module(int fd, const char *param_values, int flags);
 int delete_module(const char *name, int flags);
 int load_module(const char *path, bool verbose);
+int load_module_params(const char *path, const char *param_values, bool verbose);
 int unload_module(const char *name, bool verbose);

 static inline __u64 get_time_ns(void)
--
2.51.0


