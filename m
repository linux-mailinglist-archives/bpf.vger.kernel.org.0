Return-Path: <bpf+bounces-48061-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 186E7A03A01
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 09:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3077160374
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 08:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124AA1E3DFC;
	Tue,  7 Jan 2025 08:44:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533481E0E0A;
	Tue,  7 Jan 2025 08:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736239444; cv=none; b=JX039rhTsgfsFA+TX+DBQWowbtDnS43iHyLAxLihXHyiCfULizdt6lhGcZuxOH4RQ5pg/YAoJIbOc06Lr0ZdDb8R/xWGW+6aerh7sPlM2iTJOq51icQASoj8sUvcJZgck2/H066fJMSZ6WpSBkC6jN6KE+XRk5IQCNszLiLVbsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736239444; c=relaxed/simple;
	bh=FWV0BoBbS84j+XA3gTkPGwbiax5EzuoBU40jfx+C4dE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XJUoCrULvIunNhB2rvvZ1K+p4cJz6UA5ROXIO5G8BkXQNY6HMBPGtIZ2DbrdjOljQyM8v1A5hcR10tFaP4T8+XHCUtXdplt2kGz0IB9FSYdIoq8u6roOd8YSshpEgqX/43+DzBEbxNKIDywSTnsEPexUPcXbC4dY6fbuDug7xiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YS4MY35VXz4f3jHy;
	Tue,  7 Jan 2025 16:43:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8C0721A130E;
	Tue,  7 Jan 2025 16:43:57 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgC3Gl9E6XxnpFgeAQ--.43336S11;
	Tue, 07 Jan 2025 16:43:57 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	houtao1@huawei.com,
	xukuohai@huawei.com
Subject: [PATCH bpf-next 7/7] selftests/bpf: Add test case for the freeing of bpf_timer
Date: Tue,  7 Jan 2025 16:55:59 +0800
Message-Id: <20250107085559.3081563-8-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20250107085559.3081563-1-houtao@huaweicloud.com>
References: <20250107085559.3081563-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgC3Gl9E6XxnpFgeAQ--.43336S11
X-Coremail-Antispam: 1UD129KBjvJXoWxKr1kZF4xuF1ruF15XFW7CFg_yoWxuFW3pa
	yrK345Kr4rXw47Ww48tFn7GrWfKrs5XFyxGry0gw1UZr1Iqws5tF92gFy5tFW3CFWDWryS
	vF4FkFZ8GrZrJrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6r
	W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuY
	vjxUI-eODUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

The main purpose of the test is to demonstrate the lock problem for the
free of bpf_timer under PREEMPT_RT. When freeing a bpf_timer which is
running on other CPU in bpf_timer_cancel_and_free(), hrtimer_cancel()
will try to acquire a spin-lock (namely softirq_expiry_lock), however
the freeing procedure has already held a raw-spin-lock.

The test first creates two threads: one to start timers and the other to
free timers. The start-timers thread will start the timer and then wake
up the free-timers thread to free these timers when the starts complete.
After freeing, the free-timer thread will wake up the start-timer thread
to complete the current iteration. A loop of 10 iterations is used.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 .../selftests/bpf/prog_tests/free_timer.c     | 165 ++++++++++++++++++
 .../testing/selftests/bpf/progs/free_timer.c  |  71 ++++++++
 2 files changed, 236 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/free_timer.c
 create mode 100644 tools/testing/selftests/bpf/progs/free_timer.c

