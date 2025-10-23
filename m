Return-Path: <bpf+bounces-71868-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C60FFBFFACE
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 09:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4B83B4F834F
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 07:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07762989BF;
	Thu, 23 Oct 2025 07:44:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D7628489B;
	Thu, 23 Oct 2025 07:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761205473; cv=none; b=EJcUoj9aJsLZKFx6kpA+QX/Wue90n87vphN6rfaNRlF8Ig0KtZMnSYYiOg30FFDkJp7w+tkXiB7I0eMG+XIna1TTZf7tO9JxG82ajQca+KzCZf0jbI51HAES/vQeDMXOOlm8BS2fGhfvL2Xu6dHs2VeiZsp5fo4c5j0KlKfKqFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761205473; c=relaxed/simple;
	bh=JUNLi/65dgjkw16k+x/1hTCjDaNNWT63HXZ+kModT6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=s1L1vpHR4Gw6wRGZkWfK2JCjdIX5l4HfDcIX2G6+LucwN3+7Rxj1nJS2GKJQtMlJyAFLpbB2PJ9w7NJjfJAnY9cBRF2c4BS3TlI7tROidcAk6ppi9NTkf64rd4xdUixX8Bq6thCKYuzjHqwIPTctA9V1eJ0EreYsf+inDjVcMpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-5a-68f9dcd4f823
From: Byungchul Park <byungchul@sk.com>
To: linux-mm@kvack.org,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel_team@skhynix.com,
	harry.yoo@oracle.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	pabeni@redhat.com,
	akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	horms@kernel.org,
	jackmanb@google.com,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	ilias.apalodimas@linaro.org,
	willy@infradead.org,
	brauner@kernel.org,
	kas@kernel.org,
	yuzhao@google.com,
	usamaarif642@gmail.com,
	baolin.wang@linux.alibaba.com,
	almasrymina@google.com,
	toke@redhat.com,
	asml.silence@gmail.com,
	bpf@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	sfr@canb.auug.org.au,
	dw@davidwei.uk,
	ap420073@gmail.com,
	dtatulea@nvidia.com
Subject: [RFC mm v4 1/2] page_pool: check if nmdesc->pp is !NULL to confirm its usage as pp for net_iov
Date: Thu, 23 Oct 2025 16:44:09 +0900
Message-Id: <20251023074410.78650-2-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251023074410.78650-1-byungchul@sk.com>
References: <20251023074410.78650-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTcRjG+59zds5xODgts5NFxaICKbMweYNIoYITYQQSdPlQSw9utqlt
	uTQIpo0uM2/VaM2Jq0iXWtZM3SRXzmWaUWJoC0vNKFsXi2nLqWTbpG8/nvd5fp9eGhcXCmJo
	edZJXpUlVUhIISH8EXljQ/+7gCy+qZ0Cc0M9CXVTeVAzYhdAoH4MA3NtM4LJwCAFc22dCCbc
	z0j41uFDcOuGHwfzKx0BvxumcXC0jiH4arxLwqfOUQrqbCkwXP2ZgEfnW3AYLe0ioVg3g0Nb
	YJyCQrs1KG7UUtDbXCKAq9O3cWjRjlDwutVMwlD9nAA+u4oJ6DbdIeCXwY3DcEkydFqiwd/z
	HYG7oQUD/6VKEvqvt2LQ1NZPwZU+CwkfdcMI+jpGCTDMXiChoqAEwcxUUDleNimAiqdDVHIc
	V+DxkFzH95849/DOW4wbMJYTnMf5HOMcpvcUZ7Hlco3WWE7v6cM5W+1FkrP5LlPcu4FHJNdl
	nCE4x4etnMM+gXHFZ8fJfYsPCbel8wq5hldt3H5UKJvx1lA51pg8r+umQIvci/UogmaZBPaL
	uRjTIzrMBaV7QjHJrGM9ngAe4igmnrUaJoMspHGmiGYHnQ/Ch0VMBjv36RoV2hLMGvaNJYwi
	Zgt79aVi3r6Srbv/JNyOYBLZ7r9PqRCLg5Xe8mkqpGQZN8369Oeo+cFStt3qIcqQyIIW1CKx
	PEujlMoVCXGy/Cx5XlxattKGgp9RfWb2sB35elNdiKGRJFKU/GxKJhZINep8pQuxNC6JEmkO
	BiNRujT/NK/KPqLKVfBqF1pGE5Ilos3+U+liJkN6kj/O8zm86v8VoyNitGiVlV+/d5RfuEg8
	UJq04JTR27Ti+OHlurH7E97EQHsV7wxUpuQOKoW743K7iMdVKzOEmWlNS9+mRL/WFja8+qHP
	7Ks5scOZeuB9oC7ekJjg9aQ0V6qidBWZop6iZhX2h1h7zLT19+rt92L3SU/vX+2Yit5joo1D
	OyVJIy92bUwSSAi1TLopFleppf8AUtMB3BUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRbUhTYRiGe3fOzjkOF4eldjCiWGRWpPb99EEZBL0VWlQo9SeHnrbhnLWp
	qKHMFCzLr1JaqbSSbKmhzspN1GSb5goqrNXKcsvSssQiTZ1GNoX+XTz3dd9/HoaQfCaDGaU6
	hdeoZSopJSJF0Tty171671VEOG6shcqGegrqptLhjscsBG/9FwFU1j5EMO7to2G2vRvBmP0x
	Bd9tvxBU35wgoPJ5Hgm/G6YJsLR+QfBNf4+Cwe4BGupMUeCuGSKhLb+FgIHiHgoK82YIaPeO
	0nDObPQNN+tosFU5hPDiYZEQyqZvE9Ci89DwsrWSgv76WSEMWQtJcFy/S8LPcjsB7qJI6DYE
	wcTTEQT2hhYBTFyqosB5rVUAD9qdNFzpNVDwKc+NoNc2QEL5n/MUVOQUIZiZ8k2OlowLoaKr
	n44MxzkuF4VtIz8IfP/uWwF+rS8lsavjiQBbrn+gscGUipuNa3CBq5fAptoLFDb9ukzj96/b
	KNyjnyGx5eM2bDGPCXBh7ih1OOiEaGcCr1Km8ZrwXXEixczwHfq0MTh92HpLqEP2wALEMBy7
	icspPliA/BiKXcW5XF5ijgPYCM5YPu5jEUOwFxmur6NpPljEyrnZwav0XJdkV3JvDPMoZjdz
	Zc9UcwbHLuPqGjvnbT92C+f420XPscSnvCidpkuQyIAW1KIApTotSaZUbQ7TJioy1Mr0sPjk
	JBPy/b4m60+pGY2/3GdFLIOk/uLIx1MKiVCWps1IsiKOIaQB4rTjvpM4QZaRyWuST2pSVbzW
	ipYwpHSx+EAsHydh5bIUPpHnT/Oa/6mA8QvWIb4/2vnqTMjW0OYFuz8sXBG7NzA/tKEuwe5M
	9pzqvFZyIjEl+6xn+5Ri2eTepT9Ln8jHxD3Zi1KP1Jg9bnX0HpzZv0MQIg9ambVcrs92NDYP
	DW70L9PF921wboiKvfB8tTnma1FMNf9On1U8GWXLb696BL8PHU3dH3DM/bTJIonxSkmtQrZ+
	DaHRyv4B18DwC/cCAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

