Return-Path: <bpf+bounces-59056-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B60D5AC5F54
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 04:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C67C4A0E6A
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 02:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20251DE3BB;
	Wed, 28 May 2025 02:29:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5B91C862F;
	Wed, 28 May 2025 02:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748399367; cv=none; b=mXHrba6IsNiOMA0O3ITJhI5E3sj3kipSkqZKMoNQ/CJteupB0qDuDPBxkWT+fZH8+aK/YHmSEP9TMyzkQx8mG2tl1Y4pPPi4cLVXoYQmI+VanjPh8tEnbkolzOmMhIwTj430G7j/oKFFCgk4VdMiLLWd0/Peh/sPJkSZZx2IkCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748399367; c=relaxed/simple;
	bh=tBde3LU+2rZfI2yUYys643X8X47mUeuMIdg6rbr6seA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=dtCPQ4PIUyagn1uB7BxCslr8BZBCmf318e/XLJFpJa584+6KQqkoGE3AGJ92j78Psf47cx0Pya5Gq3SUS1EGTRTfhc1hnpQKx4kDlYppXAv6oLVmvuGkwEbD2ZGh3i76tcSw//62R72vZ349HH6w0SszI8dgJhLoXt+NjoEL1f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-69-68367501a16e
From: Byungchul Park <byungchul@sk.com>
To: willy@infradead.org,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel_team@skhynix.com,
	kuba@kernel.org,
	almasrymina@google.com,
	ilias.apalodimas@linaro.org,
	harry.yoo@oracle.com,
	hawk@kernel.org,
	akpm@linux-foundation.org,
	davem@davemloft.net,
	john.fastabend@gmail.com,
	andrew+netdev@lunn.ch,
	asml.silence@gmail.com,
	toke@redhat.com,
	tariqt@nvidia.com,
	edumazet@google.com,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	leon@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	bpf@vger.kernel.org,
	vishal.moola@gmail.com
