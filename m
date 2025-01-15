Return-Path: <bpf+bounces-48888-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3450DA1166F
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 02:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E12F7A22C1
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 01:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B2338FB9;
	Wed, 15 Jan 2025 01:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="H+zLI7/L"
X-Original-To: bpf@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D278BE7
	for <bpf@vger.kernel.org>; Wed, 15 Jan 2025 01:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736903862; cv=none; b=HtqMROT4ZCiEbxuKP0Q+y7KWJ+wjFhgkswj/Sqg4VuAJogJq8tZt3QqgO+4JpkDQzxruh0PQE6h8HA2k+emNbk7hytfs9MmIdKbJwE/I8vKh924vLcbf4w2pFOoax/3KW8SeFcO9Rftl/8Gh/HnaYPtNT2LS9h4umvpV+IW6RhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736903862; c=relaxed/simple;
	bh=tNhwArqPp1gm4tyy9B3TK51+REmy7c+T3o6UBlbJc3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mnXRS+Us8mVnS0gBvf5gKIOFu/a0eXugkwXZ/pJqqabseyVuVqUUF7aIS39ttpSh+mu5rogJFgiQuQApsQwlvCGrPuHLTe12aG3YxNqpC3wjmrkhWbDuNqpzj1X1paSn6bry+3pCfkCMqtSVA0P7N86/damZ2sThVYCFa0qsgOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=H+zLI7/L; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <02031003-872e-49bf-a658-c22bc7e1a954@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736903848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MGSguZrh0S4QzlRr4LAZHQzehwExWEFMcRJhr7aDRNI=;
	b=H+zLI7/LdGHjQVnED81vuI5604DztE1UF+YtLvWPyX/BPy0afKzr4TR7BSFCIW51xlUlgw
	BybGGpzlPoifHOpn11/NF168AKEcEznyC5zfquJPFTtw45ghwMpwZ1c2A8m9O9774aSTF0
	1U5d2Vpm+biog7p0oV6Kt2bl3rrArPg=
Date: Tue, 14 Jan 2025 17:17:20 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v5 03/15] bpf: introduce timestamp_used to allow
 UDP socket fetched in bpf prog
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250112113748.73504-1-kerneljasonxing@gmail.com>
 <20250112113748.73504-4-kerneljasonxing@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20250112113748.73504-4-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/12/25 3:37 AM, Jason Xing wrote:
