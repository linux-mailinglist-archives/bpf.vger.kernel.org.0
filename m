Return-Path: <bpf+bounces-8961-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C531578D34F
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 08:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0314B1C20B05
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 06:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A205A15CD;
	Wed, 30 Aug 2023 06:21:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674B215A0
	for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 06:21:15 +0000 (UTC)
Received: from out-250.mta0.migadu.com (out-250.mta0.migadu.com [91.218.175.250])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05051BE
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 23:21:10 -0700 (PDT)
Message-ID: <b48c25fd-6c4e-d04f-aea8-65acf6a9fe2a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1693376469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GVU/sVW6cOAfmZd60un34NNa4+oiokMDYGAV7UXOSRw=;
	b=GjlvVHkDn43z6uMGPRYLAbkhF5oUixUpH5Hys/Wprd7WwbH5mZFZyoPukWP2Gvj0AUtO+4
	7Wck4PC08lxBDxKLK2msjS5quV1lNK87u4FvwjpY9Jqrdx2uUeAOb2429E3D5Lk32PCzGQ
	AWq9dVjuUD77ocLjZU/0PhXnjbHuQLY=
Date: Tue, 29 Aug 2023 23:21:04 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 2/9] bpf: Propagate modified uaddrlen from
 cgroup sockaddr programs
Content-Language: en-US
To: Daan De Meyer <daan.j.demeyer@gmail.com>
Cc: kernel-team@meta.com, bpf@vger.kernel.org
References: <20230829101838.851350-1-daan.j.demeyer@gmail.com>
 <20230829101838.851350-3-daan.j.demeyer@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230829101838.851350-3-daan.j.demeyer@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/29/23 3:18 AM, Daan De Meyer wrote:
> @@ -1482,11 +1485,22 @@ int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
>   	if (!ctx.uaddr) {
>   		memset(&unspec, 0, sizeof(unspec));
>   		ctx.uaddr = (struct sockaddr *)&unspec;
> -	}
> +		ctx.uaddrlen = sizeof(unspec);

ctx.uaddr could be NULL during BPF_CGROUP_RUN_PROG_UDP[46]_SENDMSG_LOCK(). There 
is nothing from the sa_kern->uaddr that is useful to read, so ctx.uaddrlen 
should be 0. The new kfunc bpf_sock_addr_set_addr() can do better than the 
current sa->user_ip[46] uapi and should return error in this case because the 
kernel will eventually ignore it.

> +	} else if (uaddrlen)
> +		ctx.uaddrlen = *uaddrlen;
> +	else if (sk->sk_family == AF_INET)
> +		ctx.uaddrlen = sizeof(struct sockaddr_in);
> +	else if (sk->sk_family == AF_INET6)
> +		ctx.uaddrlen = sizeof(struct sockaddr_in6);
>   
>   	cgrp = sock_cgroup_ptr(&sk->sk_cgrp_data);
> -	return bpf_prog_run_array_cg(&cgrp->bpf, atype, &ctx, bpf_prog_run,
> -				     0, flags);
> +	ret = bpf_prog_run_array_cg(&cgrp->bpf, atype, &ctx, bpf_prog_run,
> +				    0, flags);
> +
> +	if (!ret && uaddrlen)
> +		*uaddrlen = ctx.uaddrlen;
> +
> +	return ret;
>   }
>   EXPORT_SYMBOL(__cgroup_bpf_run_filter_sock_addr);
>   

[ ... ]

> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index 3a88545a265d..255b02d98404 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -135,7 +135,7 @@ static int tcp_v6_pre_connect(struct sock *sk, struct sockaddr *uaddr,
>   
>   	sock_owned_by_me(sk);
>   
> -	return BPF_CGROUP_RUN_PROG_INET6_CONNECT(sk, uaddr);
> +	return BPF_CGROUP_RUN_PROG_INET6_CONNECT(sk, uaddr, NULL);


For IPv6, there is a minimum SIN6_LEN_RFC2133 which excludes the last '__u32 
sin6_scope_id'. Meaning the last 4 bytes in 'struct sockaddr_in6' is optional.

It has been a few months since v2, so my memory faded a bit. I recalled one of 
the concerns on passing addrlen to BPF_CGROUP_RUN_PROG is the bpf prog can 
change it for AF_INET[6] and the addrlen change could be ignored by the kernel.

The bpf_sock_addr_set_addr() in v3 does not allow addrlen changes in AF_INET[6]. 
I think it now makes sense to pass addrlen (of AF_INET[6]) to BPF_CGROUP_RUN_* 
whenever it is available such that the newly added sa_kern->uaddrlen can better 
reflect what is in the sa_kern->uaddr.

I think the only addrlen missing case is in the inet[6]_getname(). Either NULL 
can be passed or create a local addrlen var. afaict, the addrlen must be 'struct 
sockaddr_in[6]' in those cases.

