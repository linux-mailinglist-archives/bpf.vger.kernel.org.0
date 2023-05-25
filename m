Return-Path: <bpf+bounces-1240-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E03B47112B6
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 19:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 874561C20E93
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 17:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB9F1EA7B;
	Thu, 25 May 2023 17:42:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBBE101DA;
	Thu, 25 May 2023 17:42:38 +0000 (UTC)
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8851716;
	Thu, 25 May 2023 10:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1685036519; x=1716572519;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QJ9ADxImvjDykmk/8xiVoztm58jHLtn+k2Fmt5zlId4=;
  b=Kjoabjjq4SjqaPqt2iKoHJs2mD2KkMrjP/0CTYl4d/HflqZQNwBQQb3u
   YDf/in8QlpHcv2SGF58+qY1v9l47JDx5U36OqEuNjr1819NXZbbGqtWs4
   yTKzDLOdEuyIv3a/fKDNgnEhOZHTgqdCjsYq7WrL/CtBCEHar45J0TuX/
   4=;
X-IronPort-AV: E=Sophos;i="6.00,191,1681171200"; 
   d="scan'208";a="585586602"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-b404fda3.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 17:41:55 +0000
Received: from EX19MTAUWA002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
	by email-inbound-relay-iad-1d-m6i4x-b404fda3.us-east-1.amazon.com (Postfix) with ESMTPS id EFB31803BA;
	Thu, 25 May 2023 17:41:48 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 25 May 2023 17:41:43 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.54) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 25 May 2023 17:41:39 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <lmb@isovalent.com>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<daniel@iogearbox.net>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<edumazet@google.com>, <haoluo@google.com>, <joe@cilium.io>,
	<joe@wand.net.nz>, <john.fastabend@gmail.com>, <jolsa@kernel.org>,
	<kafai@fb.com>, <kpsingh@kernel.org>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <martin.lau@linux.dev>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <sdf@google.com>,
	<song@kernel.org>, <willemdebruijn.kernel@gmail.com>, <yhs@fb.com>,
	<kuniyu@amazon.com>
Subject: [PATCH bpf-next 1/2] bpf, net: Support SO_REUSEPORT sockets with bpf_sk_assign
Date: Thu, 25 May 2023 10:41:31 -0700
Message-ID: <20230525174131.4706-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230525081923.8596-1-lmb@isovalent.com>
References: <20230525081923.8596-1-lmb@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.170.54]
X-ClientProxiedBy: EX19D043UWA001.ant.amazon.com (10.13.139.45) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Lorenz Bauer <lmb@isovalent.com>
Date: Thu, 25 May 2023 09:19:22 +0100
> Currently the bpf_sk_assign helper in tc BPF context refuses SO_REUSEPORT
> sockets. This means we can't use the helper to steer traffic to Envoy, which
> configures SO_REUSEPORT on its sockets. In turn, we're blocked from removing
> TPROXY from our setup.
> 
> The reason that bpf_sk_assign refuses such sockets is that the bpf_sk_lookup
> helpers don't execute SK_REUSEPORT programs. Instead, one of the
> reuseport sockets is selected by hash. This could cause dispatch to the
> "wrong" socket:
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
> Fixes: 8e368dc ("bpf: Fix use of sk->sk_reuseport from sk_assign")
> Fixes: cf7fbe6 ("bpf: Add socket assign support")

Please use 12 chars of hash.

---8<---
$ cat ~/.gitconfig
[core]
	abbrev = 12
