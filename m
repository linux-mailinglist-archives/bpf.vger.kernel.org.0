Return-Path: <bpf+bounces-79117-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 66071D27B8E
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 19:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 70843317F504
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 18:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C6C3D1CC3;
	Thu, 15 Jan 2026 18:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6XizVth"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFED3D300B
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 18:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768501757; cv=none; b=MUZLSrmRqwiOuRQhr0RpqmUPXffEtellcGMcKom2Eb/JQxGe/yZr1XlpBL0ikd/fIRxCEJiSNsT6Okat5XzrHTIErIn6vhm7wh5ilWTT7yOBWyVtL1a8O67m5+lYblLBC0lX9K011DKiP7Bt88PHFBmJLNGsyoywi+pq9MHKLvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768501757; c=relaxed/simple;
	bh=GhLUF0L0IpH45tda1zr/y9KpIGofV4tcu+8hyTPCFfk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=esSGSZ0ONMAnlu6P53/PhJ6QJKcAV9zLb19px/FGlYP7c99WEYCdpycnxc/iqULjkg4mD3oOR6QtTw/BcYL1KRfMnNIhWrPCgELPGu90wWvncpKmUaO5HOHc+wWpDyFcEoIqWExi18+B2ZAF5IsmvrcAcRhKBLik2ImFlWa3ce4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B6XizVth; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4801bc328easo6982895e9.3
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 10:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768501753; x=1769106553; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0xLMYYolyJjqq6i9TpWAlkvvOL0WcqfDjXNv5Xko3nI=;
        b=B6XizVthZEcUFhJdaMdFGrq7LinExRVy2hGhch6lHTncbsGm8PLvhP6kQqkZaeRE0H
         ZzCYvGJnxZfpT0oqiYauup3plEZC5LA8mR7FM4RNnNmrxxBF1IeucVana613Kut9v1ZG
         IBI/ZpASkuz7KEy75Fe5YZ3apQXIGuz5vbOPOvfGMKMeR2qfaP8rnyGMLNkuBkjOJHpG
         nW5y+dJuJXu2Fy3JQyvhQFphNeBp6JFsMHssZM1yysuwnfqoKRLXmR+JFYSqT6O0ehcL
         KVhX5sPQDEbiHTGk1xslY1rcOM7kz1XnevXda5IRNyq7Gp7+HLwuwhjkeqLr01G15EGm
         mLkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768501753; x=1769106553;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0xLMYYolyJjqq6i9TpWAlkvvOL0WcqfDjXNv5Xko3nI=;
        b=EkciB+ELOxPtLWvm0HYPhKfdA2v5PV0aKvnCMZBlaMM9i8qhDdV4evvbGLrLU34rpO
         zGWYpL/MeeLEYf4CKW8mk5hgzvLE7AgvovRp1Ptcb8VE19SCM76pE0tNuy+qnKA6+S1t
         oXJNCFj20Duv78voiwY+4DHgVZxMxoqJGDU9B93H0RVpVy+Uua9EhXk8NzVANPC/NNuL
         bXlFoCtq9YH5f7MQ3CgPAs6RgMH/ZerfqyBRUcOSAvhquWTcpnd6VZSkbrSOtGZXEdTl
         KTiIXMhh4Q6rvb3268QvQy1b1ojWE3vgRpxkb4jSDRUrmi7Cj+RhZfcX4X4s6Z6UgXLf
         rG6g==
X-Gm-Message-State: AOJu0Ywqwoy7c70Qq1XnAFeU/CMXEi1NcDJ73CKSatcEwZzN+WbC3KGn
	zxPCQJnBkHzWuQA9WsWZuJY5ttNQpJSrdoRso0kfUfy+1+//ehGxqbYhOwY83g==
X-Gm-Gg: AY/fxX4nOU6TyCpNr1mBh3XItn7kuZUss9tzsRuDunEF9BZ4XsTN4hmHxQfjf7UwLiF
	DIEhiDw2nCyRD8tLpr62sKMYASHDgY5J/fDvKhVoIPNBf7Crdvy3D/T2SAIFAWiQyCkfGFfAe29
	81xVansudMKVB6jgKSnq44nDT4gs/9Qiyq8f9FA8wMIWsydk1etVOM7WSgP5YBSkTRkX9i3nqlN
	hF+nUh46DsIK9t2NgrkhB5fYRwhWrQGBjYuYIuUGByTNZGqhlIaoSH35qbdKLpmNRnDbiyXEIR1
	9LRLdtEx41mGjaMM7z4m/yGw18qKQgiQLV51Bj8dCyeDNp7+LqaNfZbPcaR1oSM63ram1MYObva
	xHYaYbZw6IMX0RURtl0KO3+EwI/FgTPQ3/N+OTCKIzIVO/Z3IJYy4qhvu6pQKhLjAqeFAi27PD5
	HJ
