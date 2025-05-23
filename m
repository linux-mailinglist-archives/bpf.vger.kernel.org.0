Return-Path: <bpf+bounces-58813-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8012BAC1AA3
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 05:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC9A8A46EE7
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 03:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9AE27932D;
	Fri, 23 May 2025 03:26:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E8D2494C2;
	Fri, 23 May 2025 03:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747970791; cv=none; b=Cvnkhdc/1By2D1mHwnnXUVTF5jEHac1A2KMidzj5U1n98o3iSdvRWKcD9xcmgAMyqAGtv2wf6fXiL8P2CO637HQguH0xJCTqBclWx+0GMmpiim+/bcvG8crmrmc2tJ3lzIuDlxEt07fJjF9vIs9AzUGQcWmaa4zKYJSSjyvrDo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747970791; c=relaxed/simple;
	bh=Z3JJeNdwGBejhySVSY6ZldGF6m28wstyI2xRaKuKRmY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=CWGgVpdu6QyljTbZ8BzWkGfIH5MUY9dtBftYJB8qz4PsSMn1pm75B5lJba496eJT3iGEldzIPCA9qdD9COlPx6E7tYCC1i6PtnUAiVvETaMF+2AbAs0mQh7NXmVgJj/3khoOihQxS/0RnByqfNQb0CvcPWMWZD4/KaMvh8i4AaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-16-682feadce21a
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
Subject: [PATCH 17/18] netdevsim: use netmem descriptor and APIs for page pool
Date: Fri, 23 May 2025 12:26:08 +0900
Message-Id: <20250523032609.16334-18-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250523032609.16334-1-byungchul@sk.com>
References: <20250523032609.16334-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAz2Ra0hTcRjG+++cnXOcrg5L659h0UAjIW+ZvIWUn+oEYUXQhyJ15KEtr2xq
	0y6YSZqpWXYxWzSpzBvMluk001zzRkKmacvykqKSeMtbuinmlPr243mf53k/PAwhMZHOjCIy
	hldGysKllIgUjTnk7e4e8ZR7GTLtQKMroaB4Xg0v+wxC0BSVI5hZ+E7DtKmRgmd5cwRoPiWT
	MKuzEDDY0E9Db/4QCdUpFQT0326iICPZSkCSoUAAreWZQrhneUFARWIfDe1VGgp6SpaFMGTM
	IKE5t5CE3swAaNBugrmPowhMugoBzKU/oSC7TUvBQHIvgrYP/SQ8vpaJQFdjFoJ1XkMF7ODK
	Cr8JuMrcbprT6mO51wXuXJq5jeD0RTcpTj91l+Z+dFZTXFOOleQqDdMCLuP6OMX9HuwiuYma
	DorTlXWQXIvWRHPT+m3H2dMi/1A+XBHHKz0PhIjkk8mviOghibqivFuQiMo2pCE7BrO+eOBN
	IfWfDc0CG1PsTmw2LxA2dmS98XR/I5mGRAzBjgvxoMa6YmKYjWwg1lku2zwk64qfzBQjG4tZ
	P1yYs8aY3Y6LS9+v9tit6Fk9s6u/JOxe/PZLF23rxOwsjZfud9BrgS24rsBMZiGxFq0rQhJF
	ZFyETBHu6yGPj1SoPc5FRejRyrb5VxbPGNBU60kjYhkkdRAbRJ5yiVAWp4qPMCLMEFJHcf2Q
	h1wiDpXFJ/DKqGBlbDivMqKtDCndLPaZuxgqYc/LYvgwno/mlf+uAsbOORGlf67EgXssbi6K
	E3fqqoKEj5L+DGepamsjLvChqW5+B9P9Lz2dt5+4kdvpO5y4vEvd0ONoPVUzonXbt5h99FBL
	UIiTfe2vgnZVfemDh0fG3MJwgsVV+s57SYRSnVyeG3/6HPtaHyzb7y0NXH/W63Cj0pTRMFk9
	erX4liCPxXU9KVJSJZd5uxNKlewvGfoLdNcCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzXRa0hTcRgG8P47Z2fH1fA4RQ9GGYNIBJ2Kl1e6YPShQ4KEFtaQcuShLTe1
	TdccRpqLUnJpFxTbYGV5x9U0N0tGTfNCA0szlnlDcYSEaV7yRuWKvv143ofny0tiwno8mJRn
	57GqbKlCRPBxfvLBkvCxObEssmorHoyWFgKa17RQP2XngrGpA8Hy+hceLPX0EVD7aBUD46Ae
	hxXLBgazvdM8mKzz4NB104bB9J1+Asr1mxhctzdwoNs0wIX3HQYu3N94ioGtaIoHwy+NBEy0
	/OaCx1mOw0BNIw6ThkToNQfC6rtvCHosNg6s3jYRcG/ITMCMfhLBUPc0Dg+LDQgsDjcXNteM
	RKKIaW/8zGE6a8Z5jNmaz7Q1hDFl7iGMsTaVEoz1x10eM/api2D6qzdxptO+xGHKS+YJZnF2
	FGe+O0YIpvbrAoextI/gjMvcwzvpJ+EfymQVcg2rEh/J4MsW9M+xXI9Qa+sY5xShdt8y5EPS
	VAw9Yx/geE1QB2i3ex3zOoCKopem+/AyxCcxap5Lzxo3t0sk6U8l05aNQm8Hp/bTpuVm5LWA
	iqMbq/+ZpkLo5mev/+74bOcVEyuE10Iqln71cZRXgfhmtKMJBcizNUqpXBEboc6SFWTLtREX
	cpRWtP2+uqtblXa0PHzciSgSiXYJQpVimZAr1agLlE5Ek5goQPDWEyETCjKlBTpWlXNela9g
	1U60m8RFQYITaWyGkLoozWOzWDaXVf2/ckif4CIkkcRJgx4Hazs1rUn5tTHhpWfOnWqbE/g+
	ie8fzJ8LytVPRrcuTjxI25eUEvqrOF0RuBdSb3GV9AtV3LJDQqVeflOYFuk6ZipKCSu4NnzJ
	ddZ/Z4IzTVkZRN4wiw0x6a5F6+GQvhEWTBlVR3Vuw1howk/bhs7ht+eDUnc6+ooIV8ukUWGY
	Si39A8t6AHa6AgAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