[pretty]
	fixes = Fixes: %h (\"%s\")

$ git show 8e368dc --pretty=fixes | head -n 1
Fixes: 8e368dc72e86 ("bpf: Fix use of sk->sk_reuseport from sk_assign")
---8<---


> Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
> Cc: Joe Stringer <joe@cilium.io>
> Link: https://lore.kernel.org/bpf/CACAyw98+qycmpQzKupquhkxbvWK4OFyDuuLMBNROnfWMZxUWeA@mail.gmail.com/
> ---
>  include/net/inet6_hashtables.h | 36 +++++++++++++++++++++++++++++-----
>  include/net/inet_hashtables.h  | 27 +++++++++++++++++++++++--
>  include/net/sock.h             |  7 +++++--
>  include/uapi/linux/bpf.h       |  3 ---
>  net/core/filter.c              |  2 --
>  net/ipv4/inet_hashtables.c     | 15 +++++++-------
>  net/ipv4/udp.c                 | 23 +++++++++++++++++++---
>  net/ipv6/inet6_hashtables.c    | 19 +++++++++---------
>  net/ipv6/udp.c                 | 23 +++++++++++++++++++---
>  tools/include/uapi/linux/bpf.h |  3 ---
>  10 files changed, 119 insertions(+), 39 deletions(-)
> 
> diff --git a/include/net/inet6_hashtables.h b/include/net/inet6_hashtables.h
> index 56f1286583d3..3ba4dc2703da 100644
> --- a/include/net/inet6_hashtables.h
> +++ b/include/net/inet6_hashtables.h
> @@ -48,6 +48,13 @@ struct sock *__inet6_lookup_established(struct net *net,
>  					const u16 hnum, const int dif,
>  					const int sdif);
>  
> +struct sock *inet6_lookup_reuseport(struct net *net, struct sock *sk,
> +				    struct sk_buff *skb, int doff,
> +				    const struct in6_addr *saddr,
> +				    __be16 sport,
> +				    const struct in6_addr *daddr,
> +				    unsigned short hnum);
> +
>  struct sock *inet6_lookup_listener(struct net *net,
>  				   struct inet_hashinfo *hashinfo,
>  				   struct sk_buff *skb, int doff,
> @@ -85,14 +92,33 @@ static inline struct sock *__inet6_lookup_skb(struct inet_hashinfo *hashinfo,
>  					      int iif, int sdif,
>  					      bool *refcounted)
>  {
> -	struct sock *sk = skb_steal_sock(skb, refcounted);
> -
> +	bool prefetched;
> +	struct sock *sk = skb_steal_sock(skb, refcounted, &prefetched);
> +	struct net *net = dev_net(skb_dst(skb)->dev);
> +	const struct ipv6hdr *ip6h = ipv6_hdr(skb);

nit: Reverse Xmas Tree order.  Same for other chunks.


> +
> +	if (prefetched) {
> +		struct sock *reuse_sk = inet6_lookup_reuseport(net, sk, skb, doff,
> +							       &ip6h->saddr, sport,
> +							       &ip6h->daddr, ntohs(dport));
> +		if (reuse_sk) {
> +			if (reuse_sk != sk) {
> +				if (*refcounted) {
> +					sock_put(sk);
> +					*refcounted = false;
> +				}
> +				if (IS_ERR(reuse_sk))
> +					return NULL;
> +			}
> +			return reuse_sk;
> +		}

Maybe we can add a hepler to avoid this duplication ?


> +	}
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
> index 99bd823e97f6..c2af195ca71f 100644
> --- a/include/net/inet_hashtables.h
> +++ b/include/net/inet_hashtables.h
> @@ -379,6 +379,11 @@ struct sock *__inet_lookup_established(struct net *net,
>  				       const __be32 daddr, const u16 hnum,
>  				       const int dif, const int sdif);
>  
> +struct sock *inet_lookup_reuseport(struct net *net, struct sock *sk,
> +				   struct sk_buff *skb, int doff,
> +				   __be32 saddr, __be16 sport,
> +				   __be32 daddr, unsigned short hnum);
> +
>  static inline struct sock *
>  	inet_lookup_established(struct net *net, struct inet_hashinfo *hashinfo,
>  				const __be32 saddr, const __be16 sport,
> @@ -436,13 +441,31 @@ static inline struct sock *__inet_lookup_skb(struct inet_hashinfo *hashinfo,
>  					     const int sdif,
>  					     bool *refcounted)
>  {
> -	struct sock *sk = skb_steal_sock(skb, refcounted);
> +	bool prefetched;
> +	struct sock *sk = skb_steal_sock(skb, refcounted, &prefetched);
> +	struct net *net = dev_net(skb_dst(skb)->dev);
>  	const struct iphdr *iph = ip_hdr(skb);
>  
> +	if (prefetched) {
> +		struct sock *reuse_sk = inet_lookup_reuseport(net, sk, skb, doff,
> +							      iph->saddr, sport,
> +							      iph->daddr, ntohs(dport));
> +		if (reuse_sk) {
> +			if (reuse_sk != sk) {
> +				if (*refcounted) {
> +					sock_put(sk);
> +					*refcounted = false;
> +				}
> +				if (IS_ERR(reuse_sk))
> +					return NULL;
> +			}
> +			return reuse_sk;
> +		}
> +	}
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
> index 1bb11a6ee667..2af606a525db 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -4144,9 +4144,6 @@ union bpf_attr {
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
> index 968139f4a1ac..5f451260849b 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -7265,8 +7265,6 @@ BPF_CALL_3(bpf_sk_assign, struct sk_buff *, skb, struct sock *, sk, u64, flags)
>  		return -EOPNOTSUPP;
>  	if (unlikely(dev_net(skb->dev) != sock_net(sk)))
>  		return -ENETUNREACH;
> -	if (unlikely(sk_fullsock(sk) && sk->sk_reuseport))
> -		return -ESOCKTNOSUPPORT;
>  	if (sk_is_refcounted(sk) &&
>  	    unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
>  		return -ENOENT;
> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> index e7391bf310a7..920131e4a65d 100644
> --- a/net/ipv4/inet_hashtables.c
> +++ b/net/ipv4/inet_hashtables.c
> @@ -332,10 +332,10 @@ static inline int compute_score(struct sock *sk, struct net *net,
>  	return score;
>  }
>  
> -static inline struct sock *lookup_reuseport(struct net *net, struct sock *sk,
> -					    struct sk_buff *skb, int doff,
> -					    __be32 saddr, __be16 sport,
> -					    __be32 daddr, unsigned short hnum)
> +struct sock *inet_lookup_reuseport(struct net *net, struct sock *sk,
> +				   struct sk_buff *skb, int doff,
> +				   __be32 saddr, __be16 sport,
> +				   __be32 daddr, unsigned short hnum)
>  {
>  	struct sock *reuse_sk = NULL;
>  	u32 phash;
> @@ -346,6 +346,7 @@ static inline struct sock *lookup_reuseport(struct net *net, struct sock *sk,
>  	}
>  	return reuse_sk;
>  }
> +EXPORT_SYMBOL_GPL(inet_lookup_reuseport);
>  
>  /*
>   * Here are some nice properties to exploit here. The BSD API
> @@ -369,8 +370,8 @@ static struct sock *inet_lhash2_lookup(struct net *net,
>  	sk_nulls_for_each_rcu(sk, node, &ilb2->nulls_head) {
>  		score = compute_score(sk, net, hnum, daddr, dif, sdif);
>  		if (score > hiscore) {
> -			result = lookup_reuseport(net, sk, skb, doff,
> -						  saddr, sport, daddr, hnum);
> +			result = inet_lookup_reuseport(net, sk, skb, doff,
> +						       saddr, sport, daddr, hnum);
>  			if (result)
>  				return result;
>  
> @@ -399,7 +400,7 @@ static inline struct sock *inet_lookup_run_bpf(struct net *net,
>  	if (no_reuseport || IS_ERR_OR_NULL(sk))
>  		return sk;
>  
> -	reuse_sk = lookup_reuseport(net, sk, skb, doff, saddr, sport, daddr, hnum);
> +	reuse_sk = inet_lookup_reuseport(net, sk, skb, doff, saddr, sport, daddr, hnum);
>  	if (reuse_sk)
>  		sk = reuse_sk;
>  	return sk;
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 6893fb867529..c67253386a38 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -2426,7 +2426,7 @@ int __udp4_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
>  	struct rtable *rt = skb_rtable(skb);
>  	__be32 saddr, daddr;
>  	struct net *net = dev_net(skb->dev);
> -	bool refcounted;
> +	bool refcounted, prefetched;
>  	int drop_reason;
>  
>  	drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
> @@ -2455,11 +2455,28 @@ int __udp4_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
>  	if (udp4_csum_init(skb, uh, proto))
>  		goto csum_error;
>  
> -	sk = skb_steal_sock(skb, &refcounted);
> +	sk = skb_steal_sock(skb, &refcounted, &prefetched);
>  	if (sk) {
>  		struct dst_entry *dst = skb_dst(skb);
>  		int ret;
>  
> +		if (prefetched) {
> +			struct sock *reuse_sk = lookup_reuseport(net, sk, skb,
> +								 saddr, uh->source,
> +								 daddr, ntohs(uh->dest));
> +			if (reuse_sk) {
> +				if (reuse_sk != sk) {
> +					if (refcounted) {
> +						sock_put(sk);
> +						refcounted = false;
> +					}
> +					if (IS_ERR(reuse_sk))
> +						goto no_sk;
> +				}
> +				sk = reuse_sk;
> +			}
> +		}
> +
>  		if (unlikely(rcu_dereference(sk->sk_rx_dst) != dst))
>  			udp_sk_rx_dst_set(sk, dst);
>  
> @@ -2476,7 +2493,7 @@ int __udp4_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
>  	sk = __udp4_lib_lookup_skb(skb, uh->source, uh->dest, udptable);
>  	if (sk)
>  		return udp_unicast_rcv_skb(sk, skb, uh);
> -
> +no_sk:
>  	if (!xfrm4_policy_check(NULL, XFRM_POLICY_IN, skb))
>  		goto drop;
>  	nf_reset_ct(skb);
> diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
> index b64b49012655..b7c56867314e 100644
> --- a/net/ipv6/inet6_hashtables.c
> +++ b/net/ipv6/inet6_hashtables.c
> @@ -111,12 +111,12 @@ static inline int compute_score(struct sock *sk, struct net *net,
>  	return score;
>  }
>  
> -static inline struct sock *lookup_reuseport(struct net *net, struct sock *sk,
> -					    struct sk_buff *skb, int doff,
> -					    const struct in6_addr *saddr,
> -					    __be16 sport,
> -					    const struct in6_addr *daddr,
> -					    unsigned short hnum)
> +struct sock *inet6_lookup_reuseport(struct net *net, struct sock *sk,
> +				    struct sk_buff *skb, int doff,
> +				    const struct in6_addr *saddr,
> +				    __be16 sport,
> +				    const struct in6_addr *daddr,
> +				    unsigned short hnum)
>  {
>  	struct sock *reuse_sk = NULL;
>  	u32 phash;
> @@ -127,6 +127,7 @@ static inline struct sock *lookup_reuseport(struct net *net, struct sock *sk,
>  	}
>  	return reuse_sk;
>  }
> +EXPORT_SYMBOL_GPL(inet6_lookup_reuseport);
>  
>  /* called with rcu_read_lock() */
>  static struct sock *inet6_lhash2_lookup(struct net *net,
> @@ -143,8 +144,8 @@ static struct sock *inet6_lhash2_lookup(struct net *net,
>  	sk_nulls_for_each_rcu(sk, node, &ilb2->nulls_head) {
>  		score = compute_score(sk, net, hnum, daddr, dif, sdif);
>  		if (score > hiscore) {
> -			result = lookup_reuseport(net, sk, skb, doff,
> -						  saddr, sport, daddr, hnum);
> +			result = inet6_lookup_reuseport(net, sk, skb, doff,
> +							saddr, sport, daddr, hnum);
>  			if (result)
>  				return result;
>  
> @@ -175,7 +176,7 @@ static inline struct sock *inet6_lookup_run_bpf(struct net *net,
>  	if (no_reuseport || IS_ERR_OR_NULL(sk))
>  		return sk;
>  
> -	reuse_sk = lookup_reuseport(net, sk, skb, doff, saddr, sport, daddr, hnum);
> +	reuse_sk = inet6_lookup_reuseport(net, sk, skb, doff, saddr, sport, daddr, hnum);
>  	if (reuse_sk)
>  		sk = reuse_sk;
>  	return sk;
> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> index e5a337e6b970..3fede8ec95c4 100644
> --- a/net/ipv6/udp.c
> +++ b/net/ipv6/udp.c
> @@ -949,7 +949,7 @@ int __udp6_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
>  	struct net *net = dev_net(skb->dev);
>  	struct udphdr *uh;
>  	struct sock *sk;
> -	bool refcounted;
> +	bool refcounted, prefetched;
>  	u32 ulen = 0;
>  
>  	if (!pskb_may_pull(skb, sizeof(struct udphdr)))
> @@ -986,11 +986,28 @@ int __udp6_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
>  		goto csum_error;
>  
>  	/* Check if the socket is already available, e.g. due to early demux */
> -	sk = skb_steal_sock(skb, &refcounted);
> +	sk = skb_steal_sock(skb, &refcounted, &prefetched);
>  	if (sk) {
>  		struct dst_entry *dst = skb_dst(skb);
>  		int ret;
>  
> +		if (prefetched) {
> +			struct sock *reuse_sk = lookup_reuseport(net, sk, skb,
> +								 saddr, uh->source,
> +								 daddr, ntohs(uh->dest));
> +			if (reuse_sk) {
> +				if (reuse_sk != sk) {
> +					if (refcounted) {
> +						sock_put(sk);
> +						refcounted = false;
> +					}
> +					if (IS_ERR(reuse_sk))
> +						goto no_sk;
> +				}
> +				sk = reuse_sk;
> +			}
> +		}
> +
>  		if (unlikely(rcu_dereference(sk->sk_rx_dst) != dst))
>  			udp6_sk_rx_dst_set(sk, dst);
>  
> @@ -1020,7 +1037,7 @@ int __udp6_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
>  			goto report_csum_error;
>  		return udp6_unicast_rcv_skb(sk, skb, uh);
>  	}
> -
> +no_sk:
>  	reason = SKB_DROP_REASON_NO_SOCKET;
>  
>  	if (!uh->check)
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 1bb11a6ee667..2af606a525db 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -4144,9 +4144,6 @@ union bpf_attr {
>   *		**-EOPNOTSUPP** if the operation is not supported, for example
>   *		a call from outside of TC ingress.
>   *
> - *		**-ESOCKTNOSUPPORT** if the socket type is not supported
> - *		(reuseport).
> - *
>   * long bpf_sk_assign(struct bpf_sk_lookup *ctx, struct bpf_sock *sk, u64 flags)
>   *	Description
>   *		Helper is overloaded depending on BPF program type. This
> -- 
> 2.40.1