> timestamp_used consists of two parts, one is is_fullsock, the other
> one is for UDP socket which will be support in the next round.
> 
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> ---
>   include/linux/filter.h | 1 +
>   net/core/filter.c      | 4 ++--
>   net/core/sock.c        | 1 +
>   net/ipv4/tcp_input.c   | 2 ++
>   net/ipv4/tcp_output.c  | 2 ++
>   5 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index a3ea46281595..daca3fe48b8f 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -1508,6 +1508,7 @@ struct bpf_sock_ops_kern {
>   	void	*skb_data_end;
>   	u8	op;
>   	u8	is_fullsock;
> +	u8	timestamp_used;
>   	u8	remaining_opt_len;
>   	u64	temp;			/* temp and everything after is not
>   					 * initialized to 0 before calling
> diff --git a/net/core/filter.c b/net/core/filter.c
> index c6dd2d2e44c8..1ac996ec5e0f 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -10424,10 +10424,10 @@ static u32 sock_ops_convert_ctx_access(enum bpf_access_type type,
>   		}							      \
>   		*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(			      \
>   						struct bpf_sock_ops_kern,     \
> -						is_fullsock),		      \
> +						timestamp_used),	      \
>   				      fullsock_reg, si->src_reg,	      \
>   				      offsetof(struct bpf_sock_ops_kern,      \
> -					       is_fullsock));		      \
> +					       timestamp_used));	      \

hmm... I don't think it is the right change. This change may disallow the bpf 
prog from reading skops->sk. It is fine to allow bpf prog (includes the new 
timestamp callback) getting the skops->sk as long as skops->sk is a fullsock.

The actual thing that needs to address is writing to sk, like:

	case offsetof(struct bpf_sock_ops, sk_txhash):
		SOCK_OPS_GET_OR_SET_FIELD(sk_txhash, sk_txhash,
                                           struct sock, type);


and also all the SOCK_OPS_GET_TCP_SOCK_FIELD() to prepare for the udp sock 
support. After this patch 3, I think I start to understand the udp/fullsock 
discussion in patch 2. is_fullsock here does not mean it is tcp, although it is 
always a tcp_sock now. It literally means it is a full "struct sock". The 
verifier will treat the skops->sk as "struct sock" instead of "struct tcp_sock".

>   		*insn++ = BPF_JMP_IMM(BPF_JEQ, fullsock_reg, 0, jmp);	      \
>   		if (si->dst_reg == si->src_reg)				      \
>   			*insn++ = BPF_LDX_MEM(BPF_DW, reg, si->src_reg,	      \
> diff --git a/net/core/sock.c b/net/core/sock.c
> index e06bcafb1b2d..dbb9326ae9d1 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -958,6 +958,7 @@ void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb, int op)
>   	if (sk_is_tcp(sk) && sk_fullsock(sk))
>   		sock_ops.is_fullsock = 1;
>   	sock_ops.sk = sk;
> +	sock_ops.timestamp_used = 1;
>   	__cgroup_bpf_run_filter_sock_ops(sk, &sock_ops, CGROUP_SOCK_OPS);
>   }
>   #endif
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 4811727b8a02..cad41ad34bd5 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -169,6 +169,7 @@ static void bpf_skops_parse_hdr(struct sock *sk, struct sk_buff *skb)
>   	memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
>   	sock_ops.op = BPF_SOCK_OPS_PARSE_HDR_OPT_CB;
>   	sock_ops.is_fullsock = 1;
> +	sock_ops.timestamp_used = 1;
>   	sock_ops.sk = sk;
>   	bpf_skops_init_skb(&sock_ops, skb, tcp_hdrlen(skb));
>   
> @@ -185,6 +186,7 @@ static void bpf_skops_established(struct sock *sk, int bpf_op,
>   	memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
>   	sock_ops.op = bpf_op;
>   	sock_ops.is_fullsock = 1;
> +	sock_ops.timestamp_used = 1;
>   	sock_ops.sk = sk;
>   	/* sk with TCP_REPAIR_ON does not have skb in tcp_finish_connect */
>   	if (skb)
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 0e5b9a654254..7b4d1dfd57d4 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -522,6 +522,7 @@ static void bpf_skops_hdr_opt_len(struct sock *sk, struct sk_buff *skb,
>   		sock_owned_by_me(sk);
>   
>   		sock_ops.is_fullsock = 1;
> +		sock_ops.timestamp_used = 1;
>   		sock_ops.sk = sk;
>   	}
>   
> @@ -567,6 +568,7 @@ static void bpf_skops_write_hdr_opt(struct sock *sk, struct sk_buff *skb,
>   		sock_owned_by_me(sk);
>   
>   		sock_ops.is_fullsock = 1;
> +		sock_ops.timestamp_used = 1;

The "timestamp_used = 1;' assignment has missed some places. At least in the 
tcp_call_bpf().

Also, the name "timestamp_used" is confusing. Like setting timestamp_used in the 
bpf_skops_*_hdr_opt() callback here when it is not a timestamp callback.

Altogether, need to rethink what to add to sock_ops instead of timestamp_used 
and it should be checked in "some" of the SOCK_OPS_*_FIELD(). A quick thought 
(not 100% sure) is to add "u8 allow_direct_access" which is only set for the 
existing sockops callbacks.

[ I will continue the rest later. ]

>   		sock_ops.sk = sk;
>   	}
>   


