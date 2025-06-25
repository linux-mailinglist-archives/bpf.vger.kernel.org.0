Return-Path: <bpf+bounces-61487-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E94AE75F0
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 06:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D7C67A92C3
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 04:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB641EE03D;
	Wed, 25 Jun 2025 04:34:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C0D19C542;
	Wed, 25 Jun 2025 04:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750826047; cv=none; b=k0tjGrsujmaxeZ+n/XlK0pqr4iH95nxmSktmwzjt+BOAu1vbY9ldICExMwE9e69MI2EhxQeVvEr6j43Elp88Wnsr6qeCCaIrNcp+nEHVMAijD/t38Ls5iiBFlOx3UtWfvoQFH/mY9bdjOLI4mNAJBe8kBAlMUOESXS+ZHOBbyxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750826047; c=relaxed/simple;
	bh=u0Epei8ZPF+Ot4HQSjUH7Nttos+q9QG8Q4ljT+2pBw4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IqL1ggKPYrgtqs9hRoZcxTF3yCXZqXyWqXq7eKbFpw3PJg6rsTpQ5tFY+3AazTOgeMgJtbOsbV+jdPL/f8BDwU3DT0n/ffkipJ1Vvk4jql9Yevlf7xsKxjwBVA3rBhm+SrBDY42jhsWTlSdWu7XXZoymm7+Tl3ulvLy4uyF1nBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-fe-685b7c38f21f
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
	vishal.moola@gmail.com,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	jackmanb@google.com
Subject: [PATCH net-next v7 3/7] page_pool: rename __page_pool_release_page_dma() to __page_pool_release_netmem_dma()
Date: Wed, 25 Jun 2025 13:33:46 +0900
Message-Id: <20250625043350.7939-4-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250625043350.7939-1-byungchul@sk.com>
References: <20250625043350.7939-1-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHefeenXNcLo7L6qRBtIpA0bQMny6E9SEORFEkCArmzKMbXqrN
	LY0Cr1iSZhdK56plaPOSi2U6y6x06UyjUpRlNWOmH8oLaQ0vUR01yW9/nuf3/z1fHhrLisU+
	tCollVenKJLkpISQjHqWBew4G6UMcmViMJhrSKieSoN7n61iMFTVI/gx/YGCSVs7CXfvuAXi
	TQ4BP80zGIbaXBRUWw7CQMUwAU15DRhcl+wkFOTMYng6PUZBltUkgrf1hWK4NlOOoSHjMwU9
	jw0kOGv+iGG4pYCADn0lAQOFYdBmXAXuzhEENnODCNwXb5JwtdtIwmDOAILuVhcBpZmFCMzN
	DjHMTgmO0pdOKmwj1zoyjrm6yvcirlH/ieKMFi330OTH5Tu6MWepukBylokrFPexr4nk7MWz
	BNdonRRxBdljJPd9qJ/gxpt7Sc5c10twXUYbddgrUrI7jk9S6Xj1lj0xEuV7dwk6ObY8Lbtk
	mMhAbZ75yINmmRBW7+wjFnNHXg+eyySzmXU4puezNxPMTrraBUZCY+Y+ydpqPlD5iKZXMFr2
	ZafvHEMwm1j7xf55j1TwGNqn8IJzHVv94Pl89mC2swZX9jwjE5jcvky8wHuxHSVfiDklFu6a
	b8nmxlioZj8q/aepo9kbN5MX8hr2hclBFCFGv6St/9/WL2kbEa5CMlWKLlmhSgoJVKanqNIC
	j59ItiDhXyrO/Yqyoom3R1sQQyO5pzQoN1IpEyt0mvTkFsTSWO4tvR4qjKRxivQzvPrEMbU2
	ide0IF+akK+WbnWfjpMxCYpUPpHnT/Lqxa2I9vDJQBWN/v1NMSt3xV4zx4wXqHNH2488yerN
	Kf+2PlEefXXo48hIQsD+UI2Xh3/woDXC73Xzzmeha01O+ylVfO3+1xBnuxx9aO/XtRtQRKqW
	it/2riu69vxAuH+4md+ny1r3iinysubHxva4xCKps+a34ba91qR4VTQYpJWELDtQNqmTExql
	ItgPqzWKv94n0aorAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHe/e+O+e4XByX1SELY1CRlaVdfLIQJcJDYSQFkhE58tRGc9qW
	V4rUKeLw0o3IOcWQzNScLPOGSngfQomSmJbaKisQL7lMm1SbEvXtz//5Pb/ny8NgmYNsZFSa
	a4JWo1DLKQmRnDys3w3Xzyn3Zn/1A5O5ioLKhSR4PN4gBlNFHQL74ggNcx3dFJQ+nMdgepVB
	4Lv5J4ZPXTYaKi1hMFY2QaA5qx6DLb+HgtwMB4aWxSka0hvKRdBeZBVDX12eGO79fIShPnWc
	hoEmEwWjVb/FMNGWS8BqfEJgLC8YukrWw3zvJIIOc70I5nOKKLjbX0LBh4wxBP3tNgKFaXkI
	zK1DYnAsOB2FnaN08Fa+fXIa87VP3oj4RuM7mi+xxPPPyn14w1A/5i0V2RRv+XaH5t8ONlN8
	zwMH4Rsb5kR8rn6K4mc/DRN+uvU1xZd+mRHx5trX5JQsUnIkWlCrEgTtnqAoifLNfAGKm1qT
	pC+YIKmoy92A3BiO3c9ZswawK1Psdm5oaHE5e7J+3JytmxiQhMHsU4rrqBqhDYhh1rLxXGev
	l4sh7FauJ2eYuLLU6TF1L+AVpzdXWfNiObuxBziTTb/MyJxM5mAaXuE9OGvBR+JSYuddc7HM
	VWPnqv55Ib6FpMb/KOM/yvgfVYJwBfJUaRJiFCr1AV/dFWWyRpXkezE2xoKcL1F2Y+l2A7IP
	hLYhlkFyd+nezEilTKxI0CXHtCGOwXJP6f0AZyWNViSnCNrYC9p4taBrQ14MkW+QHo8QomTs
	ZcU14YogxAnav1MR47YxFUVcpHYE7v591nymejXyqR5s5Wr8qT7lTdorMKC0aCkmIsiedsaP
	Dfe+2pM4k5Z+qbjZcGzb5vtblj7YWvadD4ntU2uU4WEHwwNPtIf5D2/yHDhtwYmhq2cP2e3r
	HB4hTFZHvihjV5/i8/uj7omM49GvlKYfmUzcqpeRqTtJ9SarnOiUCj8frNUp/gAPyMa1DgMA
	AA==
