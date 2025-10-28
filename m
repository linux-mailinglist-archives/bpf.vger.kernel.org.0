Return-Path: <bpf+bounces-72520-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51ADAC14632
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 12:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04CFB4687E0
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 11:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FAC30DD02;
	Tue, 28 Oct 2025 11:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OHK3vQ9x"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D442DE71C
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 11:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761651039; cv=none; b=fsoueZrVxnBHJ1swEgZRwY7dA6EDW4Ns42x1z9Cq2cBYT5cuAKpVsoR6h0a/LrhpM6KTNSvqMrIYf0ygdlm0WDyXWsYWQ7lt/lSIgixLqhm05cR2dY8k0hZ1tIV+dAV5pC4T3xQGqsMZiUGiA8gHI1lsMgb0knpecMzz+szHKWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761651039; c=relaxed/simple;
	bh=uLz1nCOc13P72Z9cLqgJATuBA1im88R9TxqI9YQCXBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=co7yjDbkaH/D/qqgDeyclaM3H4g6jdjYtqVnWIJo+rUHcxwDYKFvT7LuRNlFoY5GZP0Q9Om6mcH1RMvtG6HJ02Ese4J5FbU5Jre2zT7wbJn2++UN2/89jetw6VKX2wAvgoLlwDPtsXPecNq9tYUao/k6GKOKX8Mf960XDtaRk1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OHK3vQ9x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761651035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6wj7YAztZrM6wj1+S+3q5JHWOPj4KIXwKeK9N2bqLfU=;
	b=OHK3vQ9x/ZP6u43xL2s3MoVZhKcY+OmiBIZObFBud6rTLFkRALFkcmrJVsLYD0kxycC1io
	/T+M5MGd3BIWaYMGLmWZT+OhXj/PrSzdXeGzuYDUgYvhs5FqiUnhGzeF3hwt299SMUaA/X
	9Ny5JoVOYKbrPibUnjblCMo9uG/H+kE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-MQnGNzQgPIOqEFIPPsRDOQ-1; Tue, 28 Oct 2025 07:30:33 -0400
X-MC-Unique: MQnGNzQgPIOqEFIPPsRDOQ-1
X-Mimecast-MFC-AGG-ID: MQnGNzQgPIOqEFIPPsRDOQ_1761651032
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4710d174c31so54745775e9.0
        for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 04:30:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761651031; x=1762255831;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6wj7YAztZrM6wj1+S+3q5JHWOPj4KIXwKeK9N2bqLfU=;
        b=SgCcHVXxoQm9AVl+BSsNWxpjx5KLHP57Lp+X5yK5tu7zrnmFG5oKHviRVCyl9A/EfL
         uO6az/RBtoTOGOE+jkxtz6MMR56ifPE95gGPtBrmdG/UGOs3lOtg9GvR6m3cerjtCdhd
         q00tILe/5gymW0yPy/CVByv1+AwlY1EzulKtCNVucqqAyAc7bNDpUNaWF4EOAmgF2s6U
         Rz6VtzpmEorNEM77I9o2VltSfdpYUMXM0tA87P6CF1YhxM2LtQMtduwGttyTunM2erRB
         FktPYw3BqPPweU9OjDWIu28PaR417zpsKpe/2r5N+jkxi/sUq7pQgY3oI5jE2TKiXb3d
         2fcQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9mkU/pvqj72uVElmfEYKlHPmhxTonp+lC3r2X9uYBF5ZcpxG9YR3Sc1o3croN4G6sMBM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh/m2MLwfikl8824OcwBLNn89nt3h9J0PmiZLthFjeDvZUVye+
	+4+a8wq32+mRvYYV51/MtG34dZjkWBIZ14OUlyjyqLaEhmD0F+oOtiy1RcCnMw7kYUIl/lxJh3I
	754nSZUAgzTMrmCmaHweynFYinu1m0DCPXVxPIS1OXyejYY8KZJ5JOQ==
X-Gm-Gg: ASbGncuHahshpYrNAf+rp69cY88vnXk1qqlTDjfBfrTuesmwRQXK27v6jNIg1R/x7Kq
	x0w5vBnGRO8VxCRE/K8D/eMM0zTwc1hQVjBYfYxg2ChAjxZFLpYRIXdK/zEo687tTNyvRiyWaLA
	d3l1hCSeDvtAZDRI53sdtqe4SaHOWqb8s6Z6SCsJ3xJJmGzKklcYBR7zR1b31BmmrLGRcKO8NrC
	KpX/TW8IQ6f4YYEw25sSV8fCmLgu0HwutPqbySo+IKQWe/Mr637P4ko7AYch4ElaJr/8n0soFs0
	UL4JRkD6Q3Tj8S2ujTLcwWDO9zIqnmNnE27VhLT6KOO3NSWwM/RKe7/czSBtXzxnyzfSoqcU4Ew
	9JM5P9b3lep0D5v4K+hMHhILufWhGUpndcfhc1eeklgfhZ3E=
X-Received: by 2002:a05:600c:4446:b0:475:da13:2566 with SMTP id 5b1f17b1804b1-47717e6095fmr25034645e9.35.1761651031635;
        Tue, 28 Oct 2025 04:30:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1UoWkDkAxEnPYbIqlYF36LNiS1od7f4r/oylsQ8lGjLYMkIaaEI5SdiPojR2VWZlNQPGbIA==
X-Received: by 2002:a05:600c:4446:b0:475:da13:2566 with SMTP id 5b1f17b1804b1-47717e6095fmr25034235e9.35.1761651031148;
        Tue, 28 Oct 2025 04:30:31 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd489fa4sm187152685e9.16.2025.10.28.04.30.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 04:30:30 -0700 (PDT)
Message-ID: <c10939d2-437e-47fb-81e9-05723442c935@redhat.com>
Date: Tue, 28 Oct 2025 12:30:27 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/3] net,mptcp: fix proto fallback detection with
 BPF sockmap
To: Jiayuan Chen <jiayuan.chen@linux.dev>, mptcp@lists.linux.dev
Cc: stable@vger.kernel.org, Jakub Sitnicki <jakub@cloudflare.com>,
 John Fastabend <john.fastabend@gmail.com>, Eric Dumazet
 <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Willem de Bruijn <willemb@google.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Matthieu Baerts <matttbe@kernel.org>,
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20251023125450.105859-1-jiayuan.chen@linux.dev>
 <20251023125450.105859-2-jiayuan.chen@linux.dev>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251023125450.105859-2-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/23/25 2:54 PM, Jiayuan Chen wrote:
> When the server has MPTCP enabled but receives a non-MP-capable request
> from a client, it calls mptcp_fallback_tcp_ops().
> 
> Since non-MPTCP connections are allowed to use sockmap, which replaces
> sk->sk_prot, using sk->sk_prot to determine the IP version in
> mptcp_fallback_tcp_ops() becomes unreliable. This can lead to assigning
> incorrect ops to sk->sk_socket->ops.

I don't see how sockmap could modify the to-be-accepted socket sk_prot
before mptcp_fallback_tcp_ops(), as such call happens before the fd is
installed, and AFAICS sockmap can only fetch sockets via fds.

Is this patch needed?

/P


