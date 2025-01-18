Return-Path: <bpf+bounces-49262-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD6AA15E07
	for <lists+bpf@lfdr.de>; Sat, 18 Jan 2025 17:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05E73166237
	for <lists+bpf@lfdr.de>; Sat, 18 Jan 2025 16:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12E21A00ED;
	Sat, 18 Jan 2025 16:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kD2L6D/k"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE33619CC24
	for <bpf@vger.kernel.org>; Sat, 18 Jan 2025 16:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737217366; cv=none; b=MAbGZ6SXdkGOWWs5dzt1C9GjHg9FPi7zxVrPYI3G/88BkI6HN0WB0C6NdvtOAvjsus+nwlH70Oye71KczLTjL3o6Igm6dZWLNt+hwpmDFrdQRD0wZOjl/9tvT6HkHbeeCNnHVwtzXyk/fhRIjf70Qa60/P0wwGza2c55grqwQrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737217366; c=relaxed/simple;
	bh=CUyZhJYlTouMZbyOLgIIPbU56uupjMw1ya4K5IFMWAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RIlwZHvy0U3i3E5o2pBvMupJ64yb8znsEbGAQMAViD1cXThkoj2UQvWe8rJN9c/siEm0/RS8mwYS02o5qBYxEp1aD9uY5PNh6DAfjBFCESA9p2DPJZ6hvJnOgs1G/mnl+9ypjUkQ+1Wy3q+5/mirsh+cW8IbW9nvt4vdqJiHeo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kD2L6D/k; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-385f06d0c8eso1627665f8f.0
        for <bpf@vger.kernel.org>; Sat, 18 Jan 2025 08:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737217363; x=1737822163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WY596I4mUbXIZXZ6hkwQcqwDjVsI+g4PVULXv3A8iNs=;
        b=kD2L6D/kjI9chMhKBk4BzRpppxCeoZ8/j9JEoTkIQrca4YbmcMytf3sOVRZU2eU7+u
         yVbla82jHZ59kC4XOkntJPTHtPTWWh6K6o741U6obVElbw+s7JCt6SXFLU6ej/MZzeth
         QZJ7YInHz+FTDR6i/UrUxoTa0Ou4yFXk8HUCkbZQIE7WeXgdtqitTMaysffcOuZSprvX
         /6VeGdvCyiLJoT569JrsfLRF/1NcNwO+4TMJevlRB6KaGcMCC4jnEw4Yan/wfG7bLBgg
         DBsUzDo5r+6rFI2np77kgWcaN128mOXFeugLPSwJoBlJeJgc6dB/5O4lk+XoogI55Cfn
         oK6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737217363; x=1737822163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WY596I4mUbXIZXZ6hkwQcqwDjVsI+g4PVULXv3A8iNs=;
        b=oKINac4iGCbLmzBTXF1yBVbMej+ByRlHtuYVjr33yl59dBx3u/odCjFIf1iC4RXMmE
         4Ya5PH2evDS4zatSfqo0zs74bJLdVVVuusZwl5OZVBXDjVcqtZMxwZ4wYjWYsygUr1p2
         s0832B89NXxvVEP3ZOTaGaro8JAD0x4GIm2HmpIAevVtDTNDOeXsOAa44rccV+yMZCFQ
         6iYPFM7x1QQ/JrWA3dKlBKP0GXjMaZbGnEdxYF4Uf6ryOkxPHOGYfWqpuSg7BxwafQn7
         YmoZKE8iQTMM5p1omDcaT4389s1qBrhxXr6Ti0q9pzh+CZHdtu+Gpf64PqQ0BgNZK647
         +XFw==
X-Gm-Message-State: AOJu0YzfuEP3/2gFS9XLZfyqWxS/EiGCExAEm42u1I30wxX6gnwLdsLV
	jzQ+Y3g9o6nLh9cyFgnqZMmeZ4hJd27dct1pBNP0/reMWU6B4h6w9NfZ+7WfBag=
X-Gm-Gg: ASbGncuzwgnLwIKG+a3BUlb3OGKRYvu/lR6YF28nnCtHIKxC1d1kkYmQvqLRJgovlmr
	9F/wFgxocgLIjb/xz0ttCG4azETVJ4aUajkSIEnmlxQBEC0PAqfMKAeBQzSePOjvsRJHpFYiLXD
	0ORDpkOwnN9aq55LS2JUN12K5YoQBwAJxucN8BClodh2cx7POggC3wT54QgHr7RSTBbx80lHiZw
	Hu6183LTUjo3jSTm10INOmheHsk5mVXfnFxkFMCHZzgAphLHvdIlol677c=
