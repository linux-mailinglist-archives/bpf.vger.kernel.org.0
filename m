Return-Path: <bpf+bounces-60029-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8EDAD17E8
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 06:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D686166348
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 04:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CC8280337;
	Mon,  9 Jun 2025 04:32:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33A1254AFE;
	Mon,  9 Jun 2025 04:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749443561; cv=none; b=TZ4vjBly/EZ/7yrLhAwopt+5Zv/h7k0cASXpWrxn1oW4czoECzdemrzPRzTcF5YSz+MJutyDcYLh2khJ6oIBc0PKFNV5mR5FygfFKElJF2bjeQ3iH3bBxRs9a9Uxgnpeqy5YN6gJLqw99n0MtM26/QV7CPOwf7ZEn6I1cLMCvdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749443561; c=relaxed/simple;
	bh=Zt/S6ugF6kr0AYEDS86dlCmErkruE8ak6bfdZXRzvsg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lCSQ1IOPVFGVldZxIcRCZOQlK+seOFjW+Zge1QnJfWo6qDMZMXr98/lVPafvRGR1WUd/hNm0rRVlYRfXMlvCNV81QLsbaj9iK0a/XCU3u8EDvYxtW4zxG/NiOuD+Iz/xbLavlcmuUz/SZ9R2uLPLQPA1lf4XZXrmPEheifiWNHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-4e-684663e399ec
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
Subject: [PATCH net-next 1/9] netmem: introduce struct netmem_desc mirroring struct page
Date: Mon,  9 Jun 2025 13:32:17 +0900
Message-Id: <20250609043225.77229-2-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250609043225.77229-1-byungchul@sk.com>
References: <20250609043225.77229-1-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG++9/dnY2HJyW1cmicBSGpWVpvZSIlMbBPmT0Jayooce22lQ2
	L7MovIWoeam0cpsxs3JearG8lkgu0UmFZlnLsslMP1RauRIvA9uKqG8Pz/v8nufLS2FJAd+P
	UiSlcuokmVJKigjRpM/NoLH4ffKtl+aCwWBuJKFhVgu1o218MNS3IPgx904Aru5eEmqqZzAY
	+vMI+GmexzDe4xSA484EAR35rRicpTYSivMWMOS0mXgw0FLCh/L52xhas0YF8PKhgYQPjYt8
	mLAWE9CnqyPAURIJPcYVMPP0C4JucysPZi5WkXBl0EjCWJ4DweATJwH67BIE5k47HxZmDWSk
	P9tU95bHtutGBKzRksY+MAWyhfZBzFrqC0jWMn1ZwL5/3UGytusLBNve5uKxxblTJPt9fJhg
	v3YOkay5aYhgnxm7BazLsjaWjhOFJ3BKRTqn3hJxQiR/PjGEU7o2akd/3MVZaHJdIRJSDB3K
	fCrqJ//qIfdlwqtJOoCx2+ewV/vSIYzL2evxRRSmp/jMuGGB5z0sow8z+WWPf4cIegPjLr2H
	ChFFiekwptaN/nSuYxrueyMUJaR3MKP2VK8t8SSsr0y/STG9lOmr/Eh4I9gza74h8drYQ+Y2
	67F3laHrKOZCjgP/qVzFdJnsRBmidf/hun+47j/ciHA9kiiS0lUyhTI0WJ6ZpNAGxyerLMjz
	IHfOuY+0oemBQ1ZEU0jqIz5xLVou4cvSNZkqK2IoLPUV0469cok4QZZ5hlMnH1enKTmNFa2m
	COlK8baZjAQJfVKWyp3muBRO/ffKo4R+WWjr7okBZlejuzekv0GTmHfsUoeraHPodMWStPCY
	qDVnl2v1Qr1/9C1hclDV4KK4vDaDl7jpniompIyWrVdENT8L6EsUl576tlidoor7/MZJZUcU
	1+yJtOl9lp+Pn4wV7TxQpFPbBH6Pws7XF+w/XHlybLZi2ObuPGrgRqIOvth+VUpo5LKQQKzW
	yH4Bi6JqIhwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG+e9/dnZcrk7L7GCUNEjDsrKyXihEiuoQFSXd6OrQQxs6tU2H
	GpU1SRp5ya7OGQvJppaTZTrFLs7hJbvOFssyzRuWZhfNvJFtReS3h+f5Pe/75aGwuJ/woeQx
	8ZwyRhotIYWEcPtaTWBnxCbZ8l8P54PedJuE4pFEuNVu4YO+qBzB0OhbAQza6knIvzGMQf88
	lYAfpjEM3XUdAmgr6CGgOq0CQ0dmAwnpqeMYzliMPKjNa+TDi/IMPlwau4mhIqVdAM1VehLe
	357kQ481nYBGXSEBbRmhUGfwhuGmfgQ2UwUPhs/nkXDRbiChM7UNgb22g4Dc0xkITA+cfBgf
	0ZOhEras8A2PrdS1CliDOYG9awxgtU47Zs1F50jW/D1bwL57XU2yDdfGCbbSMshj0zUDJPut
	u4VgvzxwkGx+71ceaypzEOwTg02wY+Z+4bpILlqu5pTLQsKFsqc9DhxXsyixfegOTkGffbXI
	g2LoVYxjIptwa5L2Z5zOUezWXnQQM9hR7/KFFKYH+Ey3fpznDmbR+5i0rEd/IIJeyExkliAt
	oigRHczcmkB/b/oyxaVuhKI86NVMuzPebYtdhPWV8U9TRM9kGnO6CDeCXW9N18VuG7uamnu5
	OAuJdFMo3X9KN4UyIFyEvOQxaoVUHh28VBUlS4qRJy6NiFWYkWsDBScmLljQUPNmK6IpJPEU
	hV/dKBPzpWpVksKKGApLvER02waZWBQpTUrmlLFHlAnRnMqK5lKEZI5oy14uXEwflcZzURwX
	xyn/pTzKwycF7XEcP3C52xioNCpm+P3MyWy9773tRPG3Bdow/my/3f4Hi5tChIEeXVd5e8I+
	Te+cNdl77Mr7FVXzz9q7TiYXPHo5zX5I05ez0kbEflQ8DlKXlhRiea0nrV2fnFZ9elTj32Je
	3PruK93nk7dr3taumtGdISGn+g6vsUymjXyoWpJheSYhVDJpUABWqqS/AXFNIgf/AgAA
