Return-Path: <bpf+bounces-61486-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C709AE75E9
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 06:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F64217B248
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 04:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859131E5B6D;
	Wed, 25 Jun 2025 04:34:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53ADA5103F;
	Wed, 25 Jun 2025 04:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750826047; cv=none; b=D5Jf0gOGln9jv9Jx6bggq1Q286LnfyiX2wbwna7XbS+B5Dc+oE1zjqcuBmt9Wc65/R4Tl75cYmsh2VFqnf2bn8gmKZan0Xz0ZXBp5Yig8h9t0PGwxeh7/h1MbU1ich4CvcK9m3x7/4lDcDt7wkfDH6tMKNzbFZuRyJcxEykcQ3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750826047; c=relaxed/simple;
	bh=oDe+SSFHvXIl1O54swE3pjcihxN0aMJyQy+oKtgdrLY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a5vPWsU210BAnzqOqnNHshzoK2SMFsogD7qPKbj/6rhIwgOqfp5P2f0A6qNN6abdUiQ9DInArzZkvdac9uRhZ7MUeIxmW30SIeA1JDsExVQGBiiqSVqf4Fl5BJYkUusERjjUJ8KQgFV0Gc4strjrFrcjnbWqwEvx/vkv39b/Ps8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-ea-685b7c38b74e
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
Subject: [PATCH net-next v7 1/7] netmem: introduce struct netmem_desc mirroring struct page
Date: Wed, 25 Jun 2025 13:33:44 +0900
Message-Id: <20250625043350.7939-2-byungchul@sk.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA02SXUhTcRjG+e9/ds5xODguq396EQ3FDDItrTfow7o6N4HoTSh9rDy0kc6x
	lR9R4SehpUZFH3PWLHM6rcUynflBzaWJkaEkKytrqQWZltbSltWZInX38LzP73luXhYrrkhD
	WI32iKDXqtKUtIySfQ6sWgvHU9TRHdUAJlsDDfUz2WB565CCydqE4NvsEAPTrm4ablR5MZj6
	Cin4bvuJYbTLw0C9fRcM14xR0HaqGYOn/DENpYU+DO2zEwzkO2ol8KypTAoXft7E0Jz7loGB
	+yYa3jT8kcKYs5SCHmMdBcNl8dBlXgbe3nEELluzBLxnKmk432+m4X3hMIL+Tg8FFXllCGwd
	bin4ZsSOikdvmPgwvnN8EvONdS8kfIvxNcOb7Uf5u7Vr+BJ3P+bt1mKat0+dY/hXg200//iy
	j+JbHNMSvrRggua/jr6k+MmO5zRva3xO8U/MLiYhKFm2JVVI02QK+nXb9svUT8rTda6Y7LnB
	VpyLiiNKUABLuFjiPG+RLGrTrUHKr2kugrjds9ivg7kYMu3pFn0Zi7lbNHE1DDH+wxIuhfSW
	586HKC6ctFouzcNysWikx4MXSleS+jsP5nUAF0dMnoL5jELMFA3m4YV8EOm5MiL6rDgQQWxX
	FX4bi2jBvQrs3yVcI0u++OxooXMFeVjrps4izvgfbvyHG//DzQhbkUKjzUxXadJio9Q5Wk12
	1MGMdDsSH6bmxK8UB5p6luREHIuUgfLoomS1QqrKNOSkOxFhsTJYfnGTaMlTVTnHBH3GPv3R
	NMHgRKEspVwuX+/NSlVwh1RHhMOCoBP0i1cJGxCSiwwZNbol10d/nNzxZ0C3N7r66WZNZO2e
	00nTkGc3B+++Frz2Q+Rq+s57k67dGpfQeWGmMpw2fuxo26kbEVb+/n1gW+VWm8+rTV06t32D
	d8ziYKD6dsnG08dUoQ3xVtfoqsQUS0JYorL9LF7xqZcUR7npvvzOdwM7ug6Qb9o+Z5aSMqhV
	MWuw3qD6C7iCTBUsAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG+e9/ds5xNDgtyYMFwUBWYuoq6aUiKqROQRH0IaoPttqpjeaF
	rUy7gDajNHXdsJpTlMrr1mLe76VTW0aK4lgtL63UCLFSMy+VHZWobw/P83ue98tLY9kcEUhr
	Y87y+hiVTk5KCMmBrcb1cOmYJvxd5Tqw2K0klE4nQOFgtRgsJZUIJme8FEw420l4mD+FwdKZ
	QsB3+yyGoTYfBaWO/TBQMExA/bUqDD7TCxIyUuYwNMyMUXClukgELTkuMXRVZorh7uxjDFVJ
	gxT01FpI6LfOi2G4OYMAl7mYgIHMHdCWtxKmOkYROO1VIphKzyHhTnceCR9SBhB0t/gIyE7O
	RGBv9IhhblrYyG7tp3YEcS2jXzBXXvxGxNWY+yguz3GOKysK5tI83ZhzlKSSnGP8NsW9c9eT
	3Iv7cwRXUz0h4jKMYyT3begtwX1p7CW5h5++ijh7eS9xUHZUsk3N67TxvD5s+3GJ5pUpOs6p
	TPjlrsNJKFWRhvxoltnEWmxuYkGTjIL1eGbwgvZnlOyEr13wJTRmbCTrtHqphWAFc4ztMCUt
	QgQTxNYV3lssS4Whjy4fXhpdw5Y+fbao/ZgI1uIzLjIygbnqTsZL/HLW9eCj4NPCAQVrz5Ut
	2FioGiuy8U0kNf9Hmf9R5v+oPIRLkL82Jj5apdVFhBrOaBJjtAmhJ2OjHUh4iYLLP29Vo8me
	Pc2IoZF8mTT86lGNTKyKNyRGNyOWxnJ/adZmwZKqVYkXeH1slP6cjjc0o1U0IQ+Q7jvMH5cx
	p1Vn+TM8H8fr/6Yi2i8wCfUd6tnZ/7op4/5v/5X5a1+rtx3eaHWPiHeHzNzMSbRljuX/oC6G
	BT7fb1jRdGP0VMBmxXxZ76NrtQf1rq700PEty++1bslVR6m9R8ZeNmzIum77/KQ1Mr035H3h
	yPnI7NWyzuQf8YeUHu+J1izC3deC4vZWrHoZ3OcpNJt2OU26olw5YdColMFYb1D9ARDk7m0O
	AwAA
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
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Harry Yoo <harry.yoo@oracle.com>
---
 include/net/netmem.h | 116 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 95 insertions(+), 21 deletions(-)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index 7a1dafa3f080..e9eee8f680d5 100644
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
@@ -30,13 +74,48 @@ enum net_iov_type {
 	NET_IOV_MAX = ULONG_MAX
 };
 
+/* A memory descriptor representing abstract networking I/O vectors,
+ * generally for non-pages memory that doesn't have its corresponding
+ * struct page and needs to be explicitly allocated through slab.
+ *
+ * net_iovs are allocated and used by networking code, and the size of
+ * the chunk is PAGE_SIZE.
+ *
+ * This memory can be any form of non-struct paged memory.  Examples
+ * include imported dmabuf memory and imported io_uring memory.  See
+ * net_iov_type for all the supported types.
+ *
+ * @pp_magic:	pp field, similar to the one in struct page/struct
+ *		netmem_desc.
+ * @pp:		the pp this net_iov belongs to, if any.
+ * @dma_addr:	the dma addrs of the net_iov. Needed for the network
+ *		card to send/receive this net_iov.
+ * @pp_ref_count: the pp ref count of this net_iov, exactly the same
+ *		usage as struct page/struct netmem_desc.
+ * @owner:	the net_iov_area this net_iov belongs to, if any.
+ * @type:	the type of the memory.  Different types of net_iovs are
+ *		supported.
+ */
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
@@ -48,27 +127,22 @@ struct net_iov_area {
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


