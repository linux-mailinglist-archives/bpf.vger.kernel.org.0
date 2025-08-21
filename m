Return-Path: <bpf+bounces-66240-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A074B30018
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 18:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 284251C218BC
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 16:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661DD2DCF71;
	Thu, 21 Aug 2025 16:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNiU7wJo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EAC2E1F01;
	Thu, 21 Aug 2025 16:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755793566; cv=none; b=UoqsA6ONEUjKOkyjIk2rpnLw8OebGtJVYVA/4/T3qTQUsI6ICmYhm9wt2LvRv/j5rc9sElp4CfcRfRqnMV0paSjSb957oPCqJKE5A+v/opob7uKJbE/7RxlvY10ir+o4wgG+Dkh7CyrHpiN6fSuQt178dwXM+t4zNWE0NkG3+Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755793566; c=relaxed/simple;
	bh=39w/P912HxxRO2J7nfqfTL97c1JDkPmOEVExc2gBAS8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eXOjGV23KREABxgSO44oh+MzyQoX1H7baDNZFQpDhA5JEkkhpOpAIOofC1LcblQs23DKQY35hGQIYcrZ42bmJRXgPLsa/QsoCHBBtj1YeluqTMA2sttiJ5kuDU+W+DOQO+otXdfF7at4Mh4OYMb9CtN5iCMcRou5NRSGWHh39HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNiU7wJo; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-afcb78fb04cso162585466b.1;
        Thu, 21 Aug 2025 09:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755793562; x=1756398362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2d2a7EPRfILJGAfQnbkIn0Fn1zUwbQ5I9lTA8AtYmE8=;
        b=cNiU7wJo/LWxr75VaW3QTRBz1tUv11kRgyxSwUzVTgmQROTpWU221atBLr+uSYwmH9
         DC+3gCDP3g7U4NxMxgWPY/sratck8ldJZ7tM0KiOr6SPHYXNFgKucxX/yDb4D1zK2pcR
         YwN1X4wV6K2xId+Ke2VgPK1rjho/D8XQ+J0wZJjyiQOYlJWHgxOoixtxmBcU+6DvP6y8
         xV6zuPF0jR2/MdwUNifuUXEyyJdvTN6ud3ULeWGr+wLoqyHfU+c/J4/NaodTCTIY72sA
         PGmky/0HdRc04ZjLSsI97wiJhk+i+RLvm9vd/yCv8SBdcd6ktzYOclRLxqf63WmkaGsi
         xaOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755793562; x=1756398362;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2d2a7EPRfILJGAfQnbkIn0Fn1zUwbQ5I9lTA8AtYmE8=;
        b=YyYknAmoHSFGbrxHgu4tztpgJq4+FFx8RJpA/Q/EFaj5T+N/g85/uE8yiF6t2YBcQQ
         PjfruGMjpfYLzdKA+FKawyJaUXFO3U/c0lm4KffQY0Nd+Xx09FKPwakqZccahhpIaEPr
         SIGaGAAS0jQuJqzx2UpkpiQeeoPmm7ZbZRUa5F5k8MQQaLBoc5LbXgQjCrHgVcHkdagF
         mW3EeoW4v4djusbjdIXdHWEGrE59S52saf/3xV2dffd3VoWEwtJAQA669m4sV/eAArQr
         t/rJDizIgz8jlD9tkCDXaInBoFWk9H04XpXQXtq8ICflMJgwQ9ohffB5onrFj/eurFpt
         hDvA==
X-Forwarded-Encrypted: i=1; AJvYcCXXwPSFCoK+C2bwS7uXXZNe1YeE4UTdllaFx2I3EIhSIHtvukLezwt+7DiIwtyCDCwstbXeT+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLScSayN/Da/H1eo3hZaSyInHQ2R3jfrTCdIGkRNBYf7XeO29d
	IRvZAzpct1YKJ3T/xs2QwG6kDwNmrdmghEIgVsBfVOkPHs0NeERwMoD6OI1B/MiC
X-Gm-Gg: ASbGncuE9uXKU1d2shHPUEo4e22ObfKdxYfBi/PpZHSjBsDGelTGIItRdN8hFpSWxjr
	LdH1cmTEQ+haAnhmJH3rOhRz+iEi2E8e/rCVZkPR6w5xIuyp3gwKvP4PiU8vYaGVjOSY5mhrNsV
	swXAnFZX/ps3pqB6E/6NFv33wTnQNx08vrMwkyGbTMJ2e02w4DZjD0sO4yhWetNMnUdS1CHkxtu
	gP2T/sTiUXKJavvWqu5s0R6O7rpvk8zsHEGHxhvR3xIZxZkz10rD7CXsQZqlSnBQYqtZKaQOXv2
	wAfvdFDg5Dt2tvTrhKKtuI0st7L1Y76DCM5LzoYqNFmXp31qYCz7cxI8gkHTvo2c/VQMpkk7uLh
	UjnviZASkj9JSOINIJOra7/tsjzmB01juf9tDsM+chjgJ
