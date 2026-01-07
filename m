Return-Path: <bpf+bounces-78143-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF0ACFF601
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 19:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5A47230019F9
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 18:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E40395275;
	Wed,  7 Jan 2026 17:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYrUUBmz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7877039447A
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 17:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767808196; cv=none; b=Oulos6goDYwQM1VfEj4SzAZbq6vfGHsn9/aYz5rv/xu6m28AD337oHRSx9jZFYuyAB4/au9QC5BG5TaB782WmZWnleLPBf84mH9T0JmPYWu9MkNc/vkZVb4nJzvZBJzj7Ls94vCs90D/KnpkiFZE7HYJzw6QrsJxlEao/zIkMmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767808196; c=relaxed/simple;
	bh=lRes9l+x3wDpNSO2Sa5JkIhFzgz9xGBZD8cX6/ZNbvQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CsXB68ndhuv9nzcf4jzoRRGwDWM42yDCrE2O7wFFEOBJUhkoaZZYBevhvBIFL0rLqFRadNLUdle0+v3nNYG1eusOMWgp9Ort+ptFBDMTjNWprFEW2J1bxzjzFXlAaP1zzuoIxpvxpKHnML4ivEM61mwfATzibJRI0STiuFVUxeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hYrUUBmz; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47755de027eso14181885e9.0
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 09:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767808184; x=1768412984; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4FzDrJXSiFpMM2oO5xJw4oZibyZTAtzJi/b5pFlTTC8=;
        b=hYrUUBmzCUDUGpWUTEkFUa0Cn+iJSbes6WKJ8r8N+n2F9qE0dNsjfDe56G39SDOQKg
         S81YsaSQTPnoLSTBDv+mfSuOlJdUPfAtUUglzLmnzPkpo9gkmLwn8EJ2UhrJENqj5gch
         /oZAfGihaVmoYvm+1tVUmAQZYIgThwj23EfsbEF18M+aLJkPjJq5nIh3Pv7UYGIKKiTU
         oNcOh4/MQekEUeyrFIjcey3TDh8A0w/0HIph2PiuA9QbrYEXU7XU4wHsZ1HfHlDH/lE4
         0toGdtAAkhlfVpokB6kSevYP45aHqsvCT6GHT2LAGUxkONz0akgQJKFCh2SKlBmV4qwF
         Wo+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767808184; x=1768412984;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4FzDrJXSiFpMM2oO5xJw4oZibyZTAtzJi/b5pFlTTC8=;
        b=UkB6FbLeO2w8I37sG81kmmN8i2iu6Ai+BiMRq6DC8MiMIZPvujX+uruPvqli0PCIQB
         C/ayZFpPdJkZfDc5OT76NnbTfBXuhU80RSkJfRSQlouoRTPy3AUsDkVSRmWHLXViCf/8
         OC+LY8lWlFkIupUh5+tE2KjUMc3pogpk+pPR9EmPtQUUXzcIe4aKfoLmX1ZiULBxvV6e
         fU8zn0W5k66kO5jnJsK6F26UsLpm2fgo1otgah6Jjc+8obtYU5ERcan+TtIYmKhw79cE
         3v2ULEZLEjk2qBOtZyFLYsNnfPkdw4Ldcc+NwM1vdgPteQEnuRRwTx66FrUoUF+morM+
         1NNg==
X-Gm-Message-State: AOJu0YxMORRjlyQnltLl6tzUng4D5jRiMW9I4+PoewCSFR/D7B4/GM8Z
	eRknfQqdyI0hBV8O+3NBsucX4AowybhRBW5eTfhVkV2DZEvVFVsBatdD
X-Gm-Gg: AY/fxX6kxAJRcZH7JQlv+n51JL6oviWzl9lkjG7d4d30Qpkbh+TOJPESM9BfPvfFG95
	JUINlC9/j3CA1TjdZm7r25cKwXP7v76I4Iq8NZ8kJ9Wa34z3lneAb6Kc2mwhAYETN9QA4hTLu5z
	UZENXvYiNmy4Dho1H+1S2DoT99MAwc5ifgMACPTqJzW/WIr8nFP/WfXAw9j76Jq5g9LiQSNwKNM
	AsfXkw9QtuZX5f3Rpm6M6wIbF0xYR/CoEw/3/7uybrRNx8FN/sk9ZTvehSF8ZwPt15ZdQlQ43RD
	XX+6/JpPl9mtqXC6AvFs1ox687QhHFC/Wf1s+NjiNDRmtjzauqgxz+ijK7rUHX0fRxzySEBKqQQ
	A3fw9fmfg1p0mmZ6dlYmHTg4Od+KncCuqESUycKg6lmyIEd6KRvhkdAT9Q1AhC1VGi/4=
X-Google-Smtp-Source: AGHT+IHcdis5UaiMkFQALdxsp6sSeQ39v4wxGFjFoPviqDuUVEwI3OkQtzKgPcuiry+/Pmdz7yDDXA==
X-Received: by 2002:a05:600c:4e86:b0:477:9574:d641 with SMTP id 5b1f17b1804b1-47d84b3281fmr39706095e9.22.1767808184022;
        Wed, 07 Jan 2026 09:49:44 -0800 (PST)
Received: from localhost ([2620:10d:c092:500::5:d4be])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f410c6csm119132895e9.1.2026.01.07.09.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 09:49:43 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 07 Jan 2026 17:49:12 +0000
Subject: [PATCH RFC v3 10/10] selftests/bpf: Verify bpf_timer_cancel_async
 works
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-timer_nolock-v3-10-740d3ec3e5f9@meta.com>
References: <20260107-timer_nolock-v3-0-740d3ec3e5f9@meta.com>
In-Reply-To: <20260107-timer_nolock-v3-0-740d3ec3e5f9@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 memxor@gmail.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767808173; l=2785;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=rxvPvabdjJ7jjXmOwc3ttq22Faa0bJrvplOFprPR9ZE=;
 b=bg+IqmNg1LEmEGFCInFbyypNOS+38aF6BPsGXQlG9UQFXXeDxVdjwIFwGm+zZlZ94YTLygvVH
 oJ/3xKtRccpCIh+T2Lu3pZ19XVJgxOhKKqLzga/Rn4SBPX7Ks2sgtFp
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


