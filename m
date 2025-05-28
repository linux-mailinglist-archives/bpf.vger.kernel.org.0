Return-Path: <bpf+bounces-59058-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F41AC5F5C
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 04:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 678C64A0A3E
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 02:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB6A1E834E;
	Wed, 28 May 2025 02:29:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77A71C7017;
	Wed, 28 May 2025 02:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748399368; cv=none; b=Bnl2EavWGYF+jCmut+i7rHhghVfrO3c++Xd5RejfIAdKHt74VuEhR2yqpPiyRV/ZICOm4F1E4ohbAPAVZ0kpjy/2I6Z/u7DLarwz/QG+uKcvVKpdKu4yJo5zEP6+SmJqEMP2nyk8WeNP73OTzQEjrtRjHFeoyFCbmWw5Bx3Roz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748399368; c=relaxed/simple;
	bh=OcW5+1PM1j3WtfmJnooxD5p/vUeRoBMrsH4LW77EccI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=cstaeuLcHa6f72G2PegS8SrK6Uscq/F/0vjosPVAktdJLgswebaJo4IpXZcig0sHKneMqmsDg6h/6uVKnUy8+Dk0WHZ9sIrpgfQx9JgXiCsHE7HsspkmJzqREgqwEklFQ0VMXwIkISqdmcK2uhikt8Y6ps22Q3jVmju1HWGLItE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-20-68367501dd61
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
Subject: [PATCH v2 01/16] netmem: introduce struct netmem_desc struct_group_tagged()'ed on struct net_iov
Date: Wed, 28 May 2025 11:28:56 +0900
Message-Id: <20250528022911.73453-2-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250528022911.73453-1-byungchul@sk.com>
References: <20250528022911.73453-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRf0yMcRzHfe/53nNPt45np/Fgfp1hjLhW7TNEG+M7tthaWObHs3q4Z+qy
	S+cyJie/LhejGbnmiFQulytdLI3rIjmTU3aUalFqI3TcuGvDMf+99n6/9v7nzVBKF57MiNq9
	gk7LZ6hoOZZ/iry6EOXEaxZbnHPAYrfRcPOHAW701kvBUlmH4NvPThn43Y9pKL0SoMDyPB/D
	d3uQgv5HfTLoKRvA0HDcSUHf6RYazPkhCoz15RJoqyuUQlHwOgXOvF4ZvLxnoaHb9ksKAy4z
	hifFFRh6ChPhkXUCBJ5+ROC2OyUQOFVCwzmvlYZ3+T0IvE19GC4dLkRgb/RJIfTDQifOJLUV
	ryXkbvFbGbE6ckhN+Xxi8nkp4qg8SRPHyFkZ6XrVQJOWCyFM7tb7JcR8ZJgmX/vfYPK5sYMm
	9toOTDxWt4z4HdM2sKnyZelChqgXdIuW75BrvhztxXtejDeM2G7jPPRqnAlFMBwby5lqqqn/
	XFB77S/T7FzO5/v5l6NYNefve4xNSM5Q7LCU67eEJCbEMONZkRt9vzGMmJ3NVX7lw7qCjeOq
	Lt7B/yanczerH1BhJYKN55q70sKx8o/yucCOwosc+13GDbZ7pP/8SdzDch8+gxRWNKYSKUWt
	PpMXM2KjNbla0RCdlpXpQH+eLTs4uqUejbQluxDLIFWkglTHaZRSXp+dm+lCHEOpohTGFfEa
	pSKdz90v6LK263IyhGwXmsJg1URFTGBfupLdxe8VdgvCHkH3v5UwEZPz0LFh784ja9pWvVWv
	H1vTrs/xpNio2CV1SfmU76VxgeLEvG2NdYGiwYS166rTU7rvKw9dnjH6S7l1s1FtaBKTHw41
	T410PxM7WjcnrFz6MRjjnDWkTqKLdsYYxFrbOfc9rpQPjonObKU7q1LZD5sCzHlvnMd8YLXG
	8PzWqoQGW4kKZ2t49XxKl83/BkHDRoHVAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWReUiTcRzG++397d270fBtSr2ZUKxSMLQZKV+wUijtZ4HZZVBSDn1xw5NN
	RaPAPJC8sgPymLHyyCtm5p1IqHlkpHllqWlTR3+Id8OLzBX99+F5Pjz/PAwlK8a2jDoimtdE
	KMPktARLfN2TnFCMm0phKtsLOkMlDRWrcfByskEIuvI6BCtroyJYbu+kofC5mQJdbzKGX4Z1
	CmY6jCKYKDFhaE6tp8D4oIuGzOQNChIbSgXQVtAthL66LCE8WS+moD5hUgQDTToavlduCcHU
	momhO68Mw0SWJ3Tod4O5ZxZBu6FeAOaMAhoe9+tpmEqeQNDfZsSQfy8LgaFlRAgbqzraU05q
	yr4KSGPeuIjoq2PIm1JHkjbST5Hq8vs0qV56JCJjw8006crZwKSxYVlAMpPmaLI48w2T+ZYh
	mhT+XBAQQ80QJh/17SK/XdclJ4L5MHUsrzl6KlCiWkiZxFGfreOWKl/jBDRslYbEDMce59Jr
	iigL06wDNzKy9pdtWBdu2diJ05CEodg5ITej2xCkIYaxZtXc5rS/BTF7mCtfVFp0KevKvcqt
	xf8m93MVVe8oiyJm3bj3Y0GWWLatzKcbUDaS6NGOcmSjjogNV6rDXJ21oar4CHWcc1BkeDXa
	Pq/k7ubDBrQycLYVsQyS75SSKleVTKiM1caHtyKOoeQ20kQPN5VMGqyMv81rIm9pYsJ4bSva
	x2D5Hum5a3ygjA1RRvOhPB/Fa/63AkZsm4D840+KUSAjHnj6wid78AdzzFxgdabR26bMNqTp
	gsotc8b+YKL5xsqRmwGJo299n80p7ArttryKvAdTF3OiBzzgw/Jlrysmxna176pfCnvoi7eP
	wmH8QLJ9T/esy1Tp6QT32kLZnbaLlz6t5S+lu9AETfdk5CpGTb0Bv4m10Om8HGtVShdHSqNV
	/gGEuav7uAIAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

