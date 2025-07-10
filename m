Return-Path: <bpf+bounces-62897-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0AFDAFFC4A
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 10:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D87B57BCBAA
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 08:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106E4293C67;
	Thu, 10 Jul 2025 08:28:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E2928C5D5;
	Thu, 10 Jul 2025 08:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752136111; cv=none; b=KjiZgFjjO4b6+ISNdVZt2RpYnPhV+0OO44Krbs4C97RzsivGqAy2z8YKC+4p47XY6yCBPOS6eLnOu6o3jtX8SaznUIeaDnqhcfIM1wC6FrgOLHQVGC6SXuQMojohwoUTosjbhpIRpfdqhZMQz6N/rmmcIzgf6X25X66D5ArgMoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752136111; c=relaxed/simple;
	bh=YdUfE/29Ky1Z1tGPPdQbrNA4czgzbUksqRDAtH+ExeQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=X8xjyU02GroI6SEvJbUpTWVBREFbiay2/pbJYbQUIb6uf2XcZ+2nSml+5VqysM1FuYK5ZdSWv9ylXqhT3/WoMGlMHlmZfzP44qMcrZy/uVKyByUGVHHeE5lOkPRK9Ms2ZYNPtrJlR7q4P2fS/dx6Uoz6TfrIFm/4ShhG0vCNSrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-e0-686f79a16ad4
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
Subject: [PATCH net-next v9 2/8] netmem: introduce utility APIs to use struct netmem_desc
Date: Thu, 10 Jul 2025 17:28:01 +0900
Message-Id: <20250710082807.27402-3-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250710082807.27402-1-byungchul@sk.com>
References: <20250710082807.27402-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTcRjG/e+cnXMcLU7T8mSFMRRhqKWYvUIXobBTKRRBdIMceXKjeZRp
	5oxKa1Iut6IMSifMLl5niyk6u4h5m6KZacbMvKRYfTClrHmZUJvltx/P8+PhhZfCJH24P6Xk
	0zk1L1dJCREu+r6qJLREk6LYap8PB6PFTEDVfCaUjdmEYKysQ/BrYYiE2VY7AY9KnBgY32px
	+G1ZxGCyfZyEKms8jJZ+weHl9XoMxm91EKDXujB4tTBNwlVbuQB66wxCKFh8gkF99hgJ/c+N
	BIyY/wjhS7Meh87CChxGDTHQbloHzq4pBK2WegE484sJuNtnImBCO4qgr2Uch6IcAwJLo0MI
	rnn3RlHbCBkTyLZMzWBsbcWggG0oHCZZk/U8W1MuY3WOPoy1VuYRrPXnHZL99OElwXbcd+Fs
	g21WwOqvTRPsj8mPODvTOECwltoBnO02tZKH1pwQ7UjkVMoMTr1lV4JIUfSjmEy955+Z196D
	slHNWh3yphg6ktE/eINW+MmSnvAwQQczDscC5mFfOpyZHbfjOiSiMLqaYFrNQ6Sn8KGPM/nv
	XrglisLpIKbtZpYnFtPbmLZXBvLfZgBT9axpWfGmoxjbxEVPLHErrgHd8iRD51LM6/Ku/zes
	d7MDv43EJuRViSRKPiNZrlRFhik0vDIz7ExKshW5P116aemkDf3sPdKMaApJV4l7k3iFRCjP
	SNMkNyOGwqS+4vljKoVEnCjXZHHqlNPq8yourRltoHCpnzjCeSFRQifJ07lzHJfKqVdaAeXt
	n402OhN8dIGPIxYnHJrhvWDcfPBomZ1nEnoo8+chvD2OyHnY3RmkuBZgpJsmQ50DV7bv8ftm
	nuMnq7sN/K5YmZY/FVw8Zpft7NRGRefe0R0o/OoVerlgrsl1Kb7pxt4QxVJjyNL7fW27+wd1
	qrhNf448vbV6/+GA4p6zsQHRpJefFE9TyMNlmDpN/hfbDSqI5QIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRfyyUcRzHfe957nket249u6gHyXZNNYsy0adpxh/lWU35T5rJyTN3OUd3
	x5ymXVjN4Yp+h8WM/NxxzJ3CzG9rkx+jC2EMrYn8zK8mV+u/917v197/vClMVI87UjKFmlMq
	JHIxIcAF13zT3Is0cdKzfWsukG+oIqByMwneTZn5kF/RgGBta4yE1Y5uAoqLNjDI/5SOw7ph
	G4PZrmkSKo1BMFk6h0PTIxMG0497CMhO38GgeWuRhFRzGQ/aC3r50N+g58Oz7RIMTNopEobe
	5xMwUbXHh7m2bBx635TjMKn3h67Cw7DxcQFBh8HEg42sAgKeDhYSMJM+iWCwfRqHvAd6BIYW
	Cx92Nvc38jonSH9Xtn1hCWPry7/w2MY3X0m20JjA1pW5sTrLIMYaKzII1riSS7LjI00E2/Nq
	B2cbzas8NjttkWCXZ0dxdqllmGCLv/3ksYb6YTxYdFNwMYqTyxI55Rm/CIE0b7mAjH/umJTR
	1Ye0qM5eh2wphj7HlOxmE9ZM0CcZi2ULs2Y72pNZne7GdUhAYXQ1wXRUjZHW4hAdymQNfNiX
	KAqnXZnOzGQrFtLeTGeznvy36cJU1rT+VWxpH8Y8c8+KRfvKzrAOf4IEhcimAtnJFImxEpnc
	20MVI9UoZEket+NijWj/y9KU3RwzWhsKbEM0hcQHhP3RCqmIL0lUaWLbEENhYjvh5g25VCSM
	kmiSOWXcLWWCnFO1IScKFx8RXgnhIkR0tETNxXBcPKf83/IoW0ctOnUMDyq9ujtco12zPwrq
	SwdXjg98P++X48p3koaGtb5YeVt94qGXe/8vx4D1EHsRvFaH9dp4jESVvaQue80XZ5au940v
	+0dGVf8euWCoEmju+0Z6m2oHgu1HHaThDnfuBo05pzIpkbm1P66r5isMOdq4058bAlfCTYaA
	dWefPbkYV0klnm6YUiX5A2hTrqPHAgAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

