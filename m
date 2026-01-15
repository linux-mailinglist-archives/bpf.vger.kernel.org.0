Return-Path: <bpf+bounces-79118-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D4084D27D1D
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 19:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81A9C31EC8FE
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 18:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0303D3015;
	Thu, 15 Jan 2026 18:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hGE94zCd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729D43C1995
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 18:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768501758; cv=none; b=KVE+sCaEl0Ei7OdB4xvuQa2oGsqHwhvxHwedsNNldFpwduVaeC8SUhD+5x+mCF54zB1pMTc+bjWHg8mkqduJjVV5rxCqcVViViWnVjWEsSD+y98TqNXTaiClkI7lWMhckYzGje3ZbRa1v1QR2IgFM/0Fp5WDEcUu3bBtRSze6ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768501758; c=relaxed/simple;
	bh=lRes9l+x3wDpNSO2Sa5JkIhFzgz9xGBZD8cX6/ZNbvQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t71TmL2VgvdICSJ5TDxatpHBfmJZdJkneEjWJGL3dgSP/Epy0qZCjhW6nnHrGxvpfo2hFpxRcj/UpruuQkBgN5/IjJ6i6ibKIWzfESMWTRhbl0zWv05Rk352/AE1Nb8lnMvGcIcRmZZR+tVuehuMJTWWYgs5+Y2EeYlEjKQnCSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hGE94zCd; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4801c731d0aso4728575e9.1
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 10:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768501755; x=1769106555; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4FzDrJXSiFpMM2oO5xJw4oZibyZTAtzJi/b5pFlTTC8=;
        b=hGE94zCdwZPehcno6F5iLvdSGGIQ1gRHH/Vixx6fnvW57tbdYr+R6h5OfxiSDNfr0I
         JXyKy2MxlRbZDd6sQQFPlYO1UHLap088OkoYuaklaRbZl2q5eIbwuIICnb2CjSpXjQJz
         QSOhiNWlYTKBzetzcoTh+Z5SRHZxVR9h/MZAu9cBheEt/NUFHJ5fzgzkzc73yOuKdLya
         OW24OqoMLqPVtF5hG/bUX9S0FDI+OT4cfo8tOX58TdpJRVqIo0cTXIlLu4dkq1lBARmF
         sA8YvCAsCZqgl9EyFsiPQplAAMPHDHOxpyOWP06A3UgZoJWuYNzWhGtM02Y11HM10Tpf
         2A2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768501755; x=1769106555;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4FzDrJXSiFpMM2oO5xJw4oZibyZTAtzJi/b5pFlTTC8=;
        b=xAW65FcN8WiV8dqKSvzfh1sjaPa2zvhdRGBjtPVUJG/HY9UICxiQ6c2yrFCZ1H7pQr
         xwcReyO8Lip8fIldIsPvfQO6Z5wshrqnxNG7bhvfmk42tCpTuQXj6jf7wqQ5RpUEuZnq
         5n0wj5QJDdwcpXclNK+zKptKMHFt8vmW2+KeWCDCj59Js3uOrJSD+hn9fK/MJ2VEG7Mu
         +ZBu+dQVry06JL7lnzkRIs9jjkPVt4wvAYRoMRHX8ljEjTVayYbsOPnO0cZeKPpBbV1Z
         eQdCIesGnAfGuCTCISwvMvytwfhI5syawYROl1mNySNv7YcTvvbNDyPWnvOJOD+p6Zbn
         1uSg==
X-Gm-Message-State: AOJu0YzcHrkob9J3KkKUtYbWFOgI3mAVBlw58MxACN92cRNW9fPE3L9Q
	SoyNZ7+/YwFZZX12Dt7GRGkmdCMsND0nUT1foymW4f6AV7D3bkGVbax5FYfrZg==
X-Gm-Gg: AY/fxX45oXG+NNFLP/cGXFjqpG+89blbUQVd6GS+nnHd63/Hg4hdb4a7x9JEp6zh2Wq
	fzLdS5ouOw42i5b+jp/WRA6DBtw5COUoQL5MBSCET+D5bxl+a0u5OBp5EjgxX/qpndaKN9Vv5qN
	2qBlOcTxiJ/W6qa19u+6NZZWiKvSjE4VJ4c0mumNu8gpLpBo2+zdzwAwLbl1pfbu+MiC5Spzu10
	k7RnP6YsWX8i6voKjo9wTuiluu9kusw9odS5pUzJfFJegnSQ0vksnDi7FZDzJjVgDGwYZK8NeQI
	yfe3eEzn09CMaTkvxLt0KIJtwSmXmdzjD5zyI3RLNLon0/oN/dYaIBviAoMlWWAig0TJCwFJkST
	ETncHdCgc8m8GQsE2NN3CkwPQ7HcZZSWGRFdDRwI8aaZ/gPAU5XzX8fsSh5tyQrzOj5PmiJcBKa
	eQ
