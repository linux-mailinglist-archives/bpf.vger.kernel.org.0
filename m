Return-Path: <bpf+bounces-66737-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A891B38E59
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 00:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 375CE7A7E88
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 22:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55E528DF36;
	Wed, 27 Aug 2025 22:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eagy1LZk"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB0330F951
	for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 22:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756333426; cv=none; b=WMgEZ4F+DGwTbVWC06qMcfNqSwK5OLTC/2BsXc2FqHjcZEDBRCwfVQ/rL2Eol4qB+WOpElpxb7cPcCXFhyqjsXj/1laXx0GY+6givmUc/DbGK2o5DbTzyt/isY7YT3Mk9Mo9ZIRUmX1erryeNePFFE5RVCpfRxIyi0Kl6KOPOIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756333426; c=relaxed/simple;
	bh=YfoXYH3cm92sHCjAYQM6pQjLBZ7QQPBb5+txY9E1NA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rvGF0nlGLtFI+kKOc1BUvtd1XN0k0li49fXQHHhf0AX/ITQNstvFZuDNrfV9e7vIiHJQd7o6X/eDnB8c9YKks/+9LpAX7SmoSW7sXZ1JM4wtW9AjdiLEW2mfglh9rcBhPHM5tjV8qdo7+yPX/mCvhPDeFIZ3HRSTVFJJTGvWkkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eagy1LZk; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <aaf5eeb5-2336-4a20-9b8f-0cdd3c274ff0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756333422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YXH9gB5skVmjTjxtTahEaINOT63mMXBiq7apizRcrto=;
	b=eagy1LZkvI6Yu0kL1UO1q9Z7Xsq89PYa/MCWFuCYozy1tW2hAIAkLONuznop9aCX5oNRny
	uuJSRWpLdjau4AVJF7ppIZ0ra7+B69dmlMawtQzQaweTv2f6ktLxKtkvEvdJlzW6e9UVK+
	E+Eb8K1QovpFnEnc6dZacyY24QDmkQk=
Date: Wed, 27 Aug 2025 15:23:35 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 bpf-next/net 2/5] bpf: Support bpf_setsockopt() for
 BPF_CGROUP_INET_SOCK_CREATE.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>,
 Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima
 <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20250826183940.3310118-1-kuniyu@google.com>
 <20250826183940.3310118-3-kuniyu@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250826183940.3310118-3-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/26/25 11:38 AM, Kuniyuki Iwashima wrote:
> We will store a flag in sk->sk_memcg by bpf_setsockopt() during
> socket() or before sk->sk_memcg is set in accept().
> 
> BPF_CGROUP_INET_SOCK_CREATE is invoked by __cgroup_bpf_run_filter_sk()
> that passes a pointer to struct sock to the bpf prog as void *ctx.
> 
> But there are no bpf_func_proto for bpf_setsockopt() that receives
> the ctx as a pointer to struct sock.
> 
> Let's add a new bpf_setsockopt() variant for BPF_CGROUP_INET_SOCK_CREATE.
> 
> Note that inet_create() is not under lock_sock().
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
> v3: Remove bpf_func_proto for accept()
> v2: Make 2 new bpf_func_proto static
> ---
>   net/core/filter.c | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 63f3baee2daf..443d12b7d3b2 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -5743,6 +5743,23 @@ static const struct bpf_func_proto bpf_sock_ops_setsockopt_proto = {
>   	.arg5_type	= ARG_CONST_SIZE,
>   };
>   
> +BPF_CALL_5(bpf_unlocked_sock_setsockopt, struct sock *, sk, int, level,
> +	   int, optname, char *, optval, int, optlen)
> +{
> +	return _bpf_setsockopt(sk, level, optname, optval, optlen);

The sock_owned_by_me() will warn.

 From CI:
WARNING: CPU: 0 PID: 102 at include/net/sock.h:1756 bpf_unlocked_sock_setsockopt+0xc7/0x110

> +}
> +
> +static const struct bpf_func_proto bpf_unlocked_sock_setsockopt_proto = {
> +	.func		= bpf_unlocked_sock_setsockopt,
> +	.gpl_only	= false,
> +	.ret_type	= RET_INTEGER,
> +	.arg1_type	= ARG_PTR_TO_CTX,
> +	.arg2_type	= ARG_ANYTHING,
> +	.arg3_type	= ARG_ANYTHING,
> +	.arg4_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
> +	.arg5_type	= ARG_CONST_SIZE,
> +};
> +
>   static int bpf_sock_ops_get_syn(struct bpf_sock_ops_kern *bpf_sock,
>   				int optname, const u8 **start)
>   {
> @@ -8051,6 +8068,13 @@ sock_filter_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>   		return &bpf_sk_storage_get_cg_sock_proto;
>   	case BPF_FUNC_ktime_get_coarse_ns:
>   		return &bpf_ktime_get_coarse_ns_proto;
> +	case BPF_FUNC_setsockopt:
> +		switch (prog->expected_attach_type) {
> +		case BPF_CGROUP_INET_SOCK_CREATE:
> +			return &bpf_unlocked_sock_setsockopt_proto;
> +		default:
> +			return NULL;
> +		}
>   	default:
>   		return bpf_base_func_proto(func_id, prog);
>   	}


