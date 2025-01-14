Return-Path: <bpf+bounces-48731-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91417A0FEA1
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 03:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95B321883678
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 02:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AD223027B;
	Tue, 14 Jan 2025 02:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ReEwvYds"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640FE23026F
	for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 02:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736821192; cv=none; b=IGih65ShE/9MSfWKMvBVHY6HLbwbWIqNe4B1l6aZmRIUygliWpRGnQk22VL8A3aApPi6GHMj8w9dWG2GyMdYckJlhNXuUV2tddxLq5tVie96BZzmOCoIx/MPnKF1W2knQx+Z4c5gQkQD40+eAobuyUxssAXd6lN62i1ga3jKZsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736821192; c=relaxed/simple;
	bh=ZhXE0wLLMBUB9EgYPFEuO6m3OKi1YFiPbsJQ4bZ7JhE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RCK7y2tbb90z/DMoCSfd4H9FASDCz3bARqAoZqNgu3MJeMNx1EShc2kh4vy3vIjeHroj7X38o3aE8Qzdub+Dzi/IOHwHQ7pQ9CY/0DFNZ8eh/Xj79c/I/vS0qI2dX/m0dpufOlXytPBXJp6IQqCsq5nTBXNem4koOKzoZsT3eIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ReEwvYds; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21634338cfdso73813785ad.2
        for <bpf@vger.kernel.org>; Mon, 13 Jan 2025 18:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736821190; x=1737425990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rVaRyHY3N181Ob6HytxKBrw588chz5TJlaChctBoK1M=;
        b=ReEwvYdsEkYR43euo1dvFDuACdNJeRZ/rhG+BPdyiEPUfZFshFNOFRBDNYnEYYAa+V
         Rn4C7FsuN5BFGjp8jGVxPFHktr8+m4dpGPrSahLM7KknVf+nQ7777z9tsML9z8CiF/qp
         KMTt9BzCfiIKyYd4CHqDovHL31AAVi6klozTh8dCjy6Zr0drifsUbUygKkeRQhXNJwVe
         mgxOKzOrcvIOWeikoEuhDn4JusYLwt2H3F7R+mdIopoj4nD5PR7naSlES3HxUVAnWnqM
         6i4P/wOfChEL0+L4ONEO9NnJS0Gn4Gdx/giURHNrupoUo+8BUioB5oviwA+SW8Da5qGH
         9ePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736821190; x=1737425990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rVaRyHY3N181Ob6HytxKBrw588chz5TJlaChctBoK1M=;
        b=M81mNJ2TGbQb/FvFhzBD3LI9o7HJUQTnoMoWDQBMriCcMhinqDIus9f1KSfBsj6iU/
         3HWvewtD2t1Ir/Zl3FTEzGXUNbfJj4eOd31QFja6fxnDS+J1kzm0vLjTxUJGM3extqmQ
         c36Nx1FJsd0JlPi9Xgzg28b4vbXKrzt+qE0yi7EKZFo0VTX2eDih8ekG310segk7+3VT
         guVPEYCTkm0Xty7kcx3tGDTYJjr/HAWfHYJcTtbknl0V24DVXhVmNkvY33TIpqQP82B9
         gR0rwmNb/Ne/NJK3UumGciy6ld2BnDM4Tj8KkucsFJgCmqUcY7YEtoSRll/piNQ+1riC
         OvFQ==
X-Gm-Message-State: AOJu0YxM1c45mXhIX2Tz9cbe7hvYeQiwVMQN8CG5gzsGUrovnrGBxOss
	tM1w1g+F6doaSPQXDNZBf2EN/WN+ybw4CJOvOEprQWl0SQAsqhLUPOHbNg==
X-Gm-Gg: ASbGncsGoGbuvi9ybnigBPsHCpiLK02dgVbKVtvwR6MxwqnQg8kCOJhTAZgD2Bklk8K
	+eZkd7HLIDhTkFORF0k8ZG+OlnhjofGWBOayuhLp01nQtyMCU8mYBMQ2YzBKgejBPT9IV3ZIbgt
	tTwkJ2ixC4QJoYRJ3Py1z4D7POA0X/su03Jn/XmTKDKFTSMnjL60fwz/rvz+7pE8BvUaFcVTKEc
	N3oioUOHW5TpaOqlL+k6LxljUh/jJDWlsGd5eqcHvF5FuGGlbEySMc37qYasAJFE5wNbLjzT8gY
	MsIB0ATi
X-Google-Smtp-Source: AGHT+IFgd3F1vhcoVYBusGT4YkcS3cyvI9lPQCSRNl7H1SCdyLOMHx5+LSBkcObgthXTbJSLr0qoDQ==
X-Received: by 2002:a05:6a00:3cc2:b0:726:f7c9:7b36 with SMTP id d2e1a72fcca58-72d21f325b8mr38139980b3a.8.1736821190203;
        Mon, 13 Jan 2025 18:19:50 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:4043])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d406a4dfesm6523242b3a.156.2025.01.13.18.19.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Jan 2025 18:19:49 -0800 (PST)
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
Subject: [PATCH bpf-next v4 4/6] memcg: Use trylock to access memcg stock_lock.
Date: Mon, 13 Jan 2025 18:19:20 -0800
Message-Id: <20250114021922.92609-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250114021922.92609-1-alexei.starovoitov@gmail.com>
References: <20250114021922.92609-1-alexei.starovoitov@gmail.com>
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
 mm/memcontrol.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 7b3503d12aaf..e4c7049465e0 100644
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
+		if (!gfpflags_allow_spinning(gfp_mask))
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
@@ -2196,9 +2208,13 @@ int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
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


