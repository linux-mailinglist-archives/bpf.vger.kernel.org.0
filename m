Return-Path: <bpf+bounces-36855-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E72994E40A
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 02:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85EA2B20CBD
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 00:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8ED56112;
	Mon, 12 Aug 2024 00:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMkIaD8o"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7814A1D;
	Mon, 12 Aug 2024 00:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723423527; cv=none; b=P9DaJvBZW8LX3k5xh0F2Y5KI+JZ8k091o9gM/ojH7qeVCBm1m0f6yEFUd1M07lRn8ifXhfN/7pj1nVi9sXQk4PvqEGaDjHrMWtADXMD9qhtrsei8COui2F+zSSclEF1VkyDVBQmBeYjgUKjdoVjL/OIdXUDq9GZKLzT8s8xs82s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723423527; c=relaxed/simple;
	bh=LEToUvRLUnMYA+8gvEo1Yi8GUl+0G8+Ezy/9btse6lY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bEuvQgIvgUYYRQyfRk4uR+lOeIcO6j2JouQXoJKgLe8Y3G1LxGbVeV417a8Kwvk+cWWNgSIXUjqjRkNhK/rO25brfOEzF7k/VOynV1nBwLF9wLFK/Iqs4ISZzBFcIsKpf5goQScnsijkmlTkPOEmXZKixGAQZzLV14Eg8SZ0Dnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LMkIaD8o; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-26827ec5235so1929674fac.2;
        Sun, 11 Aug 2024 17:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723423524; x=1724028324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KtOUEokUSHIvTZRmLanbdG9E9eSu+Uv9BzZGjcrIPPo=;
        b=LMkIaD8oMVZBnl4j5qDQEPZX3RguK8SBNZbgc4xgiZ6WZ51kiTXfqJFwnIPKJAQRpD
         bETkpWDHrC32hM4f5W/CIwoQf1p0SDZn/bLVFB5WUKg3XYeZMIEhF8qK83ctvgMZ2MV+
         AhhwXb1IOpmjZVZHNKkebW8S4M4fdCpdECc2rHrfWQ9hNd0jwMANiUg+d53p08Yp5WFe
         22yi0gucIo18NeId4ZSA9/a0lNvUsUM/V/YHWpHerpKitES5IA70nA2U4PHf1sDOPAV8
         wLQ0ETlG9IolXi0f/EuQgJ43dZQIC1XIrsu2Zcl3Uer4QG9ycmF12F+k23c++Fp4L8US
         zxrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723423524; x=1724028324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KtOUEokUSHIvTZRmLanbdG9E9eSu+Uv9BzZGjcrIPPo=;
        b=NXG18GPGQ+n7YRmUMl4JpynS/LpDg2V2RPOc5l+ESeSxlcWvnJaQHCyqCfn1ZappmD
         OjrLAiQbZwplXufTv8QSadRnuftvMXo4666moIYGLSAPTLFLP9TKmGoOeinIKPuwEDCc
         7bZ9G0DozN6VFn/VcdWvxVP1Ppb2yIprpvuA01vH+I3ftfavdVeeCaDx7k8yh+wNuCP6
         5V7OKZlEt8Bpq5Vq3d7Ga5PVOv4dIQkOYkZsa3inJWsARpyZFVB8A+MaLlh35Fisc1VI
         DSJgxfKMV+1FRwwJzFxg8Y+E0QjfUOy8E5OfHwJ79ZLpMhrmH837lA5bRAr5VvdgTGFy
         6ZGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZFLzLT+Nrxqt6tbtWnO5ZE511nRb9dzf4vq++IPbG3CLyjyf6Wr0xP1BktNAMLyiGO3BnA1pMyxFxjS0EUEbafhmpD8mPWflfRsgGCQYtvhnEaXR4n87nEaei6gRL1J2WngxaPYGYizJ0acJqXF3kd+Hqh4Agzbfj7eS3
