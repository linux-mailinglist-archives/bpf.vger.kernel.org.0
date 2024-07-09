Return-Path: <bpf+bounces-34278-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE0692C38A
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 20:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 133942836C4
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 18:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA9F182A53;
	Tue,  9 Jul 2024 18:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWmXgLcN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABB1182A41
	for <bpf@vger.kernel.org>; Tue,  9 Jul 2024 18:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720551295; cv=none; b=QjyQU9xOVhAIHdyZ2l3Q3w43C6SyjarPJPXUD6IqfItFf6EZPNoO2DxfXf05sS8DRj1P2UhcxAzeHn3a0ng+fd6Ps77Z8sPtVopf/Oeg0sbabYHtO0mFZ6kASWjVLyulbzV6D4STqbdsTMkBEvy4nsMkXTSalOY17/4xPwoo/fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720551295; c=relaxed/simple;
	bh=jcn0AeM1rbLzBgyDbcxQ/jmlpvg/rwiV8DyXu9Q36PQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fCja5ituiBmRNYak8/GNd9r7fZKNCkytY/KDjuIOsRNDlvb6CEEdq2/jJpHvTm0465apdfUty88L9ywBPGx62GpTwjQhs9jC+3fJYWtKulVB+RhsDUSvuVPZxnHjpdLmynOhs3vqFLRWIF4cy9eXMO6A64JJuNt3NlGqV58A8/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eWmXgLcN; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-a77e7a6cfa7so315807366b.1
        for <bpf@vger.kernel.org>; Tue, 09 Jul 2024 11:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720551291; x=1721156091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H6vPWh/Cdfv+g6Y41vcOMOGSawu5s0lT6PzyDhP1yBc=;
        b=eWmXgLcNHcxmOWEdK0xhQJZJNxNHBh5Jx41sTZv5/WVDWsSHZ2nJXJ2BitY9skX2an
         mfhBFtAAD3hUujPObxIAk0B95FJxSo/Z+2vhSztm1vNYeW8NRxcwmcdK99VcsQBEf+cI
         3WrmACCpG+1cC7Sn/s4BiaLmr/EJ7A5zu5+V9/BoLyg+W5TafK4SqZP8weOMDqBkl5qv
         NrICrO+FuNkjeRXQFp/tkrRz+GyvNzcyOptGrCX/PG5cHSNQ4OqBzkpduKxHymCTv5q2
         VO1Vf1f70EspmPzRtxmHT80sYDYd5EXNgmi6dHMCMVYkAeBMcoaAW3DzSI8iRVkwG5KM
         2sLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720551291; x=1721156091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H6vPWh/Cdfv+g6Y41vcOMOGSawu5s0lT6PzyDhP1yBc=;
        b=jZEFmzQ9vxEo3hoa8YUaHS17ISVjverWosao+8YSInwmGT0aIHGc9vpHSUtGwfCQeQ
         wltqc+jwkJtXYCcRsPjDecjgIOVEUyVNLNWFua6kVkVUvWwSptpLrSl+Rv05cbYdjXsK
         1waVEMhvafbbGtGupwv9ub3TtcL25K78tOvl7YbJnC0H8x8qAL/6Hm14VztJ3IV+TgWb
         ALDPdGgaA5ZASnHTmzj9GdqNBV+06OsfHotYbd9DwVG/GXgOzDg93tBVhrTT+ChH0bgx
         +edc8YJQOSf14T6piPqgXN1yxEpFqYpKphI7S6enxU2rvQqcCyUIgdgSwW+dbNJb5WaU
         3Dvw==
X-Gm-Message-State: AOJu0Yz4qo+1rJcPWvXLeb8/UH79QVyycH/S8/cYVAtGcVAZbhoA340G
	DxsLjrUeVxyobaAwJ9Yy2jIB0nGDJ2HHBWCt0gVIuCjQGH5M9h2LR8wdzM7y
