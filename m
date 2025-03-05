Return-Path: <bpf+bounces-53266-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFEDA4F35B
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 02:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83E9D3A6DD7
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 01:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5494661FFE;
	Wed,  5 Mar 2025 01:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjcDhr/L"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1247222338
	for <bpf@vger.kernel.org>; Wed,  5 Mar 2025 01:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741137539; cv=none; b=tALnrlu/wg5G48tfQEjF8NOXwtLHBrGoJuAJH+qySNaHD45o0UrDamYOD+pPzn4bXAYjhps8qvTi1SxrmYctGFigMhS4wPlZ86pclE21SKxSonY1mOte95QDbu6o7W2dDGTPNuuml6tQdS5tdSiTAtnH1hLUcQmyX6rqDFMvOog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741137539; c=relaxed/simple;
	bh=AroAmV2UBkVo+WlznhFvO42yG+sNDlz0XWG8UpcuWpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tYbuJVVANX7ExDGrIJJjF/WRheKnGzG4qk5Ug6kfRijICyJYZE7nNfrTmii5g3PykCmgyij4WvuesuboiRnJ3fnLiWqHVeZYDJXavDkdKEnC94Wr6wVeIzFc/KjSRlgbM+Yfhxq/srA59lMrA3ihJEZkPyXpNmS6IPTWpM87+CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CjcDhr/L; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-43bcb1a9890so1898685e9.0
        for <bpf@vger.kernel.org>; Tue, 04 Mar 2025 17:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741137535; x=1741742335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sd7CJq8HxV9MAWgO7GVWaB4lzcuPwgxmq34hTfIGUuk=;
        b=CjcDhr/LZS2AmFFypR5G6Ub5UsjrPGtscrxhkU7PaoLoKEmPAdjmhz4y1kS8fSPXem
         vm9WEO23VHcNKht0IswJiENOZa+qjMhdrg5pifLTGr5T62sDHCAb3lsvsP/J3cuwS4Kt
         rp5k6EonS19oA/LJt0j79/4HGuoH5lwRNu0BbgXbSQYWhw1iBQTnISSY905o+uU0XQMC
         x/XJcehbUHa4mFQjvh4EpqAUceJaqjqa95sP1hLJ3U2SQEQgyFb3rLrev0E/ZyhksUt5
         5Vof6ZJNSD9grhC3CxzP6pboGxJuyx5pwOj2QMqbI5IbzpH/zC1QPfpafS9b7ZrGn9Az
         QCxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741137535; x=1741742335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sd7CJq8HxV9MAWgO7GVWaB4lzcuPwgxmq34hTfIGUuk=;
        b=S/Kg9/ZXqCXcg/5zSTYGVCw6LNJdj0g53entJ0hLdUejkQbRx7LSDZh1PzwALdxe1M
         neuOXCG0mWwl7vqj8PG2m6TBBKH3aGb0/k6b8iJYib/W9lFwjPgC4kHOAMICOCiwWFcA
         alt46Kaud9COod0VW0aCPDlxVcZsjw0Vb+toNS9UKStCnlo75JGLsadbmWwHK6fb4c6y
         5OU8SdQ/mgltQ1CmHK1zVCQJiGIvAbgja4EMeNl6Su/OSmCNqh9ecQJwnqcTr8452fn7
         0tG3f9U955SlxOGuu1yCexgBSe6psIfC4BjUJKExzJj/tsv+nYO6aenkqdLV5Yp4+6UF
         06Mw==
X-Gm-Message-State: AOJu0YwkXZCHtnnzeqwy35tP9k6gbFTVJa18Y3uBfxbKhCQwMbt8/5Sx
	gOTuk97AoGYOJahpJxz8m0HYfR7FMpfg2UUtzZXaY07w/IKLsNqqy7jSaSTUzJ0=
X-Gm-Gg: ASbGncsSsfKHK79nKK9MgcQ1gIZb6InulP7tGaWZnKO3lv7+a3Gbg6nzmocR5qfe9Im
	ZnvY1jo7fYHPeYFSJEOdJ/rMIN866f84rHc67/njtB3wjFASZUSVzxlhcELmX6tuEsuxi9QmT1z
	0jHlYu0PQav9ayreWftl4Xw8yi/9/07l02+8oF0kL1gWTwhU+2WRN3pfuT4VpVB9JjXKe2kZtnR
	UvVejRtOdx+uvVpFmZIIAguSPWdIZ0UVgQxvdMZMzKBrtYe75l2zDNiL1dqfth7ydYrF5NVjHqS
	X1hcDscjgfPbXItQH+U3Oq64m/mXpSlYeg==
