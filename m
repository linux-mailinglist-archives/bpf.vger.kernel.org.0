Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C1C741833
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 20:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbjF1Suu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Jun 2023 14:50:50 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:57835 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjF1Su3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Jun 2023 14:50:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1687978230; x=1719514230;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0C6AI79x8rcE4/d5YSavZ3njDTjpbEI5cdT3SSecK+w=;
  b=lM4fm9zyulqABTAO0DA00Q0UctdKzz3QNZMQASUYDvr3JrpCeNL+Gk3d
   OzT6DHJ/UT3q5FEQLnHeX+1HUozrY67QRLHhtx0zOQaxff43SvBZI/M00
   eeZkRevec7jF5WxAlqkGN5olGUaZwg32HS4ednlTH1UEmWJ0naWZ2tDSd
   8=;
X-IronPort-AV: E=Sophos;i="6.01,166,1684800000"; 
   d="scan'208";a="336712928"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-8a14c045.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 18:50:24 +0000
Received: from EX19MTAUWC002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2a-m6i4x-8a14c045.us-west-2.amazon.com (Postfix) with ESMTPS id 48C7B805C7;
        Wed, 28 Jun 2023 18:50:22 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 28 Jun 2023 18:50:21 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.170.50) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 28 Jun 2023 18:50:16 +0000
From:   Kuniyuki Iwashima <kuniyu@amazon.com>
To:     <lmb@isovalent.com>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>, <davem@davemloft.net>,
        <dsahern@kernel.org>, <edumazet@google.com>, <haoluo@google.com>,
        <hemanthmalla@gmail.com>, <joe@cilium.io>, <joe@wand.net.nz>,
        <john.fastabend@gmail.com>, <jolsa@kernel.org>,
        <kpsingh@kernel.org>, <kuba@kernel.org>, <kuniyu@amazon.com>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <martin.lau@linux.dev>, <mykolal@fb.com>, <netdev@vger.kernel.org>,
        <pabeni@redhat.com>, <sdf@google.com>, <shuah@kernel.org>,
        <song@kernel.org>, <willemdebruijn.kernel@gmail.com>, <yhs@fb.com>
Subject: Re: [PATCH bpf-next v4 6/7] bpf, net: Support SO_REUSEPORT sockets with bpf_sk_assign
Date:   Wed, 28 Jun 2023 11:50:06 -0700
Message-ID: <20230628185006.76632-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230613-so-reuseport-v4-6-4ece76708bba@isovalent.com>
References: <20230613-so-reuseport-v4-6-4ece76708bba@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.170.50]
X-ClientProxiedBy: EX19D041UWB003.ant.amazon.com (10.13.139.176) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Lorenz Bauer <lmb@isovalent.com>
Date: Wed, 28 Jun 2023 10:48:21 +0100
> Currently the bpf_sk_assign helper in tc BPF context refuses SO_REUSEPORT
> sockets. This means we can't use the helper to steer traffic to Envoy,
> which configures SO_REUSEPORT on its sockets. In turn, we're blocked
> from removing TPROXY from our setup.
> 
> The reason that bpf_sk_assign refuses such sockets is that the
> bpf_sk_lookup helpers don't execute SK_REUSEPORT programs. Instead,
> one of the reuseport sockets is selected by hash. This could cause
> dispatch to the "wrong" socket:
> 
>     sk = bpf_sk_lookup_tcp(...) // select SO_REUSEPORT by hash
>     bpf_sk_assign(skb, sk) // SK_REUSEPORT wasn't executed
> 
> Fixing this isn't as simple as invoking SK_REUSEPORT from the lookup
> helpers unfortunately. In the tc context, L2 headers are at the start
> of the skb, while SK_REUSEPORT expects L3 headers instead.
> 
> Instead, we execute the SK_REUSEPORT program when the assigned socket
> is pulled out of the skb, further up the stack. This creates some
> trickiness with regards to refcounting as bpf_sk_assign will put both
> refcounted and RCU freed sockets in skb->sk. reuseport sockets are RCU
> freed. We can infer that the sk_assigned socket is RCU freed if the
> reuseport lookup succeeds, but convincing yourself of this fact isn't
> straight forward. Therefore we defensively check refcounting on the
> sk_assign sock even though it's probably not required in practice.
> 
> Fixes: 8e368dc72e86 ("bpf: Fix use of sk->sk_reuseport from sk_assign")
> Fixes: cf7fbe660f2d ("bpf: Add socket assign support")
> Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
> Cc: Joe Stringer <joe@cilium.io>
> Link: https://lore.kernel.org/bpf/CACAyw98+qycmpQzKupquhkxbvWK4OFyDuuLMBNROnfWMZxUWeA@mail.gmail.com/

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

