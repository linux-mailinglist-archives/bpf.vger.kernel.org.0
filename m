Return-Path: <bpf+bounces-62898-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F60AFFC56
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 10:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3E691C861C3
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 08:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60EB1298CC4;
	Thu, 10 Jul 2025 08:28:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569DA28DEFC;
	Thu, 10 Jul 2025 08:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752136113; cv=none; b=rNSFWl4HW6ZtP190126O2hVk6Jglszb30qlTNRNYQNd2lNMAeRNAwMJaVoOXR4lzNaUNGEbka6aqP9ZIbV/L0R7Aj1nKUDUMcN33B8mgPVtDIW/tYdJlUpTELfB88ODn7z5Y/z05vXeYfImnWvh+WoSYW8f+wEOVZKUsvzl/+bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752136113; c=relaxed/simple;
	bh=QZfgq/uQBZ8IaOShdYr5bExF2zKPxaHWVpJjAClxRnk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=um9eePsO4bXVfbkIxXYiBUpokFbt3mCsDetvtUVMAuoGG6Q9iyeaOR5iaH6Tp0d3Fdo9wGryY5bAojbfA7bchGfYdrEudzY7WHn7m7TtRsIynbjzVmftiVksQ501SIp1DOahBMPBZINUXYUBQVco2M6/3CJA1OFQAQ7JUXESVjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-19-686f79a2591f
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
Subject: [PATCH net-next v9 7/8] netdevsim: use netmem descriptor and APIs for page pool
Date: Thu, 10 Jul 2025 17:28:06 +0900
Message-Id: <20250710082807.27402-8-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250710082807.27402-1-byungchul@sk.com>
References: <20250710082807.27402-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTcRyG+++cnXNcjk5T6mSBMYrA0jJUfh8i7FMnyBIM0oJ05MGt5pTN
	26xomqIOXVHSxQssS+ctJmvpvOYtL2loijaz1BxakGnepm5BOcNvD+/78nx5KUz0EfeiZIoE
	TqmQyMWEABf8ci/xLVHHSU8UZLlDkbGagKr1FDBMWfhQVFmLYGVjnITlzm4CXjy3Y1A0kIHD
	qtGBwUzXNAlVphCYLJvFoSmrDoPp+z0E5GU4MWjemCch3VLOg8FaHR/yHaUY1GmmSBhuKCJg
	ovovH2bb83DoLajAYVIXDF36PWDvm0PQaazjgT23mIBHQ3oCbBmTCIY6pnEoTNMhMLZY+eBc
	33QUvpsggw+xHXMLGGuuGOOx9QVfSVZvSmRfl/uwWusQxpoqcwjWtPSQZL+MNhFsz1MnztZb
	lnls3r15gl2c+YyzCy0jBGs0j+Bsv76TDN19RXAqmpPLkjjl8dNRAukb+xovXuOR0vF4hNSg
	tl1aRFEMHcB0DR/Yxh/fb2mRG0XQRxirdQNzsSftzyxPd+NaJKAw+hXBdFaPk67Cgw5nGnLe
	Ei7G6cNMWuXoVi6kAxlj6XvcxQztzVTVtGIuvxsdxFhsW37R5sQ5ot1yMnQmxWRlPyH+7/cx
	beVW/AES6tGOSiSSKZJiJTJ5gJ9UrZCl+F2PizWhzaPL7vy5akFLg2HtiKaQ2F04GKOQiviS
	JJU6th0xFCb2FK6Hy6UiYbREncop4yKViXJO1Y72U7h4r/CkPTlaRMdIEribHBfPKbdbHuXm
	pUE1UTEF2QvnLwZ39RVnHg2aF6eGBfheS19bcIjz+r1tkfLkVXNgjtnwbOyy6u7ZvlxVsjqJ
	1o8d8zj3MwWc30pubxjaQi41RgzwVwwlM4b0SB/bDVnL7wystxnG8nf2dDDGZbFV3njwzIdP
	hsUId/OsvLVR+rLlQmhEfKNDVyPGVVKJvw+mVEn+AYDTPCPkAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRb0gTcRzG++1ud+dodE3JS6FgIIWROUz5VlYSRGdg1IvSeqEeebnhnLKp
	qGG4FMKVf7KQ0AkT2dKprKbpNLPa/B+oaZql+WeiCYlmmrkZmBN69+F5Hj5vHgqTNOF+lEKV
	xqtVnFJKiHDRlTN5x6uyUuTBre5ToLfUE1C3mQnPZ2xC0JubEay7JkhY6+whoLpqAwP9YD4O
	vy1uDOa7nSTUWaNg2rSAQ/uDFgycxb0EFOZvYfDGtUzCfVuNAByVfUIYai4SwlO3EYOW3BkS
	Rtr0BEzVbwthwV6IQ195LQ7TRRHQbTgAGx+WEHRaWgSw8aiSgCfDBgLm8qcRDDucOFRoixBY
	OsaFsLW546jomiIjAljH0grGNtV+EbCt5d9I1mBNZxtrAlnd+DDGWs0FBGv9VUqyk2PtBNv7
	bAtnW21rArYwb5lgV+e/4uxKxyjBVi/+FLCWplH8quSWKDyBVyoyePWJc/Ei+auNP4LUXO9M
	R9komYve79MhimLok8zi97s65EUR9BFmfNyFediHljFrzh5ch0QURjcQTGf9BOkpvOkYpq3g
	LeFhnA5gtOax3VxMhzIWYz/uYYY+zNS9eId5/F50GGOb2/VLdiZbozq8BIkMaI8Z+ShUGcmc
	QhkapEmSZ6kUmUG3U5KtaOdLU87fxza0PnLJjmgKSfeKhxJVcomQy9BkJdsRQ2FSH/FmjFIu
	ESdwWdm8OiVOna7kNXbkT+FSX/HlaD5eQidyaXwSz6fy6v+tgPLyy0UXCb87MRp3+sfGudWj
	8caG4AFzRMV2jv20f4hU0l4eNfz65vZZfunTy+BDIaSsX2E0uUMHpJ9n1ytkUw+75TOcb6zv
	RGnk1AVh9AOdqkSnahYWF/SVyM5f+3HDFegKDpncvxC3nB3WGN7lmh0KHDQlaiPLKnuujxy8
	V1Abqz0mxTVyThaIqTXcP7di57nHAgAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

