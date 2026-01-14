Return-Path: <bpf+bounces-78948-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE15D20C68
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 19:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 505E23020528
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 18:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163F2335545;
	Wed, 14 Jan 2026 18:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWiHq+A2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2222264AD
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 18:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768414993; cv=none; b=bSwfYRLbXiLNcgfgHJdRdBGzqfccq6IO8uzzI1rZa7Tq94toFlJy5GZBcgEdKAmwaF69Y/j47cxbM0thqQGn3hh+zMhgOXgDYexLzEvkVMDIgNh2E9kKx6GQKgGm5NoqJGurlP4qny1FrLEQKMZbgqEDU2DbIKBcJxTysz+AwvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768414993; c=relaxed/simple;
	bh=SWyMRCjSOVCSx3FWxZDLXZnAjKeKkFv9M7p4lS61Opo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PSgAPwbSSargErr/T8Z30JVaEqck44AFbcos54nDd8ujXU6LGbPgETriz44eatoCGp+j74Y59zzIB4aFPp/AOhWVOx6hGLvmcU+84o/Gjn8JZQVD0Z5FELMO5uy2O2T6IXtoj8oiHT5hakzLI6rgc35U+YUeuTxq+FB8n/r5ewM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SWiHq+A2; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47edd9024b1so908015e9.3
        for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 10:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768414990; x=1769019790; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z90nFROdPtst2IKVs/+csEyxpI1YETMH4mOHgmwYj7o=;
        b=SWiHq+A2H2g97/Neu44A4UPOAhsRxRnt7WXEn2G/sqOVt++BKDFqisWLjQbE+Zdtmy
         wLWxw0A/Coy89Mq0bdsM1TFi05FzOCIf+1WDStX8nF6gIcwmGs9o2vUSdM5dgwwFsstI
         P9scgX24lPPnaLl2M/s8o8/DyzzJPH4Iv49teAkt22G4N+Z5gNlSbGtQeuTNFvH2KYY/
         oxiHoP0FfEE+jA7VRUls/rvlYXfK6N1O069t+3PeWhH8cmg5bX4uRI88egYlrFhLYduV
         C93Uw/URX9aRjWPIaJcgVovFHWVoE6h5UxgdimuMXxSHvjnbVVNld1hNseE1d5uxTrHW
         jg0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768414990; x=1769019790;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z90nFROdPtst2IKVs/+csEyxpI1YETMH4mOHgmwYj7o=;
        b=lkW0J0XMRdUea0idGFKfl2vc1PxTLxrjjtEYRsW75vefu1PGMTIAmEuLXnUPk6jyDC
         XHeD1Wj8VgudjGfRXQN6IraeTpP54to75FfFCVH6ezNuz/4+BhduYc/5nw/5zIxcYUXw
         50ZvhUJ73u4M6bGuPA5WPgyMXANoYUIimFjZXHg7xqzSFa1HEOKqoB9nBKERvw94QnIk
         WALro0JjobIecwGbkiTM/sInE3TpuRV8KA2GKOm3IpC3RINwSnIja4iVPOOATHL0s+wf
         94HcQjTPPmK32n2YQ0mR6mTu48/QgO5GRSVuMoboRCTQDbufljGCvXyMIPVgjj7XV4z3
         V4zg==
X-Gm-Message-State: AOJu0YxT5FaHw7WH8GNPrEwjOIYf1A9hWYwXANnz2zNaspa414TEsX9B
	EQQ7huRoGrlQIM3yT1jL02jdofUqyPtBwiV5bjk9D/Rll2z85PVkUIM1
X-Gm-Gg: AY/fxX4STMmTTl/5Y+J1bydFGnJFvnTquu1NTuliIKG9sFHQeY+uTs76A7kpqNt9HmQ
	hMzwW3sDRa18PAvtc5Gpx49hJ1Y7RpYmTChiE7JQr3hzwXQamBG4DD0LRYTLgeRUnRZbYd/Gwg7
	7epXosHT3pR488cTESsmXjySBjitOQLNBtKho8a0sjrDE6gdqWVvAe2byYmFTWdqltvbERHDjwx
	7Y1n0auFl57xUcDTkrewH0v74lQrAWS6mUNZmPFbZ2bBOwi9O/RvLlKNK5R7BSbNOjl89Lcjemw
	aaTFMNy0ZheLF77OPbnD8FcOp2fQZ94Arpor2E30sNBW9y+y0EcM5j7BRVPj4HX9fZCMs/Rd6e3
	k7fUcVnbzgaUL9TtNvZGpjo55NCJEVOuaAFI7+jjyPhL4ljv6Cm30gF9LcIpQTwDuO3CqTZYqeu
	pfTVVGHN71yg==
X-Received: by 2002:a05:6000:18a9:b0:432:c0e6:cfcc with SMTP id ffacd0b85a97d-4342c4feed4mr4560649f8f.23.1768414990306;
        Wed, 14 Jan 2026 10:23:10 -0800 (PST)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af653745sm749822f8f.12.2026.01.14.10.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 10:23:10 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 14 Jan 2026 18:22:50 +0000
Subject: [PATCH RFC v4 6/8] selftests/bpf: Refactor timer selftests
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-timer_nolock-v4-6-fa6355f51fa7@meta.com>
References: <20260114-timer_nolock-v4-0-fa6355f51fa7@meta.com>
In-Reply-To: <20260114-timer_nolock-v4-0-fa6355f51fa7@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 memxor@gmail.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768414982; l=2904;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=I12f8/2m85P/qMhnRxqBUg240K5nCwpW7fUenuGUBFo=;
 b=aRJJIvWztbN3NUxolUsRlwePksu191Dcj3qVUgNx7gFqjCIpFPBnq5uKeQaI6eI2Bu20nfBDl
 mAs6JBkmDEcC6avxWzsggkLj0aBZi46WYfaiQTpMBLqq+zfzqC6zzMm
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


