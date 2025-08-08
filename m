Return-Path: <bpf+bounces-65244-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32736B1DFF6
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 02:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BDA45669F7
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 00:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7290F12B73;
	Fri,  8 Aug 2025 00:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I6Wn3Xt2"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267FDDDAD
	for <bpf@vger.kernel.org>; Fri,  8 Aug 2025 00:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754613244; cv=none; b=e8SdgUukQCgjUwMppm2IzWqbJOgyBWrawBjhwdmNkyJO2WdGfYoFk910+Ku8lHOAcYFId3xg30BZcgKQkkeNDe7Nk4+N9J0y1sHXkR9BZuzdX4kTiwaMu/HUcmLwBZQoSYFQjaN6ETr4OhsjWWhqdeA+z751zLimf3zs3i+Cii4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754613244; c=relaxed/simple;
	bh=uez1LvaW4jPtLA5JVOmIdQe7itBGXB8ohZV6CUz0uTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Db5XuKzJ4TtZdVRP7Yp1r6ULlAFuQEr6DUSFmTfy/Z4jEy2HWtuAHMrkkn+yQj3lJcQXHIwvZStqDhULX97k0iwPzsyZMvQQ5Owpun+cqEgLuULU1zqsb5KKIwRG5WyA7Wybm4ZxV0mNr+UXh/dxDywJfGnw0AV0+jDFsl2Eu8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I6Wn3Xt2; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7a73fb00-9433-40d7-acb7-691f32f198ff@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754613230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dTkHCXnD4M7V2JUeyQeb5nt8PCy7/rijGCweadvB5Tc=;
	b=I6Wn3Xt2/rPBxDgdVN+x9jihodYyJKkQkSLtXC2MjYCKfSmZmr0ETKCJyZHjNu/7Lk8ZMn
	UAT913CnQy87LPrvcauokPHq5yMqvOpjFwY7DcEzTelaIFO8GH17s/3bjhgzbn1+7pCozW
	/2pHa9Pv0HxQ5OLAtlhIlADgZHJD3v0=
Date: Thu, 7 Aug 2025 17:33:43 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 9/9] selftests/bpf: Cover metadata access from
 a modified skb clone
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Arthur Fabre <arthur@arthurfabre.com>, Daniel Borkmann
 <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Jesse Brandeburg <jbrandeburg@cloudflare.com>,
 Joanne Koong <joannelkoong@gmail.com>, Lorenzo Bianconi
 <lorenzo@kernel.org>, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
 <thoiland@redhat.com>, Yan Zhai <yan@cloudflare.com>,
 kernel-team@cloudflare.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
 Stanislav Fomichev <sdf@fomichev.me>
References: <20250804-skb-metadata-thru-dynptr-v6-0-05da400bfa4b@cloudflare.com>
 <20250804-skb-metadata-thru-dynptr-v6-9-05da400bfa4b@cloudflare.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20250804-skb-metadata-thru-dynptr-v6-9-05da400bfa4b@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/4/25 5:52 AM, Jakub Sitnicki wrote:
> +/* Check that skb_meta dynptr is empty */
> +SEC("tc")
> +int ing_cls_dynptr_empty(struct __sk_buff *ctx)
> +{
> +	struct bpf_dynptr data, meta;
> +	struct ethhdr *eth;
> +
> +	bpf_dynptr_from_skb(ctx, 0, &data);
> +	eth = bpf_dynptr_slice_rdwr(&data, 0, NULL, sizeof(*eth));

If this is bpf_dynptr_slice() instead of bpf_dynptr_slice_rdwr() and...

> +	if (!eth)
> +		goto out;
> +	/* Ignore non-test packets */
> +	if (eth->h_proto != 0)
> +		goto out;
> +	/* Packet write to trigger unclone in prologue */
> +	eth->h_proto = 42;

... remove this eth->h_proto write.

Then bpf_dynptr_write() will succeed. like,

         bpf_dynptr_from_skb(ctx, 0, &data);
         eth = bpf_dynptr_slice(&data, 0, NULL, sizeof(*eth));
	if (!eth)
                 goto out;

	/* Ignore non-test packets */
         if (eth->h_proto != 0)
		goto out;

         bpf_dynptr_from_skb_meta(ctx, 0, &meta);
         /* Expect write to fail because skb is a clone. */
         err = bpf_dynptr_write(&meta, 0, (void *)eth, sizeof(*eth), 0);

The bpf_dynptr_write for a skb dynptr will do the pskb_expand_head(). The 
skb_meta dynptr write is only a memmove. It probably can also do 
pskb_expand_head() and change it to keep the data_meta.

Another option is to set the DYNPTR_RDONLY_BIT in bpf_dynptr_from_skb_meta() for 
a clone skb. This restriction can be removed in the future.

> +
> +	/* Expect no metadata */
> +	bpf_dynptr_from_skb_meta(ctx, 0, &meta);
> +	if (bpf_dynptr_size(&meta) > 0)
> +		goto out;
> +
> +	test_pass = true;
> +out:
> +	return TC_ACT_SHOT;
> +}


