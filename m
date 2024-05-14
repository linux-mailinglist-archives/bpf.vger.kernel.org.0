Return-Path: <bpf+bounces-29694-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B82BC8C55FF
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 14:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5ACB1C227D6
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 12:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4C24594C;
	Tue, 14 May 2024 12:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1sLiUqx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E54FDDC0
	for <bpf@vger.kernel.org>; Tue, 14 May 2024 12:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715689454; cv=none; b=GKYi9R3mFD20OeCGVOFMfP9pYn0WVidkuk31G2d2SGqHnmB+R5L2p58EI9+bWJwq3MrclGckAzGk7nl7jV5TiI0uwLSKal/erfwdOcCA8gJycKiO91DQwkKsEAUEqNIBYb6uJqUx1v5nJ4CUFEqrp4kzP7A+7dFSQJg6W1OLsh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715689454; c=relaxed/simple;
	bh=uowLP++liw21uF2zuo/eKfAR23hS3OQREjM5sUi3QDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SPMfeGnmrD0kHql+wabyUNOb0sdzoxTU6DbdKu7GlJK9bShfKSvs+TNdxsQ7KLPa+0QuyFcY8LhzRGepMpkHT4pkcKh/iQR69i/bPJ6VXT2cm5jv/NrX1BwIGVCG6BFuRc0XZYzNWFWDrdAO1OKwu7+lecrxrgykWUkyYcdAsh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I1sLiUqx; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-43e1593d633so13422261cf.3
        for <bpf@vger.kernel.org>; Tue, 14 May 2024 05:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715689452; x=1716294252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ypCihyheNflK1mbusL6H8ZCmjUFQCxzxR9a9qXg+FaI=;
        b=I1sLiUqxmFkJUrYYRZKqGqFGdhIG4FasZxKhhZRzoQ+BueMOi3TaZrx8T8NCuBxvaP
         eRwRsZVZdsQelJZqEiz2GY/nO0ya0mFvQ7EvrmcpqKrXMvWU3dhM64YTaSB/kvs+hHeO
         J6FmgSTPqVt9TN+d2aU3w4fCS+XrE/wM/cJORl9pmYeTLJq5xfjuZ3Td+qYUh42S5y3u
         JfeeFjCTGvZXDOnpcUuSnR4rZnjFbRZyN3zT6xpdw89RVBckiM2sj0rfD7EeKoC6e58K
         skNlCDsrcRo87YljhniiNACsYugI6xL+f+u50QlKl+B5e8IIPKgs4vHf3mZMNoE9u6/t
         sKpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715689452; x=1716294252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ypCihyheNflK1mbusL6H8ZCmjUFQCxzxR9a9qXg+FaI=;
        b=GiaijvfqbDVM8xY9L3IkQGSC0sfgA3S883rCuS/fq2S2+5d8hOKZZ2YtMjWvnhwDru
         +opGQb0DINmeCSfY02tePC+I7KY0KU3edPqJ5J1cO9jZIK9gOSn3Mio2v6jcz01zVsCb
         8Xul0eT6BX+qfC3oktlw9j6hmdeycrJz6CY9dS7Kzeax4TPKHnHWhqUFWq6yrfOdiNs4
         Divm90JJbbBvh642At2pt8SgMndfUBMPzgxy/lj1mIuFr/H1L+P1IH3pjRX6FvBE8gwy
         SDJuj2L5p2pBo2wir3hPhUlnYXZuUe5Y/1y/RBc1DxwrCkGvHjhDmVVooxqpilrmGDa4
         3gSQ==
X-Gm-Message-State: AOJu0YxxfQgzNNPP8QHEYcBfggNKHujJ1O45s4xEGustp41cDPrB/UGs
	b7xIEDoGvvc4JD9bgRXb/rCRflHZgKbe+Q62vg3nLNF4AqmSNvQHXDKX8g==
X-Google-Smtp-Source: AGHT+IF03vDjN14n5TbSX2nv8cwW9mF3I8ZBqv41jSYYXZ3RFnTRCMfd4U7LCjLazJguG/mo9WtX9w==
X-Received: by 2002:a05:622a:1344:b0:43b:4d2:48cc with SMTP id d75a77b69052e-43dfdd1961bmr194978081cf.46.1715689451957;
        Tue, 14 May 2024 05:24:11 -0700 (PDT)
Received: from fedora.. ([2607:b400:30:a100:6442:5b0e:54ab:110b])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e25735ceesm11861811cf.11.2024.05.14.05.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 05:24:11 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 1/2] bpf: Patch to Fix deadlocks in queue and stack maps
Date: Tue, 14 May 2024 08:23:37 -0400
Message-ID: <20240514122337.1239800-2-sidchintamaneni@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240514122337.1239800-1-sidchintamaneni@gmail.com>
References: <20240514122337.1239800-1-sidchintamaneni@gmail.com>
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