X-Google-Smtp-Source: AGHT+IFGknCJmuYQzN8tfIXXN6/7lNKCtwusaSU6WcsaIzaxoKfSEfWN31L2cX/r266o5eDdVk+rpQ==
X-Received: by 2002:a17:906:3c04:b0:a6f:2206:99ae with SMTP id a640c23a62f3a-a780b705382mr192121466b.41.1720551291274;
        Tue, 09 Jul 2024 11:54:51 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6e1742sm97488766b.70.2024.07.09.11.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 11:54:50 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Dohyun Kim <dohyunkim@google.com>,
	Neel Natu <neelnatu@google.com>,
	Barret Rhoden <brho@google.com>,
	Tejun Heo <htejun@gmail.com>,
	David Vernet <void@manifault.com>
Subject: [PATCH bpf v1 3/3] selftests/bpf: Add timer lockup selftest
Date: Tue,  9 Jul 2024 18:54:40 +0000
Message-ID: <20240709185440.1104957-4-memxor@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709185440.1104957-1-memxor@gmail.com>
References: <20240709185440.1104957-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4896; i=memxor@gmail.com; h=from:subject; bh=jcn0AeM1rbLzBgyDbcxQ/jmlpvg/rwiV8DyXu9Q36PQ=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBmjYUMSOZhgQ9ffn0BxhgAVW4Rmng9L5aJJqNRz 6ELcVWEehmJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZo2FDAAKCRBM4MiGSL8R yhoZD/9CnQC4MjclpusmtpL0t9Vl0wqBMmPalO53vQqY8S/ah5C/iP5M6OHrso/izlaprZo4AfF nSr6GefR8/J8zQfEDSYXwTQcmptbVIJlD4EwcsmOqBUndc4B4y/pQMS7Uc00jXD+hmPPa7u+NFT 6gNX3EjPqIenf+3p1cWqcedKBnfDFaN3C8sEjKLn7i0D5jM15nDJErscZs2EFpTTYBq/Ahco9KN pcYY1p/sDRUWACfX88/Tm1h0hzSGrTqklmEpw4Ef79e2yDeOAGt4xeqdTlXI1i7UUGENn1ZCZHy xhbKBESMaNdGr/HFVxSZoNjcI5hzBcdYA/41in7jTsDcSmvJqb4Lbfx41kI4nsRFP1tqPGj1Nn1 7ugO0aFkIi0SgiATGvIflm4qQ5Cpl6DmJGS/FDing+O/Skg9DL7Ik2x/hAK8nJSZUsIKWwzeT+J hyMSVnWxV7pnP6oxsD9zNjsZTWHlAwI2vWl140s2aNivnzWFcE2fJw1DlkHHqej4bk+pgyd1upj Npjf2BKPlfUeth8Fn4X/iuZFAVshYvPJEUu5r0+419s7F4s7EsbLoimNLk3HcuWdNI5SSkhVyN4 g1xzgP8MCte/YuLOE+ZC8inGRAZJMBEHZ3Rv2sW8VNMWtQwqKkXI3LUvPLsU6xuevTfoLHfYpWb 9HsE0/2iNQYdSKA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Add a selftest that tries to trigger a situation where two timer
callbacks are attempting to cancel each other's timer. By running them
continuously, we hit a condition where both run in parallel and cancel
each other. Without the fix in the previous patch, this would cause a
lockup as hrtimer_cancel on either side will wait for forward progress
from the callback.

Ensure that this situation leads to a EDEADLK error.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/timer_lockup.c   | 65 ++++++++++++++
 .../selftests/bpf/progs/timer_lockup.c        | 85 +++++++++++++++++++
 2 files changed, 150 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/timer_lockup.c
 create mode 100644 tools/testing/selftests/bpf/progs/timer_lockup.c

