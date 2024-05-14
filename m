Return-Path: <bpf+bounces-29697-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E14C8C5616
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 14:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B370FB21096
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 12:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5AD6BFBB;
	Tue, 14 May 2024 12:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9F6fUsw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C48D55C3B
	for <bpf@vger.kernel.org>; Tue, 14 May 2024 12:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715690478; cv=none; b=UVm6gTwCKd01hFewDXVDvhRDq9YTUA9rmO2ELbXQaNJ7BynRlOLNEdBbr+COgbIROnmliFC6Gwwt9KZnvKrX8XtwAOCnBZLBnZcysPL8tAB8fTyjFVuzdOB+R9zZBqQCBdh4CHZr8n9KbDpVSTaExWOI5VYTk5TEbvX0QlmqsQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715690478; c=relaxed/simple;
	bh=uowLP++liw21uF2zuo/eKfAR23hS3OQREjM5sUi3QDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LhvXu3fqSFaDrVUF+M57iZ9EZ8X2alsDT7AcPJpxtAaQbHA7rP4LubxMxjbF4wNPULoMPwYtMyhYUWeBk9XUzKmL2CposViUohuLVV4+3yojJp2L0YBy1twExlARfghX8RzCN1SdGzIF+vhYHAjddP/5bXDodZwuF3T4+QYaqiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A9F6fUsw; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6f0e2612303so3070482a34.2
        for <bpf@vger.kernel.org>; Tue, 14 May 2024 05:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715690476; x=1716295276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ypCihyheNflK1mbusL6H8ZCmjUFQCxzxR9a9qXg+FaI=;
        b=A9F6fUswW9BmI3pemEPXkaGpS/ESkz6H9dnuyaYi8Y1J+kJ38lkojOszdxcA7B2OHj
         g9pDef3CvxOZeKy+6cueiAkvJo439uDjt4teRMQLO93vwdzhaS+xfv6ZH4J9aX6Fd3kg
         uqdmO2h7JRZayjdifg/8daBkWfw67R/eSMA+caq+mjxxeHpxgJqW/cV5hrKy3Wg56GEz
         TvQecTDaT1nWk0WKTJLi1cM/XcirVg1+lz3zayq50J1/O5G4Rx7uMx2JeHeYL1HtOYw+
         7m8W5eEvdNuB83p4blYaa8DatUFVnZVQohyoZO7Gq8mc144yJnmGstNV/JVFggIk3vcQ
         o7qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715690476; x=1716295276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ypCihyheNflK1mbusL6H8ZCmjUFQCxzxR9a9qXg+FaI=;
        b=l9jarDtlXz6ar1umnRNoO0HnQS3duz3420WBfxoJPxQ3l2Qs0qXSZPE6G7yX/77g0H
         cXVfClXBCmgMhyzQpxPR5ROCQXmq8b+xM5oSZy+TNVs01C9OhAPCTTUwcBAZjSZ4o/fy
         dpA01KoATypkBtCkkIM/nXpEfSR775dSKymq2/cafbq5uCyb2f4SuDs3GbkYUhwMS6f/
         3iRK86pr/RnLh6m5QRdi60Nj4/W1IKg06FJPbha0a//o7K6re6GD6wAPpzQ/JBVYGX5A
         aEFDhFPBYHDJ5UpQsTXIuN0AQQL8yEsQBWKAlBpf7W5YERm7aaQBRRt5TAEi8W0hYHmr
         DyQg==
X-Gm-Message-State: AOJu0YweKwqXxQSz+VBbWNFSRSlIpwVUgNA+9F9/zJNhUBnAuAD8NyKW
	v/dXIeDo2mbV2xnAqUp1SMlfsBHo8AbI+19uN8bK4oAja+Kvk/fRogp4AA==
X-Google-Smtp-Source: AGHT+IEMOPqd2U633nnLPc6hpzPS6QpR3RpJC6j1x6BGQzLltIrGchlKHIx7NWy/C1hbfTaZ20diSQ==
X-Received: by 2002:a9d:6d95:0:b0:6f0:7986:7821 with SMTP id 46e09a7af769-6f0e929fc3cmr14228198a34.28.1715690476175;
        Tue, 14 May 2024 05:41:16 -0700 (PDT)
Received: from fedora.. ([2607:b400:30:a100:6442:5b0e:54ab:110b])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e12f41a0asm31923981cf.48.2024.05.14.05.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 05:41:15 -0700 (PDT)
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	daniel@iogearbox.net,
	olsajiri@gmail.com,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	rjsu26@vt.edu,
	sairoop@vt.edu,
	miloc@vt.edu,
	memxor@gmail.com,
	Siddharth Chintamaneni <sidchintamaneni@gmail.com>,
	syzbot+8bdfc2c53fb2b63e1871@syzkaller.appspotmail.com
Subject: [PATCH v3 bpf-next 1/2] bpf: Patch to Fix deadlocks in queue and stack maps
Date: Tue, 14 May 2024 08:40:52 -0400
Message-ID: <20240514124052.1240266-2-sidchintamaneni@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240514124052.1240266-1-sidchintamaneni@gmail.com>
References: <20240514124052.1240266-1-sidchintamaneni@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch is a revised version which addresses a possible deadlock issue in
queue and stack map types.

Deadlock could happen when a nested BPF program acquires the same lock
as the parent BPF program to perform a write operation on the same map
as the first one. This bug is also reported by syzbot.

Link: https://lore.kernel.org/lkml/0000000000004c3fc90615f37756@google.com/
Reported-by: syzbot+8bdfc2c53fb2b63e1871@syzkaller.appspotmail.com
Fixes: f1a2e44a3aec ("bpf: add queue and stack maps")
Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
---
 kernel/bpf/queue_stack_maps.c | 76 +++++++++++++++++++++++++++++++++--
 1 file changed, 73 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/queue_stack_maps.c b/kernel/bpf/queue_stack_maps.c
