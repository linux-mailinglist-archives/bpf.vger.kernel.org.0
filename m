Return-Path: <bpf+bounces-79116-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A688AD27B88
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 19:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E1A2130B6EF0
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 18:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEDB3D300C;
	Thu, 15 Jan 2026 18:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PR55i2LU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796D83D300A
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 18:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768501756; cv=none; b=XUHMTtRajPJ0VB+Lo6Cub9UGegkvlSGQTbH7LU70ynXCMohg+sfobVfO39hjNLThzF7IaHUr2JLKmwS5oVPng6JQVyiuW1RmsTQjbtx+ks5cHnlmxc54pGXhIjXEbG8AbB8/QOVTCN+URHuwyjL8of1QQCb3G7t7YhzKJgfclkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768501756; c=relaxed/simple;
	bh=SWyMRCjSOVCSx3FWxZDLXZnAjKeKkFv9M7p4lS61Opo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wf48XOp4pPzPwrplhLppFXo2w/hyYmyN9K+ZEjemT/EFlngF73hFx/DvNyR0ZYiwE+oWGAh9nU2FoWhGyhP0hey2fudfGdd38bk8gg2A63ImAC53Di3xU8IR9G4IyhzeQJM/i3RJumvDLJL9kKSBAiYEZ1JrdwSMt2+7/Bjn8MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PR55i2LU; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47d59da3d81so9840925e9.0
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 10:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768501753; x=1769106553; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z90nFROdPtst2IKVs/+csEyxpI1YETMH4mOHgmwYj7o=;
        b=PR55i2LUSDklFa0meD1dhFYkmdMqYahwu7boyQjCO8Mf5zRboRqXoXfL6Z7bmcAxk7
         VU1LXlkUAHlhsMgu9n7Qi1KP40V/Y3zyznz9Anl4bESxa1LA5tmOCW0AXcw/anicqo9q
         LkoqAO15tOuVRie0ycgEDHTAlXF3yQPGSyF9n0EGKlJ/qzfB4zOQP1lph7g/hvAk/Ue8
         TjaNNuYKzokjrB+w4vfR8awj/IK3uuRsoS9q9q2nZ6QGq6z2andMExL9RJPk1b7y6Jur
         KMZozQSrOWdoWaviFXTItbN8bdTaUA5ZSqKhwo8nE02JiCxPKYN30PClDmMPnR26tGKK
         xBow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768501753; x=1769106553;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z90nFROdPtst2IKVs/+csEyxpI1YETMH4mOHgmwYj7o=;
        b=mxdo3ezg3V2WS5QBuUG11mBlqkKWAoZ1qJZjkLGirKSLG0P5966cyi9sqHSaDZnQxT
         jqKBspPxCaKBXHDU/2cCwJn9v1iVbTmd00TJQNEK+V36DoCHWhYALUxojgPGdYhcnsGf
         kmIzR50Bq55I3w67gEHjZvX7gzc4fN3f3t73Ec6OVh9pWoViU1OCYBgSD2ljH+9ZY02R
         27bw/PPEZ/iEM57kQ9kxYX7qkdLS+WanUWm6ycrWMnQU21AsKgoBezOxMAgu8S1euvpi
         VizvOLRivai6Y9/VO95n+CIiwyK7jLbyc8EPOiKSEcLfvCpUt3PDI6Z8X21OmKGY+kVB
         bAzA==
X-Gm-Message-State: AOJu0YxkLR23yQuSDvLrMBU93SQP03rQG1nqJdqeLrsTCiBGh5UI0oQj
	GsutXCfTDBdElSsPKIc/cDD82zDzrdEMBI8bhnR+qZtvuKzGpfHK0dYOsAU7cg==
X-Gm-Gg: AY/fxX5aahGreiAyz5FMH8/gh7ZLV3mzWW6FvM30r+X3DpHhYwl4KrGdDrHMU0qKtWX
	Zve9gXxEP37tz2d+heHhdMp7Kbpfy/ESxkUfZ7vsOTYftFxhHxM6yp3iyjf/I+TAf2v0Ob2r2XR
	Y8XgdZYR5Iw4z7O57ra67WKAQ28dvpZQALa89kwiCpmBYfyi3t1nkg+R90L5jB0/kZMGAEC+s9J
	zBVdPhDq8kLMJBRro4/sNtPo9Fpe+1f3Q2HqM3AIFr+EiC1CMODq6j1WDzrxs8ztAgX+r/a1BYB
	WIhczB3hKJEgaAIme1gnqadrPNe4pVNgj9kbQTzESEM8V3z5aR68Vla9XRsEW2l1tSlbywmpCyU
	h1KoSqaJC/LIvDcgCN1Kz6W0mAwu7n4M70pw02028kqQBPm4SVxuNaJ2J6VBidwfuZg==
