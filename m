Return-Path: <bpf+bounces-78141-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF915CFF8ED
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 19:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC84F3391600
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 18:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BBE398707;
	Wed,  7 Jan 2026 17:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9oFB2Zx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839E338F22E
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 17:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767808192; cv=none; b=Vm5j0JfltZD4dt8K60wD61XSNCZrUr9sqVFbOfFo9/Ai0bar2RqnQOWg66S/fG1gKyLlCiKpa+JKermqQ6joUSkpTkBTwZrbHi5KRxeX+Ju4w92Cq5224BUjG0V8S7/pJaqXKNkDVTPO97brWzNTCuRrRxKrYGYiHp+a6qyZmKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767808192; c=relaxed/simple;
	bh=GhLUF0L0IpH45tda1zr/y9KpIGofV4tcu+8hyTPCFfk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qM5Cfq7RAmvzQKDYz2gLcGCCA2+ESAMlKZn0pKyxdYHcBUeYl7UDjGGURu9TAoYEn0wclzSQtnx/KdQtMbLXIonLxpItd+ur4ECRy2g/WbbwTsqtuenqeAyeBEbN8E0dKdwtwq7/2w75d2ZfDAclmeEZ+54JygpQgO6Qkd2KoHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L9oFB2Zx; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43260a5a096so1601151f8f.0
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 09:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767808183; x=1768412983; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0xLMYYolyJjqq6i9TpWAlkvvOL0WcqfDjXNv5Xko3nI=;
        b=L9oFB2Zx0TGPP/MrNfNsKKr56h4iaNZWG5QuNH65VSC6bk5C3WsZ9Ke0sUJ+I85yFp
         i9eMDGWQWCOdS0tEILyxm7+yjhx4tD3gVNC6Aje/p0EimGfnVY/1WFIeutrZuCth1Adz
         E9npN78Ufr/RKQqepo1zKtQlTYzz8TV3UF8Bs34YSj7kZMagp9MVqUdXGeUMl69srLXy
         8zGKob//umtMrw0CFyXSEVS7oOzYU6gc1jH6IYfJiY3+GUTJYztd6y2PmIBlO15kgnqe
         zACT64oklg6pZcpu3UrJLM+6W32oJC2M0EfuhmG+Drsglt+1MOXYNELygiq8dnEEAr+a
         XYng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767808183; x=1768412983;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0xLMYYolyJjqq6i9TpWAlkvvOL0WcqfDjXNv5Xko3nI=;
        b=c0FxGQdBu2NYrxdZvbypOsw55oVdmQrXCArFAIlw4wAzCNc0Shu/Fzb50PpEfDQoQP
         55R+ZpfD56D7i4IilkkBkp/w/S4DQMkSwVd8m24em44FRn2GZKJHijbDHG8U09PoNarp
         cAswmW3NNVx4X2uY9+Z5fyf21aXtrc9lxURtovIk/yJzjHNniORYULa6qr/JOs4xmDgQ
         Ak0u2hicQOvRVsLJxmqIcYOekEk1K8O2yg0goYA80Ahhy+QIxlgd08xXRT6IsL9d/CRJ
         3/877uMivoo9VgggX91hgQM98v15MzH4OjzzvsY9rweux6G2jTtb/MOr/EWemQXXRyMb
         ilog==
X-Gm-Message-State: AOJu0YyAwAnhsVU/NvJ8B4y+FRN+6lb0eNVFEhQSeEIma8NzWpTVMy3a
	9BRljlZFa8H8lK7K37kiVjSKKaUNht8CeflIg92yIwg7NAzFVjf+hz2n
X-Gm-Gg: AY/fxX6feTLF4xN8k0K5Fl8ihZeq4XE03oorxX20JlQeg3tIFOPBAtoqpTPXcRdVHVU
	9j3DEPvBFaltNG81/esmeqIrsysxTmsDmbjG9O6r5JZW8OBKKCg4mUrvdbey/meBG3uNXuwoOwH
	Mn7xrDReheCe3jh5FAA2LX1mCJXtsjL7+i2PzksiDuY6hVH46J+k/16Y9gPNxKdEJOxdtM0tZsO
	4HrcxJAfPkAc1yGe6OpcWY2U5yk7xO1Kt5ke/SadVxjzyO5HuuZ07FTQjEq8tRSlK8lhevL8yAV
	2EZC0xbo6b3Jlbbw5+BZ7pBvEYn52P09hYFwcNzlYOKd70b1TKJHDq3DNImTbkS/Y/TT3Hsh/r+
	Ai4O8aqtEI6V+61247nZkT7mIIJ7wIklAFsDWz6qaPN8SxI+pSYjPiVnFYdggKpEt/OM4YpMvpf
	hI6g==
X-Google-Smtp-Source: AGHT+IERpcRzyiJMhOcfmeKtYgPRtExq7kix7yxpkuO4QAsaRCvocj4A/IYnhM2QGPFgCXBMe/CJ3w==
X-Received: by 2002:a05:6000:144f:b0:42f:f627:3a99 with SMTP id ffacd0b85a97d-432c37c87efmr4877610f8f.38.1767808183067;
        Wed, 07 Jan 2026 09:49:43 -0800 (PST)
Received: from localhost ([2620:10d:c092:500::5:d4be])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5df939sm11469895f8f.21.2026.01.07.09.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 09:49:42 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 07 Jan 2026 17:49:11 +0000
Subject: [PATCH RFC v3 09/10] selftests/bpf: Add stress test for timer
 async cancel
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-timer_nolock-v3-9-740d3ec3e5f9@meta.com>
References: <20260107-timer_nolock-v3-0-740d3ec3e5f9@meta.com>
In-Reply-To: <20260107-timer_nolock-v3-0-740d3ec3e5f9@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 memxor@gmail.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767808173; l=3034;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=8om38gAdspUYGhhX2UZoUsJGe+8wJ7bi5do3dC7FV58=;
 b=HPdKP2kMkNpT/y95D1X8VSBOaY45PX4hj7aZIyYea9ZHggwoph2lCOvSD3ZdmtdtcHi90CIJV
 +9B6cYdZoKGD30+2RarXrrw5VmC54MQkJ99vLZHI8viMeUBlt96Knv8
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


