Return-Path: <bpf+bounces-44257-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CA39C0B2E
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 17:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 199B81C2374B
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 16:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BA5218334;
	Thu,  7 Nov 2024 16:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QO7ZvCrR"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43A721831C;
	Thu,  7 Nov 2024 16:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730996044; cv=none; b=VTnb7sXJD/2E/VwXeAXoIdDuT40N5pzFI8U5kXuAnFSu1vb0FavdHoNXd9KliqWf59TEwxhUt35VU6ihqoRH+u6rKuXNuzOeCwatUpnAULg2CcaZz2m6T/Bn6xUoJ0RbE5n7cdK8zyCM4I883JH3J2TCZdzzx7d0/K5b80ltQeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730996044; c=relaxed/simple;
	bh=AfJFNMcUas04sgUA/cbzlvj7FMUvz9x4FoR0A2Rhnxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Om9OMQgLc9Lm5F+mTirLO3FPrIf8f0bAYQ4W4v4xuVX6O3bXOQraFTDtwKKA8TKxT7DA7TimxwNxf2KQmZtbtFWCrP8ilUrJR4bLCZIbFfc/yv2D8HAyCY48SqUjsxuVdTCvtjJJZNIQqDISKiafmZrJOLiy+aUzMmI0po2xsms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QO7ZvCrR; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730996043; x=1762532043;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AfJFNMcUas04sgUA/cbzlvj7FMUvz9x4FoR0A2Rhnxo=;
  b=QO7ZvCrR+H3FmbuxpWbLDwxcbJgWpt67w6Fv3PFizMICH43SKglZ18XI
   eLJu+WfC/F/C2rhajDFyvO/FFHNMkp+ujUiIuDYhRbq4BqPULxuV1X4Fy
   9/Uo/rngj+P6aIXNBeGoaRKqMdlrXn1AjVoDXfKCuSDCXtAFlhZv+XgRY
   afsRPgdR6zOPwIPRBUegXRfF/LVMQ+pQJ8T1GU8Yanj2AHTiBDj4JWVjc
   IA4BkXLn6Ap7WN42VeFapbPtduhhcmBzevdske+ETWE0e2LACcTSyDITw
   gRS8WO4LehfDzPBxA7FlkAa82ZHZDmYB69RgD6kC+rbBtXUN6KnLyFbSu
   g==;
X-CSE-ConnectionGUID: ORfk8gdrSu61bkTo/scAMw==
X-CSE-MsgGUID: /knE6/tGRbSvZfSHNKWZbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41955784"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="41955784"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 08:14:01 -0800
X-CSE-ConnectionGUID: v9cYsM9LRG+jmP8XpDL12Q==
X-CSE-MsgGUID: 44NkP3a4QPG3vu9UR63/mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,135,1728975600"; 
   d="scan'208";a="90258169"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa004.jf.intel.com with ESMTP; 07 Nov 2024 08:13:57 -0800
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
Subject: [PATCH net-next v4 04/19] bpf, xdp: constify some bpf_prog * function arguments
Date: Thu,  7 Nov 2024 17:10:11 +0100
Message-ID: <20241107161026.2903044-5-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107161026.2903044-1-aleksander.lobakin@intel.com>
References: <20241107161026.2903044-1-aleksander.lobakin@intel.com>
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
index 3c552b648b27..201f0c0ec62e 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3941,9 +3941,9 @@ static inline void dev_consume_skb_any(struct sk_buff *skb)
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
index 9e55223ba362..d6920df9b620 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3618,7 +3618,7 @@ static inline netmem_ref skb_frag_netmem(const skb_frag_t *frag)
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
index 6a31152e4606..32dd742450b6 100644
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
index 00afeb90c23a..224cfe8b4368 100644
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


