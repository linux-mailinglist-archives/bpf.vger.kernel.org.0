Return-Path: <bpf+bounces-53450-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 914EEA54176
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 04:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEFB47A7479
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 03:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF3E19C574;
	Thu,  6 Mar 2025 03:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJ7MAbx+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD2819C540
	for <bpf@vger.kernel.org>; Thu,  6 Mar 2025 03:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741233285; cv=none; b=T8pyapVvIJ95BrhhF9MSjrpywAoZBcBmlDz24anc9aQg4zrq+WAIxpFtZtdJvDgQzjStU9Fg9BVqv2vAYWryJ/TXi1/k6g9tjrF+xjCOUrIsIFUpVCH+kNk8fCKbrC7m3cTwTw3Pg9wH5jgSQiwcyXoimwEWyq7eg1wGt8BYXMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741233285; c=relaxed/simple;
	bh=ruwllVcxVR8hL7pZvqgC0ju7e3nf8kxM438AdoWXkZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YCt/pROd/TLwetZ0qsR1s1GCmX78locZSJg30GmADcJLZT7ISi/RXJkU/gtwGz3s41xYrVpWdtkR30nFdPSvP+sBaoV4x10Vn9aoDRNH7ElgjWVgacd3u/maYUrvxWgk4+vOP9dI3OKQVdDEgEsmckp+ugMb97NmdKRhWewUOMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJ7MAbx+; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-43bc31227ecso705945e9.1
        for <bpf@vger.kernel.org>; Wed, 05 Mar 2025 19:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741233280; x=1741838080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sz1udnkrVf7H1EVKSlcz18+3nTTqlgb9md15hm7hieg=;
        b=LJ7MAbx+1mNNf20bnGYXugKa1kKpGXUNwTK6Vc6xwlO/hdGhs+lClV4AeR6SAItfZL
         whVHe63LWdLMzGNaN/dqv+NxUt0a/DpaOD/Iedm2bUMs3ZU8AKuNwSyINux+PkKgzPxd
         3fAx69KepoVw9lf8YnUuovTyxrPyTqy8Xl74UDUQqVV/B9DRm/s61qgm2lhSFHe8o2NJ
         5Epf87+PmFgRrHudLA9UURKwD4Rv2n/BLrnuRKywD7A86hokMbPqZm/XEN4c5lf/gQwL
         raZfDQylgjCSU2OA8DIZ+6OwG8nmDjOIQR7J2+//d2jbicklpRK8+ZrbmDBS8vB4z1xM
         /v8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741233280; x=1741838080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sz1udnkrVf7H1EVKSlcz18+3nTTqlgb9md15hm7hieg=;
        b=OzyJT4xSy9HwpR6rnww0/Q0lZ8iT4NJUFg23WeYea4mshzryC0hI1g0PSbmo74Hlwj
         7/gqVaM2Z7Oa/N1b9zPa84zKwiBzV5+v00ofcD2UZn2IBoXwlMm5QD8eIXggiuBQmlkK
         BxSgLgyIFgJURHggemYNk/BUHGy9IXmBjingLKgcjgqSNgdgRmZKNccMFxVMxClFjJth
         FWnSG39F1fq0ip5YXeEAwc/mrpMvECqg8KXlR1xMYbZxiORcafP2LmZrA5h4/GVbvgKW
         ACRxvNu+BkewaKaOGS7SQfhQ5NUVFKYk67HIkdPm/T699BgaaRyPz6KaNi6RpEwLmd3H
         h5mQ==
X-Gm-Message-State: AOJu0YwecHpTp1H8pYeYZrVgct90/NGlZngr0XNhv2Hq0sU6CImTMrnM
	DzXIjE93x4/hU4+EiS75PV8OZ3KkK+ysVQNt5CboOjNwUK/Eic0Vc+lU+5yTY1o=
X-Gm-Gg: ASbGncvbwiUDgXjFH9iXkYeXdwI2vXQuKIseuEgL4DFe340Q2NpIun+AmiBUjol6qgz
	v+fK2gszfiR8hGwIM0gE3JaAgYKcd1c/LkhPiUQUHDj+yJMu36cfqhx4EZOfUpIoc9RGesRA24z
	TIFqM+AE82MT8MNaLrCE+wWjg45EHgzLVrhbgjOjRG5GtnNObTGkIVx+IjMw2S5wCgX/hF4QSrA
	GqeNNQzEHfqbhIVaVA3yTVfYqlYMLzjKA5WboJJPEvbISNec2nVdZjdtM3mQdg7Z4gRFj9wuaxP
	U/3+WMDw9DVnFXk6sxBsFDPnYLt2cUCw4Us=