X-CFilter-Loop: Reflected

Now that __page_pool_release_page_dma() is for releasing netmem, not
struct page, rename it to __page_pool_release_netmem_dma() to reflect
what it does.

Signed-off-by: Byungchul Park <byungchul@sk.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 net/core/page_pool.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 3bf25e554f96..95ffa48c7c67 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -673,8 +673,8 @@ void page_pool_clear_pp_info(netmem_ref netmem)
 	netmem_set_pp(netmem, NULL);
 }
 
-static __always_inline void __page_pool_release_page_dma(struct page_pool *pool,
-							 netmem_ref netmem)
+static __always_inline void __page_pool_release_netmem_dma(struct page_pool *pool,
+							   netmem_ref netmem)
 {
 	struct page *old, *page = netmem_to_page(netmem);
 	unsigned long id;
@@ -721,7 +721,7 @@ static void page_pool_return_netmem(struct page_pool *pool, netmem_ref netmem)
 	if (static_branch_unlikely(&page_pool_mem_providers) && pool->mp_ops)
 		put = pool->mp_ops->release_netmem(pool, netmem);
 	else
-		__page_pool_release_page_dma(pool, netmem);
+		__page_pool_release_netmem_dma(pool, netmem);
 
 	/* This may be the last page returned, releasing the pool, so
 	 * it is not safe to reference pool afterwards.
@@ -1136,7 +1136,7 @@ static void page_pool_scrub(struct page_pool *pool)
 		}
 
 		xa_for_each(&pool->dma_mapped, id, ptr)
-			__page_pool_release_page_dma(pool, page_to_netmem(ptr));
+			__page_pool_release_netmem_dma(pool, page_to_netmem((struct page *)ptr));
 	}
 
 	/* No more consumers should exist, but producers could still
-- 
2.17.1