X-Received: by 2002:a05:600c:6812:b0:47d:403a:277 with SMTP id 5b1f17b1804b1-4801e5301fcmr6514875e9.4.1768501752526;
        Thu, 15 Jan 2026 10:29:12 -0800 (PST)
Received: from localhost ([2620:10d:c092:400::5:2520])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e9ee5c3sm916215e9.2.2026.01.15.10.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 10:29:12 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Thu, 15 Jan 2026 18:27:55 +0000
Subject: [PATCH RFC v5 08/10] selftests/bpf: Refactor timer selftests
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-timer_nolock-v5-8-15e3aef2703d@meta.com>
References: <20260115-timer_nolock-v5-0-15e3aef2703d@meta.com>
In-Reply-To: <20260115-timer_nolock-v5-0-15e3aef2703d@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 memxor@gmail.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768501743; l=2904;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=I12f8/2m85P/qMhnRxqBUg240K5nCwpW7fUenuGUBFo=;
 b=cNJrODzlRFGUDU9Adxs3vegurSOKee8FqKHFg+o92dB9WgvuYlFRkGaP0sVtYyhHOAZ8DG86L
 d/DwYxkrruKAMjJfZy+m8j2cB95pBLJclDMYyD2/NYrsSqc2MwyMmth
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=

From: Mykyta Yatsenko <yatsenko@meta.com>

Refactor timer selftests, extracting stress test into a separate test.
This makes it easier to debug test failures and allows to extend.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/prog_tests/timer.c | 55 +++++++++++++++++---------
 1 file changed, 36 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/timer.c b/tools/testing/selftests/bpf/prog_tests/timer.c
index 34f9ccce260293755980bcd6fcece491964f7929..4d853d1bd2a71b3d0f1ba0daa7a699945b4457fe 100644
--- a/tools/testing/selftests/bpf/prog_tests/timer.c
+++ b/tools/testing/selftests/bpf/prog_tests/timer.c
@@ -22,13 +22,35 @@ static void *spin_lock_thread(void *arg)
 	pthread_exit(arg);
 }
 
-static int timer(struct timer *timer_skel)
+
+static int timer_stress(struct timer *timer_skel)
 {
-	int i, err, prog_fd;
+	int i, err = 1, prog_fd;
 	LIBBPF_OPTS(bpf_test_run_opts, topts);
 	pthread_t thread_id[NUM_THR];
 	void *ret;
 
+	prog_fd = bpf_program__fd(timer_skel->progs.race);
+	for (i = 0; i < NUM_THR; i++) {
+		err = pthread_create(&thread_id[i], NULL,
+				     &spin_lock_thread, &prog_fd);
+		if (!ASSERT_OK(err, "pthread_create"))
+			break;
+	}
+
+	while (i) {
+		err = pthread_join(thread_id[--i], &ret);
+		if (ASSERT_OK(err, "pthread_join"))
+			ASSERT_EQ(ret, (void *)&prog_fd, "pthread_join");
+	}
+	return err;
+}
+
+static int timer(struct timer *timer_skel)
+{
+	int err, prog_fd;
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+
 	err = timer__attach(timer_skel);
 	if (!ASSERT_OK(err, "timer_attach"))
 		return err;
@@ -63,25 +85,10 @@ static int timer(struct timer *timer_skel)
 	/* check that code paths completed */
 	ASSERT_EQ(timer_skel->bss->ok, 1 | 2 | 4, "ok");
 
-	prog_fd = bpf_program__fd(timer_skel->progs.race);
-	for (i = 0; i < NUM_THR; i++) {
-		err = pthread_create(&thread_id[i], NULL,
-				     &spin_lock_thread, &prog_fd);
-		if (!ASSERT_OK(err, "pthread_create"))
-			break;
-	}
-
-	while (i) {
-		err = pthread_join(thread_id[--i], &ret);
-		if (ASSERT_OK(err, "pthread_join"))
-			ASSERT_EQ(ret, (void *)&prog_fd, "pthread_join");
-	}
-
 	return 0;
 }
 
-/* TODO: use pid filtering */
-void serial_test_timer(void)
+static void test_timer(int (*timer_test_fn)(struct timer *timer_skel))
 {
 	struct timer *timer_skel = NULL;
 	int err;
@@ -94,13 +101,23 @@ void serial_test_timer(void)
 	if (!ASSERT_OK_PTR(timer_skel, "timer_skel_load"))
 		return;
 
-	err = timer(timer_skel);
+	err = timer_test_fn(timer_skel);
 	ASSERT_OK(err, "timer");
 	timer__destroy(timer_skel);
+}
+
+void serial_test_timer(void)
+{
+	test_timer(timer);
 
 	RUN_TESTS(timer_failure);
 }
 
+void serial_test_timer_stress(void)
+{
+	test_timer(timer_stress);
+}
+
 void test_timer_interrupt(void)
 {
 	struct timer_interrupt *skel = NULL;

-- 
2.52.0