X-Google-Smtp-Source: AGHT+IHaCf+8JROeT5x9gIelpfad9AcwgNGeOtgkNvCYSW6UDFN7F9cnFqFwPhVJcDfsUnUywG72Gw==
X-Received: by 2002:a05:600c:310d:b0:439:9737:675b with SMTP id 5b1f17b1804b1-43bd20b5147mr8523875e9.7.1741137535216;
        Tue, 04 Mar 2025 17:18:55 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:2::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd4352ec1sm1763305e9.25.2025.03.04.17.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 17:18:54 -0800 (PST)
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
Subject: [PATCH bpf-next v3 3/3] selftests/bpf: Add tests for arena spin lock
Date: Tue,  4 Mar 2025 17:18:49 -0800
Message-ID: <20250305011849.1168917-4-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305011849.1168917-1-memxor@gmail.com>
References: <20250305011849.1168917-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4934; h=from:subject; bh=AroAmV2UBkVo+WlznhFvO42yG+sNDlz0XWG8UpcuWpk=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnx6ZypoX98KdqybNh7KGzTwL0h2nK3zJ2w/LJ2dDM xhBf1w6JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ8emcgAKCRBM4MiGSL8RygdzD/ 0TsXj9b86orEAZibAOrVf0WdF/iMMs0jLNpfkMGNbiM1CQjwaC3fPHPqPR3ZLMxlbK6733K386enLg VgOIb+C1vwn7WvXsdPABs/7etwythcGotTA0HK79X92VGPmYRiXV3FvZ61icLYr6Nv2LDk9BxqGfdE uSngAh+GunwBERzHf1x2qE8Uu5fsoUlq9jc8yN/ZtKef9K5aIN0ksSzyA0mPFMEhaVV2PWCI34DUhd 3iOh7FFuUqfNrpn747dufx/BiVY2WInngSdunQF4d989reySE3ijxQPidChlKcae8wo/oBxcpM3aL5 Mn8ygANK+eckdBjZDCLGqBi1NEsNYUna5QO3CbujHmN8+xGVfhdVyhbcj1I7Ed+PFTnaeym1WrocPZ S1TROd3HYgPcrtRYdvzNrNkkX4RXI2Kejj5zuMy4c89IFtVpapJZv5GxNqaQ3RZthCPpT7DK+DgABG 6rw287wfEXeKRZl83kX1v/TyrAUfUUwLFD9rTJYVmHnWPBBRL1TIIMfxeoRMe1AAXVKIloZVrX3hkB Ijd3EPGhZPgTWoyOII4GAdJCSK5V8h64GW2xK6gSqnf1o2Mb/mLsRpL9+uQsWLs92JAojEoRxlRDly au3wb6STnRI8EJyMXdq1j1UTwZQNOqP25YSCqvoXDDfpZLFQu1oVV114tbLQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Add some basic selftests for qspinlock built over BPF arena using
cond_break_label macro.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../bpf/prog_tests/arena_spin_lock.c          | 102 ++++++++++++++++++
 .../selftests/bpf/progs/arena_spin_lock.c     |  51 +++++++++
 2 files changed, 153 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_spin_lock.c

diff --git a/tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c b/tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c
new file mode 100644
index 000000000000..2cc078ed1ddb
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c
@@ -0,0 +1,102 @@
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
+static void *spin_lock_thread(void *arg)
+{
+	int err, prog_fd = *(u32 *)arg;
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
+
+void test_arena_spin_lock(void)
+{
+	if (test__start_subtest("arena_spin_lock_1"))
+		test_arena_spin_lock_size(1);
+	cpu = 0;
+	if (test__start_subtest("arena_spin_lock_1000"))
+		test_arena_spin_lock_size(1000);
+	cpu = 0;
+	if (test__start_subtest("arena_spin_lock_10000"))
+		test_arena_spin_lock_size(10000);
+	cpu = 0;
+	if (test__start_subtest("arena_spin_lock_100000"))
+		test_arena_spin_lock_size(100000);
+	cpu = 0;
+	if (test__start_subtest("arena_spin_lock_500000"))
+		test_arena_spin_lock_size(500000);
+}
diff --git a/tools/testing/selftests/bpf/progs/arena_spin_lock.c b/tools/testing/selftests/bpf/progs/arena_spin_lock.c
new file mode 100644
index 000000000000..3e8ce807e028
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
+	int ret = -2;
+
+#if defined(ENABLE_ATOMICS_TESTS) && defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+	unsigned long flags;
+
+	ptr = &arena;
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


