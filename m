Return-Path: <bpf+bounces-41316-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A87995C49
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 02:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A39B71C21FF8
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 00:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107E75684;
	Wed,  9 Oct 2024 00:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HWCOP+6b"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F464685;
	Wed,  9 Oct 2024 00:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728433338; cv=none; b=J+srf0OPboqTEKkf8LBNptgq8EsBsr9Vu3bSorMb/bjvW+Mc/gTS2W4e1962647KymUcllviV6Uz94QVexzZRhoX9Q3Jmu7o6/KUzmDB75rl9S3I1BzsiqDHuOoru0lZuF9M5dznH9V61HwwGrFuP7XdeHGm++OCEkG0i0Ntw4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728433338; c=relaxed/simple;
	bh=P0eGSONP1L25wijyw7mA6+55+MXWy9VUXzEAwbUuF6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BScmbMIc8zReuqFz6XrPUhMSR0YVvJ/m/HFOsbP4LfXqIvTCkQyEODwVTetWsqP1ec9nV1e2s+9jp624u1D6FXfwuJd/KmiuaPoH/Q7K/Vu0/RT4wPwX5lUNyhjfFKTRMcDYNoEOrUPoHbKcBYoxA55POeoddbCAWh+C011NJ4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HWCOP+6b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AF15C4CEC7;
	Wed,  9 Oct 2024 00:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728433338;
	bh=P0eGSONP1L25wijyw7mA6+55+MXWy9VUXzEAwbUuF6Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HWCOP+6b8grI9FWJhksJ+47WLZjvwYRUTAsE5wLgKOwJ6c+uI5uK/yIcxfLxAWTxg
	 l4QOQ72liQgPjUSiRQbsqPhpf6fKngTnoFE9G/ZMgW0taKDAiEwFuseMtgrVd0omZU
	 qG5q2ZcYwSCVLlfbzBaVidA2/Ip7f1OhkEg7J/jFm+LsSpRRr+KL8HxJrSB4sQy41G
	 Ny15GrDZbZGK8Nae7Xvl1rQGD4FLpam+uFgvYcKgtBH77HOuL+q5A70QUw/NGGPUxm
	 oiZePI0mhCUK19eA8ZHL4d9fdlhoyNcjfcV4e1SPN2URlXCbNiuJjakQpEXI39w/19
	 rWte2ukJH5ZWg==
Date: Tue, 8 Oct 2024 17:22:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 dsahern@kernel.org, willemdebruijn.kernel@gmail.com, willemb@google.com,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next 8/9] net-timestamp: add bpf framework for rx
 timestamps
Message-ID: <20241008172216.6f7b5697@kernel.org>
In-Reply-To: <20241008095109.99918-9-kerneljasonxing@gmail.com>
References: <20241008095109.99918-1-kerneljasonxing@gmail.com>
	<20241008095109.99918-9-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  8 Oct 2024 17:51:08 +0800 Jason Xing wrote:
> +static bool tcp_bpf_recv_timestamp(struct sock *sk, struct scm_timestamping_internal *tss)
> +{
> +	struct tcp_sock *tp = tcp_sk(sk);
> +
> +	if (BPF_SOCK_OPS_TEST_FLAG(tp, BPF_SOCK_OPS_RX_TIMESTAMPING_OPT_CB_FLAG))
> +		return true;
> +
> +	return false;
> +}
> +
>  /* Similar to __sock_recv_timestamp, but does not require an skb */
>  void tcp_recv_timestamp(struct msghdr *msg, const struct sock *sk,
>  			struct scm_timestamping_internal *tss)
> @@ -2284,6 +2294,9 @@ void tcp_recv_timestamp(struct msghdr *msg, const struct sock *sk,
>  	u32 tsflags = READ_ONCE(sk->sk_tsflags);
>  	bool has_timestamping = false;
>  
> +	if (tcp_bpf_recv_timestamp(sk, tss))

net/ipv4/tcp.c:2297:29: error: passing 'const struct sock *' to parameter of type 'struct sock *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
 2297 |         if (tcp_bpf_recv_timestamp(sk, tss))
      |                                    ^~
net/ipv4/tcp.c:2279:49: note: passing argument to parameter 'sk' here
 2279 | static bool tcp_bpf_recv_timestamp(struct sock *sk, struct scm_timestamping_internal *tss)
      |                                                 ^
-- 
pw-bot: cr