diff --git a/tools/testing/selftests/bpf/prog_tests/free_timer.c b/tools/testing/selftests/bpf/prog_tests/free_timer.c
new file mode 100644
index 000000000000..b7b77a6b2979
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/free_timer.c
@@ -0,0 +1,165 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2025. Huawei Technologies Co., Ltd */
+#define _GNU_SOURCE
+#include <unistd.h>
+#include <sys/syscall.h>
+#include <test_progs.h>
+
+#include "free_timer.skel.h"
+
+struct run_ctx {
+	struct bpf_program *start_prog;
+	struct bpf_program *overwrite_prog;
+	pthread_barrier_t notify;
+	int loop;
+	bool start;
+	bool stop;
+};
+
+static void start_threads(struct run_ctx *ctx)
+{
+	ctx->start = true;
+}
+
+static void stop_threads(struct run_ctx *ctx)
+{
+	ctx->stop = true;
+	/* Guarantee the order between ->stop and ->start */
+	__atomic_store_n(&ctx->start, true, __ATOMIC_RELEASE);
+}
+
+static int wait_for_start(struct run_ctx *ctx)
+{
+	while (!__atomic_load_n(&ctx->start, __ATOMIC_ACQUIRE))
+		usleep(10);
+
+	return ctx->stop;
+}
+
+static void *overwrite_timer_fn(void *arg)
+{
+	struct run_ctx *ctx = arg;
+	int loop, fd, err;
+	cpu_set_t cpuset;
+	long ret = 0;
+
+	/* Pin on CPU 0 */
+	CPU_ZERO(&cpuset);
+	CPU_SET(0, &cpuset);
+	pthread_setaffinity_np(pthread_self(), sizeof(cpuset), &cpuset);
+
+	/* Is the thread being stopped ? */
+	err = wait_for_start(ctx);
+	if (err)
+		return NULL;
+
+	fd = bpf_program__fd(ctx->overwrite_prog);
+	loop = ctx->loop;
+	while (loop-- > 0) {
+		LIBBPF_OPTS(bpf_test_run_opts, opts);
+
+		/* Wait for start thread to complete */
+		pthread_barrier_wait(&ctx->notify);
+
+		/* Overwrite timers */
+		err = bpf_prog_test_run_opts(fd, &opts);
+		if (err)
+			ret |= 1;
+		else if (opts.retval)
+			ret |= 2;
+
+		/* Notify start thread to start timers */
+		pthread_barrier_wait(&ctx->notify);
+	}
+
+	return (void *)ret;
+}
+
+static void *start_timer_fn(void *arg)
+{
+	struct run_ctx *ctx = arg;
+	int loop, fd, err;
+	cpu_set_t cpuset;
+	long ret = 0;
+
+	/* Pin on CPU 1 */
+	CPU_ZERO(&cpuset);
+	CPU_SET(1, &cpuset);
+	pthread_setaffinity_np(pthread_self(), sizeof(cpuset), &cpuset);
+
+	/* Is the thread being stopped ? */
+	err = wait_for_start(ctx);
+	if (err)
+		return NULL;
+
+	fd = bpf_program__fd(ctx->start_prog);
+	loop = ctx->loop;
+	while (loop-- > 0) {
+		LIBBPF_OPTS(bpf_test_run_opts, opts);
+
+		/* Run the prog to start timer */
+		err = bpf_prog_test_run_opts(fd, &opts);
+		if (err)
+			ret |= 4;
+		else if (opts.retval)
+			ret |= 8;
+
+		/* Notify overwrite thread to do overwrite */
+		pthread_barrier_wait(&ctx->notify);
+
+		/* Wait for overwrite thread to complete */
+		pthread_barrier_wait(&ctx->notify);
+	}
+
+	return (void *)ret;
+}
+
+void test_free_timer(void)
+{
+	struct free_timer *skel;
+	struct bpf_program *prog;
+	struct run_ctx ctx;
+	pthread_t tid[2];
+	void *ret;
+	int err;
+
+	skel = free_timer__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_load"))
+		return;
+
+	memset(&ctx, 0, sizeof(ctx));
+
+	prog = bpf_object__find_program_by_name(skel->obj, "start_timer");
+	if (!ASSERT_OK_PTR(prog, "find start prog"))
+		goto out;
+	ctx.start_prog = prog;
+
+	prog = bpf_object__find_program_by_name(skel->obj, "overwrite_timer");
+	if (!ASSERT_OK_PTR(prog, "find overwrite prog"))
+		goto out;
+	ctx.overwrite_prog = prog;
+
+	pthread_barrier_init(&ctx.notify, NULL, 2);
+	ctx.loop = 10;
+
+	err = pthread_create(&tid[0], NULL, start_timer_fn, &ctx);
+	if (!ASSERT_OK(err, "create start_timer"))
+		goto out;
+
+	err = pthread_create(&tid[1], NULL, overwrite_timer_fn, &ctx);
+	if (!ASSERT_OK(err, "create overwrite_timer")) {
+		stop_threads(&ctx);
+		goto out;
+	}
+
+	start_threads(&ctx);
+
+	ret = NULL;
+	err = pthread_join(tid[0], &ret);
+	ASSERT_EQ(err | (long)ret, 0, "start_timer");
+	ret = NULL;
+	err = pthread_join(tid[1], &ret);
+	ASSERT_EQ(err | (long)ret, 0, "overwrite_timer");
+out:
+	free_timer__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/free_timer.c b/tools/testing/selftests/bpf/progs/free_timer.c
new file mode 100644
index 000000000000..4501ae8fc414
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/free_timer.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2025. Huawei Technologies Co., Ltd */
+#include <linux/bpf.h>
+#include <time.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+
+#define MAX_ENTRIES 8
+
+struct map_value {
+	struct bpf_timer timer;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, int);
+	__type(value, struct map_value);
+	__uint(max_entries, MAX_ENTRIES);
+} map SEC(".maps");
+
+static int timer_cb(void *map, void *key, struct map_value *value)
+{
+	volatile int sum = 0;
+	int i;
+
+	bpf_for(i, 0, 1024 * 1024) sum += i;
+
+	return 0;
+}
+
+static int start_cb(int key)
+{
+	struct map_value *value;
+
+	value = bpf_map_lookup_elem(&map, (void *)&key);
+	if (!value)
+		return 0;
+
+	bpf_timer_init(&value->timer, &map, CLOCK_MONOTONIC);
+	bpf_timer_set_callback(&value->timer, timer_cb);
+	/* Hope 100us will be enough to wake-up and run the overwrite thread */
+	bpf_timer_start(&value->timer, 100000, BPF_F_TIMER_CPU_PIN);
+
+	return 0;
+}
+
+static int overwrite_cb(int key)
+{
+	struct map_value zero = {};
+
+	/* Free the timer which may run on other CPU */
+	bpf_map_update_elem(&map, (void *)&key, &zero, BPF_ANY);
+
+	return 0;
+}
+
+SEC("syscall")
+int BPF_PROG(start_timer)
+{
+	bpf_loop(MAX_ENTRIES, start_cb, NULL, 0);
+	return 0;
+}
+
+SEC("syscall")
+int BPF_PROG(overwrite_timer)
+{
+	bpf_loop(MAX_ENTRIES, overwrite_cb, NULL, 0);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.29.2