X-Gm-Message-State: AOJu0Ywawh6/6LtcAgVvrcj/y4DJ/CI8MLlo3bgmbBSrSn/X0rxL6VOK
	NiefHFU7Ss5LvZavzLxKAr0Efm6jiky8hQ7oupMRJzzL/4/pZks=
X-Google-Smtp-Source: AGHT+IEQQGDJOiUncFU2tngRwOS+F9Gx9IVJjZ/YcxMzz34tcJjt04DQCrtpa/Im0hO9i27FGVGxCA==
X-Received: by 2002:a05:6870:c0d2:b0:260:fb01:5651 with SMTP id 586e51a60fabf-26c62c5439dmr9273101fac.12.1723423523999;
        Sun, 11 Aug 2024 17:45:23 -0700 (PDT)
Received: from vagrant.. ([114.71.48.94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e58ade4fsm2891966b3a.51.2024.08.11.17.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 17:45:23 -0700 (PDT)
From: "Daniel T. Lee" <danieltimlee@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Yipeng Zou <zouyipeng@huawei.com>,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [bpf-next 3/3] samples/bpf: remove obsolete tracing related tests
Date: Mon, 12 Aug 2024 00:45:03 +0000
Message-ID: <20240812004503.43206-4-danieltimlee@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240812004503.43206-1-danieltimlee@gmail.com>
References: <20240812004503.43206-1-danieltimlee@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The samples/bpf has become outdated and often does not follow up with
the latest. This commit removes obsolete tracing-related tests.

Specifically, 'test_overhead' is migrated from previous two commits,
and 'test_override_return', 'test_probe_write_user' tests are obsolete
since they have been replaced by kprobe_multi_override and probe_user
from selftests/bpf respectively.

This cleanup will help to streamline the testing framework by removing
redundant tests.

Signed-off-by: Daniel T. Lee <danieltimlee@gmail.com>
---
 samples/bpf/Makefile                     |  12 --
 samples/bpf/test_overhead_kprobe.bpf.c   |  41 -----
 samples/bpf/test_overhead_raw_tp.bpf.c   |  17 --
 samples/bpf/test_overhead_tp.bpf.c       |  23 ---
 samples/bpf/test_overhead_user.c         | 225 -----------------------
 samples/bpf/test_override_return.sh      |  16 --
 samples/bpf/test_probe_write_user.bpf.c  |  52 ------
 samples/bpf/test_probe_write_user_user.c | 108 -----------
 samples/bpf/tracex7.bpf.c                |  15 --
 samples/bpf/tracex7_user.c               |  56 ------
 10 files changed, 565 deletions(-)
 delete mode 100644 samples/bpf/test_overhead_kprobe.bpf.c
 delete mode 100644 samples/bpf/test_overhead_raw_tp.bpf.c
 delete mode 100644 samples/bpf/test_overhead_tp.bpf.c
 delete mode 100644 samples/bpf/test_overhead_user.c
 delete mode 100755 samples/bpf/test_override_return.sh
 delete mode 100644 samples/bpf/test_probe_write_user.bpf.c
 delete mode 100644 samples/bpf/test_probe_write_user_user.c
 delete mode 100644 samples/bpf/tracex7.bpf.c
 delete mode 100644 samples/bpf/tracex7_user.c

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 3e003dd6bea0..68cc86c1288a 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -18,14 +18,11 @@ tprogs-y += tracex3
 tprogs-y += tracex4
 tprogs-y += tracex5
 tprogs-y += tracex6
-tprogs-y += tracex7
-tprogs-y += test_probe_write_user
 tprogs-y += trace_output
 tprogs-y += lathist
 tprogs-y += offwaketime
 tprogs-y += spintest
 tprogs-y += map_perf_test
-tprogs-y += test_overhead
 tprogs-y += test_cgrp2_array_pin
 tprogs-y += test_cgrp2_attach
 tprogs-y += test_cgrp2_sock
@@ -68,14 +65,11 @@ tracex3-objs := tracex3_user.o
 tracex4-objs := tracex4_user.o
 tracex5-objs := tracex5_user.o $(TRACE_HELPERS)
 tracex6-objs := tracex6_user.o
-tracex7-objs := tracex7_user.o
-test_probe_write_user-objs := test_probe_write_user_user.o
 trace_output-objs := trace_output_user.o
 lathist-objs := lathist_user.o
 offwaketime-objs := offwaketime_user.o $(TRACE_HELPERS)
 spintest-objs := spintest_user.o $(TRACE_HELPERS)
 map_perf_test-objs := map_perf_test_user.o
-test_overhead-objs := test_overhead_user.o
 test_cgrp2_array_pin-objs := test_cgrp2_array_pin.o
 test_cgrp2_attach-objs := test_cgrp2_attach.o
 test_cgrp2_sock-objs := test_cgrp2_sock.o
@@ -110,9 +104,7 @@ always-y += tracex3.bpf.o
 always-y += tracex4.bpf.o
 always-y += tracex5.bpf.o
 always-y += tracex6.bpf.o
-always-y += tracex7.bpf.o
 always-y += sock_flags.bpf.o
-always-y += test_probe_write_user.bpf.o
 always-y += trace_output.bpf.o
 always-y += tcbpf1_kern.o
 always-y += tc_l2_redirect_kern.o
@@ -120,9 +112,6 @@ always-y += lathist_kern.o
 always-y += offwaketime.bpf.o
 always-y += spintest.bpf.o
 always-y += map_perf_test.bpf.o
-always-y += test_overhead_tp.bpf.o
-always-y += test_overhead_raw_tp.bpf.o
-always-y += test_overhead_kprobe.bpf.o
 always-y += parse_varlen.o parse_simple.o parse_ldabs.o
 always-y += test_cgrp2_tc.bpf.o
 always-y += test_current_task_under_cgroup.bpf.o
@@ -194,7 +183,6 @@ TPROGLDLIBS_xdp_router_ipv4	+= -lm -pthread
 TPROGLDLIBS_tracex4		+= -lrt
 TPROGLDLIBS_trace_output	+= -lrt
 TPROGLDLIBS_map_perf_test	+= -lrt
-TPROGLDLIBS_test_overhead	+= -lrt
 
 # Allows pointing LLC/CLANG to a LLVM backend with bpf support, redefine on cmdline:
 # make M=samples/bpf LLC=~/git/llvm-project/llvm/build/bin/llc CLANG=~/git/llvm-project/llvm/build/bin/clang
diff --git a/samples/bpf/test_overhead_kprobe.bpf.c b/samples/bpf/test_overhead_kprobe.bpf.c
deleted file mode 100644
index 668cf5259c60..000000000000
--- a/samples/bpf/test_overhead_kprobe.bpf.c
+++ /dev/null
@@ -1,41 +0,0 @@
-/* Copyright (c) 2016 Facebook
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- */
-#include "vmlinux.h"
-#include <linux/version.h>
-#include <bpf/bpf_helpers.h>
-#include <bpf/bpf_tracing.h>
-#include <bpf/bpf_core_read.h>
-
-SEC("kprobe/__set_task_comm")
-int prog(struct pt_regs *ctx)
-{
-	struct signal_struct *signal;
-	struct task_struct *tsk;
-	char oldcomm[TASK_COMM_LEN] = {};
-	char newcomm[TASK_COMM_LEN] = {};
-	u16 oom_score_adj;
-	u32 pid;
-
-	tsk = (void *)PT_REGS_PARM1_CORE(ctx);
-
-	pid = BPF_CORE_READ(tsk, pid);
-	bpf_core_read_str(oldcomm, sizeof(oldcomm), &tsk->comm);
-	bpf_core_read_str(newcomm, sizeof(newcomm),
-				  (void *)PT_REGS_PARM2(ctx));
-	signal = BPF_CORE_READ(tsk, signal);
-	oom_score_adj = BPF_CORE_READ(signal, oom_score_adj);
-	return 0;
-}
-
-SEC("kprobe/fib_table_lookup")
-int prog2(struct pt_regs *ctx)
-{
-	return 0;
-}
-
-char _license[] SEC("license") = "GPL";
-u32 _version SEC("version") = LINUX_VERSION_CODE;
diff --git a/samples/bpf/test_overhead_raw_tp.bpf.c b/samples/bpf/test_overhead_raw_tp.bpf.c
deleted file mode 100644
index 6af39fe3f8dd..000000000000
--- a/samples/bpf/test_overhead_raw_tp.bpf.c
+++ /dev/null
@@ -1,17 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* Copyright (c) 2018 Facebook */
-#include "vmlinux.h"
-#include <bpf/bpf_helpers.h>
-
-SEC("raw_tracepoint/task_rename")
-int prog(struct bpf_raw_tracepoint_args *ctx)
-{
-	return 0;
-}
-
-SEC("raw_tracepoint/fib_table_lookup")
-int prog2(struct bpf_raw_tracepoint_args *ctx)
-{
-	return 0;
-}
-char _license[] SEC("license") = "GPL";
diff --git a/samples/bpf/test_overhead_tp.bpf.c b/samples/bpf/test_overhead_tp.bpf.c
deleted file mode 100644
index 5dc08b587978..000000000000
--- a/samples/bpf/test_overhead_tp.bpf.c
+++ /dev/null
@@ -1,23 +0,0 @@
-/* Copyright (c) 2016 Facebook
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- */
-#include "vmlinux.h"
-#include <bpf/bpf_helpers.h>
-
-/* from /sys/kernel/tracing/events/task/task_rename/format */
-SEC("tracepoint/task/task_rename")
-int prog(struct trace_event_raw_task_rename *ctx)
-{
-	return 0;
-}
-
-/* from /sys/kernel/tracing/events/fib/fib_table_lookup/format */
-SEC("tracepoint/fib/fib_table_lookup")
-int prog2(struct trace_event_raw_fib_table_lookup *ctx)
-{
-	return 0;
-}
-char _license[] SEC("license") = "GPL";
diff --git a/samples/bpf/test_overhead_user.c b/samples/bpf/test_overhead_user.c
deleted file mode 100644
index dbd86f7b1473..000000000000
--- a/samples/bpf/test_overhead_user.c
+++ /dev/null
@@ -1,225 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/* Copyright (c) 2016 Facebook
- */
-#define _GNU_SOURCE
-#include <sched.h>
-#include <errno.h>
-#include <stdio.h>
-#include <sys/types.h>
-#include <asm/unistd.h>
-#include <fcntl.h>
-#include <unistd.h>
-#include <assert.h>
-#include <sys/wait.h>
-#include <sys/socket.h>
-#include <arpa/inet.h>
-#include <stdlib.h>
-#include <signal.h>
-#include <linux/bpf.h>
-#include <string.h>
-#include <time.h>
-#include <bpf/bpf.h>
-#include <bpf/libbpf.h>
-
-#define MAX_CNT 1000000
-#define DUMMY_IP "127.0.0.1"
-#define DUMMY_PORT 80
-
-static struct bpf_link *links[2];
-static struct bpf_object *obj;
-static int cnt;
-
-static __u64 time_get_ns(void)
-{
-	struct timespec ts;
-
-	clock_gettime(CLOCK_MONOTONIC, &ts);
-	return ts.tv_sec * 1000000000ull + ts.tv_nsec;
-}
-
-static void test_task_rename(int cpu)
-{
-	char buf[] = "test\n";
-	__u64 start_time;
-	int i, fd;
-
-	fd = open("/proc/self/comm", O_WRONLY|O_TRUNC);
-	if (fd < 0) {
-		printf("couldn't open /proc\n");
-		exit(1);
-	}
-	start_time = time_get_ns();
-	for (i = 0; i < MAX_CNT; i++) {
-		if (write(fd, buf, sizeof(buf)) < 0) {
-			printf("task rename failed: %s\n", strerror(errno));
-			close(fd);
-			return;
-		}
-	}
-	printf("task_rename:%d: %lld events per sec\n",
-	       cpu, MAX_CNT * 1000000000ll / (time_get_ns() - start_time));
-	close(fd);
-}
-
-static void test_fib_table_lookup(int cpu)
-{
-	struct sockaddr_in addr;
-	char buf[] = "test\n";
-	__u64 start_time;
-	int i, fd;
-
-	fd = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
-	if (fd < 0) {
-		printf("couldn't open socket\n");
-		exit(1);
-	}
-	memset((char *)&addr, 0, sizeof(addr));
-	addr.sin_addr.s_addr = inet_addr(DUMMY_IP);
-	addr.sin_port = htons(DUMMY_PORT);
-	addr.sin_family = AF_INET;
-	start_time = time_get_ns();
-	for (i = 0; i < MAX_CNT; i++) {
-		if (sendto(fd, buf, strlen(buf), 0,
-			   (struct sockaddr *)&addr, sizeof(addr)) < 0) {
-			printf("failed to start ping: %s\n", strerror(errno));
-			close(fd);
-			return;
-		}
-	}
-	printf("fib_table_lookup:%d: %lld events per sec\n",
-	       cpu, MAX_CNT * 1000000000ll / (time_get_ns() - start_time));
-	close(fd);
-}
-
-static void loop(int cpu, int flags)
-{
-	cpu_set_t cpuset;
-
-	CPU_ZERO(&cpuset);
-	CPU_SET(cpu, &cpuset);
-	sched_setaffinity(0, sizeof(cpuset), &cpuset);
-
-	if (flags & 1)
-		test_task_rename(cpu);
-	if (flags & 2)
-		test_fib_table_lookup(cpu);
-}
-
-static void run_perf_test(int tasks, int flags)
-{
-	pid_t pid[tasks];
-	int i;
-
-	for (i = 0; i < tasks; i++) {
-		pid[i] = fork();
-		if (pid[i] == 0) {
-			loop(i, flags);
-			exit(0);
-		} else if (pid[i] == -1) {
-			printf("couldn't spawn #%d process\n", i);
-			exit(1);
-		}
-	}
-	for (i = 0; i < tasks; i++) {
-		int status;
-
-		assert(waitpid(pid[i], &status, 0) == pid[i]);
-		assert(status == 0);
-	}
-}
-
-static int load_progs(char *filename)
-{
-	struct bpf_program *prog;
-	int err = 0;
-
-	obj = bpf_object__open_file(filename, NULL);
-	err = libbpf_get_error(obj);
-	if (err < 0) {
-		fprintf(stderr, "ERROR: opening BPF object file failed\n");
-		return err;
-	}
-
-	/* load BPF program */
-	err = bpf_object__load(obj);
-	if (err < 0) {
-		fprintf(stderr, "ERROR: loading BPF object file failed\n");
-		return err;
-	}
-
-	bpf_object__for_each_program(prog, obj) {
-		links[cnt] = bpf_program__attach(prog);
-		err = libbpf_get_error(links[cnt]);
-		if (err < 0) {
-			fprintf(stderr, "ERROR: bpf_program__attach failed\n");
-			links[cnt] = NULL;
-			return err;
-		}
-		cnt++;
-	}
-
-	return err;
-}
-
-static void unload_progs(void)
-{
-	while (cnt)
-		bpf_link__destroy(links[--cnt]);
-
-	bpf_object__close(obj);
-}
-
-int main(int argc, char **argv)
-{
-	int num_cpu = sysconf(_SC_NPROCESSORS_ONLN);
-	int test_flags = ~0;
-	char filename[256];
-	int err = 0;
-
-
-	if (argc > 1)
-		test_flags = atoi(argv[1]) ? : test_flags;
-	if (argc > 2)
-		num_cpu = atoi(argv[2]) ? : num_cpu;
-
-	if (test_flags & 0x3) {
-		printf("BASE\n");
-		run_perf_test(num_cpu, test_flags);
-	}
-
-	if (test_flags & 0xC) {
-		snprintf(filename, sizeof(filename),
-			 "%s_kprobe.bpf.o", argv[0]);
-
-		printf("w/KPROBE\n");
-		err = load_progs(filename);
-		if (!err)
-			run_perf_test(num_cpu, test_flags >> 2);
-
-		unload_progs();
-	}
-
-	if (test_flags & 0x30) {
-		snprintf(filename, sizeof(filename),
-			 "%s_tp.bpf.o", argv[0]);
-		printf("w/TRACEPOINT\n");
-		err = load_progs(filename);
-		if (!err)
-			run_perf_test(num_cpu, test_flags >> 4);
-
-		unload_progs();
-	}
-
-	if (test_flags & 0xC0) {
-		snprintf(filename, sizeof(filename),
-			 "%s_raw_tp.bpf.o", argv[0]);
-		printf("w/RAW_TRACEPOINT\n");
-		err = load_progs(filename);
-		if (!err)
-			run_perf_test(num_cpu, test_flags >> 6);
-
-		unload_progs();
-	}
-
-	return err;
-}
diff --git a/samples/bpf/test_override_return.sh b/samples/bpf/test_override_return.sh
deleted file mode 100755
index 35db26f736b9..000000000000
--- a/samples/bpf/test_override_return.sh
+++ /dev/null
@@ -1,16 +0,0 @@
-#!/bin/bash
-
-rm -r tmpmnt
-rm -f testfile.img
-dd if=/dev/zero of=testfile.img bs=1M seek=1000 count=1
-DEVICE=$(losetup --show -f testfile.img)
-mkfs.btrfs -f $DEVICE
-mkdir tmpmnt
-./tracex7 $DEVICE
-if [ $? -eq 0 ]
-then
-	echo "SUCCESS!"
-else
-	echo "FAILED!"
-fi
-losetup -d $DEVICE
diff --git a/samples/bpf/test_probe_write_user.bpf.c b/samples/bpf/test_probe_write_user.bpf.c
deleted file mode 100644
index a4f3798b7fb0..000000000000
--- a/samples/bpf/test_probe_write_user.bpf.c
+++ /dev/null
@@ -1,52 +0,0 @@
-/* Copyright (c) 2016 Sargun Dhillon <sargun@sargun.me>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- */
-#include "vmlinux.h"
-#include <string.h>
-#include <linux/version.h>
-#include <bpf/bpf_helpers.h>
-#include <bpf/bpf_tracing.h>
-#include <bpf/bpf_core_read.h>
-
-struct {
-	__uint(type, BPF_MAP_TYPE_HASH);
-	__type(key, struct sockaddr_in);
-	__type(value, struct sockaddr_in);
-	__uint(max_entries, 256);
-} dnat_map SEC(".maps");
-
-/* kprobe is NOT a stable ABI
- * kernel functions can be removed, renamed or completely change semantics.
- * Number of arguments and their positions can change, etc.
- * In such case this bpf+kprobe example will no longer be meaningful
- *
- * This example sits on a syscall, and the syscall ABI is relatively stable
- * of course, across platforms, and over time, the ABI may change.
- */
-SEC("ksyscall/connect")
-int BPF_KSYSCALL(bpf_prog1, int fd, struct sockaddr_in *uservaddr,
-		 int addrlen)
-{
-	struct sockaddr_in new_addr, orig_addr = {};
-	struct sockaddr_in *mapped_addr;
-
-	if (addrlen > sizeof(orig_addr))
-		return 0;
-
-	if (bpf_probe_read_user(&orig_addr, sizeof(orig_addr), uservaddr) != 0)
-		return 0;
-
-	mapped_addr = bpf_map_lookup_elem(&dnat_map, &orig_addr);
-	if (mapped_addr != NULL) {
-		memcpy(&new_addr, mapped_addr, sizeof(new_addr));
-		bpf_probe_write_user(uservaddr, &new_addr,
-				     sizeof(new_addr));
-	}
-	return 0;
-}
-
-char _license[] SEC("license") = "GPL";
-u32 _version SEC("version") = LINUX_VERSION_CODE;
diff --git a/samples/bpf/test_probe_write_user_user.c b/samples/bpf/test_probe_write_user_user.c
deleted file mode 100644
index 2a539aec4116..000000000000
--- a/samples/bpf/test_probe_write_user_user.c
+++ /dev/null
@@ -1,108 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <stdio.h>
-#include <assert.h>
-#include <unistd.h>
-#include <bpf/bpf.h>
-#include <bpf/libbpf.h>
-#include <sys/socket.h>
-#include <netinet/in.h>
-#include <arpa/inet.h>
-
-int main(int ac, char **argv)
-{
-	struct sockaddr_in *serv_addr_in, *mapped_addr_in, *tmp_addr_in;
-	struct sockaddr serv_addr, mapped_addr, tmp_addr;
-	int serverfd, serverconnfd, clientfd, map_fd;
-	struct bpf_link *link = NULL;
-	struct bpf_program *prog;
-	struct bpf_object *obj;
-	socklen_t sockaddr_len;
-	char filename[256];
-	char *ip;
-
-	serv_addr_in = (struct sockaddr_in *)&serv_addr;
-	mapped_addr_in = (struct sockaddr_in *)&mapped_addr;
-	tmp_addr_in = (struct sockaddr_in *)&tmp_addr;
-
-	snprintf(filename, sizeof(filename), "%s.bpf.o", argv[0]);
-	obj = bpf_object__open_file(filename, NULL);
-	if (libbpf_get_error(obj)) {
-		fprintf(stderr, "ERROR: opening BPF object file failed\n");
-		return 0;
-	}
-
-	prog = bpf_object__find_program_by_name(obj, "bpf_prog1");
-	if (libbpf_get_error(prog)) {
-		fprintf(stderr, "ERROR: finding a prog in obj file failed\n");
-		goto cleanup;
-	}
-
-	/* load BPF program */
-	if (bpf_object__load(obj)) {
-		fprintf(stderr, "ERROR: loading BPF object file failed\n");
-		goto cleanup;
-	}
-
-	map_fd = bpf_object__find_map_fd_by_name(obj, "dnat_map");
-	if (map_fd < 0) {
-		fprintf(stderr, "ERROR: finding a map in obj file failed\n");
-		goto cleanup;
-	}
-
-	link = bpf_program__attach(prog);
-	if (libbpf_get_error(link)) {
-		fprintf(stderr, "ERROR: bpf_program__attach failed\n");
-		link = NULL;
-		goto cleanup;
-	}
-
-	assert((serverfd = socket(AF_INET, SOCK_STREAM, 0)) > 0);
-	assert((clientfd = socket(AF_INET, SOCK_STREAM, 0)) > 0);
-
-	/* Bind server to ephemeral port on lo */
-	memset(&serv_addr, 0, sizeof(serv_addr));
-	serv_addr_in->sin_family = AF_INET;
-	serv_addr_in->sin_port = 0;
-	serv_addr_in->sin_addr.s_addr = htonl(INADDR_LOOPBACK);
-
-	assert(bind(serverfd, &serv_addr, sizeof(serv_addr)) == 0);
-
-	sockaddr_len = sizeof(serv_addr);
-	assert(getsockname(serverfd, &serv_addr, &sockaddr_len) == 0);
-	ip = inet_ntoa(serv_addr_in->sin_addr);
-	printf("Server bound to: %s:%d\n", ip, ntohs(serv_addr_in->sin_port));
-
-	memset(&mapped_addr, 0, sizeof(mapped_addr));
-	mapped_addr_in->sin_family = AF_INET;
-	mapped_addr_in->sin_port = htons(5555);
-	mapped_addr_in->sin_addr.s_addr = inet_addr("255.255.255.255");
-
-	assert(!bpf_map_update_elem(map_fd, &mapped_addr, &serv_addr, BPF_ANY));
-
-	assert(listen(serverfd, 5) == 0);
-
-	ip = inet_ntoa(mapped_addr_in->sin_addr);
-	printf("Client connecting to: %s:%d\n",
-	       ip, ntohs(mapped_addr_in->sin_port));
-	assert(connect(clientfd, &mapped_addr, sizeof(mapped_addr)) == 0);
-
-	sockaddr_len = sizeof(tmp_addr);
-	ip = inet_ntoa(tmp_addr_in->sin_addr);
-	assert((serverconnfd = accept(serverfd, &tmp_addr, &sockaddr_len)) > 0);
-	printf("Server received connection from: %s:%d\n",
-	       ip, ntohs(tmp_addr_in->sin_port));
-
-	sockaddr_len = sizeof(tmp_addr);
-	assert(getpeername(clientfd, &tmp_addr, &sockaddr_len) == 0);
-	ip = inet_ntoa(tmp_addr_in->sin_addr);
-	printf("Client's peer address: %s:%d\n",
-	       ip, ntohs(tmp_addr_in->sin_port));
-
-	/* Is the server's getsockname = the socket getpeername */
-	assert(memcmp(&serv_addr, &tmp_addr, sizeof(struct sockaddr_in)) == 0);
-
-cleanup:
-	bpf_link__destroy(link);
-	bpf_object__close(obj);
-	return 0;
-}
diff --git a/samples/bpf/tracex7.bpf.c b/samples/bpf/tracex7.bpf.c
deleted file mode 100644
index ab8d6704a5a4..000000000000
--- a/samples/bpf/tracex7.bpf.c
+++ /dev/null
@@ -1,15 +0,0 @@
-#include "vmlinux.h"
-#include <linux/version.h>
-#include <bpf/bpf_helpers.h>
-
-SEC("kprobe/open_ctree")
-int bpf_prog1(struct pt_regs *ctx)
-{
-	unsigned long rc = -12;
-
-	bpf_override_return(ctx, rc);
-	return 0;
-}
-
-char _license[] SEC("license") = "GPL";
-u32 _version SEC("version") = LINUX_VERSION_CODE;
diff --git a/samples/bpf/tracex7_user.c b/samples/bpf/tracex7_user.c
deleted file mode 100644
index b10b5e03a226..000000000000
--- a/samples/bpf/tracex7_user.c
+++ /dev/null
@@ -1,56 +0,0 @@
-#define _GNU_SOURCE
-
-#include <stdio.h>
-#include <unistd.h>
-#include <bpf/libbpf.h>
-
-int main(int argc, char **argv)
-{
-	struct bpf_link *link = NULL;
-	struct bpf_program *prog;
-	struct bpf_object *obj;
-	char filename[256];
-	char command[256];
-	int ret = 0;
-	FILE *f;
-
-	if (!argv[1]) {
-		fprintf(stderr, "ERROR: Run with the btrfs device argument!\n");
-		return 0;
-	}
-
-	snprintf(filename, sizeof(filename), "%s.bpf.o", argv[0]);
-	obj = bpf_object__open_file(filename, NULL);
-	if (libbpf_get_error(obj)) {
-		fprintf(stderr, "ERROR: opening BPF object file failed\n");
-		return 0;
-	}
-
-	prog = bpf_object__find_program_by_name(obj, "bpf_prog1");
-	if (!prog) {
-		fprintf(stderr, "ERROR: finding a prog in obj file failed\n");
-		goto cleanup;
-	}
-
-	/* load BPF program */
-	if (bpf_object__load(obj)) {
-		fprintf(stderr, "ERROR: loading BPF object file failed\n");
-		goto cleanup;
-	}
-
-	link = bpf_program__attach(prog);
-	if (libbpf_get_error(link)) {
-		fprintf(stderr, "ERROR: bpf_program__attach failed\n");
-		link = NULL;
-		goto cleanup;
-	}
-
-	snprintf(command, 256, "mount %s tmpmnt/", argv[1]);
-	f = popen(command, "r");
-	ret = pclose(f);
-
-cleanup:
-	bpf_link__destroy(link);
-	bpf_object__close(obj);
-	return ret ? 0 : 1;
-}
-- 
2.43.0


