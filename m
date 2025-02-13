Return-Path: <bpf+bounces-51349-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEA0A3361F
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 04:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A33F5167CAC
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 03:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C80D204F7E;
	Thu, 13 Feb 2025 03:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kep3VY5Q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D381204C30
	for <bpf@vger.kernel.org>; Thu, 13 Feb 2025 03:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739417776; cv=none; b=DHK6OzEpdFEc62y+4DY2nq7vaQzT6tOlsw16M1tHDTTicwX04y8XBtywOUuEXB2M56JfTgg8qxokIVSqTDBf8pi3d/gHNYI6de0YBC7FKkZ3dNTNvMCz+Yl9xQP/q+eTgBZciHOyPOgERo7fjbREc4H5j8Av7OXdAU5oLoB+FPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739417776; c=relaxed/simple;
	bh=ZC2g15cWBHl4xKK3l6VY+Bv903v1M/rGvWQlFD6bb8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jOh0mNKhd9LDnoOPUyLL7sYDgggczbSMdnhBxvco64FVmYZ8JuatL7h9j2SDM9nhHjZ3w1/TL0I29Ls3EX/t7jVd9gYVlSf+IqhEg7gwyrUA/D85hqt9a1pWUjH5wx0D8Kwkq40I1CP/XOm2RW1Fxe1MrkL6ufFgI+XVWYOfrj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kep3VY5Q; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21f818a980cso5066475ad.3
        for <bpf@vger.kernel.org>; Wed, 12 Feb 2025 19:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739417773; x=1740022573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UVEemv3fH2Y13Oyfgyz54ddroh/hFIT8TR6MrFMiG5U=;
        b=kep3VY5QH5G0XU6BUicy7bhB4GYVo5XkAnhnB2uaOmLTHyDrxYyVkZ6bprQ06aDjxQ
         klUhn5wb4GFJIXwRm2rAOnIdcwauC6lPulNBFMOrGFtmTfpXcI943pDRUtHlEn/tyufb
         KLjQGGDbOlw4UcnhMEY2RfUzq8TJajmAZvQwVcciEDNW7IiGWu3TUimWyGDc2C/q40gC
         nXE1EP4A5sO51JgnZdjMp6D/Q67nUZB1orrYxev0eil0yxfR8UUGOlMhncPi+uoMA/Y6
         GjM5JeqU3AvE09LmrElSQY5/BF6/GfUpnRji3GbWrhmCgJs9xcmG2nStf+OzQWA+7bAW
         onog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739417773; x=1740022573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UVEemv3fH2Y13Oyfgyz54ddroh/hFIT8TR6MrFMiG5U=;
        b=NzhpraGZqOnbHrKXgfuV7g4dsUjHoV0ohg6tVrxAynd+/qctAvfmt5DPtMx1TNth7Z
         C1y2PwJg/pI+e1BGuGJYGzXAnVitVJQQV9gpQdmIMRDEmWPFMv3QfceBeZKqA94qQNbU
         gbAX5v10L9M65fqZ31/phwCIu8ua8FoPsccH8QbBpoCFOtfwXS7zpaZkPKWGH2VqYZ6f
         H0EL8pxSVnuUYR0N82yVHddiof3anFxL+qIrdEo1hiCgleSwnFIMx98pkd3YxPtJFldv
         bjySGAJFmO2M+HG8yog+TCP+qfx67u5upX0xcV5Z17vGzD3x3LnWI970oC/SaL71yvSg
         dKAA==
X-Gm-Message-State: AOJu0YxtVQd0+A6CeLUxawKQGC23oWi0Zb63uYLN5M+WnQbSiCJ/7ZjH
	sflHdZfam3dTzQACtkSIIf1dFCFLVA72SB3Na1yXRygn9qQd9zhQMElXIA==
