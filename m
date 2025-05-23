Return-Path: <bpf+bounces-58816-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 941C6AC1AAE
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 05:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AA47A24CDC
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 03:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47D5280314;
	Fri, 23 May 2025 03:26:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564A5270ECD;
	Fri, 23 May 2025 03:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747970793; cv=none; b=iD+FLpQM571sUjsbuLt4dQ7xyibSLWDtQ7SzkWGUD1cHqXyaMwLJaz/DkAzPPkFobPcrKnSIMX9WRbma/JrUqA7o4fVsRq188JX9hrgWav+hcgiVpkY3MbUba9xkcN2ky5IuFQz9mQCZfV7MOG9Uxxm2iF2O8pH3fUkvSvJlCxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747970793; c=relaxed/simple;
	bh=C9NK/m9W07yH0SH2bdXndsqdPgn7AEXo1UEv0+SzIRk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=VvgG4pNM25llbw5yVSZhnOY6x1KE/+yoHANxUJQIpwXpFJAcNqWqtd7mUBrCMwa5Zcyeymfhg6g0pXL+PEa4nLLneTvybn8LPhdYH/KPYVvvUWysKgWarEjWwsSpjQmUpClL5OJ3RdD1yqlOGHVriU/CIVphL6rNidw52GxU5OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-23-682feadd3b6c
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
Subject: [PATCH 18/18] mm, netmem: remove the page pool members in struct page
Date: Fri, 23 May 2025 12:26:09 +0900
Message-Id: <20250523032609.16334-19-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250523032609.16334-1-byungchul@sk.com>
References: <20250523032609.16334-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRSUwTYRiG/TvTmaGhZqwII4poFTUQ2YLmI0HDwcN/MgY1cTlII6OtlMWW
	PUGrEo0NICphsyQlRqylsVoRWkSUAgWiEWSzgiyp0oMiO0TBuBTl9uR9v++5vAwhaSH9GUVy
	Gq9KlimllIgUffOu2jP8JUwePjS1FnRmEwU137PgwZhVCDpjHYL5H0M0zLW2U3CvapEAXVce
	CQvmJQLGHS4aRqvdJDReryfAdbODgoK8ZQKuWA0C6K4rFELx0n0C6jVjNPQ26CgYMf0Wgtte
	QEJnxUMSRgtjwaH3hcXXEwhazfUCWMyvpOBOj56CT3mjCHpaXCTcvVyIwNzkFMLydx0Vuw3X
	PvwgwLaKYRrrLen4qSEYa509BLYYb1DYMnubxh8HGincUbZMYpt1ToALrk5SeGZ8kMRTTf0U
	Ntf2k/iNvpXGc5Yth9mTopgEXqnI4FVhB+JF8icFTkFqi1+Wu3eTBpkkWuTFcGwUZ8jToVVe
	yHcLPEyxuzin8wfhYR82gptztZNaJGIIdlLIjeuWV47Ws4e46SYTpUUMQ7JBXHVJuCcWs/u4
	WeNL+p8zkKt5/GrF4/U3LxpZoDwsYfdyz/sGaY+TY2dorsw2/f9hI9dscJJFSKxHa4xIokjO
	SJIplFGh8uxkRVbomZQkC/o7bXXuz1NWNNt9xI5YBkm9xVZRmFwilGWos5PsiGMIqY+4zR0q
	l4gTZNk5vCrltCpdyavtaBNDSv3EkYuZCRL2nCyNT+T5VF612goYL38N0lwovdYZEq1t25h2
	LeAXE1DRPDGwFGfIdMTF75gpdzsvK83RBsdAnz3361Hl1YmS4Usvdh576zCdjel1nX8X1et7
	8ESIfWypPLNh9y2N99bIIHyxNOlRunRzgxonBt6vGf0cn98jLw5UXOlc98x//3zw9uNcii2n
	yth1tHJD1XuHlFTLZRHBhEot+wN92pOl1gIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTcRyG++9cN1qcTqsORgQr07ScWsYPCjWK/CNk9akIQpcd2vLKZuK6
	YSqUw5mWWdqMydByCsspzpWsmNcuULiU5W1hOaLCLl5ILSyNvj0878v75WUJvo4MYrWZOaIu
	U52upGWkLGlP4Y7RTypNZOM2MNubaGj8mQf337VTYLa1IZieG2ZgqquXBmvtLAHmV0UkzNjn
	CZjoGWfAXx8goeOqk4Dx6300mIoWCChofyCBzppnFLxuK6WgYr6OAGf+Owa8j8w0jDUtUhDw
	mEh4Vt1Agr80Hnos62D2xRcEXXanBGZLami42W+h4X2RH0F/5zgJd6+UIrC7fRQs/DTT8Urc
	2vBWgl3Vowy2OM7hlgdh2OjrJ7DDVkxjx48bDB4Z7KBx350FErvapyTYVDhJ4+8TQyT+6h6g
	sfXjNwm2tw6Q+KWlizmy+oRs72kxXZsr6lSxKTJNs8knye5cnxfwbshHTbwRSVmB2yXMlAQk
	S0xzIYLPN0cssYKLEqbGe0kjkrEEN0kJE+aF5dIaLkn45m6ijYhlSS5YqK+MXNJybrfww/aE
	+be5SWh8+HR5R/rXl43N0EvMczHC4zdDTBmSWdAKG1JoM3Mz1Nr0mAh9msaQqc2LSM3KcKC/
	59Vf+lXejqa9CR7EsUi5Uh6aodLwlDpXb8jwIIEllAp5dyBCw8tPqw3nRV1Wsu5cuqj3oA0s
	qVwvTzwmpvDcGXWOmCaK2aLufyphpUH5KPxQVrC+fOcYexL2Sb3QJjv4QRXOHNmzlRqJWVXm
	n3e4EpJdk9zmlo2VxYmtistZWt5YeNscFBeqOOCMqzjbmFZ/in9e4L949Gl3cfQ1qyEvovDW
	cPm8dvA3dTgndfuF2JfWugq8GF12vrlKuj/ctMVQ1R1w13523jvOz6wNUZJ6jToqjNDp1X8A
	10tm/bgCAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Now that all the users of the page pool members in struct page have been
