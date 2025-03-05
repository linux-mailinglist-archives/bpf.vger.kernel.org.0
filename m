Return-Path: <bpf+bounces-53291-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0ACAA4F633
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 05:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC0F2188DBC5
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 04:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3F71C8603;
	Wed,  5 Mar 2025 04:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4CyONj3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62F7193062
	for <bpf@vger.kernel.org>; Wed,  5 Mar 2025 04:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741150311; cv=none; b=FsUr5mF2VKj7QsCXN+xu5an+NptINQPrBsY5PPFOhtBG3XwjId/6uhzFVYcaQNT3EG1VsqppCTv8nl8zFxyHDDAAf7HBmIzypa8V/6R1Wskk/zeW2+1EytMoWc2nFtAKxMv9A9Xu6vB0ntNdwR0LUkffAUqDyAs9rw9SHbJfxm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741150311; c=relaxed/simple;
	bh=HJmKZV8zGRUwN23jrLHkvuqLQxCPJiV5ZXmo5npqSWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YwMwBU64XzDqXcYp5T8AM28s+RBM8hDoqsu+M4LMtWg3OazgcUHiYQ2yyzZ7fkuHfmnfN2Sb14bKEscHLdYmQTWf45Q0uFILfz6o0H+vx6Q2plyv4V+JiJReKEDXJvIti7Ex6CRmNuRLbc55Cs1BMzploy9IIx/LrMSf2X8dO9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i4CyONj3; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-43bc48ff815so2511335e9.0
        for <bpf@vger.kernel.org>; Tue, 04 Mar 2025 20:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741150307; x=1741755107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/bhJi7i/6nAlW3dg19vvwFG0ecbTxspZbx4UiFgT7dE=;
        b=i4CyONj3bWzO8TQ+3HOkMFtHDG2lbZcmBpELeE2b61N3cB4ysz2vZCJWrq97Uf17JI
         PD0W2neAplxrwNAB6f6HW8C6HZWBqCcUW2ENr+EsjdJr5LJ7F3F6uQ5Ip2geFNa0lUO6
         BUlaEvYCrn0m2avM5JiMoyM03jPVb7gFkZGuRRexS1Z3sLfHCeC27KCEKXHk4wxrBdKr
         f7VXCTrJC8wXFWWnSn8f4PHLiCECOPK1Qbp8ZqPTR42CGp6DwADmUzfSbQTqq947eVQt
         bc37ktY+Fcy2qC7KD4AjLl2PLrD6sZSxLH5TTkjGTMR2Ae5VHPvStv7Gb3WhvG9Amyd4
         8CCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741150307; x=1741755107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/bhJi7i/6nAlW3dg19vvwFG0ecbTxspZbx4UiFgT7dE=;
        b=FGdTsXjLo5pcfXwgQHc9iU9k7962r5MCND+jJ3/SdOK9H/dT5Y6vOg08pzq8juB+PD
         u5R6QMsDGKeZFuM9ruii5Ir3nVIg+3Xw+7/vFhObAcO2yoQCAynro6rTLp+bXX01T9ro
         oOhw7AjYqZkJYtVVSXcjXfK45pgc8XS+DkiVkNoH1h4uPOlgwP2hT+AqNVMDgCNoXB+5
         TXqBCWmGJlAXetVVG+oK9Mup/WUkhCzWYi9QBN01LnxS4g3SUSW8Jb8fj39Zhd9Zc3ty
         PpqqyEIQ+Iv+0PM/fCGQMzphMArf91T2PejSFHwFyLWNHii9S1Rg8lkNAU7kF3oJGaTR
         nh8Q==
X-Gm-Message-State: AOJu0YwhJ6YHa7xzL35CQ6rjh9WLU1WpuNUSZymufUDmB4fJkFAVVITA
	OXb1D3D4E1J6SheokQY7yEeqWyFme3x6k2ws3aDLW6l+HEw+ejQtS0Jy9CYCB60=
