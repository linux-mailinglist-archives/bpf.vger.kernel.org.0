Return-Path: <bpf+bounces-52547-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40888A4484C
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 18:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1781881CDB
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 17:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF71519D881;
	Tue, 25 Feb 2025 17:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fH8XuLiL"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39B119992D;
	Tue, 25 Feb 2025 17:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740504283; cv=none; b=HWv/0malNdEPKnT2wtOWfZsFTHbmXsG9VPBO8a9k5dTYwa5kqs4TxrHdcDV0iCgzQuOBn67u+/t1D96jepNRRYWH2V5NCwb9LPsvEICnORqmTDR3rxA9I1Nch+0WjXLzW7ghJiXmHEPB352damp5a8Af5UdpLmrivRrvn/QdJCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740504283; c=relaxed/simple;
	bh=pQJdWRNBZwHK6OqaFnjZoFz/5IDQS+SCAFtxnsNtLuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IGaQl07d3k1lsazVxkbOgQ2z4tONkP8MxX0t3YiVASMIA2nGPO99sfVu8TV0Pt5C+WRXg4+G8sh0t1GLg56djE39d6RtZ42r6xc49EtAsTQz9xPQhZW1peMscLGVH8vmRYhHYGC66SuASnoa9eJFiakNYtP+QmaeJOt5VdWIBw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fH8XuLiL; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740504282; x=1772040282;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pQJdWRNBZwHK6OqaFnjZoFz/5IDQS+SCAFtxnsNtLuY=;
  b=fH8XuLiLhBb6rWFb6H9fBE5nhfgL91/hQO//qzsvxMmxrKgbmaJw2pS/
   Paim4RE2Lu4+Tii3FxGpH8QGIvQkPw+kDK4jgnrMthw1r0XhyY9UTtOPi
   B+a5tmEHvSPk4izJ7lJQICs3HBRVatHdqtIzQmFvG3zsQQ2npdazip3k9
   ANGAreh9baZT9xxz06ElnCSKV5Aew+a+UwZMIfZ3aOwRS7iHSFMNI9pc+
   sJ4juNJdm4p7axqO77cTRJu9s4Ca5wJYYDrbBgxPQJNSHlCN60RIqWCU5
   EQuBVMSxPG4FKYwjgSq5rwoKpaWtBIgUiHumVOaRmr3dDyQORDq1E2Rtu
   A==;
X-CSE-ConnectionGUID: LF8trDYSQt+g1VI5AXrEOw==
X-CSE-MsgGUID: Kyvy2yXGTXCIf2GSlgkmqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="44974099"
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="44974099"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 09:24:41 -0800
X-CSE-ConnectionGUID: /wG95mAmS9KYyDtnylqnqw==
X-CSE-MsgGUID: 9vEUlFs+Si6QW6/yOjc0Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="116256871"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa006.fm.intel.com with ESMTP; 25 Feb 2025 09:24:37 -0800
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
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH net-next v5 2/8] net: gro: expose GRO init/cleanup to use outside of NAPI
Date: Tue, 25 Feb 2025 18:17:44 +0100
Message-ID: <20250225171751.2268401-3-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250225171751.2268401-1-aleksander.lobakin@intel.com>
References: <20250225171751.2268401-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Make GRO init and cleanup functions global to be able to use GRO
without a NAPI instance. Taking into account already global gro_flush(),
it's now fully usable standalone.
New functions are not exported, since they're not supposed to be used
outside of the kernel core code.

Tested-by: Daniel Xu <dxu@dxuuu.xyz>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/gro.h |  3 +++
 net/core/dev.c    | 37 +++----------------------------------
 net/core/gro.c    | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+), 34 deletions(-)

diff --git a/include/net/gro.h b/include/net/gro.h
index 38d70c69ff80..22d3a69e4404 100644
--- a/include/net/gro.h
+++ b/include/net/gro.h
@@ -546,6 +546,9 @@ static inline void gro_normal_one(struct gro_node *gro, struct sk_buff *skb,
 		gro_normal_list(gro);
 }
 
+void gro_init(struct gro_node *gro);
+void gro_cleanup(struct gro_node *gro);
+
 /* This function is the alternative of 'inet_iif' and 'inet_sdif'
  * functions in case we can not rely on fields of IPCB.
  *
diff --git a/net/core/dev.c b/net/core/dev.c
index ef66e8aaca19..5ea1400066cc 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6850,19 +6850,6 @@ static enum hrtimer_restart napi_watchdog(struct hrtimer *timer)
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
-
-	napi->gro.bitmask = 0;
-	napi->gro.cached_napi_id = 0;
-}
-
 int dev_set_threaded(struct net_device *dev, bool threaded)
 {
 	struct napi_struct *napi;
@@ -7026,10 +7013,8 @@ void netif_napi_add_weight_locked(struct net_device *dev,
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
@@ -7143,22 +7128,6 @@ void napi_enable(struct napi_struct *n)
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
-
-	napi->gro.bitmask = 0;
-	napi->gro.cached_napi_id = 0;
-}
-
 /* Must be called in process context */
 void __netif_napi_del_locked(struct napi_struct *napi)
 {
@@ -7178,7 +7147,7 @@ void __netif_napi_del_locked(struct napi_struct *napi)
 	list_del_rcu(&napi->dev_list);
 	napi_free_frags(napi);
 
-	flush_gro_hash(napi);
+	gro_cleanup(&napi->gro);
 
 	if (napi->thread) {
 		kthread_stop(napi->thread);
@@ -12631,7 +12600,7 @@ static int __init net_dev_init(void)
 		INIT_CSD(&sd->defer_csd, trigger_rx_softirq, sd);
 		spin_lock_init(&sd->defer_lock);
 
-		init_gro_hash(&sd->backlog);
+		gro_init(&sd->backlog.gro);
 		sd->backlog.poll = process_backlog;
 		sd->backlog.weight = weight_p;
 		INIT_LIST_HEAD(&sd->backlog.poll_list);
diff --git a/net/core/gro.c b/net/core/gro.c
index 9e1803fdf249..19bd4cdaee3a 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -790,3 +790,37 @@ __sum16 __skb_gro_checksum_complete(struct sk_buff *skb)
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
+	gro->cached_napi_id = 0;
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
+	gro->cached_napi_id = 0;
+
+	list_for_each_entry_safe(skb, n, &gro->rx_list, list)
+		kfree_skb(skb);
+
+	gro->rx_count = 0;
+}
-- 
2.48.1


