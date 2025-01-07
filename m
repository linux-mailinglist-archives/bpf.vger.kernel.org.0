Return-Path: <bpf+bounces-48129-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E99EA0448E
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 16:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E704B3A6D1E
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 15:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF031F4704;
	Tue,  7 Jan 2025 15:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LT759/7b"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA681F3D38;
	Tue,  7 Jan 2025 15:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736263876; cv=none; b=Ssg1dZA+QWuExV4fyqW9Z4hu4cYEMJ26vmhuLYgZgfbOXG7sHbyvtQ/9ucXgysFLSq8fycPpACBzhJUaYjgVe0VljyqGbfUB1xe7fKKmTocDytq1X9IzW4MPP+j5XbCdQiGQLR+Ff/HT04mVpoKEJ2JKVXxgyoxF1EDHSbJlYfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736263876; c=relaxed/simple;
	bh=QEuodkCqCKVlW/pYKwomGb48liH0jo/JBYA7U9wgwjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OD+4u7LosAGoR8udHlFd5X+AWLr8u5knPclH9dnRAWFpNtHdznOFkSTs2mbUcYZ0i8v+YexaiLlvtaEl+of1LCMnUPFt7bEhfo2LpPRYAFfbiYJGyd6o7Yv7eeSUw8t8uZvn+Tk3w8TfMqcMRStNnqzGT01VoxFvYBTnjSYaLLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LT759/7b; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736263874; x=1767799874;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QEuodkCqCKVlW/pYKwomGb48liH0jo/JBYA7U9wgwjg=;
  b=LT759/7bSNN7BA47jVibLPRtr552jChz2zNN529ctGiQ/FmMjM6+WC9S
   sd7Et1yuwk2ha8QOCXBAJo7WN4oQcd0+bMbaIm1LxvNfJSfc1TGDescDx
   +XfXreJ8oGPgzimjSJMxKAnIZ28ttN13Ghypfz8YSgpX1AdN8BxXS1QHE
   mu5YrNPbEecGdFvvEVmS79swre0j1qcAckhtLN6MzOKGg8tazN57WLMGj
   rzuouxhzdV11s2N+HFcnTHfINbQPjZawc3egTCV8wAWvjykwgbMTmkFOs
   7KBqzBuTpS85wS6Uv2uD8hV8bh0+hcdXx+B/VPkB706sXwlDW6VB6yqmN
   Q==;
X-CSE-ConnectionGUID: ZCHZKShSS5musrtoMxEngA==
X-CSE-MsgGUID: vth9Oh0BSsiD4ycCxoO6Zg==
X-IronPort-AV: E=McAfee;i="6700,10204,11308"; a="35685799"
X-IronPort-AV: E=Sophos;i="6.12,295,1728975600"; 
   d="scan'208";a="35685799"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 07:31:14 -0800
X-CSE-ConnectionGUID: C4y1l49ERiyfMsgFgtahwA==
X-CSE-MsgGUID: TimD9tCXQ+qlEVn9keDrnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="103646935"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa008.jf.intel.com with ESMTP; 07 Jan 2025 07:31:10 -0800
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
Subject: [PATCH net-next v2 2/8] net: gro: expose GRO init/cleanup to use outside of NAPI
Date: Tue,  7 Jan 2025 16:29:34 +0100
Message-ID: <20250107152940.26530-3-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250107152940.26530-1-aleksander.lobakin@intel.com>
References: <20250107152940.26530-1-aleksander.lobakin@intel.com>
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
 net/core/gro.c    | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+), 30 deletions(-)

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
index 1f4e2a0ef1da..f7059e98ce87 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6616,17 +6616,6 @@ static enum hrtimer_restart napi_watchdog(struct hrtimer *timer)
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
@@ -6738,10 +6727,8 @@ void netif_napi_add_weight(struct net_device *dev, struct napi_struct *napi,
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
@@ -6828,19 +6815,6 @@ void napi_enable(struct napi_struct *n)
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
@@ -6855,8 +6829,7 @@ void __netif_napi_del(struct napi_struct *napi)
 	list_del_rcu(&napi->dev_list);
 	napi_free_frags(napi);
 
-	flush_gro_hash(napi);
-	napi->gro.bitmask = 0;
+	gro_cleanup(&napi->gro);
 
 	if (napi->thread) {
 		kthread_stop(napi->thread);
@@ -12243,7 +12216,7 @@ static int __init net_dev_init(void)
 		INIT_CSD(&sd->defer_csd, trigger_rx_softirq, sd);
 		spin_lock_init(&sd->defer_lock);
 
-		init_gro_hash(&sd->backlog);
+		gro_init(&sd->backlog.gro);
 		sd->backlog.poll = process_backlog;
 		sd->backlog.weight = weight_p;
 		INIT_LIST_HEAD(&sd->backlog.poll_list);
diff --git a/net/core/gro.c b/net/core/gro.c
index 77ec10d9cd43..29ee36bb0b27 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -793,3 +793,37 @@ __sum16 __skb_gro_checksum_complete(struct sk_buff *skb)
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
+
+	gro->napi_id = 0;
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
2.47.1


