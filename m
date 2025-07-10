Return-Path: <bpf+bounces-62893-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7E7AFFC41
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 10:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D30CE7B78F7
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 08:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1E028E59C;
	Thu, 10 Jul 2025 08:28:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D5F28C5CA;
	Thu, 10 Jul 2025 08:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752136110; cv=none; b=XE13lDmqKq7z3pZjFPwsARofn3k01gXZ2Gpuf9xAWeIh5LRLcku8IYqaal24aj1QzQMsjb5xhKkWGVvVRYBIgNU2YFknp5YZjDNxPXGuGAPFbHJoIMqIC4Si1D541zK7c9a9Xc+SZTBhncdCTAs3WcuOBUnkL+N7UteiDkohpBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752136110; c=relaxed/simple;
	bh=EEU0kq+HKSIbN2GeOshnu1C+3IJMA4iILRmIBGrc5h0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O4rEwr4cKFRcOhOOCdvfE99J29NPdcbJGpWi9nEGHTwCaYNty1ijs/rW3JcJjNoEBlgkhkfXfzZfgeXrgJyULSO/raSrxT7ueaNavlYFTC/Dp7kY7Mgszr6w9ga/+PH6iYpyg8FrvSEVdopQM+RCz1lb2yQiQbh0c4ZyBe2RCcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-d4-686f79a1b34e
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
Subject: [PATCH net-next v9 1/8] netmem: introduce struct netmem_desc mirroring struct page
Date: Thu, 10 Jul 2025 17:28:00 +0900
Message-Id: <20250710082807.27402-2-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250710082807.27402-1-byungchul@sk.com>
References: <20250710082807.27402-1-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG+e9/ds5xtDzO0pMixUosS0speSEr+xCciCCIKBLKlYe2mlM2
	NS0MbdpFm5UF1bSYhc7UmszbNAubywsVmWFNLS1L6UO5vC1vUTuI5LeH5/09z/PlpbHsljiA
	VmmSea1GoZaTEkLyc8n9sOL0ROWmqtEQKLJUklAxlQbmzzYxFJXXIZiY7qNg3NFGwoNiN4ai
	N9kETFpmMAy1DlJQYd0LA6XDBDRdrMcweLWdBEP2LIan0yMUnLeViaCzLl8MN2dKMNRnfqbg
	XWMRCf2Vf8UwbDcQ0GF8SMBAfgy0mvzA/fIHAoelXgTuK3dJuNFlIuFr9gCCrpZBAgqz8hFY
	njnFMDvl6Sh80U/FrOFafrgwV/OwR8Q1GD9RnMmawlWXhXK5zi7MWcsvk5x1rIDiPr5vIrn2
	27ME12AbF3EG/QjJjQ71EpzrWTfJWWq6Ce6VyUHt8zksiY7n1apUXrtxe5xEWTO1J8kRkfZH
	34oy0eWQXORFs8xmNudmFbGgH9WZkaBJJoR1OqexoJcxEez4YJuHkdCYeUSyjso+KhfRtC8T
	y85kRQsMwQSz9xrzRIKWMlvYuyNz1HznSraiqhkLuBcTxdq+nhVsmQeZ7c4l5nEftuPON0JA
	sGfWck8m2NiT1NcWYmGVZWw0W9lXIJ6vXME+L3MS1xBjXBQ3/o8bF8VNCJcjmUqTmqBQqTeH
	K9M1qrTw44kJVuR5l9KMuVgbGuvcb0cMjeRLpJ0nNEqZWJGqS0+wI5bG8mXSqUNqpUwar0g/
	w2sTj2pT1LzOjgJpQu4vjXSfjpcxJxTJ/CmeT+K1C1cR7RWQic75b5PpAkf9rkfv3uDqL/ke
	tavtaOy2B28zzKvWmPXJe5cnSy7sbL52hm9eHmc4eUwVlJkQfIGtrv4l/RK2y04GvU7rNUi+
	vVX5nnS5Xnnn0G9ijli3ri44WPtk8rv3EG0cfqxfnede23GkoSfy0nqlV8vS35fWfWisaDkQ
	F1SwI3ZCTuiUiohQrNUp/gHEhUXdKgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA03Se0hTcRQH8H773d17NxzdltXVCmlkhqQlqB0qwj+Cfj0pIXoY6MiLW84p
	W5oWlTmhWqmZgTU1VuJbWSydM0xMTV1SiY+wLBVfFYlWPvAVthGR/30553PO+eewWD5HebJq
	7QVBp1VqFLSUkh7dbfB7nBSr2vHb4AG5lnIaymYToWjALobcUhuCqbleBiabWmjIfzyDIfdd
	KgXTlnkMI82DDJRZj0B/4SgFtTeqMQxmtNKQlrqA4cXcOAMp9mIRNOY5xNBuSxfD/fkCDNXJ
	Awx0Ps+loa98SQyjDWkUOEwlFPSnh0CzeS3MtI0haLJUi2DmTh4NWR1mGoZS+xF0NA5SkHM9
	HYGlrkcMC7POHTmv+pgQb9I4NoFJZckHEakxfWaI2RpPnhX7EmNPBybW0ls0sf66x5BP72tp
	0vpggSI19kkRSTOM0+TnyEeKTNR10yT/6w8RsVR2U8fkZ6R7IgWNOkHQbd8bIVVVzh6KawpI
	/G1oRsnolo8RSVieC+QrbEXIlWnOh+/pmcOu7M4F8JODLZQRSVnMVdB8U3kvY0Qsu5oL4+ev
	73EZivPmHz2/LXJlGRfE540vMn93evFlT+uxi0u4YN4+dNlVljvJQreR+stX8Y6Hw5SLYOdZ
	yyO5q4ydk4aqHHwXyUzLlOm/Mi1TZoRLkbtamxCjVGuC/PXRqiStOtH/XGyMFTkfovDKYqYd
	TXXub0AcixRusvYorUouVibok2IaEM9ihbts9pRGJZdFKpMuCbrYcF28RtA3oPUspVgnO3hS
	iJBzUcoLQrQgxAm6f10RK/FMRqHfPJ5oV77c/BHvddTWmxwfviydrX92fGBjRkZmWvZQ4T5x
	aJhbFhnbJleuqLrGbk2VVJR2NV+VOG74/RqKe3s+smvis6dbZOauuoA+0ZqbQb4hthP2Rf/6
	SltK9kWviDZtwumtW4bDY17+LPz++g3e5Bcc2OWz4UBN7/Qhn8M77xQoKL1KGeCLdXrlHzc9
	ZF4MAwAA
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
index de1d95f04076..535cf17b9134 100644
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


