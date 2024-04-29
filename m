Return-Path: <bpf+bounces-28124-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4ED8B5F6D
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 18:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA10B1C21413
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 16:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABA386158;
	Mon, 29 Apr 2024 16:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ng5jPwRL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E3533C7
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 16:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714409837; cv=none; b=QK4mfo1nSpC1kURcwFWhCPZ5JcGLhwIHwHUT80TcK9Z9p9/5corVmckI5Tg6sKtkSnM/Wc0DPdZZCvXRHYD5FGf/rQsGUCQpeoTzaaWDxVj8TwwQT3cKzSS+4M1X+X1Tr3HNoDpv6KaYGbFF+kv97jEaj0IyjjCiA6XFwuRrJZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714409837; c=relaxed/simple;
	bh=siK3kKrobvPnmziYFgX7k3QNzrUUA/glXT1ty22eN4U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QOM7wXaeHgJ1H11Y53sfoBsSEI8TcMZ0oVGi56cBm+to6MC7+phCly3DMrXl43S6UwSXQCzk8tVeVaYC1QIUFusbjlb6FeWD7qDumg/9wsY+G898Dl/5HBjTkd6bMuyRFntOFH+I0sRBGq5LdhDisutMRd2ln+Hhu2lbDhAkOv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ng5jPwRL; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-69b59c10720so11340266d6.3
        for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 09:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714409834; x=1715014634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aOZZTMrjSpiAuTui+v+CO8NJMpyQfa45AC/DO4tm6Hg=;
        b=Ng5jPwRLIQLzONaAmmw52q7sf9qjxzZEM+ob64oaq6OLZodyIQ+NsWJzP892oZnHKr
         cyu6UJesLhH3Gm6AJnMr+nS2g2WuBlZonUBFKhhkb+gZgTuoJ+USeKSWx321nHeouV8w
         AMKHLIhsW3xXzvtTP0KNUm/+YUCh9m8CfImeBAnwZt4k7mKtA1bSPHphWQORyCUZKCih
         n+SPEBZHzj6fJeeWrTOVHPAkqi/tlzaQ5XeRk5Q3Z1g3aXVX/7K1bnfsEKve0/DIcj1H
         7Gkv5ERojKcrPCEqRc1KgB2ZVaWRN4SZSIa/NXuy1BJKjTUNG1PnXeIXOflWdNSXR441
         lVxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714409834; x=1715014634;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aOZZTMrjSpiAuTui+v+CO8NJMpyQfa45AC/DO4tm6Hg=;
        b=EyvQ0T5cIqyQPUqSAiRvtkDwfqftqgJGAGweSochJA1BHiBaed7S3ErNJFPuFJHUFC
         uN+zrOwo2QY72nUnTIOX4jiie1BPf+wztGPvh+KZB2y+37ttKgi3F1fzFobwxeZntI0N
         YaELeMSNnxI7TGb4p6iyYTpJcJ2aW7eOQc14Wd5rnpgr9+0OzIGlKCoGH/mY+QTTJ1pL
         ScgDuDmePn2LFVYfGyBWCE5fHAnUvkudYBOiRgc6FiIrij6kNIyOq3iPLJdpbKBesVOw
         24Bu4qzr+XUtKDFLrSR3ZB967KgGC381TqdZE5FnbiOArFMhi8YJPnYsKSaHxvgKnW2v
         K/zw==
X-Gm-Message-State: AOJu0YwowGcNDeGVrGt+YKCNZ6C1iJUm8W3m5HWihVPuDu3ZYmstcXP2
	D5dzLh0dMMltruK0SOqQZ/IZORTPTLkRFkVH72Owd5K/L36eabuenPbFYg==
X-Google-Smtp-Source: AGHT+IH9+uB0yVCB3y/ubdvkxPxo5aVEj/hIpTwdj6nZROVz1W008mXxXK1IsHTh15qe4mH5gdza6Q==
X-Received: by 2002:a05:6214:cc6:b0:699:206c:2db1 with SMTP id 6-20020a0562140cc600b00699206c2db1mr14153561qvx.16.1714409834384;
        Mon, 29 Apr 2024 09:57:14 -0700 (PDT)