X-Google-Smtp-Source: AGHT+IGxON9wvgiVHgSgxXlXHvG1m6SjImvCEc6HOjqCGZZUTyigIlJeDjmsSSSXSxHgXK9lb7PWlA==
X-Received: by 2002:a17:907:9726:b0:af6:361a:eac0 with SMTP id a640c23a62f3a-afe07b9cecamr300165066b.32.1755793561785;
        Thu, 21 Aug 2025 09:26:01 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-afded2bc305sm411507866b.18.2025.08.21.09.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 09:26:01 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	stable@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v1] bpf: Drop rqspinlock usage in ringbuf
Date: Thu, 21 Aug 2025 16:26:00 +0000
Message-ID: <20250821162600.1627359-1-memxor@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We noticed potential lock ups and delays in progs running in NMI context
with the rqspinlock changes, which suggests more improvements need to be
made before we can support ring buffer updates in such a context safely.
Revert the change for now.

Reported-by: Josef Bacik <josef@toxicpanda.com>
Cc: stable@vger.kernel.org
Fixes: a650d38915c1 ("bpf: Convert ringbuf map to rqspinlock")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/ringbuf.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index 719d73299397..1499d8caa9a3 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -11,7 +11,6 @@
 #include <linux/kmemleak.h>
 #include <uapi/linux/btf.h>
 #include <linux/btf_ids.h>
-#include <asm/rqspinlock.h>

 #define RINGBUF_CREATE_FLAG_MASK (BPF_F_NUMA_NODE)

@@ -30,7 +29,7 @@ struct bpf_ringbuf {
 	u64 mask;
 	struct page **pages;
 	int nr_pages;
-	rqspinlock_t spinlock ____cacheline_aligned_in_smp;
+	raw_spinlock_t spinlock ____cacheline_aligned_in_smp;
 	/* For user-space producer ring buffers, an atomic_t busy bit is used
 	 * to synchronize access to the ring buffers in the kernel, rather than
 	 * the spinlock that is used for kernel-producer ring buffers. This is
@@ -174,7 +173,7 @@ static struct bpf_ringbuf *bpf_ringbuf_alloc(size_t data_sz, int numa_node)
 	if (!rb)
 		return NULL;

-	raw_res_spin_lock_init(&rb->spinlock);
+	raw_spin_lock_init(&rb->spinlock);
 	atomic_set(&rb->busy, 0);
 	init_waitqueue_head(&rb->waitq);
 	init_irq_work(&rb->work, bpf_ringbuf_notify);
@@ -417,8 +416,12 @@ static void *__bpf_ringbuf_reserve(struct bpf_ringbuf *rb, u64 size)

 	cons_pos = smp_load_acquire(&rb->consumer_pos);

-	if (raw_res_spin_lock_irqsave(&rb->spinlock, flags))
-		return NULL;
+	if (in_nmi()) {
+		if (!raw_spin_trylock_irqsave(&rb->spinlock, flags))
+			return NULL;
+	} else {
+		raw_spin_lock_irqsave(&rb->spinlock, flags);
+	}

 	pend_pos = rb->pending_pos;
 	prod_pos = rb->producer_pos;
@@ -443,7 +446,7 @@ static void *__bpf_ringbuf_reserve(struct bpf_ringbuf *rb, u64 size)
 	 */
 	if (new_prod_pos - cons_pos > rb->mask ||
 	    new_prod_pos - pend_pos > rb->mask) {
-		raw_res_spin_unlock_irqrestore(&rb->spinlock, flags);
+		raw_spin_unlock_irqrestore(&rb->spinlock, flags);
 		return NULL;
 	}

@@ -455,7 +458,7 @@ static void *__bpf_ringbuf_reserve(struct bpf_ringbuf *rb, u64 size)
 	/* pairs with consumer's smp_load_acquire() */
 	smp_store_release(&rb->producer_pos, new_prod_pos);

-	raw_res_spin_unlock_irqrestore(&rb->spinlock, flags);
+	raw_spin_unlock_irqrestore(&rb->spinlock, flags);

 	return (void *)hdr + BPF_RINGBUF_HDR_SZ;
 }
--
2.50.0


