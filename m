Return-Path: <bpf+bounces-63168-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FAE7B03DFC
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 14:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E68BF17CF64
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 12:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560B3248F69;
	Mon, 14 Jul 2025 12:01:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BD7149C51;
	Mon, 14 Jul 2025 12:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752494461; cv=none; b=JSu5fRenAZlv/jQ9/zEk03TqOWEY3ooPtxluURz9PHJjTKiubtWITmaQQTk6wRNoGwVRLWXJ8rJK3TLIKt7iA5u5QFYQf2OY2uTKVyRmjhJWq5C6hr/BqvHA8KNHjoeOxMKO/KnH4kDRcBy9+Av11NLFMxUsx6em3xtEKw1c/CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752494461; c=relaxed/simple;
	bh=EEU0kq+HKSIbN2GeOshnu1C+3IJMA4iILRmIBGrc5h0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=euZYV6E5Dmvg2D+3+1tiH0RHopmHzDpC+XZp44byUZN1cxMslu+ErHmCfR79TP5GTlQSdQf77egt0Vs5F5m6Pe/W0fkouNxpqZ+rvdgSbGtev2vBXsQv7w7mrwJHUIHophxeZTipKpbZ6HuRbXtgpMX0OqcXdtxHwqY12sVxrO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-fa-6874f1796cc2
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
Subject: [PATCH net-next v10 01/12] netmem: introduce struct netmem_desc mirroring struct page
Date: Mon, 14 Jul 2025 21:00:36 +0900
Message-Id: <20250714120047.35901-2-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250714120047.35901-1-byungchul@sk.com>
References: <20250714120047.35901-1-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0xTdxTO7/7uq6Vd7qrbrsxlSRdj4qaTieYsYca4LLnTLdlkcdmWbDZy
	RxsB3W1hdNkyBiwL3UT2YINSWFFwhRpLWoGKBbE0gKADUbo75SFlEkUEFCUtVbtWZ+Z/X77z
	Pc5JDos1NXQya8gxiVKOLktLK0nlDdXBteabJv16p3Mt2FxHaDi3UEuBM5wPf1z2UjDUwMOJ
	wTABtsYWBLcjlxhwl4xgWAj00HCodhFDpGk/CbaBYhLuuJYwXOkOMdDrv0eC0/02jB+eIsH3
	XSuGrjurIHSgl4b9xVEMlWPf0hC7GKWgPTLLQKHXQUD79WYGBltKKfhlqR5Da8HleNdkkILz
	bTYazhedQzB2JEbBlD9eOOMYYaDUaUXgP9lAQ2HxBphpvs3AfHkAw3jpFrhfkQfd9qdhsX8G
	waX6YQJiPi8Df44dpSDgaiXgwkQEw+IP1TRYbhxAMFzZRsCZ6iYK6vovEPE90iEYu0vAz0N2
	GiaLxxEMdYVIqPqmFIGrQ6bgpi9+cjRso7dsFbpm5rDgHa1DwrGGvwnhatl9QpA7+gjhuHWU
	EezuXMHjWCMc8l0jBIs8hAV3YwktuG/9xAgjQR8t9FZEScFT97Vw1VOJ3nnuQ2VahphlyBOl
	lzfvUuqPhbfvC6Tk3yvqRgWoZLUFKVieS+XLf5ygH+Ez0wM4gWluNS/LkQd4OZfCL4R6SAtS
	spg7q+LbPRVEYrCM+5g/G+1EFsSyJLeKXwq8maDV3EZeDldRDzOf551NnQ9yFNwm/vfqCZTA
	mrimw1KHH+qf5E9X/kMmYnC811WjSdA4bi1qrsKJWp6bUvAX5ZP/Za7gTzlksgxx1sfs1v/t
	1sfsdoQbkcaQk5etM2SlrtObcwz563bvzXaj+Nce/uruR150azDdjzgWaVVqmDbpNZQuz2jO
	9iOexdrl6ulRSa9RZ+jMX4jS3k+k3CzR6EfPsqT2GfUri59naLhMnUncI4r7ROnRlGAVyQVo
	5e7MJLXfrTr6qir91/oVns0bJvq2GQsdS7M1ytxtA/O5aXPzO4Nffm8tqTK+Z5rr7m97sawv
	/7Vdn70rvbRxh/56puKtnYZrK7cvk1rs+vGnylPfrwjVIvn1yFRDUsHkC0WnZ6+YQ59iTVLw
	DevB5N/S1pv8T7g7/8re1DO8NRZlPtCSRr0uZQ2WjLp/AY40DrWxAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0yTZxTG937vd6Pa5LMg+4LJzJoZMowXNlnOss0Yl4x3F9mWmS1TN2nm
	l7WzXNZWAkuMaEsWGkC2uYQW2OoAx0UtaQWq1sJKhwg4ELSp46bVkQ5hjnGRUpW1mmX+95xz
	fud5zh+Hx4oIk8Rrsg2SLlulVbIyWpbxinFDwYxBvXlmYjVU2U+ycGX2OANNi/nw8w0XA4MN
	IpwfWKSgqrEVwVx4mANH8QiGWd9FFmqOL2AIN5fSUNVvomHevoThj64gB93eBzQ0OXbA+IkJ
	Gtxft2HonF8HwaPdLJSaIhgsY0UsLP8eYeBC+C8OjrjqKeisvhQt77RwMNBaxsCxpToMbYU3
	ooG3/AwMnatiYch4BcHYyWUGJrzR1Kn6EQ7KmqwIvO0NLBwxvQhTLXMc/P29D8N42TZ4WJEH
	XbZEWOidQjBcd42CZbeLg9/GTjPgs7dRcPVmGMNCSTUL5umjCK5ZzlHQV93MQG3vVSp6xwfg
	X75PwXeDNhZumcYRDHYGaag8XIbA7gkwMOM20dteJ51TdzFxjdYicqbhOkVC5Q8pEvD0UOSs
	dZQjNscB4qxPITXuPyliDgxi4mgsZonjn285MuJ3s6S7IkITZ+0hEnJa0HvP7JK9uk/SavIk
	3aatmTL1mcW3c32p+Q+MXagQFSebURwvClvEvsl+HNOskCwGAuFHOkFIFWeDF2kzkvFYuLxS
	vOCsoGKDeOFT8XKkA5kRz9PCOnHJ92asLRfSxMBiJfPYc63Y1NzxyCdOeEn8sfomimlFlPGY
	a/FjfpV4yXKbjtngaK79B0WsjaOrxpZKXI7k1ico6/+U9QnKhnAjStBk52WpNNq0jfr96oJs
	Tf7Gz3KyHCj6kicO3v/GheaG0r1I4JFypRwmDWoFo8rTF2R5kchjZYJ8clSnVsj3qQq+knQ5
	e3UHtJLei9bwtPJp+VsfSZkK4XOVQdovSbmS7r8pxcclFaKdOwZWePrWN2tT2pO+cHhul+xJ
	eDdzTVF6+anc6WRTQL35BfWheOeXa+/YZeRYUend/t1e27zhtY6RpzI2bUn7ifkF5yTu/KSl
	bumd7aOVvw4HQq17Q6uff67n+seH/Zb2nor490M1Hz6bMb3HeC94EHqL0udLNDb/yykabXzi
	zBurKCWtV6tSU7BOr/oXBAXMeI4DAAA=
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


