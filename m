Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61721294487
	for <lists+bpf@lfdr.de>; Tue, 20 Oct 2020 23:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388188AbgJTV0I (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Oct 2020 17:26:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32523 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2409919AbgJTV0G (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 20 Oct 2020 17:26:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603229163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3gYim5cY/5UX45e/fLKhAZG3xXjykGIwk/ncsGAvwxQ=;
        b=e2XM8gx2BXXuz6C7XV3C9ImPgciwp5Aj25bImJpaiayZ3ms5z8K2m42gLyMWQo8Konr6WS
        ELojxaUn7H6UP/di/v3wXwFY7jrrBsUh6FUoJmJ6c+m+/h1yiWlrEH55t+b6O8C9lLomyg
        YXSW/UwaXLpqBcZCZYMlqjoGgkymoTg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-YR9f2FUoOFS4YJZDvUvYYg-1; Tue, 20 Oct 2020 17:25:59 -0400
X-MC-Unique: YR9f2FUoOFS4YJZDvUvYYg-1
Received: by mail-ej1-f70.google.com with SMTP id b17so50555ejb.20
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2020 14:25:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=3gYim5cY/5UX45e/fLKhAZG3xXjykGIwk/ncsGAvwxQ=;
        b=SDRvdCap4AMbxb/BTEJGoj+I1Tsv62FgBHu7tdCRGRspD/LJL2O7hNxPAChVO5qiku
         1yJApaF42KaAIYwTBvMgnNtn0A6GfK3Kt6R0ukBTIyC4vvuBwsORECqiSUKHx/uj16sJ
         bT0FFLvnY4m/Hb/uPjXjZGSEl13Zrz8uyZ6M7Yb/q47fYM2fSrNJ1DmyO+aYw48YL6i5
         9uHgFhtAHKOy7X/6PjhrZ8pUKvoyZGcRX2W9DBTauxNP8rwXqJSPYjUMgZa4jfQG7+/v
         Y8LwtS3Oo/s84zmWTDJjiWnxu3UrOfzl7Ya8rKueeAtTofxcm5eg4eK9qInA9g/pDOPg
         BkBQ==
X-Gm-Message-State: AOAM531qBQ4VZvbwyvv8oI7Hh1OEDUXYD+7LL7/0OstExCyXJEW9iAGS
        bT7NyYW4oQLQiRD3ypDDL/URj1oyTNEQLu8Cc5k+jmht63g5toictCRbyUVndJXi3ef/mSjuztb
        q5iDOTw212AK+
X-Received: by 2002:a17:906:1a19:: with SMTP id i25mr124406ejf.323.1603229157966;
        Tue, 20 Oct 2020 14:25:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz8kWL689fEjkVBXRfgcTFJ55+jlVuLZfjHK32rYdQprmiocuMnv/l5zQRz5NRScLwc1NOawA==
X-Received: by 2002:a17:906:1a19:: with SMTP id i25mr124385ejf.323.1603229157565;
        Tue, 20 Oct 2020 14:25:57 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id m16sm189231edj.37.2020.10.20.14.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 14:25:56 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 3AC361838FB; Tue, 20 Oct 2020 23:25:56 +0200 (CEST)
Subject: [PATCH bpf v3 1/2] bpf_redirect_neigh: Support supplying the nexthop
 as a helper parameter
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Date:   Tue, 20 Oct 2020 23:25:56 +0200
Message-ID: <160322915615.32199.1187570224032024535.stgit@toke.dk>
In-Reply-To: <160322915507.32199.17907734403861652183.stgit@toke.dk>
References: <160322915507.32199.17907734403861652183.stgit@toke.dk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

Based on the discussion in [0], update the bpf_redirect_neigh() helper to
accept an optional parameter specifying the nexthop information. This makes
it possible to combine bpf_fib_lookup() and bpf_redirect_neigh() without
incurring a duplicate FIB lookup - since the FIB lookup helper will return
the nexthop information even if no neighbour is present, this can simply be
passed on to bpf_redirect_neigh() if bpf_fib_lookup() returns
BPF_FIB_LKUP_RET_NO_NEIGH.

[0] https://lore.kernel.org/bpf/393e17fc-d187-3a8d-2f0d-a627c7c63fca@iogearbox.net/

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 include/linux/filter.h         |    9 ++
 include/uapi/linux/bpf.h       |   22 +++++-
 net/core/filter.c              |  159 +++++++++++++++++++++++++---------------
 scripts/bpf_helpers_doc.py     |    1 
 tools/include/uapi/linux/bpf.h |   22 +++++-
 5 files changed, 145 insertions(+), 68 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 20fc24c9779a..083a9fbb2c0b 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -607,12 +607,21 @@ struct bpf_skb_data_end {
 	void *data_end;
 };
 
+struct bpf_nh_params {
+	u32 nh_family;
+	union {
+		__u32 ipv4_nh;
+		struct in6_addr ipv6_nh;
+	};
+};
+
 struct bpf_redirect_info {
 	u32 flags;
 	u32 tgt_index;
 	void *tgt_value;
 	struct bpf_map *map;
 	u32 kern_flags;
+	struct bpf_nh_params nh;
 };
 
 DECLARE_PER_CPU(struct bpf_redirect_info, bpf_redirect_info);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index bf5a99d803e4..e6ceac3f7d62 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3677,15 +3677,19 @@ union bpf_attr {
  * 	Return
  * 		The id is returned or 0 in case the id could not be retrieved.
  *
- * long bpf_redirect_neigh(u32 ifindex, u64 flags)
+ * long bpf_redirect_neigh(u32 ifindex, struct bpf_redir_neigh *params, int plen, u64 flags)
  * 	Description
  * 		Redirect the packet to another net device of index *ifindex*
  * 		and fill in L2 addresses from neighboring subsystem. This helper
  * 		is somewhat similar to **bpf_redirect**\ (), except that it
  * 		populates L2 addresses as well, meaning, internally, the helper
- * 		performs a FIB lookup based on the skb's networking header to
- * 		get the address of the next hop and then relies on the neighbor
- * 		lookup for the L2 address of the nexthop.
+ * 		relies on the neighbor lookup for the L2 address of the nexthop.
+ *
+ * 		The helper will perform a FIB lookup based on the skb's
+ * 		networking header to get the address of the next hop, unless
+ * 		this is supplied by the caller in the *params* argument. The
+ * 		*plen* argument indicates the len of *params* and should be set
+ * 		to 0 if *params* is NULL.
  *
  * 		The *flags* argument is reserved and must be 0. The helper is
  * 		currently only supported for tc BPF program types, and enabled
@@ -4906,6 +4910,16 @@ struct bpf_fib_lookup {
 	__u8	dmac[6];     /* ETH_ALEN */
 };
 
+struct bpf_redir_neigh {
+	/* network family for lookup (AF_INET, AF_INET6) */
+	__u32 nh_family;
+	/* network address of nexthop; skips fib lookup to find gateway */
+	union {
+		__be32		ipv4_nh;
+		__u32		ipv6_nh[4];  /* in6_addr; network order */
+	};
+};
+
 enum bpf_task_fd_type {
 	BPF_FD_TYPE_RAW_TRACEPOINT,	/* tp name */
 	BPF_FD_TYPE_TRACEPOINT,		/* tp name */
diff --git a/net/core/filter.c b/net/core/filter.c
index c5e2a1c5fd8d..a431b116e11a 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2165,12 +2165,12 @@ static int __bpf_redirect(struct sk_buff *skb, struct net_device *dev,
 }
 
 #if IS_ENABLED(CONFIG_IPV6)
-static int bpf_out_neigh_v6(struct net *net, struct sk_buff *skb)
+static int bpf_out_neigh_v6(struct net *net, struct sk_buff *skb,
+			    struct net_device *dev, struct bpf_nh_params *nh)
 {
-	struct dst_entry *dst = skb_dst(skb);
-	struct net_device *dev = dst->dev;
 	u32 hh_len = LL_RESERVED_SPACE(dev);
 	const struct in6_addr *nexthop;
+	struct dst_entry *dst = NULL;
 	struct neighbour *neigh;
 
 	if (dev_xmit_recursion()) {
@@ -2196,8 +2196,13 @@ static int bpf_out_neigh_v6(struct net *net, struct sk_buff *skb)
 	}
 
 	rcu_read_lock_bh();
-	nexthop = rt6_nexthop(container_of(dst, struct rt6_info, dst),
-			      &ipv6_hdr(skb)->daddr);
+	if (!nh) {
+		dst = skb_dst(skb);
+		nexthop = rt6_nexthop(container_of(dst, struct rt6_info, dst),
+				      &ipv6_hdr(skb)->daddr);
+	} else {
+		nexthop = &nh->ipv6_nh;
+	}
 	neigh = ip_neigh_gw6(dev, nexthop);
 	if (likely(!IS_ERR(neigh))) {
 		int ret;
@@ -2210,36 +2215,43 @@ static int bpf_out_neigh_v6(struct net *net, struct sk_buff *skb)
 		return ret;
 	}
 	rcu_read_unlock_bh();
-	IP6_INC_STATS(dev_net(dst->dev),
-		      ip6_dst_idev(dst), IPSTATS_MIB_OUTNOROUTES);
+	if (dst)
+		IP6_INC_STATS(dev_net(dst->dev),
+			      ip6_dst_idev(dst), IPSTATS_MIB_OUTNOROUTES);
 out_drop:
 	kfree_skb(skb);
 	return -ENETDOWN;
 }
 
-static int __bpf_redirect_neigh_v6(struct sk_buff *skb, struct net_device *dev)
+static int __bpf_redirect_neigh_v6(struct sk_buff *skb, struct net_device *dev,
+				   struct bpf_nh_params *nh)
 {
 	const struct ipv6hdr *ip6h = ipv6_hdr(skb);
 	struct net *net = dev_net(dev);
 	int err, ret = NET_XMIT_DROP;
-	struct dst_entry *dst;
-	struct flowi6 fl6 = {
-		.flowi6_flags	= FLOWI_FLAG_ANYSRC,
-		.flowi6_mark	= skb->mark,
-		.flowlabel	= ip6_flowinfo(ip6h),
-		.flowi6_oif	= dev->ifindex,
-		.flowi6_proto	= ip6h->nexthdr,
-		.daddr		= ip6h->daddr,
-		.saddr		= ip6h->saddr,
-	};
 
-	dst = ipv6_stub->ipv6_dst_lookup_flow(net, NULL, &fl6, NULL);
-	if (IS_ERR(dst))
-		goto out_drop;
+	if (!nh) {
+		struct dst_entry *dst;
+		struct flowi6 fl6 = {
+			.flowi6_flags = FLOWI_FLAG_ANYSRC,
+			.flowi6_mark  = skb->mark,
+			.flowlabel    = ip6_flowinfo(ip6h),
+			.flowi6_oif   = dev->ifindex,
+			.flowi6_proto = ip6h->nexthdr,
+			.daddr	      = ip6h->daddr,
+			.saddr	      = ip6h->saddr,
+		};
+
+		dst = ipv6_stub->ipv6_dst_lookup_flow(net, NULL, &fl6, NULL);
+		if (IS_ERR(dst))
+			goto out_drop;
 
-	skb_dst_set(skb, dst);
+		skb_dst_set(skb, dst);
+	} else if (nh->nh_family != AF_INET6) {
+		goto out_drop;
+	}
 
-	err = bpf_out_neigh_v6(net, skb);
+	err = bpf_out_neigh_v6(net, skb, dev, nh);
 	if (unlikely(net_xmit_eval(err)))
 		dev->stats.tx_errors++;
 	else
@@ -2252,7 +2264,8 @@ static int __bpf_redirect_neigh_v6(struct sk_buff *skb, struct net_device *dev)
 	return ret;
 }
 #else
-static int __bpf_redirect_neigh_v6(struct sk_buff *skb, struct net_device *dev)
+static int __bpf_redirect_neigh_v6(struct sk_buff *skb, struct net_device *dev,
+				   struct bpf_nh_params *nh)
 {
 	kfree_skb(skb);
 	return NET_XMIT_DROP;
@@ -2260,11 +2273,9 @@ static int __bpf_redirect_neigh_v6(struct sk_buff *skb, struct net_device *dev)
 #endif /* CONFIG_IPV6 */
 
 #if IS_ENABLED(CONFIG_INET)
-static int bpf_out_neigh_v4(struct net *net, struct sk_buff *skb)
+static int bpf_out_neigh_v4(struct net *net, struct sk_buff *skb,
+			    struct net_device *dev, struct bpf_nh_params *nh)
 {
-	struct dst_entry *dst = skb_dst(skb);
-	struct rtable *rt = container_of(dst, struct rtable, dst);
-	struct net_device *dev = dst->dev;
 	u32 hh_len = LL_RESERVED_SPACE(dev);
 	struct neighbour *neigh;
 	bool is_v6gw = false;
@@ -2292,7 +2303,21 @@ static int bpf_out_neigh_v4(struct net *net, struct sk_buff *skb)
 	}
 
 	rcu_read_lock_bh();
-	neigh = ip_neigh_for_gw(rt, skb, &is_v6gw);
+	if (!nh) {
+		struct dst_entry *dst = skb_dst(skb);
+		struct rtable *rt = container_of(dst, struct rtable, dst);
+
+		neigh = ip_neigh_for_gw(rt, skb, &is_v6gw);
+	} else if (nh->nh_family == AF_INET6) {
+		neigh = ip_neigh_gw6(dev, &nh->ipv6_nh);
+		is_v6gw = true;
+	} else if (nh->nh_family == AF_INET) {
+		neigh = ip_neigh_gw4(dev, nh->ipv4_nh);
+	} else {
+		rcu_read_unlock_bh();
+		goto out_drop;
+	}
+
 	if (likely(!IS_ERR(neigh))) {
 		int ret;
 
@@ -2309,33 +2334,37 @@ static int bpf_out_neigh_v4(struct net *net, struct sk_buff *skb)
 	return -ENETDOWN;
 }
 
-static int __bpf_redirect_neigh_v4(struct sk_buff *skb, struct net_device *dev)
+static int __bpf_redirect_neigh_v4(struct sk_buff *skb, struct net_device *dev,
+				   struct bpf_nh_params *nh)
 {
 	const struct iphdr *ip4h = ip_hdr(skb);
 	struct net *net = dev_net(dev);
 	int err, ret = NET_XMIT_DROP;
-	struct rtable *rt;
-	struct flowi4 fl4 = {
-		.flowi4_flags	= FLOWI_FLAG_ANYSRC,
-		.flowi4_mark	= skb->mark,
-		.flowi4_tos	= RT_TOS(ip4h->tos),
-		.flowi4_oif	= dev->ifindex,
-		.flowi4_proto	= ip4h->protocol,
-		.daddr		= ip4h->daddr,
-		.saddr		= ip4h->saddr,
-	};
 
-	rt = ip_route_output_flow(net, &fl4, NULL);
-	if (IS_ERR(rt))
-		goto out_drop;
-	if (rt->rt_type != RTN_UNICAST && rt->rt_type != RTN_LOCAL) {
-		ip_rt_put(rt);
-		goto out_drop;
-	}
+	if (!nh) {
+		struct flowi4 fl4 = {
+			.flowi4_flags = FLOWI_FLAG_ANYSRC,
+			.flowi4_mark  = skb->mark,
+			.flowi4_tos   = RT_TOS(ip4h->tos),
+			.flowi4_oif   = dev->ifindex,
+			.flowi4_proto = ip4h->protocol,
+			.daddr	      = ip4h->daddr,
+			.saddr	      = ip4h->saddr,
+		};
+		struct rtable *rt;
+
+		rt = ip_route_output_flow(net, &fl4, NULL);
+		if (IS_ERR(rt))
+			goto out_drop;
+		if (rt->rt_type != RTN_UNICAST && rt->rt_type != RTN_LOCAL) {
+			ip_rt_put(rt);
+			goto out_drop;
+		}
 
-	skb_dst_set(skb, &rt->dst);
+		skb_dst_set(skb, &rt->dst);
+	}
 
-	err = bpf_out_neigh_v4(net, skb);
+	err = bpf_out_neigh_v4(net, skb, dev, nh);
 	if (unlikely(net_xmit_eval(err)))
 		dev->stats.tx_errors++;
 	else
@@ -2348,14 +2377,16 @@ static int __bpf_redirect_neigh_v4(struct sk_buff *skb, struct net_device *dev)
 	return ret;
 }
 #else
-static int __bpf_redirect_neigh_v4(struct sk_buff *skb, struct net_device *dev)
+static int __bpf_redirect_neigh_v4(struct sk_buff *skb, struct net_device *dev,
+				   struct bpf_nh_params *nh)
 {
 	kfree_skb(skb);
 	return NET_XMIT_DROP;
 }
 #endif /* CONFIG_INET */
 
-static int __bpf_redirect_neigh(struct sk_buff *skb, struct net_device *dev)
+static int __bpf_redirect_neigh(struct sk_buff *skb, struct net_device *dev,
+				struct bpf_nh_params *nh)
 {
 	struct ethhdr *ethh = eth_hdr(skb);
 
@@ -2370,9 +2401,9 @@ static int __bpf_redirect_neigh(struct sk_buff *skb, struct net_device *dev)
 	skb_reset_network_header(skb);
 
 	if (skb->protocol == htons(ETH_P_IP))
-		return __bpf_redirect_neigh_v4(skb, dev);
+		return __bpf_redirect_neigh_v4(skb, dev, nh);
 	else if (skb->protocol == htons(ETH_P_IPV6))
-		return __bpf_redirect_neigh_v6(skb, dev);
+		return __bpf_redirect_neigh_v6(skb, dev, nh);
 out:
 	kfree_skb(skb);
 	return -ENOTSUPP;
@@ -2382,7 +2413,8 @@ static int __bpf_redirect_neigh(struct sk_buff *skb, struct net_device *dev)
 enum {
 	BPF_F_NEIGH	= (1ULL << 1),
 	BPF_F_PEER	= (1ULL << 2),
-#define BPF_F_REDIRECT_INTERNAL	(BPF_F_NEIGH | BPF_F_PEER)
+	BPF_F_NEXTHOP	= (1ULL << 3),
+#define BPF_F_REDIRECT_INTERNAL	(BPF_F_NEIGH | BPF_F_PEER | BPF_F_NEXTHOP)
 };
 
 BPF_CALL_3(bpf_clone_redirect, struct sk_buff *, skb, u32, ifindex, u64, flags)
@@ -2455,8 +2487,8 @@ int skb_do_redirect(struct sk_buff *skb)
 		return -EAGAIN;
 	}
 	return flags & BPF_F_NEIGH ?
-	       __bpf_redirect_neigh(skb, dev) :
-	       __bpf_redirect(skb, dev, flags);
+		__bpf_redirect_neigh(skb, dev, flags & BPF_F_NEXTHOP ? &ri->nh : NULL) :
+		__bpf_redirect(skb, dev, flags);
 out_drop:
 	kfree_skb(skb);
 	return -EINVAL;
@@ -2504,16 +2536,21 @@ static const struct bpf_func_proto bpf_redirect_peer_proto = {
 	.arg2_type      = ARG_ANYTHING,
 };
 
-BPF_CALL_2(bpf_redirect_neigh, u32, ifindex, u64, flags)
+BPF_CALL_4(bpf_redirect_neigh, u32, ifindex, struct bpf_redir_neigh *, params,
+	   int, plen, u64, flags)
 {
 	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
 
-	if (unlikely(flags))
+	if (unlikely((plen && plen < sizeof(*params)) || flags))
 		return TC_ACT_SHOT;
 
-	ri->flags = BPF_F_NEIGH;
+	ri->flags = BPF_F_NEIGH | (plen ? BPF_F_NEXTHOP : 0);
 	ri->tgt_index = ifindex;
 
+	BUILD_BUG_ON(sizeof(struct bpf_redir_neigh) != sizeof(struct bpf_nh_params));
+	if (plen)
+		memcpy(&ri->nh, params, sizeof(ri->nh));
+
 	return TC_ACT_REDIRECT;
 }
 
@@ -2522,7 +2559,9 @@ static const struct bpf_func_proto bpf_redirect_neigh_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_ANYTHING,
-	.arg2_type	= ARG_ANYTHING,
+	.arg2_type      = ARG_PTR_TO_MEM_OR_NULL,
+	.arg3_type      = ARG_CONST_SIZE_OR_ZERO,
+	.arg4_type	= ARG_ANYTHING,
 };
 
 BPF_CALL_2(bpf_msg_apply_bytes, struct sk_msg *, msg, u32, bytes)
diff --git a/scripts/bpf_helpers_doc.py b/scripts/bpf_helpers_doc.py
index 7d86fdd190be..6769caae142f 100755
--- a/scripts/bpf_helpers_doc.py
+++ b/scripts/bpf_helpers_doc.py
@@ -453,6 +453,7 @@ class PrinterHelpers(Printer):
             'struct bpf_perf_event_data',
             'struct bpf_perf_event_value',
             'struct bpf_pidns_info',
+            'struct bpf_redir_neigh',
             'struct bpf_sk_lookup',
             'struct bpf_sock',
             'struct bpf_sock_addr',
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index bf5a99d803e4..e6ceac3f7d62 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3677,15 +3677,19 @@ union bpf_attr {
  * 	Return
  * 		The id is returned or 0 in case the id could not be retrieved.
  *
- * long bpf_redirect_neigh(u32 ifindex, u64 flags)
+ * long bpf_redirect_neigh(u32 ifindex, struct bpf_redir_neigh *params, int plen, u64 flags)
  * 	Description
  * 		Redirect the packet to another net device of index *ifindex*
  * 		and fill in L2 addresses from neighboring subsystem. This helper
  * 		is somewhat similar to **bpf_redirect**\ (), except that it
  * 		populates L2 addresses as well, meaning, internally, the helper
- * 		performs a FIB lookup based on the skb's networking header to
- * 		get the address of the next hop and then relies on the neighbor
- * 		lookup for the L2 address of the nexthop.
+ * 		relies on the neighbor lookup for the L2 address of the nexthop.
+ *
+ * 		The helper will perform a FIB lookup based on the skb's
+ * 		networking header to get the address of the next hop, unless
+ * 		this is supplied by the caller in the *params* argument. The
+ * 		*plen* argument indicates the len of *params* and should be set
+ * 		to 0 if *params* is NULL.
  *
  * 		The *flags* argument is reserved and must be 0. The helper is
  * 		currently only supported for tc BPF program types, and enabled
@@ -4906,6 +4910,16 @@ struct bpf_fib_lookup {
 	__u8	dmac[6];     /* ETH_ALEN */
 };
 
+struct bpf_redir_neigh {
+	/* network family for lookup (AF_INET, AF_INET6) */
+	__u32 nh_family;
+	/* network address of nexthop; skips fib lookup to find gateway */
+	union {
+		__be32		ipv4_nh;
+		__u32		ipv6_nh[4];  /* in6_addr; network order */
+	};
+};
+
 enum bpf_task_fd_type {
 	BPF_FD_TYPE_RAW_TRACEPOINT,	/* tp name */
 	BPF_FD_TYPE_TRACEPOINT,		/* tp name */