X-Google-Smtp-Source: AGHT+IH/m4LMrbzqGX+Wi+gEqFbYlpVHelphUQBPJddZQ0fnBxlJePuyLTGK47vPWGPH25es+sLwSA==
X-Received: by 2002:a05:6000:2d0a:b0:390:e8d4:6517 with SMTP id ffacd0b85a97d-3911f740ccamr3653881f8f.21.1741233280036;
        Wed, 05 Mar 2025 19:54:40 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:48::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0e2b6asm556692f8f.66.2025.03.05.19.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 19:54:39 -0800 (PST)
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
Subject: [PATCH bpf-next v5 3/3] selftests/bpf: Add tests for arena spin lock
Date: Wed,  5 Mar 2025 19:54:31 -0800
Message-ID: <20250306035431.2186189-4-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250306035431.2186189-1-memxor@gmail.com>
References: <20250306035431.2186189-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5069; h=from:subject; bh=ruwllVcxVR8hL7pZvqgC0ju7e3nf8kxM438AdoWXkZ8=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnyRLAlOXcH90ljv5gtq6dUVqpXpdbfWdwl4gw0onq P9LtKZyJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ8kSwAAKCRBM4MiGSL8RysI/EA DB94Ih+0NetzrukimHRDdyBBiMWwt2b+iR2NHF4mCYvcVyGrBxv68JdhTHKBtrdYy8dFpk8L6v7y0w 69TPNz7LCXxzZ6FMcbryZppp96EslrQT7DmdoZ+KOQvEn3cJb0GtdMwAN2QXxIegSCjn41+q0KHYFU vOOtofTebB6Ig1n9ZPKrNpMhHfP+6bnJtr1+35M50zQa+xsSNmWna/fFPiCT3445O/Bbk2dpmWpCYq NIVspr81pTFZVOkrY0n8YPgXv9te715XxCWdgTHA2sCO/mOhUlMvAlcvjEWd5oBKlqxwq5igSRAG7A g18UkxaZ5R3EUhGxGcPHXCALg6tDBBgUbrKSrVks9NRbDv2qO4P/mlYb0AiF/2eX6a6+RjuwEi7Tsg /AilnkwlDu0jczfgCyPCmZXmlzv3TdkTY53a2R9SpRhtgzeEDjB3abEZ/gY/mLLZ9O1U5obro8LQe5 Scnj5KKw+rHjDPQZwofhFPYMrrE6wYzQg5EUfR8FtXucTu7X323lKWJIpAcJ3bN6eYWRTZ3K5akVdL HGCz3TkJTAXLR9SeiWv4k+Y1dbTvjQftOHueWSc6MO67OWdkMka8Ff0mwE/GK2Wfpt8GeghTX9gVtb +tSHkzKDdlaQd1gO8v0BRXxumr2OKLjVCc6Mq0N4V53mDROrvG3FZsXMB0cw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Add some basic selftests for qspinlock built over BPF arena using
cond_break_label macro.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../bpf/prog_tests/arena_spin_lock.c          | 108 ++++++++++++++++++
 .../selftests/bpf/progs/arena_spin_lock.c     |  51 +++++++++
 2 files changed, 159 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_spin_lock.c

diff --git a/tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c b/tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c
new file mode 100644
index 000000000000..bc3616ba891c
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c
@@ -0,0 +1,108 @@
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
+static int repeat;
+
+pthread_barrier_t barrier;
+
+static void *spin_lock_thread(void *arg)
+{
+	int err, prog_fd = *(u32 *)arg;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in = &pkt_v4,
+		.data_size_in = sizeof(pkt_v4),
+		.repeat = repeat,
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
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_run err");
+	ASSERT_EQ((int)topts.retval, 0, "test_run retval");
+
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
+	skel->bss->cs_count = size;
+	skel->bss->limit = repeat * 16;
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
+
+	ASSERT_EQ(skel->bss->counter, repeat * 16, "check counter value");
+
+end_barrier:
+	pthread_barrier_destroy(&barrier);
+end:
+	arena_spin_lock__destroy(skel);
+	return;
+}
+
+void test_arena_spin_lock(void)
+{
+	repeat = 1000;
+	if (test__start_subtest("arena_spin_lock_1"))
+		test_arena_spin_lock_size(1);
+	cpu = 0;
+	if (test__start_subtest("arena_spin_lock_1000"))
+		test_arena_spin_lock_size(1000);
+	cpu = 0;
+	repeat = 100;
+	if (test__start_subtest("arena_spin_lock_50000"))
+		test_arena_spin_lock_size(50000);
+}
diff --git a/tools/testing/selftests/bpf/progs/arena_spin_lock.c b/tools/testing/selftests/bpf/progs/arena_spin_lock.c
new file mode 100644
index 000000000000..c4500c37f85e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/arena_spin_lock.c
@@ -0,0 +1,51 @@
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
+int limit;
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
+	if (counter != limit)
+		counter++;
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


