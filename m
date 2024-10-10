Return-Path: <bpf+bounces-41611-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F419991A5
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 21:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51D8B1F24CF5
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 19:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CCF1E7C17;
	Thu, 10 Oct 2024 18:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tC10qpRx"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565251E7C01
	for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 18:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728586464; cv=none; b=rN2i25ZUeTvQi6ZY4qDLgcFB2MKhNRUgpfld2SrlSG7KpQ8pQAA2QIpD637h2X9wQt9Xl05VIh40loPoO1iRkLwX5jaz2IZKbVeRLp5xNV42KgLasar00GnDmQNcz+b2ULmY0uAA5JW+BuIoXqg9iFZSay3xsHJA6m9eLMgHBb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728586464; c=relaxed/simple;
	bh=Wn8u+ZwqZQCn/jj2BD1MSnA+y5sLcLPJbvtx9C5eif0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=siYS2l7h4iYF/TYYgUsr5Li1aY/cgmZ+UIpl4axgMUnuHeSifFk3XDamIeHTMBDTNAfLKfkA4hAs/5Vx8OiRoy75Fln0DlzfyVTtovJismyvgZWpKStYpsYBkRcYJTq+o0RewL+Gby3LerloAzbXMyt39PCl+L4YxVbV2RfzAzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tC10qpRx; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7f4bf2ad-3085-4190-a9fe-58672f744bae@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728586459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y2sFU+mhkreogqetewYXW4CuQ+piLzvISb3B3kccdA8=;
	b=tC10qpRxyAtyodLTz8105efEiKl8Oi8TC1Re3DIsMmqv7g/ZSVBx2CP8NU1l4F16/0Hq55
	mK3aQRflt16K7TIOaBt5iTL4C1XbIS6I3CgTRtakmySldd2jHuJFTscZuTsvFDkgNES7Uf
	zqCr7JzM5d+2YAXYPaA0h/k5YBmOAB8=
Date: Thu, 10 Oct 2024 11:54:12 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf 1/4] bpf, sockmap: SK_DROP on attempted redirects of
 unsupported af_vsock
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 John Fastabend <john.fastabend@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Michal Luczaj <mhal@rbox.co>,
 netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20241009-vsock-fixes-for-redir-v1-0-e455416f6d78@rbox.co>
 <20241009-vsock-fixes-for-redir-v1-1-e455416f6d78@rbox.co>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20241009-vsock-fixes-for-redir-v1-1-e455416f6d78@rbox.co>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/9/24 2:20 PM, Michal Luczaj wrote:
> Don't mislead the callers of bpf_{sk,msg}_redirect_{map,hash}(): make sure
> to immediately and visibly fail the forwarding of unsupported af_vsock
> packets.
> 
> Fixes: 634f1a7110b4 ("vsock: support sockmap")
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---
>   include/net/sock.h  | 5 +++++
>   net/core/sock_map.c | 8 ++++++++
>   2 files changed, 13 insertions(+)
> 
> diff --git a/include/net/sock.h b/include/net/sock.h
> index c58ca8dd561b7312ffc0836585c04d9fe917a124..c87295f3476db23934d4fcbeabc7851c61ad2bc4 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -2715,6 +2715,11 @@ static inline bool sk_is_stream_unix(const struct sock *sk)
>   	return sk->sk_family == AF_UNIX && sk->sk_type == SOCK_STREAM;
>   }
>   
> +static inline bool sk_is_vsock(const struct sock *sk)
> +{
> +	return sk->sk_family == AF_VSOCK;
> +}
> +
>   /**
>    * sk_eat_skb - Release a skb if it is no longer needed
>    * @sk: socket to eat this skb from
> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index 242c91a6e3d3870ec6da6fa095d180a933d1d3d4..07d6aa4e39ef606aab33bd0d95711ecf156596b9 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -647,6 +647,8 @@ BPF_CALL_4(bpf_sk_redirect_map, struct sk_buff *, skb,
>   	sk = __sock_map_lookup_elem(map, key);
>   	if (unlikely(!sk || !sock_map_redirect_allowed(sk)))
>   		return SK_DROP;
> +	if ((flags & BPF_F_INGRESS) && sk_is_vsock(sk))
> +		return SK_DROP;
>   
>   	skb_bpf_set_redir(skb, sk, flags & BPF_F_INGRESS);
>   	return SK_PASS;
> @@ -675,6 +677,8 @@ BPF_CALL_4(bpf_msg_redirect_map, struct sk_msg *, msg,
>   		return SK_DROP;
>   	if (!(flags & BPF_F_INGRESS) && !sk_is_tcp(sk))
>   		return SK_DROP;
> +	if (sk_is_vsock(sk))
> +		return SK_DROP;
>   
>   	msg->flags = flags;
>   	msg->sk_redir = sk;
> @@ -1249,6 +1253,8 @@ BPF_CALL_4(bpf_sk_redirect_hash, struct sk_buff *, skb,
>   	sk = __sock_hash_lookup_elem(map, key);
>   	if (unlikely(!sk || !sock_map_redirect_allowed(sk)))
>   		return SK_DROP;
> +	if ((flags & BPF_F_INGRESS) && sk_is_vsock(sk))
> +		return SK_DROP;
>   
>   	skb_bpf_set_redir(skb, sk, flags & BPF_F_INGRESS);
>   	return SK_PASS;
> @@ -1277,6 +1283,8 @@ BPF_CALL_4(bpf_msg_redirect_hash, struct sk_msg *, msg,
>   		return SK_DROP;
>   	if (!(flags & BPF_F_INGRESS) && !sk_is_tcp(sk))
>   		return SK_DROP;
> +	if (sk_is_vsock(sk))
> +		return SK_DROP;

Jakub Sitnicki, I think you have been on another thread about this change. 
Please help to take a look and ack if it looks good. Thanks.

>   
>   	msg->flags = flags;
>   	msg->sk_redir = sk;
> 


