Return-Path: <bpf+bounces-59061-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A16AC5F66
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 04:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 200BF7A70B6
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 02:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC07A1F3B91;
	Wed, 28 May 2025 02:29:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1921CAA92;
	Wed, 28 May 2025 02:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748399368; cv=none; b=PmIqNKn9rp8Kp7XMTfHSX+5kIePr1T8X0k9DUF49SuLfN+e4Mjs/FQfhSaFV/UeDZ12bBuhwwQFMQFIv8bZ+TY3WqrTvcmdLxtEn6ZCAuvBLdro6GdYLivsVe/YLc0PVfyrsa2a2Ho1bGr+PVY0zQDl6W/QnH/Vkoss8agL4Bw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748399368; c=relaxed/simple;
	bh=trIbGDIpbur5VH8OquO1UieH1E1JDFzjrbiAE1SK7N4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=jACLn5ljM7KPmAlWJ9qQqpDWljZA/h/QvqxYimIoI/g++Qh290qJ6vXX684PQn+ns9TkdK+CKkIr1b3qmTmjN1F8iq6VtPhMtjruKDIPTAdwemsy4O9Yg/UYqO02wDqL8ZTvzTpuUHMdVPNV6VrT62JsjzTDxAKuvQVVK//G0Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-5f-68367501fe5c
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
Subject: [PATCH v2 07/16] page_pool: use netmem put API in page_pool_return_netmem()
Date: Wed, 28 May 2025 11:29:02 +0900
Message-Id: <20250528022911.73453-8-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250528022911.73453-1-byungchul@sk.com>
References: <20250528022911.73453-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTcRyG++9cdpyOTkvqpJA1SEFQs3T8gjI/SPwJBCE/SBY19OBm3ti8
	l2A2EK+FBpVOmIV3abJEZ5mXeSfLu82ytMVmZCo6FW9QLvHbw/s+vF9ehpD0kG6MMiGZVyXI
	46S0iBQtuVT6CFJkivMz2zRo9Y00NGylQ828kQJtfQuC9e2vQrD3DtDwqnKTAO2IhoQN/Q4B
	1n6LEOaqbSS057YSYHk8SEORZpeAHGOtAEZbiil4ulNFQGv2vBAm3mpp+N74lwKbqYiEobI6
	EuaKg6FfdwI2P/xB0KtvFcBmYQUNpeM6Gn5q5hCM91hIKH9YjEDfYaZgd0tLB5/FzXUzAtxW
	9k2IdYYU/KbWG+ebxwlsqM+jsWGtRIhnp9tpPPh8l8RtRrsAFz1apvGq9QuJVzqmaKxvniLx
	sK5XiO2G02HsTdHlaD5Omcqr/ILuihQzeWuCpHmX9NnJl3Q2+ijKR04MxwZwg8Zi8pBLOn8J
	HUyzXpzZvE042JX15+yWgX1HxBDsMsVZtbsCR3GcDecWfzT/l0j2HFe3bqIcLGYDOWu3jToY
	9eAamrr2HYZxYmVc32yUI5bsKysFenSgbAg5zadbB3yK6641k0+QWIeO1COJMiE1Xq6MC/BV
	ZCQo032jEuMNaP/a6qy9SCNaG71hQiyDpC5i3BSokFDyVHVGvAlxDCF1FedclSkk4mh5Riav
	SryjSonj1SbkzpDSk+ILm2nREjZGnszf4/kkXnXYChgnt2xUI7/9PtMrK9sr1jO3T+oeHj24
	GEE41bTMF3RPh6aErGZ2V87eXKIjygc8g0pbzzwwlF33Wbt4v7DKw95ZqDmq6PU0hsh0kZJ3
	C2MZfY2TnkVDoX7OtqH6z5eWry08i6yQ9OSor1he5A5TE+m5tpHY32HOe3xXcNoYZdW9bj8W
	IyXVCrm/N6FSy/8BG6tWL9YCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRW0iTcRyG/e87Ohx9rVVfdREsJBTMglw/Msq7/kSniyCoIL/so03ntM1j
	FJhK0spDllA2a2Utp9FCbR4yrWmm2Uo8lKfUZhNhpeXMdAvKFd09vO/De/OyhPwBuZbV6FJE
	vU7QKmkpKd0fnROBUlXqza4SFZhsD2moWsiAB+P1FJgq7QjmFocZ8La9oqH8zjwBpne5JPyw
	+Qhwt7sYGLNMktCUV0eAq7CDhvxcPwHZ9RUSaC3rpKDbXkDBNd99AuqyxhnobTTRMPrwNwWT
	jnwSOkutJIwVxEC7eRXMd31B0Gark8D85TIarvaYaZjIHUPQ0+oi4eb5AgS25gEK/AsmOkaJ
	a62DEtxQ+pHB5upUXFMRjo0DPQSurrxI4+rZYgaPvG+iccd1P4kb6r0SnJ8zTePv7iESzzT3
	07h86psE22r7SfzG3MYcXH5EuuOkqNWkifrInbFS9eDFWUnyeEjGSN9dOgs5pUYUzPLcVr64
	ZYoJMM1t5AcGFokAK7gtvNf1ijQiKUtw0xTvNvklgWIFd4j3fKr9K5FcKG+dc1ABlnFRvPvF
	JPVvdD1f9fj5ksOywZyKfzkSF4jlS8rMJRsqQlIzCqpECo0uLVHQaKM2GRLUmTpNxqa4pMRq
	tHSf5dyvK/Vorne3A3EsUobI8OMotZwS0gyZiQ7Es4RSIcvepVLLZSeFzDOiPum4PlUrGhxo
	HUsqV8v2HBZj5dwpIUVMEMVkUf+/lbDBa7NQ8+uzXlPNqc+PyKD4Gylf7cpbH1Dkie7xC4xf
	7Yt/0pd31Fg0FVpkF5aFpTVe2vBEwCETulzdga23k8pGFZ596Vo6bPDIve29zrctlpFt1sLD
	T4eHVv70OPdaItaIpxfaS7rKvBHR05Xhx57JC5Sp8T/TpxmnxdPgq0rynLYnK0mDWtgSTugN
	wh/GeO2rugIAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Use netmem put API, put_netmem(), instead of put_page() in
