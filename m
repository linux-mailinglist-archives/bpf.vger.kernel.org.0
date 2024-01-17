Return-Path: <bpf+bounces-19700-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C9A82FE99
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 02:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DE9D286BDC
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 01:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD51517E9;
	Wed, 17 Jan 2024 01:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wSxQDHkK"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9430138E;
	Wed, 17 Jan 2024 01:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705456539; cv=none; b=ieK3PK7axdoWjHOpuOCeXoi96yrKvoqCT4cpEehCeRdIGWo9hLDpYqMQtOtQUx7jEsodQuYf13mkRNjlJgzZnCD5VvHZMrkyumYJ5pH85cVaRebjSocKQ+7chLmI8wi77A+l5FIb9Bl9D/EpBRlW2A53Da5AW7mTJgtzVyo1zxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705456539; c=relaxed/simple;
	bh=Ud9pgdI8WdGZ2k6pYJHx9fd2eH10qoZoBhAIfJfSEmg=;
	h=Message-ID:DKIM-Signature:Date:MIME-Version:Subject:
	 Content-Language:To:Cc:References:X-Report-Abuse:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Migadu-Flow; b=NmetbI8hCeAoeC+4w5Vqd6QN4vBlUN+hbJnlmlQVvX1jwKPGllsJb4bFeEwqpE9qZFUyQ8/RIIU1n28y/Gf/5bzbj9Xkw9BHqWZfQW82jLYPgRFxI6lGVLCda+XZq4zs2yMHNKOEJmsX1wPC1UrFGob9IYAybXaBwSj/gIfqMYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wSxQDHkK; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <358c0c74-3c01-4de2-95e0-750fa800d362@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705456534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2E5JwxCSZmWo3JqGWWA5fZW/OPPZrbzXLN35U8M1YtU=;
	b=wSxQDHkKZJYzcPOW4vnRmhCLF+5I+2vx8+jd1H3kxQFT1eIck8kHtL+4dWRQz48j3Qywaq
	Glff57lGrlKSIm2pXkJcXGAcTV4elmtvlVk0hwe0mcASNGgeNF12Fk738Gvmd0d+GJExaT
	kiUZsfT8mLyhSWTYNWPlMuygx72Vo9Y=
Date: Tue, 16 Jan 2024 17:55:12 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v8 bpf-next 5/6] bpf: tcp: Support arbitrary SYN Cookie.
Content-Language: en-US
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20240115205514.68364-1-kuniyu@amazon.com>
 <20240115205514.68364-6-kuniyu@amazon.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240115205514.68364-6-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/15/24 12:55 PM, Kuniyuki Iwashima wrote:
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 8c9f67c81e22..647d04171b7e 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -11837,6 +11837,106 @@ __bpf_kfunc int bpf_sock_addr_set_sun_path(struct bpf_sock_addr_kern *sa_kern,
>   
>   	return 0;
>   }
> +
> +__bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct sk_buff *skb, struct sock *sk,
> +					struct bpf_tcp_req_attrs *attrs, int attrs__sz)
> +{
> +#if IS_ENABLED(CONFIG_SYN_COOKIES)
> +	const struct request_sock_ops *ops;
> +	struct inet_request_sock *ireq;
> +	struct tcp_request_sock *treq;
> +	struct request_sock *req;
> +	struct net *net;
> +	__u16 min_mss;
> +	u32 tsoff = 0;
> +
> +	if (attrs__sz != sizeof(*attrs) ||
> +	    attrs->reserved[0] || attrs->reserved[1] || attrs->reserved[2])
> +		return -EINVAL;
> +
> +	if (!sk)

I removed this "!sk" check, the verifier will check for it,

and ...

> +BTF_SET8_START(bpf_kfunc_check_set_tcp_reqsk)
> +BTF_ID_FLAGS(func, bpf_sk_assign_tcp_reqsk)

... limited it to KF_TRUSTED_ARGS. The arg "sk" must be from "bpf_sk*_lookup_*" 
or from "bpf_map_lookup_elem(&sock_map,...)". Both of them have 
"reg->ref_obj_id" (i.e. the verifier tracks the refcnt acquire/release) and it 
is as good as trusted ptr.

The above is some final details I noticed. Applied. Thanks.

> +BTF_SET8_END(bpf_kfunc_check_set_tcp_reqsk)


