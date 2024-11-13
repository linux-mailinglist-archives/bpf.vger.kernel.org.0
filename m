Return-Path: <bpf+bounces-44759-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A63AE9C771B
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 16:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 358D21F27773
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 15:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB87204009;
	Wed, 13 Nov 2024 15:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e5g2hYpB"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE91814EC59;
	Wed, 13 Nov 2024 15:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731511531; cv=none; b=kQgMrjY6ihhVxmX2kJg/cYjqH4JsSHSqcMQtJbvotFiS9zlUAGaYV3D4a+l3ttFuPjoLSoI77gXGF4IzqnCiX397OMo3ewIgT1vC5Jq65QA1qjbRfedPaphcBRFKjhoN1Yw4/8Zag7FPUOb7J0YDzh0QkPeu+hPXVDFGOpbqPQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731511531; c=relaxed/simple;
	bh=SOKOQW7CwagZ62AjVLBwdZnmxMDEc3m4isJlamPMFu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nv4ZAdamVbUFqP9rRVv9/rofKdiebKkSBAlct97uHRZ1Wz5l7uNhuUdXb7hPQsfsL/HVuMyLgBbGSGJxOc9ZIQiKpTB1HS4hR8sw90dqFAQG0mHhgp6zZ3mGK4rd4W+duNweJfJLShgff1D9k18o1A/nqOIlWNRGoZPhvu5F8CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e5g2hYpB; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731511530; x=1763047530;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SOKOQW7CwagZ62AjVLBwdZnmxMDEc3m4isJlamPMFu8=;
  b=e5g2hYpBm/AGAgjrwV0zvuCoUvg0Q8/JTIFdV6S00eSVXVkvfPKfjaZY
   KgIXakJzThLzUgLPgnMrbzoMdtMfj3XbYoKRIglBDc0gxclsVRJG+TAKl
   PZ/+95K7Tc3ftOb781Fgt5BO1aCyCAAr4spCaDgET5W0Fn9HJCY9JyLFp
   gMqRW677XP/CPbmADyTJhLAeTzRCQsb5C8RK8Xs+ZgGs00cWw9RUkYN6W
   ZBmu2GbQfYMVQjmdvSfM5BKGT6nI3q8K2n0GUTE0Q0wSjsZZvcm4cu0Fz
   QJlyPLVR+eKwk7Bs2UN16xuEe/g/xYAez0EstPn9VUBMEBYPmo8UnFwlV
   g==;
