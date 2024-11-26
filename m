Return-Path: <bpf+bounces-45607-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E7F9D8F9E
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 01:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDB561675C7
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 00:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8627E8831;
	Tue, 26 Nov 2024 00:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="umgQduCH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A5546B5;
	Tue, 26 Nov 2024 00:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732582339; cv=none; b=IXWJGCImrGGyyZxvnWe1DE3fNWGT2dDyMMdIczCoiC4M4tkfW4ooTH2LtwDxkn+S7UcA7fxtFoZWBcupAJDM8RSM9qtoR8UlgIlXN1lls613v26It/1utWUP6EEzmxFLgppZjvIwCXFBAEWqZHEw+PIb2znUyt7LLQ0FRCDUA0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732582339; c=relaxed/simple;
	bh=B1+ggchJb8GusZDAY26niU/dmeqT4DRum6Nh2NFx7AM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=huqOkPaGAmgfWBAh+MiaTxPnx90f1J1fupeD+LOKIH/63r+tmPHYDgduu7LIDID/szWXaOdN7pAyznB6sxznqsR+Z9DigZ5K4EOoZy/3qfWgxIIyWZhV2kVQhVyFn84oE1ZAaCGdL4pnEuceGfuAd+6Yl4aankclCpWoXQCp6Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=umgQduCH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68BCAC4CECE;
	Tue, 26 Nov 2024 00:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732582338;
	bh=B1+ggchJb8GusZDAY26niU/dmeqT4DRum6Nh2NFx7AM=;
	h=From:To:Cc:Subject:Date:From;
	b=umgQduCHCBujzvVdlYa68l6rdolQMJYXalMOc7Xv+z/Sr924eEOb3KoG3E9Xl93hF
	 uLm1/E2fyvuVI87zwJ7KAbOddh9mPFXyF3NjpLfGQ2GhbjinV9EhFX1QwqFel0dMTO
	 +o2gaOroUjMS1vGqt9dI9YoZC4M14s4iGrwyrajKCpLXCXQvG+BIlhYkTVrlJB8mA8
	 w4C1T0pSYFSU0mRtXcqT3btE1q/HZx54umah3cc9BfYT7zHNk60n3nZ9rEIjiTXcie
	 idSvDMIq3EYXpkE7uEsPRrKoFCgUQBbc9mxN+8oLPnMxFrEHcjQuaggxcxD6Lq+fcx
	 508+bPYJr3J/g==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-mm@kvack.org,
	akpm@linux-foundation.org,
	urezki@gmail.com,
	hch@infradead.org
Cc: vbabka@suse.cz,
	dakr@kernel.org,
	mhocko@suse.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	ast@kernel.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH mm/stable] mm: fix vrealloc()'s KASAN poisoning logic
Date: Mon, 25 Nov 2024 16:52:06 -0800
Message-ID: <20241126005206.3457974-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When vrealloc() reuses already allocated vmap_area, we need to
re-annotate poisoned and unpoisoned portions of underlying memory
according to the new size.

Note, hard-coding KASAN_VMALLOC_PROT_NORMAL might not be exactly
correct, but KASAN flag logic is pretty involved and spread out
throughout __vmalloc_node_range_noprof(), so I'm using the bare minimum
flag here and leaving the rest to mm people to refactor this logic and
reuse it here.

Fixes: 3ddc2fefe6f3 ("mm: vmalloc: implement vrealloc()")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 mm/vmalloc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 7ed39d104201..f009b21705c1 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -4093,7 +4093,8 @@ void *vrealloc_noprof(const void *p, size_t size, gfp_t flags)
 		/* Zero out spare memory. */
 		if (want_init_on_alloc(flags))
 			memset((void *)p + size, 0, old_size - size);
-
+		kasan_poison_vmalloc(p + size, old_size - size);
+		kasan_unpoison_vmalloc(p, size, KASAN_VMALLOC_PROT_NORMAL);
 		return (void *)p;
 	}
 
-- 
2.43.5