page_pool_return_netmem().

While at it, delete #include <linux/mm.h> since the last put_page() in
page_pool.c has been just removed with this patch.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 net/core/page_pool.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 8d52363f37cc..fb487013ef00 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -20,7 +20,6 @@
 #include <linux/dma-direction.h>
 #include <linux/dma-mapping.h>
 #include <linux/page-flags.h>
-#include <linux/mm.h> /* for put_page() */
 #include <linux/poison.h>
 #include <linux/ethtool.h>
 #include <linux/netdevice.h>
@@ -712,7 +711,7 @@ static __always_inline void __page_pool_release_page_dma(struct page_pool *pool,
 /* Disconnects a page (from a page_pool).  API users can have a need
  * to disconnect a page (from a page_pool), to allow it to be used as
  * a regular page (that will eventually be returned to the normal
- * page-allocator via put_page).
+ * page-allocator via put_netmem() and then put_page()).
  */
 static void page_pool_return_netmem(struct page_pool *pool, netmem_ref netmem)
 {
@@ -733,7 +732,7 @@ static void page_pool_return_netmem(struct page_pool *pool, netmem_ref netmem)
 
 	if (put) {
 		page_pool_clear_pp_info(netmem);
-		put_page(netmem_to_page(netmem));
+		put_netmem(netmem);
 	}
 	/* An optimization would be to call __free_pages(page, pool->p.order)
 	 * knowing page is not part of page-cache (thus avoiding a
-- 
2.17.1