X-Gm-Gg: ASbGncsanYvfujrlX60LjB2GsLC0Ldh8QrMcsjw86PHv8NWDbcxAhry31t6ikU8Agbm
	3sq1mj6ZmrNNE7H58NHYFfugMS9a08iO1GI+FFudrwMBDMiWQ3Kiwgd+rE/pRERKsV0rX+ylniT
	REWkeJBYkJ5BgO1M7svsxYl2CGr1fP1SRqMRDF2awhNsje7/gtnxYIeZR5dx35VYWEdfp/FMLAw
	kKlfWpXeCt6UMt754P/wwVz1oO/TaLq0J5c4ZOSvWPP22f0L1716ld9hzImMfX4xlY2PHqZfdZd
	plfCvHMk1/LU22xgg7BX0zGiOuFZEjBvW04=
X-Google-Smtp-Source: AGHT+IGZC5Zl0yUhAXrWV2f0wApeSZjUt6F5g+ZWBNZ0HaXfHzKm/MgWus9JKRWCZOG3UVoXr74HPg==
X-Received: by 2002:a05:600c:319a:b0:435:edb0:5d27 with SMTP id 5b1f17b1804b1-43bcae29d8dmr51138905e9.9.1741150307196;
        Tue, 04 Mar 2025 20:51:47 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:44::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd42c5dd1sm5602645e9.18.2025.03.04.20.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 20:51:46 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Barret Rhoden <brho@google.com>,
	Josh Don <joshdon@google.com>,
	Dohyun Kim <dohyunkim@google.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 3/3] selftests/bpf: Add tests for arena spin lock
Date: Tue,  4 Mar 2025 20:51:36 -0800
Message-ID: <20250305045136.2614132-4-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305045136.2614132-1-memxor@gmail.com>
References: <20250305045136.2614132-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5025; h=from:subject; bh=HJmKZV8zGRUwN23jrLHkvuqLQxCPJiV5ZXmo5npqSWM=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnx9WghZ3ltzcF/DfIDTNt4IyXCDOHabYNVpowvp2k ws60OySJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ8fVoAAKCRBM4MiGSL8RytjWD/ 4z7gmPgoa222R/YHSBML67cEtuHPHrYY7XRduv5iJURS4A4BRuygn7Ie5QhuLhPVMA6JWnTl1GCn6L PMg802RZDZsHyNATSO7gFxRAqa6n9xkQT1t3pF4ZU73b03W37hCC9tKI5sZOmFefgGunBW99bd340/ QYgwxzCeUPgGShx+zLxX2uBKRx7gtG5rsrTEdJerDhVS/1ZM+3wYfGIc6RMYA7q8BVdvtakrOVN352 fp9eDvX4foeGWK3Vm8gCjQkjq8U4EaFW9hDOKB8atFIUXxZplRsZ4Q7U2vyz/uq9FloBljeQ75X0+G t5RIdXuoXg2nBC1i7CAYaywGcth0myUvxcxCnTS8jLH5gZLS93wkZrnpXVUwmRclnXtaiB6tXahdpB Df0F/lAJ2RxlgExwRfbBEhoez+Kv0Ov25fPb/r89YlMS3rdx3hvyqg0e3WXDIhSkKUixMnNH8ynwu0 YO3ro1HqzUtsISq6SX1u0A76+LAkbA2ETZAbHPnIokhRBRQoQxKdmxXJFPK8Qk4pQQmxXdlNk/HhmR MqvgJGOTGKU9lNEvyVUi5E1zaG+IhdvhYoB/SKORSh/RqLvK4goOemqhbWKpcTsQfLq2fVV+nIAd9P Kh7H8QE6Xq0dscHsdi+JOoB6bnL0Pk/jPDSYFZmlAf3GYnCeiThS6hIHBOxw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Add some basic selftests for qspinlock built over BPF arena using
cond_break_label macro.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../bpf/prog_tests/arena_spin_lock.c          | 106 ++++++++++++++++++
 .../selftests/bpf/progs/arena_spin_lock.c     |  49 ++++++++
 2 files changed, 155 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_spin_lock.c