->pp_magic field in struct page is current used to identify if a page
belongs to a page pool.  However, ->pp_magic will be removed and page
type bit in struct page e.g. PGTY_netpp should be used for that purpose.

As a preparation, the check for net_iov, that is not page-backed, should
avoid using ->pp_magic since net_iov doens't have to do with page type.
Instead, nmdesc->pp can be used if a net_iov or its nmdesc belongs to a
page pool, by making sure nmdesc->pp is NULL otherwise.

For page-backed netmem, just leave unchanged as is, while for net_iov,
make sure nmdesc->pp is initialized to NULL and use nmdesc->pp for the
check.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 net/core/devmem.c      |  1 +
 net/core/netmem_priv.h |  8 ++++++++
 net/core/page_pool.c   | 16 ++++++++++++++--
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index d9de31a6cc7f..f81b700f1fd1 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -291,6 +291,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 			niov = &owner->area.niovs[i];
 			niov->type = NET_IOV_DMABUF;
 			niov->owner = &owner->area;
+			niov->desc.pp = NULL;
 			page_pool_set_dma_addr_netmem(net_iov_to_netmem(niov),
 						      net_devmem_get_dma_addr(niov));
 			if (direction == DMA_TO_DEVICE)
diff --git a/net/core/netmem_priv.h b/net/core/netmem_priv.h
index 23175cb2bd86..5561fd556bc5 100644
--- a/net/core/netmem_priv.h
+++ b/net/core/netmem_priv.h
@@ -22,6 +22,14 @@ static inline void netmem_clear_pp_magic(netmem_ref netmem)
 
 static inline bool netmem_is_pp(netmem_ref netmem)
 {
+	/* net_iov may be part of a page pool.  For net_iov, ->pp in
+	 * net_iov.desc can be used to determine if the pages belong to
+	 * a page pool.  Ensure that the ->pp either points to its page
+	 * pool or is set to NULL if it does not.
+	 */
+	if (netmem_is_net_iov(netmem))
+		return !!netmem_to_nmdesc(netmem)->pp;
+
 	return (netmem_get_pp_magic(netmem) & PP_MAGIC_MASK) == PP_SIGNATURE;
 }
 
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 1a5edec485f1..2756b78754b0 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -699,7 +699,13 @@ s32 page_pool_inflight(const struct page_pool *pool, bool strict)
 void page_pool_set_pp_info(struct page_pool *pool, netmem_ref netmem)
 {
 	netmem_set_pp(netmem, pool);
-	netmem_or_pp_magic(netmem, PP_SIGNATURE);
+
+	/* For page-backed, pp_magic is used to identify if it's pp.
+	 * For net_iov, it's ensured nmdesc->pp is non-NULL if it's pp
+	 * and nmdesc->pp is NULL if it's not.
+	 */
+	if (!netmem_is_net_iov(netmem))
+		netmem_or_pp_magic(netmem, PP_SIGNATURE);
 
 	/* Ensuring all pages have been split into one fragment initially:
 	 * page_pool_set_pp_info() is only called once for every page when it
@@ -714,7 +720,13 @@ void page_pool_set_pp_info(struct page_pool *pool, netmem_ref netmem)
 
 void page_pool_clear_pp_info(netmem_ref netmem)
 {
-	netmem_clear_pp_magic(netmem);
+	/* For page-backed, pp_magic is used to identify if it's pp.
+	 * For net_iov, it's ensured nmdesc->pp is non-NULL if it's pp
+	 * and nmdesc->pp is NULL if it's not.
+	 */
+	if (!netmem_is_net_iov(netmem))
+		netmem_clear_pp_magic(netmem);
+
 	netmem_set_pp(netmem, NULL);
 }
 
-- 
2.17.1


