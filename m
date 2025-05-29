Return-Path: <bpf+bounces-59246-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CEEAC7635
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 05:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 348101C05504
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 03:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75C02586C2;
	Thu, 29 May 2025 03:11:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5AE247DEA;
	Thu, 29 May 2025 03:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748488273; cv=none; b=rnrRDLdncy5mcRjcBBgZtyvOChT0o4qgBh4FGVwTy5rpEYs6OuDUUPbBljH7gOR3DvY4DNsAGpU6IMJs3S1CmSHe2Urip3jAvpVETZMffdYRFJMuDLIGSnw4C2vSJ653HxU2ci5Q4SdMoO0LLZFl00KJSuEw15Tj8OC3jBhJgJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748488273; c=relaxed/simple;
	bh=T7VsDJAf/JyWvc+iiMEhAwa1VT9UwjZCK0qnx0Yindo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Rch+x7LhN0p150MzJA2rJVf1rJDDP+F0hmntr/P6yR0qJmvlw2Qswn5Xr8VJSncPKwWZQ/LoPR7QSwsZNiQLHiM83DUPDLHA3Q8DfDNdjcF0iYmjkuE7IYpXWypJLchybdHYonGFGJg+GjCHDOdEHJCLTn9KgkCFRDAVuHhYOzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-28-6837d042c041
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
Subject: [RFC v3 10/18] page_pool: rename __page_pool_alloc_pages_slow() to __page_pool_alloc_netmems_slow()
Date: Thu, 29 May 2025 12:10:39 +0900
Message-Id: <20250529031047.7587-11-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250529031047.7587-1-byungchul@sk.com>
References: <20250529031047.7587-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRbUhTYRiGe3fevec4PHVaZccWfSwqMJwpVg8UpkVw/hX1q6KPlYe2nFM2
	Mw2CZYY4cn1L2opJ5lfqZIlfyag13EIrWVhTa8rCiMgsZyNdVFvhv4v75rqfHw9Dyd14BaPV
	F4gGvVqnJDIsm4yvSd41uE2zecSzGqz2ZgIPfxZB/XiXFKxNHQhmZkdpCLk9BO7XhCmwvirF
	8MM+R8FEX5CGsbqPGHrLOikIXvESqCiNUFDS1SCBwQ6LFG7OPaCg0zROw+seK4FA8x8pfHRV
	YHhe3YhhzJIJfbYECPd/QeC2d0ogfPkugRs+G4EPpWMIfM+CGO5csCCwO/1SiPy0ksy1Qnvj
	sETorn5PCzbHGeFRQ5Jg9vsowdFUTgTH9HVaePemlwje2xEsdHeFJELFxa9E+D4xgoUp5xAR
	7O1DWBiwuWkh5Fi1jzsk25Et6rSFoiEl47hM439sxvndsiKnJUCZ0GfGjOIYnkvnXQM9aJ7L
	PoRJjAm3kff7Z6kYL+VS+VDQg81IxlDcVyk/YY1IYsUSTsdfrC+nY4y59fzwSElUYBiW28K3
	zrH/N1fzD9ue/NuJi8aVjyr/qfLorSrzUxLb5LnvNH/rt5v6LyTyTxv8+CpibWhBE5Jr9YW5
	aq0uXaUp1muLVCfzch0o+tu6878Od6HpwQMuxDFIGc960TaNXKouNBbnuhDPUMqlbMnOrRo5
	m60uPica8o4ZzuhEowspGKxczqaFz2bLuVPqAjFHFPNFw3wrYeJWmFBzzjfPoqP5jtcl2VWj
	f6ZO/Pa1Jm5qJJcyX7gD+9ecJ86Ol+vqZ2xsbX9ayzGxYGbZNU3tIivzKcOoCt5TyLpb31ZN
	H7lQ822lYvts1uI9qmbphpS2WvqgNy+H87ItAe/OfPPe3qzk2oXYyC08IZ00KTZO8pbIVPmT
	3XcSTv9QYqNGnZpEGYzqv04hbrnXAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRe0hTcRzF/e3e+9v10uK6xG5KRIsIDTXJ6RcMk4K6+EeIUEGUOfLihvPB
	pkMDaalkDl3Zw8pmLSTni1YqOmuIqegkM1HMab5QlIowdTbU9XJG/304h3POH4cmpBYykFZl
	ZAuaDIVahhmSORNTGHpiKFp5pMrjByZrI4aG9VywzNooMNW3Iljb+CQGV08fhupnbgJMH4pI
	+GHdJGChd04MMzWLJNiL2wiYu+XAUFbkIaDAViuC7qp+CoZajRTc23xOQJt+Vgwjr00Yphv/
	ULDYVUZCf2UdCTPGOOg1B4D73TcEPdY2EbhLqzDcHTZjmC+aQTDcPUfC4+tGBNYOJwWedROO
	k/EtdeMivr1ySsybm3L45toQ3uAcJvim+hLMN63eEfOTH+2Ydzz0kHy7zSXiywqXML+yMEHy
	3ztGMV/9eVnEW1tGSX7A3CNO8LvAHEsR1CqdoAmPTWaUzjcGMqudye0wThN69JU2IF+aYyO5
	4nk39jJmD3FO5wbhZX82gnPN9ZEGxNAEu0RxCyaPyGvsYtVcoaVE7GWSPciNTxRsBWhawsq5
	F5uSf537uIaXnds9vltyRXPFdlS6tfXI8BbfRowZ+dQjf1WGLl2hUsvDtGnKvAxVbtiVzPQm
	tHVfTf7PchtaGzndhVgayXZIHChaKaUUOm1eehfiaELmLyk4HqWUSlIUeVcFTeZlTY5a0Hah
	IJqU7ZbEnxeSpWyqIltIE4QsQfPfFdG+gXqUJOlVFOtvRp19Ffvb8bT2V8x4UlLwfmEkIaFb
	/v6wD7u8oOsMuuQvWM4tzqxCz7Xyo1NPcisHDpy6GKlayRdyJuNmQ+UJFSWDaX6Be+mY+ID7
	G8OltuDBkz57HCFf7C6uqjzVkIiZSHtcDVl744GGGhstjTWFW9fHElWDO+tkpFapiAghNFrF
	Xyxbm5K6AgAA
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
index 9eae57e47112..11d759302d19 100644
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


