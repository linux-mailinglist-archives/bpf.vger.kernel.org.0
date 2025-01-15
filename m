Return-Path: <bpf+bounces-48938-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D002A12723
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 16:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AAAC3A448D
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 15:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4586115853A;
	Wed, 15 Jan 2025 15:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cT7cYTlu"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE231448DC;
	Wed, 15 Jan 2025 15:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736954390; cv=none; b=qW2HwlfZOgtVVpGh/AsCTu37gJ5jZYSQ77xHITLXIdIeviM203BVmSs2bEEJyCHKkDMj5THXMT0DkJy97SavpEIWr8Ki82iEN8HOqyC1X1NTJNLBb9KOSAGTtmTkKpg/F/HULekOsyPyz6MXqzpx4LHRYF4pY6fozct4VGGtncI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736954390; c=relaxed/simple;
	bh=hvY65ELOVizwVM0MFYKXWcYas5ed242LEd5vH8fd0BU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cHKfmkUqd/blz5WQfZ2wBc3viSw5rxgU9zr3PrLbIXZ7EKgjJHnT7364KH7MmKKscXwkVkYZRfMLTSPFxuQK1d+JQ31ulDTK2qhbAaIHOwifKtvZ7NOjdvPZeJjZHgwCzu4vyaeF2sWY/rr5ocm7GzSiybLfOJHXSx/jUvWUIqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cT7cYTlu; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736954389; x=1768490389;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hvY65ELOVizwVM0MFYKXWcYas5ed242LEd5vH8fd0BU=;
  b=cT7cYTlu9eiTqzQJhxV7GkGJC3Q6cFdZ9IZ7Ttu8WYdhKGLWMrUhFtUi
   QwRHMhU9oIimyvy7EzF40P09SlO0OoZtKgw7F5B9D6zAgJlSO/Gv+IZLp
   VMifVLjNo4Oy4rw+TMsIbJ0F5Rw2DatPIUrq8btqjHtX+lx91TsPuDUXq
   c+8VP5I6zJx4faq9HmTQXJ1ivugMQgS+AndkK9xB9LMYuDkxhruwXhsKH
   lczIwv0qoLB0n78PkmcIF1pOsFkaZEewnfO2GnP8Qs+wVY8dPuK3AAuJ1
   ycpsi75Xg+W3YZLivC33RCWOKiUGhjBLvtKgvSXsIQENTKJt4j4MyrJ+9
   w==;
X-CSE-ConnectionGUID: RSCpbbjDQg2/Pix8z9iDhA==
X-CSE-MsgGUID: NDwFD8kWSmiZ1N68SZ9Kzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="37451780"
X-IronPort-AV: E=Sophos;i="6.13,206,1732608000"; 
   d="scan'208";a="37451780"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 07:19:49 -0800
X-CSE-ConnectionGUID: slY4WwgzSDWpibHXw/DvKw==
X-CSE-MsgGUID: yjnBfjSjSKWdXlEYRN6luw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,206,1732608000"; 
   d="scan'208";a="105116653"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa007.fm.intel.com with ESMTP; 15 Jan 2025 07:19:45 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Daniel Xu <dxu@dxuuu.xyz>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 2/8] net: gro: expose GRO init/cleanup to use outside of NAPI
Date: Wed, 15 Jan 2025 16:18:55 +0100
Message-ID: <20250115151901.2063909-3-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250115151901.2063909-1-aleksander.lobakin@intel.com>
References: <20250115151901.2063909-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make GRO init and cleanup functions global to be able to use GRO
without a NAPI instance. Taking into account already global gro_flush(),
it's now fully usable standalone.
New functions are not exported, since they're not supposed to be used
outside of the kernel core code.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Tested-by: Daniel Xu <dxu@dxuuu.xyz>
---
 include/net/gro.h |  3 +++
 net/core/dev.c    | 33 +++------------------------------
 net/core/gro.c    | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 30 deletions(-)

diff --git a/include/net/gro.h b/include/net/gro.h
index 7aad366452d6..343d5afe7c9e 100644
--- a/include/net/gro.h
+++ b/include/net/gro.h
@@ -543,6 +543,9 @@ static inline void gro_normal_one(struct gro_node *gro, struct sk_buff *skb,
 		gro_normal_list(gro);
 }
 