diff --git a/tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c b/tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c
new file mode 100644
index 000000000000..bfa644bd7ff8
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+#include <network_helpers.h>
+#include <sys/sysinfo.h>
+
+struct qspinlock { int val; };
+typedef struct qspinlock arena_spinlock_t;
+
+struct arena_qnode {
+	unsigned long next;
+	int count;
+	int locked;
+};
+
+#include "arena_spin_lock.skel.h"
+
+static long cpu;
+int *counter;
+
+pthread_barrier_t barrier;
+
+static void *spin_lock_thread(void *arg)
+{
+	int err, prog_fd = *(u32 *)arg;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in = &pkt_v4,
+		.data_size_in = sizeof(pkt_v4),
+		.repeat = 100,
+	);
+	cpu_set_t cpuset;
+
+	CPU_ZERO(&cpuset);
+	CPU_SET(__sync_fetch_and_add(&cpu, 1), &cpuset);
+	ASSERT_OK(pthread_setaffinity_np(pthread_self(), sizeof(cpuset), &cpuset), "cpu affinity");
+
+	err = pthread_barrier_wait(&barrier);
+	if (err != PTHREAD_BARRIER_SERIAL_THREAD && err != 0)
+		ASSERT_FALSE(true, "pthread_barrier");
+
+	while (*READ_ONCE(counter) <= 1000) {
+		err = bpf_prog_test_run_opts(prog_fd, &topts);
+		if (!ASSERT_OK(err, "test_run err"))
+			break;
+		if (!ASSERT_EQ((int)topts.retval, 0, "test_run retval"))
+			break;
+	}
+	pthread_exit(arg);
+}
+
+static void test_arena_spin_lock_size(int size)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	struct arena_spin_lock *skel;
+	pthread_t thread_id[16];
+	int prog_fd, i, err;
+	void *ret;
+
+	if (get_nprocs() < 2) {
+		test__skip();
+		return;
+	}
+
+	skel = arena_spin_lock__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "arena_spin_lock__open_and_load"))
+		return;
+	if (skel->data->test_skip == 2) {
+		test__skip();
+		goto end;
+	}
+	counter = &skel->bss->counter;
+	skel->bss->cs_count = size;
+
+	ASSERT_OK(pthread_barrier_init(&barrier, NULL, 16), "barrier init");
+
+	prog_fd = bpf_program__fd(skel->progs.prog);
+	for (i = 0; i < 16; i++) {
+		err = pthread_create(&thread_id[i], NULL, &spin_lock_thread, &prog_fd);
+		if (!ASSERT_OK(err, "pthread_create"))
+			goto end_barrier;
+	}
+
+	for (i = 0; i < 16; i++) {
+		if (!ASSERT_OK(pthread_join(thread_id[i], &ret), "pthread_join"))
+			goto end_barrier;
+		if (!ASSERT_EQ(ret, &prog_fd, "ret == prog_fd"))
+			goto end_barrier;
+	}
+end_barrier:
+	pthread_barrier_destroy(&barrier);
+end:
+	arena_spin_lock__destroy(skel);
+	return;
+}
+
+void test_arena_spin_lock(void)
+{
+	if (test__start_subtest("arena_spin_lock_1"))
+		test_arena_spin_lock_size(1);
+	cpu = 0;
+	if (test__start_subtest("arena_spin_lock_1000"))
+		test_arena_spin_lock_size(1000);
+	cpu = 0;
+	if (test__start_subtest("arena_spin_lock_100000"))
+		test_arena_spin_lock_size(100000);
+}
diff --git a/tools/testing/selftests/bpf/progs/arena_spin_lock.c b/tools/testing/selftests/bpf/progs/arena_spin_lock.c
new file mode 100644
index 000000000000..5f47ea794ec4
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/arena_spin_lock.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "bpf_arena_spin_lock.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, 100); /* number of pages */
+#ifdef __TARGET_ARCH_arm64
+	__ulong(map_extra, 0x1ull << 32); /* start of mmap() region */
+#else
+	__ulong(map_extra, 0x1ull << 44); /* start of mmap() region */
+#endif
+} arena SEC(".maps");
+
+int cs_count;
+
+#if defined(ENABLE_ATOMICS_TESTS) && defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+arena_spinlock_t __arena lock;
+int test_skip = 1;
+#else
+int test_skip = 2;
+#endif
+
+int counter;
+
+SEC("tc")
+int prog(void *ctx)
+{
+	int ret = -2;
+
+#if defined(ENABLE_ATOMICS_TESTS) && defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+	unsigned long flags;
+
+	if ((ret = arena_spin_lock_irqsave(&lock, flags)))
+		return ret;
+	WRITE_ONCE(counter, READ_ONCE(counter) + 1);
+	bpf_repeat(cs_count);
+	ret = 0;
+	arena_spin_unlock_irqrestore(&lock, flags);
+#endif
+	return ret;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.47.1


