Return-Path: <bpf+bounces-78951-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 069C2D20C6E
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 19:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1B614301949F
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 18:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443493376A3;
	Wed, 14 Jan 2026 18:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BT9UVnOR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F61F33710E
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 18:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768414995; cv=none; b=Fpa+CHjY6TpKN2IleWD+J3ygd2tEi3gQVjoi5G/cMdPvWNXNlelTji3wewF77JvY7x9Qgw5wSIlUCdFOKOWMOFIfrvxCJNdzeYUc14B21bjqJSKNMzimMz4urKmzYFL8UfeCHRGuofgjqVAIC47QRg4PjoUrhYPsP0VTVx/LB/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768414995; c=relaxed/simple;
	bh=lRes9l+x3wDpNSO2Sa5JkIhFzgz9xGBZD8cX6/ZNbvQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JNTRNqJ9Ty9IzTjghk4YC2+odZ+oLM9ng7iIxY5awbv9EN3kSpcmPrsELGHL+S7ULF7CCjPKioDqJx+k2kaT64GATBuqlJ2O6SK2mLm8nu4x2vugZAl+TclbIUw08y1Xi4dS1A50ijJhE3kvL9V1l1DPtGVkii6AAdehmicU8+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BT9UVnOR; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47f5c2283b6so557915e9.1
        for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 10:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768414993; x=1769019793; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4FzDrJXSiFpMM2oO5xJw4oZibyZTAtzJi/b5pFlTTC8=;
        b=BT9UVnORZ19JohpPdOye/FQq4o4WKOHUwBFA9fytgXeEt/XhVWyp9NHSz0k+Z9B6Ti
         W8k/dP4Me9zVkYPRVM2ZlEcQU3I66cpidxYJQTK8QbtQa2UdJu0RM9s4gckG+p/U/jCT
         ZYE1a7/+hHcgDAv3gDewgYTzuyeMrImqLfTDi3iJw70tGrD3Z8eVdPJotqbFfTOeEA9r
         STXlphg2wbc+eQKhRxTnA6cZxWgJyE7EUvpt+p2dtPdEMh/bF80yojZbWXnJ1RicgM5n
         LqSrX5VTguqXyWT/EvBwvpG4JAekBCQAn1thiYdS7bKlwrCBAalDbCUPsQDBbOiDYOCj
         8plw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768414993; x=1769019793;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4FzDrJXSiFpMM2oO5xJw4oZibyZTAtzJi/b5pFlTTC8=;
        b=nX63o3nRMq5DlOXOluAgKQymMEqKThoDIQe4mUjczifF/IMmzdqvUJiV4plWG3SUeL
         zZthMxaF66ps3NBNrYuTqCq0DI/F0EkNvBYlYWjRa6hMMG91P79JQP5qU1bNDQ8TH3l9
         colXr2d4SgjrUJ1xsShQjdR5hsHwiy6uvPquEGtIH2e7fC6CL8T2SRLoswGHcPyeve14
         ic3FGRb4Tli3zqULWOQ4BFVO1D5FEqbS23ZQbste2iSjz+W258YcooWyOBV8TTINjFOv
         ZRCRb0Byc/scvRuMGIHILEVJwpFepCJjD/tVS2BUZWwOMHrg4hp1O5VzfgfP53HVQQoU
         bkvQ==
X-Gm-Message-State: AOJu0Yy6hjNiisITaLmomgF3pQ51/x6w/3912zeda3CiIJKiyqcDnl27
	f9K+N5K1RrtOnlYzSvHvycswU3Z9zfiu/PPtuW5fgQUi0/TImTTvs7Rx
X-Gm-Gg: AY/fxX4ArU75iwdu1Mq4UnpbnCiogdScYLFODHvBvwEtrBh4mfve9S6egb6NwHiYnzT
	iq2CYeeguPf3kgwXndAhKhFq8bla/zux3cHJCZ68UlZ+DQLU1h1QyJXJ2+nxavJAoJxqys2mg2K
	grIimcTRCfAOoRzKhlvvRNmUNkJZQzU17VvY/bosusfKrfh77bcROa4fQtKXi3Koc3zKr78PK9E
	71fy3WxvSOdlT99odMmdbgCBXHZpeR31tp6vdmJKOuRygpa0O+RzN7oTbf8O3OWuHlp0SuFTUrv
	0jB6gFT0o6w2lyKSwHgtl4VPJUy8GinIn5Z9Ee79NRkCXkDXZIhsDhh16x2UHfkiy3LVRx5ui9j
	DZzuA71ny7OBC3imXLBjg5nHDmub9Z8dxTSPBotpmEntLKKEdTOOrEhgv6lcHf1Vfjz/ts9hOrm
	ktQzMWobbanw==
X-Received: by 2002:a05:600c:c16a:b0:47a:9560:ec28 with SMTP id 5b1f17b1804b1-47ee3317031mr40805205e9.13.1768414992445;
        Wed, 14 Jan 2026 10:23:12 -0800 (PST)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee27d9aaesm26933505e9.3.2026.01.14.10.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 10:23:12 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 14 Jan 2026 18:22:52 +0000
Subject: [PATCH RFC v4 8/8] selftests/bpf: Verify bpf_timer_cancel_async
 works
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-timer_nolock-v4-8-fa6355f51fa7@meta.com>
References: <20260114-timer_nolock-v4-0-fa6355f51fa7@meta.com>
In-Reply-To: <20260114-timer_nolock-v4-0-fa6355f51fa7@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 memxor@gmail.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768414982; l=2785;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=rxvPvabdjJ7jjXmOwc3ttq22Faa0bJrvplOFprPR9ZE=;
 b=ryNgLAS8n8e19M1XfpVGjddC9s+36ZPYMedOj2SF3BJ1wPvxyd1WSRaT+v4oMGOOvEKEQEQMp
 noNI1GqxjksB+i00gcm+9rfd8P+5st0uUsMjRU6tre5GuAl1kzYXvFE
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


