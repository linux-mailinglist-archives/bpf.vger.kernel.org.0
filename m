Return-Path: <bpf+bounces-72846-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 137A9C1CBF3
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 19:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA02F18936F3
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 18:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C3A3559C7;
	Wed, 29 Oct 2025 18:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ryv0Rib3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D743009E3
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 18:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761761921; cv=none; b=f3VDhCj1slK0teBaMM5ylZY/n9RKD9m3HpuMjxJBiGV/CTUvnHVj1vNoIb5R3tO5uwHsoaNrHYXNpE02ZFPrbJhchvxCLMnFNCxzC+jRnoH6csmeyZPtFzHBYVSJE+LJ9L19+2tNZTHAeTZy4NHLHPPAdRD7aXqp1HA7VJG/6Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761761921; c=relaxed/simple;
	bh=OUNLvyEgIT+n3pX7f3X9MJ4NI5Z+tzd+R9fjqWqq45U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZOlkcqGKxzmggYDwmKMGG1Qv3qux5uF7KkOS9RXlNWwaeEzQ/uDJODdfOtrjd5J6V0pfRxNEWwVb4W0IKpCq+n6u0cdYORzQUUaFI4UASElfA0Xu9OxgtPi5gjmEtYddIjLzmEWfdHy46YWRrRcMijnlaoSu/+4LaA3EMUZv7QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ryv0Rib3; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-475dae5d473so991075e9.2
        for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 11:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761761916; x=1762366716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gG97BqKlGoFkkMhbTTqVAejk+UUGlIlvMdGAenqzqcU=;
        b=Ryv0Rib3cPXU1jrzj/P11w+3jt1CXNzkxtWWm7BhvuWb/7S3zALFZy+iAPV7nLZZS7
         ffazqekxhWv1kBaHh+Mf6tRBJcCYzXizdIqS1/bi0cJdJFhBb6HGZ2lcGgjnjWKY7AUu
         Vve5bx/j7/VYnQzyMQn2xS5n3tGW6SI+MbcCe2laaLfwHtqccER34lvJtLF9s6cgS+7h
         wfhepFavJcmsmehLOvH2o55UYxaJUh0K2ujutG8PQXaTHnG2Wpw7Nhi4nTEZDhWEFm4/
         6eoSXQFwwlmJi0fusmNK+WxGkH8o4t5cr75JG8EkKLXVK5Koh25kNwhAk3eX1uTlSYdf
         7rNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761761916; x=1762366716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gG97BqKlGoFkkMhbTTqVAejk+UUGlIlvMdGAenqzqcU=;
        b=MIXym5P9hvtY+QXVu6YJ6tRD9Ap221OuInXnJZenk5kn4QMnW2fOutoRHt27ZNCnuP
         5FVCscgWACrC91q5DPBlayntwHsMYUBKztRSX2wpvAsN71lh2t+Cq+8bq3dtczIbDu+1
         jEBtl93YW4N1zhcyS+xDxtx8zzCsL6B+p2X2xNMCPCAfNrPfxfszarqhtkcfjXay1onb
         AJXzoM/SbfFJID0rCYMXb3WuOLIXM4AWHZ73PNgIg05pL96Wxc46QDMijN0KjxL7Dcjv
         zmy36XFXn/O6hGvXZZDfMDuZY/lhj4ehd0hE7Y8CRJNDJHydcyd+KpMKLtH1dN/+/kga
         NCjg==
X-Gm-Message-State: AOJu0YwQXnUZVvkUw/VgdbtDrb2Baab+IUocVD0psz80E8XCs5Ihk8j+
	SmHB8Ov/LDgKQlFTSTVpdd8bovisRbbI/eJmh2NqCACifUUg135yIEZCxuK4htK8
