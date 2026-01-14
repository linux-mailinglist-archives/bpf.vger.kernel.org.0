Return-Path: <bpf+bounces-78950-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2CBD20CEC
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 19:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48D9430FDF41
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 18:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E81D3375C2;
	Wed, 14 Jan 2026 18:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LX7/TLFV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C95184
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 18:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768414994; cv=none; b=K/sIvZzDtM1y+6U7QH4ZSYNXi3V4WxuAbhtCarwRk44KCPh6m/mn8Y0gQolmKEJZwLkzxr0MlbyQGBtxVPRYS2APdtx1l+BUsCFQCd2LBlsnBqNE4ie39QddfPQxhDeahGWT66WLcHpiQidpK616GVH3BZNZKDFhofLX2dqwUMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768414994; c=relaxed/simple;
	bh=GhLUF0L0IpH45tda1zr/y9KpIGofV4tcu+8hyTPCFfk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JG+61sC1LK0FhZl10fbAG13EB4Ew58x53PHi+793ucxQWb9+uqocJwMdn4mrJqd6WNpI8PSeRDctSBkEiilJOvpLxArHCuA8c3DZzgGk7CEHazTqardupgX4CbvPv89gqy6Snd4hwjTtgUTzNY8jHoaM4luU19i9+QiuybEqFXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LX7/TLFV; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47ee3a63300so1164195e9.2
        for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 10:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768414991; x=1769019791; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0xLMYYolyJjqq6i9TpWAlkvvOL0WcqfDjXNv5Xko3nI=;
        b=LX7/TLFVHtRsBEwwK2DemYD2pImwUrQbJZ+N37mGzC+1AK43X7QBcFx27DPDYecAtd
         mSYO2Q7OObjXzvvhK82j5dKFlTNGIS3anEYk71PddLB5XnCIvePEcYe/E9FbdbUxd8r9
         2GIfLFbJu+9tThtW8GxFyqoig6ZYQtok/EbzGM41YbMzgaoXwrYlzPLylTCihrjZVbr7
         W/jHPaIoGYbOpKvR8VJZrbpoNeXotB90Rncd13/dOPNqPMr4LGiLUKcAvtdisoJdRyu1
         idbt4By1jRK/BEpQzBWq3ONGfv8tm75siwNOTsu2NrN+irSkinWz1ZZpZsSIODIbPEhw
         Np6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768414991; x=1769019791;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0xLMYYolyJjqq6i9TpWAlkvvOL0WcqfDjXNv5Xko3nI=;
        b=nz6W3GlZ8GSNc9czHBlGFzWSj/doflvSg/pX3JZnaP74s720dgQ6ho/0dhejMZiJwr
         ylxyGvZHCtd9I5OcQdiIDMJ+uqBkNvTVniPIstTjVKjO09D+wVOwFOxaIRKcdtjyqwVv
         JyhmXaGchuEcHsKrWFVF+59E/3+KRB+rvNWKkbRLMCBIOjrYRJuO+KUajcjDawFJQT3p
         gs2CqfEi+bdLIEmJMedMyV//EC0l41FWdQsmI4knEhM9W5cMk5leKJY9/058JPhWK6Vj
         uzOup3E7crNopjfXcu1RuSNUomjHg5LZbLrq2dfru0TmZ6Iudc9QAB8UPOmgJaCd6ldd
         3hHA==
X-Gm-Message-State: AOJu0Yy5OsYiHnbYJvrDtGIdx4Z1dDIt1M2/fPhR+Q11X2GLcIFF11Rl
	40Cv+Rx5RMHljASGi+w5eU+jbihqdfBmR3OuMaksRxSDo9p6EJdKdamZ
X-Gm-Gg: AY/fxX5OeeLaKJvT2iimoqmgJ6WxL8B/SKafg/TyDD1i4y9PdCza0NG5YrS8Ij0mNFX
	Hty1WGX33oSQcMaTjbV5NOAwZw48+6m0fY4/6bse6ZC0lJ+RYGlf49M7AichlwI6yazOXujDi3m
	rwfqICUrX5ae1cnFcu0ylIt0agEN2Ne21opjnLUbeEA2u9Q8k6zpAM/QjLxiBZfnJZcToH0ccZJ
	OWwbeSVn0Ng12OxgsQyXkWlc2eVUY8W4QFUxxEcTXk4f/jUhMdzSnuJYjvmjMczgOs0gNtyD0a1
	gVffPTyYPDTO2yRlWWnkTwVOPgeMvrkk5xrTbTYbVhf4sjG10/RNXxsxxkVJR3SH56eT7WdXfJG
	85zwJuTXVBxclxX+Tj5v9r7SAKM64O6atoTbknLbjbHzuN39vs9OqEMmg2haMpzk1QReP5G/qPV
	gt/RxHeKE7Lg==
X-Received: by 2002:a05:600c:8b33:b0:477:5b0a:e616 with SMTP id 5b1f17b1804b1-47ee32e5c71mr44133175e9.5.1768414991249;
        Wed, 14 Jan 2026 10:23:11 -0800 (PST)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af64a778sm763289f8f.3.2026.01.14.10.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 10:23:10 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 14 Jan 2026 18:22:51 +0000
Subject: [PATCH RFC v4 7/8] selftests/bpf: Add stress test for timer async
 cancel
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-timer_nolock-v4-7-fa6355f51fa7@meta.com>
References: <20260114-timer_nolock-v4-0-fa6355f51fa7@meta.com>
In-Reply-To: <20260114-timer_nolock-v4-0-fa6355f51fa7@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 memxor@gmail.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768414982; l=3034;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=8om38gAdspUYGhhX2UZoUsJGe+8wJ7bi5do3dC7FV58=;
 b=jO48DKOXOzt2TJVcGIaKxLE7QzbyKaRX3GNOB926nM/Cj7HEd2voPUA5sM9DeBoMpI/zlMlzo
 DdWIxyKDMctDUJp3aYb1cwosMm1fwuZl7Rv+teKmbzkumsxCCb7vTHF
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