index d869f51ea93a..b5ed76c9ddd7 100644
--- a/kernel/bpf/queue_stack_maps.c
+++ b/kernel/bpf/queue_stack_maps.c
@@ -13,11 +13,13 @@
 #define QUEUE_STACK_CREATE_FLAG_MASK \
 	(BPF_F_NUMA_NODE | BPF_F_ACCESS_MASK)
 
+
 struct bpf_queue_stack {
 	struct bpf_map map;
 	raw_spinlock_t lock;
 	u32 head, tail;
 	u32 size; /* max_entries + 1 */
+	int __percpu *map_locked;
 
 	char elements[] __aligned(8);
 };
@@ -78,6 +80,15 @@ static struct bpf_map *queue_stack_map_alloc(union bpf_attr *attr)
 
 	qs->size = size;
 
+	qs->map_locked = bpf_map_alloc_percpu(&qs->map,
+						sizeof(int),
+						sizeof(int),
+						GFP_USER | __GFP_NOWARN);
+	if (!qs->map_locked) {
+		bpf_map_area_free(qs);
+		return ERR_PTR(-ENOMEM);
+	}
+
 	raw_spin_lock_init(&qs->lock);
 
 	return &qs->map;
@@ -88,19 +99,57 @@ static void queue_stack_map_free(struct bpf_map *map)
 {
 	struct bpf_queue_stack *qs = bpf_queue_stack(map);
 
+	free_percpu(qs->map_locked);
 	bpf_map_area_free(qs);
 }
 
+static inline int map_lock_inc(struct bpf_queue_stack *qs)
+{
+	unsigned long flags;
+
+	preempt_disable();
+	local_irq_save(flags);
+	if (unlikely(__this_cpu_inc_return(*(qs->map_locked)) != 1)) {
+		__this_cpu_dec(*(qs->map_locked));
+		local_irq_restore(flags);
+		preempt_enable();
+		return -EBUSY;
+	}
+
+	local_irq_restore(flags);
+	preempt_enable();
+
+	return 0;
+}
+
+static inline void map_unlock_dec(struct bpf_queue_stack *qs)
+{
+	unsigned long flags;
+
+	preempt_disable();
+	local_irq_save(flags);
+	__this_cpu_dec(*(qs->map_locked));
+	local_irq_restore(flags);
+	preempt_enable();
+}
+
 static long __queue_map_get(struct bpf_map *map, void *value, bool delete)
 {
 	struct bpf_queue_stack *qs = bpf_queue_stack(map);
 	unsigned long flags;
 	int err = 0;
 	void *ptr;
+	int ret;
+
+	ret = map_lock_inc(qs);
+	if (ret)
+		return ret;
 
 	if (in_nmi()) {
-		if (!raw_spin_trylock_irqsave(&qs->lock, flags))
+		if (!raw_spin_trylock_irqsave(&qs->lock, flags)) {
+			map_unlock_dec(qs);
 			return -EBUSY;
+		}
 	} else {
 		raw_spin_lock_irqsave(&qs->lock, flags);
 	}
@@ -121,6 +170,8 @@ static long __queue_map_get(struct bpf_map *map, void *value, bool delete)
 
 out:
 	raw_spin_unlock_irqrestore(&qs->lock, flags);
+	map_unlock_dec(qs);
+
 	return err;
 }
 
@@ -132,10 +183,17 @@ static long __stack_map_get(struct bpf_map *map, void *value, bool delete)
 	int err = 0;
 	void *ptr;
 	u32 index;
+	int ret;
+
+	ret = map_lock_inc(qs);
+	if (ret)
+		return ret;
 
 	if (in_nmi()) {
-		if (!raw_spin_trylock_irqsave(&qs->lock, flags))
+		if (!raw_spin_trylock_irqsave(&qs->lock, flags)) {
+			map_unlock_dec(qs);
 			return -EBUSY;
+		}
 	} else {
 		raw_spin_lock_irqsave(&qs->lock, flags);
 	}
@@ -158,6 +216,8 @@ static long __stack_map_get(struct bpf_map *map, void *value, bool delete)
 
 out:
 	raw_spin_unlock_irqrestore(&qs->lock, flags);
+	map_unlock_dec(qs);
+
 	return err;
 }
 
@@ -193,6 +253,7 @@ static long queue_stack_map_push_elem(struct bpf_map *map, void *value,
 	unsigned long irq_flags;
 	int err = 0;
 	void *dst;
+	int ret;
 
 	/* BPF_EXIST is used to force making room for a new element in case the
 	 * map is full
@@ -203,9 +264,16 @@ static long queue_stack_map_push_elem(struct bpf_map *map, void *value,
 	if (flags & BPF_NOEXIST || flags > BPF_EXIST)
 		return -EINVAL;
 
+
+	ret = map_lock_inc(qs);
+	if (ret)
+		return ret;
+
 	if (in_nmi()) {
-		if (!raw_spin_trylock_irqsave(&qs->lock, irq_flags))
+		if (!raw_spin_trylock_irqsave(&qs->lock, irq_flags)) {
+			map_unlock_dec(qs);
 			return -EBUSY;
+		}
 	} else {
 		raw_spin_lock_irqsave(&qs->lock, irq_flags);
 	}
@@ -228,6 +296,8 @@ static long queue_stack_map_push_elem(struct bpf_map *map, void *value,
 
 out:
 	raw_spin_unlock_irqrestore(&qs->lock, irq_flags);
+	map_unlock_dec(qs);
+
 	return err;
 }
 
-- 
2.44.0


