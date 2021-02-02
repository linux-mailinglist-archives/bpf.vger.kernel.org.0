Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A209F30C68C
	for <lists+bpf@lfdr.de>; Tue,  2 Feb 2021 17:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236788AbhBBQv2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Feb 2021 11:51:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33247 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236390AbhBBQ30 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 2 Feb 2021 11:29:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612283222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vpMAGKN1ZW+XTmIlso+xtUb7GLhtgn5xVtFzaXOfeeY=;
        b=jItT+uMWZWxZ3anOdaDVW1/na6MQJKK1fZ4r045r7yi6xfRMh7UB/PYkzRsBtt6UcW2JhW
        EM5OmfS46M4iPdmjPr05rFU/3PVA0lXVSeL4lyBcLPkQIMPNX6O6sA4Cx6uDhjX6OiWu++
        Rn9At7jbcFYNJGZvKhhN4gLzUh2nKfw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-578-ZiuprLRmOci5hY6WK-tWdQ-1; Tue, 02 Feb 2021 11:26:58 -0500
X-MC-Unique: ZiuprLRmOci5hY6WK-tWdQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C03FC59;
        Tue,  2 Feb 2021 16:26:56 +0000 (UTC)
Received: from firesoul.localdomain (unknown [10.40.208.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 05E345D9C6;
        Tue,  2 Feb 2021 16:26:53 +0000 (UTC)
Received: from [192.168.42.3] (localhost [IPv6:::1])
        by firesoul.localdomain (Postfix) with ESMTP id CAF5C30736C73;
        Tue,  2 Feb 2021 17:26:51 +0100 (CET)
Subject: [PATCH bpf-next V15 2/7] bpf: fix bpf_fib_lookup helper MTU check for
 SKB ctx
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     bpf@vger.kernel.org
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>, netdev@vger.kernel.org,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        maze@google.com, lmb@cloudflare.com, shaun@tigera.io,
        Lorenzo Bianconi <lorenzo@kernel.org>, marek@cloudflare.com,
        John Fastabend <john.fastabend@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>, eyal.birger@gmail.com,
        colrack@gmail.com
Date:   Tue, 02 Feb 2021 17:26:51 +0100
Message-ID: <161228321177.576669.11521750082473556168.stgit@firesoul>
In-Reply-To: <161228314075.576669.15427172810948915572.stgit@firesoul>
References: <161228314075.576669.15427172810948915572.stgit@firesoul>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BPF end-user on Cilium slack-channel (Carlo Carraro) wants to use
bpf_fib_lookup for doing MTU-check, but *prior* to extending packet size,
by adjusting fib_params 'tot_len' with the packet length plus the expected
encap size. (Just like the bpf_check_mtu helper supports). He discovered
that for SKB ctx the param->tot_len was not used, instead skb->len was used
(via MTU check in is_skb_forwardable() that checks against netdev MTU).

Fix this by using fib_params 'tot_len' for MTU check. If not provided (e.g.
zero) then keep existing TC behaviour intact. Notice that 'tot_len' for MTU
check is done like XDP code-path, which checks against FIB-dst MTU.

V13:
- Only do ifindex lookup one time, calling dev_get_by_index_rcu().

V10:
- Use same method as XDP for 'tot_len' MTU check

Fixes: 4c79579b44b1 ("bpf: Change bpf_fib_lookup to return lookup status")
Reported-by: Carlo Carraro <colrack@gmail.com>
Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
Acked-by: John Fastabend <john.fastabend@gmail.com>
---
 net/core/filter.c |   50 ++++++++++++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 22 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 5beadd659091..252fbb294001 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5301,22 +5301,18 @@ static int bpf_fib_set_fwd_params(struct bpf_fib_lookup *params,
 #endif
 
 #if IS_ENABLED(CONFIG_INET)
-static int bpf_ipv4_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
+static int bpf_ipv4_fib_lookup(struct net *net, struct net_device *dev,
+			       struct bpf_fib_lookup *params,
 			       u32 flags, bool check_mtu)
 {
 	struct fib_nh_common *nhc;
 	struct in_device *in_dev;
 	struct neighbour *neigh;
-	struct net_device *dev;
 	struct fib_result res;
 	struct flowi4 fl4;
 	int err;
 	u32 mtu;
 
-	dev = dev_get_by_index_rcu(net, params->ifindex);
-	if (unlikely(!dev))
-		return -ENODEV;
-
 	/* verify forwarding is enabled on this interface */
 	in_dev = __in_dev_get_rcu(dev);
 	if (unlikely(!in_dev || !IN_DEV_FORWARD(in_dev)))
@@ -5418,14 +5414,14 @@ static int bpf_ipv4_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 #endif
 
 #if IS_ENABLED(CONFIG_IPV6)
-static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
+static int bpf_ipv6_fib_lookup(struct net *net, struct net_device *dev,
+			       struct bpf_fib_lookup *params,
 			       u32 flags, bool check_mtu)
 {
 	struct in6_addr *src = (struct in6_addr *) params->ipv6_src;
 	struct in6_addr *dst = (struct in6_addr *) params->ipv6_dst;
 	struct fib6_result res = {};
 	struct neighbour *neigh;
-	struct net_device *dev;
 	struct inet6_dev *idev;
 	struct flowi6 fl6;
 	int strict = 0;
@@ -5436,10 +5432,6 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 	if (rt6_need_strict(dst) || rt6_need_strict(src))
 		return BPF_FIB_LKUP_RET_NOT_FWDED;
 
-	dev = dev_get_by_index_rcu(net, params->ifindex);
-	if (unlikely(!dev))
-		return -ENODEV;
-
 	idev = __in6_dev_get_safely(dev);
 	if (unlikely(!idev || !idev->cnf.forwarding))
 		return BPF_FIB_LKUP_RET_FWD_DISABLED;
@@ -5533,22 +5525,27 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 BPF_CALL_4(bpf_xdp_fib_lookup, struct xdp_buff *, ctx,
 	   struct bpf_fib_lookup *, params, int, plen, u32, flags)
 {
+	struct net *net = dev_net(ctx->rxq->dev);
+	struct net_device *dev;
+
 	if (plen < sizeof(*params))
 		return -EINVAL;
 
 	if (flags & ~(BPF_FIB_LOOKUP_DIRECT | BPF_FIB_LOOKUP_OUTPUT))
 		return -EINVAL;
 
+	dev = dev_get_by_index_rcu(net, params->ifindex);
+	if (unlikely(!dev))
+		return -ENODEV;
+
 	switch (params->family) {
 #if IS_ENABLED(CONFIG_INET)
 	case AF_INET:
-		return bpf_ipv4_fib_lookup(dev_net(ctx->rxq->dev), params,
-					   flags, true);
+		return bpf_ipv4_fib_lookup(net, dev, params, flags, true);
 #endif
 #if IS_ENABLED(CONFIG_IPV6)
 	case AF_INET6:
-		return bpf_ipv6_fib_lookup(dev_net(ctx->rxq->dev), params,
-					   flags, true);
+		return bpf_ipv6_fib_lookup(net, dev, params, flags, true);
 #endif
 	}
 	return -EAFNOSUPPORT;
@@ -5568,7 +5565,9 @@ BPF_CALL_4(bpf_skb_fib_lookup, struct sk_buff *, skb,
 	   struct bpf_fib_lookup *, params, int, plen, u32, flags)
 {
 	struct net *net = dev_net(skb->dev);
+	struct net_device *dev;
 	int rc = -EAFNOSUPPORT;
+	bool check_mtu = false;
 
 	if (plen < sizeof(*params))
 		return -EINVAL;
@@ -5576,23 +5575,30 @@ BPF_CALL_4(bpf_skb_fib_lookup, struct sk_buff *, skb,
 	if (flags & ~(BPF_FIB_LOOKUP_DIRECT | BPF_FIB_LOOKUP_OUTPUT))
 		return -EINVAL;
 
+	dev = dev_get_by_index_rcu(net, params->ifindex);
+	if (unlikely(!dev))
+		return -ENODEV;
+
+	if (params->tot_len)
+		check_mtu = true;
+
 	switch (params->family) {
 #if IS_ENABLED(CONFIG_INET)
 	case AF_INET:
-		rc = bpf_ipv4_fib_lookup(net, params, flags, false);
+		rc = bpf_ipv4_fib_lookup(net, dev, params, flags, check_mtu);
 		break;
 #endif
 #if IS_ENABLED(CONFIG_IPV6)
 	case AF_INET6:
-		rc = bpf_ipv6_fib_lookup(net, params, flags, false);
+		rc = bpf_ipv6_fib_lookup(net, dev, params, flags, check_mtu);
 		break;
 #endif
 	}
 
-	if (!rc) {
-		struct net_device *dev;
-
-		dev = dev_get_by_index_rcu(net, params->ifindex);
+	if (rc == BPF_FIB_LKUP_RET_SUCCESS && !check_mtu) {
+		/* When tot_len isn't provided by user,
+		 * check skb against net_device MTU
+		 */
 		if (!is_skb_forwardable(dev, skb))
 			rc = BPF_FIB_LKUP_RET_FRAG_NEEDED;
 	}


