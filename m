Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 438742863A8
	for <lists+bpf@lfdr.de>; Wed,  7 Oct 2020 18:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbgJGQWz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Oct 2020 12:22:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44388 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726702AbgJGQWy (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 7 Oct 2020 12:22:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602087773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ikvHl0SMuAAx/2hFVp4naP5TxS0bA5ToBBRXWlR8ERk=;
        b=Hpa2sjM+nF4gk07Xq6lAZQB7QCuydUdYN8cKZTLah8DZYuU5EYNjtCpTqPXJm3KFh0JUEp
        pbb3uErDFZsO2yafkE2aZZmEbTOMpk23GjZaN8FSD+bl9UltYWBp+9juDUbO775RcRPQ20
        fWaTyabNEcosZg3kclO3q9UpQ5Bh4uI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-Z-GCsxMIMcuiGbHybS9HmQ-1; Wed, 07 Oct 2020 12:22:49 -0400
X-MC-Unique: Z-GCsxMIMcuiGbHybS9HmQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0FC78070E2;
        Wed,  7 Oct 2020 16:22:46 +0000 (UTC)
Received: from firesoul.localdomain (unknown [10.40.208.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 70D3255770;
        Wed,  7 Oct 2020 16:22:46 +0000 (UTC)
Received: from [192.168.42.3] (localhost [IPv6:::1])
        by firesoul.localdomain (Postfix) with ESMTP id 78D6F30736C8B;
        Wed,  7 Oct 2020 18:22:45 +0200 (CEST)
Subject: [PATCH bpf-next V2 2/6] bpf: bpf_fib_lookup return MTU value as
 output when looked up
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     bpf@vger.kernel.org
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>, netdev@vger.kernel.org,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        maze@google.com, lmb@cloudflare.com, shaun@tigera.io,
        Lorenzo Bianconi <lorenzo@kernel.org>, marek@cloudflare.com,
        John Fastabend <john.fastabend@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>, eyal.birger@gmail.com
Date:   Wed, 07 Oct 2020 18:22:45 +0200
Message-ID: <160208776541.798237.663413315328442772.stgit@firesoul>
In-Reply-To: <160208770557.798237.11181325462593441941.stgit@firesoul>
References: <160208770557.798237.11181325462593441941.stgit@firesoul>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The BPF-helpers for FIB lookup (bpf_xdp_fib_lookup and bpf_skb_fib_lookup)
can perform MTU check and return BPF_FIB_LKUP_RET_FRAG_NEEDED.  The BPF-prog
don't know the MTU value that caused this rejection.

If the BPF-prog wants to implement PMTU (Path MTU Discovery) (rfc1191) it
need to know this MTU value for the ICMP packet.

Patch change lookup and result struct bpf_fib_lookup, to contain this MTU
value as output via a union with 'tot_len' as this is the value used for
the MTU lookup.

Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
---
 include/uapi/linux/bpf.h |   11 +++++++++--
 net/core/filter.c        |   17 ++++++++++++-----
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index c446394135be..50ce65e37b16 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -2216,6 +2216,9 @@ union bpf_attr {
  *		* > 0 one of **BPF_FIB_LKUP_RET_** codes explaining why the
  *		  packet is not forwarded or needs assist from full stack
  *
+ *		If lookup fails with BPF_FIB_LKUP_RET_FRAG_NEEDED, then the MTU
+ *		was exceeded and result params->mtu contains the MTU.
+ *
  * long bpf_sock_hash_update(struct bpf_sock_ops *skops, struct bpf_map *map, void *key, u64 flags)
  *	Description
  *		Add an entry to, or update a sockhash *map* referencing sockets.
@@ -4844,9 +4847,13 @@ struct bpf_fib_lookup {
 	__be16	sport;
 	__be16	dport;
 
-	/* total length of packet from network header - used for MTU check */
-	__u16	tot_len;
+	union {	/* used for MTU check */
+		/* input to lookup */
+		__u16	tot_len; /* total length of packet from network hdr */
 
+		/* output: MTU value (if requested check_mtu) */
+		__u16	mtu;
+	};
 	/* input: L3 device index for lookup
 	 * output: device index from FIB lookup
 	 */
diff --git a/net/core/filter.c b/net/core/filter.c
index fed239e77bdc..d84723f347c0 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5185,13 +5185,14 @@ static const struct bpf_func_proto bpf_skb_get_xfrm_state_proto = {
 #if IS_ENABLED(CONFIG_INET) || IS_ENABLED(CONFIG_IPV6)
 static int bpf_fib_set_fwd_params(struct bpf_fib_lookup *params,
 				  const struct neighbour *neigh,
-				  const struct net_device *dev)
+				  const struct net_device *dev, u32 mtu)
 {
 	memcpy(params->dmac, neigh->ha, ETH_ALEN);
 	memcpy(params->smac, dev->dev_addr, ETH_ALEN);
 	params->h_vlan_TCI = 0;
 	params->h_vlan_proto = 0;
 	params->ifindex = dev->ifindex;
+	params->mtu = mtu;
 
 	return 0;
 }
@@ -5275,8 +5276,10 @@ static int bpf_ipv4_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 
 	if (check_mtu) {
 		mtu = ip_mtu_from_fib_result(&res, params->ipv4_dst);
-		if (params->tot_len > mtu)
+		if (params->tot_len > mtu) {
+			params->mtu = mtu; /* union with tot_len */
 			return BPF_FIB_LKUP_RET_FRAG_NEEDED;
+		}
 	}
 
 	nhc = res.nhc;
@@ -5309,7 +5312,7 @@ static int bpf_ipv4_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 	if (!neigh)
 		return BPF_FIB_LKUP_RET_NO_NEIGH;
 
-	return bpf_fib_set_fwd_params(params, neigh, dev);
+	return bpf_fib_set_fwd_params(params, neigh, dev, mtu);
 }
 #endif
 
@@ -5401,8 +5404,10 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 
 	if (check_mtu) {
 		mtu = ipv6_stub->ip6_mtu_from_fib6(&res, dst, src);
-		if (params->tot_len > mtu)
+		if (params->tot_len > mtu) {
+			params->mtu = mtu; /* union with tot_len */
 			return BPF_FIB_LKUP_RET_FRAG_NEEDED;
+		}
 	}
 
 	if (res.nh->fib_nh_lws)
@@ -5421,7 +5426,7 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 	if (!neigh)
 		return BPF_FIB_LKUP_RET_NO_NEIGH;
 
-	return bpf_fib_set_fwd_params(params, neigh, dev);
+	return bpf_fib_set_fwd_params(params, neigh, dev, mtu);
 }
 #endif
 
@@ -5490,6 +5495,8 @@ BPF_CALL_4(bpf_skb_fib_lookup, struct sk_buff *, skb,
 		dev = dev_get_by_index_rcu(net, params->ifindex);
 		if (!is_skb_forwardable(dev, skb))
 			rc = BPF_FIB_LKUP_RET_FRAG_NEEDED;
+
+		params->mtu = dev->mtu; /* union with tot_len */
 	}
 
 	return rc;