X-CFilter-Loop: Reflected

To simplify struct page, the page pool members of struct page should be
moved to other, allowing these members to be removed from struct page.

Introduce a network memory descriptor to store the members, struct
netmem_desc, and make it union'ed with the existing fields in struct
net_iov, allowing to organize the fields of struct net_iov.

Signed-off-by: Byungchul Park <byungchul@sk.com>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
---
 include/net/netmem.h | 94 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 73 insertions(+), 21 deletions(-)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index 386164fb9c18..2687c8051ca5 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -12,6 +12,50 @@
 #include <linux/mm.h>
 #include <net/net_debug.h>
 
+/* These fields in struct page are used by the page_pool and net stack:
+ *
+ *        struct {
+ *                unsigned long pp_magic;
+ *                struct page_pool *pp;
+ *                unsigned long _pp_mapping_pad;
+ *                unsigned long dma_addr;
+ *                atomic_long_t pp_ref_count;
+ *        };
+ *
+ * We mirror the page_pool fields here so the page_pool can access these
+ * fields without worrying whether the underlying fields belong to a
+ * page or netmem_desc.
+ *
+ * CAUTION: Do not update the fields in netmem_desc without also
+ * updating the anonymous aliasing union in struct net_iov.
+ */
+struct netmem_desc {
+	unsigned long _flags;
+	unsigned long pp_magic;
+	struct page_pool *pp;
+	unsigned long _pp_mapping_pad;
+	unsigned long dma_addr;
+	atomic_long_t pp_ref_count;
+};
+
+#define NETMEM_DESC_ASSERT_OFFSET(pg, desc)        \
+	static_assert(offsetof(struct page, pg) == \
+		      offsetof(struct netmem_desc, desc))
+NETMEM_DESC_ASSERT_OFFSET(flags, _flags);
+NETMEM_DESC_ASSERT_OFFSET(pp_magic, pp_magic);
+NETMEM_DESC_ASSERT_OFFSET(pp, pp);
+NETMEM_DESC_ASSERT_OFFSET(_pp_mapping_pad, _pp_mapping_pad);
+NETMEM_DESC_ASSERT_OFFSET(dma_addr, dma_addr);
+NETMEM_DESC_ASSERT_OFFSET(pp_ref_count, pp_ref_count);
+#undef NETMEM_DESC_ASSERT_OFFSET
+
+/*
+ * Since struct netmem_desc uses the space in struct page, the size
+ * should be checked, until struct netmem_desc has its own instance from
+ * slab, to avoid conflicting with other members within struct page.
+ */
+static_assert(sizeof(struct netmem_desc) <= offsetof(struct page, _refcount));
+
 /* net_iov */
 
 DECLARE_STATIC_KEY_FALSE(page_pool_mem_providers);