gone, the members can be removed from struct page.

However, since struct netmem_desc might still use the space in struct
page, the size of struct netmem_desc should be checked, until struct
netmem_desc has its own instance from slab, to avoid conficting with
other members within struct page.

Remove the page pool members in struct page and add a static checker for
the size.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/mm_types.h | 11 -----------
 include/net/netmem.h     | 28 +++++-----------------------
 2 files changed, 5 insertions(+), 34 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 873e820e1521..5a7864eb9d76 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -119,17 +119,6 @@ struct page {
 			 */
 			unsigned long private;
 		};
-		struct {	/* page_pool used by netstack */
-			unsigned long _pp_mapping_pad;
-			/**
-			 * @pp_magic: magic value to avoid recycling non
-			 * page_pool allocated pages.
-			 */
-			unsigned long pp_magic;
-			struct page_pool *pp;
-			unsigned long dma_addr;
-			atomic_long_t pp_ref_count;
-		};
 		struct {	/* Tail pages of compound page */
 			unsigned long compound_head;	/* Bit zero is set */
 		};
diff --git a/include/net/netmem.h b/include/net/netmem.h
index c63a7e20f5f3..257c22398d7a 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -77,30 +77,12 @@ struct net_iov_area {
 	unsigned long base_virtual;
 };
 
-/* These fields in struct page are used by the page_pool and net stack:
- *
- *        struct {
- *                unsigned long _pp_mapping_pad;
- *                unsigned long pp_magic;
- *                struct page_pool *pp;
- *                unsigned long dma_addr;
- *                atomic_long_t pp_ref_count;
- *        };
- *
- * We mirror the page_pool fields here so the page_pool can access these fields
- * without worrying whether the underlying fields belong to a page or net_iov.
- *
- * The non-net stack fields of struct page are private to the mm stack and must
- * never be mirrored to net_iov.
+/* XXX: The page pool fields in struct page have been removed but they
+ * might still use the space in struct page.  Thus, the size of struct
+ * netmem_desc should be under control until struct netmem_desc has its
+ * own instance from slab.
  */
-#define NET_IOV_ASSERT_OFFSET(pg, iov)             \
-	static_assert(offsetof(struct page, pg) == \
-		      offsetof(struct net_iov, iov))
-NET_IOV_ASSERT_OFFSET(pp_magic, pp_magic);
-NET_IOV_ASSERT_OFFSET(pp, pp);
-NET_IOV_ASSERT_OFFSET(dma_addr, dma_addr);
-NET_IOV_ASSERT_OFFSET(pp_ref_count, pp_ref_count);
-#undef NET_IOV_ASSERT_OFFSET
+static_assert(sizeof(struct netmem_desc) <= offsetof(struct page, _refcount));
 
 static inline struct net_iov_area *net_iov_owner(const struct net_iov *niov)
 {
-- 
2.17.1


