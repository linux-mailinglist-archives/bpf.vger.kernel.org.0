Return-Path: <bpf+bounces-71834-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6ECBFDB85
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 19:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 123803A3434
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 17:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338B12E1C7C;
	Wed, 22 Oct 2025 17:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIUFAuoE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922622E172B
	for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 17:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761155651; cv=none; b=mA35eI4ARnx+AzXoGP+IVxCUjWqcdAhfGPO0bc7sTify+tS1h13shsmN3h8gi3Qwt9tJ24EhkIq2q05Lh3GimSpdRxTqJ/ar1lOc3vUPW+MfKg3SUKRAQDpVXbd20A+kBiY7ZXLVE35TJjG33lbiU30LT5HqZ0SolFd1RMD4L3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761155651; c=relaxed/simple;
	bh=VSGDtEJ5A7Pv5AJIsbo6G0pnMLXGS/GD5fUXjXOptwM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SBa8VKeYDrC/FhnIBv9X7A4Rpl4+ScGcc5ygJye7QGw3DFYjaFV8kfM9vTxusNZzPC3ShczHy4bnvkezHYKcPY2ZRoZuNNwPdTccqhZftg76GoGdvpGIkoIksZT5vdVCIOLXPdqT/c6+tJ+o4cot/8HfY9CKRS2SctoKDkVkPUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UIUFAuoE; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-471076f819bso57486325e9.3
        for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 10:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761155647; x=1761760447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H7R81KCktcpI4qms/dvGlk3Nmu/8wiBKIRFEH0ElPQY=;
        b=UIUFAuoEOBls/14FHZp+GKk0GkBA9JGzkvQ1FAX1i1/2rc1Vfzh4IdhFZcoY/GD+2g
         YT3xjcgVq0JcGAY5EQuZa+Zaip5+V4wJzGuA8Q1MpzRWLDbs1TpOrSP76g7jXA8NL0OM
         rULvajmHUdl2Xqs4wa/Eo/g3Xvjqh4HmxSmWl2dfkatC0UjFQ0oc601r4fyG/agZzOSc
         d2WmQ7wAPvrwYPoFqqCwDtaUAGNeLu8lQC1hodOLulgjkvotcUFIFbXmJkZeZHUN6Re3
         GBAYroS3HYQHrN3dj499iaqgGjMntnuRsRJkFQUvVRocMvA/cDUesHVAngyOimEpQRzy
         KQrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761155647; x=1761760447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H7R81KCktcpI4qms/dvGlk3Nmu/8wiBKIRFEH0ElPQY=;
        b=NlH4V+qEGujj8AnQhxE91srrG2KYqcitS19oHYIRyJvGb0/rf+Wui3ugV2HR7RbibR
         tTObTbKoahaAnPEyzpi/E7ObcMOS9yFOi6kVAeJKvFmTkbZU4UONUX+TUGOp1/u5mrsL
         TlmS35HmPgvueVKMASYcFiALTOFJUzi8ewNEuh0LMnN7ZdxaGDLsxcNcWTK25+lMI/g9
         zb9n09j13Jas41Hvrr17NUgi+DIKRfV7dY2/etjgJgc6o5l1FEXHtzRpGKMZEG0m5W3c
         ldHyoBGzeaKpXsjUpa0GzPkNlYMP+rcZnmKG9p+HgZbZ0Scyl5BS87yhV1xpgFrwjJ0M
         7wSA==
X-Gm-Message-State: AOJu0YznYcUtcAUuDGaYTpc97N8aoZ/vEI/JS+7/0BqMFLzaQx/BU5TR
	nLDGiGIglpOznkVtfOMheezxjzs646imCFqrNaQ/nPOnlFMckCD6BdlqoNmwlrTx
X-Gm-Gg: ASbGncusmCNn3syn1+Gv2JndBeKwsxlgo8VPLl9NIVmyMyLxjdhbAV+72QDoP87D3aX
	W4H0kX53MOsdryHbFYZl9qFN7wikhZF85KGFhZY3dVShAhAFr1HycqoRmpsEiDcUaHXKzRPDqR7
	GLuWFxqMdR9J0d62rYUPRU62BGBcudwXTWB2g3J8zWsvZMyoIQfmx5BrCct7bVv66xWqIJ58QHS
	ICSW5mD5LiolVLLaeoH3ukn+s2Z7Lldr4gwHhHRoOIYYyWoWtS1X6pvVlOL85b6VLG97Zi1lANC
	P6XTCXqRu506rqQO0dDMAnHB5yvYTh+E3EHA/pNI0kSJc+tybTzS/AkK2lad8Xn7UNiZ1XwGMWA
	Ev1SkTgibCPmWGxgUw1d1275xolp8AcIrGPFMnXSaWTO085HeqmWUEXSMlpzBgE7NZASAgLPVa2
	Jz8eN74HoSCha/5vNi9V221xD7axJ19k01N+4DKtYPIM6KXoliqzw1dCjmMyvh8CyO
X-Google-Smtp-Source: AGHT+IGbAcE+WWruJrWvBEnqt4gf4EHsaMi4L4wLYsRFRf4LFYZ7NsKwCm/irD9mpplMawS8x/a4nA==
X-Received: by 2002:a05:600c:548a:b0:471:669:e95d with SMTP id 5b1f17b1804b1-4711787dcc8mr144237345e9.12.1761155647369;
        Wed, 22 Oct 2025 10:54:07 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-475c42b48c9sm60640605e9.15.2025.10.22.10.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 10:54:06 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1] selftests/bpf: Add ABBCCA case for rqspinlock stress test
Date: Wed, 22 Oct 2025 17:54:02 +0000
Message-ID: <20251022175402.211176-1-memxor@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new mode for the rqspinlock stress test that exercises a
deadlock that won't be detected by the AA and ABBA checks, such that we
always reliably trigger the timeout fallback. We need 4 CPUs for this
particular case, as CPU 0 is untouched, and three participant CPUs for
triggering the ABBCCA case.

Refactor the lock acquisition paths in the module to better reflect the
three modes and choose the right lock depending on the context.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/res_spin_lock.c  | 11 ++-
 .../bpf/test_kmods/bpf_test_rqspinlock.c      | 85 ++++++++++++++-----
 2 files changed, 72 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/res_spin_lock.c b/tools/testing/selftests/bpf/prog_tests/res_spin_lock.c
index 8c6c2043a432..f566d89f85ea 100644
--- a/tools/testing/selftests/bpf/prog_tests/res_spin_lock.c
+++ b/tools/testing/selftests/bpf/prog_tests/res_spin_lock.c
@@ -111,7 +111,16 @@ void serial_test_res_spin_lock_stress(void)
 	sleep(5);
 	unload_module("bpf_test_rqspinlock", false);

-	ASSERT_OK(load_module_params("bpf_test_rqspinlock.ko", "test_ab=1", false), "load module ABBA");
+	ASSERT_OK(load_module_params("bpf_test_rqspinlock.ko", "test_mode=1", false), "load module ABBA");
+	sleep(5);
+	unload_module("bpf_test_rqspinlock", false);
+
+	if (libbpf_num_possible_cpus() < 4) {
+		test__skip();
+		return;
+	}
+
+	ASSERT_OK(load_module_params("bpf_test_rqspinlock.ko", "test_mode=2", false), "load module ABBCCA");
 	sleep(5);
 	unload_module("bpf_test_rqspinlock", false);
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