X-Google-Smtp-Source: AGHT+IEOVdTj+UmVsWICzNy9C6RFVE5OJ2DP7cfkPLKncfgGDj53Yoc5u8XLm5La61s3sttyXrjhpg==
X-Received: by 2002:a05:6000:4022:b0:385:e013:73f6 with SMTP id ffacd0b85a97d-38bf59eff21mr6509813f8f.50.1737217362651;
        Sat, 18 Jan 2025 08:22:42 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:a::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf32150a6sm5634562f8f.15.2025.01.18.08.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2025 08:22:42 -0800 (PST)
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
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Add tests for qspinlock in BPF arena
Date: Sat, 18 Jan 2025 08:22:38 -0800
Message-ID: <20250118162238.2621311-3-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250118162238.2621311-1-memxor@gmail.com>
References: <20250118162238.2621311-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4016; h=from:subject; bh=CUyZhJYlTouMZbyOLgIIPbU56uupjMw1ya4K5IFMWAM=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBni9T7N/2podKenNyXmkalFPTrqNOmmWj/CNXGce2L JUlq4FWJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ4vU+wAKCRBM4MiGSL8RypnHEA Cz8Xv/tYVf9lL3jcM4t/7gM/Sae9igfA8zSURH2zQYDU9vyFJVVfshFJZnMV8p0+AB1QsEHrvz4d0Y vqvMg6aSiHF7Y7DFkv/DPFp9Kecdhqorwt8ycolWSs7JWyWCU5deXuv54CzQy0yceitCIdwHd62N10 nxZ4wsxuSY80SUBne+u8POJzt9pM5c8rHoqDg9j/xRiH0bZpVY5trfl0soId1XfVmNKz78/dlnIAup YAGa2oxK9a1wZTg17ncppQVlmxvCZbKq8QAlPHb92+LMOUJumw7shZN56F8uhZdsOIUXSI1AqFn3up 2fH15cfWmEJyr8NEfB+SihVawi46iPRAImOqhitsy5xVqUVokIDpqKkAAm1iISvqHxb+601cGUSFtk 9PgoTvIppDTztU0xrVVnPZdd3qUd0YR0+bc9G/rt2nndTWhtqaiKqdMEZJIo8f9GykPV1M9uedTx/t sx4aeSTXwYxYS16C6AxMgDYVRoQ8Gb37692EvKdnGNGsBCa7qmdlEUFZ4RsXtXnFnC88l+rCqRZqEp 54hpnPrYEUCCuH1DYIW5iYHDarRmd6oxN8ph4Bw3MZ6QTu7Zx3FR4z/QrDqLWVEbzoVqM5zNB+bpXV NwzCQQToqAafiNATVhocqr3O9xndohfcAyHLAFcxqJsrzZ3Et+Je5RidyzuA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Add some basic selftests for qspinlock built over BPF arena using
cond_break.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../bpf/prog_tests/arena_spin_lock.c          | 68 +++++++++++++++++++
 .../selftests/bpf/progs/arena_spin_lock.c     | 49 +++++++++++++
 2 files changed, 117 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_spin_lock.c

diff --git a/tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c b/tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c
new file mode 100644
index 000000000000..cd473d9ce764
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+#include <network_helpers.h>
+
+struct qspinlock { int val; };
+
+#include "arena_spin_lock.skel.h"
+
+static long cpu;
+int *counter;
+
+static void *spin_lock_thread(void *arg)
+{
+	int err, prog_fd = *(u32 *) arg;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in = &pkt_v4,
+		.data_size_in = sizeof(pkt_v4),
+		.repeat = 1,
+	);
+	cpu_set_t cpuset;
+
+	CPU_ZERO(&cpuset);
+	CPU_SET(__sync_fetch_and_add(&cpu, 1), &cpuset);
+	ASSERT_OK(pthread_setaffinity_np(pthread_self(), sizeof(cpuset), &cpuset), "cpu affinity");
+
+	while (*READ_ONCE(counter) <= 50) {
+		err = bpf_prog_test_run_opts(prog_fd, &topts);
+		ASSERT_OK(err, "test_run err");
+		ASSERT_EQ(topts.retval, 1, "test_run retval");
+	}
+	pthread_exit(arg);
+}
+
+void test_arena_spin_lock(void)
+{
+	struct arena_spin_lock *skel;
+	pthread_t thread_id[16];
+	int prog_fd, i, err;
+	void *ret;
+
+	skel = arena_spin_lock__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "arena_spin_lock__open_and_load"))
+		return;
+	if (skel->data->test_skip == 2) {
+		test__skip();
+		goto end;
+	}
+
+	counter = &skel->bss->counter;
+
+	prog_fd = bpf_program__fd(skel->progs.prog);
+	for (i = 0; i < 16; i++) {
+		err = pthread_create(&thread_id[i], NULL, &spin_lock_thread, &prog_fd);
+		if (!ASSERT_OK(err, "pthread_create"))
+			goto end;
+	}
+
+	for (i = 0; i < 16; i++) {
+		if (!ASSERT_OK(pthread_join(thread_id[i], &ret), "pthread_join"))
+			goto end;
+		if (!ASSERT_EQ(ret, &prog_fd, "ret == prog_fd"))
+			goto end;
+	}
+end:
+	arena_spin_lock__destroy(skel);
+	return;
+}
diff --git a/tools/testing/selftests/bpf/progs/arena_spin_lock.c b/tools/testing/selftests/bpf/progs/arena_spin_lock.c
new file mode 100644
index 000000000000..ec768368f7f1
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/arena_spin_lock.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "bpf_arena_qspinlock.h"
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
+#if defined(ENABLE_ATOMICS_TESTS) && defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+struct qspinlock __arena lock;
+void *ptr;
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
+	bool ret = false;
+
+#if defined(ENABLE_ATOMICS_TESTS) && defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+	ptr = &arena;
+	bpf_preempt_disable();
+	if (queued_spin_lock(&lock))
+		return false;
+	WRITE_ONCE(counter, READ_ONCE(counter) + 1);
+	bpf_repeat(BPF_MAX_LOOPS);
+	ret = true;
+	queued_spin_unlock(&lock);
+	bpf_preempt_enable();
+#endif
+	return ret;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.43.5


