Return-Path: <bpf+bounces-54914-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA6FA75D7B
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 02:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96B2B3A42C2
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 00:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD6AFC0B;
	Mon, 31 Mar 2025 00:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVKi1Arp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491F94431;
	Mon, 31 Mar 2025 00:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743380898; cv=none; b=i2xVXDdElDZTusP4osdx3442YFcxrRS196GU0Omf1aRMG3Q0ZBBBBCOCtuJRDDN3Cok3GvLYr+5jNamOwTnB4QqWNnP/ZvJO2orTAbnCA5yGSRXkfxtjx1Gnr7MDj4efuZs2Gwm9SAPtBUrF1ke3C1TazG3PC+XXRjBghctVNR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743380898; c=relaxed/simple;
	bh=7kJ4JuDRcTOcW2z/dFRyfD40/2WD22AYsATquheyns0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iGCWNckxPWUSOUXf3LnTxk/ClRlTgn5xuKCjTSA/JsBdM1TvEkpMjoFN6fVXxzmp0v7XCGvH+83FixEKuSe9mAn23UGsgcy9fzP9hv4DJ+Uoz34fFHZQgKGMoRCjJpMdZn6kvwbbohEs7B4T51V0PcKgl+Xka4v1+QTGXV6Exg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VVKi1Arp; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ff784dc055so6423116a91.1;
        Sun, 30 Mar 2025 17:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743380894; x=1743985694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rFi5AJSWI2YMMuD5etUG01CTNnkiusxKc3AgS1Fz8Ig=;
        b=VVKi1ArpUQeQ/NqESHGMhuc9DDov9KTsCqa4fOY4V+TLCobYwjIipnPZQyxRr5c/UF
         B78FwlqrD/Ih+n1HMWJzRDEXc6e3h0meDCQJH/h3U9z5Xml0Chcifo5kx6jFMvRAPpvW
         3w8hAuBgLTLdSNy0F51rPveogknMvU0SfsbKfFxB3A9yuKNwzzwgtxsmzPCwRQi3rZul
         S7gFZiAAT1KuS+/pq1hgF/eTR23iC0vyE0pyRUcLNa2W99sASuA8e5imOaT6E/PCn2fO
         XgC9R4o79nkywnBJs4LY83Q6ddz0jHNyrAlyxGMw77jxXfQ5kX35x9KCHCEWiUqXl9+8
         FnNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743380894; x=1743985694;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rFi5AJSWI2YMMuD5etUG01CTNnkiusxKc3AgS1Fz8Ig=;
        b=CQk+xDO8vfMhTTWiDg7kB9YI9Dsov53z437hdTBYjNf4VBuDiJ4PSONGnHSvm8xO1R
         H0ehMMybOVze5UpXT1nuW5NMMJjksZnLQGsR2yEVbTqoqRkjf7UUpKQ/OLGGH2GLvhJ5
         alErIHCEuC2r9ugFtU6lBYE4YsH+Yjn5Re/0UdEG02GEN9ZvDZu7Y/opzBwfJWXSen1O
         BErCk0hF2lg/0TlDG9Ku8D+LHiDSBlsMqbAHsTCNUMd1f+4RBPeVOpi6+JXMk+aElq3W
         Zytsov+GomowqWsKo4M+iWnsZeDwdDuF0P2i+2N1XSMj1bFtEQiL4LEGmA+cZedDLaTk
         MEHw==
X-Forwarded-Encrypted: i=1; AJvYcCVJZdt0SsAMnJQ4w1JBA1NMc8x20jEu1iyvNBpql/cT4GFMWGaUMcViuMMsZq/6d8LXsvrnoOiCfiibcFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLpLywSlfFuFAppK5e4pzxVnjtjZ0lK/acz0/mSDPr3oZ1XLcF
	uY+1T/w1h2T5VowmysgA7SoE7L++0cCWJ0lIpYikcZEERrzQsJ3z
