Return-Path: <bpf+bounces-47178-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE249F5D3E
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 04:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 718D01889E6E
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 03:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152AC146A68;
	Wed, 18 Dec 2024 03:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUqDeyOW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2144A43146
	for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 03:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734491267; cv=none; b=LunQgsrO84A127w54BedE+C4jgSoiTWNHRH/OudHhQ45nGG2rmho8I4I5nyNqTU1vaAz+fhSdSvdwvJaabHf/GzQQbSKKePrR4NetM2X70C8FgqNGRTu/7yFysGrfhsknPoL1dNR9KWuaoj+OGD2NifhR3xu6DqGhcYPYTvZ+So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734491267; c=relaxed/simple;
	bh=7Vm/a/+qy6Ar8kP/6ExK4ePgo3e/MRDtz66Sr+JZdmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ojfzo2uCNwEyMnjcflcAhazr6wUPhilPzzPSuaV7v9Eeu1ggjhhjmMkAmQQDYjNGkaClNRKn8MyAc9HWcUkUmBDdIU6UvP89oW5hqx8KOWr6juQHhzB25PCQnLg4d//KAOW9zI+XY7kzK7JMru+iN3zPijAZinRyZEfebHJC2Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CUqDeyOW; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-71e287897ceso3972131a34.0
        for <bpf@vger.kernel.org>; Tue, 17 Dec 2024 19:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734491264; x=1735096064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/7W5s6nR1eKMiZGmAkj0lhGxTA+TFwBoEtTYrZWxIj4=;
        b=CUqDeyOW3FW5/2G7Sd2FNm3ciUOubwEntxwB2v07OSDDePcpJQmcNii4PtE7owOdAQ
         czlFn2VsZ6Qnlpc42pARiMGyUNvUF0i8LVtBLZb3DCM8bY9l8u3lqh9niSkQBHIYVsA0
         foRDYT6XD38RBkJ25A/+LhgZ/P4XyaAbCw4nohk4+fZfAjP5zm0pr54jUjq4JSf+49Ce
         8Oz1zno4DWLAZ5BbopmyDILEKwWH4Nkq4jBqWIDKDG4Dpx9holWoYC0oRqX+NmT48cRU
         +MvwRggGussa9Kc+Sc9PMQZM+pznC8WPPdZoHszhVaAS8VsJN5+wfwanOW/OiYxGShlE
         Fjnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734491264; x=1735096064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/7W5s6nR1eKMiZGmAkj0lhGxTA+TFwBoEtTYrZWxIj4=;
        b=l2HHKpE3H586dYyMNEHpjg8gW7HZM4T3e3PJO96IKp7nwa9hnkhO/H6iyFswqpQFD4
         bjQT0hph+o1n6bkt5+1wkkFbwbVBfLrv+xJ50VMJ0D9+GiAlroKsHxxk+Wau12MKrc8f
         Mx/oLQbC8DAtpGwHxk46n3LRkduakrd0dqTpdJ9dzlO0xdxIKSdFb99DewvzsKiKAefG
         D0PDgcV911rncLZ9ssx9p6JLLGiH9FaXkt9cJ+ZeVsZ/b3yITtfNgszRpYOXW5U1x9yv
         wpQE14euTjZrNNvaac21/1pmUFwcJmhKLiV7tHXSM1noXkGzr4xn8GLgZUFeBeTyuw/V
         ed0Q==
X-Gm-Message-State: AOJu0YxcDXd/KyHNNL/alokKteBLVe89aikP4a/jBA8YgvmCyp+sftWy
	qMpwY2TQAqLzOPmxRR+AkFHyJ53HqrjPUgklFi8GS5ahRkUfbM7Zc6RqEQ==
