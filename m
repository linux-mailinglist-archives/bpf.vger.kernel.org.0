Return-Path: <bpf+bounces-63167-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B720B03DF3
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 14:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50DAD17D5D5
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 12:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0377B248193;
	Mon, 14 Jul 2025 12:01:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12081EEF9;
	Mon, 14 Jul 2025 12:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752494461; cv=none; b=podp9arxMic+1sJsLI7n8lVk7JYvUE7xaJIOMtSDpIXUnKIzV2cNCEGPJ6e8OxYWq/V3sIP3MvD2qT53GVf8bb23ps9Pv93IuDIoILKQeKDAYK81745Yoywr4zeKTTUAW9pPEi5Dg/+dTPKhnGGc+qd3xXVu890K1/Hl2mmMMu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752494461; c=relaxed/simple;
	bh=319V1i582sD7EQPcc3+4s+8NmfIU3icXNcMcXVYBu0c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=EBJfk66M96+fDPndckrWNdLmEZlnY2ifEU009KqM5UK53FzCs5/cz0K7bKu8o0wPcIKqMHYXsMIt7zUyeB9OMnD9md6zBlA4+OX1ykQ/CuMr6akUuxJrBJOoB0P8bLd5BfpI75ijJe9qRkgkLIixyJtSrpfbH/TloG2OcmHwOBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-0c-6874f179ae2a
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
Subject: [PATCH net-next v10 02/12] netmem: use netmem_desc instead of page to access ->pp in __netmem_get_pp()
Date: Mon, 14 Jul 2025 21:00:37 +0900
Message-Id: <20250714120047.35901-3-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250714120047.35901-1-byungchul@sk.com>
References: <20250714120047.35901-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0yTdxTG93/vrXS+dsS9wxiTLsyoQcQLOx+ct0Tz+sHN6Dcv0Ube2MZy
	SamVuiyigobKLShJ0eJALgNqBFu1RQtKWwVlKlYhVe44sUNAoVApoLXU+O2Xc87zPOckh8Gl
	L8koRpmkEdRJcpWMEhPikYgrMboxjWJV12A8GGuvUvDMV0qCaSoN/umzkeCu5uBO2xQGxppb
	CCYCnTSYs7pw8LmaKSgr9eMQqMshwPg0g4DJ2mkc3jwYoKHF8YkAk3kH9FYOEmA/a8XBORkN
	A3ktFORkzOBQ1JNJQfDVDAkNgVEaTtmqMGh4d5OGtlu5JFyYrsDBmt4XynrdQcLz20YKnp9+
	hqDnapCEQUcocLiqi4Zc00UEjrvVFJzKWAPDNydo+FDowqE3dxN8NmjhQclC8LcOI+isaMcg
	aLfR8KTnGgmuWisGL/oDOPiziynQj+QhaC+6jcG/xXUklLe+wEJ77IaO4CwG590lFLzO6EXg
	dg4QcOlkLoLaRg8JY/bQyTNTRmrTFt45/B7nbd3liL9R/RLjvfmfMd7T+Ajj6y9203yJ+Shv
	qVrOl9n/x3i9x43z5posijePF9B8V4ed4lsMMwRvKT/Bey1FaOfiPeL1CYJKqRXUsRsOihWT
	91x0yuXv0+r6Cqh09N88PWIYjl3LtZ9br0eiMA4VB+k5ptilnMcTwOc4ko3jfAPNhB6JGZx9
	HME1WAzYXOMHNpnL9lnCTLDR3ETQGhZL2HVc5mwH+mq6hDPV3Qsbidh47u/i/nBdGppp1Jfj
	c6YcWybipkcn6K+Cn7imKg+RjyQl6LsaJFUmaRPlStXalQpdkjJt5aHkRDMKPVzlX7N7bWi8
	bbcDsQySRUhgSKOQknJtqi7RgTgGl0VKhrrVCqkkQa47LqiTD6iPqoRUB1rEELIfJav9xxKk
	7GG5RjgiCCmC+lsXY0RR6WjbgtLfrMrm9hv7tKOc/Oeduvm/R5mXbXQ29WY+NNXT3nTVr5b7
	vsEK0RPYyv4RYWzdXOj+eF17ffWu+A2ud9ObY37JcuaM+Dv/TPHmx9Wbmvdg2+nCRFvP+BtD
	vnLd/vtj2Y8LzmhiH0Lfq2OxwcrSyOi3i/N29a+4sMMbU2ZocsiIVIU8bjmuTpV/AZqG1HJs
	AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0iTcRTG+7/XuZy9LKkX7QILCaI0K+NAVyroJTCKqKAvOfStLZ3WpmPr
	QqaTaKSZ3dRcaS7zEmlbtmXTYhtey1JT5v1WUbay8kJTa02jb79znnOe53w4AlxsIYME8vhE
	XhkvjZNQQkK4d1PqGu2PRNla94XlkFf+kIKWsQISyn5p4MGAlYTWEhaev/2FQV7pUwTjnm4a
	TJd6cBhz1lFQWDCJg6cinYC8NzoCJsqncPhQO0RDvf03AWWmSOgv+kiA7aIFB8dECAxdqacg
	XTeNQ05fGgXermkSqj3faEixFmPgMDT4yi+VNLx9mkHC9an7OFiSB3yBwx0ktFXlUdCW2oKg
	76GXhI92X6q7uIeGjLJcBPYXJRSk6NaDu3Kchu83nDj0Z2yHP9lqqM1fBJNNbgTd99sx8Nqs
	NDT3PSLBWW7B4N2gB4fJywYK9F+vIGjPqcLglaGCBGPTO8x3xwHo8M5gcK01n4JhXT+CVscQ
	AbcvZCAor3GR8MOmI7bv5BzuUZyz9hoR96SkE+M+Zf7BOFdNI8Y9y+2luXxTEmcuXsUV2j5j
	nN7VinOm0ksUZ/qZRXM9HTaKq8+eJjiz8Tz3yZyD9i07Itwcw8fJ1bwybGuUUDbx0kmfvBOg
	qRjIopLR+/l65CdgmQ3siMFLzzLFrGRdLg8+y4FMODs2VEfokVCAM6/92WpzNjYrLGQS2Mtj
	5jkmmBB23GuZWxYxEWzaTAf6Z7qcLat4OWfkx2xk7xoG5/pi30yN3ohnImE+mleKAuXxaoVU
	HhcRqoqVaePlmtDoBIUJ+d6p6NzMVSsab9ttR4wASfxFMJIoE5NStUqrsCNWgEsCRSO9SplY
	FCPVnuaVCUeVSXG8yo6CBYRksWjPYT5KzByXJvKxPH+SV/5XMYFfUDLaumhpwPnm3Eey1Wcy
	w+sljruDo9sioxXaLZrHa7tuLs1mV8QaVyY5gyWj0ggiqkczEPlhxYmDNsuehq/OoCj/syG/
	1a5vvY8tiuRnU9cLd4SlVIYHp1WFCZsXNHUe2tV4Sj7Ycisg9ciouV1StK70Z5phiTcySzxj
	bT528J4mXbZfQqhk0vBVuFIl/QvMoNwuSgMAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

