Return-Path: <bpf+bounces-50535-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FC5A29690
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 17:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3F0E16A10B
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 16:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EE21E1020;
	Wed,  5 Feb 2025 16:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rvmjy2By"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333C3193436;
	Wed,  5 Feb 2025 16:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738774003; cv=none; b=ZsTUEeSCm6zFrMcCtabeeFq6/Exn+/fZnerml4A5l47+pv8CCVC7AWSp90NmfiOmQ/NT0aUPSvcDM4xQfC9K0xuvhhpd/35zZriUB7MUCAAzUxPYhfgqBT9QrRha2AsDVka5GapRiySYaGfCRaAK0NrPddavrazrJVeaGgArOMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738774003; c=relaxed/simple;
	bh=pNrR2W7p5Cymu5iJeU3N2zOhtm5FwBszG3XFDlaYD9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UNaLcnreHN9Hs+k1oQYBOw8UujOI6WLlDgssxML3OlcQgGCdZeNUYnbdtFbQgxjWvnZHQr0oVgJZNEtRRg/0E7J5KNVooNRQI1XFdMjjHR8PDNpZ6wUGzfN9UQmeGnqU1ZhkGJzx6iYpeVMbRORI9LiDLVzv1dnoEjKBfnRDqDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rvmjy2By; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738774002; x=1770310002;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pNrR2W7p5Cymu5iJeU3N2zOhtm5FwBszG3XFDlaYD9s=;
  b=Rvmjy2ByVPLbVhFDHEOl4uKKrMoEGPmBCGJ+rgEEGWnOEGhM0Y5bZogG
   FC45yESQGoAh7QRCg+l0h9BlLW8nk/7eU+M1id8+rjZpcNWvhmlW5X3Xo
   A+qsCn3kXnKoyCrfVW3+54cyezTllouiI41VNmpyLuNo8mdJW9CriVNCG
   m2lbczhxIaslTdpyJz3bUlSJh3lSEouwORq9Jd7rMjNW+ivB4JUeCSSS8
   rbwFj0ChTdGQXy/VN4crlFo0vtK7JZg0HCbQ/H2VpqOj+AVEmcCt5k+Tr
   G/aCWWn+BfK25NstrFrsT7PQXe0l2s7ak6nxWVBaHTV8gSQGyzHC06W7q
   g==;
X-CSE-ConnectionGUID: CkAeoDpEQ0eyNtApouhjAg==
X-CSE-MsgGUID: nQOtDxDHR7WUMyIT7hVH+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="50741097"
X-IronPort-AV: E=Sophos;i="6.13,262,1732608000"; 
   d="scan'208";a="50741097"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 08:39:50 -0800
X-CSE-ConnectionGUID: Hx5YOSF3RtGDDwCEkKGRAw==
X-CSE-MsgGUID: 1++oW2AiRaeDg/rcz8gpCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,262,1732608000"; 
   d="scan'208";a="110741704"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa009.jf.intel.com with ESMTP; 05 Feb 2025 08:39:45 -0800
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
Subject: [PATCH net-next v4 2/8] net: gro: expose GRO init/cleanup to use outside of NAPI
Date: Wed,  5 Feb 2025 17:36:03 +0100
Message-ID: <20250205163609.3208829-3-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205163609.3208829-1-aleksander.lobakin@intel.com>
References: <20250205163609.3208829-1-aleksander.lobakin@intel.com>
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
index ca3dc42b17af..b5feba84fa4e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6771,17 +6771,6 @@ static enum hrtimer_restart napi_watchdog(struct hrtimer *timer)
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
@@ -6928,10 +6917,8 @@ void netif_napi_add_weight_locked(struct net_device *dev,
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
@@ -7045,19 +7032,6 @@ void napi_enable(struct napi_struct *n)
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
 void __netif_napi_del_locked(struct napi_struct *napi)
 {
@@ -7077,8 +7051,7 @@ void __netif_napi_del_locked(struct napi_struct *napi)
 	list_del_rcu(&napi->dev_list);
 	napi_free_frags(napi);
 
-	flush_gro_hash(napi);
-	napi->gro.bitmask = 0;
+	gro_cleanup(&napi->gro);
 
 	if (napi->thread) {
 		kthread_stop(napi->thread);
@@ -12507,7 +12480,7 @@ static int __init net_dev_init(void)
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
2.48.1


