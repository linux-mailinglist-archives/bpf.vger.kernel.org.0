Return-Path: <bpf+bounces-51288-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 087A1A32DD1
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 18:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A504F7A2111
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 17:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A822525A653;
	Wed, 12 Feb 2025 17:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Px6cIex+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A522325C6F1
	for <bpf@vger.kernel.org>; Wed, 12 Feb 2025 17:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739382449; cv=none; b=CSOvCuCOimO7JDGXqsbPm5iM2QW6YC5B0d7Ec20rWGddvqnnbLCEtoNj8gbdDlsCojoZIKukz7WOA6J/ire036KoJ1OtHLhemXbFPyDV2YRyiLRe5LwIOKFdg4yJHOxHSfbFN+KMKNY59+5+kkiNOVi3LDzWyeM2VUoO00rpGxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739382449; c=relaxed/simple;
	bh=rvkD0voG5AFWPbxH/cFvKKuqBd+a8nG/qfAcky5jsKI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rcm0/2DumftLCK73IQSH1wEdtr6yGlTpGeodCcRkPB6ThjnRPzKxc+QQAAcg3Vq1hn1SYMUe0HGuSrJgJ7JZmCKV3Na5n3CsWoO097AxiMf2mFczNEUMqkzE9epkywf0kv4k1TXVt27D+e/nzHnWv2rptH4E6QeimFszxlLN5sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Px6cIex+; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2f9bac7699aso78869a91.1
        for <bpf@vger.kernel.org>; Wed, 12 Feb 2025 09:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739382447; x=1739987247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lgL2WdPUSp9IlhXwRVgFpZY7gPxe7SOzqv/p6kt86b8=;
        b=Px6cIex+7mP7z7X6xdOOXQdxAFn5OKR84+RXhOv9wooAwgKrsmEM7HV+J/WJFFk+IS
         1dk0Idq8KnTs/2QW7/28kkjMB4BottzGr/Bk3ifNayRuFznrPuXcjYBU1cDKPmx5l8J2
         HzDcmi19DrZlzhk5n18n/RHL1PyhGzEuqVpmWh/AjJnXuDH0/q2JYUpKE5+3zaSZTQpK
         MjYOoWJqj5iVpAzO4rxoeFCMf5ufshoOoUclfDWNeP+iowgnzUCa11VpTmX4x1K69Vke
         G6XqYRuzvSt1ZPJ7wc2RGnWbnEGRNgkeBcWN8QTQhekOTzpFlIfXTACNvImoSWzVicRA
         c/Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739382447; x=1739987247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lgL2WdPUSp9IlhXwRVgFpZY7gPxe7SOzqv/p6kt86b8=;
        b=ZPz2ise4TOj2rOvKhd9DYHjxlWgXO5w5lXrmFVR8Mv/mzZKhJxHY2i7J7+94QzJAxU
         K5g7hRDMFKBXDK8qUAOe1G8uCH8BWma5leTVKrebAEEQJYLIxDxinlutW9clK96Xwl9m
         gXuMkNoJLDLese9XD/HjbxM4q6+AU5xMaSO2v5wb3O+KZXanlk5fbcAP8WEtECS2v4WQ
         WGWR0YegAXXmMovb8YIXQ3wDFKEYlTu9HS0zRUrtaKm8eUiC3JzjqKVBczlNEho16XJj
         be3B2ngi1MedidblKoO3BsO3CmddSiQvahUsfof0c7sqwhLBmaUm0zRQmi2g1EII34Y6
         2tMA==
X-Gm-Message-State: AOJu0YzZSY2Tlzo/aVnGeciKa+i2bjBHInLxawx2b71aQ+03lGM8gjGb
	UrVY2pAMGO/Vs8NIBinGKJmHMo1s7gup0JFq0FP7t7p3fxNkLhTFY9CqBQ==
X-Gm-Gg: ASbGncuPgNmhqBkrOjP0obUuvAlueVb6GkJlob0MDVkCfc+QVIqG4yUQBWOcAkJxnrx
	QsONyMCCOwQjBeDKRYagRZ90zEBEHVNtPVHKHt9pZonX3uagIeavIQESu05XIvgF+mXKWf+v1z+
	wsMf3Gaxf6d4XB683L7CpwG2TR+UvND1XDp8StXBJuJgvwpiC7yZ6MkNiFrTx0cpPyb3pR41bmT
	mSA9MDjFfNumab4ppseRWaVb+uL6I/t0c0d1THb9tZ8olHm+B0F8cx1HS/b9vvc/RZpD9uuiY7W
	wEZ5WUC715P451dzV8+1VDzpTd6mQGSaXTxatfy3MuBu6Q==