To simplify struct page, the page pool members of struct page should be
moved to other, allowing these members to be removed from struct page.

Introduce a network memory descriptor to store the members, struct
netmem_desc, reusing struct net_iov that already mirrored struct page.

While at it, add a static assert to prevent the size of struct
netmem_desc from getting bigger that might conflict with other members
within struct page.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/net/netmem.h | 41 +++++++++++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index 386164fb9c18..a721f9e060a2 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -31,12 +31,34 @@ enum net_iov_type {
 };
 
 struct net_iov {
-	enum net_iov_type type;
-	unsigned long pp_magic;
-	struct page_pool *pp;
-	struct net_iov_area *owner;
-	unsigned long dma_addr;
-	atomic_long_t pp_ref_count;
+	/*
+	 * XXX: Now that struct netmem_desc overlays on struct page,
+	 * struct_group_tagged() should cover all of them.  However,
+	 * a separate struct netmem_desc should be declared and embedded,
+	 * once struct netmem_desc is no longer overlayed but it has its
+	 * own instance from slab.  The final form should be:
+	 *
+	 *    struct netmem_desc {
+	 *	   unsigned long pp_magic;
+	 *	   struct page_pool *pp;
+	 *	   unsigned long dma_addr;
+	 *	   atomic_long_t pp_ref_count;
+	 *    };
+	 *
+	 *    struct net_iov {
+	 *	   enum net_iov_type type;
+	 *	   struct net_iov_area *owner;
+	 *	   struct netmem_desc;
+	 *    };
+	 */
+	struct_group_tagged(netmem_desc, desc,
+		enum net_iov_type type;
+		unsigned long pp_magic;
+		struct page_pool *pp;
+		struct net_iov_area *owner;
+		unsigned long dma_addr;
+		atomic_long_t pp_ref_count;
+	);
 };
 
 struct net_iov_area {
@@ -73,6 +95,13 @@ NET_IOV_ASSERT_OFFSET(dma_addr, dma_addr);
 NET_IOV_ASSERT_OFFSET(pp_ref_count, pp_ref_count);
 #undef NET_IOV_ASSERT_OFFSET
 
+/*
+ * Since struct netmem_desc uses the space in struct page, the size
+ * should be checked, until struct netmem_desc has its own instance from
+ * slab, to avoid conflicting with other members within struct page.
+ */
+static_assert(sizeof(struct netmem_desc) <= offsetof(struct page, _refcount));
+
 static inline struct net_iov_area *net_iov_owner(const struct net_iov *niov)
 {
 	return niov->owner;
-- 
2.17.1


