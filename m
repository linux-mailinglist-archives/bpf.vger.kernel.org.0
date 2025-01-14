Return-Path: <bpf+bounces-48876-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 165CEA11589
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 00:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69EAF7A1196
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 23:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F159621423A;
	Tue, 14 Jan 2025 23:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tNQHz/j0"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA522144BF
	for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 23:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736898015; cv=none; b=qhXC099IzOeAxZHgKBaiFz7Izlp3nPa+6UVjqVgJAm/vj5P6VibAJaujfz4xEFVPXeY6dGrXjdaagERMAQdg4nFJnnDqUSpV4tQQ2CEfL0Usy3JeHN9k2w+vpIYilNenwDrF29p79yq0h6RapENvjurf+okfhpMGT8J8MOfJCw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736898015; c=relaxed/simple;
	bh=p4buqTjeJQG3h6HRQvCZEMwz749vK9HxFe78V3xPKwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c46DamdyrCFyxeFOLoYZRTUxyWo/VXPHRK3ebE+ywURMg7Ts3y+rogmJTeKfoG1C5MDPVpWQxggY9FLDLmnRjpC+KUoHoF2PTUZh4m44C1vogGQ+Y42sDnJvp5Ye0xcBn8/sL/H4ES4Bz9M5HizX2EksAUZBvwqkRdvGhKIHrlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tNQHz/j0; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5480eedb-ceb0-402e-883b-da4207dcc43d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736897996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=urAWnGyUdLXnXPqUT46mpecD0eBCSqqmE2X8DFw16Fk=;
	b=tNQHz/j0ICOlAiAzYtPE5kBMZKS0R7bi9zhHZhohgkJ4mT6GOHfNmmk1GIX7EOkvq/lV3Z
	70zKwGYBs/TrV3kJOw02zCKS/lL+XfM8TfUbfXtoNHfqjzuLQ0ROPID6V+y3W2RTIMFeaD
	gTYMH7jv2Iy8tn1Hrsyd6Aoi+WFmuWE=
Date: Tue, 14 Jan 2025 15:39:37 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v5 02/15] net-timestamp: prepare for bpf prog use
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250112113748.73504-1-kerneljasonxing@gmail.com>
 <20250112113748.73504-3-kerneljasonxing@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20250112113748.73504-3-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/12/25 3:37 AM, Jason Xing wrote:
> Later, I would introduce three points to report some information
> to user space based on this.
> 
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> ---
>   include/net/sock.h |  7 +++++++
>   net/core/sock.c    | 14 ++++++++++++++
>   2 files changed, 21 insertions(+)
> 
> diff --git a/include/net/sock.h b/include/net/sock.h
> index f5447b4b78fd..dd874e8337c0 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -2930,6 +2930,13 @@ int sock_set_timestamping(struct sock *sk, int optname,
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
> index eae2ae70a2e0..e06bcafb1b2d 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -948,6 +948,20 @@ int sock_set_timestamping(struct sock *sk, int optname,
>   	return 0;
>   }
>   
> +#if defined(CONFIG_CGROUP_BPF) && defined(CONFIG_BPF_SYSCALL)
> +void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb, int op)
> +{
> +	struct bpf_sock_ops_kern sock_ops;
> +
> +	memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
> +	sock_ops.op = op;
> +	if (sk_is_tcp(sk) && sk_fullsock(sk))
> +		sock_ops.is_fullsock = 1;
> +	sock_ops.sk = sk;
> +	__cgroup_bpf_run_filter_sock_ops(sk, &sock_ops, CGROUP_SOCK_OPS);

hmm... I think I have already mentioned it in the earlier revision
(https://lore.kernel.org/bpf/f8e9ab4a-38b9-43a5-aaf4-15f95a3463d0@linux.dev/).

__cgroup_bpf_run_filter_sock_ops(sk, ...) requires sk to be fullsock.
Take a look at how BPF_CGROUP_RUN_PROG_SOCK_OPS does it.
sk_to_full_sk() is used to get back the listener. For other mini socks,
it needs to skip calling the cgroup bpf prog. I still don't understand
why BPF_CGROUP_RUN_PROG_SOCK_OPS cannot be used here because of udp.

> +}
> +#endif
> +
>   void sock_set_keepalive(struct sock *sk)
>   {
>   	lock_sock(sk);