X-Google-Smtp-Source: AGHT+IGEj3NYQQrGwrnzg5FtQkvq3P2X1QMPIINMUYPk4XwQqFltxvoCKJbMwmmlCOqX7njlFq8C2Q==
X-Received: by 2002:a17:90b:1dcb:b0:2ee:bbd8:2b9d with SMTP id 98e67ed59e1d1-2fbf91358eamr4369795a91.34.1739382446220;
        Wed, 12 Feb 2025 09:47:26 -0800 (PST)
Received: from ast-mac.thefacebook.com ([2620:10d:c090:500::4:c330])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f36896b86sm116452455ad.212.2025.02.12.09.47.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 12 Feb 2025 09:47:25 -0800 (PST)
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
	mhocko@suse.com,
	willy@infradead.org,
	tglx@linutronix.de,
	jannh@google.com,
	tj@kernel.org,
	linux-mm@kvack.org,
	kernel-team@fb.com
Subject: [PATCH bpf-next v7 4/6] memcg: Use trylock to access memcg stock_lock.
Date: Wed, 12 Feb 2025 09:47:03 -0800
Message-Id: <20250212174705.44492-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250212174705.44492-1-alexei.starovoitov@gmail.com>
References: <20250212174705.44492-1-alexei.starovoitov@gmail.com>
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
index 7b3503d12aaf..f3af615f727c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1722,7 +1722,7 @@ void mem_cgroup_print_oom_group(struct mem_cgroup *memcg)
 }
 
 struct memcg_stock_pcp {
-	local_lock_t stock_lock;
+	localtry_lock_t stock_lock;
 	struct mem_cgroup *cached; /* this never be root cgroup */
 	unsigned int nr_pages;
 
@@ -1737,7 +1737,7 @@ struct memcg_stock_pcp {
 #define FLUSHING_CACHED_CHARGE	0
 };
 static DEFINE_PER_CPU(struct memcg_stock_pcp, memcg_stock) = {
-	.stock_lock = INIT_LOCAL_LOCK(stock_lock),
+	.stock_lock = INIT_LOCALTRY_LOCK(stock_lock),
 };
 static DEFINE_MUTEX(percpu_charge_mutex);
 
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
+	if (!localtry_trylock_irqsave(&memcg_stock.stock_lock, flags)) {
+		if (!gfpflags_allow_spinning(gfp_mask))
+			return ret;
+		localtry_lock_irqsave(&memcg_stock.stock_lock, flags);
+	}
 
 	stock = this_cpu_ptr(&memcg_stock);
 	stock_pages = READ_ONCE(stock->nr_pages);
@@ -1775,7 +1780,7 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 		ret = true;
 	}
 
-	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+	localtry_unlock_irqrestore(&memcg_stock.stock_lock, flags);
 
 	return ret;
 }
@@ -1814,14 +1819,14 @@ static void drain_local_stock(struct work_struct *dummy)
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
 
@@ -1851,9 +1856,20 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
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
@@ -2196,9 +2212,13 @@ int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
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
@@ -2709,7 +2729,7 @@ static void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
 	unsigned long flags;
 	int *bytes;
 
-	local_lock_irqsave(&memcg_stock.stock_lock, flags);
+	localtry_lock_irqsave(&memcg_stock.stock_lock, flags);
 	stock = this_cpu_ptr(&memcg_stock);
 
 	/*
@@ -2762,7 +2782,7 @@ static void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
 	if (nr)
 		__mod_objcg_mlstate(objcg, pgdat, idx, nr);
 
-	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+	localtry_unlock_irqrestore(&memcg_stock.stock_lock, flags);
 	obj_cgroup_put(old);
 }
 
@@ -2772,7 +2792,7 @@ static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
 	unsigned long flags;
 	bool ret = false;
 
-	local_lock_irqsave(&memcg_stock.stock_lock, flags);
+	localtry_lock_irqsave(&memcg_stock.stock_lock, flags);
 
 	stock = this_cpu_ptr(&memcg_stock);
 	if (objcg == READ_ONCE(stock->cached_objcg) && stock->nr_bytes >= nr_bytes) {
@@ -2780,7 +2800,7 @@ static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
 		ret = true;
 	}
 
-	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+	localtry_unlock_irqrestore(&memcg_stock.stock_lock, flags);
 
 	return ret;
 }
@@ -2872,7 +2892,7 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 	unsigned long flags;
 	unsigned int nr_pages = 0;
 
-	local_lock_irqsave(&memcg_stock.stock_lock, flags);
+	localtry_lock_irqsave(&memcg_stock.stock_lock, flags);
 
 	stock = this_cpu_ptr(&memcg_stock);
 	if (READ_ONCE(stock->cached_objcg) != objcg) { /* reset if necessary */
@@ -2890,7 +2910,7 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 		stock->nr_bytes &= (PAGE_SIZE - 1);
 	}
 
-	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+	localtry_unlock_irqrestore(&memcg_stock.stock_lock, flags);
 	obj_cgroup_put(old);
 
 	if (nr_pages)
-- 
2.43.5


