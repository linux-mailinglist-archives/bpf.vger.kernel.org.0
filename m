Return-Path: <bpf+bounces-59617-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 115EFACD5EB
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 04:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A88BD3A1676
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 02:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2C3235C17;
	Wed,  4 Jun 2025 02:53:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43657214801;
	Wed,  4 Jun 2025 02:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749005591; cv=none; b=pHxzUmygkoG3SUUNMlhEoP8fJvtAXrakfSUPkHfGnEFN/hS/AC6s0rx+wbw90zZOc1HB62Cg73lSfPqQJD1OL/Hb3AZOOK3zT2UZH8t93gtMHyZzoEHBAFoxdT0UkDJRIKoBIWr15pvhqxZR0J395z7mxDE+3cPM9J4UW034l5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749005591; c=relaxed/simple;
	bh=F5ve9D20MBPulBeEal1AW31+4WWtMmfgj0/WGJxTWEU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=bhjX9KaqZYcHv7ENhqXioCV3RT2ohoRMAWu/WCuDkGMgTDZ2Rjt/nCTWZWOuyvTjicQBllC73T4P6BnqCdctUeoLgwbEtgkxRUoP4HXeDyYLPjUPWDX9eHiZeV6pEc5qs5n4GvAvO0RoEBQAjKeMvxZKyfJjHRG67wgQ4bnivyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-c4-683fb509066e
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
Subject: [RFC v4 01/18] netmem: introduce struct netmem_desc mirroring struct page
Date: Wed,  4 Jun 2025 11:52:29 +0900
Message-Id: <20250604025246.61616-2-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250604025246.61616-1-byungchul@sk.com>
References: <20250604025246.61616-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRbUhTYRiGe3fenXMcDg7L8mSltIzKPhWL50dYEOELBVmBPwrKQx7acM65
	mWkQrTKq0TQsqNaMSaVTq9VaukrMljVLo/nZzJmy0l+pmPm5oJzVv4vnvu/rz8NSiiYcw6q1
	eaJeK2iUtAzLhiPLN0Q83a7aPGGOA6vjPg010wVQOeCWgrW6FsHPmV4Gxpu8NNwpn6TA+rEI
	w4RjloLBt0EG+iuGMNRfqKMgWNJMg7koRMFZt10CvtpiKVybvUdBnXGAgY7nVhq+3P8thSGP
	GcM7SxWG/uId8Na2GCZbviNoctRJYPJyGQ1X2200fC3qR9D+Oojh1pliBI4GvxRC01Z6xwri
	quqRkGeWPobYnMfJE3sCMfnbKeKsvkQT549ShgS662nSfCOEyTP3uISYz43QZGzwMyajDV00
	cbi6MGm1NTFk3Bmbxh2UbcsUNep8Ub8pJUOmav0WpHS3VxdUTmUZUU+sCUWwPJfM1ztb0H92
	NY5RYaa51bzfPzPPUVwiPx70YhOSsRQ3IuUHrSFJOFjI7ectJV10mDG3ig94K6VhlnNb+IoZ
	H/NXGsfXPGqcF0VwW/nAyPX5rWKuY3Z3UmEpzw0zfMmTqX+DJfwrux9fQXIbWlCNFGptfrag
	1iRvVBVq1QUbj+ZkO9HcbytO/TrkRj98BzyIY5EyUu4OpKgUUiHfUJjtQTxLKaPkcWvnTvJM
	ofCkqM85oj+uEQ0etJTFymh50uSJTAV3TMgTs0RRJ+r/pxI2IsaI7J983c3dOqbMsD01K/qS
	qWxWiL9rvBm41mnxfUhf4Tqre/zRm/Kid0Fj607rosjR1OXv15fsikuzF+9+tfJX0cTpNoIb
	jlr2PXwzuiZ+VW5OufEh855dP/Z4Q2dGVJvMrksLnb/IdiTsWbzuZenOllyffs1EEjH1PVjW
	vDf98EuXEhtUQmICpTcIfwAN90Fz1wIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTYRzGfXcuO45mxyV1ssgaiCVlGRl/KtJvvgVJRBgolStPbjinbHO5
	wrBcmJpaGRg6a2V5j8W8zRAzFadpJV7S1UyZl6TCvF+DUqNvP57bl4chJEWkJ6NQaXm1SqaU
	0iJSFHI0eZ9rVaD8wPNnbmA0l9NQtpgARUNWCoyl1Qhml74IYabZRkPB03kCjB8NJMyZlwkY
	bXEKYbBwjIS6lBoCnFmtNGQYVgi4ZS0WQFN+GwWd1ZkUPFx+QUBN0pAQul8bafha/oeCscYM
	EtpyS0gYzAyCFtNmmG//iaDZXCOA+bv5NGR3mWgYNgwi6GpykpB3MxOBub6fgpVFIx0kxZUl
	dgGuzR0QYpMlHlcU++K0/i4CW0pTaWyZfiDEjk91NG59tELiWuuMAGckT9B4avQziX/V99K4
	YHxSgM2VvSTuMDULT7uHiY5F8kqFjlfvPx4hkneMOIm4xz4JRQvRSci+Iw25Mhx7iKtsmCLW
	mGZ9uP7+pXX2YP25GaeNTEMihmAnKG7UuCJYMzaxZ7jcrF56jUnWm3PYiqg1FrMBXOFSp/Df
	qBdX9qphfciVPcw5JnLWu5LVTIa1h7iHRCbkUoo8FCpdjEyhDPDTRMv1KkWC3+XYGAtava8w
	8fd9K5rtDm5ELIOkG8RWx3G5hJLpNPqYRsQxhNRD7LVnVRJHyvTXeHXsRXW8ktc0om0MKd0i
	PnmOj5CwUTItH83zcbz6vytgXD2TUPD4xujhvvq5lllrWrvuwru3bh8SQ5Ky0oMNC0N7t2Yz
	trCAnlB/7fcJe17fDffw3SlKPaROe1+i3CPwQujA1bhTL+3Ns8qqN/K6nYxluWoSvtG7wm0n
	JtmDVxwN6YHbczxV6KyWeH++5Mh1l0K7yx2DTnv7yY+8qBGXmilxhZTUyGX+voRaI/sLXeRT
	RboCAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

To simplify struct page, the page pool members of struct page should be
moved to other, allowing these members to be removed from struct page.

Introduce a network memory descriptor to store the members, struct
netmem_desc, and make it union'ed with the existing fields in struct
net_iov, allowing to organize the fields of struct net_iov.

Signed-off-by: Byungchul Park <byungchul@sk.com>
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