X-Gm-Gg: ASbGnctQ+iGyUQAXxgYzHcqt13wNLwarF20RA0IoElfL8v5Z9iwULN1zyGDgvJOkaKx
	Vdb/xIerQigUodZTUg3LPkNTfqmukuno6ytZlCzwjBzDKa56rbiZfkJWJVzzvv4iLtQuqJKPYUv
	LA7FRLFmBLwvx0yCjQG4DNbpqAV8x9hjoaPPFRQLabpsvLZcG2pCw4eP/wcQwtZp28bjl9n12Ri
	B5biEa37X8LD6KvoaGXqgIh8Qgv8HpdK4B4MCYJxWX1kLxs2T71Z3I9S28m7AczJqbjP1bHFo6j
	CI66KA9kiv00oeZnH53E8GPUJYUx++VGavhufjgDPoMDIqRiCw==
X-Google-Smtp-Source: AGHT+IFVpGjNj/vzK1bi6WsgsmwnS7KOtENZ1Nu6FIVShyFexL6xf+cWsUdEjky1AdkIY4WdMWXaMw==
X-Received: by 2002:a17:902:c942:b0:216:386e:dbc with SMTP id d9443c01a7336-220bbacbb1amr78015995ad.13.1739417772747;
        Wed, 12 Feb 2025 19:36:12 -0800 (PST)
Received: from macbookpro.lan ([2603:3023:16e:5000:8af:ecd2:44cd:8027])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d556d5e6sm2691755ad.173.2025.02.12.19.36.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 12 Feb 2025 19:36:12 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
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
Subject: [PATCH bpf-next v8 4/6] memcg: Use trylock to access memcg stock_lock.
Date: Wed, 12 Feb 2025 19:35:54 -0800
Message-Id: <20250213033556.9534-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250213033556.9534-1-alexei.starovoitov@gmail.com>
References: <20250213033556.9534-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Teach memcg to operate under trylock conditions when spinning locks
cannot be used.

localtry_trylock might fail and this would lead to charge cache bypass
if the calling context doesn't allow spinning (gfpflags_allow_spinning).
In those cases charge the memcg counter directly and fail early if
that is not possible. This might cause a pre-mature charge failing
but it will allow an opportunistic charging that is safe from
try_alloc_pages path.

Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 mm/memcontrol.c | 52 ++++++++++++++++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 16 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 46f8b372d212..7587511b92cc 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1739,7 +1739,7 @@ void mem_cgroup_print_oom_group(struct mem_cgroup *memcg)
 }
 
 struct memcg_stock_pcp {
-	local_lock_t stock_lock;
+	localtry_lock_t stock_lock;
 	struct mem_cgroup *cached; /* this never be root cgroup */
 	unsigned int nr_pages;
 
@@ -1754,7 +1754,7 @@ struct memcg_stock_pcp {
 #define FLUSHING_CACHED_CHARGE	0
 };
 static DEFINE_PER_CPU(struct memcg_stock_pcp, memcg_stock) = {
-	.stock_lock = INIT_LOCAL_LOCK(stock_lock),
+	.stock_lock = INIT_LOCALTRY_LOCK(stock_lock),
 };
 static DEFINE_MUTEX(percpu_charge_mutex);
 
@@ -1773,7 +1773,8 @@ static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
  *
  * returns true if successful, false otherwise.
  */
-static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
+static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages,
+			  gfp_t gfp_mask)
 {
 	struct memcg_stock_pcp *stock;
 	unsigned int stock_pages;
@@ -1783,7 +1784,11 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 	if (nr_pages > MEMCG_CHARGE_BATCH)
 		return ret;
 
-	local_lock_irqsave(&memcg_stock.stock_lock, flags);
+	if (!localtry_trylock_irqsave(&memcg_stock.stock_lock, flags)) {
+		if (!gfpflags_allow_spinning(gfp_mask))
+			return ret;
+		localtry_lock_irqsave(&memcg_stock.stock_lock, flags);
+	}
 
 	stock = this_cpu_ptr(&memcg_stock);
 	stock_pages = READ_ONCE(stock->nr_pages);
@@ -1792,7 +1797,7 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 		ret = true;
 	}
 
-	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+	localtry_unlock_irqrestore(&memcg_stock.stock_lock, flags);
 
 	return ret;
 }
