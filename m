Return-Path: <bpf+bounces-46474-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3A29EA542
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 03:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B2801610CC
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 02:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AB519EEA1;
	Tue, 10 Dec 2024 02:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uu1iho7c"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3074B199949
	for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 02:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733798406; cv=none; b=ii1mXTnmWBkSyuUulXhnzIMD3WOSHb4tq81LX3WTF4w0DUrtjQHRKYN5Gg6FGYbtjYyqsXtcY/39gA3bg5L897twF+gcZ/4llXehPm2uqfzWp+sjQx4X6PR5E2I6aD/4Y3Ueu0zLaVim3uXQ/3uiZSXEMpbew3c8ywVqwkw17a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733798406; c=relaxed/simple;
	bh=Yf10ydUs8cwUl/6z5MH4k9pW7IZNRoVK3iTxZDFOqGg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WyTiOp5mdVqaW9vT8f4b24PGa/Ca5h7/9goYbUvdJdsY7IPxntZHfg/pqVFlPoRFXFLBlqtiEMAeb/FLYjfsqlfV0WyD3j7yblt/8K9kTOgr2ew9L1n8C2uWRmej1XSBQ4W17RGKMhBgP5snVgjwAN67W1MYfZxYEBeQcV74klg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uu1iho7c; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20cf3e36a76so43693405ad.0
        for <bpf@vger.kernel.org>; Mon, 09 Dec 2024 18:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733798404; x=1734403204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dZcki3SirXCmN69CdcGKxt31rfH5khiUYpTKaefczMs=;
        b=Uu1iho7c6APy9wfXzGh0DnPfJQskzKUo013sQ56ncDCctCXgZwZsZt56V2WwroMmU7
         qcvIzsUXgo2jrdNDIr/5i+nw3Id6cFVt+ogvYr4Z709h6crOY0/hVWRlXlw10bbXOH1D
         hmaz5sofappQVSQ1QPLdrWTa2WA3wup+VZVccA60GLqxU9gP30QCH1Zngkh4gr2wuK1b
         +PZYBhmNefgfyDnJ6OTC1G97HICgdRyna0sCF2fIci5bxmgLpUJOtcsfb/6AV3wdpmy6
         gXoEC1uEbg/v7K8OhOeIpQBazW7JNl3mfP8XUZ/uZ5OwcxlQoQY6TTgiFIcxtcndL+x7
         GXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733798404; x=1734403204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dZcki3SirXCmN69CdcGKxt31rfH5khiUYpTKaefczMs=;
        b=KOMP5PfRBTL4tqTSwq5zjBJe7qUIWM7AXdA/T5pkNIGXluzlyxQZExan7yt+VRkW3j
         LeoNmKfR1rvff7h/x982sjTce+hXWntpnWG7o2rQ6RhRLR39VwKnc1hG+7mgqHe17E88
         +TrPFhawSDcxgz2+ADv/xZ/lGdEsdpFPjXK1v63LZfoSGxreVuyNiTnxxuk/7uhrtEN2
         BSdTo8OoGcsEOJ+rfX0cgiw+3CKjNHMjyGYBGjPJqdrsFXNOC88/E1qNyrUcZfCAHUIZ
         hF3AinD83WVPFheDQUwVS5lUlHIYFcZRaAhhLIsNPSXDqVzZ9WKDHC7cdwAVDe1GevD2
         ei7A==
X-Gm-Message-State: AOJu0YyNj61BXyCI/GQZ+mUVSncqqOkmcN5fOSjaOc1bGaoCfjmNjaFd
	ogfxMgWpvGaCvP1pBVNnqsyv1kStQ6smMSGMXdO0ffmz1edA0VcWnCqieg==
X-Gm-Gg: ASbGnctkzlUZpXuX6p+mjQETju7oIk25RxGghrb2OfAjF8LRtEqAsQ40QZUjyK50AY9
	hRlHtudLHpx+xweLN3NfP3PkITjEPUlB+RNYmpTjBJY/geSvr69zHkDD2N6fOs+tzWbLmwAw1Ys
	tcRVkJqveuI/Rzb+lyscMTaeX7HvuM0lzK2Dla4WiGNl4UjKHQy5RVkTL0LnGwv7alyQjPFG5bv
	udrSBSySSlNSkXaBdXarvLJ98n/xBTXyGfOBNi26z8bzfGoVllYfRIo17u+E0UogfKsTKehF8Tu
	6C7l4g==
X-Google-Smtp-Source: AGHT+IGCrCmcyV05haNAd+ohuQ5mWaS3nvBsc6i7L/ZiIyD+Czd5Of6TvkBrVGS6hN/453APVBLTQg==
X-Received: by 2002:a17:902:cec4:b0:216:501e:e314 with SMTP id d9443c01a7336-21669fb7abcmr31154365ad.20.1733798403643;
        Mon, 09 Dec 2024 18:40:03 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:83b0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-216150886e7sm61609365ad.282.2024.12.09.18.40.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Dec 2024 18:40:03 -0800 (PST)
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
Subject: [PATCH bpf-next v2 5/6] mm, bpf: Use __GFP_ACCOUNT in try_alloc_pages().
Date: Mon,  9 Dec 2024 18:39:35 -0800
Message-Id: <20241210023936.46871-6-alexei.starovoitov@gmail.com>
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

Unconditionally use __GFP_ACCOUNT in try_alloc_pages().
The caller is responsible to setup memcg correctly.
All BPF memory accounting is memcg based.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/gfp.h | 5 ++---
 mm/page_alloc.c     | 5 ++++-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index dcae733ed006..820c4938c9cd 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -356,18 +356,17 @@ static inline struct page *try_alloc_pages_noprof(int nid, unsigned int order)
 	 */
 	if (preemptible() && !rcu_preempt_depth())
 		return alloc_pages_node_noprof(nid,
-					       GFP_NOWAIT | __GFP_ZERO,
+					       GFP_NOWAIT | __GFP_ZERO | __GFP_ACCOUNT,
 					       order);
 	/*
 	 * Best effort allocation from percpu free list.
 	 * If it's empty attempt to spin_trylock zone->lock.
 	 * Do not specify __GFP_KSWAPD_RECLAIM to avoid wakeup_kswapd
 	 * that may need to grab a lock.
-	 * Do not specify __GFP_ACCOUNT to avoid local_lock.
 	 * Do not warn either.
 	 */
 	return alloc_pages_node_noprof(nid,
-				       __GFP_TRYLOCK | __GFP_NOWARN | __GFP_ZERO,
+				       __GFP_TRYLOCK | __GFP_NOWARN | __GFP_ZERO | __GFP_ACCOUNT,
 				       order);
 }
 #define try_alloc_pages(...)			alloc_hooks(try_alloc_pages_noprof(__VA_ARGS__))
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a969a62ec0c3..1fada16b8a14 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4818,7 +4818,10 @@ struct page *__alloc_pages_noprof(gfp_t gfp, unsigned int order,
 out:
 	if (memcg_kmem_online() && (gfp & __GFP_ACCOUNT) && page &&
 	    unlikely(__memcg_kmem_charge_page(page, gfp, order) != 0)) {
-		__free_pages(page, order);
+		if (unlikely(gfp & __GFP_TRYLOCK))
+			free_pages_nolock(page, order);
+		else
+			__free_pages(page, order);
 		page = NULL;
 	}
 
-- 
2.43.5