To simplify struct page, the effort to seperate its own descriptor from
struct page is required and the work for page pool is on going.

Use netmem descriptor and APIs for page pool in netdevsim code.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 drivers/net/netdevsim/netdev.c    | 18 +++++++++---------
 drivers/net/netdevsim/netdevsim.h |  2 +-
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index af545d42961c..c550a234807c 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -821,7 +821,7 @@ nsim_pp_hold_read(struct file *file, char __user *data,
 	struct netdevsim *ns = file->private_data;
 	char buf[3] = "n\n";
 
-	if (ns->page)
+	if (ns->netmem)
 		buf[0] = 'y';
 
 	return simple_read_from_buffer(data, count, ppos, buf, 2);
@@ -841,18 +841,18 @@ nsim_pp_hold_write(struct file *file, const char __user *data,
 
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
+		ns->netmem = page_pool_dev_alloc_netmem(ns->rq[0]->page_pool, NULL, NULL);
+		if (!ns->netmem)
 			ret = -ENOMEM;
 	} else {
-		page_pool_put_full_page(ns->page->pp, ns->page, false);
-		ns->page = NULL;
+		page_pool_put_full_netmem(netmem_get_pp(ns->netmem), ns->netmem, false);
+		ns->netmem = 0;
 	}
 
 exit:
@@ -1077,9 +1077,9 @@ void nsim_destroy(struct netdevsim *ns)
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


