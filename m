Return-Path: <bpf+bounces-49238-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 961D7A1598E
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 23:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8F3B166280
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 22:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF5D1D5AC8;
	Fri, 17 Jan 2025 22:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lEGIy+uz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B3D1D7E33
	for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 22:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737153482; cv=none; b=TgoQ1hDFPLa2HCzAH+nIQUAcskzi0wwYLq8pfa7+IzV3j88qZpGYOEUYDYVQy6ZI3D4i3jrHZIX9v9E/4x4XuJUedmaLNgkL4r2+4nmpXrkpM4Y0VxcmR/ahFtsf5pE8j7zCziSbndnOQ23oW7RSm1RP8GQaswi10EOQLYYCJIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737153482; c=relaxed/simple;
	bh=YlbGQWxxLy95uWdiAGXfTzD+HyWTMJrS021PkJ9EJZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ux/5zOvsvrdcl0RqlalLQrL4J8ogLnBaYXb/k691c+gqmXrN0boPK5JTX9b7T2K4C2cGZmkisnXBOPboEJCx0O8ns0aEehmbL1pmXcfr+3ZlTjT3OqWPUxfSyQwuSPCwzZUaYYWqu9kHjy0irEWMYpXWtxPD04w5oMTRkCQELIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lEGIy+uz; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-43626213fffso22837555e9.1
        for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 14:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737153479; x=1737758279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jVFDdkIC3IAB8oC+IVD6vJR4uhmFp7lH9ErJ2Cb7bs0=;
        b=lEGIy+uzhZZvFFlEWg26b5YHnDG/1w97nIJOEBJUGm8sV4gVX5turpS7hzk4jY5Qhh
         b9wUu3rxRsv2+ktrDRNLDwD0TSf5GOgrDAIGe1L9CBtra/0G7/bDyHbkTNddvRhygupf
         eb9Wjnus05lX9QhZhgNptAqz45CMEPbnIyKiFGF+t4jcua8/ylyECqoyGcIVRLUuuiNb
         QRRXpjrCELN0M/RDCaQfDgwrX8JQ9RukrhS1W7PMW4spX7v5gRDVVWenGkXsR12Rse9d
         fX7Up9cOqVf1HGC9PTIczuqQjgu0bdSNY/0MQ1DXTK8j6KlhEWrw7/SKCavKvpQ8s1oP
         wRpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737153479; x=1737758279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jVFDdkIC3IAB8oC+IVD6vJR4uhmFp7lH9ErJ2Cb7bs0=;
        b=Dl71H94bVzAe03Tk1XqJyjLGJBD+OhqcYtl+8ACvVPlzcWBOHQy0lfrwyYp6pcLYQ2
         JatYNZnRcAiMWC1SwZKtt68toNolx5FEInOPDVmx1/+3tjjZcEo3tX/g8ThmOt7hkTIr
         GSGw+MKVl9fCnq/gqw1EISeFElD/9LnCB7KblfLErCZsOWUma+BT2bSB3fYcJId4oqw5
         ey5ch46Etdr2diX28aXrZqnpOQ6TSE++2i/Uf+2Vyy8b1Q1Rr/1cUB/Km7JELnk5Wswk
         rCGPbBppFTA5sY/YtcvyIgo30AE9XnbSHhlFFhsvExdjSGj0G17arwXvcUZ+v0G7vW6v
         x80Q==
X-Gm-Message-State: AOJu0Yy+o2T4SwltWw0DW8is5eYxO6U1KkgjNofecVsCHitPENlBEnCm
	wW3HUBDYu35JbZ9U1gfFFAEZM8imTeV4DvkhuR1zJQUemNDpruCkQfWyhV4EWEo=