Subject: [PATCH v2 08/16] page_pool: rename __page_pool_release_page_dma() to __page_pool_release_netmem_dma()
Date: Wed, 28 May 2025 11:29:03 +0900
Message-Id: <20250528022911.73453-9-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250528022911.73453-1-byungchul@sk.com>
References: <20250528022911.73453-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRXUhTYRzGfXfenR2Hg8OMOhVlTSoQ0ozSfxCmQvBGXRTdJZlTT23mpm1+
	zCKwkiLLKVpkNnMl2dyE2fychNi0NFOyibbKVGYWRR/MpakzzSXePfyeh9/Nw1DSTryBUaqz
	eI1ani6jxVj8I+jhTkF2lGKX3i4Gg7WOBsusDh6PtwrBYG5G8Hvugwi8Xd00VD+YocDwugDD
	tHWegskXbhGM1XzG8PRaCwXu4h4aigp8FFxuNQlgoFkvhFvzjyhoyR8XwWCbgYbRuiUhfHYU
	YXhZUYthTB8LL4xrYebVdwRd1hYBzNyspKHMaaRhomAMgbPTjeHeJT0Ca7tLCL5ZAx27lTTW
	vhMQe8VHETHaskmDKYwUupwUsZmv08Q2VSoiI8NPadJT7sPE3uoVkKIrP2nimXyPya/2IZpY
	G4cw6TN2iYjXtvkoe0K8P5VPV+bwmoiYJLGid75fmKmX6IYveal8NC8uRIEMx+7hBqs7qNXs
	vl+D/Zlmd3Au19x/voaN5Lzu7mUuZij2p5CbNPgE/iKYVXO3f9QJCxHDYHYbNzyU5ccSdi83
	Om6hV5whnKXe72eYQDaKez6S4sfS5cmvG1bkV3LsnIj70jmLV/bruWcmFy5BEiMKMCOpUp2j
	kivT94Qr8tRKXXhKhsqGlq+tubiQ0IqmBo47EMsgWZCE1O9VSIXyHG2eyoE4hpKtkVw+EKWQ
	SlLleed5TcYpTXY6r3WgjQyWrZPsnslNlbJn5Fn8WZ7P5DWrrYAJ3JCPDm1hPclxyfsEuRe+
	mpc8A1N/D6dQpoOWI8ZB+5tjE7r40MXok/FNxVVtNzNPLwQ9GdnuvFvS01/aUjY6raq0iBq5
	+A9pcWl/2iLCY2TR59CmfYWN3ESAD3vupKZVjV5VxfYm9FWFJnYYdMXjIW+bkt5XxgYnihfX
	fiv/1OAabpdhrUIeGUZptPJ/SK0e+dYCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTcRyG+5/bjrPBaUmd7D6LSugGab/ookHgn4IIihQhaujJLedam4oW
	wVIpsra00qymzcLljWZLdKaYTNOsdcHS1mWpq42CvNRMdAvKEX17ed6H98vLklILFckq1ZmC
	Vi1XyRgxJd67NX8tyopVbBj2bQGTtZ6BuqkcuDtkp8FU24RgYvqDCPxdPQzcqZwkwfSygIJf
	1gAJ3m6PCAYtPgrazjWT4Ln0hAFDQZCEPHs1AZ3lvTS8ajLScDVQRUKzfkgErx+aGPhU/4cG
	n8NAQe+NGgoGjfHQbZ4Hk8++I+iyNhMwebGcgSt9ZgY+Fwwi6Ov0UHDzjBGBtd1FQ3DKxMTL
	cGPNOwK33HCLsNmWhR9UR+NCVx+JbbXnGWz7eVmEPw60MfhJWZDCLXY/gQ35owz+4X1P4bH2
	fgbf+TpOYGtjP4Wd5i7RvjnJ4m2pgkqZLWjX7zgiVjwNPKc1RknOwBk/qUcBcSEKY3luE++p
	sFChzHCreJdrmgzlCG4j7/f0zHAxS3KjNO81BYlQMZdT8yUj9XQhYlmKW8kP9GeGsISL4T8N
	1TH/NpfydQ0dZEgJ42L5xx9TQlg6o4xdsKIiJDajWbUoQqnOzpArVTHrdOmKXLUyZ13K8Qwb
	mnnPcvp3sR1NvE5wII5FstkS3BCjkNLybF1uhgPxLCmLkOTFxSqkklR57klBe/ywNksl6Bxo
	IUvJ5kt2JwpHpFyaPFNIFwSNoP3fEmxYpB5d1nrTdk3oDO7hKPny1cVxx1ISxl/8WLzmYNC0
	eWf4g8I3o7d9394sqzIs6Xilr3i01HnCvoBI1FSmnijaM2fTSFL4l8RTNKuJan07RSbHdS46
	Gmk+NtUanhRd7pZcJfl718/6Sn/2R6wfD+zffujWgVFTWbVzeAVR6r52pSTxvs0po3QK+cZo
	UquT/wUpO1o2uQIAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Now that __page_pool_release_page_dma() is for releasing netmem, not
struct page, rename it to __page_pool_release_netmem_dma() to reflect
what it does.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 net/core/page_pool.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index fb487013ef00..af889671df23 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -674,8 +674,8 @@ void page_pool_clear_pp_info(netmem_ref netmem)
 	netmem_set_pp(netmem, NULL);
 }
 
-static __always_inline void __page_pool_release_page_dma(struct page_pool *pool,
-							 netmem_ref netmem)
+static __always_inline void __page_pool_release_netmem_dma(struct page_pool *pool,
+							   netmem_ref netmem)
 {
 	struct page *old, *page = netmem_to_page(netmem);
 	unsigned long id;
@@ -722,7 +722,7 @@ static void page_pool_return_netmem(struct page_pool *pool, netmem_ref netmem)
 	if (static_branch_unlikely(&page_pool_mem_providers) && pool->mp_ops)
 		put = pool->mp_ops->release_netmem(pool, netmem);
 	else
-		__page_pool_release_page_dma(pool, netmem);
+		__page_pool_release_netmem_dma(pool, netmem);
 
 	/* This may be the last page returned, releasing the pool, so
 	 * it is not safe to reference pool afterwards.
@@ -1140,7 +1140,7 @@ static void page_pool_scrub(struct page_pool *pool)
 		}
 
 		xa_for_each(&pool->dma_mapped, id, ptr)
-			__page_pool_release_page_dma(pool, page_to_netmem(ptr));
+			__page_pool_release_netmem_dma(pool, page_to_netmem((struct page *)ptr));
 	}
 
 	/* No more consumers should exist, but producers could still
-- 
2.17.1


