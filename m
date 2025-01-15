Return-Path: <bpf+bounces-48898-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0321A11729
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 03:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B5FD3A4DCD
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 02:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE28D132105;
	Wed, 15 Jan 2025 02:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7KGtxI8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E645C2D638
	for <bpf@vger.kernel.org>; Wed, 15 Jan 2025 02:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736907494; cv=none; b=TsXxqgBnhrQu60LrzOmHFiA4wz9u5r0syLBkR9R9bpW6d7ZMp3+QRHVvXMi8Uk5DVlmleMANhZLW9+4phaeOCefmbNnqw124Gvd+fTr/GOJfpCuxndA/oPh0kl7kP7dhZrpoR/AONJpnV6SKhVgw8XYLbRyD7SuXM7Xv40CapXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736907494; c=relaxed/simple;
	bh=Uwr2xE6B7JMwmcTthZddqGjvDCqEOvs584NXfxZNX8w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tAEmXgtSmYxHS4PraMuG1ZtERi9GyBwQRKPORGEvTY+aV28RP4HMeYSOgCxBTczeBiGVNePvbkzzqax8OZyMdhwhO9HNeQw+3u4FJOey1YyCaNh4G1t9rp1dbW7PesWD106TBCA7YaDcgrk7VvMvqTsP9pRNjKqiFNlVasI+KY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7KGtxI8; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21619108a6bso108436105ad.3
        for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 18:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736907492; x=1737512292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mxa1zavVGcrL3mhmNj3zaW3g0F2sJ8bBr01E6sisj+Y=;
        b=k7KGtxI83/Zr3eZU5P1DcDunTMaDYyOe14xX3PNxY/7YsCAb60MLKJnWcDAZe9Xjsu
         ssmjubbJxnSCkj4ERYfhmNJbf5Hc5T95iAVpaf8J//Xqkxy1MQA2cd6xuL2eVhg0XzZ3
         JZ6MxWrz02l/738dwJzkYDl4p6g8wh2vnio9KaY16bx4cROVWMWGKOaqS0fnYTCkXYEb
         B3yGpkM61b0oVWzsbh+qHwoqjkPtWldDnZfRXh/9WKuyoMcSlOsoLgjBz/iPQXmGXq9V
         e0fc+O1/NAL34Pat6h+maQo7roEnEOUIGyJxJP88iF7i09BMUl0ueo26wPn0i+IQFxIQ
         a3bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736907492; x=1737512292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mxa1zavVGcrL3mhmNj3zaW3g0F2sJ8bBr01E6sisj+Y=;
        b=Oy/iB2x3yNUGWdEIWI3XyZgREyiXu6MzbWEsSaEHBQDwv2gjVMLId8rmWUCchIpwJZ
         eaDibxdLG06qp0fN1vkGo3VcOfp80E7oqd4iAp4Akq8ZtMozS4qFrXq9zP69aG0OETqF
         9fiSsVr6oNcl0EzbfuV7tbSrCyMKzbHZ+58z3ZZJYoGniG52YM/HNlV6JhsQzzIdLGld
         HW/2wXpvXydaD7RgOCqXqaPxjunEi6Qc0kzinRv3jzEiIJlZrznB/CGbNBPRXUTkmGVv
         dyK33Xg18cerMoLRBZdiU6haclfBsS26pklGtM7dYlnNTa58Jd4C9WjQJIhhr7lDkzKP
         8tfQ==
X-Gm-Message-State: AOJu0YwPFVzW21QMjwAU/oZVIGWNCt1h/siNOrmDupL1eTDdqPGbdK0B
	IMGeExCB6eXey0dTsu4fhdPiTYJ5RijeQXpwYWB+tbgB8vJNNIKxd8/Vog==
X-Gm-Gg: ASbGnctcWH2Mc3r5hlZf23Bgdr3j9Fj+rONOaqmcnC5lypj6riXRPKLManLpkHanU8i
	Fhl4Tt3zLz1/pLIhyD99nCkSqVkY+IpxUea/wZhmr0pTU//LzAp1Gb685DcczRTBQDdL8oMfDQG
	qfDD0y1kMfI09U06x9M2Fh9Q/bBLyN4xZID7aJ9rbeDF1g/3QXSrxTS2rjAi/NiC8yJRSV9Km+i
	H0nVNZuvRYDCdxl2cI2OJCzTxaps3m42t1IPjiTsjEBXU17yqHWHVzq+K4D9SrHP8sNwrD9qpb/
	KVQwqsA0
X-Google-Smtp-Source: AGHT+IES28E6/UzBuAXcKHyytweWh1DbAVGKG/FlHuIJMf6aRzxb6IkpsZav+M1wSoIo/J2A0mfOZg==
X-Received: by 2002:a17:903:41c5:b0:215:19ae:77bf with SMTP id d9443c01a7336-21a83f4ea67mr419970035ad.19.1736907491906;
        Tue, 14 Jan 2025 18:18:11 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:4043])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f12f919sm73361445ad.69.2025.01.14.18.18.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Jan 2025 18:18:11 -0800 (PST)
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
Subject: [PATCH bpf-next v5 4/7] memcg: Use trylock to access memcg stock_lock.
Date: Tue, 14 Jan 2025 18:17:43 -0800
Message-Id: <20250115021746.34691-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250115021746.34691-1-alexei.starovoitov@gmail.com>
References: <20250115021746.34691-1-alexei.starovoitov@gmail.com>
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


