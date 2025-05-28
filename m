Return-Path: <bpf+bounces-59071-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 105CBAC5F8D
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 04:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C9494C1526
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 02:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B22B21C167;
	Wed, 28 May 2025 02:29:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C890D1F0999;
	Wed, 28 May 2025 02:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748399372; cv=none; b=Lu9o6ahRWuYNzfLdiJ8JY+k1GKurbUWdzaA8YuzokkPuV8M8rbzO9QEzoZNPtoT1snD9yuSSz+6jdViQMEFaZcDD8kQMOb0G3bwDx8lPKfP1J3EIEOloZvh+hFex8W7M8tSqXBLmwy5HJKhguZoJmzkSFgQQZ26qfL4Lmu1yuwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748399372; c=relaxed/simple;
	bh=ygNVJUYQK6Yi1iMpKKRah0NggVF+VUhUMmtnS25CpYQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=cSILgF74b+irFovEi4y9GkPjAkdZK+I8Kkk89MiFVDmsYgsYpduNlhc9sp5KxSvEi1jWaLN8yf4sImFPrTvu8GGdBLD3rRkC/ud7E95LahniW81wvD2t9Qdfw/BLW/HNNKupwwmbC8IzF+mlB2wJXGMkNLp3YJtzc10khGz8HHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-b3-68367502ace5
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
Subject: [PATCH v2 15/16] netdevsim: use netmem descriptor and APIs for page pool
Date: Wed, 28 May 2025 11:29:10 +0900
Message-Id: <20250528022911.73453-16-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250528022911.73453-1-byungchul@sk.com>
References: <20250528022911.73453-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTcRiH+59zds5xOTpMqWNFl0E3KU1TeaMoP9U/uhMFGlQrD241p8xL
	ziiWCtK8RZZZLZyEd2E276Kma15SIzOrWZq20IpM09UyF5Qr/Pbw/F6eLy9LSq3UclapjhM0
	arlKRosp8VfPgi1EfIhiq701AAymChrKZxOheLReBIayWgTff71lwGHtpOFBgZMEw7NUCn6Y
	5kgY67AzMFI0TkFTWh0J9uwuGjJTXSQk15cQ0FebJYKbc4Uk1OlGGXjRaKDhXcUfEYxbMil4
	creUgpGsUOgwLgVnzwQCq6mOAGfGfRpy+o00fEgdQdD/2E7BvatZCEwtNhG4Zg106FpcXTpI
	4Ia7www2muNxVYkv1tv6SWwuu0Zj88wNBg+9aqJxV56Lwg31DgJnpkzSeHrsDYWnWl7S2FT9
	ksK9RiuDHeZVR7hw8c4IQaVMEDT+u86IFb0DeiJG55Xo7P1J6lDbEj3yYHkuiB+tGaAX+JEl
	BbmZ5jbwNtsv0s3eXADvsHdSeiRmSW5SxI8ZXIR78OKO8jntnYybKW4df8c5+M9LuBA+v6iH
	+R9dzZdXts6HWNZj3rcPnXNrKRfMT6WbkLvJcz8YPvnbLfL/vQ/fVmKjriOJES0qQ1KlOiFK
	rlQF+Sm0amWi37noKDOa/23R5d8n69FM3zEL4lgk85TgymCFVCRPiNVGWRDPkjJvSfLuEIVU
	EiHXJgma6NOaeJUQa0ErWEq2TBLovBgh5SLlccIFQYgRNAsrwXos16GDSWXapz5xe3UfK19v
	25Pb+ipsZXc0r+mfyXlQ+GVzzdnnpc2pjuNCYLr+1G1a/bkm17+q2fhpeHDHJs/DdWHlxZ/S
	8j3b8qabg6sa91WcL+6OTD90M3HzxMTD7DWqS+HarN4DAev2BzuMVlP8fuPG7e8Ppa+flvrG
	XMkgkk64Fs9hGRWrkAf4kppY+V+ZsrI/1wIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTYRyHe8/d5eq4rA72IVh0wcoyL/whKyGit6IwMIXIcumpDeeUTc11
	gZWLcqV2I8omLsSVF5hO02mStaYuGiSaoWkpK8UuZKmtclG5om8Pzw+eLz+OlN2hwjiVJkfU
	ahRqOSOhJHs2FqwlcmOV6weHl4LZVstAzfd8uDPioMFc3YRg+scgC1OuLgYqbvtIMD8zUvDV
	NkPCaKeXhWHrGAVt55pJ8Ja4GSgy+kk447hLwOOyJzR0NxXTcG2mkoRmwwgLva1mBl7X/qZh
	zFlEwZPSKgqGi+Oh07IIfE8/InDZmgnwXSxj4GqPhYE3xmEEPY+9FNw6XYzA9qCfBv93MxMv
	x41VAwRuKX3FYos9FzfcDcem/h4S26sLGWyfvMLioRdtDHbf8FO4xTFF4KKCTwz+MvqSwhMP
	+hhcMf6ZwLbGPgp7LC42IWS/JC5dVKvyRO26zakSpee5icg2LMj3eb6RBvRovgkFcQIfLbQ7
	C1CAGX6l0N//gwxwKB8pTHm7KBOScCT/iRZGzX4iMCzg9wpXO7rYAFP8cuGmb+Cvl/KxQrn1
	KfsvulSoqXs4G+K4oFnfMZQW0DI+Rpi4YEOXkMSC5lSjUJUmL1OhUsdE6DKUeo0qPyItK9OO
	Zu+znvp52YGme7c7Ec8hebAU18UoZbQiT6fPdCKBI+Wh0jNbYpUyabpCf1zUZh3S5qpFnRMt
	4Sj5YunOZDFVxh9V5IgZopgtav+vBBcUZkDsKXeIfNkvOkm6Cdd5Pqz3ujfVGysl9etwsGV8
	crV+A+U4GxE194rYuSMq6eDEosRfDfe3phpa31a2u0+6to3IgkuS0xJW7V7yzlO4ZuG57vTD
	8y6d4Ff0ZR+xetvjH17X7ztR3kRnNESfL08sO9YRdS8npe1Ayvj7t7tKEwwVbXFySqdURIaT
	Wp3iDxnZumS6AgAA
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