To eliminate the use of the page pool fields in struct page, the page
pool code should use netmem descriptor and APIs instead.

However, some code e.g. __netmem_to_page() is still used to access the
page pool fields e.g. ->pp via struct page, which should be changed so
as to access them via netmem descriptor, struct netmem_desc instead,
since the fields no longer will be available in struct page.

Introduce utility APIs to make them easy to use struct netmem_desc as
descriptor.  The APIs are:

   1. __netmem_to_nmdesc(), to convert netmem_ref to struct netmem_desc,
      but unsafely without checking if it's net_iov or system memory.

   2. netmem_to_nmdesc(), to convert netmem_ref to struct netmem_desc,
      safely with checking if it's net_iov or system memory.

   3. nmdesc_to_page(), to convert struct netmem_desc to struct page,
      assuming struct netmem_desc overlays on struct page.

   4. page_to_nmdesc(), to convert struct page to struct netmem_desc,
      assuming struct netmem_desc overlays on struct page, allowing only
      head page to be converted.

   5. nmdesc_adress(), to get its virtual address corresponding to the
      struct netmem_desc.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/net/netmem.h | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index 535cf17b9134..ad9444be229a 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -198,6 +198,32 @@ static inline struct page *netmem_to_page(netmem_ref netmem)
 	return __netmem_to_page(netmem);
 }
 
+/**
+ * __netmem_to_nmdesc - unsafely get pointer to the &netmem_desc backing
+ * @netmem
+ * @netmem: netmem reference to convert
+ *
+ * Unsafe version of netmem_to_nmdesc(). When @netmem is always backed
+ * by system memory, performs faster and generates smaller object code
+ * (no check for the LSB, no WARN). When @netmem points to IOV, provokes
+ * undefined behaviour.
+ *
+ * Return: pointer to the &netmem_desc (garbage if @netmem is not backed
+ * by system memory).
+ */
+static inline struct netmem_desc *__netmem_to_nmdesc(netmem_ref netmem)
+{
+	return (__force struct netmem_desc *)netmem;
+}
+
+static inline struct netmem_desc *netmem_to_nmdesc(netmem_ref netmem)
+{
+	if (WARN_ON_ONCE(netmem_is_net_iov(netmem)))
+		return NULL;
+
+	return __netmem_to_nmdesc(netmem);
+}
+
 static inline struct net_iov *netmem_to_net_iov(netmem_ref netmem)
 {
 	if (netmem_is_net_iov(netmem))
@@ -314,6 +340,21 @@ static inline netmem_ref netmem_compound_head(netmem_ref netmem)
 	return page_to_netmem(compound_head(netmem_to_page(netmem)));
 }
 
+#define nmdesc_to_page(nmdesc)		(_Generic((nmdesc),		\
+	const struct netmem_desc * :	(const struct page *)(nmdesc),	\
+	struct netmem_desc * :		(struct page *)(nmdesc)))
+
+static inline struct netmem_desc *page_to_nmdesc(struct page *page)
+{
+	VM_BUG_ON_PAGE(PageTail(page), page);
+	return (struct netmem_desc *)page;
+}
+
+static inline void *nmdesc_address(struct netmem_desc *nmdesc)
+{
+	return page_address(nmdesc_to_page(nmdesc));
+}
+
 /**
  * __netmem_address - unsafely get pointer to the memory backing @netmem
  * @netmem: netmem reference to get the pointer for
-- 
2.17.1