X-CSE-ConnectionGUID: F7BGh6l1RFKWEbW0cFVc5Q==
X-CSE-MsgGUID: hcKcQd3uSJuGttLvLh8vgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="42799285"
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="42799285"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 07:25:17 -0800
X-CSE-ConnectionGUID: UB19XJhrRT+8l+LbX4HTjA==
X-CSE-MsgGUID: rKm5+uRhS5SxpluQ0r28xA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="118726886"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa002.jf.intel.com with ESMTP; 13 Nov 2024 07:25:13 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 04/19] bpf, xdp: constify some bpf_prog * function arguments
Date: Wed, 13 Nov 2024 16:24:27 +0100
Message-ID: <20241113152442.4000468-5-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241113152442.4000468-1-aleksander.lobakin@intel.com>
References: <20241113152442.4000468-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In lots of places, bpf_prog pointer is used only for tracing or other
stuff that doesn't modify the structure itself. Same for net_device.
Address at least some of them and add `const` attributes there. The
object code didn't change, but that may prevent unwanted data
modifications and also allow more helpers to have const arguments.

Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/linux/bpf.h       | 12 ++++++------
 include/linux/filter.h    |  9 +++++----
 include/linux/netdevice.h |  6 +++---
 include/linux/skbuff.h    |  2 +-
 kernel/bpf/devmap.c       |  8 ++++----
 net/core/dev.c            | 10 +++++-----
 net/core/filter.c         | 29 ++++++++++++++++-------------
 net/core/skbuff.c         |  2 +-
 8 files changed, 41 insertions(+), 37 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index bdadb0bb6cec..0d537d547dce 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2542,10 +2542,10 @@ int dev_map_enqueue(struct bpf_dtab_netdev *dst, struct xdp_frame *xdpf,
 int dev_map_enqueue_multi(struct xdp_frame *xdpf, struct net_device *dev_rx,
 			  struct bpf_map *map, bool exclude_ingress);
 int dev_map_generic_redirect(struct bpf_dtab_netdev *dst, struct sk_buff *skb,
-			     struct bpf_prog *xdp_prog);
+			     const struct bpf_prog *xdp_prog);
 int dev_map_redirect_multi(struct net_device *dev, struct sk_buff *skb,
-			   struct bpf_prog *xdp_prog, struct bpf_map *map,
-			   bool exclude_ingress);
+			   const struct bpf_prog *xdp_prog,
+			   struct bpf_map *map, bool exclude_ingress);
 
 void __cpu_map_flush(struct list_head *flush_list);
 int cpu_map_enqueue(struct bpf_cpu_map_entry *rcpu, struct xdp_frame *xdpf,
@@ -2809,15 +2809,15 @@ struct sk_buff;
 
 static inline int dev_map_generic_redirect(struct bpf_dtab_netdev *dst,
 					   struct sk_buff *skb,
-					   struct bpf_prog *xdp_prog)
+					   const struct bpf_prog *xdp_prog)
 {
 	return 0;
 }
 
 static inline
 int dev_map_redirect_multi(struct net_device *dev, struct sk_buff *skb,
-			   struct bpf_prog *xdp_prog, struct bpf_map *map,
-			   bool exclude_ingress)
+			   const struct bpf_prog *xdp_prog,
+			   struct bpf_map *map, bool exclude_ingress)
 {
 	return 0;
 }
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 7d7578a8eac1..ee067ab13272 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1178,17 +1178,18 @@ static inline int xdp_ok_fwd_dev(const struct net_device *fwd,
  * This does not appear to be a real limitation for existing software.
  */
 int xdp_do_generic_redirect(struct net_device *dev, struct sk_buff *skb,
-			    struct xdp_buff *xdp, struct bpf_prog *prog);
+			    struct xdp_buff *xdp, const struct bpf_prog *prog);
 int xdp_do_redirect(struct net_device *dev,
 		    struct xdp_buff *xdp,
-		    struct bpf_prog *prog);
+		    const struct bpf_prog *prog);
 int xdp_do_redirect_frame(struct net_device *dev,
 			  struct xdp_buff *xdp,
 			  struct xdp_frame *xdpf,
-			  struct bpf_prog *prog);
+			  const struct bpf_prog *prog);
 void xdp_do_flush(void);
 
-void bpf_warn_invalid_xdp_action(struct net_device *dev, struct bpf_prog *prog, u32 act);
+void bpf_warn_invalid_xdp_action(const struct net_device *dev,
+				 const struct bpf_prog *prog, u32 act);
 
 #ifdef CONFIG_INET
 struct sock *bpf_run_sk_reuseport(struct sock_reuseport *reuse, struct sock *sk,
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 0aae346d919e..42715e1b9220 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3950,9 +3950,9 @@ static inline void dev_consume_skb_any(struct sk_buff *skb)
 }
 
 u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
