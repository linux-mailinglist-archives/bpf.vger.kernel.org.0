Return-Path: <bpf+bounces-55714-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7EBA8597A
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 12:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 328101BC0B9F
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 10:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26B829DB76;
	Fri, 11 Apr 2025 10:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCK6hLMk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C1629CB4E
	for <bpf@vger.kernel.org>; Fri, 11 Apr 2025 10:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744366685; cv=none; b=OxGgTrjbk0ZalqMPnFQoCdnANsiHKSSDzYM+PyQpmjozHeaeDnpUOr6v3wARd7WZhANf88U2pMCG5a5Qf3qYuEqQglPkNtZ/t3whJy59yDqM5BtBdXUuEVT6Dp3bTO5VYujvu6HtOAkTBsOE13pznoonT+h40H18rrfBZiW5wHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744366685; c=relaxed/simple;
	bh=cJ+CNU5qSe30UllGTTAsdTpxx+tzZZRU4F1XRz9tJJk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F3fbiiYXf9RyM9qHsBdSA76yHNtSEAQSB/E0hKyrd4Pxbv0fyHJOBuvqjzr0vIctJziONl3QuFKE2C1WVZ6Ad4JgUGlR2qAtHw4g776v2dah/FoLoO4vJIGGUS3meiDXgWQbYyKlP2mWaMDgZZ4Mmv713QxfNrvYDj42Q46duys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gCK6hLMk; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-43cfe574976so13157885e9.1
        for <bpf@vger.kernel.org>; Fri, 11 Apr 2025 03:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744366681; x=1744971481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4Py+dbqfEcf4oOwg3oQo6diC0Wa5k7KBq21XmI17sVU=;
        b=gCK6hLMkDXBLbavG3x9GRNqq7EgJ7H1liN8VHNEboqATYlu0XFn2uTSkR+qKF/Ji3V
         jF0SRWA6Q+5jzOmfv1WyhwMxV7QtbPWRt6wL70u4JxrSRsgni+gf8lYdz0AXtc9jTxd1
         NJ4c4qUXbny5HlhkOoqCti9mM3DCAayDXy8WwTIs0M01DIVcM+CCdGRo9uQApQB3nQWD
         boqmRrF0zZvkeNbEexVeKv2rMEiFtlmA+3iuu2yr+9w5ezqgBSXfTDR+GOnGps4MQc8L
         /WxN3qMTVZX4HHaapLvnZvpeIGVA/2O6MnpQHDL9E5HKwMJ6UM/uob8Y577SlpZSPfJQ
         6xXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744366681; x=1744971481;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Py+dbqfEcf4oOwg3oQo6diC0Wa5k7KBq21XmI17sVU=;
        b=m5ata0H+n3GgK4cprxi+TAALrxW5Nzh8pAnc5b+QNSUyuHTDL1t/piyN51Js57UAgU
         CX95+tBEPwCjDcozR+j2DITnEHzlnVvJHEouBMtB37MKizcA/yERQlYg4o9ndfh8yWev
         bJqbB6RBjud6ayNi7bkdBgpKlBq2EWkghEAbZN8Y4KaX/J8EA0YgRFXcrL1t3k/6VyX4
         QQLXufc+UUx82h+6tD9rMvaGnGkr7vsl2Q13a4/Uv65MgbRiYZyGfTX0qcLaHRVEisAZ
         fZO3SqKzz99v3Cd4jLooh85375dRIKc59aGsHWvQltrdQzYo+8xcMgc6/ORwzXg4eqfn
         +aNA==
X-Gm-Message-State: AOJu0YzhMcV6VTyUSRum/cxkmYhBgZ5Dcb0O7yEUoDNMBesfWO7CuDXz
	ohVBh3ru73KPT/RKkn++ONBxRRXy2MNykAW8xwW7yS2DCvvbgtaWltvlw6GklE4=
X-Gm-Gg: ASbGncs3axF6MztwaQfuJZFikwhZ/VRBNcdF6bE9gRKgKThk5n8ffY6AImcWaFokBUA
	PxZk4D12fcpHA73GWaCzOU8NcVuMO/PzaLJBFkxUT3R4mfskoyKOvU7ooVo55ldFylzGFWtVcWE
	SHE7Y95EVK65qsARNCHXYBPmyTScHyKLHGL7pfT82Gfei2Xc8pFnDXMO9JJx/tAWhD0oNsfgMie
	kZx0K8puiqJfYammog9eQ8I5X3aw28FsJuSrshyJ1CByqrvhvz/cW3CgDgMDZ3+UrUPebVUz2z0
	rFxstF91Rx1d74wfy1FBYWyYACbGCZQ=