To simplify struct page, the effort to separate its own descriptor from
struct page is required and the work for page pool is on going.

Use netmem descriptor and APIs for page pool in netdevsim code.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 drivers/net/netdevsim/netdev.c    | 19 ++++++++++---------
 drivers/net/netdevsim/netdevsim.h |  2 +-
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index e36d3e846c2d..ba19870524c5 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -812,7 +812,7 @@ nsim_pp_hold_read(struct file *file, char __user *data,
 	struct netdevsim *ns = file->private_data;
 	char buf[3] = "n\n";
 
-	if (ns->page)
+	if (ns->netmem)
 		buf[0] = 'y';
 
 	return simple_read_from_buffer(data, count, ppos, buf, 2);
@@ -832,18 +832,19 @@ nsim_pp_hold_write(struct file *file, const char __user *data,
 
 	rtnl_lock();
 	ret = count;
-	if (val == !!ns->page)
+	if (val == !!ns->netmem)
 		goto exit;
 
 	if (!netif_running(ns->netdev) && val) {
 		ret = -ENETDOWN;
 	} else if (val) {
-		ns->page = page_pool_dev_alloc_pages(ns->rq[0]->page_pool);
-		if (!ns->page)
+		ns->netmem = page_pool_alloc_netmems(ns->rq[0]->page_pool,
+						     GFP_ATOMIC | __GFP_NOWARN);
+		if (!ns->netmem)
 			ret = -ENOMEM;
 	} else {
-		page_pool_put_full_page(ns->page->pp, ns->page, false);
-		ns->page = NULL;
+		page_pool_put_full_netmem(netmem_get_pp(ns->netmem), ns->netmem, false);
+		ns->netmem = 0;
 	}
 
 exit:
@@ -1068,9 +1069,9 @@ void nsim_destroy(struct netdevsim *ns)
 		nsim_exit_netdevsim(ns);
 
 	/* Put this intentionally late to exercise the orphaning path */
-	if (ns->page) {
-		page_pool_put_full_page(ns->page->pp, ns->page, false);
-		ns->page = NULL;
+	if (ns->netmem) {
+		page_pool_put_full_netmem(netmem_get_pp(ns->netmem), ns->netmem, false);
+		ns->netmem = 0;
 	}
 
 	free_netdev(dev);
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index 809dd29fc5fe..129e005ef577 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -132,7 +132,7 @@ struct netdevsim {
 		struct debugfs_u32_array dfs_ports[2];
 	} udp_ports;
 
-	struct page *page;
+	netmem_ref netmem;
 	struct dentry *pp_dfs;
 	struct dentry *qr_dfs;
 
-- 
2.17.1


