Return-Path: <bpf+bounces-77023-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D879CCD151
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 19:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03AEF304B210
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 17:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C8B307AE9;
	Thu, 18 Dec 2025 17:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHJy3AZs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED03330F522
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 17:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766080611; cv=none; b=tPJSLWGdUrdW528WNKGvPMGeMjmdD/sdiRUKyZFh5UxgTeehTFqP2YD5ZrkPOJgiJ+k0qDkEN/GKpS9ky0+4vWe0BCsmjiu+XmPJO3+GJlWG9DjQ6dOONydaLmuMcpdkEluIfHVxGWP1uMCwWbV7pCram+QY0vb6j6hdbNUznb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766080611; c=relaxed/simple;
	bh=ccp3EztJlEJzQLmiEu1DIzpJsXT5LIfKYR2G67v0qAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Se33BaYCKnhssfAkvyskHv1KsiMuJJsMaKtykJDAsxUPzDDiZTlcJLISwk3kTJWUs8ZC5puALknWh69NfyIxa44KqeNSa4iZa7AaETAgsYWsvQSZp/LXFWBNM9m/7Y8oLS0HKxENAQxYbGIx0eBLxKdP8/J3sYz7k5+6pXCkVk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHJy3AZs; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-34c2f335681so740473a91.1
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 09:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766080608; x=1766685408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6dhstHRDqQgEPx9WkzXkwbtwT/zsNcRbIl8bglWWgQI=;
        b=LHJy3AZs5NBwgU1PpMXHkQGy7mcxih3U2eGtvvGAmtx84OFtn5K6iDPbMQardo2pKg
         bRQ6Bl4LYbo6D9soFjUQoCC21StM4iWRDvFz2D0FJameMu2vvadE6pw6LuVtThVXx3pE
         WTTnpenuaJtW1DrbdM2c6h9i+UYzAqsguGWl7Rm7G/0AyWDPUWpbxNS8NacCPerOuQBP
         zq6XHeFQI0FoBwxBrb0IOxuHud/OCnRpc+PMtTMeFfE3SNAhRXBG0iE7yaaT3cnzSoET
         WD46S0//zedOi9rjLLZUmOd9mu9PLCNHopeoMIX5gLA+mZZAnczHSE3boYWUE8uW4m1L
         NbRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766080608; x=1766685408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6dhstHRDqQgEPx9WkzXkwbtwT/zsNcRbIl8bglWWgQI=;
        b=OxoguK6evoo/gBAe8aZ+e2vF8CAzXY0Vw70KWLTn/qrfJZXi+cy352RRGl6UiBX/Ba
         w09Os3Qu8jTEFzH1qUnl/6rqaMeOM0ODcwplpevwdGujltbaahsTzP6z6ibEU0x1M7Bj
         IH4KDXhmgwKqAmMoErVdtuvOB83yP++LPM6JjdBNjxY1oY9dh0LGYQhnZsNz1ZOnsUDY
         xFOZkGR+P04hloDBFpLxbrcXhn62P/2g0Hq1KX+Ha//wcl2D6bm0lYGP71hUGsrjn6Hm
         TNb8gdaXORuPlNz3n+AHY9Il1BW2iHm+fqIGDv1oqWoinIpnImwxY9FyBj/ehNuMKmG6
         NeiQ==
X-Gm-Message-State: AOJu0YybAJo4m4Fy4R4AcmN9ICaJQZaQcxL4GEI0uv6SdRHrAH/hB2Ob
	/VrhZz8xrtkeH0chUI/qwKLmYfUaxZGpKQEC+GMuTlyL9xviBN75E6Yu+55Adg==