@@ -1831,14 +1836,14 @@ static void drain_local_stock(struct work_struct *dummy)
 	 * drain_stock races is that we always operate on local CPU stock
 	 * here with IRQ disabled
 	 */
-	local_lock_irqsave(&memcg_stock.stock_lock, flags);
+	localtry_lock_irqsave(&memcg_stock.stock_lock, flags);
 
 	stock = this_cpu_ptr(&memcg_stock);
 	old = drain_obj_stock(stock);
 	drain_stock(stock);
 	clear_bit(FLUSHING_CACHED_CHARGE, &stock->flags);
 
-	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+	localtry_unlock_irqrestore(&memcg_stock.stock_lock, flags);
 	obj_cgroup_put(old);
 }
 
@@ -1868,9 +1873,20 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 {
 	unsigned long flags;
 
-	local_lock_irqsave(&memcg_stock.stock_lock, flags);
+	if (!localtry_trylock_irqsave(&memcg_stock.stock_lock, flags)) {
+		/*
+		 * In case of unlikely failure to lock percpu stock_lock
+		 * uncharge memcg directly.
+		 */
+		if (mem_cgroup_is_root(memcg))
+			return;
+		page_counter_uncharge(&memcg->memory, nr_pages);
+		if (do_memsw_account())
+			page_counter_uncharge(&memcg->memsw, nr_pages);
+		return;
+	}
 	__refill_stock(memcg, nr_pages);
-	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+	localtry_unlock_irqrestore(&memcg_stock.stock_lock, flags);
 }
 
 /*
@@ -2213,9 +2229,13 @@ int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	unsigned long pflags;
 
 retry:
-	if (consume_stock(memcg, nr_pages))
+	if (consume_stock(memcg, nr_pages, gfp_mask))
 		return 0;
 
+	if (!gfpflags_allow_spinning(gfp_mask))
+		/* Avoid the refill and flush of the older stock */
+		batch = nr_pages;
+
 	if (!do_memsw_account() ||
 	    page_counter_try_charge(&memcg->memsw, batch, &counter)) {
 		if (page_counter_try_charge(&memcg->memory, batch, &counter))
@@ -2699,7 +2719,7 @@ static void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
 	unsigned long flags;
 	int *bytes;
 
-	local_lock_irqsave(&memcg_stock.stock_lock, flags);
+	localtry_lock_irqsave(&memcg_stock.stock_lock, flags);
 	stock = this_cpu_ptr(&memcg_stock);
 
 	/*
@@ -2752,7 +2772,7 @@ static void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
 	if (nr)
 		__mod_objcg_mlstate(objcg, pgdat, idx, nr);
 
-	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+	localtry_unlock_irqrestore(&memcg_stock.stock_lock, flags);
 	obj_cgroup_put(old);
 }
 
@@ -2762,7 +2782,7 @@ static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
 	unsigned long flags;
 	bool ret = false;
 
-	local_lock_irqsave(&memcg_stock.stock_lock, flags);
+	localtry_lock_irqsave(&memcg_stock.stock_lock, flags);
 
 	stock = this_cpu_ptr(&memcg_stock);
 	if (objcg == READ_ONCE(stock->cached_objcg) && stock->nr_bytes >= nr_bytes) {
@@ -2770,7 +2790,7 @@ static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
 		ret = true;
 	}
 
-	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+	localtry_unlock_irqrestore(&memcg_stock.stock_lock, flags);
 
 	return ret;
 }
@@ -2862,7 +2882,7 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 	unsigned long flags;
 	unsigned int nr_pages = 0;
 
-	local_lock_irqsave(&memcg_stock.stock_lock, flags);
+	localtry_lock_irqsave(&memcg_stock.stock_lock, flags);
 
 	stock = this_cpu_ptr(&memcg_stock);
 	if (READ_ONCE(stock->cached_objcg) != objcg) { /* reset if necessary */
@@ -2880,7 +2900,7 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 		stock->nr_bytes &= (PAGE_SIZE - 1);
 	}
 
-	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+	localtry_unlock_irqrestore(&memcg_stock.stock_lock, flags);
 	obj_cgroup_put(old);
 
 	if (nr_pages)
-- 
2.43.5


