Return-Path: <bpf+bounces-67221-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A20C3B40E4C
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 22:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50A063A3CAF
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 20:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B3C2E7652;
	Tue,  2 Sep 2025 20:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OLXt4ft+"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E732AF1B
	for <bpf@vger.kernel.org>; Tue,  2 Sep 2025 20:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756843337; cv=none; b=YFiqY/HtaivKFCdD2pidwEyHpRADmahzesUWYo5sqazvI5/aIt/fJD4rZSfPSgdFHCn+uI7wCAtb8edLoWttLl42BoLACpjgy6PFVjcAn82gBFU/qgeOvM5H5AjR/Ne2Nhbw8MLglKvmnxkLtB5F5ouasY9Jf9NSgUFLXcZBvbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756843337; c=relaxed/simple;
	bh=zc04ghhfwnLRYRShTKVcLauO8ktPn1CgQwQAw+WpMOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q3rPalvqj/MDljnhKPTbi4+vBaP+FddpQKT3W7WtnMzY6S+vzUy1C8x65NbR+xS/DHefQjgHRY/Bf2ceG7Se3VE6VNs4KOApQtGyT4g086v9gdXs4PmutoEhnhR9xuEwPwJRKguoDtzqdNLF6IJICQn0JJknk8jn84Ck/za/Lc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OLXt4ft+; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e4d9f89b-03cb-47ee-bc71-acea080a84e2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756843332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V+JdT4Wgnn25xoKItxxRHwiaGiuoeCjlMg47tKTZurc=;
	b=OLXt4ft+EpnjRXIZmAiCQ2oECVKnBMwtzNEmoH5x9y0uerjqHjo5szzMXgNjLaQqfwMX4E
	1HjtIpSvSChjXXVCKdFdjbwSHvCDhHmJz8/NX4njxPtPhHJi3e4t2ymLj5e16vj+rgNf8d
	KxqiI8VrpgRVlk2qEqGH45ogH95lML8=
Date: Tue, 2 Sep 2025 13:02:03 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 bpf-next/net 3/5] bpf: Introduce SK_BPF_MEMCG_FLAGS and
 SK_BPF_MEMCG_SOCK_ISOLATED.
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
References: <20250829010026.347440-1-kuniyu@google.com>
 <20250829010026.347440-4-kuniyu@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250829010026.347440-4-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/28/25 6:00 PM, Kuniyuki Iwashima wrote:
>   static int sol_socket_sockopt(struct sock *sk, int optname,
>   			      char *optval, int *optlen,
>   			      bool getopt)
> @@ -5284,6 +5313,7 @@ static int sol_socket_sockopt(struct sock *sk, int optname,
>   	case SO_BINDTOIFINDEX:
>   	case SO_TXREHASH:
>   	case SK_BPF_CB_FLAGS:
> +	case SK_BPF_MEMCG_FLAGS:
>   		if (*optlen != sizeof(int))
>   			return -EINVAL;
>   		break;
> @@ -5293,8 +5323,15 @@ static int sol_socket_sockopt(struct sock *sk, int optname,
>   		return -EINVAL;
>   	}
>   
> -	if (optname == SK_BPF_CB_FLAGS)
> +	switch (optname) {
> +	case SK_BPF_CB_FLAGS:
>   		return sk_bpf_set_get_cb_flags(sk, optval, getopt);
> +	case SK_BPF_MEMCG_FLAGS:

I would remove the getsockopt only support from the other hooks that cannot do 
the setsockopt. There are other ways for them to read sk->sk_memcg if it is 
really needed.

> +		if (!IS_ENABLED(CONFIG_MEMCG) || !getopt)
> +			return -EOPNOTSUPP;
> +
> +		return sk_bpf_get_memcg_flags(sk, optval);

Instead, do this only in bpf_sock_create_getsockopt.