X-Gm-Gg: ASbGnct23imD1SEhjGAskkKjHyAsuOjTLliILOiDzWeg6jotaYoVSJMp1HOmmceTfs9
	szPrPm+/PPAmVNV9FVYXyF/1vCz86o7Iya28t0hzva8c6yOiNEEVKRVQ8fLNK+rrdtix7gin044
	2cjRa0OBAYu+gxaho+KX5iBh/cU/TTKeoVn/ZgvMGee42UxMvM+ntGRfZC39RgBSzJp8x+tNBFc
	CwrnGzkGiy4UAyVuG7LWNnwPRtKv2P5e1vg4iQI+nJNrHqMUr+0Dii7b7fE
X-Google-Smtp-Source: AGHT+IH5A1Q8EbEYIZ0b2jiAAYAvFwjfs6N0qmiNUnENuBfV+F+N3YQAnzkHFX/jToWeDUepFVqmKg==
X-Received: by 2002:a05:6000:156d:b0:386:34af:9bae with SMTP id ffacd0b85a97d-38bec4f5fbdmr7105247f8f.4.1737153478467;
        Fri, 17 Jan 2025 14:37:58 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:1f::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf3221db2sm3508738f8f.29.2025.01.17.14.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 14:37:57 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Barret Rhoden <brho@google.com>,
	Josh Don <joshdon@google.com>,
	Dohyun Kim <dohyunkim@google.com>,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 2/2] selftests/bpf: Add tests for qspinlock in BPF arena
Date: Fri, 17 Jan 2025 14:37:54 -0800
Message-ID: <20250117223754.1020174-3-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250117223754.1020174-1-memxor@gmail.com>
References: <20250117223754.1020174-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4015; h=from:subject; bh=YlbGQWxxLy95uWdiAGXfTzD+HyWTMJrS021PkJ9EJZI=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnituwbUpA5HduGwvzAkqSkMOUdTlzWEzbQTW8OOWk fvAzkVGJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ4rbsAAKCRBM4MiGSL8RyqilD/ 9jcxO9bfyUTASWYtyayIkFFULWjzROpIN4fvneB1lmVYUKyXRjiiNxJKV8Zme8DC+hZRU47FKUT9cv CcW3VCixAiKDizMGOWDJR0TmhyLrZz3rZ4xeZS4GcAded1gDEyErxykOvgw/QtTkkjE09c3wdrVrLK Qi1tHU09qw9r5lGUG/4t0KC8gYucB12zYuvM/DNnWgUA6sB8HB6ENXDogIDChwm8ks2pIzwTntFgeF cFZxSKXqKCYJHyi7/Mg3D1UF74xlG3iuJYgXmSDdfPGHZe6GdFv/GVo8UEZgM1QZnvclIXxi8hHkNe 1AKKC+HkS3MXda6B3uxg9xZiRwtBzKlF1dg6WciFy8Rko7g7whv7FajkIV5eYrxiMh9LrRhwD+K3Zy hp5YUNjsUzY/rqcwiSNefOMrHuPPnAb1A+xvELjzOFxu5fEPLDrRxaQa0la2wx5V8NgZX3rNaB9gwG Dvv6AwSxg5+q4AgSu8xhLHqv6jzCiAGUtzVxVga//916gdOz6At0fi/qOqkLRU+NrhUvAxb9YHoBbm Inb5v5XyInEN6w04sOrLljhCnR4g9+uxdbNM7tV1EpJlGcGEmGaJMINpcNHjkFfZIvIetvGn/8cdSY i4dK3ApTtfCQ2H/FzCNSgy/IH+qtx00H6DV8w2FRAadynI2uyyW0VFv11iWw==
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
index 000000000000..4f86774fa058
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
+struct qspinlock __arena *lock;
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
+	if (queued_spin_lock(lock))
+		return false;
+	WRITE_ONCE(counter, READ_ONCE(counter) + 1);
+	bpf_repeat(BPF_MAX_LOOPS);
+	ret = true;
+	queued_spin_unlock(lock);
+	bpf_preempt_enable();
+#endif
+	return ret;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.43.5


