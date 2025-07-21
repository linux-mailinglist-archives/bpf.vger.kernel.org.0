Return-Path: <bpf+bounces-63867-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB19DB0BA79
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 04:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19351178BE4
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 02:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B92213E74;
	Mon, 21 Jul 2025 02:18:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBB01F791C;
	Mon, 21 Jul 2025 02:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753064333; cv=none; b=TNxwr762N33ORVOAhm17tiQZFSk8flqMcP2hdB25so79tL9qmBd2xAgdSPo9tIGyecO8hH1sxg3hJImShirY5PgL/wTuJBI+CSv/fkpEOjrwiC+wsJeORqqunDUHzP9Oprwhacd4ywRKDXPIYAIHun6htsXnaIoviv2SXgCbhyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753064333; c=relaxed/simple;
	bh=EEU0kq+HKSIbN2GeOshnu1C+3IJMA4iILRmIBGrc5h0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p28NY4oQoag8WXkR0bfixeZTUlbv0ff24Rr7U8WALjyoyZd6h5z0DoASuvzFVddRYK8qndiX4upvy9OUDnDFp/ONfn17c9IuXeXuTgV00YVjj0Ym04ChPSd+d/ahiQeMg3FdUcvfUxAjIj+df4U+pM04arCBIwv1WtBc7GKTFiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-34-687da386d3c0
From: Byungchul Park <byungchul@sk.com>
To: willy@infradead.org,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel_team@skhynix.com,
	almasrymina@google.com,
	ilias.apalodimas@linaro.org,
	harry.yoo@oracle.com,
	akpm@linux-foundation.org,
	andrew+netdev@lunn.ch,
	asml.silence@gmail.com,
	toke@redhat.com,
	david@redhat.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	linux-rdma@vger.kernel.org,
	bpf@vger.kernel.org,
	vishal.moola@gmail.com,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	jackmanb@google.com,
	wei.fang@nxp.com,
	shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	sgoutham@marvell.com,
	gakula@marvell.com,
	sbhatta@marvell.com,
	hkelam@marvell.com,
	bbhushan2@marvell.com,
	tariqt@nvidia.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	saeedm@nvidia.com,
	leon@kernel.org,
	mbloch@nvidia.com,
	danishanwar@ti.com,
	rogerq@kernel.org,
	nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	aleksander.lobakin@intel.com,
	horms@kernel.org,
	m-malladi@ti.com,
	krzysztof.kozlowski@linaro.org,
	matthias.schiffer@ew.tq-group.com,
	robh@kernel.org,
	imx@lists.linux.dev,
	intel-wired-lan@lists.osuosl.org,
	linux-arm-kernel@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next v12 01/12] netmem: introduce struct netmem_desc mirroring struct page
