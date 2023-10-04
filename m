Return-Path: <bpf+bounces-11401-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D747B8DD5
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 22:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 482191F23065
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 20:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A2D224E5;
	Wed,  4 Oct 2023 20:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Dkvbo4ZI"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347901B27F
	for <bpf@vger.kernel.org>; Wed,  4 Oct 2023 20:09:21 +0000 (UTC)
Received: from out-210.mta1.migadu.com (out-210.mta1.migadu.com [95.215.58.210])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB40A6
	for <bpf@vger.kernel.org>; Wed,  4 Oct 2023 13:09:19 -0700 (PDT)
Message-ID: <5bef21a3-18c0-e335-d64e-bcd6f1e304a4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1696450157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cKEG8DFxglAjCKMotH39BW8Hr+L7HodS9zAdAitsPcY=;
	b=Dkvbo4ZIzPQnEkEotqu8FSHyTkuh9rE4upGmTV1wDu0WhcyvBz38tnh7AD47apGmAHStZN
	NwCHJPB63CUJhhz2s77gfi1TJY5c+UoDujp4jaTl5re5BMqa/m8TlBOVJLj5PXUas87ckF
	ebh8Iem9+JIzIbmiR7EozvklPU+eUAc=
Date: Wed, 4 Oct 2023 13:09:12 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v2 1/2] bpf: Derive source IP addr via
 bpf_*_fib_lookup()
Content-Language: en-US
To: Martynas Pumputis <m@lambda.lt>
Cc: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 Nikolay Aleksandrov <razor@blackwall.org>, bpf@vger.kernel.org
References: <20231003071013.824623-1-m@lambda.lt>
 <20231003071013.824623-2-m@lambda.lt>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231003071013.824623-2-m@lambda.lt>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/3/23 12:10 AM, Martynas Pumputis wrote:
> Extend the bpf_fib_lookup() helper by making it to return the source
> IPv4/IPv6 address if the BPF_FIB_LOOKUP_SET_SRC flag is set.
> 
> For example, the following snippet can be used to derive the desired
> source IP address:
> 
>      struct bpf_fib_lookup p = { .ipv4_dst = ip4->daddr };
> 
>      ret = bpf_skb_fib_lookup(skb, p, sizeof(p),
>              BPF_FIB_LOOKUP_SET_SRC | BPF_FIB_LOOKUP_SKIP_NEIGH);
>      if (ret != BPF_FIB_LKUP_RET_SUCCESS)
>          return TC_ACT_SHOT;
> 
>      /* the p.ipv4_src now contains the source address */
> 
> The inability to derive the proper source address may cause malfunctions
> in BPF-based dataplanes for hosts containing netdevs with more than one
> routable IP address or for multi-homed hosts.
> 
> For example, Cilium implements packet masquerading in BPF. If an
> egressing netdev to which the Cilium's BPF prog is attached has
> multiple IP addresses, then only one [hardcoded] IP address can be used for
> masquerading. This breaks connectivity if any other IP address should have
> been selected instead, for example, when a public and private addresses
> are attached to the same egress interface.
> 
> The change was tested with Cilium [1].
> 
> Nikolay Aleksandrov helped to figure out the IPv6 addr selection.
> 
> [1]: https://github.com/cilium/cilium/pull/28283
> 
> Signed-off-by: Martynas Pumputis <m@lambda.lt>
> ---
>   include/net/ipv6_stubs.h       |  5 +++++
>   include/uapi/linux/bpf.h       |  9 +++++++++
>   net/core/filter.c              | 19 ++++++++++++++++++-
>   net/ipv6/af_inet6.c            |  1 +
>   tools/include/uapi/linux/bpf.h | 10 ++++++++++
>   5 files changed, 43 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/ipv6_stubs.h b/include/net/ipv6_stubs.h
> index c48186bf4737..21da31e1dff5 100644
> --- a/include/net/ipv6_stubs.h
> +++ b/include/net/ipv6_stubs.h
> @@ -85,6 +85,11 @@ struct ipv6_bpf_stub {
>   			       sockptr_t optval, unsigned int optlen);
>   	int (*ipv6_getsockopt)(struct sock *sk, int level, int optname,
>   			       sockptr_t optval, sockptr_t optlen);
> +	int (*ipv6_dev_get_saddr)(struct net *net,
> +				  const struct net_device *dst_dev,
> +				  const struct in6_addr *daddr,
> +				  unsigned int prefs,
> +				  struct in6_addr *saddr);
>   };
>   extern const struct ipv6_bpf_stub *ipv6_bpf_stub __read_mostly;
>   
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 0448700890f7..a6bf686eecbc 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -3257,6 +3257,10 @@ union bpf_attr {
>    *			and *params*->smac will not be set as output. A common
>    *			use case is to call **bpf_redirect_neigh**\ () after
>    *			doing **bpf_fib_lookup**\ ().
> + *		**BPF_FIB_LOOKUP_SET_SRC**
> + *			Derive and set source IP addr in *params*->ipv{4,6}_src
> + *			for the nexthop. If the src addr cannot be derived,
> + *			**BPF_FIB_LKUP_RET_NO_SRC_ADDR** is returned.
>    *
>    *		*ctx* is either **struct xdp_md** for XDP programs or
>    *		**struct sk_buff** tc cls_act programs.
> @@ -6953,6 +6957,7 @@ enum {
>   	BPF_FIB_LOOKUP_OUTPUT  = (1U << 1),
>   	BPF_FIB_LOOKUP_SKIP_NEIGH = (1U << 2),
>   	BPF_FIB_LOOKUP_TBID    = (1U << 3),
> +	BPF_FIB_LOOKUP_SET_SRC = (1U << 4),

bikeshedding: Shorten it to BPF_FIB_LOOKUP_SRC?

>   };
>   
>   enum {
> @@ -6965,6 +6970,7 @@ enum {
>   	BPF_FIB_LKUP_RET_UNSUPP_LWT,   /* fwd requires encapsulation */
>   	BPF_FIB_LKUP_RET_NO_NEIGH,     /* no neighbor entry for nh */
>   	BPF_FIB_LKUP_RET_FRAG_NEEDED,  /* fragmentation required to fwd */
> +	BPF_FIB_LKUP_RET_NO_SRC_ADDR,  /* failed to derive IP src addr */
>   };
>   
>   struct bpf_fib_lookup {
> @@ -6999,6 +7005,9 @@ struct bpf_fib_lookup {
>   		__u32	rt_metric;
>   	};
>   
> +	/* input: source address to consider for lookup
> +	 * output: source address result from lookup
> +	 */
>   	union {
>   		__be32		ipv4_src;
>   		__u32		ipv6_src[4];  /* in6_addr; network order */
> diff --git a/net/core/filter.c b/net/core/filter.c
> index a094694899c9..f3777ef1840b 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -5850,6 +5850,9 @@ static int bpf_ipv4_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
>   	params->rt_metric = res.fi->fib_priority;
>   	params->ifindex = dev->ifindex;
>   
> +	if (flags & BPF_FIB_LOOKUP_SET_SRC)
> +		params->ipv4_src = fib_result_prefsrc(net, &res);

Does it need to check 0 and return BPF_FIB_LKUP_RET_NO_SRC_ADDR for v4 also,
or the fib_result_prefsrc does not fail?

> +
>   	/* xdp and cls_bpf programs are run in RCU-bh so
>   	 * rcu_read_lock_bh is not needed here
>   	 */
> @@ -5992,6 +5995,19 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
>   	params->rt_metric = res.f6i->fib6_metric;
>   	params->ifindex = dev->ifindex;
>   
> +	if (flags & BPF_FIB_LOOKUP_SET_SRC) {
> +		if (res.f6i->fib6_prefsrc.plen) {
> +			*(struct in6_addr *)params->ipv6_src = res.f6i->fib6_prefsrc.addr;
> +		} else {
> +			err = ipv6_bpf_stub->ipv6_dev_get_saddr(net, dev,
> +								&fl6.daddr, 0,
> +								(struct in6_addr *)
> +								params->ipv6_src);
> +			if (err)
> +				return BPF_FIB_LKUP_RET_NO_SRC_ADDR;

This error also implies BPF_FIB_LKUP_RET_NO_NEIGH. I don't have a clean way of 
improving the API. May be others have some ideas.

Considering dev has no saddr is probably (?) an unlikely case, it should be ok 
to leave it as is but at least a comment in the uapi will be needed. Otherwise, 
the bpf prog may use the 0 dmac as-is.

I feel the current bpf_ipv[46]_fib_lookup helper is doing many things in one 
function and then requires different BPF_FIB_LOOKUP_* bits to select what/how to 
do. In the future, it may be worth to consider breaking it into smaller 
kfunc(s). e.g. the __ipv[46]_neigh_lookup could be in its own kfunc.

> +		}
> +	}
> +
>   	if (flags & BPF_FIB_LOOKUP_SKIP_NEIGH)
>   		goto set_fwd_params;
>   
> @@ -6010,7 +6026,8 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
>   #endif
>   
>   #define BPF_FIB_LOOKUP_MASK (BPF_FIB_LOOKUP_DIRECT | BPF_FIB_LOOKUP_OUTPUT | \
> -			     BPF_FIB_LOOKUP_SKIP_NEIGH | BPF_FIB_LOOKUP_TBID)
> +			     BPF_FIB_LOOKUP_SKIP_NEIGH | BPF_FIB_LOOKUP_TBID | \
> +			     BPF_FIB_LOOKUP_SET_SRC)
>   
>   BPF_CALL_4(bpf_xdp_fib_lookup, struct xdp_buff *, ctx,
>   	   struct bpf_fib_lookup *, params, int, plen, u32, flags)