X-Received: by 2002:a05:600c:1d0a:b0:477:8ba7:fe0a with SMTP id 5b1f17b1804b1-4801e343051mr8892305e9.24.1768501754231;
        Thu, 15 Jan 2026 10:29:14 -0800 (PST)
Received: from localhost ([2620:10d:c092:400::5:2520])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f428ac749sm59867195e9.5.2026.01.15.10.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 10:29:13 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Thu, 15 Jan 2026 18:27:57 +0000
Subject: [PATCH RFC v5 10/10] selftests/bpf: Verify bpf_timer_cancel_async
 works
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-timer_nolock-v5-10-15e3aef2703d@meta.com>
References: <20260115-timer_nolock-v5-0-15e3aef2703d@meta.com>
In-Reply-To: <20260115-timer_nolock-v5-0-15e3aef2703d@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 memxor@gmail.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768501744; l=2785;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=rxvPvabdjJ7jjXmOwc3ttq22Faa0bJrvplOFprPR9ZE=;
 b=+GVVLiUzVHhGiPPsfM4Z9RBCSOJ09r4iwsZ15gMEsHlURbscxpcOUXDJNdPtO0rUW4ZlaUGww
 s080OvEuMByBdCpg1w2Cy1YP00FLiX4n6PhYikSAg8lXWAb8Z0geK8S
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=

From: Mykyta Yatsenko <yatsenko@meta.com>

Add test that verifies that bpf_timer_cancel_async works: can cancel
callback successfully.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/prog_tests/timer.c | 25 +++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/timer.c      | 23 +++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/timer.c b/tools/testing/selftests/bpf/prog_tests/timer.c
index a157a2a699e638c9f21712b1e7194fc4b6382e71..2b932d4dfd436fd322bd07169f492e20e4ec7624 100644
--- a/tools/testing/selftests/bpf/prog_tests/timer.c
+++ b/tools/testing/selftests/bpf/prog_tests/timer.c
@@ -99,6 +99,26 @@ static int timer(struct timer *timer_skel)
 	return 0;
 }
 
+static int timer_cancel_async(struct timer *timer_skel)
+{
+	int err, prog_fd;
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+
+	prog_fd = bpf_program__fd(timer_skel->progs.test_async_cancel_succeed);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_run");
+	ASSERT_EQ(topts.retval, 0, "test_run");
+
+	usleep(500);
+	/* check that there were no errors in timer execution */
+	ASSERT_EQ(timer_skel->bss->err, 0, "err");
+
+	/* check that code paths completed */
+	ASSERT_EQ(timer_skel->bss->ok, 1 | 2 | 4, "ok");
+
+	return 0;
+}
+
 static void test_timer(int (*timer_test_fn)(struct timer *timer_skel))
 {
 	struct timer *timer_skel = NULL;
@@ -134,6 +154,11 @@ void serial_test_timer_stress_async_cancel(void)
 	test_timer(timer_stress_async_cancel);
 }
 
+void serial_test_timer_async_cancel(void)
+{
+	test_timer(timer_cancel_async);
+}
+
 void test_timer_interrupt(void)
 {
 	struct timer_interrupt *skel = NULL;
diff --git a/tools/testing/selftests/bpf/progs/timer.c b/tools/testing/selftests/bpf/progs/timer.c
index a81413514e4b07ef745f27eade71454234e731e8..4b4ca781e7cdcf78015359cbd8f8d8ff591d6036 100644
--- a/tools/testing/selftests/bpf/progs/timer.c
+++ b/tools/testing/selftests/bpf/progs/timer.c
@@ -169,6 +169,29 @@ int BPF_PROG2(test1, int, a)
 	return 0;
 }
 
+static int timer_error(void *map, int *key, struct bpf_timer *timer)
+{
+	err = 42;
+	return 0;
+}
+
+SEC("syscall")
+int test_async_cancel_succeed(void *ctx)
+{
+	struct bpf_timer *arr_timer;
+	int array_key = ARRAY;
+
+	arr_timer = bpf_map_lookup_elem(&array, &array_key);
+	if (!arr_timer)
+		return 0;
+	bpf_timer_init(arr_timer, &array, CLOCK_MONOTONIC);
+	bpf_timer_set_callback(arr_timer, timer_error);
+	bpf_timer_start(arr_timer, 100000 /* 100us */, 0);
+	bpf_timer_cancel_async(arr_timer);
+	ok = 7;
+	return 0;
+}
+
 /* callback for prealloc and non-prealloca hashtab timers */
 static int timer_cb2(void *map, int *key, struct hmap_elem *val)
 {

-- 
2.52.0


