Return-Path: <bpf+bounces-49645-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2C3A1AF36
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 04:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16D61169A3F
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 03:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136F21D7998;
	Fri, 24 Jan 2025 03:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DL6ZBxd8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F381D7982
	for <bpf@vger.kernel.org>; Fri, 24 Jan 2025 03:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737691033; cv=none; b=mRlvNRnqJfdBNUWMCkTEhlM6cTuQCjCZIbd2ZM3G87I2pvUUm6dmqquiRNXrX+QTO/u/urn9FAA4mPYrCnHirts5XTENAqUnhcOpDeRvFkYGQP1H9BWwoFf67hcn1trY01ylixch11rFH4mmlJa3lNEdVFOhE2yp+Sq0O+HAUko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737691033; c=relaxed/simple;
	bh=wOI4QvmQ5PKB479PGhfquAy80qR9vCS2TKGkgdqfjOI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PrV+FZRihC+JECo3FaFOkTt0NOfW7cGqoNro95pD99g44T93LXOmIwBNeiRavHQl9n9dU8u5ql2pTSz3v+NRwrbZIWV9LT39Q0tjdp95NHLHWuS+yko8NcjKfpQVOPb76ik+U0hDSJ5CJg8M/8in/SKQAMRQKFw0fXUj3VtRTjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DL6ZBxd8; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2f4448bf96fso2415766a91.0
        for <bpf@vger.kernel.org>; Thu, 23 Jan 2025 19:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737691031; x=1738295831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c4la5/cXBbk2HatOeHKkn8ryi3z3XRRBiHexjMZ10FA=;
        b=DL6ZBxd8h7GfSiDO1QHldhe3kqE9Du45oIcQGDdqUHg7mM3WqfBmF4QaNyggf8VkHs
         V8To5nmyJIgZaU3TK9jupmKPz41k+LNaSfiZrgsiOmrFVs5J744qe5l8k55Qj+yVS+u8
         SPaOYWBdGx2OfNSq5fFvGpRefqTg6KE5PClws3QYdz9kytlGouxsb7p5ZOIanw2Q8C1G
         Hnqi7mt3hf5FqqSKdgfzucBzsaCehIU/1qUq1ssUpU0pkjDhJdQ55iH9MiJH+o+MWwUs
         lStMLFw2X6ufId97PukQh11yYmHVWFlbljDieAiULGLVlfHBVq+c3k1NmBOYwbXlPwR+
         GnvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737691031; x=1738295831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c4la5/cXBbk2HatOeHKkn8ryi3z3XRRBiHexjMZ10FA=;
        b=aFV/fy4w9Nmfe/MYI8iINwW7IjEVcnsJ1K5mEvuPJoAq0IWSjDGfwweO1gVAOPq7Uv
         NQ6CnIrEzFy8qmaR9tut3dkzpBW8PTg2nZ7Srl0IxGxgRBGnu4mf2juxqE6fAfYGC05L
         Yqhmz7iQ27dy7ZYCANs1r+MUlniA6s2oa5Cxf5mZ+yjhnyklSMuSLzEac73POmE94PHA
         NWTb4tu/KinO6R5ppFEF6GCE4vIKVKuIlzXqSPysh+IEBJ19VFGE9vv2PheGxH3+VYwc
         KZ5uWCPtZ3Dg2apcNgy8hlww6VRfpUGzl4YvY1YIvebcuOgGAeiqfAwPNj743A1OOsp8
         LvtQ==
X-Gm-Message-State: AOJu0Yw1qJ3CucXFa7e+M5SaNWWfxgj+ya2vuW7oLoVWYEzV96qMuzeU
	di2GZaXGKfILiFFCNN7oSTktNGG2vRTSbt3i9lHcCfJcPZLUzugRBXXzxQ==
X-Gm-Gg: ASbGncsRgyj6I3Gcwc4Yd0FGA/9EpiAY1Gl3VBU0h4kQ6Lrdm+EtossfVqwqicP4j0C
	XfTEiN1yaGCErKLZzi8GYsYpwwUxt0Ziva0j62tjyIwx8UJx7jOhMtFypWfMSFpUUzRzPIBZUka
	P5UDdwRxYmy+dYyrlLBhC1tIczFMxPzP6LRRaDbABNxlXpZkkydiYZ1DYJnr2S9+fPv8WNDaeDh
	etPlQOSfkb+CJASmVL7T2IzW+ta52QxPLfkcK+ONI46SdwbD94/wWf0h/wsXwa7c2ReuUbMLZiZ
	NOufjRGMMLNIngyKsuuhiz8lVP8qaRrKO9rlHzE=
X-Google-Smtp-Source: AGHT+IEwvNwHQhd2JUrRjyZznwdi2ypsyJojHQDiGm/2CjTDfPwIknvaSpVusJ/6NdDxjUU11w5G/A==
X-Received: by 2002:a17:90b:4c45:b0:2ee:bc1d:f98b with SMTP id 98e67ed59e1d1-2f782d5d822mr38678528a91.31.1737691031062;
        Thu, 23 Jan 2025 19:57:11 -0800 (PST)
Received: from macbookpro.lan ([2603:3023:16e:5000:8af:ecd2:44cd:8027])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffa6b2bdsm549950a91.25.2025.01.23.19.57.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 23 Jan 2025 19:57:10 -0800 (PST)
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
Subject: [PATCH bpf-next v6 4/6] memcg: Use trylock to access memcg stock_lock.
Date: Thu, 23 Jan 2025 19:56:53 -0800
Message-Id: <20250124035655.78899-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250124035655.78899-1-alexei.starovoitov@gmail.com>
References: <20250124035655.78899-1-alexei.starovoitov@gmail.com>
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

local_trylock might fail and this would lead to charge cache bypass if
the calling context doesn't allow spinning (gfpflags_allow_spinning).
In those cases charge the memcg counter directly and fail early if
that is not possible. This might cause a pre-mature charge failing
but it will allow an opportunistic charging that is safe from
try_alloc_pages path.

Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 mm/memcontrol.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 7b3503d12aaf..9caca00cb7de 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1722,7 +1722,7 @@ void mem_cgroup_print_oom_group(struct mem_cgroup *memcg)
 }
 
 struct memcg_stock_pcp {
-	local_lock_t stock_lock;
+	local_trylock_t stock_lock;
 	struct mem_cgroup *cached; /* this never be root cgroup */
 	unsigned int nr_pages;
 
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
+		if (!gfpflags_allow_spinning(gfp_mask))
+			return ret;
+		local_lock_irqsave(&memcg_stock.stock_lock, flags);
+	}
 
 	stock = this_cpu_ptr(&memcg_stock);
 	stock_pages = READ_ONCE(stock->nr_pages);
@@ -1851,7 +1856,18 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 {
 	unsigned long flags;
 
-	local_lock_irqsave(&memcg_stock.stock_lock, flags);
+	if (!local_trylock_irqsave(&memcg_stock.stock_lock, flags)) {
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
 	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
 }
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
-- 
2.43.5


