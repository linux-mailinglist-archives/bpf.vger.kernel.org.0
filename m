Return-Path: <bpf+bounces-69874-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41155BA567B
	for <lists+bpf@lfdr.de>; Sat, 27 Sep 2025 01:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E64733860C3
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 23:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81DB2BE043;
	Fri, 26 Sep 2025 23:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLNya9We"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA5F14B953
	for <bpf@vger.kernel.org>; Fri, 26 Sep 2025 23:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758931153; cv=none; b=UEf237zx4fs+jY3MAPu3SThNinmVYkbqTQqndUYuX3h7noYI/vwydxStGj3CkT+iJMviIHHWCn75d0Ft7xl16fEMXlW2y9l7mSaiQ/IwxXviQxKOk55sPcm4c8OGOIJou+BZGtBikPlKLx0HFvTlDEjLjrET0MAcEpxO1ykeO24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758931153; c=relaxed/simple;
	bh=cH5x/eXwBhCc1hYrpx4CUOH0oqZ677CtViveaQeXxEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YmPrIgrc6Jl6baLbsWdyc/akTjAfWmYPz2a4mRAvs2X+ktausvQdBPtTFZQANp1kUTp5lIMWlhAglXh9ZWgGK49PnqcrXM/xehBp0P7ep2mx/dNV+lnxpJ7GXKSYPPz3pKCGtI3zWSK8N44+Bpx7SRVMzRNV5nKPmC7hTaA920k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VLNya9We; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-b28e1b87c31so395698766b.0
        for <bpf@vger.kernel.org>; Fri, 26 Sep 2025 16:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758931149; x=1759535949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VcgIoDPWAlbKOonsrKCVX1IEB/zcGaPz3CaOTZr6HZU=;
        b=VLNya9WeURzEN3khUK0sT2R0R8G6GXrorWC7eeAjvJRhD1b1Jr28zK3hhH+pcgHjl+
         pqfHDXkTbpuByYcD1cY46G0ycmyRlYyfBTS8u+6Ky6CDjiAuMjdFT3hHndqxI1HMxy5k
         HtzxMPBdi+f8MSx0F+4wSgVQIIXGCNgxhTcYjNCgRj2THs+gUmIJ4EFoDEjYQj+AkIFa
         WXNU92gYNpQfz3NC9Xv4HrGQ1SWkG0FADeitavRxIxhERFgPikCHJ/+I+g7FHmjUou74
         c3EvIjeNdRpL6Q9FMXzTLsJSfZ6Knxc2BV4X5PyZIaYmDgRXuyo+bIe6Ota7H2p+vKns
         q1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758931149; x=1759535949;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VcgIoDPWAlbKOonsrKCVX1IEB/zcGaPz3CaOTZr6HZU=;
        b=XK2Wj1a6Kgb2bzYOsxo5JbGcsrkA1k4QXu1BTxWF8EDsdUBDCuIx0r766rWmgjoRHr
         gxyfc6s+TzSVnTPG6K6EQ4i4ZU4WerlEb61x+Z7F/ggiNNEiR3LJlmYvRvPU+yhvRszi
         GvURqov/tDwTI87MbQ1fWCT8oOUG6SEpADAI6rlOxfsmSfx+IL6G/WKwHx4nLIxhZ3z5
         UnARusKMT7ke5ZptRqcZVWU8iOhFsOYHwtP/qLoTc312R8ToovuissQHDdPLqJ5g58wi
         bAa33xI4sOl634tk6OJLk860QqgXfuGLu5dW1akCpaJ+kBn9k5tyJBbtNolRHEpWERpt
         mEXw==
X-Gm-Message-State: AOJu0YzKW6w6KVVd7IvOTgOcpVQdrGGONMEKFxzMHgwZAAMTpZmaN90K
	FnYqJHf3WjWHC1yY9T61w2+XhAubZrRtX4n85+jGdBroJQS12Sp0IlaBjZghMUFF
X-Gm-Gg: ASbGncscI4UmxuMzcWq7g9c+eu7TsI2kbebg/CMVJdXrjNdD6B0W67k3HMd0xRGH9oH
	jF7uhKMbZU3XSWh2xplMGUGZjk4x5d+01mcyBczbQnFYn5tuneMCdfybLdpDRz+CLO4ddXXkkJG
	n00/f7k7DnoEqo47hJNxq+5xGj2ajx9e8gwDPto11mPq3vBsFfW56RUfm9Hgz35TlXwe5SrFX6W
	d8vPvASyhhSEdAj5543doKY8rhA3OX1BeUp6sIeBjy5XDL6WXAnsmWxZ87SogGwxRQrFgzKa+Bi
	ArTC2PWnwV2mcS+qw9+ylfqjMvQUwgE8yHIscqWgJl6PpU33GSfYQW709BRZbUm4jbiire6DrTQ
	qIx5xOp/oHo1NATrME6lloJdflaq0g6Wd8KKJ80tNjtbT
X-Google-Smtp-Source: AGHT+IHN+awAk21Dkq9CFQdoFyOc9DahkzBRDXQEODKUTEucyP+QkSPiAeIaiVI/91eG0uMUAE+iyQ==
X-Received: by 2002:a17:907:3f1e:b0:b11:c9df:7a73 with SMTP id a640c23a62f3a-b34bd34a2b0mr1154000966b.57.1758931149058;
        Fri, 26 Sep 2025 16:59:09 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b3544fcddacsm465074466b.72.2025.09.26.16.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 16:59:08 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1] selftests/bpf: Add stress test for rqspinlock in NMI
Date: Fri, 26 Sep 2025 23:59:07 +0000
Message-ID: <20250926235907.3357831-1-memxor@gmail.com>
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
 tools/testing/selftests/bpf/Makefile          |   2 +-
 .../selftests/bpf/prog_tests/res_spin_lock.c  |  16 ++
 .../testing/selftests/bpf/test_kmods/Makefile |   2 +-
 .../bpf/test_kmods/bpf_test_rqspinlock.c      | 208 ++++++++++++++++++
 tools/testing/selftests/bpf/testing_helpers.c |  14 +-
 tools/testing/selftests/bpf/testing_helpers.h |   1 +
 6 files changed, 239 insertions(+), 4 deletions(-)
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
index 000000000000..dc8620715ac1
--- /dev/null
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_test_rqspinlock.c
@@ -0,0 +1,208 @@
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
+static void free_rqsl_threads(void) {
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
+		goto err_perf_alloc;
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
+err_perf_alloc:
+	free_rqsl_evts();
+err_perf_events:
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


