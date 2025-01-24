Return-Path: <bpf+bounces-49723-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 283D7A1BF12
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 00:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD1B63A5408
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 23:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEF91EEA2C;
	Fri, 24 Jan 2025 23:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mWpxEz9j"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB93A2B9BC;
	Fri, 24 Jan 2025 23:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737762068; cv=none; b=tOLsbKBTDkbHdCkPOemRXOC7Oh6An6B/ngXgIzLngtFF8tMGr2DKhsUVf5kT217AA8n/3bHDKOJzEFD41wGEhFiBkbPu0yksyskTLR5TIwJj3pSpp4NFgaFSh1eHadO2NHimEhSkQnB1jZ7ZUdYI3Lt3nyQvMDdiZMxgoIfWOv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737762068; c=relaxed/simple;
	bh=b3WQmM/tao+lpAuI3faT+EbYcotu4+fjpb2WjLWCPJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OKpFU6VX1mVgkq85csCj5Y5evzGOw8bhBiMpPdK9vVl8+cl4Zicvkvy7fD894V4Er/2yVSdm2/H/HtocPK6ShfXReS33wU1WYnGl4eWrlU89lGgGhKQIoc62vwK1kWBFcw1sVWYAuYBFBtEFGOfgsyE6k5iItmjv/nkJ3UPSrjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mWpxEz9j; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e1440d0b-4803-49b2-ba17-b9523649ca8b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737762057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D0YzInS2Txyl/Fuy8v3vm8ES3MAgYqQz1nDaGeki7n0=;
	b=mWpxEz9jlWKtZxWjuCuqdU2Bg7iF+PltrtZ4N/3DUPqkZrtzUAm7FoDYri4ezTxBr7hPWS
	52JPtj5cXfUYnizEfuYRC4XRVi9fJ8bhjLe2F3wXhJ2G/SI4EKDfE68DRHwqRsSxfxZjFG
	DfGCPac89g9wlhPPz9kI8RnwPxaQqPg=
Date: Fri, 24 Jan 2025 15:40:47 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH net-next v6 03/13] bpf: stop UDP sock accessing TCP
 fields in bpf callbacks
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250121012901.87763-1-kerneljasonxing@gmail.com>
 <20250121012901.87763-4-kerneljasonxing@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20250121012901.87763-4-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/20/25 5:28 PM, Jason Xing wrote:
> Applying the new member allow_tcp_access in the existing callbacks
> where is_fullsock is set to 1 can help us stop UDP socket accessing
> struct tcp_sock, or else it could be catastrophe leading to panic.
> 
> For now, those existing callbacks are used only for TCP. I believe
> in the short run, we will have timestamping UDP callbacks support.

The commit message needs adjustment. UDP is not supported yet, so this change 
feels like it's unnecessary based on the commit message. However, even without 
UDP support, the new timestamping callbacks cannot directly write some fields 
because the sk lock is not held, so this change is needed for TCP timestamping 
support.

To keep it simple, instead of distinguishing between read and write access, we 
disallow all read/write access to the tcp_sock through the older bpf_sock_ops 
ctx. The new timestamping callbacks can use newer helpers to read everything 
from a sk (e.g. bpf_core_cast), so nothing is lost.

The "allow_tcp_access" flag is added to indicate that the callback site has a 
tcp_sock locked. Yes, it will make future UDP support easier because a udp_sock 
is not a tcp_sock to begin with.

