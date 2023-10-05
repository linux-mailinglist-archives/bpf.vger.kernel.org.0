Return-Path: <bpf+bounces-11479-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C39217BAB5B
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 22:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 9D815B209EB
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 20:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA88B41E3F;
	Thu,  5 Oct 2023 20:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lambda.lt header.i=@lambda.lt header.b="V39Wov9D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wpm9wjfn"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985C84174F;
	Thu,  5 Oct 2023 20:18:14 +0000 (UTC)
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696309F;
	Thu,  5 Oct 2023 13:18:10 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 1FEF85C0429;
	Thu,  5 Oct 2023 16:18:07 -0400 (EDT)
Received: from imap43 ([10.202.2.93])
  by compute6.internal (MEProxy); Thu, 05 Oct 2023 16:18:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lambda.lt; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1696537087; x=1696623487; bh=xc
	GEVcpZ/lKGP4/o+zI/bWDktQxyuUosIyx4qc3jYek=; b=V39Wov9DqVykP+PJ1/
	WKQPuMWnybkmfn6eHKw0enF9sIlIGZd0bE5vpg/a5LiHI2Tv2mZEWUl470DFH9hD
	fz9EyHjDgvK7X+vJcMZd4rPbHfziFBf2q2F5w1I8fzNxU2tQuR2zzT9jjT/ruoWc
	9GaSiSOWWCT65ijbuVvFPnt1d8Eq9+edY+gaSrf7RTp0On2L0sEnjyTdMya/yZNE
	pZ5XZ7rgJN7qGJxAZqqT3c2GvT4MMSah/Q9Qj71Iv3dM2Ev/HgPZ6k4m0vlzz/ON
	9IoyESQHWeGcTaVq3fRXI0BcK1l7Iu5vrMPUuOMSHIyH3OMx7O6xrXSx+BGIisAT
	jnxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1696537087; x=1696623487; bh=xcGEVcpZ/lKGP
	4/o+zI/bWDktQxyuUosIyx4qc3jYek=; b=Wpm9wjfnlHrthsD7tRALjjMEMQca/
	nQEZ9hJovkUbjS9V7QRh5wRv4v9eht7cqZBB3Y9AW1BURJ9jB7W3q1AerNyysuSC
	ErAJI0VkdegeBpcBmelt+Nk3Vf8oerEdpvffNY1GC9EpvFl/i0jsZsfVhAdCFGd3
	vBmgv84s//aDjqc1UCjwqzAEEgcdUVZHfA6OHo+8yvS+8PxGpQnBIf+ViuPQvo27
	Mw2/n7NS3OmKGJSS7SVjkMcEjyEPCi2d474qVRZ48VGAF3kd0Tqe+BWs3JG3TDib
	nH8YhSAUfKFA0gKJ+WIPJ+45XyRAKUZrIRLP5YKsblhlBhsSdVzp6qJ1g==
X-ME-Sender: <xms:_hkfZQhuLJRUSdNOn1tQeVb5yOzhbdFCQ2x-BGg0AM2TfGc4OD2S0w>
    <xme:_hkfZZAlHKmTSWCNdIdwRcOo_0O6IY_2K02AyM6Uc0fbmuVK9GpD1VvsDi3FPoYb9
    ZSWN7vw1eJ_hhgYc7Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrgeeggddugeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpeforghr
    thihnhgrshcuoehmsehlrghmsggurgdrlhhtqeenucggtffrrghtthgvrhhnpeffvdejie
    dtgfegkeetjedvhfeuieevuefhvdefveduleffveevjefgveekjeehheenucffohhmrghi
    nhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepmheslhgrmhgsuggrrdhlth
X-ME-Proxy: <xmx:_hkfZYG228JjlhikLXDA2-Y27ZDJmsVTo2cgdR6Wo-OprN6PSMX8Kw>
    <xmx:_hkfZRQHVL_JjPURrOZpu4ilk9JtLHjg53chrZUH2kKEupufiVVsng>
    <xmx:_hkfZdy_1g81guML5hbJ5ccwo0tCgNl4867Otpizi5ECtE_uYseRCA>
    <xmx:_xkfZY9sb4fCPIIAqNDAdmA4WHWr5M5d_i8uR2GGJvXKL4chYUfMAg>
Feedback-ID: i215944fb:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 930F72D42D87; Thu,  5 Oct 2023 16:18:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-958-g1b1b911df8-fm-20230927.002-g1b1b911d
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e7b992e3-8059-4058-8561-cb017c200c8d@app.fastmail.com>
In-Reply-To: <5bef21a3-18c0-e335-d64e-bcd6f1e304a4@linux.dev>
References: <20231003071013.824623-1-m@lambda.lt>
 <20231003071013.824623-2-m@lambda.lt>
 <5bef21a3-18c0-e335-d64e-bcd6f1e304a4@linux.dev>
