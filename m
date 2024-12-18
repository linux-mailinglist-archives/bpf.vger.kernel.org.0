Return-Path: <bpf+bounces-47179-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BA89F5D3D
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 04:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C77FE165229
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 03:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DBF146A6F;
	Wed, 18 Dec 2024 03:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcjJMhYR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17DA1F931
	for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 03:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734491272; cv=none; b=ZDj5npxaYK6ORCtBX07lxqu6KbXed4p7GhGWvy4fPrtJgX+CpyqWDaEosqGnpI2uy01qOKsOF5EP3sxuZmx9MCtuNTWCI3N8DHuIXJ6dAXI2GBJ7jaaTP0+Ulqpv6c9bq8B1cALVekEUMET3ES56E9sbWPK6++UGyHE+hCR07rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734491272; c=relaxed/simple;
	bh=xyUVZumur1RRZwVexUoAmOdDa6jTdszBfA40AlVo+HM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ULFBgMG7lfQjJb6im6kBOq4aAiXTn5UFYNRUSYqlSZfmfG6NybaghaDep6SgUSG1rk8lrrerM/YdUGVs9fdjzRDQbp/aNPgONQKuwd6FSfhPAcstonhQOLCxMnOfZOXRtmxMMUdRYM7OC7RpH+fg/Andr4avhw54e2ZJ4ybOpTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LcjJMhYR; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3eb7f3b1342so2557496b6e.1
        for <bpf@vger.kernel.org>; Tue, 17 Dec 2024 19:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734491269; x=1735096069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=we3p1MJO0mH53GLx5S6kuhiFdcHuR7bEtawg6CO6LzQ=;
        b=LcjJMhYRRvwvtAYIiQz0Bw/7GMeF7dOQ2vsD19ScQ3PBFQVW0xrOhaAiP6J7xmMyGR
         6l++7gYWP2XYDzMtqURqEJU3yC72WX1+L4Fvpz/jJltzW7/uRxQhTTcyS416MW1pQTFR
         fX6CT8v0EBGv4HoFblKhoYPbUfdd7Ft9BwrVVyYqcY5KkvxrQVWlwtv5EEAJf3/Xpb7A
         Zzc1fgYL8P6x0CtS+EQKLHFtU+lldFw17yWSXa81RbAMopLZkLBy6DzIUKLlhC0W+8Zh
         SYZ705sAJTy2cnU4BXRfXDaCRofVlPRS+0sZjwdGP3yDJgF9oEYadr+ExfGMD6i6V+Ce
         pFcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734491269; x=1735096069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=we3p1MJO0mH53GLx5S6kuhiFdcHuR7bEtawg6CO6LzQ=;
        b=GXZZD4He5+neZkgfX7t/NiR8LjG0TByoMeuggWj6O/u/XomEP8CEeqyCRA4csS9n77
         uak5V6CfaWcL58fJK0raPAqzojLFzaWQM7C7lDWe9myf/UMmH5vH/uZuqqaCRefTMhl7
         I0ge1VMiAFpYmSMXmFwddjalLMXR8uUqfEuXe3mjeJeFl2KsqKlP17KdtfoIRMgg+PeM
         tUhK9pHBjQqMIp1nKTJagAANXu9HYPsuPH/PGuuIG8nIaRx4BXd1a7R9Mey81rJb8bQC
         ++YKKqSwDl2RzDoiaAoHRBQreL/xmasr26NkaY6UI/sODDMfNqCIdBbu5MaPT+yH3Jnw
         5bkg==
X-Gm-Message-State: AOJu0YwBAUcLxrBb0iWT0cf/RdJqPSujGU3mPaEYIb9yR/blPqzcCEql
	nTAp1KFjODeOiNwseB9nClLjzXGlQkbnXY3qTkLhc0IOKZii+axtYpo59w==
X-Gm-Gg: ASbGncuXRI2wotifKABhdAXR+e0Lpnt/4WdZ6pfg4EwWHspNW/dJGCHce++Q0OsYNvK
	KDa+Z6Nv3n6FeYWL83nfWrIXSm4LLINYhbu0IQ/BmsC+isndQB3rruuo2QEJwIUIGP+qFCIR8bC
	FnAA1A6lfJegQ5BG5BC4tlU6wSwICo/pVgZbeEwayXxh+E1ooswjktaBS5JTX/FmHdh6EjXkBxl
	ctS031XixnBg/GJgG/MX/gDZRlTsCZdE+wuAgWOpoTfFbV/+ev7OBozoWyc5A==
X-Google-Smtp-Source: AGHT+IGL10nUsHo3mK7ebRhA2Sibr6OXQ514T2ZZGOY0T/DlM7tZqSomQ9DnyLhRUkqKMnmcfJnnaQ==
X-Received: by 2002:a05:6808:bc4:b0:3eb:5d3a:5b1e with SMTP id 5614622812f47-3eccbf091c1mr839843b6e.3.1734491269205;
        Tue, 17 Dec 2024 19:07:49 -0800 (PST)
Received: from localhost ([2a03:2880:12ff:3::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3ebb479702asm2651497b6e.13.2024.12.17.19.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 19:07:48 -0800 (PST)
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
Subject: [PATCH bpf-next v3 5/6] mm, bpf: Use memcg in try_alloc_pages().
Date: Tue, 17 Dec 2024 19:07:18 -0800
Message-ID: <20241218030720.1602449-6-alexei.starovoitov@gmail.com>
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

Unconditionally use __GFP_ACCOUNT in try_alloc_pages().
The caller is responsible to setup memcg correctly.
All BPF memory accounting is memcg based.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 mm/page_alloc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 10918bfc6734..5d0e56fbb65b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7100,7 +7100,7 @@ static bool __free_unaccepted(struct page *page)
 struct page *try_alloc_pages_noprof(int nid, unsigned int order)
 {
 	gfp_t alloc_gfp = __GFP_NOWARN | __GFP_ZERO |
-			  __GFP_NOMEMALLOC | __GFP_TRYLOCK;
+			  __GFP_NOMEMALLOC | __GFP_TRYLOCK | __GFP_ACCOUNT;
 	unsigned int alloc_flags = ALLOC_TRYLOCK;
 	struct alloc_context ac = { };
 	struct page *page;
@@ -7136,13 +7136,17 @@ struct page *try_alloc_pages_noprof(int nid, unsigned int order)
 	 * If it's empty attempt to spin_trylock zone->lock.
 	 * Do not specify __GFP_KSWAPD_RECLAIM to avoid wakeup_kswapd
 	 * that may need to grab a lock.
-	 * Do not specify __GFP_ACCOUNT to avoid local_lock.
 	 * Do not warn either.
 	 */
 	page = get_page_from_freelist(alloc_gfp, order, alloc_flags, &ac);
 
 	/* Unlike regular alloc_pages() there is no __alloc_pages_slowpath(). */
 
+	if (memcg_kmem_online() && page &&
+	    unlikely(__memcg_kmem_charge_page(page, alloc_gfp, order) != 0)) {
+		free_pages_nolock(page, order);
+		page = NULL;
+	}
 	trace_mm_page_alloc(page, order, alloc_gfp & ~__GFP_TRYLOCK, ac.migratetype);
 	kmsan_alloc_page(page, order, alloc_gfp);
 	return page;
-- 
2.43.5