X-Gm-Gg: AY/fxX78UE56JGkjCqALIbrW6kE0X/AYeqPzhRJ0G/uR3R5ACwD2z2uDvggoSQNxoPL
	zQhP1/RZ1v+vRUt4d+PJAnLA+uXEZiX85OZ7RW80XbxwH8XpQkas/YPUw+lbf6oSotSqlP0zB4r
	+Nb8aw0HF33DgxLjY/gprR2wLBXIS+oa5JQbAGlouYKP0QPY9WwgFHtWcGoS1p2CcyIyeb99BIF
	B/XKRAVjRv+8oA0YdQyWVWOnJKSB66BAi0vIztghsz6Ax/jwwiDZAi2y4/xXgXLTMRQIXTmg+PU
	AWspNVPuh6da5AReWN1Z1207/qs4gHRcp80PDgat1e2bPKo44+xIFMuJiZalzmr4/h1D2pJ0Xav
	a5kKt9Fbk6Fmkq9k3MUbZWWjFL/86au8JZzGNQwdHSYO5utEIRrcoYqPBUV45perijSMr/ol/mB
	maYLz1oQ7eFfrWzg==
X-Google-Smtp-Source: AGHT+IEaIrx59ImEgN04V21oc6d6COS6PffwChfyc71J8YcEt1UOloXcICg+ZQlJklsEE6XTOvxfDg==
X-Received: by 2002:a17:90b:4a09:b0:340:25f0:a9b with SMTP id 98e67ed59e1d1-34e921f4a50mr150649a91.33.1766080607955;
        Thu, 18 Dec 2025 09:56:47 -0800 (PST)
