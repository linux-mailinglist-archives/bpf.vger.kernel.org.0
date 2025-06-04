Return-Path: <bpf+bounces-59624-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31191ACD601
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 04:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 259B23A80E8
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 02:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18762259C98;
	Wed,  4 Jun 2025 02:53:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7CB22A4EB;
	Wed,  4 Jun 2025 02:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749005594; cv=none; b=tRolnTrKeRtVTIIwRGe+B0TKyItFIyVTEW4ul9nCtujpancVkAf0APlIFnLGvv5Ks79DBfVCPesWg66eJT19ABhD5ntRqR2ey6iREuqqot5gL+wGIsP9hwf5aqLIVaCOnZTHeWni0ouODrCtT291we3JQB2kQPxSBTYDWtEQ2/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749005594; c=relaxed/simple;
	bh=IGTxdFV2ktTOkIESeZoVlbIauWO6Irq5WjUlVRKa8/4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=KjDi1t+fQdr21ZOwPCqnEslIJGOxv2oVv975C1MNQSSGH6JlcFv7vpjbhRu7ynltBtHaIxNtcuKqF5Nx3cbJbrkmTpwFV0VLQbWY8v0/5RuKG2XDlRfD0MwZYhwp2U7KW6l3MJsqzMzU0ZhaFff9pCVTD4jHv+9GnbfNasjtRII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-1e-683fb50a148c
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
Subject: [RFC v4 10/18] page_pool: rename __page_pool_alloc_pages_slow() to __page_pool_alloc_netmems_slow()
Date: Wed,  4 Jun 2025 11:52:38 +0900
Message-Id: <20250604025246.61616-11-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250604025246.61616-1-byungchul@sk.com>
References: <20250604025246.61616-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRbUhTYRiGfXc+PTY6raiTldmoxCjTMHkisU/whQoiqcCIGu3QRnPKVqZh
	YDqoRjPJoLBVy0rNpNXUnCaSa6lRoVjmMs2xMkFT0dVQp5Wb9O/iup/7/vOwhMxJhrNq7WlR
	p1Vo5DRHcsPz7m3garapYuv+hIHZWknD44ksKHPbKTBXPEfwa/ILA15nCw337/kIMLcZSPht
	nSKgv9nDQF/pDxIaLtYS4LnaSoPJ4Ccgz14ugfbnBRRcn3pIQG2um4EP9WYavlb+peCHw0TC
	m+JHJPQVbIdmy2Lwvf2JwGmtlYDvym0aijosNHwz9CHoeOUh4daFAgTWRhcF/gkzvX0Vrn70
	WYLrinsZbLGdwVXl67DR1UFgW8VlGtvGrzG451MDjVtv+klcZ/dKsCl/hMZj/d0kHm3spLG1
	upPE7yxOBnttEfv5VC5RKWrUmaJuY9JxTlXS0Uxl1HFZZd8biVw0yBpRKCvw8UJ3UTVlRGyQ
	fb17A5rmowSXa5II8CI+TvB6Wkgj4liCH6GEfrNfEggW8hqhqLAhyCS/RqiprwoWpHyC0HD/
	PTG3v1J4/PRlkENnfc/IjeC9jN8smOwficCowA8zwouhIWausFRoKneRhUhqQSEVSKbWZqYp
	1Jr4GFW2Vp0VcyI9zYZmf1t6fvqIHY23pzgQzyL5PKm9J0kloxSZ+uw0BxJYQr5IujJ6VkmV
	iuxzoi79mO6MRtQ70DKWlC+RbvKdVcr4k4rT4ilRzBB1/1MJGxqei/Lcu3Oo0lPzd3beLTPo
	lw9x3sQ9hVGc6q1lbIZI3qrsStkxEXLWHB9R7nC//pla//BN9KXooW/p+5TTz2LXu9URCcme
	wwNXI5scbata21bPVM/szk8ZKJlyvuq0xPpKHnxu7zq6P0e2ZUGf5E7krgPJa5+EHbo1dvDo
	YPviFM+K5aNyUq9SxK0jdHrFP9MhRuTXAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTcRyG/e9cdjYdnJbUQSFpIJKQJmT9yjCpoEOF9anIIh16cMt5YZsy
	C8t0EI2mlkaik6ZW8waLeZsyrOY9s2JqzdKUTS3MTNNEXVY66NvD877vp5fCxCY8gJKnqTll
	mlQhIYW4MDYqf6+g+ahsn3vqMBjMDSTUr2rANGklwFDXgmB57RMflrp6SaiuXMHA8FaLwy/z
	OgbTPS4+TDydwcF2uxUDV2EfCXqtB4M8aw0POiv6CXjXUkBAyfoTDFpzJ/kw1G4g4XPDXwJm
	7Hoc+stqcZgoiIEe4w5YGZhD0GVu5cHK3QoSih1GEtzaCQSOThcO5bcKEJg7nAR4Vg1kjIRt
	qh3lsW1l43zWaMlkG2tCWZ3TgbGWujska/l5n8+OvbeRbF+pB2fbrEs8Vp8/T7KL0x9x9kfH
	CMlWf13gseamEZx9bezin9sWJzySxCnkWZwyPDpBKKty9BAZbUKNaaoDy0WzlA5RFEPvZ1bG
	z+iQgCLpEMbpXMO22J+OYJZcvbgOCSmMnieYaYOHtxVspxVMcZHNyzgdzDS3N3oHIvoAY6se
	9DJDBzH1z154WbDpx+YfevtiOpLRW4exIiQ0Ip865C9Py0qVyhWRYaoUWXaaXBOWmJ5qQZv3
	Pc35fc+KlodO2hFNIYmfyDoWLRMT0ixVdqodMRQm8RcF7dlUoiRp9jVOmR6vzFRwKjsKpHDJ
	TtGpC1yCmE6WqrkUjsvglP9THiUIyEWOXWdLE0/ofTVceElIZc5kt5r+EOUeufqNcmlDZyFh
	d2BD2frx5NOFLwOzfI71G0YflD8qcgxWLJaZpv/4ovjYx/rlYfuhqZuy3iuW4OiugY2DakuM
	zfHK9GWuqkq6cd59Q9t+0Zl3XXP5+5vAS89DCLVvU5yldKMb19ELfqUSXCWTRoRiSpX0H6LA
	lgq6AgAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Now that __page_pool_alloc_pages_slow() is for allocating netmem, not
