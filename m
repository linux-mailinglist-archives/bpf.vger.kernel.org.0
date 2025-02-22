Return-Path: <bpf+bounces-52237-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18834A40526
	for <lists+bpf@lfdr.de>; Sat, 22 Feb 2025 03:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 699D14400D0
	for <lists+bpf@lfdr.de>; Sat, 22 Feb 2025 02:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9589D1FF1CC;
	Sat, 22 Feb 2025 02:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Swn6m+8L"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872EB1FCFE2
	for <bpf@vger.kernel.org>; Sat, 22 Feb 2025 02:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740192293; cv=none; b=fyBITATWRZPhSbG85VW5saj0bLQIbBx2HAxDB+2DFdKY+920KBaEojjhcgvnViPyasHtg+3DXDjiZkqzeODsuVe/jE6JMTTtDVdYqnKGRwkHQJxaRqe+lGPZ1ABvnS86PZnguM64wcpKYsD9aMbQii6dysEGxAhXWSUPejERUw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740192293; c=relaxed/simple;
	bh=Hq/MoataBAFy4xzlMlPj8gRlRWhLycemk1vWsLJqBP8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tOKkvDcNoTtVdaM1H5VeerRo2fssozQACTehvx0mCIX3VtDoGgzzhtgXhj1rCz4GOjI4WF9K6IEyj4QjtVcYK5v9/dzo27wij7ReGNyV3ylRK1V8/bHQw1weP5vGH5lfTX5519WOGlWHGQIldgghO+0GYJI+ly+hlEVsRotAdP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Swn6m+8L; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2fc11834404so4414538a91.0
        for <bpf@vger.kernel.org>; Fri, 21 Feb 2025 18:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740192290; x=1740797090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v3GSE8xL4BCDC6o3OqMQgPMvNv4GpRTdC8gwhotmjF4=;
        b=Swn6m+8LVY0EN3QIfQCSQwJqF1gMFj8Iq1y2VRFMJutf2inH4/QHz4HlTe9fhEW4Fo
         I3g6BxA7Xb+klA5p/Anaa3b7fZHCEFDN2ferlw2ELdKbGYMMv9f6nLf0wQMWZ43es/bf
         BCRIRXZtOWqaq5UOyW49fExaAtXvFnkg6WxeQ7Bals0hVkbnGyiIfYUqwj0zdoyh7s0A
         V5o6WuRxBe6c2IsUryp81dqhqkddaGdYKEQbjej7YwqlUfWDMJGLf3FQRSsUf7D+cKj7
         R4ImNI9271mVZSzm38TH0JqQxQMAdOVM+4iMfDxFKLv/4A35KxVvSnIEjqh64NwrvtIy
         5hIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740192290; x=1740797090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v3GSE8xL4BCDC6o3OqMQgPMvNv4GpRTdC8gwhotmjF4=;
        b=dl6Tq0Qttz8HsCwMVgTxyStOKSpZUNpDnr0+iYxtseZLOsPyFJzO8huFzCrnsTiwDx
         rpVGQ8XDdnFCYwKmBoXg0vwClldBQvgmPd7lZSzNIQFUiO6TwHF/psXjQnhYUIQMxjmD
         HTxYgobgEtGDpSZBTk46DPigzNpgqvwpqi3tQakyQyI8o8Ix1eeQdbjw7sQ3+lNK27Re
         Q4Kv1gNdJiqwSBwBNU0CTDfoSSUXq1K3I6TnaeYPYPd+KvDCOexnJJMiYidPmuAfNzXq
         8/1oGlmstQCvJ2LCy85n6l6AztKZgI/rQ21tMmc5R9XGzybkg3NuMSRZIUsOG1UwLPuz
         T0HA==
X-Gm-Message-State: AOJu0YzYJOA432OGbVYyu5Eh6pqtO9cQtyr1SMxWwgt4vEiVDq3M22eb
	6Xz6a0mVISxQSVgs4h01yT1k4U3Nv+o4SXUJSa6/xx8cjatyG0ck68YZ3A==
X-Gm-Gg: ASbGncsZWX/rKwFZ++L8lmTyfVW+n16T08cQItvEjnh/ih+fxzaB71KIpM9FU3FqC2F
	edr4xnZ9Rl9jqH1/zsXQiKgPY0KP8U6VFmaO94ibHs/WYymxx8Ve/V/6WpXPgnaCaklAAZ80Lzf
	EZh97P/8nBRwqKsULCV+qRL/5Lhz0BHyBqKhMuXevG53wPdzhfJ5wTpt1MDZem8nOpuNwJ9tjFk
	NDJqkFPT0DDHhaSBq+PK8tg71MeMVzdQYK+sIfs63DiRphKR+3K1W/gGLC886CzFNY7kiEx1hH6
	JJF5+rckuQc52Raf6CX4pLbG22luZnLEQnfOLYpDG9+RU8yuUk56Dg==
X-Google-Smtp-Source: AGHT+IFLGHpgxyBxSlJviOmokWQ79A/ZPTGdiqZO1+sWjAAQ8SXex0TBGIOGdCqxJtQew4NhBBCvqg==
X-Received: by 2002:a17:90b:2e8c:b0:2ee:d024:e4e2 with SMTP id 98e67ed59e1d1-2fce868cc3bmr9200563a91.7.1740192290163;
        Fri, 21 Feb 2025 18:44:50 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:fd1b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fceb0a0ab7sm2122738a91.47.2025.02.21.18.44.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 21 Feb 2025 18:44:49 -0800 (PST)
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
Subject: [PATCH bpf-next v9 4/6] memcg: Use trylock to access memcg stock_lock.
Date: Fri, 21 Feb 2025 18:44:25 -0800
Message-Id: <20250222024427.30294-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250222024427.30294-1-alexei.starovoitov@gmail.com>
References: <20250222024427.30294-1-alexei.starovoitov@gmail.com>
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
index 4de6acb9b8ec..97a7307d4932 100644
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


