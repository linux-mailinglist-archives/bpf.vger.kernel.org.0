Return-Path: <bpf+bounces-51090-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05748A300AE
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 02:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D75A1882C64
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 01:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACB61E5710;
	Tue, 11 Feb 2025 01:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QoR0j2mX"
X-Original-To: bpf@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4C81FCF7C;
	Tue, 11 Feb 2025 01:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739237522; cv=none; b=VmzwjkMvvuJdMFn6lJEL23ERsYXmvoRuFIW8uOlEnPX2VToAhl8AQnEdMVsQrH6pjTRpNTjxXEiTIsKPJFLLHsEK9F6ixq1VzbAjULoK5NHxbjwYfVzAFhLXVIeOUivDg9JMB0LUGER50Drx/MKOeGmt2US77gGsjMQfftWnW4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739237522; c=relaxed/simple;
	bh=/e1SyLOssKabt8BWs4Fdn+h3tz+FrLEdRnMxGzAdqmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=euErGBCdztt4Tw8eiq7TfoPzrjhY+jNOzO3FiuKPqQONl2+zt5z1xFPyvy9TOCOFgQoGIVET4xolPhIoVw+vDoJbcXobRAhcCdKxWVqz8Y2jB39C5VbWsiK2lDLERDDyKkwzray4NAjgEtpjoA/RiZqYwYQGusKxx/+0JgEzj1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QoR0j2mX; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fb1111fc-6a4e-4388-860c-0077910e814f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739237518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=neP0SKgEI+w95/65Hgd9dc1j+6tueIdAR6FbJXn0Es0=;
	b=QoR0j2mXfye/7Z10EAc2fVguGdEyTDrQTEln593Lre3frbvHmURUVT5DYyBF17V2Lx2ZTh
	IIerLadkiBIleLirYwoy/Rr2nqAu9Lb5iZ3t/87ig95NfV8djqgKBzM6xNK459njVNDhj8
	sTcDWQL38FRcKstKtO2dfirRO9BlYtc=
Date: Mon, 10 Feb 2025 17:31:50 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v9 02/12] bpf: prepare for timestamping callbacks
 use
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250208103220.72294-1-kerneljasonxing@gmail.com>
 <20250208103220.72294-3-kerneljasonxing@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250208103220.72294-3-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/8/25 2:32 AM, Jason Xing wrote:
> Later, four callback points to report information to user space
> based on this patch will be introduced.
> 
> As to skb initialization here, users can follow these three steps
> as below to fetch the shared info from the exported skb in the bpf
> prog:
> 1. skops_kern = bpf_cast_to_kern_ctx(skops);
> 2. skb = skops_kern->skb;
> 3. shinfo = bpf_core_cast(skb->head + skb->end, struct skb_shared_info);
> 
> More details can be seen in the last selftest patch of the series.

This BPF program example is not useful in this commit message. It is not how 
this change will be used in the kernel. People will naturally be required to 
look at the selftest to see how the bpf prog can get to the skb and tskey, etc.

The commit message should focus on explaining "what" has changed and "why" it is 
necessary. The "why" part ("four callback points to report...") is mostly 
present but could be clearer.

Subject: bpf: Prepare the sock_ops ctx and call bpf prog for TX timestamping

(What)
This patch introduces a new bpf_skops_tx_timestamping() function that prepares 
the "struct bpf_sock_ops" ctx and then executes the sockops BPF program.

(Why)
The subsequent patch will utilize bpf_skops_tx_timestamping() at the existing TX 
timestamping kernel callbacks (__sk_tstamp_tx specifically) to call the sockops 
BPF program.


> 
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> ---
>   include/net/sock.h |  7 +++++++
>   net/core/sock.c    | 15 +++++++++++++++
>   2 files changed, 22 insertions(+)
> 
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 7916982343c6..6f4d54faba92 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -2923,6 +2923,13 @@ int sock_set_timestamping(struct sock *sk, int optname,
>   			  struct so_timestamping timestamping);
>   
>   void sock_enable_timestamps(struct sock *sk);
> +#if defined(CONFIG_CGROUP_BPF)
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
> index eae2ae70a2e0..41db6407e360 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -948,6 +948,21 @@ int sock_set_timestamping(struct sock *sk, int optname,
>   	return 0;
>   }
>   
> +#if defined(CONFIG_CGROUP_BPF)
> +void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb, int op)
> +{
> +	struct bpf_sock_ops_kern sock_ops;
> +
> +	memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
> +	sock_ops.op = op;
> +	sock_ops.is_fullsock = 1;
> +	sock_ops.sk = sk;
> +	bpf_skops_init_skb(&sock_ops, skb, 0);
> +	/* Timestamping bpf extension supports only TCP and UDP full socket */

nit: After our earlier discussions, it's clear that the above is_fullsock = 1; 
is always true for all sk here. This comment has become redundant. Let's remove it.

> +	__cgroup_bpf_run_filter_sock_ops(sk, &sock_ops, CGROUP_SOCK_OPS);
> +}
> +#endif
> +
>   void sock_set_keepalive(struct sock *sk)
>   {
>   	lock_sock(sk);