X-Google-Smtp-Source: AGHT+IHH49aaEldEwOJ6b9aird7tsWefVc2Kl3XMwb3LP7A7D71tezKKQVdufWamNd9BoH7lzd0/kA==
X-Received: by 2002:a05:6000:2ca:b0:391:48d4:bcf2 with SMTP id ffacd0b85a97d-39ea51eede3mr1736015f8f.12.1744366680852;
        Fri, 11 Apr 2025 03:18:00 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:4b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f20a0bf4esm39852315e9.1.2025.04.11.03.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 03:18:00 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: syzbot+850aaf14624dc0c6d366@syzkaller.appspotmail.com,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v1] bpf: Convert ringbuf.c to rqspinlock
Date: Fri, 11 Apr 2025 03:17:59 -0700
Message-ID: <20250411101759.4061366-1-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5853; h=from:subject; bh=w6TZNP0TgDbH7c38Tv4GJH8/u3XCEzzuBM/1BbH69f0=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBn+Ow8P9S9WDx/ECKacR6GrUGxMu6kUlN+TBhUpkj6 /oVYr0WJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ/jsPAAKCRBM4MiGSL8RyklXD/ 9oK6AhK8Jhq6Hd3Ts7/ppsbSD9p04NjU/ujqSQB7fG8H3bE4Xv+hq8sepr6AiVEGZgx/cq06LAIs45 VuR7ekB0Ij6roEK/9mv1Ez/Awg7bgb02ErCiy6zZiT2j5Ata2r2Y5kgFmU6u/JqNG++qebwdsi/HcT lEIkzkY8saJ03DW0uwBW36AzHRZ/UPZpDJvuz5w5JVXdheo0dxih2KRFHAfVMVGVVkVOCdTYKNw6fv o1TAJlzB5QFlIUW66Mki2EIklF2WVpKVhjBZzvmpyqELXUdqqzJqrmXiv+oCV365HsgvcQvOVDw3t5 WHBkw45Vy30uJ/c2L2HJrQjx1vPO12zuhklYmNEei+y4kcRC3F90nl4w4PisgWBczcDOp0OuBcO2pt NIfDFum1pKs0eLk35VKnkuvJHREi8ZsNUJ2TcLvl3rZtRxZ/LxXnnefAlUlqByakbZx6F5joGXo6a4 0v+KqZdN8LbF9ep9tbEz88fuWToTxKfyYwUj+kEwn8UODJWMcltyg9eSqjtDooEgilwO7OQL/n1OlV bDFk5MI8d0rzDvwq69AZKwEC1gHciGHHp5iU9HOvgvH8edb5qGv+1DibBzTOj0E3x4l3COcUG3CvCk uIMnm0bN8djbKikWhMkrHqPCiPydHWyNZ01n7ep3Bun2w6TTEVWCTyLmZvMg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Convert the raw spinlock used by BPF ringbuf to rqspinlock. Currently,
we have an open syzbot report of a potential deadlock. In addition, the
ringbuf can fail to reserve spuriously under contention from NMI
context.

It is potentially attractive to enable unconstrained usage (incl. NMIs)
while ensuring no deadlocks manifest at runtime, perform the conversion
to rqspinlock to achieve this.

This change was benchmarked for BPF ringbuf's multi-producer contention
case on an Intel Sapphire Rapids server, with hyperthreading disabled
and performance governor turned on. 5 warm up runs were done for each
case before obtaining the results.

Before (raw_spinlock_t):

Ringbuf, multi-producer contention
==================================
rb-libbpf nr_prod 1  11.440 ± 0.019M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 2  2.706 ± 0.010M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 3  3.130 ± 0.004M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 4  2.472 ± 0.003M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 8  2.352 ± 0.001M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 12 2.813 ± 0.001M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 16 1.988 ± 0.001M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 20 2.245 ± 0.001M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 24 2.148 ± 0.001M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 28 2.190 ± 0.001M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 32 2.490 ± 0.001M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 36 2.180 ± 0.001M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 40 2.201 ± 0.001M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 44 2.226 ± 0.001M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 48 2.164 ± 0.001M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 52 1.874 ± 0.001M/s (drops 0.000 ± 0.000M/s)

After (rqspinlock_t):