> 
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> ---
>   include/linux/filter.h | 1 +
>   include/net/tcp.h      | 1 +
>   net/core/filter.c      | 8 ++++----
>   net/ipv4/tcp_input.c   | 2 ++
>   net/ipv4/tcp_output.c  | 2 ++
>   5 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index a3ea46281595..1b1333a90b4a 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -1508,6 +1508,7 @@ struct bpf_sock_ops_kern {
>   	void	*skb_data_end;
>   	u8	op;
>   	u8	is_fullsock;
> +	u8	allow_tcp_access;

It is useful to add a comment here to explain the sockops callback has the 
tcp_sock locked when it is set.

>   	u8	remaining_opt_len;
>   	u64	temp;			/* temp and everything after is not
>   					 * initialized to 0 before calling
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 5b2b04835688..293047694710 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -2649,6 +2649,7 @@ static inline int tcp_call_bpf(struct sock *sk, int op, u32 nargs, u32 *args)
>   	memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
>   	if (sk_fullsock(sk)) {
>   		sock_ops.is_fullsock = 1;
> +		sock_ops.allow_tcp_access = 1;
>   		sock_owned_by_me(sk);
>   	}
>   
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 8e2715b7ac8a..fdd305b4cfbb 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -10381,10 +10381,10 @@ static u32 sock_ops_convert_ctx_access(enum bpf_access_type type,
>   		}							      \
>   		*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(			      \
>   						struct bpf_sock_ops_kern,     \
> -						is_fullsock),		      \
> +						allow_tcp_access),	      \
>   				      fullsock_reg, si->src_reg,	      \
>   				      offsetof(struct bpf_sock_ops_kern,      \
> -					       is_fullsock));		      \
> +					       allow_tcp_access));	      \
>   		*insn++ = BPF_JMP_IMM(BPF_JEQ, fullsock_reg, 0, jmp);	      \
>   		if (si->dst_reg == si->src_reg)				      \
>   			*insn++ = BPF_LDX_MEM(BPF_DW, reg, si->src_reg,	      \
> @@ -10469,10 +10469,10 @@ static u32 sock_ops_convert_ctx_access(enum bpf_access_type type,
>   					       temp));			      \
>   		*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(			      \
>   						struct bpf_sock_ops_kern,     \
> -						is_fullsock),		      \
> +						allow_tcp_access),	      \
>   				      reg, si->dst_reg,			      \
>   				      offsetof(struct bpf_sock_ops_kern,      \
> -					       is_fullsock));		      \
> +					       allow_tcp_access));	      \
>   		*insn++ = BPF_JMP_IMM(BPF_JEQ, reg, 0, 2);		      \
>   		*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(			      \
>   						struct bpf_sock_ops_kern, sk),\
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index eb82e01da911..77185479ed5e 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -169,6 +169,7 @@ static void bpf_skops_parse_hdr(struct sock *sk, struct sk_buff *skb)
>   	memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
>   	sock_ops.op = BPF_SOCK_OPS_PARSE_HDR_OPT_CB;
>   	sock_ops.is_fullsock = 1;
> +	sock_ops.allow_tcp_access = 1;
>   	sock_ops.sk = sk;
>   	bpf_skops_init_skb(&sock_ops, skb, tcp_hdrlen(skb));
>   
> @@ -185,6 +186,7 @@ static void bpf_skops_established(struct sock *sk, int bpf_op,
>   	memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
>   	sock_ops.op = bpf_op;
>   	sock_ops.is_fullsock = 1;
> +	sock_ops.allow_tcp_access = 1;
>   	sock_ops.sk = sk;
>   	/* sk with TCP_REPAIR_ON does not have skb in tcp_finish_connect */
>   	if (skb)
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 0e5b9a654254..695749807c09 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -522,6 +522,7 @@ static void bpf_skops_hdr_opt_len(struct sock *sk, struct sk_buff *skb,
>   		sock_owned_by_me(sk);
>   
>   		sock_ops.is_fullsock = 1;
> +		sock_ops.allow_tcp_access = 1;
>   		sock_ops.sk = sk;
>   	}
>   
> @@ -567,6 +568,7 @@ static void bpf_skops_write_hdr_opt(struct sock *sk, struct sk_buff *skb,
>   		sock_owned_by_me(sk);
>   
>   		sock_ops.is_fullsock = 1;
> +		sock_ops.allow_tcp_access = 1;
>   		sock_ops.sk = sk;
>   	}
>   


