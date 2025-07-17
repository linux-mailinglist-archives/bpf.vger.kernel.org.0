Return-Path: <bpf+bounces-63563-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF371B085DD
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 09:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D24054E544C
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 07:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3915D21C9F9;
	Thu, 17 Jul 2025 07:01:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573061EE7B9;
	Thu, 17 Jul 2025 07:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752735672; cv=none; b=NXvRkRJhpFmZuVIreaFXQBzYrUyMNVfi8zHCi5CDgJ22FHkYJBQm0G93V17KVUw2GF6Qvg6vlmEF1p6YOO31Fa53k4zUZQp8cQzrblCQds8bli2AXDR7xZMMSHk43GmlS7TDUaUIbKA8Q75sCjZ1GzVbZawzb+Tdza3VE+cCbEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752735672; c=relaxed/simple;
	bh=EEU0kq+HKSIbN2GeOshnu1C+3IJMA4iILRmIBGrc5h0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d8iilfECD91rrRiOUV5qAO4ZbUYuP6JSzw/ZXwBuVKZN1k0mI5XszH4ZgqcKfpn9esLkAiCa1guJ4i0/xmjtRqCXTCmqNB2pcbe1I9HUw2/UNDNtQA3gjFonGyDPDEnr0M1Io/KeOlkPe9bnNvgMXlrsz4d4sXoeTYGPLvhCUqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-cc-68789fb3a763
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
Subject: [PATCH net-next v11 01/12] netmem: introduce struct netmem_desc mirroring struct page
Date: Thu, 17 Jul 2025 16:00:41 +0900
Message-Id: <20250717070052.6358-2-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250717070052.6358-1-byungchul@sk.com>
References: <20250717070052.6358-1-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se2xTZRjG/c53bqurOVTUsxlDaJjTGZDp0BeDBg2JxyCJkf/AKI070kp3
	sYPSGckGq5EtrCMwzNoV2MbYpSW0adlWRwd6NsYugqOMWdzWQdGBcfPCRm3pRj3rQuS/J+/7
	/J7n+5KXxapjdDqry98pGvI1ejWtIBXTqQ0rvcdN2tV9wafA7jpFw5WZegqcURM03/BREGjl
	4exQlAC7ox3BbGyUAU/5GIaZnos0nKiPYIi5K0mw/2Qm4Z7rPobfesMM9EnzJDg9m2CiaZIE
	/zcdGLrvZUC4qo+GSnMcgzX0NQ2JX+IUdMX+ZGCfr4WArj/aGBhqt1BQff8kho7SG3LXrREK
	rnbaabhadgVB6FSCgklJLpxqGWPA4rQhkM630rDP/CpMtc0y8PeRHgwTlvXwoMYIvXVPQ2Rw
	CsHoyWsEJPw+Bi6HTlPQ4+ogYPhmDEPkwFEaKqarEFyzdhLw41E3BY2Dw4T8js0wkpgj4HCg
	joZb5gkEge4wCbV7LQhc54IU/OOXvxyP2un17wjdU39hwTfeiIQzrdcJ4c7BB4QQPDdACN/Z
	xhmhzrNL8LZkCSf8vxNCRTCABY+jnBY8dw8xwtiInxb6auKk4G0sEe54reiD57Yo1uWKep1R
	NLz81jaF9kx0Y2FPtmm+rBeVovLMCpTC8lwO39AeIh7qyMAcXtA0l8kHg7GkXspl8zPhi2QF
	UrCYu5TKd3lrksCT3Md8lXSWXtAkl8HvvWxPzpVykOVfM1oMXcY73d8ng1K4NXy8+lDSr5I9
	ww2lzKJ/Cd9v/VUuYOWCTN51TLUwxjJa1laLF2PCKXxrxxeLOo3/oSVIHkSc7RHa9j9te4Su
	Q9iBVLp8Y55Gp89ZpS3O15lWfVqQ50Hy1TbtmdvqQ3eHNkuIY5E6VbnNvVurojTGouI8CfEs
	Vi9VHg4YtSplrqb4S9FQ8Ilhl14sktCzLKl+RvlKZHeuituu2SnuEMVC0fBwS7Ap6aUo7Yl3
	Vzudsef7q8kS/MalQse30psXhpcPNrw4vuEr8vGoZ02l3jTrqHkNr7geqjpQ8t7PBS9kbOjH
	7fyO/ZqP3NTrm+azmPmRznUDL23JSd+6PLDss+bi7V7rUH3T+3uk5pWBx9In3/6w7Hba7SOJ
	0fNrb66t5j6XLuSuqJ2e2ejYr2lSk0VaTXYWNhRp/gM+u27hsQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbWxTdRTG87//+7aGmlon3kxFUoUlmAHNXHKii5Is6g1EY/SDiSa6xl1t
	3VawHbUzUTt2jW6Bbg5MttLhxjbYVrSlZVuFMuS2aQsThO4lVcaG3SQTh4AdtaVl827EyLfn
	nPM7z3M+HBarc1QBazDWCCajrkpDK0jFq8/VF3m/teo357pKwek+QsPFZCcFrrQVDl/xUxDr
	4+DEhTQBzv5BBAuZSwx4GyYxJEMRGro6Uxgynj0kOH8WSbjtvoPh93CCgah0lwSX9xWYPnSV
	hMCXQxiCt9dBoilKwx4xi6Ft6gsaln7NUnAy8xcDu/y9BATbz8jlnwMMXBi0U7DvTg+GIdsV
	OXBmgoLR404aRusvIpg6skTBVUlOne+dZMDuciCQTvXRsEsshvmBBQZufhPCMG3fAoutFgh3
	rIbUyDyCSz3jBCwF/Aycn/qegpB7iICx3zIYUrvbaWi83oRgvO04AT+1eyjoHhkj5DvegIml
	HAF7Yx00zIjTCGLBBAn76+wI3MNxCm4FRHJLGR+cv4F5/+VuxB/r+4Xg55oXCT4+fJbgf3Bc
	ZvgO707e17uB7wr8QfCN8Rjmvf0NNO/9u4XhJycCNB9tzZK8r/tzfs7Xhl5b85aitEKoMlgE
	06bnyxX6Y+ltO0Ja6936MLKhhsJGlMdyqme41NkcXta0qpCLxzMrOl+l5ZKJCNmIFCxWnVvF
	nfS1EsuDh1TvcE3SCXpZk6p1XN1550pfKRvZ/xHRPdMnOJfnxxWjPFUJl93XssKrZWbsoI25
	xz/InWmblQNYOaCQcx9QL7exvFo/sB83I6XjPsrxP+W4j+pAuB/lG4yWap2hqmSjuVJfazRY
	N763vdqL5J889Gnuaz9aGH1ZQioWaVYpyz0f69WUzmKurZYQx2JNvnJvzKJXKyt0tZ8Ipu3v
	mnZWCWYJPcqSmkeUW98UytWqD3Q1QqUg7BBM/00JNq/Ahh54f30dWWMxxQ+WD45UjHueSicX
	r5VEHtv2Yry46LuWoGv8q2Rdj/bhA1n21mfDBWW2w83Z2bA0dWp1RJzzrO156XXUfvN0dfHa
	qC/k/SgVVh/d9OHmzq2VTet3v7BGJK1PnhNbEtcS6ev201Ft0czb6htPlymNjsefncs/OhuR
	SjWkWa/TbsAms+5fo9b3GY8DAAA=
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


