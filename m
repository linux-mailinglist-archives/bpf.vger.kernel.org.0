Return-Path: <bpf+bounces-41423-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3EE8996FEC
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 17:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D009F1F264B2
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 15:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F901E32BC;
	Wed,  9 Oct 2024 15:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kuQC71wi"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BC71E103B;
	Wed,  9 Oct 2024 15:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728487734; cv=none; b=Tv1DBsXdDvvLqZcJS6EUaBtU5IkkdyaBZEWjuf+OBQRy9vu+c+hpWthg24vdPa5h+DHTsEHfGY8O+8ir3hWGBsROSJVLIUixcyMSR6XUlAUhUqlFnZe/KxW0RvGYmuS2/nK0HwvPOfgQp5lt2QN1O+LhiI1Bc81qdJIZlPnNp5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728487734; c=relaxed/simple;
	bh=TeeOH37WAvBpj5aOJdtqxOgr80igzzQO+brz05UxJbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uq57KVQgi2NgJosdobgednp/yitw6exrQDjAMxfpZtFZ0qv6qjOY+501yJFXuE61BHiPGf4QvCowRdu9YAWoj62wXiYfVBuREt8EasKMgsebzLmx4unDKvsXEPE609ROsSOF9gXxon3h0rIjoDEtlYB7wvop4ADVkoVeaGlKAlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kuQC71wi; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728487732; x=1760023732;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TeeOH37WAvBpj5aOJdtqxOgr80igzzQO+brz05UxJbg=;
  b=kuQC71wimA9q/echvgItF/M6vq007xU4myHisfRs9qcy1wVvBrg5v0iM
   uUV+5sWg/ZFyR+T6r0t1P1ZgN8jjqWT032PbbAqTcspcJLFXlXvcrkX4I
   lqlmLPzPUJ/N5v+xV2pm/EwbMCLs0I7RG1nKeJFNfJ3VOjslBlk7p+T+a
   tUsPr4D7ium88lwHJR93MmAb9fUfx5K658IEm6F5JsdeML7ae4o/Xh01d
   88VtheA3qSoHjDVXXvjwKATyawKNLRlGoeG6nUxF3wYE26bkaTDjdo1q5
   cyYClV8QAd0X6HGm/vkiO3sc1367z2S8xph5zXDTfHWxomHtbLvlWx5+m
   Q==;
X-CSE-ConnectionGUID: w9adIYrfT0yZrQRvUVcZ7w==
X-CSE-MsgGUID: dVzeVuhWRlS0mceN3sCMlg==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="27675716"
X-IronPort-AV: E=Sophos;i="6.11,190,1725346800"; 
   d="scan'208";a="27675716"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 08:28:52 -0700
X-CSE-ConnectionGUID: OqnpdPDkTOqeFMvyTnDCZw==
X-CSE-MsgGUID: JPqELvH0QhOlaY99UFUqzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,190,1725346800"; 
   d="scan'208";a="81305870"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa004.jf.intel.com with ESMTP; 09 Oct 2024 08:28:48 -0700
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
	Stanislav Fomichev <sdf@fomichev.me>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 04/18] bpf, xdp: constify some bpf_prog * function arguments
Date: Wed,  9 Oct 2024 17:27:42 +0200
Message-ID: <20241009152756.3113697-5-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241009152756.3113697-1-aleksander.lobakin@intel.com>
References: <20241009152756.3113697-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In lots of places, bpf_prog pointer is used only for tracing or other
stuff that doesn't modify the structure itself. Same for net_device.
Address at least some of them and add `const` attributes there. The
object code didn't change, but that may prevent unwanted data
modifications and also allow more helpers to have const arguments.

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
index 19d8ca8ac960..263515478984 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2534,10 +2534,10 @@ int dev_map_enqueue(struct bpf_dtab_netdev *dst, struct xdp_frame *xdpf,
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
@@ -2801,15 +2801,15 @@ struct sk_buff;
 
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
index 43720e3bf25b..b31c8ef4bb7b 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3910,9 +3910,9 @@ static inline void dev_consume_skb_any(struct sk_buff *skb)
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
index 4a07bb3bcec6..0f0266183d3e 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3590,7 +3590,7 @@ static inline netmem_ref skb_frag_netmem(const skb_frag_t *frag)
 int skb_pp_cow_data(struct page_pool *pool, struct sk_buff **pskb,
 		    unsigned int headroom);
 int skb_cow_data_for_xdp(struct page_pool *pool, struct sk_buff **pskb,
-			 struct bpf_prog *prog);
+			 const struct bpf_prog *prog);
 
 /**
  * skb_frag_address - gets the address of the data contained in a paged fragment
diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 9e0e3b0a18e4..f634b87aa0fa 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -675,7 +675,7 @@ int dev_map_enqueue_multi(struct xdp_frame *xdpf, struct net_device *dev_rx,
 }
 
 int dev_map_generic_redirect(struct bpf_dtab_netdev *dst, struct sk_buff *skb,
-			     struct bpf_prog *xdp_prog)
+			     const struct bpf_prog *xdp_prog)
 {
 	int err;
 
@@ -698,7 +698,7 @@ int dev_map_generic_redirect(struct bpf_dtab_netdev *dst, struct sk_buff *skb,
 
 static int dev_map_redirect_clone(struct bpf_dtab_netdev *dst,
 				  struct sk_buff *skb,
-				  struct bpf_prog *xdp_prog)
+				  const struct bpf_prog *xdp_prog)
 {
 	struct sk_buff *nskb;
 	int err;
@@ -717,8 +717,8 @@ static int dev_map_redirect_clone(struct bpf_dtab_netdev *dst,
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
index 3f47e9d48636..c86cf5e235fc 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4930,7 +4930,7 @@ static struct netdev_rx_queue *netif_get_rxqueue(struct sk_buff *skb)
 }
 
 u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
-			     struct bpf_prog *xdp_prog)
+			     const struct bpf_prog *xdp_prog)
 {
 	void *orig_data, *orig_data_end, *hard_start;
 	struct netdev_rx_queue *rxqueue;
@@ -5032,7 +5032,7 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 }
 
 static int
-netif_skb_check_for_xdp(struct sk_buff **pskb, struct bpf_prog *prog)
+netif_skb_check_for_xdp(struct sk_buff **pskb, const struct bpf_prog *prog)
 {
 	struct sk_buff *skb = *pskb;
 	int err, hroom, troom;
@@ -5056,7 +5056,7 @@ netif_skb_check_for_xdp(struct sk_buff **pskb, struct bpf_prog *prog)
 
 static u32 netif_receive_generic_xdp(struct sk_buff **pskb,
 				     struct xdp_buff *xdp,
-				     struct bpf_prog *xdp_prog)
+				     const struct bpf_prog *xdp_prog)
 {
 	struct sk_buff *skb = *pskb;
 	u32 mac_len, act = XDP_DROP;
@@ -5109,7 +5109,7 @@ static u32 netif_receive_generic_xdp(struct sk_buff **pskb,
  * and DDOS attacks will be more effective. In-driver-XDP use dedicated TX
  * queues, so they do not have this starvation issue.
  */