X-Gm-Gg: ASbGncv2zLvygQ6XWLDKiVzqzEfxfr7Wh1OuZETcEWEgo7+QSYAY0sF6gI+cL8TKkya
	3yGxCxF3DHiJrv+RXZq3dwP2hN8tG7REtItpulSXKdO0YzanOPQ/crL4oLNyyUrYHIvuDXVZovl
	sCtfZswzlEhSTHDuG5BacHOGSszcoCWKxFa3LctApMvEkighaww9xBdSTmOI8PiQgNpMQXr9HI0
	2mK30Y91/qvS9fcwV8rpP1iE804xsuY9jhr16L1xuKYeOW80UJ269YBDKGJcIkD5Cl9SXLnSqUR
	HDdgcyd9P4vHwZeJRs9NopLBjZqC0NBDqb8+VHKPsmXWQiMHKAin2QE1lw4drgIiouFiLb1g
X-Google-Smtp-Source: AGHT+IGd9xVHYNN5LAtu0WVsviR9zrZOcbiQrZ0CixultBjriE+r9Er3YZeWI0M2GMQRlBvx3P1H7g==
X-Received: by 2002:a17:90b:384d:b0:2ff:7b28:a519 with SMTP id 98e67ed59e1d1-30532158ee8mr10273885a91.30.1743380894198;
        Sun, 30 Mar 2025 17:28:14 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:22d1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3039dfd4ab0sm8385636a91.6.2025.03.30.17.28.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 30 Mar 2025 17:28:13 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	akpm@linux-foundation.org,
	peterz@infradead.org,
	vbabka@suse.cz,
	bigeasy@linutronix.de,
	rostedt@goodmis.org,
	shakeel.butt@linux.dev,
	mhocko@suse.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH mm] mm/page_alloc: Avoid second trylock of zone->lock
Date: Sun, 30 Mar 2025 17:28:09 -0700
Message-Id: <20250331002809.94758-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

spin_trylock followed by spin_lock will cause extra write cache
access. If the lock is contended it may cause unnecessary cache
line bouncing and will execute redundant irq restore/save pair.
Therefore, check alloc/fpi_flags first and use spin_trylock or
spin_lock.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Fixes: 97769a53f117 ("mm, bpf: Introduce try_alloc_pages() for opportunistic page allocation")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 mm/page_alloc.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e3ea5bf5c459..ffbb5678bc2f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1268,11 +1268,12 @@ static void free_one_page(struct zone *zone, struct page *page,
 	struct llist_head *llhead;
 	unsigned long flags;
 
-	if (!spin_trylock_irqsave(&zone->lock, flags)) {
-		if (unlikely(fpi_flags & FPI_TRYLOCK)) {
+	if (unlikely(fpi_flags & FPI_TRYLOCK)) {
+		if (!spin_trylock_irqsave(&zone->lock, flags)) {
 			add_page_to_zone_llist(zone, page, order);
 			return;
 		}
+	} else {
 		spin_lock_irqsave(&zone->lock, flags);
 	}
 
@@ -2341,9 +2342,10 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 	unsigned long flags;
 	int i;
 
-	if (!spin_trylock_irqsave(&zone->lock, flags)) {
-		if (unlikely(alloc_flags & ALLOC_TRYLOCK))
+	if (unlikely(alloc_flags & ALLOC_TRYLOCK)) {
+		if (!spin_trylock_irqsave(&zone->lock, flags))
 			return 0;
+	} else {
 		spin_lock_irqsave(&zone->lock, flags);
 	}
 	for (i = 0; i < count; ++i) {
@@ -2964,9 +2966,10 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
 
 	do {
 		page = NULL;
-		if (!spin_trylock_irqsave(&zone->lock, flags)) {
-			if (unlikely(alloc_flags & ALLOC_TRYLOCK))
+		if (unlikely(alloc_flags & ALLOC_TRYLOCK)) {
+			if (!spin_trylock_irqsave(&zone->lock, flags))
 				return NULL;
+		} else {
 			spin_lock_irqsave(&zone->lock, flags);
 		}
 		if (alloc_flags & ALLOC_HIGHATOMIC)
-- 
2.47.1


