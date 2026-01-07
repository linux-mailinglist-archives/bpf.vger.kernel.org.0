Return-Path: <bpf+bounces-78142-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E2FCFF892
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 19:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E161F32CF685
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 18:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC05397ACE;
	Wed,  7 Jan 2026 17:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSP51YQd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA0B393DC8
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 17:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767808192; cv=none; b=cHeJPd4h5ftSjkApKBvkX++JlWQj2kcRRpIuIlyhB2xR8/38b/f8JPK1ixadk4VwzDNQY7l1z+7yq57A71023zgmoNGVTIl97+L0tYRMvtiqyU3rGZaZdbRXjV8OcOro8ei5Y+oNXq/7Mlo6T+F5k0oWBY0MiPp6ZjasDKnzAo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767808192; c=relaxed/simple;
	bh=SWyMRCjSOVCSx3FWxZDLXZnAjKeKkFv9M7p4lS61Opo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AZivYQ49nU3QyRly6YeNOUAwdGlFdT8n2n+vVGUF7aDNv0oOk3Q7v4ZFQSdA9QJ0/yhekAAzFGHuWZbLis5wdeudYiie3qlJMubGxCRVg5Js01EBfFUIwrWbGhWmSfCRw0zUsJcCoBulRSSeFtR4UZC8L/xiyAEDI6vGZiJLmFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZSP51YQd; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4779adb38d3so16846185e9.2
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 09:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767808182; x=1768412982; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z90nFROdPtst2IKVs/+csEyxpI1YETMH4mOHgmwYj7o=;
        b=ZSP51YQdoJi9vSEPBQMs+BjZCRWJBeP1zGBMEu/RCVswQ0CcTQrmHFg77fwyDIoyxO
         QDjBUqZb1VmJD61DF5K9oZfivICUDuJGF4febOwnmxeIOM/7+d6JCIk4c+qKQER91oUt
         68xGgs7kA35GtfT5U9cK421Ck0omcDeWTZTeNq81L9wZggkaATAcX/VhjYC6dFtv1nBo
         5hqYNwOfG2Am2rGa7TNqj2+cJ239xC6EpDOcPcr7YZMMD9IW+aYWfJGUqDWEmYIgRA1a
         n8bxYS/QUY/4l+jYi17CQbHC7J2c9w5E5zaB4/gN4ibllIJJV90mAp4BZoMXompl2IGG
         924Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767808182; x=1768412982;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z90nFROdPtst2IKVs/+csEyxpI1YETMH4mOHgmwYj7o=;
        b=Kne89O6ht8XZuBiVdI1fuQXqIVMAMeW0y1FSSZdN09R0pdVXNX+m1hHMsEeqB3CZwA
         6Ga7x0pUKFcbXJ+7yiN+Bg56Hzz21us/VtaPfY3OY5bP8D0MCXSP2alrEqMQEQHbE+rV
         Yi8udZlufLv+xmxNiT6SE9wfIUlwvI5J0EU5bqGr75lpPi5IeDOCw5v4AyW5XVZ5eq5s
         4LecTFzEwko18eBCVl8vuvgfW9lBQTy2CC0bSSKX8Rm9atH8mR6zpIdSJhd5sldmJTrP
         FakQcSwQ+zKnEDNUcAHsg8mzKE6YiBD+y/fLaX1zUKkwIkotMfoQI1ArHc4n6nkVPlnb
         v5PQ==
X-Gm-Message-State: AOJu0YwCllebQfxYI3CEQNoS4agNicIi4BpBVHuhk+qzD6BH/GHaXLVI
	iL7lQeMG/zdyocCKcgABw8Kf8iWtwlBgyzAg1rpbHeaqJxXaEFePk/CJ
X-Gm-Gg: AY/fxX55d3kMShgkGuH6Clbc5ROocavRloE8lbEX8IMCPYBi5sa9o9aHqyMdQAQlPdZ
	WqPXC2kwlcKp0X7jFVWRnNdR+dnGr+OpXEepvgXDJea+wL5GEyZ1mEc2dm/SMN3/Jt7dLOTszoh
	E0n+h2EPS9WuEXt2l1DiTg/nROIn4z8lamQvQ6I0zSg1LggFT1WzIYqnKnz3bz1qRAONmPAcEpt
	tBt9XafxETBsZAgenju4CtYo5x9b12AqbuhV3XAtguvZmq9fR+vQtPbRRVQ86ZO7f7uk5416NBZ
	xKMELyizTsHstzWvp/AWuW5VZCmwy1+2mKzYUBbp44YxhDhNLt03D7DDPkEYx8PuDa+UQLPtV0D
	9MZa+kgNrKhDi4ald4zoP1KPC1ebDS2BxcRiYnF+Rc90GvlErSiR/0P8v/m63SgOS604=
X-Google-Smtp-Source: AGHT+IHPYoy1Gh+KsAYZrWNwn8ZBMZtjb6cbA+0QVRUvRahVtY/3GqS0f+5DMAxSuHBQRsLuNgYBxQ==
X-Received: by 2002:a05:600c:3110:b0:47d:3ffa:980e with SMTP id 5b1f17b1804b1-47d84b4101dmr34711385e9.28.1767808182234;
        Wed, 07 Jan 2026 09:49:42 -0800 (PST)
Received: from localhost ([2620:10d:c092:500::5:d4be])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f653cd6sm115987495e9.9.2026.01.07.09.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 09:49:41 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 07 Jan 2026 17:49:10 +0000
Subject: [PATCH RFC v3 08/10] selftests/bpf: Refactor timer selftests
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-timer_nolock-v3-8-740d3ec3e5f9@meta.com>
References: <20260107-timer_nolock-v3-0-740d3ec3e5f9@meta.com>
In-Reply-To: <20260107-timer_nolock-v3-0-740d3ec3e5f9@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 memxor@gmail.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767808173; l=2904;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=I12f8/2m85P/qMhnRxqBUg240K5nCwpW7fUenuGUBFo=;
 b=grmIi6Gy4+gbZyBc+Rky8FlTimwsgWUFTx0RWZhjTM/yJ9aMDziwe+squVTfglQ1JCkkP+fDR
 QzzjHi8NkHRC40cU8AicoUM8H9ucousehYyLZ3J5OmFbF5plGNs0xEM
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