X-Gm-Gg: ASbGncvPm8/5s4C9Afk3Ptdknv+0SLlmGU7Or3/hIciIdEfivGwdViIVQVAOWIalqMS
	gbTjICv0u9EvQS7/V/LOcIEw9pxEUrWQKPfxySm9DuDetDsRelR6FX3EZOTqZSs3rXknO4aaLI7
	Dh8NTQ6xpK7/+vlF5zyDwfu4cBrtqN5QrWGT3zZylp49r1vroX3khOwF6QDIW8qnCAYr3xJcJy1
	VadZxvS9KMBu+rqJ5quxgB/Z5ZY6Vn6cSzfcBnlxc+6IiwyQcZeCv5mM3BJBWxtADasUb/i+E0E
	y4D4RdXYWvY53n5J1uv0G1n0Ho3NQGGT2lnpLgubJgzTj6yjYjg5f5mqVywElPQdW4f+E3zIGn6
	FjeLB3XOPNH7QHs9QYtWEzfHK1RuneX65x3sHsQ0qW6yrxWe4CJHAtRUx8q9+KuLBylETx+utbj
	bpPoG4PW7s8p4nZ+mfQILhdYI7m1JAWjG2cbLl2x+/Pvtrl10VPfgKlQ==
X-Google-Smtp-Source: AGHT+IFqzkZJjAozGpICi5RFQjOpJf/ObFYlM3AL0bZm/uQEYIiMQA6S+gUuSXyUWDxoB4q64L2/eA==
X-Received: by 2002:a05:600c:6207:b0:45d:f83b:96aa with SMTP id 5b1f17b1804b1-477208d1be0mr31778455e9.7.1761761916270;
        Wed, 29 Oct 2025 11:18:36 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4771e18bd9dsm59552395e9.3.2025.10.29.11.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 11:18:35 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 2/2] selftests/bpf: Add ABBCCA case for rqspinlock stress test
Date: Wed, 29 Oct 2025 18:18:28 +0000
Message-ID: <20251029181828.231529-3-memxor@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029181828.231529-1-memxor@gmail.com>
References: <20251029181828.231529-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6232; i=memxor@gmail.com; h=from:subject; bh=OUNLvyEgIT+n3pX7f3X9MJ4NI5Z+tzd+R9fjqWqq45U=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBpAlY4amcxz+rOmkdqqZrxABGAOvW79UA9vS10T AY9/c3jeoeJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaQJWOAAKCRBM4MiGSL8R ygd/EACovzyjynmZC3CBmU8M5py9qxlWS/rDoh8sBQl/D1P2LKSxOW0pDjREg1olT9DDXRv7WUH EbUUU22vsQ8pkC/e74nOeaAPgaeRhnQC875Szw95SKhr4BiSwRYs1EL7KLwEpb8MPH+nXYnOZnW SdlCsxPKtAGZRllJpqhyCX3KLMQsQEsGWrACvyA6anl/5XPh0nzioFGnJLOrbcVqNjLK4BUHh/w fpyoeYAo8l8tKewXQv0d3NXoui+XAGt6T2664eqHq6mvxZb5VDd3moJxO98rYeusHISt2LK4e1t poI38bvR8pilnWpu2qCvORwRZo6DPg7JpuP99CF2WuMYppYcUcaSjl8LdFKklNZ6bT1z5DOAL44 wX5hXlA6qtjZU2xRPlPAYB5f928TaMdLxOQ0TB0MD1AnKT+nh+jq6ZhLQKw53lIAEelfZIDwuC3 kzB/w+I7j1PRrRGtGfDu+oWuBQZLZg9zyxxtcy7xTYgvdQ4ABVLH/99UPi74MNakeDSNsSwstr2 6cvRz1vDaFk5HGD16JzJdENQhuXLMvtS3GWNIoONwWuCne8Uv6GYfH2NZOGXHik1uYO8+dLdRxf Z9nSrHQ0C3A0F95hHLHfqOqKkoTdpAKuxfse5udr3suZpKgFhskNa1u+isKWV51mBEafOUuVxwG QmBFA5W89bpGCHg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Introduce a new mode for the rqspinlock stress test that exercises a
deadlock that won't be detected by the AA and ABBA checks, such that we
always reliably trigger the timeout fallback. We need 4 CPUs for this
particular case, as CPU 0 is untouched, and three participant CPUs for
triggering the ABBCCA case.

