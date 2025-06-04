Return-Path: <bpf+bounces-59625-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F09ACD62C
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 04:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B163189DF26
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 02:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1689B259C87;
	Wed,  4 Jun 2025 02:53:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FD0215787;
	Wed,  4 Jun 2025 02:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749005594; cv=none; b=qW7ZXH9tAPy3cT5I/TufajX3Ir2N/+QxnOf8K1DzUPZLxOnbgz5Xp6v82rcT+oQIM7N0k1mOhcL/FGWAJiEsTqAMMsI6T1aU1xKw5BMrEN2xwDoTYkS/su2XtLz5j0CDfXhcuYXlQ26UpWxpTlNJ7fjX3IOW9+oLUL0kuopzZjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749005594; c=relaxed/simple;
	bh=ygNVJUYQK6Yi1iMpKKRah0NggVF+VUhUMmtnS25CpYQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=X0iAZxtQPV255qQZeQdjVXfJGgIjNm5Qssm/4XZ+kYH6OkmykSyT/CGxfiRZn5+rqsH7iMW4LchXRoD2TsM5VnMxOlemw7WAXy2X+9zf+0RKCi4wucHO0NW/rZGQ2a8csf1+GkmtQthPvJfrDKbOYRj1oB9JYKim/HYpU3+1NTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-51-683fb50a4c3d
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
Subject: [RFC v4 15/18] netdevsim: use netmem descriptor and APIs for page pool
Date: Wed,  4 Jun 2025 11:52:43 +0900
Message-Id: <20250604025246.61616-16-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250604025246.61616-1-byungchul@sk.com>
References: <20250604025246.61616-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRW0iTcRjG/e87bdPRxzT7MkqaSmXYQTRfoiwi4YsustNFGdTIr7bals1p
	WyDMstNoS0yxdNrsYJ5otkxnmeg8o5WZ2SpNMWY3ZelqmiblFO9+/J7nfW5ePiZuwYP4cpWG
	U6ukCgkpxIXf/YoihE+3yTbY80LBbK0goXxSCw+H7ASYy6oR/PrziQJ3cxsJ94o8GJhfZ+Dw
	2zqFgat1mILB4hEc6q7UYDB8o50EY8Y0BhfsJTzorjYRkD31AIMa/RAFb5+ZSfhc8Y+AEYcR
	h468UhwGTduh1RIIns5vCJqtNTzwXC8g4WaPhYQvGYMIepqGcchPNyGw1jsJmJ40k9tXslWl
	H3hsbd4AxVpsKeyTknDW4OzBWFvZNZK1jWdRbH9fHcm235rG2Vq7m8caL46S7JjrI87+qH9H
	staqdzjbZWmmWLdtRTx9WLglkVPIUzn1+thjQllXr4GXpPfXeromMD1qXGRAAj5DRzHPs1/g
	C/yo4yrhZZJexTidfzAvB9AbGfdw22xHyMfoUYJxmad53sCf3sOkv5xAXsbpMKYpJ2vOi+hN
	zLUWFzY/GsyUVzbMsWDW94/mznXEdDRjtPdi3lGG/k0x+TkD1PzBUqaxxIlnIpEF+ZQhsVyV
	qpTKFVHrZDqVXLvu+BmlDc0+tzjtb4IdjXfvdyCajyR+Int/rExMSFOTdUoHYviYJEAUvGZW
	iRKluvOc+sxRdYqCS3agZXxcskQU6TmXKKZPSjXcaY5L4tQLKY8vCNIj7Zv40JpHMVrfzspV
	u1MaihwtOXGxVPerwqwZ8mK2pmvnlp/MvvDu8BmDPvf+geXr5asbcwnxqCBxKuKQUhS4tu/S
	EdPmEN/A0+axJ4sf38Zerz4V+dXwK5qKcezSpUUWKsJcmtjGqrq4N9ydTNHBhLr3PpqzO+7W
	Xt5bELK15MRWCZ4sk24Mx9TJ0v+osR7Q2AIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTcRyG9985O5vL1XHOOpkgDZZkZElqPygvfdFThPlBCgzKkYc21Gmb
	2jSCmUYpzlILSyfMJJtTmizTLURrXkdG5Q2z1WyyESF2UeetmzP69vC8L++Xl4cJDXgwT67I
	Y5QKaZaY4OP85CMl+/lP42UHG8aDQGdqI6B1RQ2PZiwc0Bk7ESyuvufCQv8QAU2NXgx0r0tx
	WDKtYeAedHHB2ezBoftGFwauW8MEaEvXMbhmMbChr8HOgTedlRy4s/YQgy7NDBfGnukI+Nj2
	hwMemxYHe10LDs7KBBjUbwfvyzkE/aYuNngrGgioGdUTMFvqRDDa58KhvrgSgalnigPrKzoi
	QUx3tLxj09a6D1xab86nnxjC6fKpUYw2G8sI2vyjmks7JrsJevjeOk5bLQtsWlsyT9Df3dM4
	/bVngqCbPn9j06aOCZwe0fdzUwLS+EczmCx5AaM8EJfOl42Ml7NzNYFq78gypkEvtpUjPx5F
	RlGP7Tc5PibIMGpqahXzsYiMpBZcQ3g54vMwcp5DuXXrbF8QSJ6iil8tIx/jpITqu1u96QVk
	DFU24Mb+jYZSre3PN9lvwzvmazc7QjKa0lrGsduIr0csIxLJFQXZUnlWdIQqU1aokKsjLuRk
	m9HGf81Xf1ZZ0OJYkg2RPCT2F1gccTIhR1qgKsy2IYqHiUWC0L0bSpAhLSxilDnnlflZjMqG
	dvFw8Q7BiTNMupC8KM1jMhkml1H+T9k8v2ANurQUP1k1W8MkOlnHVqt+nc0YCcD2iY4b268j
	f0k0GsrcmZprPX1lutlSUa1OPEwtzbB059K3hkWyeoPao+wP3hqkw7OiaU9sUbL9S4wkJM2V
	FLtlefZTCPd+/YA1pfZk6uU9NfUxPQ5P2YC4yMTgrl6npFFwqHb3nPp3Z7dOjKtk0shwTKmS
	/gVB9akEuwIAAA==
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
index af545d42961c..d134a6195bfa 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -821,7 +821,7 @@ nsim_pp_hold_read(struct file *file, char __user *data,
 	struct netdevsim *ns = file->private_data;
 	char buf[3] = "n\n";
 
-	if (ns->page)
+	if (ns->netmem)
 		buf[0] = 'y';
 
 	return simple_read_from_buffer(data, count, ppos, buf, 2);
@@ -841,18 +841,19 @@ nsim_pp_hold_write(struct file *file, const char __user *data,
 
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
@@ -1077,9 +1078,9 @@ void nsim_destroy(struct netdevsim *ns)
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
index d04401f0bdf7..1dc51468a50c 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -138,7 +138,7 @@ struct netdevsim {
 		struct debugfs_u32_array dfs_ports[2];
 	} udp_ports;
 
-	struct page *page;
+	netmem_ref netmem;
 	struct dentry *pp_dfs;
 	struct dentry *qr_dfs;
 
-- 
2.17.1