Ringbuf, multi-producer contention
==================================
rb-libbpf nr_prod 1  11.078 ± 0.019M/s (drops 0.000 ± 0.000M/s) (-3.16%)
rb-libbpf nr_prod 2  2.801 ± 0.014M/s (drops 0.000 ± 0.000M/s) (3.51%)
rb-libbpf nr_prod 3  3.454 ± 0.005M/s (drops 0.000 ± 0.000M/s) (10.35%)
rb-libbpf nr_prod 4  2.567 ± 0.002M/s (drops 0.000 ± 0.000M/s) (3.84%)
rb-libbpf nr_prod 8  2.468 ± 0.001M/s (drops 0.000 ± 0.000M/s) (4.93%)
rb-libbpf nr_prod 12 2.510 ± 0.001M/s (drops 0.000 ± 0.000M/s) (-10.77%)
rb-libbpf nr_prod 16 2.075 ± 0.001M/s (drops 0.000 ± 0.000M/s) (4.38%)
rb-libbpf nr_prod 20 2.640 ± 0.001M/s (drops 0.000 ± 0.000M/s) (17.59%)
rb-libbpf nr_prod 24 2.092 ± 0.001M/s (drops 0.000 ± 0.000M/s) (-2.61%)
rb-libbpf nr_prod 28 2.426 ± 0.005M/s (drops 0.000 ± 0.000M/s) (10.78%)
rb-libbpf nr_prod 32 2.331 ± 0.004M/s (drops 0.000 ± 0.000M/s) (-6.39%)
rb-libbpf nr_prod 36 2.306 ± 0.003M/s (drops 0.000 ± 0.000M/s) (5.78%)
rb-libbpf nr_prod 40 2.178 ± 0.002M/s (drops 0.000 ± 0.000M/s) (-1.04%)
rb-libbpf nr_prod 44 2.293 ± 0.001M/s (drops 0.000 ± 0.000M/s) (3.01%)
rb-libbpf nr_prod 48 2.022 ± 0.001M/s (drops 0.000 ± 0.000M/s) (-6.56%)
rb-libbpf nr_prod 52 1.809 ± 0.001M/s (drops 0.000 ± 0.000M/s) (-3.47%)

There's a fair amount of noise in the benchmark, with numbers on reruns
going up and down by 10%, so all changes are in the range of this
disturbance, and we see no major regressions.

Reported-by: syzbot+850aaf14624dc0c6d366@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/0000000000004aa700061379547e@google.com
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/ringbuf.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index 1499d8caa9a3..719d73299397 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -11,6 +11,7 @@
 #include <linux/kmemleak.h>
 #include <uapi/linux/btf.h>
 #include <linux/btf_ids.h>
+#include <asm/rqspinlock.h>

 #define RINGBUF_CREATE_FLAG_MASK (BPF_F_NUMA_NODE)

@@ -29,7 +30,7 @@ struct bpf_ringbuf {
 	u64 mask;
 	struct page **pages;
 	int nr_pages;
-	raw_spinlock_t spinlock ____cacheline_aligned_in_smp;
+	rqspinlock_t spinlock ____cacheline_aligned_in_smp;
 	/* For user-space producer ring buffers, an atomic_t busy bit is used
 	 * to synchronize access to the ring buffers in the kernel, rather than
 	 * the spinlock that is used for kernel-producer ring buffers. This is
@@ -173,7 +174,7 @@ static struct bpf_ringbuf *bpf_ringbuf_alloc(size_t data_sz, int numa_node)
 	if (!rb)
 		return NULL;

-	raw_spin_lock_init(&rb->spinlock);
+	raw_res_spin_lock_init(&rb->spinlock);
 	atomic_set(&rb->busy, 0);
 	init_waitqueue_head(&rb->waitq);
 	init_irq_work(&rb->work, bpf_ringbuf_notify);
@@ -416,12 +417,8 @@ static void *__bpf_ringbuf_reserve(struct bpf_ringbuf *rb, u64 size)

 	cons_pos = smp_load_acquire(&rb->consumer_pos);

-	if (in_nmi()) {
-		if (!raw_spin_trylock_irqsave(&rb->spinlock, flags))
-			return NULL;
-	} else {
-		raw_spin_lock_irqsave(&rb->spinlock, flags);
-	}
+	if (raw_res_spin_lock_irqsave(&rb->spinlock, flags))
+		return NULL;

 	pend_pos = rb->pending_pos;
 	prod_pos = rb->producer_pos;
@@ -446,7 +443,7 @@ static void *__bpf_ringbuf_reserve(struct bpf_ringbuf *rb, u64 size)
 	 */
 	if (new_prod_pos - cons_pos > rb->mask ||
 	    new_prod_pos - pend_pos > rb->mask) {
-		raw_spin_unlock_irqrestore(&rb->spinlock, flags);
+		raw_res_spin_unlock_irqrestore(&rb->spinlock, flags);
 		return NULL;
 	}

@@ -458,7 +455,7 @@ static void *__bpf_ringbuf_reserve(struct bpf_ringbuf *rb, u64 size)
 	/* pairs with consumer's smp_load_acquire() */
 	smp_store_release(&rb->producer_pos, new_prod_pos);

-	raw_spin_unlock_irqrestore(&rb->spinlock, flags);
+	raw_res_spin_unlock_irqrestore(&rb->spinlock, flags);

 	return (void *)hdr + BPF_RINGBUF_HDR_SZ;
 }
--
2.47.1