To eliminate the use of the page pool fields in struct page, the page
pool code should use netmem descriptor and APIs instead.

However, __netmem_get_pp() still accesses ->pp via struct page.  So
change it to use struct netmem_desc instead, since ->pp no longer will
be available in struct page.

While at it, add a helper, pp_page_to_nmdesc(), that can be used to
extract netmem_desc from page only if it's pp page.  For now that
netmem_desc overlays on page, it can be achieved by just casting.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/net/netmem.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index 535cf17b9134..2b8a7b51ac99 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -267,6 +267,17 @@ static inline struct net_iov *__netmem_clear_lsb(netmem_ref netmem)
 	return (struct net_iov *)((__force unsigned long)netmem & ~NET_IOV);
 }
 
+static inline struct netmem_desc *pp_page_to_nmdesc(struct page *page)
+{
+	DEBUG_NET_WARN_ON_ONCE(!page_pool_page_is_pp(page));
+
+	/* XXX: How to extract netmem_desc from page must be changed,
+	 * once netmem_desc no longer overlays on page and will be
+	 * allocated through slab.
+	 */
+	return (struct netmem_desc *)page;
+}
+
 /**
  * __netmem_get_pp - unsafely get pointer to the &page_pool backing @netmem
  * @netmem: netmem reference to get the pointer from
@@ -280,7 +291,7 @@ static inline struct net_iov *__netmem_clear_lsb(netmem_ref netmem)
  */
 static inline struct page_pool *__netmem_get_pp(netmem_ref netmem)
 {
-	return __netmem_to_page(netmem)->pp;
+	return pp_page_to_nmdesc(__netmem_to_page(netmem))->pp;
 }
 
 static inline struct page_pool *netmem_get_pp(netmem_ref netmem)
-- 
2.17.1