diff --git a/tools/testing/selftests/bpf/prog_tests/timer_lockup.c b/tools/testing/selftests/bpf/prog_tests/timer_lockup.c
new file mode 100644
index 000000000000..73e376fc5bbd
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/timer_lockup.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <sched.h>
+#include <test_progs.h>
+#include <pthread.h>
+#include <network_helpers.h>
+#include "timer_lockup.skel.h"
+
+long cpu;
+int *timer1_err;
+int *timer2_err;
+
+static void *timer_lockup_thread(void *arg)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts,
+		.data_in = &pkt_v4,
+		.data_size_in = sizeof(pkt_v4),
+		.repeat = 10000,
+	);
+	int prog_fd = *(int *)arg;
+	cpu_set_t cpuset;
+
+	CPU_ZERO(&cpuset);
+	CPU_SET(__sync_fetch_and_add(&cpu, 1), &cpuset);
+	ASSERT_OK(pthread_setaffinity_np(pthread_self(), sizeof(cpuset), &cpuset), "cpu affinity");
+
+	while (!*timer1_err && !*timer2_err)
+		bpf_prog_test_run_opts(prog_fd, &opts);
+
+	return NULL;
+}
+
+void test_timer_lockup(void)
+{
+	struct timer_lockup *skel;
+	pthread_t thrds[2];
+	void *ret;
+
+	skel = timer_lockup__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "timer_lockup__open_and_load"))
+		return;
+
+	int timer1_prog = bpf_program__fd(skel->progs.timer1_prog);
+	int timer2_prog = bpf_program__fd(skel->progs.timer2_prog);
+
+	timer1_err = &skel->bss->timer1_err;
+	timer2_err = &skel->bss->timer2_err;
+
+	if (!ASSERT_OK(pthread_create(&thrds[0], NULL, timer_lockup_thread, &timer1_prog), "pthread_create thread1"))
+		return;
+	if (!ASSERT_OK(pthread_create(&thrds[1], NULL, timer_lockup_thread, &timer2_prog), "pthread_create thread2")) {
+		pthread_exit(&thrds[0]);
+		return;
+	}
+
+	pthread_join(thrds[1], &ret);
+	pthread_join(thrds[0], &ret);
+
+	if (*timer1_err != -EDEADLK && *timer1_err != 0)
+		ASSERT_FAIL("timer1_err bad value");
+	if (*timer2_err != -EDEADLK && *timer2_err != 0)
+		ASSERT_FAIL("timer2_err bad value");
+
+	return;
+}
diff --git a/tools/testing/selftests/bpf/progs/timer_lockup.c b/tools/testing/selftests/bpf/progs/timer_lockup.c
new file mode 100644
index 000000000000..ca29da9ff25c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/timer_lockup.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <time.h>
+#include <errno.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct elem {
+	struct bpf_timer t;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct elem);
+} timer1_map SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct elem);
+} timer2_map SEC(".maps");
+
+int timer1_err;
+int timer2_err;
+
+static int timer_cb1(void *map, int *k, struct bpf_timer *timer)
+{
+	int key = 0;
+
+	timer = bpf_map_lookup_elem(&timer2_map, &key);
+	if (timer) {
+		timer2_err = bpf_timer_cancel(timer);
+	}
+	return 0;
+}
+
+static int timer_cb2(void *map, int *k, struct bpf_timer *timer)
+{
+	int key = 0;
+
+	timer = bpf_map_lookup_elem(&timer1_map, &key);
+	if (timer) {
+		timer1_err = bpf_timer_cancel(timer);
+	}
+	return 0;
+}
+
+SEC("tc")
+int timer1_prog(void *ctx)
+{
+	int key = 0;
+	struct bpf_timer *timer;
+
+	timer = bpf_map_lookup_elem(&timer1_map, &key);
+	if (timer) {
+		bpf_timer_init(timer, &timer1_map, CLOCK_BOOTTIME);
+		bpf_timer_set_callback(timer, timer_cb1);
+		bpf_timer_start(timer, 1, BPF_F_TIMER_CPU_PIN);
+	}
+
+	return 0;
+}
+
+SEC("tc")
+int timer2_prog(void *ctx)
+{
+	int key = 0;
+	struct bpf_timer *timer;
+
+	timer = bpf_map_lookup_elem(&timer2_map, &key);
+	if (timer) {
+		bpf_timer_init(timer, &timer2_map, CLOCK_BOOTTIME);
+		bpf_timer_set_callback(timer, timer_cb2);
+		bpf_timer_start(timer, 1, BPF_F_TIMER_CPU_PIN);
+	}
+
+	return 0;
+}
-- 
2.43.0