Received: from fedora.. ([2607:b400:30:a100:6442:5b0e:54ab:110b])
        by smtp.gmail.com with ESMTPSA id k17-20020a0cc791000000b0069b5672bab8sm3031988qvj.134.2024.04.29.09.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 09:57:14 -0700 (PDT)
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	daniel@iogearbox.net,
	olsajiri@gmail.com,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	rjsu26@vt.edu,
	sairoop@vt.edu,
	Siddharth Chintamaneni <sidchintamaneni@vt.edu>,
	syzbot+8bdfc2c53fb2b63e1871@syzkaller.appspotmail.com
Subject: [PATCH bpf-next 1/2] Patch to Fix deadlocks in queue and stack maps
Date: Mon, 29 Apr 2024 12:56:57 -0400
Message-ID: <20240429165658.1305969-1-sidchintamaneni@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Siddharth Chintamaneni <sidchintamaneni@vt.edu>

This patch address a possible deadlock issue in queue and
stack map types.

Deadlock could happen when a nested BPF program
acquires the same lock as the parent BPF program
to perform a write operation on the same map as
the first one. This bug is also reported by
syzbot.

Link: https://lore.kernel.org/lkml/0000000000004c3fc90615f37756@google.com/
Reported-by: syzbot+8bdfc2c53fb2b63e1871@syzkaller.appspotmail.com
Fixes: f1a2e44a3aec ("bpf: add queue and stack maps")
Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@vt.edu>
---
 kernel/bpf/queue_stack_maps.c | 42 +++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/kernel/bpf/queue_stack_maps.c b/kernel/bpf/queue_stack_maps.c
index d869f51ea93a..4b7df1a53cf2 100644
--- a/kernel/bpf/queue_stack_maps.c
+++ b/kernel/bpf/queue_stack_maps.c
@@ -18,6 +18,7 @@ struct bpf_queue_stack {
 	raw_spinlock_t lock;
 	u32 head, tail;
 	u32 size; /* max_entries + 1 */
+	int __percpu *map_locked;
 
 	char elements[] __aligned(8);
 };
@@ -78,6 +79,16 @@ static struct bpf_map *queue_stack_map_alloc(union bpf_attr *attr)
 
 	qs->size = size;
 
+	qs->map_locked = bpf_map_alloc_percpu(&qs->map,
+						sizeof(int),
+						sizeof(int),
+						GFP_USER);
+	if (!qs->map_locked) {
+		bpf_map_area_free(qs);
+		return ERR_PTR(-ENOMEM);
+	}
+
+
 	raw_spin_lock_init(&qs->lock);
 
 	return &qs->map;
@@ -98,6 +109,16 @@ static long __queue_map_get(struct bpf_map *map, void *value, bool delete)
 	int err = 0;
 	void *ptr;
 
+	preempt_disable();
+	local_irq_save(flags);
+	if (unlikely(__this_cpu_inc_return(*(qs->map_locked)) != 1)) {
+		__this_cpu_dec(*(qs->map_locked));
+		local_irq_restore(flags);
+		preempt_enable();
+		return -EBUSY;
+	}
+	preempt_enable();
+
 	if (in_nmi()) {
 		if (!raw_spin_trylock_irqsave(&qs->lock, flags))
 			return -EBUSY;
@@ -133,6 +154,17 @@ static long __stack_map_get(struct bpf_map *map, void *value, bool delete)
 	void *ptr;
 	u32 index;
 
+	preempt_disable();
+	local_irq_save(flags);
+	if (unlikely(__this_cpu_inc_return(*(qs->map_locked)) != 1)) {
+		__this_cpu_dec(*(qs->map_locked));
+		local_irq_restore(flags);
+		preempt_enable();
+		return -EBUSY;
+	}
+	preempt_enable();
+
+
 	if (in_nmi()) {
 		if (!raw_spin_trylock_irqsave(&qs->lock, flags))
 			return -EBUSY;
@@ -194,6 +226,16 @@ static long queue_stack_map_push_elem(struct bpf_map *map, void *value,
 	int err = 0;
 	void *dst;
 
+	preempt_disable();
+	local_irq_save(irq_flags);
+	if (unlikely(__this_cpu_inc_return(*(qs->map_locked)) != 1)) {
+		__this_cpu_dec(*(qs->map_locked));
+		local_irq_restore(irq_flags);
+		preempt_enable();
+		return -EBUSY;
+	}
+	preempt_enable();
+
 	/* BPF_EXIST is used to force making room for a new element in case the
 	 * map is full
 	 */
-- 
2.44.0


