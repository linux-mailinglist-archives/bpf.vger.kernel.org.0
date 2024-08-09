Return-Path: <bpf+bounces-36756-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7ED494C8E6
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 05:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F999B21F54
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 03:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C2C182BD;
	Fri,  9 Aug 2024 03:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wOlilCrC"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A59928E7
	for <bpf@vger.kernel.org>; Fri,  9 Aug 2024 03:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723174378; cv=none; b=Hkvfo77VRCLwkNbqG8qeRaTuyR90f5/gbTET6HtrLDgicvokHtjBVnyUf7+nbSp1KbFrCma3TS4u1oIa6+CP0gaXZ2pFAJQVA4+M8J4yTI5oALS/LbjWPe4VbHQfz3NSUKonnUG1dJzPSGs9t7vlovpHzJMgKA1uU0Z623Spfr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723174378; c=relaxed/simple;
	bh=V20k72SeTwjoAGVzTPPQq5oBGK0WmTrTQgE/7/Ry8hg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DWZzT5kHq8oWmv2cBpsJMNpSFWHkUyPLgthGVi/XugvYKc/t57Xn53TPMql0HCyyn6RXJvXVSMRkj2JVO8Yh+tB5Cw7KHA5VL8WFVcdtdp5J9QV3FjRQi3b2dW9fdH3/7GeB0LSH0AMcNBeX7bhyknGoO8q7DbMevWN2cWHHnfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wOlilCrC; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bcfe633d-8678-4b7f-85ef-b63e049021d4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723174373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aK+BVo6DNPyG246X+0i4i6/2GTfu/g9jNGd/Qu9umoU=;
	b=wOlilCrCCJ7tqsBBd9Btf68sk8RpvH6pSP2sSQlHEzl6ltDhaIuBumjMAPqStP08n76kl4
	Z+Iqyye4UnkQy//0w/tgYIQYp6CmBNOSKuNGYwnYi3slcvPAWXwhPafnQythfWU6MoNn9N
	iEtLfL+yu9hiRKLX5/97CqlmBhOUFdw=
Date: Thu, 8 Aug 2024 20:32:42 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf-next 1/2] bpf/bpf_get,set_sockopt: add option to
 set TCP-BPF sock ops flags
To: Alan Maguire <alan.maguire@oracle.com>
Cc: ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 edumazet@google.com, bpf@vger.kernel.org
References: <20240808150558.1035626-1-alan.maguire@oracle.com>
 <20240808150558.1035626-2-alan.maguire@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20240808150558.1035626-2-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/8/24 8:05 AM, Alan Maguire wrote:
> Currently the only opportunity to set sock ops flags dictating
> which callbacks fire for a socket is from within a TCP-BPF sockops
> program.  This is problematic if the connection is already set up
> as there is no further chance to specify callbacks for that socket.
> Add TCP_BPF_SOCK_OPS_CB_FLAGS to bpf_setsockopt() and bpf_getsockopt()
> to allow users to specify callbacks later, either via an iterator
> over sockets or via a socket-specific program triggered by a
> setsockopt() on the socket.
> 
> Previous discussion on this here [1].
> 
> [1] https://lore.kernel.org/bpf/f42f157b-6e52-dd4d-3d97-9b86c84c0b00@oracle.com/
> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>   include/uapi/linux/bpf.h       |  3 ++-
>   net/core/filter.c              | 15 +++++++++++++++
>   tools/include/uapi/linux/bpf.h |  3 ++-
>   3 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 35bcf52dbc65..d4d7efc34e67 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -2851,7 +2851,7 @@ union bpf_attr {
>    * 		  **TCP_SYNCNT**, **TCP_USER_TIMEOUT**, **TCP_NOTSENT_LOWAT**,
>    * 		  **TCP_NODELAY**, **TCP_MAXSEG**, **TCP_WINDOW_CLAMP**,
>    * 		  **TCP_THIN_LINEAR_TIMEOUTS**, **TCP_BPF_DELACK_MAX**,
> - * 		  **TCP_BPF_RTO_MIN**.
> + *		  **TCP_BPF_RTO_MIN**, **TCP_BPF_SOCK_OPS_CB_FLAGS**.
>    * 		* **IPPROTO_IP**, which supports *optname* **IP_TOS**.
>    * 		* **IPPROTO_IPV6**, which supports the following *optname*\ s:
>    * 		  **IPV6_TCLASS**, **IPV6_AUTOFLOWLABEL**.
> @@ -7080,6 +7080,7 @@ enum {
>   	TCP_BPF_SYN		= 1005, /* Copy the TCP header */
>   	TCP_BPF_SYN_IP		= 1006, /* Copy the IP[46] and TCP header */
>   	TCP_BPF_SYN_MAC         = 1007, /* Copy the MAC, IP[46], and TCP header */
> +	TCP_BPF_SOCK_OPS_CB_FLAGS = 1008, /* Set TCP sock ops flags */
>   };
>   
>   enum {
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 78a6f746ea0b..67114e2fb52d 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -5278,6 +5278,11 @@ static int bpf_sol_tcp_setsockopt(struct sock *sk, int optname,
>   			return -EINVAL;
>   		inet_csk(sk)->icsk_rto_min = timeout;
>   		break;
> +	case TCP_BPF_SOCK_OPS_CB_FLAGS:
> +		if (val & ~(BPF_SOCK_OPS_ALL_CB_FLAGS))
> +			return -EINVAL;
> +		tp->bpf_sock_ops_cb_flags = val;
> +		break;
>   	default:
>   		return -EINVAL;
>   	}
> @@ -5366,6 +5371,16 @@ static int sol_tcp_sockopt(struct sock *sk, int optname,
>   		if (*optlen < 1)
>   			return -EINVAL;
>   		break;
> +	case TCP_BPF_SOCK_OPS_CB_FLAGS:
> +		if (*optlen != sizeof(int))
> +			return -EINVAL;
> +		if (getopt) {
> +			struct tcp_sock *tp = tcp_sk(sk);
> +
> +			memcpy(optval, &tp->bpf_sock_ops_cb_flags, *optlen);

bpf_sock_ops_cb_flags is a u8. memcpy with "*optlen == sizeof(int)" is an issue. 
I fixed it up by assigning to a local int first. Applied. Thanks.

> +			return 0;
> +		}
> +		return bpf_sol_tcp_setsockopt(sk, optname, optval, *optlen);
>   	default:
>   		if (getopt)
>   			return -EINVAL;
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 35bcf52dbc65..d4d7efc34e67 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -2851,7 +2851,7 @@ union bpf_attr {
>    * 		  **TCP_SYNCNT**, **TCP_USER_TIMEOUT**, **TCP_NOTSENT_LOWAT**,
>    * 		  **TCP_NODELAY**, **TCP_MAXSEG**, **TCP_WINDOW_CLAMP**,
>    * 		  **TCP_THIN_LINEAR_TIMEOUTS**, **TCP_BPF_DELACK_MAX**,
> - * 		  **TCP_BPF_RTO_MIN**.
> + *		  **TCP_BPF_RTO_MIN**, **TCP_BPF_SOCK_OPS_CB_FLAGS**.
>    * 		* **IPPROTO_IP**, which supports *optname* **IP_TOS**.
>    * 		* **IPPROTO_IPV6**, which supports the following *optname*\ s:
>    * 		  **IPV6_TCLASS**, **IPV6_AUTOFLOWLABEL**.
> @@ -7080,6 +7080,7 @@ enum {
>   	TCP_BPF_SYN		= 1005, /* Copy the TCP header */
>   	TCP_BPF_SYN_IP		= 1006, /* Copy the IP[46] and TCP header */
>   	TCP_BPF_SYN_MAC         = 1007, /* Copy the MAC, IP[46], and TCP header */
> +	TCP_BPF_SOCK_OPS_CB_FLAGS = 1008, /* Set TCP sock ops flags */
>   };
>   
>   enum {