X-Gm-Gg: ASbGncu2TBQ9JAteFrjCnvf5WnIji4mJ2SiftJWJTa+QkRXjFqBJygjpYsEKqkpgcrB
	hbUtEkgFLUX7SoOYJWiUBtLwqv30wRrVZ2mgkiXouwCWVHU6E0ndoS7CMvgFxVUN3cnyeMbGDYl
	45jeE1Gm6La4DuK1+wuKc76/nLum5NM0Fgl6dNuzi9o1lURWZs9sk//xuSR4QUdZHOgNp8C6egA
	zbptrDXJ4Pvc9Cg8CRZuX7SV+g15C5jmWQqoR536l/USHOqlnY5yR55TfyI/g==
X-Google-Smtp-Source: AGHT+IH2tfKmT4WhT188FuyTuGvwz4iinrO9XQia8eG+MuqgHEUEQ+qNAXFpX68m9XBO2n0bhRDyxw==
X-Received: by 2002:a05:6830:7308:b0:71e:904:6aed with SMTP id 46e09a7af769-71fb757a1afmr792576a34.10.1734491264502;
        Tue, 17 Dec 2024 19:07:44 -0800 (PST)
Received: from localhost ([2a03:2880:12ff:2::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71e4835630esm2481271a34.27.2024.12.17.19.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 19:07:43 -0800 (PST)
From: alexei.starovoitov@gmail.com
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	memxor@gmail.com,
	akpm@linux-foundation.org,
	peterz@infradead.org,
	vbabka@suse.cz,
	bigeasy@linutronix.de,
	rostedt@goodmis.org,
	houtao1@huawei.com,
	hannes@cmpxchg.org,
	shakeel.butt@linux.dev,
	mhocko@suse.com,
	willy@infradead.org,
	tglx@linutronix.de,
	jannh@google.com,
	tj@kernel.org,
	linux-mm@kvack.org,
	kernel-team@fb.com
Subject: [PATCH bpf-next v3 4/6] memcg: Use trylock to access memcg stock_lock.
Date: Tue, 17 Dec 2024 19:07:17 -0800
Message-ID: <20241218030720.1602449-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241218030720.1602449-1-alexei.starovoitov@gmail.com>
References: <20241218030720.1602449-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Teach memcg to operate under trylock conditions when
spinning locks cannot be used.
The end result is __memcg_kmem_charge_page() and
__memcg_kmem_uncharge_page() are safe to use from
any context in RT and !RT.
In !RT the NMI handler may fail to trylock stock_lock.
In RT hard IRQ and NMI handlers will not attempt to trylock.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 mm/memcontrol.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 7b3503d12aaf..f168d223375f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1756,7 +1756,8 @@ static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
  *
  * returns true if successful, false otherwise.
  */
-static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
+static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages,
+			  gfp_t gfp_mask)
 {
 	struct memcg_stock_pcp *stock;
 	unsigned int stock_pages;
@@ -1766,7 +1767,11 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 	if (nr_pages > MEMCG_CHARGE_BATCH)
 		return ret;
 
-	local_lock_irqsave(&memcg_stock.stock_lock, flags);
+	if (!local_trylock_irqsave(&memcg_stock.stock_lock, flags)) {
+		if (gfp_mask & __GFP_TRYLOCK)
+			return ret;
+		local_lock_irqsave(&memcg_stock.stock_lock, flags);
+	}
 
 	stock = this_cpu_ptr(&memcg_stock);
 	stock_pages = READ_ONCE(stock->nr_pages);
@@ -1851,7 +1856,14 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 {
 	unsigned long flags;
 
-	local_lock_irqsave(&memcg_stock.stock_lock, flags);
+	if (!local_trylock_irqsave(&memcg_stock.stock_lock, flags)) {
+		/*
+		 * In case of unlikely failure to lock percpu stock_lock
+		 * uncharge memcg directly.
+		 */
+		mem_cgroup_cancel_charge(memcg, nr_pages);
+		return;
+	}
 	__refill_stock(memcg, nr_pages);
 	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
 }
@@ -2196,7 +2208,7 @@ int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	unsigned long pflags;
 
 retry:
-	if (consume_stock(memcg, nr_pages))
+	if (consume_stock(memcg, nr_pages, gfp_mask))
 		return 0;
 
 	if (!do_memsw_account() ||
-- 
2.43.5


