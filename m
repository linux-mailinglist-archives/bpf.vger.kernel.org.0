Return-Path: <bpf+bounces-46473-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC56F9EA541
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 03:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A1FF161FB7
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 02:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4969419E980;
	Tue, 10 Dec 2024 02:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2YGs4Im"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5D670816
	for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 02:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733798402; cv=none; b=L6dfmUzcSyx9COcsr7Qr2/0DsxRv3ne4x0KuUOoAtS+JF89P/JxPFywvpGYAJXhG5nE8DCPtqEbIRdxA92cjeT+FWZipJyKf4q+f+1dHooUzLc38mfw8KDpctOU5aNtQfvJuYTSQxYjWU2007ECe+looNfnj4ExvX3Xi2ilmsSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733798402; c=relaxed/simple;
	bh=eeArVuRQjLMkKnmW3cNtegLJbfRg67rqk55sMUQzZ/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PeD2AbuaNh/9618bB0YSAC98IXRR3PMFrbiHhl7kcXVJ4wv0HRI+o9euwiHuSw47AfYXBeZbxFThR2ZWiR75XL8ZkAMw6UXKgQKY3FLodKZo3UK0PpIFN0bEXhtihuul5YO+aVdcQxRubexbqbUiCTDz3A5HI+FtW2R8zpdXwGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S2YGs4Im; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7ee51d9ae30so3335275a12.1
        for <bpf@vger.kernel.org>; Mon, 09 Dec 2024 18:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733798399; x=1734403199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wo7sUpYgRQrXUd48YB6NzK0xhu80+vJLM/DolMWSp9w=;
        b=S2YGs4ImZobTOFiXGnByqwV+eDWhJ8AInKpMkPQyfBJYgFd6iUTcqkN6gIP6rXXkqJ
         R4wiJ3oAqszUBmvSxNQ6pbhazFEVq6bzFlFkUAz0RbFVkvQk1eZWZciyu45LDlj4mh/O
         qwGiDKzDQrevQNVlAxUHABtIDWoBPudvEPkwhXPxEmyCXwBEVFcIDnW3dQS4JRhcolJD
         DKGl3X+gGCQKCqzh+fLiGtlWZF+tuH7O7bzi09NLWMKW1s0KItCjgowlgPPZ3MLIgFY9
         aRVYSgAZG0kCifZ7gchg+hBT5RfgKXA/VMF6sQls/NhWFCNu1hD3PHmyYraCZwww1luk
         hC3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733798399; x=1734403199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wo7sUpYgRQrXUd48YB6NzK0xhu80+vJLM/DolMWSp9w=;
        b=G190Xp0jYu0zJbx43/8rY8dfY2QYj2P2ebYLEZdRV7w0X4a6ZMwyecG7pU+EGKaE7z
         x9ogmI96HBDCx9Nq4Iikki/zccDvwUMCL5F5xtdrJRBJh6baOrNGLGPBmiQ/dZUaBD9X
         ATpnGbVqfJGX42O8N6ZREwMtJEL7N+VF1Tqh5DPJVdM+JuNhE9ZHHjNbqV95Dev9Mx00
         xuvdz4CUjDYjzylgMYViLn4yoD8Udo1MeoZAXPk9d0Tp+Usm5Dw3dXL6H0lAHg193Ros
         i1+3UlaszM1d0s8QV5piEsHVHYV39EX2BdRv2b4TWukMxCFmhMtvi+qcutmUKEPqKfKW
         WPJQ==
X-Gm-Message-State: AOJu0YwYakJMhtSB1xT2F4bY0MNFfHw9oJlF4nxGsg67Ib+8sQNhu8Nz
	WO8YY9F5UTLFK00MO/IdNxq9+DB6zEjh9u66GqmNT3cjkmdha4NidiDP5A==
X-Gm-Gg: ASbGnctgjin+Vgw4fGpEGa7RhWMk1Z6ggU4m085+Cqz3A61F2TC8WvDAaND4eH9vwPf
	X5oOUCE9a69GTmwstSRYG2bEzTa5T4WL4AEihWD9Xj/umVXbZ0Koc63r7npddxibEZhsRgT2Ofi
	tYXvyRtAng8agGEkwKHNvo/1nOhUkbmp5TEZHLGaOis7YDWB5acgn+T6nTLhBxqZKnw62LyvCaB
	uebRUWklwmVtuDJHQ0pocnJJoC0YpY5krjIaQexNbO5516eELEgPIAxfTJCLlePoK2vZ7jugvZI
	9JVKIg==
X-Google-Smtp-Source: AGHT+IFtiAsGhIVFD64KUeuc/HqOnxB2YRGY24DKyXhrRpv8mSEuSX8pUEmuRY3vKJ8avlYCY8VlLQ==
X-Received: by 2002:a05:6a21:890d:b0:1e1:9fef:e96a with SMTP id adf61e73a8af0-1e1b1a79c40mr3694721637.6.1733798399161;
        Mon, 09 Dec 2024 18:39:59 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:83b0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd560985e0sm1471732a12.79.2024.12.09.18.39.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Dec 2024 18:39:58 -0800 (PST)
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
	tj@kernel.org,
	linux-mm@kvack.org,
	kernel-team@fb.com
Subject: [PATCH bpf-next v2 4/6] memcg: Add __GFP_TRYLOCK support.
Date: Mon,  9 Dec 2024 18:39:34 -0800
Message-Id: <20241210023936.46871-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241210023936.46871-1-alexei.starovoitov@gmail.com>
References: <20241210023936.46871-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Teach memcg to operate under __GFP_TRYLOCK conditions when
spinning locks cannot be used.
The end result is __memcg_kmem_charge_page() and
__memcg_kmem_uncharge_page() become lockless.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 mm/memcontrol.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 7b3503d12aaf..459f35f15819 100644
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
@@ -1851,7 +1856,15 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 {
 	unsigned long flags;
 
-	local_lock_irqsave(&memcg_stock.stock_lock, flags);
+	if (!local_trylock_irqsave(&memcg_stock.stock_lock, flags)) {
+		/*
+		 * In !RT local_trylock_irqsave() always succeeds.
+		 * In case of unlikely failure to lock percpu stock_lock in RT
+		 * uncharge memcg directly.
+		 */
+		mem_cgroup_cancel_charge(memcg, nr_pages);
+		return;
+	}
 	__refill_stock(memcg, nr_pages);
 	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
 }
@@ -2196,7 +2209,7 @@ int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	unsigned long pflags;
 
 retry:
-	if (consume_stock(memcg, nr_pages))
+	if (consume_stock(memcg, nr_pages, gfp_mask))
 		return 0;
 
 	if (!do_memsw_account() ||
-- 
2.43.5