Received: from localhost ([2a03:2880:ff:45::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70dbca5fsm3056423a91.11.2025.12.18.09.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 09:56:47 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@kernel.org,
	kpsingh@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	haoluo@google.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 15/16] selftests/bpf: Remove test_task_storage_map_stress_lookup
Date: Thu, 18 Dec 2025 09:56:25 -0800
Message-ID: <20251218175628.1460321-16-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251218175628.1460321-1-ameryhung@gmail.com>
References: <20251218175628.1460321-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove a test in test_maps that checks if the updating of the percpu
counter in task local storage map is preemption safe as the percpu
counter is now removed.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../bpf/map_tests/task_storage_map.c          | 128 ------------------
 .../bpf/progs/read_bpf_task_storage_busy.c    |  38 ------
 2 files changed, 166 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/map_tests/task_storage_map.c
 delete mode 100644 tools/testing/selftests/bpf/progs/read_bpf_task_storage_busy.c

diff --git a/tools/testing/selftests/bpf/map_tests/task_storage_map.c b/tools/testing/selftests/bpf/map_tests/task_storage_map.c
deleted file mode 100644
index a4121d2248ac..000000000000
--- a/tools/testing/selftests/bpf/map_tests/task_storage_map.c
+++ /dev/null
@@ -1,128 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2022. Huawei Technologies Co., Ltd */
-#define _GNU_SOURCE
-#include <sched.h>
-#include <unistd.h>
-#include <stdlib.h>
-#include <stdbool.h>
-#include <errno.h>
-#include <string.h>
-#include <pthread.h>
-
-#include <bpf/bpf.h>
-#include <bpf/libbpf.h>
-
-#include "bpf_util.h"
-#include "test_maps.h"
-#include "task_local_storage_helpers.h"
-#include "read_bpf_task_storage_busy.skel.h"
-
-struct lookup_ctx {
-	bool start;
-	bool stop;
-	int pid_fd;
-	int map_fd;
-	int loop;
-};
-
-static void *lookup_fn(void *arg)
-{
-	struct lookup_ctx *ctx = arg;
-	long value;
-	int i = 0;
-
-	while (!ctx->start)
-		usleep(1);
-
-	while (!ctx->stop && i++ < ctx->loop)
-		bpf_map_lookup_elem(ctx->map_fd, &ctx->pid_fd, &value);
-	return NULL;
-}
-
-static void abort_lookup(struct lookup_ctx *ctx, pthread_t *tids, unsigned int nr)
-{
-	unsigned int i;
-
-	ctx->stop = true;
-	ctx->start = true;
-	for (i = 0; i < nr; i++)
-		pthread_join(tids[i], NULL);
-}
-
-void test_task_storage_map_stress_lookup(void)
-{
-#define MAX_NR_THREAD 4096
-	unsigned int i, nr = 256, loop = 8192, cpu = 0;
-	struct read_bpf_task_storage_busy *skel;
-	pthread_t tids[MAX_NR_THREAD];
-	struct lookup_ctx ctx;
-	cpu_set_t old, new;
-	const char *cfg;
-	int err;
-
-	cfg = getenv("TASK_STORAGE_MAP_NR_THREAD");
-	if (cfg) {
-		nr = atoi(cfg);
-		if (nr > MAX_NR_THREAD)
-			nr = MAX_NR_THREAD;
-	}
-	cfg = getenv("TASK_STORAGE_MAP_NR_LOOP");
-	if (cfg)
-		loop = atoi(cfg);
-	cfg = getenv("TASK_STORAGE_MAP_PIN_CPU");
-	if (cfg)
-		cpu = atoi(cfg);
-
-	skel = read_bpf_task_storage_busy__open_and_load();
-	err = libbpf_get_error(skel);
-	CHECK(err, "open_and_load", "error %d\n", err);
-
-	/* Only for a fully preemptible kernel */
-	if (!skel->kconfig->CONFIG_PREEMPTION) {
-		printf("%s SKIP (no CONFIG_PREEMPTION)\n", __func__);
-		read_bpf_task_storage_busy__destroy(skel);
-		skips++;
-		return;
-	}
-
-	/* Save the old affinity setting */
-	sched_getaffinity(getpid(), sizeof(old), &old);
-
-	/* Pinned on a specific CPU */
-	CPU_ZERO(&new);
-	CPU_SET(cpu, &new);
-	sched_setaffinity(getpid(), sizeof(new), &new);
-
-	ctx.start = false;
-	ctx.stop = false;
-	ctx.pid_fd = sys_pidfd_open(getpid(), 0);
-	ctx.map_fd = bpf_map__fd(skel->maps.task);
-	ctx.loop = loop;
-	for (i = 0; i < nr; i++) {
-		err = pthread_create(&tids[i], NULL, lookup_fn, &ctx);
-		if (err) {
-			abort_lookup(&ctx, tids, i);
-			CHECK(err, "pthread_create", "error %d\n", err);
-			goto out;
-		}
-	}
-
-	ctx.start = true;
-	for (i = 0; i < nr; i++)
-		pthread_join(tids[i], NULL);
-
-	skel->bss->pid = getpid();
-	err = read_bpf_task_storage_busy__attach(skel);
-	CHECK(err, "attach", "error %d\n", err);
-
-	/* Trigger program */
-	sys_gettid();
-	skel->bss->pid = 0;
-
-	CHECK(skel->bss->busy != 0, "bad bpf_task_storage_busy", "got %d\n", skel->bss->busy);
-out:
-	read_bpf_task_storage_busy__destroy(skel);
-	/* Restore affinity setting */
-	sched_setaffinity(getpid(), sizeof(old), &old);
-	printf("%s:PASS\n", __func__);
-}
diff --git a/tools/testing/selftests/bpf/progs/read_bpf_task_storage_busy.c b/tools/testing/selftests/bpf/progs/read_bpf_task_storage_busy.c
deleted file mode 100644
index 69da05bb6c63..000000000000
--- a/tools/testing/selftests/bpf/progs/read_bpf_task_storage_busy.c
+++ /dev/null
@@ -1,38 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2022. Huawei Technologies Co., Ltd */
-#include "vmlinux.h"
-#include <bpf/bpf_helpers.h>
-#include <bpf/bpf_tracing.h>
-
-extern bool CONFIG_PREEMPTION __kconfig __weak;
-extern const int bpf_task_storage_busy __ksym;
-
-char _license[] SEC("license") = "GPL";
-
-int pid = 0;
-int busy = 0;
-
-struct {
-	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
-	__uint(map_flags, BPF_F_NO_PREALLOC);
-	__type(key, int);
-	__type(value, long);
-} task SEC(".maps");
-
-SEC("raw_tp/sys_enter")
-int BPF_PROG(read_bpf_task_storage_busy)
-{
-	int *value;
-
-	if (!CONFIG_PREEMPTION)
-		return 0;
-
-	if (bpf_get_current_pid_tgid() >> 32 != pid)
-		return 0;
-
-	value = bpf_this_cpu_ptr(&bpf_task_storage_busy);
-	if (value)
-		busy = *value;
-
-	return 0;
-}
-- 
2.47.3