+void gro_init(struct gro_node *gro);
+void gro_cleanup(struct gro_node *gro);
+
 /* This function is the alternative of 'inet_iif' and 'inet_sdif'
  * functions in case we can not rely on fields of IPCB.
  *
diff --git a/net/core/dev.c b/net/core/dev.c
index afa5e6e7eb3f..ed1b00b16916 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6652,17 +6652,6 @@ static enum hrtimer_restart napi_watchdog(struct hrtimer *timer)
 	return HRTIMER_NORESTART;
 }
 
-static void init_gro_hash(struct napi_struct *napi)
-{
-	int i;
-
-	for (i = 0; i < GRO_HASH_BUCKETS; i++) {
-		INIT_LIST_HEAD(&napi->gro.hash[i].list);
-		napi->gro.hash[i].count = 0;
-	}
-	napi->gro.bitmask = 0;
-}
-
 int dev_set_threaded(struct net_device *dev, bool threaded)
 {
 	struct napi_struct *napi;
@@ -6804,10 +6793,8 @@ void netif_napi_add_weight(struct net_device *dev, struct napi_struct *napi,
 	INIT_HLIST_NODE(&napi->napi_hash_node);
 	hrtimer_init(&napi->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED);
 	napi->timer.function = napi_watchdog;
-	init_gro_hash(napi);
+	gro_init(&napi->gro);
 	napi->skb = NULL;
-	INIT_LIST_HEAD(&napi->gro.rx_list);
-	napi->gro.rx_count = 0;
 	napi->poll = poll;
 	if (weight > NAPI_POLL_WEIGHT)
 		netdev_err_once(dev, "%s() called with weight %d\n", __func__,
@@ -6894,19 +6881,6 @@ void napi_enable(struct napi_struct *n)
 }
 EXPORT_SYMBOL(napi_enable);
 
-static void flush_gro_hash(struct napi_struct *napi)
-{
-	int i;
-
-	for (i = 0; i < GRO_HASH_BUCKETS; i++) {
-		struct sk_buff *skb, *n;
-
-		list_for_each_entry_safe(skb, n, &napi->gro.hash[i].list, list)
-			kfree_skb(skb);
-		napi->gro.hash[i].count = 0;
-	}
-}
-
 /* Must be called in process context */
 void __netif_napi_del(struct napi_struct *napi)
 {
@@ -6921,8 +6895,7 @@ void __netif_napi_del(struct napi_struct *napi)
 	list_del_rcu(&napi->dev_list);
 	napi_free_frags(napi);
 
-	flush_gro_hash(napi);
-	napi->gro.bitmask = 0;
+	gro_cleanup(&napi->gro);
 
 	if (napi->thread) {
 		kthread_stop(napi->thread);
@@ -12287,7 +12260,7 @@ static int __init net_dev_init(void)
 		INIT_CSD(&sd->defer_csd, trigger_rx_softirq, sd);
 		spin_lock_init(&sd->defer_lock);
 
-		init_gro_hash(&sd->backlog);
+		gro_init(&sd->backlog.gro);
 		sd->backlog.poll = process_backlog;
 		sd->backlog.weight = weight_p;
 		INIT_LIST_HEAD(&sd->backlog.poll_list);
diff --git a/net/core/gro.c b/net/core/gro.c
index 77ec10d9cd43..d8e929ad7538 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -793,3 +793,35 @@ __sum16 __skb_gro_checksum_complete(struct sk_buff *skb)
 	return sum;
 }
 EXPORT_SYMBOL(__skb_gro_checksum_complete);
+
+void gro_init(struct gro_node *gro)
+{
+	for (u32 i = 0; i < GRO_HASH_BUCKETS; i++) {
+		INIT_LIST_HEAD(&gro->hash[i].list);
+		gro->hash[i].count = 0;
+	}
+
+	gro->bitmask = 0;
+
+	INIT_LIST_HEAD(&gro->rx_list);
+	gro->rx_count = 0;
+}
+
+void gro_cleanup(struct gro_node *gro)
+{
+	struct sk_buff *skb, *n;
+
+	for (u32 i = 0; i < GRO_HASH_BUCKETS; i++) {
+		list_for_each_entry_safe(skb, n, &gro->hash[i].list, list)
+			kfree_skb(skb);
+
+		gro->hash[i].count = 0;
+	}
+
+	gro->bitmask = 0;
+
+	list_for_each_entry_safe(skb, n, &gro->rx_list, list)
+		kfree_skb(skb);
+
+	gro->rx_count = 0;
+}
-- 
2.48.0