Refactor the lock acquisition paths in the module to better reflect the
three modes and choose the right lock depending on the context.

Also drop ABBA case from running by default as part of test progs, since
the stress test can consume a significant amount of time.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Reviewed-by: Amery Hung <ameryhung@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/res_spin_lock.c  |  8 +-
 .../bpf/test_kmods/bpf_test_rqspinlock.c      | 85 ++++++++++++++-----
 2 files changed, 66 insertions(+), 27 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/res_spin_lock.c b/tools/testing/selftests/bpf/prog_tests/res_spin_lock.c
index 8c6c2043a432..f0a8c828f8f1 100644
--- a/tools/testing/selftests/bpf/prog_tests/res_spin_lock.c
+++ b/tools/testing/selftests/bpf/prog_tests/res_spin_lock.c
@@ -110,8 +110,8 @@ void serial_test_res_spin_lock_stress(void)
 	ASSERT_OK(load_module("bpf_test_rqspinlock.ko", false), "load module AA");
 	sleep(5);
 	unload_module("bpf_test_rqspinlock", false);
-
-	ASSERT_OK(load_module_params("bpf_test_rqspinlock.ko", "test_ab=1", false), "load module ABBA");
-	sleep(5);
-	unload_module("bpf_test_rqspinlock", false);
+	/*
+	 * Insert bpf_test_rqspinlock.ko manually with test_mode=[1|2] to test
+	 * other cases (ABBA, ABBCCA).
+	 */
 }
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_test_rqspinlock.c b/tools/testing/selftests/bpf/test_kmods/bpf_test_rqspinlock.c
index 769206fc70e4..4cced4bb8af1 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_test_rqspinlock.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_test_rqspinlock.c
@@ -22,23 +22,61 @@ static struct perf_event_attr hw_attr = {
 
 static rqspinlock_t lock_a;
 static rqspinlock_t lock_b;
+static rqspinlock_t lock_c;
+
+enum rqsl_mode {
+	RQSL_MODE_AA = 0,
+	RQSL_MODE_ABBA,
+	RQSL_MODE_ABBCCA,
+};
+
+static int test_mode = RQSL_MODE_AA;
+module_param(test_mode, int, 0644);
+MODULE_PARM_DESC(test_mode,
+		 "rqspinlock test mode: 0 = AA, 1 = ABBA, 2 = ABBCCA");
 
 static struct perf_event **rqsl_evts;
 static int rqsl_nevts;
 
-static bool test_ab = false;
-module_param(test_ab, bool, 0644);
-MODULE_PARM_DESC(test_ab, "Test ABBA situations instead of AA situations");
-
 static struct task_struct **rqsl_threads;
 static int rqsl_nthreads;
 static atomic_t rqsl_ready_cpus = ATOMIC_INIT(0);
 
 static int pause = 0;
 
-static bool nmi_locks_a(int cpu)
+static const char *rqsl_mode_names[] = {
+	[RQSL_MODE_AA] = "AA",
+	[RQSL_MODE_ABBA] = "ABBA",
+	[RQSL_MODE_ABBCCA] = "ABBCCA",
+};
+
+struct rqsl_lock_pair {
+	rqspinlock_t *worker_lock;
+	rqspinlock_t *nmi_lock;
+};
+
+static struct rqsl_lock_pair rqsl_get_lock_pair(int cpu)
 {
-	return (cpu & 1) && test_ab;
+	int mode = READ_ONCE(test_mode);
+
+	switch (mode) {
+	default:
+	case RQSL_MODE_AA:
+		return (struct rqsl_lock_pair){ &lock_a, &lock_a };
+	case RQSL_MODE_ABBA:
+		if (cpu & 1)
+			return (struct rqsl_lock_pair){ &lock_b, &lock_a };
+		return (struct rqsl_lock_pair){ &lock_a, &lock_b };
+	case RQSL_MODE_ABBCCA:
+		switch (cpu % 3) {
+		case 0:
+			return (struct rqsl_lock_pair){ &lock_a, &lock_b };
+		case 1:
+			return (struct rqsl_lock_pair){ &lock_b, &lock_c };
+		default:
+			return (struct rqsl_lock_pair){ &lock_c, &lock_a };
+		}
+	}
 }
 
 static int rqspinlock_worker_fn(void *arg)
@@ -51,19 +89,17 @@ static int rqspinlock_worker_fn(void *arg)
 		atomic_inc(&rqsl_ready_cpus);
 
 		while (!kthread_should_stop()) {
+			struct rqsl_lock_pair locks = rqsl_get_lock_pair(cpu);
+			rqspinlock_t *worker_lock = locks.worker_lock;
+
 			if (READ_ONCE(pause)) {
 				msleep(1000);
 				continue;
 			}
-			if (nmi_locks_a(cpu))
-				ret = raw_res_spin_lock_irqsave(&lock_b, flags);
-			else
-				ret = raw_res_spin_lock_irqsave(&lock_a, flags);
+			ret = raw_res_spin_lock_irqsave(worker_lock, flags);
 			mdelay(20);
-			if (nmi_locks_a(cpu) && !ret)
-				raw_res_spin_unlock_irqrestore(&lock_b, flags);
-			else if (!ret)
-				raw_res_spin_unlock_irqrestore(&lock_a, flags);
+			if (!ret)
+				raw_res_spin_unlock_irqrestore(worker_lock, flags);
 			cpu_relax();
 		}
 		return 0;
@@ -91,6 +127,7 @@ static int rqspinlock_worker_fn(void *arg)
 static void nmi_cb(struct perf_event *event, struct perf_sample_data *data,
 		   struct pt_regs *regs)
 {
+	struct rqsl_lock_pair locks;
 	int cpu = smp_processor_id();
 	unsigned long flags;
 	int ret;
@@ -98,17 +135,13 @@ static void nmi_cb(struct perf_event *event, struct perf_sample_data *data,
 	if (!cpu || READ_ONCE(pause))
 		return;
 
-	if (nmi_locks_a(cpu))
-		ret = raw_res_spin_lock_irqsave(&lock_a, flags);
-	else
-		ret = raw_res_spin_lock_irqsave(test_ab ? &lock_b : &lock_a, flags);
+	locks = rqsl_get_lock_pair(cpu);
+	ret = raw_res_spin_lock_irqsave(locks.nmi_lock, flags);
 
 	mdelay(10);
 
-	if (nmi_locks_a(cpu) && !ret)
-		raw_res_spin_unlock_irqrestore(&lock_a, flags);
-	else if (!ret)
-		raw_res_spin_unlock_irqrestore(test_ab ? &lock_b : &lock_a, flags);
+	if (!ret)
+		raw_res_spin_unlock_irqrestore(locks.nmi_lock, flags);
 }
 
 static void free_rqsl_threads(void)
@@ -142,13 +175,19 @@ static int bpf_test_rqspinlock_init(void)
 	int i, ret;
 	int ncpus = num_online_cpus();
 
-	pr_err("Mode = %s\n", test_ab ? "ABBA" : "AA");
+	if (test_mode < RQSL_MODE_AA || test_mode > RQSL_MODE_ABBCCA) {
+		pr_err("Invalid mode %d\n", test_mode);
+		return -EINVAL;
+	}
+
+	pr_err("Mode = %s\n", rqsl_mode_names[test_mode]);
 
 	if (ncpus < 3)
 		return -ENOTSUPP;
 
 	raw_res_spin_lock_init(&lock_a);
 	raw_res_spin_lock_init(&lock_b);
+	raw_res_spin_lock_init(&lock_c);
 
 	rqsl_evts = kcalloc(ncpus - 1, sizeof(*rqsl_evts), GFP_KERNEL);
 	if (!rqsl_evts)
-- 
2.51.0