struct page, rename it to __page_pool_alloc_netmems_slow() to reflect
what it does.

Signed-off-by: Byungchul Park <byungchul@sk.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
---
 net/core/page_pool.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 0d6a72a71745..47cec631f598 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -543,8 +543,8 @@ static netmem_ref __page_pool_alloc_netmem_order(struct page_pool *pool,
 }
 
 /* slow path */
-static noinline netmem_ref __page_pool_alloc_pages_slow(struct page_pool *pool,
-							gfp_t gfp)
+static noinline netmem_ref __page_pool_alloc_netmems_slow(struct page_pool *pool,
+							  gfp_t gfp)
 {
 	const int bulk = PP_ALLOC_CACHE_REFILL;
 	unsigned int pp_order = pool->p.order;
@@ -616,7 +616,7 @@ netmem_ref page_pool_alloc_netmems(struct page_pool *pool, gfp_t gfp)
 	if (static_branch_unlikely(&page_pool_mem_providers) && pool->mp_ops)
 		netmem = pool->mp_ops->alloc_netmems(pool, gfp);
 	else
-		netmem = __page_pool_alloc_pages_slow(pool, gfp);
+		netmem = __page_pool_alloc_netmems_slow(pool, gfp);
 	return netmem;
 }
 EXPORT_SYMBOL(page_pool_alloc_netmems);
-- 
2.17.1