X-Received: by 2002:a05:600c:540f:b0:479:2a3c:f31a with SMTP id 5b1f17b1804b1-4801eaae2b0mr1743255e9.1.1768501753367;
        Thu, 15 Jan 2026 10:29:13 -0800 (PST)
Received: from localhost ([2620:10d:c092:400::5:2520])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f428ac749sm59866655e9.5.2026.01.15.10.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 10:29:13 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Thu, 15 Jan 2026 18:27:56 +0000
Subject: [PATCH RFC v5 09/10] selftests/bpf: Add stress test for timer
 async cancel
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-timer_nolock-v5-9-15e3aef2703d@meta.com>
References: <20260115-timer_nolock-v5-0-15e3aef2703d@meta.com>
In-Reply-To: <20260115-timer_nolock-v5-0-15e3aef2703d@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 memxor@gmail.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768501744; l=3034;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=8om38gAdspUYGhhX2UZoUsJGe+8wJ7bi5do3dC7FV58=;
 b=jFpfjC/v8Bdjc0HDLaUVs+eHHfSOJYnzV14uLvUCqkc3YrR2gzEF9v2NET7JokWaSUvJPpiLX
 8xz88Okj2niBUFeqAxIA9tsa1+QqMiaT7x14EsuCITdi5mBmpZsojL4
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=

From: Mykyta Yatsenko <yatsenko@meta.com>

Extend BPF timer selftest to run stress test for async cancel.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/prog_tests/timer.c | 18 +++++++++++++++++-
 tools/testing/selftests/bpf/progs/timer.c      | 14 +++++++++++---
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/timer.c b/tools/testing/selftests/bpf/prog_tests/timer.c
index 4d853d1bd2a71b3d0f1ba0daa7a699945b4457fe..a157a2a699e638c9f21712b1e7194fc4b6382e71 100644
--- a/tools/testing/selftests/bpf/prog_tests/timer.c
+++ b/tools/testing/selftests/bpf/prog_tests/timer.c
@@ -23,13 +23,14 @@ static void *spin_lock_thread(void *arg)
 }
 
 
-static int timer_stress(struct timer *timer_skel)
+static int timer_stress_runner(struct timer *timer_skel, bool async_cancel)
 {
 	int i, err = 1, prog_fd;
 	LIBBPF_OPTS(bpf_test_run_opts, topts);
 	pthread_t thread_id[NUM_THR];
 	void *ret;
 
+	timer_skel->bss->async_cancel = async_cancel;
 	prog_fd = bpf_program__fd(timer_skel->progs.race);
 	for (i = 0; i < NUM_THR; i++) {
 		err = pthread_create(&thread_id[i], NULL,
@@ -46,6 +47,16 @@ static int timer_stress(struct timer *timer_skel)
 	return err;
 }
 
+static int timer_stress(struct timer *timer_skel)
+{
+	return timer_stress_runner(timer_skel, false);
+}
+
+static int timer_stress_async_cancel(struct timer *timer_skel)
+{
+	return timer_stress_runner(timer_skel, true);
+}
+
 static int timer(struct timer *timer_skel)
 {
 	int err, prog_fd;
@@ -118,6 +129,11 @@ void serial_test_timer_stress(void)
 	test_timer(timer_stress);
 }
 
+void serial_test_timer_stress_async_cancel(void)
+{
+	test_timer(timer_stress_async_cancel);
+}
+
 void test_timer_interrupt(void)
 {
 	struct timer_interrupt *skel = NULL;
diff --git a/tools/testing/selftests/bpf/progs/timer.c b/tools/testing/selftests/bpf/progs/timer.c
index 4c677c001258a4c05cd570ec52363d49d8eea169..a81413514e4b07ef745f27eade71454234e731e8 100644
--- a/tools/testing/selftests/bpf/progs/timer.c
+++ b/tools/testing/selftests/bpf/progs/timer.c
@@ -1,13 +1,17 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2021 Facebook */
-#include <linux/bpf.h>
-#include <time.h>
+
+#include <vmlinux.h>
 #include <stdbool.h>
 #include <errno.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
+#define CLOCK_MONOTONIC 1
+#define CLOCK_BOOTTIME 7
+
 char _license[] SEC("license") = "GPL";
+
 struct hmap_elem {
 	int counter;
 	struct bpf_timer timer;
@@ -63,6 +67,7 @@ __u64 callback_check = 52;
 __u64 callback2_check = 52;
 __u64 pinned_callback_check;
 __s32 pinned_cpu;
+bool async_cancel = 0;
 
 #define ARRAY 1
 #define HTAB 2
@@ -419,7 +424,10 @@ int race(void *ctx)
 
 	bpf_timer_set_callback(timer, race_timer_callback);
 	bpf_timer_start(timer, 0, 0);
-	bpf_timer_cancel(timer);
+	if (async_cancel)
+		bpf_timer_cancel_async(timer);
+	else
+		bpf_timer_cancel(timer);
 
 	return 0;
 }

-- 
2.52.0


