Return-Path: <bpf+bounces-58801-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 405C2AC1A73
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 05:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67CA8A43BCD
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 03:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E55224B0E;
	Fri, 23 May 2025 03:26:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5511221570;
	Fri, 23 May 2025 03:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747970787; cv=none; b=HFn71WZeosef8JUoAtm65wrY4V1YTbIhAZhMeuLEn7z08IeXpzEbWcn+EUPt+qJTUuvGUtP1dERhdqtsNO7xTmS6P3EHsV3mg4R5gCs/5gAEs13pRcAu+HoyCMo7oc+EdYuIBDljx/+eVu8xdM2u1iNbE6t8sT5LvHUmvQVsbNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747970787; c=relaxed/simple;
	bh=iLBsNwQGs9JG8J4PoJjo2V7qLU09wpvyguveTj5CO20=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=fkcBJUoi9MOVzM8ViSXOeffU6hMnD3ByVkxkxDGCyWtgCOzcBX40EQ6Jt7L681QaGytyy8wlx6YuAYK5tbjOB8HULR3IKsBUFIt01iuTa0wvRhr6aa/sC3/ErHZs9aFe4KrFknNDpDoLFjTMWk7V6XvN+TNur9D5/gwkLatSnok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-bb-682feadc7dbc
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
Subject: [PATCH 08/18] page_pool: rename __page_pool_release_page_dma() to __page_pool_release_netmem_dma()
Date: Fri, 23 May 2025 12:25:59 +0900
Message-Id: <20250523032609.16334-9-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250523032609.16334-1-byungchul@sk.com>
References: <20250523032609.16334-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRW0hTcRzH/e+cnXMcDg7L6mRSOZFKyMuw+gkV9lCdl8JuCPagh3Zwyzll
	XtJAsTLUlRcssmzVJDJvsVims7zkvMYUZaVNM69NUMpyy+WlKKf09uH7/fJ5+VKYxIz7UEp1
	Cq9RcyopIcJF37zK943OBStCHKW+oDPUElCzlA7PJkxC0FXXI/i5/IkEZ0c3AU/KXRjo+nNw
	WDSsYGDvmiJhvGIGh6bcBgyminoIKMhZxeCaqVIAA/WFQriz8hSDhuwJEt6/1hEwVvtXCDPm
	AhzelVXhMF4YAV36LeCyfEXQYWgQgOvWQwJuW/UETOeMI7C2T+Hw4GohAkOLTQirSzoiwo+t
	qxoWsI1ln0lWb0xlX1YGslqbFWON1fkEa3SUkOzoUBPB9txbxdlGk1PAFlyfJ9gF+wjOfm8Z
	JFhD3SDO9uo7SNZp3BFJR4sOyXmVMo3XBB+JFSnyZlqFSTavdOvELzIbDYm0yJNi6DCmutxJ
	ahG1zjdqz7hjgt7N2GzLmJu96VDGOdWNa5GIwuh5IWPXrQrcxSY6nlmw2kk343QAM97YQLg9
	Yno/87guYEO/k6l58Xbd40kfYIrHFgk3S9Ymbz6MkBubZZJxzUZs8DamrdKGFyOxHnlUI4lS
	nZbAKVVhQYoMtTI96GJighGtPVuR+fuCCTkGzpoRTSGpl9gkClZIhFxackaCGTEUJvUWd84E
	KSRiOZdxhdckxmhSVXyyGW2ncOlWscx1WS6h47gUPp7nk3jN/1ZAefpko+hHXwaGbx6f7Ltv
	6dsz9zuztSTEl7KH5jWf9NC+4mSk8fzz0lPhbe10XUBvqE/ctP8lWbHFpU6yOI5F8a2Hcxc8
	i4ZOBHfLZrNPh9VG4UuTMefKNeFekf2xuf5ayVJNa3e+XPUj62Mm94euyIqBZr/iXZs7K+7u
	rUpxtUwePSjFkxVcaCCmSeb+AWqiMS/VAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTcRyG+++cnXNcTo9L8mBSNJJikG6o8YtuEoInA4u+BIHlyoNbuimb
	LhdElhPN0kwry2atJPMGsylOU8zmnYRiXlhmTq2ti2F5TV1RLejbw/u+PF9eChNV4cGUUp3B
	adTyVDEhwAXxe3J2jn8JV0gt+f5gNNcTULeSBU8mW/hgrG1GsLj6loSF7j4CKh8uY2B8ZcBh
	ybyGgat3mgRnlRuH9jwrBtPX+wkoNHgwuNxSzYOuigE+vG4u4sPNtccYWLMnSRh6ZiRgov43
	H9y2QhwGymtwcBZFQ69pIyy//Iqg22zlwfK1CgJK7SYC3hucCOxd0zjcu1SEwNzh4INnxUhE
	i9mmmjc8trX8HcmaLJlsY7WELXDYMdZSe4VgLfMlJDs+2k6w/Xc8ONvassBjC3NmCXbONYaz
	3zpGCLby03cea24awdlBUzd5NOCEYG8Sl6rUcZrw/YkCRb77OT/d4Ztln/xBZqNRQQGiKIaO
	ZHLrjxUgH4qgtzMOxyrm5UBaxixM9+EFSEBh9CyfcRk9PG+xgU5h5uwu0ss4Hco4W62E1yOk
	o5gHTaHemKG3MHUNnf88PvQupnhiifCy6O+kbXiMLEYCE1pXiwKVap1KrkyNCtOmKPRqZVbY
	mTSVBf19r+rCzxstaHEo1oZoCol9hTtU4QoRX67T6lU2xFCYOFDY4w5TiIRJcv15TpN2SpOZ
	ymltaBOFi4OEcce5RBGdLM/gUjgundP8b3mUT3A2Ojv8SNn+tDNmCsDZ1B5V2tGjPzQV73t1
	QrP1gNg43+a8qzXu1ika9gXHBvV8ToysQJ1rJZIXZRe3OTff9g9sC5mJPRk32GudjSlrWPSz
	hEjdHxNGpX55ZfKIgPU1uZ7TCwb1EETISu5LbimPNKZLD9v8Zb/0CbncuQ/BM8kHxbhWIZdJ
	MI1W/ge/8HDcuQIAAA==
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
 net/core/page_pool.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 00bd5898a25c..fd71198afd8b 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -673,7 +673,7 @@ void page_pool_clear_pp_info(netmem_ref netmem)
 	netmem_set_pp(netmem, NULL);
 }
 
-static __always_inline void __page_pool_release_page_dma(struct page_pool *pool,
+static __always_inline void __page_pool_release_netmem_dma(struct page_pool *pool,
 							 netmem_ref netmem)
 {
 	struct page *old, *page = netmem_to_page(netmem);
@@ -721,7 +721,7 @@ static void page_pool_return_netmem(struct page_pool *pool, netmem_ref netmem)
 	if (static_branch_unlikely(&page_pool_mem_providers) && pool->mp_ops)
 		put = pool->mp_ops->release_netmem(pool, netmem);
 	else
-		__page_pool_release_page_dma(pool, netmem);
+		__page_pool_release_netmem_dma(pool, netmem);
 
 	/* This may be the last page returned, releasing the pool, so
 	 * it is not safe to reference pool afterwards.
@@ -1139,7 +1139,7 @@ static void page_pool_scrub(struct page_pool *pool)
 		}
 
 		xa_for_each(&pool->dma_mapped, id, ptr)
-			__page_pool_release_page_dma(pool, page_to_netmem(ptr));
+			__page_pool_release_netmem_dma(pool, page_to_netmem((struct page *)ptr));
 	}
 
 	/* No more consumers should exist, but producers could still
-- 
2.17.1