@@ -31,12 +75,25 @@ enum net_iov_type {
 };
 
 struct net_iov {
-	enum net_iov_type type;
-	unsigned long pp_magic;
-	struct page_pool *pp;
+	union {
+		struct netmem_desc desc;
+
+		/* XXX: The following part should be removed once all
+		 * the references to them are converted so as to be
+		 * accessed via netmem_desc e.g. niov->desc.pp instead
+		 * of niov->pp.
+		 */
+		struct {
+			unsigned long _flags;
+			unsigned long pp_magic;
+			struct page_pool *pp;
+			unsigned long _pp_mapping_pad;
+			unsigned long dma_addr;
+			atomic_long_t pp_ref_count;
+		};
+	};
 	struct net_iov_area *owner;
-	unsigned long dma_addr;
-	atomic_long_t pp_ref_count;
+	enum net_iov_type type;
 };
 
 struct net_iov_area {
@@ -48,27 +105,22 @@ struct net_iov_area {
 	unsigned long base_virtual;
 };
 
-/* These fields in struct page are used by the page_pool and net stack:
+/* net_iov is union'ed with struct netmem_desc mirroring struct page, so
+ * the page_pool can access these fields without worrying whether the
+ * underlying fields are accessed via netmem_desc or directly via
+ * net_iov, until all the references to them are converted so as to be
+ * accessed via netmem_desc e.g. niov->desc.pp instead of niov->pp.
  *
- *        struct {
- *                unsigned long pp_magic;
- *                struct page_pool *pp;
- *                unsigned long _pp_mapping_pad;
- *                unsigned long dma_addr;
- *                atomic_long_t pp_ref_count;
- *        };
- *
- * We mirror the page_pool fields here so the page_pool can access these fields
- * without worrying whether the underlying fields belong to a page or net_iov.
- *
- * The non-net stack fields of struct page are private to the mm stack and must
- * never be mirrored to net_iov.
+ * The non-net stack fields of struct page are private to the mm stack
+ * and must never be mirrored to net_iov.
  */
-#define NET_IOV_ASSERT_OFFSET(pg, iov)             \
-	static_assert(offsetof(struct page, pg) == \
+#define NET_IOV_ASSERT_OFFSET(desc, iov)                    \
+	static_assert(offsetof(struct netmem_desc, desc) == \
 		      offsetof(struct net_iov, iov))
+NET_IOV_ASSERT_OFFSET(_flags, _flags);
 NET_IOV_ASSERT_OFFSET(pp_magic, pp_magic);
 NET_IOV_ASSERT_OFFSET(pp, pp);
+NET_IOV_ASSERT_OFFSET(_pp_mapping_pad, _pp_mapping_pad);
 NET_IOV_ASSERT_OFFSET(dma_addr, dma_addr);
 NET_IOV_ASSERT_OFFSET(pp_ref_count, pp_ref_count);
 #undef NET_IOV_ASSERT_OFFSET
-- 
2.17.1