-			     struct bpf_prog *xdp_prog);
-void generic_xdp_tx(struct sk_buff *skb, struct bpf_prog *xdp_prog);
-int do_xdp_generic(struct bpf_prog *xdp_prog, struct sk_buff **pskb);
+			     const struct bpf_prog *xdp_prog);
+void generic_xdp_tx(struct sk_buff *skb, const struct bpf_prog *xdp_prog);
+int do_xdp_generic(const struct bpf_prog *xdp_prog, struct sk_buff **pskb);
 int netif_rx(struct sk_buff *skb);
 int __netif_rx(struct sk_buff *skb);
 
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index c212c1dad461..92f1d1e218b5 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3627,7 +3627,7 @@ static inline netmem_ref skb_frag_netmem(const skb_frag_t *frag)
 int skb_pp_cow_data(struct page_pool *pool, struct sk_buff **pskb,
 		    unsigned int headroom);
 int skb_cow_data_for_xdp(struct page_pool *pool, struct sk_buff **pskb,
-			 struct bpf_prog *prog);
+			 const struct bpf_prog *prog);
 
 /**
  * skb_frag_address - gets the address of the data contained in a paged fragment
diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 7878be18e9d2..effde52bc857 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -678,7 +678,7 @@ int dev_map_enqueue_multi(struct xdp_frame *xdpf, struct net_device *dev_rx,
 }
 
 int dev_map_generic_redirect(struct bpf_dtab_netdev *dst, struct sk_buff *skb,
-			     struct bpf_prog *xdp_prog)
+			     const struct bpf_prog *xdp_prog)
 {
 	int err;
 
@@ -701,7 +701,7 @@ int dev_map_generic_redirect(struct bpf_dtab_netdev *dst, struct sk_buff *skb,
 
 static int dev_map_redirect_clone(struct bpf_dtab_netdev *dst,
 				  struct sk_buff *skb,
-				  struct bpf_prog *xdp_prog)
+				  const struct bpf_prog *xdp_prog)
 {
 	struct sk_buff *nskb;
 	int err;
@@ -720,8 +720,8 @@ static int dev_map_redirect_clone(struct bpf_dtab_netdev *dst,
 }
 
 int dev_map_redirect_multi(struct net_device *dev, struct sk_buff *skb,
-			   struct bpf_prog *xdp_prog, struct bpf_map *map,
-			   bool exclude_ingress)
+			   const struct bpf_prog *xdp_prog,
+			   struct bpf_map *map, bool exclude_ingress)
 {
 	struct bpf_dtab *dtab = container_of(map, struct bpf_dtab, map);
 	struct bpf_dtab_netdev *dst, *last_dst = NULL;
diff --git a/net/core/dev.c b/net/core/dev.c
index 13d00fc10f55..bbb456b86e8b 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4931,7 +4931,7 @@ static struct netdev_rx_queue *netif_get_rxqueue(struct sk_buff *skb)
 }
 
 u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
-			     struct bpf_prog *xdp_prog)
+			     const struct bpf_prog *xdp_prog)
 {
 	void *orig_data, *orig_data_end, *hard_start;
 	struct netdev_rx_queue *rxqueue;
@@ -5033,7 +5033,7 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 }
 
 static int
-netif_skb_check_for_xdp(struct sk_buff **pskb, struct bpf_prog *prog)
+netif_skb_check_for_xdp(struct sk_buff **pskb, const struct bpf_prog *prog)
 {
 	struct sk_buff *skb = *pskb;
 	int err, hroom, troom;
@@ -5057,7 +5057,7 @@ netif_skb_check_for_xdp(struct sk_buff **pskb, struct bpf_prog *prog)
 
 static u32 netif_receive_generic_xdp(struct sk_buff **pskb,
 				     struct xdp_buff *xdp,
-				     struct bpf_prog *xdp_prog)
+				     const struct bpf_prog *xdp_prog)
 {
 	struct sk_buff *skb = *pskb;
 	u32 mac_len, act = XDP_DROP;
@@ -5110,7 +5110,7 @@ static u32 netif_receive_generic_xdp(struct sk_buff **pskb,
  * and DDOS attacks will be more effective. In-driver-XDP use dedicated TX
  * queues, so they do not have this starvation issue.
  */
