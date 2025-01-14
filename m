Return-Path: <bpf+bounces-48874-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D44A11545
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 00:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6ABD163DC2
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 23:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4D52139C4;
	Tue, 14 Jan 2025 23:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tYSwb+MQ"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C57232429;
	Tue, 14 Jan 2025 23:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736896857; cv=none; b=QBXwXTLU/mQGHeVRsd7NBDvxDQOALJueafmdPWKXvQ4pHOFAW2TsbJnJ8mZWDi5+N/NW2X4yVWg8JSl+hLpubWU38659CAqeIsYbK+iELcoBAo3V7au4TAAC7x9Wv8lkrWA7ro63IirZfMpdMq3OBLZUsva7ehJ2ULunrtDrksQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736896857; c=relaxed/simple;
	bh=l81c8zEzf/BUOHgqBmE29NV0oLDlQ+HkTkgBB3Iu/dQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sF6aZgH/u32b4oRLo0qR4ceAHiTJCXW31oAZWyOZ6o5Ybw4WHCV/dp6qqN+/XAiTail8IlBMX/TLtdNxjZnsKmYFGJ9LXQwkD584PHzXprlnUVLWX2K2Th2kwOObbicrKqJqhFYFJmbcqz/pIUGEIpM3EBGB/F47yxja/5rnY/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tYSwb+MQ; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6bb42e9b-83ff-497d-8052-27ac609a2af7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736896853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xwDAHSKCfoIYfiftlZsT41jVy2VlUYoZ1+GX2Wio6DU=;
	b=tYSwb+MQdWzw2aLVqT+zXp/vbimkc326U3PexbG0kgwuT6JUMIcsIyqPtRf5FIpjrRZvTT
	a24EQ6irgvWJsRkphdcrIG65Y8686CbWrJm5Me/UFOn8ZfmGfTkLeJc9UlhQS8t1kO/bIK
	0halBv0cSlzh2HfkFbZupmWndGUfC5s=
Date: Tue, 14 Jan 2025 15:20:40 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v5 01/15] net-timestamp: add support for
 bpf_setsockopt()
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
 willemdebruijn.kernel@gmail.com, willemb@google.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, horms@kernel.org
References: <20250112113748.73504-1-kerneljasonxing@gmail.com>
 <20250112113748.73504-2-kerneljasonxing@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20250112113748.73504-2-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/12/25 3:37 AM, Jason Xing wrote:
> Users can write the following code to enable the bpf extension:
> bpf_setsockopt(skops, SOL_SOCKET, SK_BPF_CB_FLAGS, &flags, sizeof(flags));
> 
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> ---
>   include/net/sock.h             |  7 +++++++
>   include/uapi/linux/bpf.h       |  8 ++++++++
>   net/core/filter.c              | 25 +++++++++++++++++++++++++
>   tools/include/uapi/linux/bpf.h |  1 +
>   4 files changed, 41 insertions(+)
> 
> diff --git a/include/net/sock.h b/include/net/sock.h
> index ccf86c8a7a8a..f5447b4b78fd 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -303,6 +303,7 @@ struct sk_filter;
>     *	@sk_stamp: time stamp of last packet received
>     *	@sk_stamp_seq: lock for accessing sk_stamp on 32 bit architectures only
>     *	@sk_tsflags: SO_TIMESTAMPING flags
> +  *	@sk_bpf_cb_flags: used for bpf_setsockopt
>     *	@sk_use_task_frag: allow sk_page_frag() to use current->task_frag.
>     *			   Sockets that can be used under memory reclaim should
>     *			   set this to false.
> @@ -445,6 +446,12 @@ struct sock {
>   	u32			sk_reserved_mem;
>   	int			sk_forward_alloc;
>   	u32			sk_tsflags;
> +#ifdef CONFIG_BPF_SYSCALL

The CONFIG_BPF is used instead in the existing "u8 bpf_sock_ops_cb_flags;" in 
tcp_sock. afaik, CONFIG_BPF is selected by CONFIG_NET. It is why the test bot 
fails when CONFIG_BPF_SYSCALL is used here but not with the existing 
bpf_sock_ops_cb_flags. Considering CONFIG_BPF is also mostly useless here 
because of CONFIG_NET, I would remove this ifdef usage altogether. If there is 
really a need to distinguish CONFIG_BPF_SYSCALL is enabled or not, this can be 
improved together with the existing bpf_sock_ops_cb_flags.

> +#define SK_BPF_CB_FLAG_TEST(SK, FLAG) ((SK)->sk_bpf_cb_flags & (FLAG))
> +	u32			sk_bpf_cb_flags;
> +#else
> +#define SK_BPF_CB_FLAG_TEST(SK, FLAG) 0
> +#endif
>   	__cacheline_group_end(sock_write_rxtx);
>   
>   	__cacheline_group_begin(sock_write_tx);
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 4162afc6b5d0..e629e09b0b31 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -6903,6 +6903,13 @@ enum {
>   	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0x7F,
>   };
>   
> +/* Definitions for bpf_sk_cb_flags */
> +enum {
> +	SK_BPF_CB_TX_TIMESTAMPING	= 1<<0,
> +	SK_BPF_CB_MASK			= (SK_BPF_CB_TX_TIMESTAMPING - 1) |
> +					   SK_BPF_CB_TX_TIMESTAMPING
> +};
> +
>   /* List of known BPF sock_ops operators.
>    * New entries can only be added at the end
>    */
> @@ -7081,6 +7088,7 @@ enum {
>   	TCP_BPF_SYN_IP		= 1006, /* Copy the IP[46] and TCP header */
>   	TCP_BPF_SYN_MAC         = 1007, /* Copy the MAC, IP[46], and TCP header */
>   	TCP_BPF_SOCK_OPS_CB_FLAGS = 1008, /* Get or Set TCP sock ops flags */
> +	SK_BPF_CB_FLAGS		= 1009, /* Used to set socket bpf flags */
>   };
>   
>   enum {
> diff --git a/net/core/filter.c b/net/core/filter.c
> index b957cf57299e..c6dd2d2e44c8 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -5222,6 +5222,23 @@ static const struct bpf_func_proto bpf_get_socket_uid_proto = {
>   	.arg1_type      = ARG_PTR_TO_CTX,
>   };
>   
> +static int sk_bpf_set_cb_flags(struct sock *sk, char *optval, bool getopt)
> +{
> +	u32 sk_bpf_cb_flags;
> +
> +	if (getopt)

I may have this in my earlier sample code? This is probably because of my 
laziness for a quick example. getopt should also be supported, similar to the 
existing TCP_BPF_SOCK_OPS_CB_FLAGS.

> +		return -EINVAL;
> +
> +	sk_bpf_cb_flags = *(u32 *)optval;
> +
> +	if (sk_bpf_cb_flags & ~SK_BPF_CB_MASK)
> +		return -EINVAL;
> +
> +	sk->sk_bpf_cb_flags = sk_bpf_cb_flags;
> +
> +	return 0;
> +}
> +
>   static int sol_socket_sockopt(struct sock *sk, int optname,
>   			      char *optval, int *optlen,
>   			      bool getopt)
> @@ -5238,6 +5255,7 @@ static int sol_socket_sockopt(struct sock *sk, int optname,
>   	case SO_MAX_PACING_RATE:
>   	case SO_BINDTOIFINDEX:
>   	case SO_TXREHASH:
> +	case SK_BPF_CB_FLAGS:
>   		if (*optlen != sizeof(int))
>   			return -EINVAL;
>   		break;
> @@ -5247,6 +5265,13 @@ static int sol_socket_sockopt(struct sock *sk, int optname,
>   		return -EINVAL;
>   	}
>   
> +	if (optname == SK_BPF_CB_FLAGS)
> +#ifdef CONFIG_BPF_SYSCALL
> +		return sk_bpf_set_cb_flags(sk, optval, getopt);
> +#else
> +		return -EINVAL;
> +#endif
> +
>   	if (getopt) {
>   		if (optname == SO_BINDTODEVICE)
>   			return -EINVAL;
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 4162afc6b5d0..6b0a5b787b12 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -7081,6 +7081,7 @@ enum {
>   	TCP_BPF_SYN_IP		= 1006, /* Copy the IP[46] and TCP header */
>   	TCP_BPF_SYN_MAC         = 1007, /* Copy the MAC, IP[46], and TCP header */
>   	TCP_BPF_SOCK_OPS_CB_FLAGS = 1008, /* Get or Set TCP sock ops flags */
> +	SK_BPF_CB_FLAGS		= 1009, /* Used to set socket bpf flags */
>   };
>   
>   enum {