Date: Mon, 21 Jul 2025 11:18:24 +0900
Message-Id: <20250721021835.63939-2-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250721021835.63939-1-byungchul@sk.com>
References: <20250721021835.63939-1-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUxTVxjGd+65XzRtvHYE71wIscyQGOZg0/mamM3tH062mCzhjyVbwtaM
	O26zUklRPtzYiuAMnRbjNINathIQ+TC2aUWqFp2lATbnhPKRbnzU1encVt0UREoRdgsx878n
	z/v+nuecnMNj7Xfset5g2iOZTXqjjlXRqrvq5he/bKmSc3y+NHC4TrMwPNPMQNd8BZy64WMg
	1CHCxaF5Chyd5xDMxic48NRNYpgJDrDQ0jyHIe4+TIPjei0ND10LGG71RzkYDDymocuzCyJt
	t2nwH+zB0PdwI0TrB1k4XJvA0Dh9gIXlXxMM9MbvcbDf105B79/dHAydszFwbOEkhh7LDaXr
	5jgDIxccLIzUDCOYPr3MwO2AUhhrn+TA1mVHELjcwcL+2lcg1j3Lwb/Hgxgitp2w1FAG/c40
	mLsaQzBxcoyCZb+Pg5+nzzAQdPVQMPpbHMPcoSYWrHfrEYw1XqDgpyY3A61XRynlHPkwvrxI
	wdchJws3ayMIQn1RGk5U2xC4LoUZuO9XrpyYd7A73yR9sX8w8U21InK24xeK3DmyRJHwpR8p
	ct4+xRGnZy/xtm8iLf4/KWINhzDxdNaxxPPgKEcmx/0sGWxI0MTb+gW5421E76S/p9pRKBkN
	ZZL5pdc+VMln598uCeZWPK7pRxZUl2VFKbwobBG9U4fwE912+Rs6qVkhSwyH4yt+qpArzkQH
	FF/FY+GaWuz1NlDJwbNCgTjVNLuiaWGjOB2eWIE1wlbxeNCCVkMzxC739ytBKcKrYlR5/aTW
	Kjuxv3zM6v5a8YfG3xWWVwqyRNe32qSNFbSm+wRO9opCNEV0D59hVzOfE6+0h+kjSLA/hdv/
	x+1P4U6EO5HWYCor1huMWzbLlSZDxeaPdhd7kPJt26oW3/ehB0P5ASTwSKfWlNBVspbRl5VW
	FgeQyGNdqoYM7JO1mkJ95T7JvPsD816jVBpAz/O0bp3m5bnyQq1QpN8jfSJJJZL5yZTiU9Zb
	EAxp4rpi89ZP16TJ8sF3ddse8ZHQx4midNPru55xZW/reOHowkRRquNUKK8y2+qI56gysg+o
	F8csS7r80T/y3NRbmcYB6+dk+4bQdUNkeN2VancGfcymLrfIVV/lrRnx6s5nZjrTm6vLd6zd
	nt93q/7eo8wNOW9MFmjZgvvXPruoo0tlfe4mbC7V/wex3bQTsgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUxbZRTG8973ftHQeO3IvE6zJU024pJNyUTPRMzM/vBVozNzusQsjEau
	tqEwbAFhCaEbnQqRj21OaVcmG6wDulhsYVToxlaaAhvqBhQ7gYKdTtDqVD5CgQ1vWYz77znn
	/J7zvMl7eKxaZtbxutx8yZCr0atZBa14Pa1sy5GGEu1Tx359DmzO8yzcmDnNgGOhCM5NehgY
	bBah6/oCBbaWCwhmY6McuMrHMMz4e1loOD2PIdZaSYPtezMNc85FDL8EIhz0+e7S4HC9BhP2
	2zR4P+7A0DO3ESLVfSxUmpcwWMJHWFj5cYmBi7E/OTjsaaKgp65fLn9v5+D6hSoGPls8i6HD
	NCkH3hphYKjTxsJQ2Q0E4fMrDNz2yanRpjEOqhxWBL7uZhYOm7dBtH2Wg79O+DFMVO2Ae7WF
	EKhfC/PXoghGzwYpWPF6OPgu/BUDfmcHBcM/xTDMf1rHQsUf1QiClk4KBupaGWi8NkzJ73gT
	RlaWKTg+WM/CLfMEgsGeCA0nD1UhcF4KMfC310zv2El6oncw8Yw3ItLWfJMiUzX3KBK6dJUi
	31jHOVLvKiDups2kwTtNkYrQICaulnKWuP45xpGxES9L+mqXaOJuLCVTbgt6Y/07iuezJL2u
	UDI8+UKmQtu28GqeP6XoblkAmVB5cgVK4EXhadHe/QUd16yQLIZCMRzXSUKKOBPplfsKHgvf
	JooX3bVUfLBGyBDH62ZXNS1sFMOh0VWzUkgVT/hN6P7SDaKj9fLqogThGTEi/3hcq2Qm+puH
	uc8/LPZbfpa9vByQLDpPqeJtLFvL2k/iGqS0PkBZ/6esD1D1CLegJF1uYY5Gp0/daszWFufq
	ira+eyDHheSbtJcsH/Wg2aGXfEjgkTpRmUeXaFWMptBYnONDIo/VSUrSe1CrUmZpig9KhgP7
	DQV6yehDj/G0+hHlK3ulTJXwviZfypakPMnw35TiE9aZUHb6rt07dw1kvofSSgPllVMFGV/b
	CvaPPv7E2037trurz0xLA+t13amMPd16lP+h60yCM3ERV3/0pRibztrUtemtlwOK0J0glW8J
	3ww+qz+evMext/TzjD3tD52b/KT/w93d2kPNj27otNdeHU6b37LdVNN1RWt78QOpdE41nK4I
	tmnUtFGrSdmMDUbNv2O9+c6PAwAA
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


