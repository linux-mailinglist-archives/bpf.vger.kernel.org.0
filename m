Return-Path: <bpf+bounces-46588-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C2D9EC1E7
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 03:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55D64188B99D
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 02:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E6D1FBCA8;
	Wed, 11 Dec 2024 02:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tBfLw1u3"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133A613C8E8
	for <bpf@vger.kernel.org>; Wed, 11 Dec 2024 02:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733882565; cv=none; b=DP/0kWH1xuLbu6HuL/KY9uVA18dk9RlIUpW4mL5mjW9XX4Sne9QJybjUZbXzUj0dYQl+B8LbJnjlTmbxaJn2lyT+o6i4bntFgZ5WApChOA9x2W1y68euS91Y1QXmjWtpAgTn5+HB1Ol100/+DbAdnzc3QLvwsfEEi4nU11JbqBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733882565; c=relaxed/simple;
	bh=ubXllK2pLReEjaBlDelkGycxR1NgCutC4e1A8MgvOjE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LwfcnT4+n4Q4WNKqQs54gr8NZWSEJiWmlXoynagr/oXtdkc4H1s0qjbxELpCj6FHELjuSWNtjuMD4qaMc6IvExnZSJmbRfMQr06yOHR3tugA8FhvIMqRUthST1ROEQ1vSJAFTRrEgdWyLzA7rTDrhhTMT/jQHNaz+ObhG1ksod8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tBfLw1u3; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f8e9ab4a-38b9-43a5-aaf4-15f95a3463d0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733882560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WZo1N6zH9M6mCoSFsoCT/bk8JFhrIX+nr0NyRMLv+t8=;
	b=tBfLw1u3+NotL66uvKQdnfMSjqjC6GORwSCrKGSGoCZJXJyDs48P2lgPxUnl2Wh7xWNW50
	hMQ8XItHrYJd2eNGv3Pm7JqvSusd8KqGgBi97qSsftz65wra3r9GCGwl9cBjTCI6RaN8iT
	HPCW0xOCat2CgXJUzqoY7GaDfNkYPmQ=
Date: Tue, 10 Dec 2024 18:02:31 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4 02/11] net-timestamp: prepare for bpf prog use
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
References: <20241207173803.90744-1-kerneljasonxing@gmail.com>
 <20241207173803.90744-3-kerneljasonxing@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20241207173803.90744-3-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/7/24 9:37 AM, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Later, I would introduce three points to report some information
> to user space based on this.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>   include/net/sock.h |  7 +++++++
>   net/core/sock.c    | 15 +++++++++++++++
>   2 files changed, 22 insertions(+)
> 
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 0dd464ba9e46..f88a00108a2f 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -2920,6 +2920,13 @@ int sock_set_timestamping(struct sock *sk, int optname,
>   			  struct so_timestamping timestamping);
>   
>   void sock_enable_timestamps(struct sock *sk);
> +#if defined(CONFIG_CGROUP_BPF) && defined(CONFIG_BPF_SYSCALL)
> +void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb, int op);
> +#else
> +static inline void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb, int op)
> +{
> +}
> +#endif
>   void sock_no_linger(struct sock *sk);
>   void sock_set_keepalive(struct sock *sk);
>   void sock_set_priority(struct sock *sk, u32 priority);
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 74729d20cd00..79cb5c74c76c 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -941,6 +941,21 @@ int sock_set_timestamping(struct sock *sk, int optname,
>   	return 0;
>   }
>   
> +#if defined(CONFIG_CGROUP_BPF) && defined(CONFIG_BPF_SYSCALL)
> +void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb, int op)
> +{
> +	struct bpf_sock_ops_kern sock_ops;
> +
> +	sock_owned_by_me(sk);

I don't think this can be assumed in the time stamping callback.

To remove this assumption for sockops, I believe it needs to stop the bpf prog 
from calling a few bpf helpers. In particular, the bpf_sock_ops_cb_flags_set and 
bpf_sock_ops_setsockopt. This should be easy by asking the helpers to check the 
"u8 op" in "struct bpf_sock_ops_kern *".

I just noticed a trickier one, sockops bpf prog can write to sk->sk_txhash. The 
same should go for reading from sk. Also, sockops prog assumes a fullsock sk is 
a tcp_sock which also won't work for the udp case. A quick thought is to do 
something similar to is_fullsock. May be repurpose the is_fullsock somehow or a 
new u8 is needed. Take a look at SOCK_OPS_{GET,SET}_FIELD. It avoids 
writing/reading the sk when is_fullsock is false.

This is a signal that the existing sockops interface has already seen better 
days. I hope not too many fixes like these are needed to get tcp/udp 
timestamping to work.

> +
> +	memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
> +	sock_ops.op = op;
> +	sock_ops.is_fullsock = 1;

I don't think we can assume it is always is_fullsock either.

> +	sock_ops.sk = sk;
> +	__cgroup_bpf_run_filter_sock_ops(sk, &sock_ops, CGROUP_SOCK_OPS);

Same here. sk may not be fullsock. BPF_CGROUP_RUN_PROG_SOCK_OPS(&sock_ops) is 
needed.

[ I will continue the rest of the set later. ]

> +}
> +#endif
> +
>   void sock_set_keepalive(struct sock *sk)
>   {
>   	lock_sock(sk);