-void generic_xdp_tx(struct sk_buff *skb, struct bpf_prog *xdp_prog)
+void generic_xdp_tx(struct sk_buff *skb, const struct bpf_prog *xdp_prog)
 {
 	struct net_device *dev = skb->dev;
 	struct netdev_queue *txq;
@@ -5135,7 +5135,7 @@ void generic_xdp_tx(struct sk_buff *skb, struct bpf_prog *xdp_prog)
 
 static DEFINE_STATIC_KEY_FALSE(generic_xdp_needed_key);
 
-int do_xdp_generic(struct bpf_prog *xdp_prog, struct sk_buff **pskb)
+int do_xdp_generic(const struct bpf_prog *xdp_prog, struct sk_buff **pskb)
 {
 	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 
diff --git a/net/core/filter.c b/net/core/filter.c
index 82f92ed0dc72..b40e091a764d 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4334,9 +4334,9 @@ u32 xdp_master_redirect(struct xdp_buff *xdp)
 EXPORT_SYMBOL_GPL(xdp_master_redirect);
 
 static inline int __xdp_do_redirect_xsk(struct bpf_redirect_info *ri,
-					struct net_device *dev,
+					const struct net_device *dev,
 					struct xdp_buff *xdp,
-					struct bpf_prog *xdp_prog)
+					const struct bpf_prog *xdp_prog)
 {
 	enum bpf_map_type map_type = ri->map_type;
 	void *fwd = ri->tgt_value;
@@ -4357,10 +4357,10 @@ static inline int __xdp_do_redirect_xsk(struct bpf_redirect_info *ri,
 	return err;
 }
 
-static __always_inline int __xdp_do_redirect_frame(struct bpf_redirect_info *ri,
-						   struct net_device *dev,
-						   struct xdp_frame *xdpf,
-						   struct bpf_prog *xdp_prog)
+static __always_inline int
+__xdp_do_redirect_frame(struct bpf_redirect_info *ri, struct net_device *dev,
+			struct xdp_frame *xdpf,
+			const struct bpf_prog *xdp_prog)
 {
 	enum bpf_map_type map_type = ri->map_type;
 	void *fwd = ri->tgt_value;
@@ -4429,7 +4429,7 @@ static __always_inline int __xdp_do_redirect_frame(struct bpf_redirect_info *ri,
 }
 
 int xdp_do_redirect(struct net_device *dev, struct xdp_buff *xdp,
-		    struct bpf_prog *xdp_prog)
+		    const struct bpf_prog *xdp_prog)
 {
 	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
 	enum bpf_map_type map_type = ri->map_type;
@@ -4443,7 +4443,8 @@ int xdp_do_redirect(struct net_device *dev, struct xdp_buff *xdp,
 EXPORT_SYMBOL_GPL(xdp_do_redirect);
 
 int xdp_do_redirect_frame(struct net_device *dev, struct xdp_buff *xdp,
-			  struct xdp_frame *xdpf, struct bpf_prog *xdp_prog)
+			  struct xdp_frame *xdpf,
+			  const struct bpf_prog *xdp_prog)
 {
 	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
 	enum bpf_map_type map_type = ri->map_type;
@@ -4458,9 +4459,9 @@ EXPORT_SYMBOL_GPL(xdp_do_redirect_frame);
 static int xdp_do_generic_redirect_map(struct net_device *dev,
 				       struct sk_buff *skb,
 				       struct xdp_buff *xdp,
-				       struct bpf_prog *xdp_prog, void *fwd,
-				       enum bpf_map_type map_type, u32 map_id,
-				       u32 flags)
+				       const struct bpf_prog *xdp_prog,
+				       void *fwd, enum bpf_map_type map_type,
+				       u32 map_id, u32 flags)
 {
 	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
 	struct bpf_map *map;
@@ -4514,7 +4515,8 @@ static int xdp_do_generic_redirect_map(struct net_device *dev,
 }
 
 int xdp_do_generic_redirect(struct net_device *dev, struct sk_buff *skb,
-			    struct xdp_buff *xdp, struct bpf_prog *xdp_prog)
+			    struct xdp_buff *xdp,
+			    const struct bpf_prog *xdp_prog)
 {
 	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
 	enum bpf_map_type map_type = ri->map_type;
@@ -9061,7 +9063,8 @@ static bool xdp_is_valid_access(int off, int size,
 	return __is_valid_xdp_access(off, size);
 }
 
-void bpf_warn_invalid_xdp_action(struct net_device *dev, struct bpf_prog *prog, u32 act)
+void bpf_warn_invalid_xdp_action(const struct net_device *dev,
+				 const struct bpf_prog *prog, u32 act)
 {
 	const u32 act_max = XDP_REDIRECT;
 
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 6841e61a6bd0..a441613a1e6c 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1009,7 +1009,7 @@ int skb_pp_cow_data(struct page_pool *pool, struct sk_buff **pskb,
 EXPORT_SYMBOL(skb_pp_cow_data);
 
 int skb_cow_data_for_xdp(struct page_pool *pool, struct sk_buff **pskb,
-			 struct bpf_prog *prog)
+			 const struct bpf_prog *prog)
 {
 	if (!prog->aux->xdp_has_frags)
 		return -EINVAL;
-- 
2.47.0