Date: Thu, 05 Oct 2023 22:16:53 +0200
From: Martynas <m@lambda.lt>
To: "Martin KaFai Lau" <martin.lau@linux.dev>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, netdev <netdev@vger.kernel.org>,
 "Nikolay Aleksandrov" <razor@blackwall.org>, bpf@vger.kernel.org
Subject: Re: [PATCH bpf v2 1/2] bpf: Derive source IP addr via bpf_*_fib_lookup()
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thanks for the review.

On Wed, Oct 4, 2023, at 10:09 PM, Martin KaFai Lau wrote:
> On 10/3/23 12:10 AM, Martynas Pumputis wrote:
>> Extend the bpf_fib_lookup() helper by making it to return the source
>> IPv4/IPv6 address if the BPF_FIB_LOOKUP_SET_SRC flag is set.
>> 
>> For example, the following snippet can be used to derive the desired
>> source IP address:
>> 
>>      struct bpf_fib_lookup p = { .ipv4_dst = ip4->daddr };
>> 
>>      ret = bpf_skb_fib_lookup(skb, p, sizeof(p),
>>              BPF_FIB_LOOKUP_SET_SRC | BPF_FIB_LOOKUP_SKIP_NEIGH);
>>      if (ret != BPF_FIB_LKUP_RET_SUCCESS)
>>          return TC_ACT_SHOT;
>> 
>>      /* the p.ipv4_src now contains the source address */
>> 
>> The inability to derive the proper source address may cause malfunctions
>> in BPF-based dataplanes for hosts containing netdevs with more than one
>> routable IP address or for multi-homed hosts.
>> 
>> For example, Cilium implements packet masquerading in BPF. If an
>> egressing netdev to which the Cilium's BPF prog is attached has
>> multiple IP addresses, then only one [hardcoded] IP address can be used for
>> masquerading. This breaks connectivity if any other IP address should have
>> been selected instead, for example, when a public and private addresses
>> are attached to the same egress interface.
>> 
>> The change was tested with Cilium [1].
>> 
>> Nikolay Aleksandrov helped to figure out the IPv6 addr selection.
>> 
>> [1]: https://github.com/cilium/cilium/pull/28283
>> 
>> Signed-off-by: Martynas Pumputis <m@lambda.lt>
>> ---
>>   include/net/ipv6_stubs.h       |  5 +++++
>>   include/uapi/linux/bpf.h       |  9 +++++++++
>>   net/core/filter.c              | 19 ++++++++++++++++++-
>>   net/ipv6/af_inet6.c            |  1 +
>>   tools/include/uapi/linux/bpf.h | 10 ++++++++++
>>   5 files changed, 43 insertions(+), 1 deletion(-)
>> 
>> diff --git a/include/net/ipv6_stubs.h b/include/net/ipv6_stubs.h
>> index c48186bf4737..21da31e1dff5 100644
>> --- a/include/net/ipv6_stubs.h
>> +++ b/include/net/ipv6_stubs.h
>> @@ -85,6 +85,11 @@ struct ipv6_bpf_stub {
>>   			       sockptr_t optval, unsigned int optlen);
>>   	int (*ipv6_getsockopt)(struct sock *sk, int level, int optname,
>>   			       sockptr_t optval, sockptr_t optlen);
>> +	int (*ipv6_dev_get_saddr)(struct net *net,
>> +				  const struct net_device *dst_dev,
>> +				  const struct in6_addr *daddr,
>> +				  unsigned int prefs,
>> +				  struct in6_addr *saddr);
>>   };
>>   extern const struct ipv6_bpf_stub *ipv6_bpf_stub __read_mostly;
>>   
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 0448700890f7..a6bf686eecbc 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -3257,6 +3257,10 @@ union bpf_attr {
>>    *			and *params*->smac will not be set as output. A common
>>    *			use case is to call **bpf_redirect_neigh**\ () after
>>    *			doing **bpf_fib_lookup**\ ().
>> + *		**BPF_FIB_LOOKUP_SET_SRC**
>> + *			Derive and set source IP addr in *params*->ipv{4,6}_src
>> + *			for the nexthop. If the src addr cannot be derived,
>> + *			**BPF_FIB_LKUP_RET_NO_SRC_ADDR** is returned.
>>    *
>>    *		*ctx* is either **struct xdp_md** for XDP programs or
>>    *		**struct sk_buff** tc cls_act programs.
>> @@ -6953,6 +6957,7 @@ enum {
>>   	BPF_FIB_LOOKUP_OUTPUT  = (1U << 1),
>>   	BPF_FIB_LOOKUP_SKIP_NEIGH = (1U << 2),
>>   	BPF_FIB_LOOKUP_TBID    = (1U << 3),
>> +	BPF_FIB_LOOKUP_SET_SRC = (1U << 4),
>
> bikeshedding: Shorten it to BPF_FIB_LOOKUP_SRC?

SGTM.

>
>>   };
>>   
>>   enum {
>> @@ -6965,6 +6970,7 @@ enum {
>>   	BPF_FIB_LKUP_RET_UNSUPP_LWT,   /* fwd requires encapsulation */
>>   	BPF_FIB_LKUP_RET_NO_NEIGH,     /* no neighbor entry for nh */
>>   	BPF_FIB_LKUP_RET_FRAG_NEEDED,  /* fragmentation required to fwd */
>> +	BPF_FIB_LKUP_RET_NO_SRC_ADDR,  /* failed to derive IP src addr */
>>   };
>>   
>>   struct bpf_fib_lookup {
>> @@ -6999,6 +7005,9 @@ struct bpf_fib_lookup {
>>   		__u32	rt_metric;
>>   	};
>>   
>> +	/* input: source address to consider for lookup
>> +	 * output: source address result from lookup
>> +	 */
>>   	union {
>>   		__be32		ipv4_src;
>>   		__u32		ipv6_src[4];  /* in6_addr; network order */
>> diff --git a/net/core/filter.c b/net/core/filter.c
>> index a094694899c9..f3777ef1840b 100644
>> --- a/net/core/filter.c
>> +++ b/net/core/filter.c
>> @@ -5850,6 +5850,9 @@ static int bpf_ipv4_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
>>   	params->rt_metric = res.fi->fib_priority;
>>   	params->ifindex = dev->ifindex;
>>   
>> +	if (flags & BPF_FIB_LOOKUP_SET_SRC)
>> +		params->ipv4_src = fib_result_prefsrc(net, &res);
>
> Does it need to check 0 and return BPF_FIB_LKUP_RET_NO_SRC_ADDR for v4 also,
> or the fib_result_prefsrc does not fail?

From inspecting the other usages of the function - it does not fail.

>
>> +
>>   	/* xdp and cls_bpf programs are run in RCU-bh so
>>   	 * rcu_read_lock_bh is not needed here
>>   	 */
>> @@ -5992,6 +5995,19 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
>>   	params->rt_metric = res.f6i->fib6_metric;
>>   	params->ifindex = dev->ifindex;
>>   
>> +	if (flags & BPF_FIB_LOOKUP_SET_SRC) {
>> +		if (res.f6i->fib6_prefsrc.plen) {
>> +			*(struct in6_addr *)params->ipv6_src = res.f6i->fib6_prefsrc.addr;
>> +		} else {
>> +			err = ipv6_bpf_stub->ipv6_dev_get_saddr(net, dev,
>> +								&fl6.daddr, 0,
>> +								(struct in6_addr *)
>> +								params->ipv6_src);
>> +			if (err)
>> +				return BPF_FIB_LKUP_RET_NO_SRC_ADDR;
>
> This error also implies BPF_FIB_LKUP_RET_NO_NEIGH. I don't have a clean way of 
> improving the API. May be others have some ideas.
>
> Considering dev has no saddr is probably (?) an unlikely case, it should be ok 
> to leave it as is but at least a comment in the uapi will be needed. Otherwise, 
> the bpf prog may use the 0 dmac as-is.

I expect that a user of the helper checks that err == 0 before using any of the output params.

>
> I feel the current bpf_ipv[46]_fib_lookup helper is doing many things 
> in one 
> function and then requires different BPF_FIB_LOOKUP_* bits to select 
> what/how to 
> do. In the future, it may be worth to consider breaking it into smaller 
> kfunc(s). e.g. the __ipv[46]_neigh_lookup could be in its own kfunc.
>

Yep, good idea. At least it seems that the neigh lookup could live in its own function.

>> +		}
>> +	}
>> +
>>   	if (flags & BPF_FIB_LOOKUP_SKIP_NEIGH)
>>   		goto set_fwd_params;
>>   
>> @@ -6010,7 +6026,8 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
>>   #endif
>>   
>>   #define BPF_FIB_LOOKUP_MASK (BPF_FIB_LOOKUP_DIRECT | BPF_FIB_LOOKUP_OUTPUT | \
>> -			     BPF_FIB_LOOKUP_SKIP_NEIGH | BPF_FIB_LOOKUP_TBID)
>> +			     BPF_FIB_LOOKUP_SKIP_NEIGH | BPF_FIB_LOOKUP_TBID | \
>> +			     BPF_FIB_LOOKUP_SET_SRC)
>>   
>>   BPF_CALL_4(bpf_xdp_fib_lookup, struct xdp_buff *, ctx,
>>   	   struct bpf_fib_lookup *, params, int, plen, u32, flags)