I left minor comments below, but this series overall looks good.

Thanks!


> ---
>  include/net/inet6_hashtables.h | 56 ++++++++++++++++++++++++++++++++++++++----
>  include/net/inet_hashtables.h  | 49 ++++++++++++++++++++++++++++++++++--
>  include/net/sock.h             |  7 ++++--
>  include/uapi/linux/bpf.h       |  3 ---
>  net/core/filter.c              |  2 --
>  net/ipv4/udp.c                 |  8 ++++--
>  net/ipv6/udp.c                 | 10 +++++---
>  tools/include/uapi/linux/bpf.h |  3 ---
>  8 files changed, 116 insertions(+), 22 deletions(-)
> 
> diff --git a/include/net/inet6_hashtables.h b/include/net/inet6_hashtables.h
> index a6722d6ef80f..7d677b89f269 100644
> --- a/include/net/inet6_hashtables.h
> +++ b/include/net/inet6_hashtables.h
> @@ -103,6 +103,46 @@ static inline struct sock *__inet6_lookup(struct net *net,
>  				     daddr, hnum, dif, sdif);
>  }
>  
> +static inline
> +struct sock *inet6_steal_sock(struct net *net, struct sk_buff *skb, int doff,
> +			      const struct in6_addr *saddr, const __be16 sport,
> +			      const struct in6_addr *daddr, const __be16 dport,
> +			      bool *refcounted, inet6_ehashfn_t *ehashfn)
> +{
> +	struct sock *sk, *reuse_sk;
> +	bool prefetched;
> +
> +	sk = skb_steal_sock(skb, refcounted, &prefetched);
> +	if (!sk)
> +		return NULL;
> +
> +	if (!prefetched)
> +		return sk;
> +
> +	if (sk->sk_protocol == IPPROTO_TCP) {
> +		if (sk->sk_state != TCP_LISTEN)
> +			return sk;
> +	} else if (sk->sk_protocol == IPPROTO_UDP) {
> +		if (sk->sk_state != TCP_CLOSE)
> +			return sk;
> +	} else {
> +		return sk;
> +	}
> +
> +	reuse_sk = inet6_lookup_reuseport(net, sk, skb, doff,
> +					  saddr, sport, daddr, ntohs(dport),
> +					  ehashfn);
> +	if (!reuse_sk || reuse_sk == sk)

nit: compiler might have optimised though, given here is the fast path,
we can save reuse_sk == sk check.


> +		return sk;
> +
> +	/* We've chosen a new reuseport sock which is never refcounted. This
> +	 * implies that sk also isn't refcounted.
> +	 */
> +	WARN_ON_ONCE(*refcounted);
> +
> +	return reuse_sk;
> +}
> +
>  static inline struct sock *__inet6_lookup_skb(struct inet_hashinfo *hashinfo,
>  					      struct sk_buff *skb, int doff,
>  					      const __be16 sport,
> @@ -110,14 +150,20 @@ static inline struct sock *__inet6_lookup_skb(struct inet_hashinfo *hashinfo,
>  					      int iif, int sdif,
>  					      bool *refcounted)
>  {
> -	struct sock *sk = skb_steal_sock(skb, refcounted);
> -
> +	struct net *net = dev_net(skb_dst(skb)->dev);
> +	const struct ipv6hdr *ip6h = ipv6_hdr(skb);
> +	struct sock *sk;
> +
> +	sk = inet6_steal_sock(net, skb, doff, &ip6h->saddr, sport, &ip6h->daddr, dport,
> +			      refcounted, inet6_ehashfn);
> +	if (IS_ERR(sk))
> +		return NULL;
>  	if (sk)
>  		return sk;
>  
> -	return __inet6_lookup(dev_net(skb_dst(skb)->dev), hashinfo, skb,
> -			      doff, &ipv6_hdr(skb)->saddr, sport,
> -			      &ipv6_hdr(skb)->daddr, ntohs(dport),
> +	return __inet6_lookup(net, hashinfo, skb,
> +			      doff, &ip6h->saddr, sport,
> +			      &ip6h->daddr, ntohs(dport),
>  			      iif, sdif, refcounted);
>  }
>  
> diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
> index c0532cc7587f..c6ae0af12ce0 100644
> --- a/include/net/inet_hashtables.h
> +++ b/include/net/inet_hashtables.h
> @@ -449,6 +449,46 @@ static inline struct sock *inet_lookup(struct net *net,
>  	return sk;
>  }
>  
> +static inline
> +struct sock *inet_steal_sock(struct net *net, struct sk_buff *skb, int doff,
> +			     const __be32 saddr, const __be16 sport,
> +			     const __be32 daddr, const __be16 dport,
> +			     bool *refcounted, inet_ehashfn_t *ehashfn)
> +{
> +	struct sock *sk, *reuse_sk;
> +	bool prefetched;
> +
> +	sk = skb_steal_sock(skb, refcounted, &prefetched);
> +	if (!sk)
> +		return NULL;
> +
> +	if (!prefetched)
> +		return sk;
> +
> +	if (sk->sk_protocol == IPPROTO_TCP) {
> +		if (sk->sk_state != TCP_LISTEN)
> +			return sk;
> +	} else if (sk->sk_protocol == IPPROTO_UDP) {
> +		if (sk->sk_state != TCP_CLOSE)
> +			return sk;
> +	} else {
> +		return sk;
> +	}
> +
> +	reuse_sk = inet_lookup_reuseport(net, sk, skb, doff,
> +					 saddr, sport, daddr, ntohs(dport),
> +					 ehashfn);
> +	if (!reuse_sk || reuse_sk == sk)

Same here.


> +		return sk;
> +
> +	/* We've chosen a new reuseport sock which is never refcounted. This
> +	 * implies that sk also isn't refcounted.
> +	 */
> +	WARN_ON_ONCE(*refcounted);
> +
> +	return reuse_sk;
> +}
> +
>  static inline struct sock *__inet_lookup_skb(struct inet_hashinfo *hashinfo,
>  					     struct sk_buff *skb,
>  					     int doff,
> @@ -457,13 +497,18 @@ static inline struct sock *__inet_lookup_skb(struct inet_hashinfo *hashinfo,
>  					     const int sdif,
>  					     bool *refcounted)
>  {
> -	struct sock *sk = skb_steal_sock(skb, refcounted);
> +	struct net *net = dev_net(skb_dst(skb)->dev);
>  	const struct iphdr *iph = ip_hdr(skb);
> +	struct sock *sk;
>  
> +	sk = inet_steal_sock(net, skb, doff, iph->saddr, sport, iph->daddr, dport,
> +			     refcounted, inet_ehashfn);
> +	if (IS_ERR(sk))
> +		return NULL;
>  	if (sk)
>  		return sk;
>  
> -	return __inet_lookup(dev_net(skb_dst(skb)->dev), hashinfo, skb,
> +	return __inet_lookup(net, hashinfo, skb,
>  			     doff, iph->saddr, sport,
>  			     iph->daddr, dport, inet_iif(skb), sdif,
>  			     refcounted);
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 656ea89f60ff..5645570c2a64 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -2806,20 +2806,23 @@ sk_is_refcounted(struct sock *sk)
>   * skb_steal_sock - steal a socket from an sk_buff
>   * @skb: sk_buff to steal the socket from
>   * @refcounted: is set to true if the socket is reference-counted
> + * @prefetched: is set to true if the socket was assigned from bpf
>   */
>  static inline struct sock *
> -skb_steal_sock(struct sk_buff *skb, bool *refcounted)
> +skb_steal_sock(struct sk_buff *skb, bool *refcounted, bool *prefetched)
>  {
>  	if (skb->sk) {
>  		struct sock *sk = skb->sk;
>  
>  		*refcounted = true;
> -		if (skb_sk_is_prefetched(skb))
> +		*prefetched = skb_sk_is_prefetched(skb);
> +		if (*prefetched)
>  			*refcounted = sk_is_refcounted(sk);
>  		skb->destructor = NULL;
>  		skb->sk = NULL;
>  		return sk;
>  	}
> +	*prefetched = false;
>  	*refcounted = false;
>  	return NULL;
>  }
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index a7b5e91dd768..d6fb6f43b0f3 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -4158,9 +4158,6 @@ union bpf_attr {
>   *		**-EOPNOTSUPP** if the operation is not supported, for example
>   *		a call from outside of TC ingress.
>   *
> - *		**-ESOCKTNOSUPPORT** if the socket type is not supported
> - *		(reuseport).
> - *
>   * long bpf_sk_assign(struct bpf_sk_lookup *ctx, struct bpf_sock *sk, u64 flags)
>   *	Description
>   *		Helper is overloaded depending on BPF program type. This
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 428df050d021..d4be0a1d754c 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -7278,8 +7278,6 @@ BPF_CALL_3(bpf_sk_assign, struct sk_buff *, skb, struct sock *, sk, u64, flags)
>  		return -EOPNOTSUPP;
>  	if (unlikely(dev_net(skb->dev) != sock_net(sk)))
>  		return -ENETUNREACH;
> -	if (unlikely(sk_fullsock(sk) && sk->sk_reuseport))
> -		return -ESOCKTNOSUPPORT;
>  	if (sk_is_refcounted(sk) &&
>  	    unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
>  		return -ENOENT;
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index eb79268f216d..b256f1f73b4d 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -2388,7 +2388,11 @@ int __udp4_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
>  	if (udp4_csum_init(skb, uh, proto))
>  		goto csum_error;
>  
> -	sk = skb_steal_sock(skb, &refcounted);
> +	sk = inet_steal_sock(net, skb, sizeof(struct udphdr), saddr, uh->source, daddr, uh->dest,
> +			     &refcounted, udp_ehashfn);
> +	if (IS_ERR(sk))
> +		goto no_sk;
> +
>  	if (sk) {
>  		struct dst_entry *dst = skb_dst(skb);
>  		int ret;
> @@ -2409,7 +2413,7 @@ int __udp4_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
>  	sk = __udp4_lib_lookup_skb(skb, uh->source, uh->dest, udptable);
>  	if (sk)
>  		return udp_unicast_rcv_skb(sk, skb, uh);
> -
> +no_sk:
>  	if (!xfrm4_policy_check(NULL, XFRM_POLICY_IN, skb))
>  		goto drop;
>  	nf_reset_ct(skb);
> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> index 8a6d94cabee0..2d4c05bc322a 100644
> --- a/net/ipv6/udp.c
> +++ b/net/ipv6/udp.c
> @@ -923,9 +923,9 @@ int __udp6_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
>  	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
>  	const struct in6_addr *saddr, *daddr;
>  	struct net *net = dev_net(skb->dev);
> +	bool refcounted;
>  	struct udphdr *uh;
>  	struct sock *sk;
> -	bool refcounted;
>  	u32 ulen = 0;
>  
>  	if (!pskb_may_pull(skb, sizeof(struct udphdr)))
> @@ -962,7 +962,11 @@ int __udp6_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
>  		goto csum_error;
>  
>  	/* Check if the socket is already available, e.g. due to early demux */
> -	sk = skb_steal_sock(skb, &refcounted);
> +	sk = inet6_steal_sock(net, skb, sizeof(struct udphdr), saddr, uh->source, daddr, uh->dest,
> +			      &refcounted, udp6_ehashfn);
> +	if (IS_ERR(sk))
> +		goto no_sk;
> +
>  	if (sk) {
>  		struct dst_entry *dst = skb_dst(skb);
>  		int ret;
> @@ -996,7 +1000,7 @@ int __udp6_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
>  			goto report_csum_error;
>  		return udp6_unicast_rcv_skb(sk, skb, uh);
>  	}
> -
> +no_sk:
>  	reason = SKB_DROP_REASON_NO_SOCKET;
>  
>  	if (!uh->check)
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index a7b5e91dd768..d6fb6f43b0f3 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -4158,9 +4158,6 @@ union bpf_attr {
>   *		**-EOPNOTSUPP** if the operation is not supported, for example
>   *		a call from outside of TC ingress.
>   *
> - *		**-ESOCKTNOSUPPORT** if the socket type is not supported
> - *		(reuseport).
> - *
>   * long bpf_sk_assign(struct bpf_sk_lookup *ctx, struct bpf_sock *sk, u64 flags)
>   *	Description
>   *		Helper is overloaded depending on BPF program type. This
> 
> -- 
> 2.40.1
