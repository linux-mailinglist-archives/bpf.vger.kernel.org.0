Return-Path: <bpf+bounces-59250-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D82AC7649
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 05:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80BB0A434E3
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 03:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B195A25C81B;
	Thu, 29 May 2025 03:11:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDDF2505D6;
	Thu, 29 May 2025 03:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748488274; cv=none; b=S4ZBqPJGu3VHaXmXFzy5aaDUtQJ0IyjHWZzwZDMGe0xzrK2jPZKDznSV3TWOMxt3duMUdYeyrcXgOay9hiMW4o4Z3ssOkoPDWgrtctKjK/ak00ipQFZqn9B7sZ+rT/U+x72iwkuY/l7GeTRxqBMcE3oJo6Y/xHpwWm55e/TDgSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748488274; c=relaxed/simple;
	bh=ygNVJUYQK6Yi1iMpKKRah0NggVF+VUhUMmtnS25CpYQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=sEDeAolt1CAhGgzqox2q5K8G6FyUeK4R0SiW3ybxopGK9i9oPsKvBFcfgrhPRF6ou7agcBL0idrFBz89zZHITx++D0XWUGlKlnxQE+Hc8rEZvKsG0PBYnhsR8O5nOSKr9x80RPQKt5zrqt+PYRSX4uLJIPE8T01ew3pswqicwLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-5d-6837d042a3a8
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
Subject: [RFC v3 15/18] netdevsim: use netmem descriptor and APIs for page pool
Date: Thu, 29 May 2025 12:10:44 +0900
Message-Id: <20250529031047.7587-16-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250529031047.7587-1-byungchul@sk.com>
References: <20250529031047.7587-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTYRjHfXfec3a2Gh2m1MmiaGGKoGaYPkWlRB9ewuhGFJXYyEMbeWNe
	mkJgZWQzTcqkcsHsYl6bLPGeqWlZGQ3TWmlp060+1CSnM51gbtW3H///8/yeDw9LyXuwP6tO
	Thc0ycpEBSPF0p9Ly0J2mqNUGycebAG9sYaB6t9aeDjaRIO+qgHB1OyQGJzdLxi4V+aiQP82
	F8O0cY4C23OrGEbK7RjaLjVSYL3ay0BBrpuC800VIjA3FNJQPPeAgsacUTG8a9Ez8KVmgQZ7
	VwGGl7crMYwUxsBzw3Jwvf6BoNvYKALXlTsMXO83MDCWO4Kg/5kVQ+m5QgTGdgsN7t96JmYd
	qa/8KCLNtz+LicGUQR5XBBOdpZ8ipqrLDDFNXhOT4fdtDOm96cakuckpIgUXHAz5ZfuEyUT7
	IEOM9YOY9Bm6xcRpWrOPOyrdliAkqjMFTdiOE1JV34BOlJrjq3X1zVA5qHOZDklYnovgbWPD
	6D+PlD6iPMxwgbzFMutlPy6cd1pfYB2SshTnoHmb3i3yFL7cXv7G+DDtYcwF8MWl1d5cxm3m
	ne6if9K1fHVdh1ckWcxLHpd4Z+SLx27pOhmPlOemxfzQrTf478JKvrPCgouQzIB8qpBcnZyZ
	pFQnRoSqspLV2tCTKUkmtPjc8rPzx5rQpPlgF+JYpFgq60VRKjmtzEzLSupCPEsp/GTnoyNV
	clmCMitb0KTEazIShbQutIrFihWyTa4zCXLulDJdOC0IqYLmfytiJf456EhQ/GGypvW0+Vhr
	6OCr+YZa9prkwF7U4yPZs7uv9W7ZIQcd5WPft4QtLLo/GGudeRo4Fbee/lZnn9w6Nd32hMsN
	GKhnLcu4uEinnz6k4Kv2fnZMrVm3YXK/EL4tYHz7XcfqBd93z77n9xyPjs3b9aGjtTgvaMhh
	y+faW/IvhoUpcJpKGR5MadKUfwDZC2ws2AIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRe0hTcRzF++3e3T1odZtSN/tDGpZk5YM0v1SWCOolMIUEMYgcemlDnbKp
	aWAslaKVj0qtdNJCMl+5nMNNEWsqOtFQ1IWWOd+F6Czne2Wp0X8fzjmc88fhYsJK3IUrlaUw
	cpk4QUTwcf6V89mng/r9Jd6LxlOg1tYSULOeDm/GjWxQVzciWN74wgF7RxcB5a9WMVD35eCw
	ot3EYKZzkgPWilkcWu4bMJjMNxOQm+PAIMtYyYL2sm429DfmsaFw8zUGBuU4Bwab1QSM1f5h
	w2xbLg7dJVU4WPMCoVNzEFZ75hF0aA0sWH1URsDTAQ0BUzlWBAPtkziU3s1DoG0dZoNjXU0E
	imh91QiLbir5yqE1ulS6odKDVg0PYLSu+gFB65aecOjRTy0EbX7uwOkmo51F52bbCPrnzGec
	Xmy1EHT59x8sWqu34HSvpoMTceAa/0IckyBNY+ReF2P4kt4hFStZ6ZS+2ruGKZFpvwrxuBTp
	S1lL67AdJkh3anh4Y5edSR/KPtmFqxCfi5E2NjWjdrB2DCcynCqaHmXvME4eowpLa3Z1AelH
	2R0F6F+pK1Xz7sNuEW9bL24o3s0It8deqExEAeJr0J5q5CyVpSWKpQl+nop4SYZMmu4Zm5So
	Q9v/VWT+emxEy4OhbYjkItFegRn5S4RscZoiI7ENUVxM5CzIunRWIhTEiTNuM/KkG/LUBEbR
	ho5wcdEhweUoJkZI3hSnMPEMk8zI/7ssLs9FiUqKgpPu2PXBaF9IVv3D+QXe+63NyHP3Al31
	Zs108yw/3/qyJ+xqU5SkzGInomPDDaqYk2eMNkthsGlia63Z9/pY//wc3zRXnOn27aOHe1hd
	SNjvib7ZkeSUUKelo8+sG7WXD+PG6OORQSsLEUPe9nKZ/1RxwFveCUd9gM3N65YIV0jEPh6Y
	XCH+C5hcr2+7AgAA
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


