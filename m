Return-Path: <bpf+bounces-19394-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8719B82B937
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 02:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1796CB24365
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 01:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB95A10FE;
	Fri, 12 Jan 2024 01:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pSn2CAz/"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B73EC5
	for <bpf@vger.kernel.org>; Fri, 12 Jan 2024 01:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <aea7e756-9b3a-46b0-af27-207ba306b875@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705023902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y7MYBGykbo+B7B7Y08PI4vamNAzIA5zfjIRY6lTBuws=;
	b=pSn2CAz/EElnB7fJJRrtE8kRoLfDNbwFJNj7z2xfGflYckT7lQKJaXAO6/HhU/PeW6VXhV
	MmLkvXYVdIqHBcv1O7+HCIuHx68bDUICAr5l0P5fDf+OknpR3r4oSMNVkpHfL02c2fjQdz
	LS3y9dJU9GRd1kvRpmjV12taud4cw0M=
Date: Thu, 11 Jan 2024 17:44:55 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v7 bpf-next 5/6] bpf: tcp: Support arbitrary SYN Cookie.
Content-Language: en-US
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20231221012806.37137-1-kuniyu@amazon.com>
 <20231221012806.37137-6-kuniyu@amazon.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231221012806.37137-6-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/20/23 5:28 PM, Kuniyuki Iwashima wrote:
> This patch adds a new kfunc available at TC hook to support arbitrary
> SYN Cookie.
> 
> The basic usage is as follows:
> 
>      struct bpf_tcp_req_attrs attrs = {
>          .mss = mss,
>          .wscale_ok = wscale_ok,
>          .rcv_wscale = rcv_wscale, /* Server's WScale < 15 */
>          .snd_wscale = snd_wscale, /* Client's WScale < 15 */
>          .tstamp_ok = tstamp_ok,
>          .rcv_tsval = tsval,
>          .rcv_tsecr = tsecr, /* Server's Initial TSval */
>          .usec_ts_ok = usec_ts_ok,
>          .sack_ok = sack_ok,
>          .ecn_ok = ecn_ok,
>      }
> 
>      skc = bpf_skc_lookup_tcp(...);
>      sk = (struct sock *)bpf_skc_to_tcp_sock(skc);
>      bpf_sk_assign_tcp_reqsk(skb, sk, attrs, sizeof(attrs));
>      bpf_sk_release(skc);
> 
> bpf_sk_assign_tcp_reqsk() takes skb, a listener sk, and struct
> bpf_tcp_req_attrs and allocates reqsk and configures it.  Then,
> bpf_sk_assign_tcp_reqsk() links reqsk with skb and the listener.
> 
> The notable thing here is that we do not hold refcnt for both reqsk
> and listener.  To differentiate that, we mark reqsk->syncookie, which
> is only used in TX for now.  So, if reqsk->syncookie is 1 in RX, it
> means that the reqsk is allocated by kfunc.
> 
> When skb is freed, sock_pfree() checks if reqsk->syncookie is 1,
> and in that case, we set NULL to reqsk->rsk_listener before calling
> reqsk_free() as reqsk does not hold a refcnt of the listener.
> 
> When the TCP stack looks up a socket from the skb, we steal the
> listener from the reqsk in skb_steal_sock() and create a full sk
> in cookie_v[46]_check().
> 
> The refcnt of reqsk will finally be set to 1 in tcp_get_cookie_sock()
> after creating a full sk.
> 
> Note that we can extend struct bpf_tcp_req_attrs in the future when
> we add a new attribute that is determined in 3WHS.

Notice a few final details.

> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>   include/net/tcp.h |  13 ++++++
>   net/core/filter.c | 113 +++++++++++++++++++++++++++++++++++++++++++++-
>   net/core/sock.c   |  14 +++++-
>   3 files changed, 136 insertions(+), 4 deletions(-)
> 
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index a63916f41f77..20619df8819e 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -600,6 +600,19 @@ static inline bool cookie_ecn_ok(const struct net *net, const struct dst_entry *
>   }
>   
>   #if IS_ENABLED(CONFIG_BPF)
> +struct bpf_tcp_req_attrs {
> +	u32 rcv_tsval;
> +	u32 rcv_tsecr;
> +	u16 mss;
> +	u8 rcv_wscale;
> +	u8 snd_wscale;
> +	u8 ecn_ok;
> +	u8 wscale_ok;
> +	u8 sack_ok;
> +	u8 tstamp_ok;
> +	u8 usec_ts_ok;

Add "u8 reserved[3];" for the 3 bytes tail padding.

> +};
> +
>   static inline bool cookie_bpf_ok(struct sk_buff *skb)
>   {
>   	return skb->sk;
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 24061f29c9dd..961c2d30bd72 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -11837,6 +11837,105 @@ __bpf_kfunc int bpf_sock_addr_set_sun_path(struct bpf_sock_addr_kern *sa_kern,
>   
>   	return 0;
>   }
> +
> +__bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct sk_buff *skb, struct sock *sk,
> +					struct bpf_tcp_req_attrs *attrs, int attrs__sz)
> +{
> +#if IS_ENABLED(CONFIG_SYN_COOKIES)
> +	const struct request_sock_ops *ops;
> +	struct inet_request_sock *ireq;
> +	struct tcp_request_sock *treq;
> +	struct request_sock *req;
> +	struct net *net;
> +	__u16 min_mss;
> +	u32 tsoff = 0;
> +
> +	if (attrs__sz != sizeof(*attrs))
> +		return -EINVAL;
> +
> +	if (!sk)
> +		return -EINVAL;
> +
> +	if (!skb_at_tc_ingress(skb))
> +		return -EINVAL;
> +
> +	net = dev_net(skb->dev);
> +	if (net != sock_net(sk))
> +		return -ENETUNREACH;
> +
> +	switch (skb->protocol) {
> +	case htons(ETH_P_IP):
> +		ops = &tcp_request_sock_ops;
> +		min_mss = 536;
> +		break;
> +#if IS_BUILTIN(CONFIG_IPV6)
> +	case htons(ETH_P_IPV6):
> +		ops = &tcp6_request_sock_ops;
> +		min_mss = IPV6_MIN_MTU - 60;
> +		break;
> +#endif
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (sk->sk_type != SOCK_STREAM || sk->sk_state != TCP_LISTEN ||
> +	    sk_is_mptcp(sk))
> +		return -EINVAL;
> +

and check for:

	if (attrs->reserved[0] || attrs->reserved[1] || attrs->reserved[2])
		return -EINVAL;

It will be safer if it needs to extend "struct bpf_tcp_req_attrs". There is an 
existing example in __bpf_nf_ct_lookup() when checking the 'struct bpf_ct_opts 
*opts'.


