Return-Path: <bpf+bounces-67217-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5DBB40D68
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 20:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4AE8C4E41C0
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 18:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2867F345750;
	Tue,  2 Sep 2025 18:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eRJ1/XGc"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532FC34F494
	for <bpf@vger.kernel.org>; Tue,  2 Sep 2025 18:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756839329; cv=none; b=jHrOqGo1tHTBzaOeiSBUs1Z1083hVR/9kouc1jbjXBBz8JbfFh29AqQlK/YisnSqVsm0aQNb9q7onP7Cni3QGLFUfaV9Qxa/BDhS20/Orxk8pwS4kSIVQPWo2hFRliRGFbW8x16ggG9nbUuthPxCca/Ro8mLl/SiGmBixVExhyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756839329; c=relaxed/simple;
	bh=k30iZqFphVmrjXtQ7cb3XHZFtGwVkWt+HAh0/BqYOZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JqFLMu79KrDlwefWYv2cxCTM0OC6om06SSQlaykVERB+4YRy0sUV7334Cg66hgTdNqvUQN1tfPAhv3pE4LDNJplPtmdeKygBvW56MJp2ExrvGzWrfHNHJ4qSVaVCYz8fYf3EBvNcIbJ/XtU1zGNDbGyC5Unv7MV/AuijlulFKlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eRJ1/XGc; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2527aee9-4e19-4e41-9176-7be1eda9aede@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756839308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sG8VBcevWdIN+EMwmaHGKO4rbCX49MuPx14U2puOrFA=;
	b=eRJ1/XGcbshKsl89UradqzBl/8fQHXtLnFMQ0IZOy7s3jAdvHSuXvkwshYLrI+lZZbG0t/
	IjtOCGZgyWhA/sfA/s38oiPZJVmVgmb2ucc3nIaHHfiaxygFMPt+OTJsDdOfDs8yqBwwuN
	k9MQG3z2IXRf2d3C+y8cnKFWUAZstIw=
Date: Tue, 2 Sep 2025 11:55:01 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 bpf-next/net 1/5] tcp: Save lock_sock() for memcg in
 inet_csk_accept().
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
 <20250829010026.347440-2-kuniyu@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20250829010026.347440-2-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/28/25 6:00 PM, Kuniyuki Iwashima wrote:
> mem_cgroup_sk_alloc() is called for SCTP before __inet_accept(),
> so I added the protocol check in __inet_accept(), but this can be
> removed once SCTP uses sk_clone_lock().

>   void __inet_accept(struct socket *sock, struct socket *newsock, struct sock *newsk)
>   {
> +	/* TODO: use sk_clone_lock() in SCTP and remove protocol checks */
> +	if (mem_cgroup_sockets_enabled &&
> +	    (!IS_ENABLED(CONFIG_IP_SCTP) ||
> +	     sk_is_tcp(newsk) || sk_is_mptcp(newsk))) {

Instead of protocol check, is it the same as checking
"if (mem_cgroup_sockets_enabled && !mem_cgroup_from_sk(newsk))"

> +		gfp_t gfp = GFP_KERNEL | __GFP_NOFAIL;
> +
> +		mem_cgroup_sk_alloc(newsk);
> +
> +		if (mem_cgroup_from_sk(newsk)) {
> +			int amt;
> +
> +			/* The socket has not been accepted yet, no need
> +			 * to look at newsk->sk_wmem_queued.
> +			 */
> +			amt = sk_mem_pages(newsk->sk_forward_alloc +
> +					   atomic_read(&newsk->sk_rmem_alloc));
> +			if (amt)
> +				mem_cgroup_sk_charge(newsk, amt, gfp);
> +		}
> +
> +		kmem_cache_charge(newsk, gfp);
> +	}
> +