-void generic_xdp_tx(struct sk_buff *skb, struct bpf_prog *xdp_prog)
+void generic_xdp_tx(struct sk_buff *skb, const struct bpf_prog *xdp_prog)
 {
 	struct net_device *dev = skb->dev;
 	struct netdev_queue *txq;
@@ -5134,7 +5134,7 @@ void generic_xdp_tx(struct sk_buff *skb, struct bpf_prog *xdp_prog)
 
 static DEFINE_STATIC_KEY_FALSE(generic_xdp_needed_key);
 
-int do_xdp_generic(struct bpf_prog *xdp_prog, struct sk_buff **pskb)
+int do_xdp_generic(const struct bpf_prog *xdp_prog, struct sk_buff **pskb)
 {
 	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 
diff --git a/net/core/filter.c b/net/core/filter.c
index bd0d08bf76bb..be78a5cd4e8c 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4349,9 +4349,9 @@ u32 xdp_master_redirect(struct xdp_buff *xdp)
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
@@ -4372,10 +4372,10 @@ static inline int __xdp_do_redirect_xsk(struct bpf_redirect_info *ri,
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
@@ -4444,7 +4444,7 @@ static __always_inline int __xdp_do_redirect_frame(struct bpf_redirect_info *ri,
 }
 
 int xdp_do_redirect(struct net_device *dev, struct xdp_buff *xdp,
-		    struct bpf_prog *xdp_prog)
+		    const struct bpf_prog *xdp_prog)
 {
 	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
 	enum bpf_map_type map_type = ri->map_type;
@@ -4458,7 +4458,8 @@ int xdp_do_redirect(struct net_device *dev, struct xdp_buff *xdp,
 EXPORT_SYMBOL_GPL(xdp_do_redirect);
 
 int xdp_do_redirect_frame(struct net_device *dev, struct xdp_buff *xdp,
-			  struct xdp_frame *xdpf, struct bpf_prog *xdp_prog)
+			  struct xdp_frame *xdpf,
+			  const struct bpf_prog *xdp_prog)
 {
 	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
 	enum bpf_map_type map_type = ri->map_type;
@@ -4473,9 +4474,9 @@ EXPORT_SYMBOL_GPL(xdp_do_redirect_frame);
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
@@ -4529,7 +4530,8 @@ static int xdp_do_generic_redirect_map(struct net_device *dev,
 }
 
 int xdp_do_generic_redirect(struct net_device *dev, struct sk_buff *skb,
-			    struct xdp_buff *xdp, struct bpf_prog *xdp_prog)
+			    struct xdp_buff *xdp,
+			    const struct bpf_prog *xdp_prog)
 {
 	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
 	enum bpf_map_type map_type = ri->map_type;
@@ -9079,7 +9081,8 @@ static bool xdp_is_valid_access(int off, int size,
 	return __is_valid_xdp_access(off, size);
 }
 
-void bpf_warn_invalid_xdp_action(struct net_device *dev, struct bpf_prog *prog, u32 act)
+void bpf_warn_invalid_xdp_action(const struct net_device *dev,
+				 const struct bpf_prog *prog, u32 act)
 {
 	const u32 act_max = XDP_REDIRECT;
 
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index e0968d3dc450..e7765716983f 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1071,7 +1071,7 @@ int skb_pp_cow_data(struct page_pool *pool, struct sk_buff **pskb,
 EXPORT_SYMBOL(skb_pp_cow_data);
 
 int skb_cow_data_for_xdp(struct page_pool *pool, struct sk_buff **pskb,
-			 struct bpf_prog *prog)
+			 const struct bpf_prog *prog)
 {
 	if (!prog->aux->xdp_has_frags)
 		return -EINVAL;
-- 
2.46.2


