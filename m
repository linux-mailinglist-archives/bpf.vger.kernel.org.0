Return-Path: <bpf+bounces-65262-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E068B1E78D
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 13:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B8911AA58EE
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 11:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2514C274FE0;
	Fri,  8 Aug 2025 11:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="cxWbsLsD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43DD274B5C
	for <bpf@vger.kernel.org>; Fri,  8 Aug 2025 11:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754653323; cv=none; b=hXybvQZutsUCFaZaVNQutU6n0syKJS55VQz8xsbdYr4g57KhFLRdExwK82zfJVhQ3LDe6xvIyaEFtd4yNoQrNRc6lzL11ncn9+7cmsTqKwRiFTYM6Qe9M/Rgf9OCpNWbLx5KoS3hRka9S0IBV2Rs/oJr7QiJpYFFnXVF+rtP2NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754653323; c=relaxed/simple;
	bh=IFJJRBw+9oHEIebrI+O4dWEY1tf+7aWKEfUWfiwgwPI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Yj5BKE63pEC6FF6PAyWcspJYFzliKKp4ipB8hIeiXGDFA8SoO7uZjrtog4rtt54MbdDu90tgmpHSAv5NbZcdnatfkgJ/pllP9TWxK6iswTRiqpnfhJpfI4Nr06TpdNZUUJN1GfBw+poDNjdNO7P/BoJGMNVvLxXojOhhpjeO5Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=cxWbsLsD; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-af95525bac4so390333666b.0
        for <bpf@vger.kernel.org>; Fri, 08 Aug 2025 04:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1754653320; x=1755258120; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=BMb9m3VLCQ1bgs63e85F6NbEdzA1hg8PJ5Yy7EGRKnQ=;
        b=cxWbsLsDRN1OAMaop0mvlafbuBowL94WWheqiYHftE2xg3QaAeNyTN6OTgnmjkZO9r
         77OwLnXWTJevCdAYitsiQ0gCmrjgqaV8lvqzZCglJkJi2j7G8zA9WUUq+kkjqY+szJxs
         mpUAdT1j6s0JxbIGJCoaUkKTqRQItAbf1UmH026CdGxxskAEzHhCTDdtOH1hOf+7er16
         jwMqsn4P58FpGEpepYNujAkTtdYm+C0nHupeLxyLp0FfuyY1h5LI0sUDjBxQHLv4oaIQ
         FaMNqwdHMlzXGhdnYQU89eFm+cYDt24IplCXZ3dIIX+/kbwwwRFuK/ZOvMWqt8HwOHi+
         xCbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754653320; x=1755258120;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BMb9m3VLCQ1bgs63e85F6NbEdzA1hg8PJ5Yy7EGRKnQ=;
        b=J3+A1ipPGp4Rk86otIZzFpd5ueAWXIgSuCC/gAkfL/8mLQu1zmkIX8Qeitqk0QVyK+
         rzOV8JzhD5jZRLMbl7n6Jg5DTuq3BNla9qz+ceQYc5mkOdG4Utw3AVNGLHjiowPFomjV
         6qh6KiRwFOnI9JHblqVC5rZZEb9m3OESG1rDoTR8YN0LRXBUejGiQdvXA9pt9n5ZOgKj
         SgHoQZ+7IyogV2u+ZoTV4DoSLa3O+GLOGWu8+9xlOZZyZYWkd1Cb1EmSQHd7ieX82phW
         YgrN8K3Q84/U5eCCiQQVJB3qH+uvCO0NPcYj4+G7VlY0RaKshnrb4U5CwLcsSfsSYtbh
         iJEg==
X-Forwarded-Encrypted: i=1; AJvYcCU/enQsTNoBrAZnJmB1XyHBS8EU9BORq9X9RqhSvrQQf1kYrW6kAgdpQxgkb3Z/rnwcPIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhTpeATrxriP9QhtthCJLGIqu1V4drZkFGwhvVcOaRMB/IwBoo
	jyoccaax0ctlP/Frle1vR6LAI+hYXuycFFZs0l7AhPkXlMIsUdrGR7MxNNjtQ9aC2nU=
X-Gm-Gg: ASbGncvtYrrIWInPU3OWwAAKJOSETRbfLZa8Z3FFoZ/PEPCB4BZ5qORRXbgTVnOEhF7
	tZziBqnh8KUzXQ3BKSHgsCLU3c0SvvqVQRCqnB5nUbmpaogZq28Y5cxEF8ROQ+igUa3YgvCaPcU
	+0q1XaJH+mbeAXcdCtuy0Bv+nl/E2YZQasUHB6wMO2Q8fa/EsAvsXyIuiW30x46GqofMQDQCXRG
	Yph1HDk4b/s1R7kRunUvz1sI2yWIJN5/unra7IZygDYrxTP0iUA6CjHP9sk55QyRS0nns21gtYy
	KhMmG2hcLw2dv1UH6NQ15Jo8sJU9WPhscqCyzTegg+McTPDGnZZpHmOcZpWCNfPzRU3TLxqt5bB
	bA7aD8uRKDka5ILY=
X-Google-Smtp-Source: AGHT+IHeczUL7oSEmBMSThziAzNDX9koz3AI45mChEQtGKYTeLIZaWza/AaAYPTWCdEljwBraeoIRQ==
X-Received: by 2002:a17:906:6a07:b0:ade:44f8:569 with SMTP id a640c23a62f3a-af9c653e5admr171028266b.42.1754653319998;
        Fri, 08 Aug 2025 04:41:59 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:9d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a3b77sm1482297666b.51.2025.08.08.04.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 04:41:59 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,  Andrii Nakryiko
 <andrii@kernel.org>,  Arthur Fabre <arthur@arthurfabre.com>,  Daniel
 Borkmann <daniel@iogearbox.net>,  Eduard Zingerman <eddyz87@gmail.com>,
  Eric Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,
  Jesper Dangaard Brouer <hawk@kernel.org>,  Jesse Brandeburg
 <jbrandeburg@cloudflare.com>,  Joanne Koong <joannelkoong@gmail.com>,
  Lorenzo Bianconi <lorenzo@kernel.org>,  Toke =?utf-8?Q?H=C3=B8iland-J?=
 =?utf-8?Q?=C3=B8rgensen?=
 <thoiland@redhat.com>,  Yan Zhai <yan@cloudflare.com>,
  kernel-team@cloudflare.com,  netdev@vger.kernel.org,
  bpf@vger.kernel.org,  Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH bpf-next v6 9/9] selftests/bpf: Cover metadata access
 from a modified skb clone
In-Reply-To: <7a73fb00-9433-40d7-acb7-691f32f198ff@linux.dev> (Martin KaFai
	Lau's message of "Thu, 7 Aug 2025 17:33:43 -0700")
References: <20250804-skb-metadata-thru-dynptr-v6-0-05da400bfa4b@cloudflare.com>
	<20250804-skb-metadata-thru-dynptr-v6-9-05da400bfa4b@cloudflare.com>
	<7a73fb00-9433-40d7-acb7-691f32f198ff@linux.dev>
Date: Fri, 08 Aug 2025 13:41:58 +0200
Message-ID: <87h5yi82gp.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Aug 07, 2025 at 05:33 PM -07, Martin KaFai Lau wrote:
> On 8/4/25 5:52 AM, Jakub Sitnicki wrote:
>> +/* Check that skb_meta dynptr is empty */
>> +SEC("tc")
>> +int ing_cls_dynptr_empty(struct __sk_buff *ctx)
>> +{
>> +	struct bpf_dynptr data, meta;
>> +	struct ethhdr *eth;
>> +
>> +	bpf_dynptr_from_skb(ctx, 0, &data);
>> +	eth = bpf_dynptr_slice_rdwr(&data, 0, NULL, sizeof(*eth));
>
> If this is bpf_dynptr_slice() instead of bpf_dynptr_slice_rdwr() and...
>
>> +	if (!eth)
>> +		goto out;
>> +	/* Ignore non-test packets */
>> +	if (eth->h_proto != 0)
>> +		goto out;
>> +	/* Packet write to trigger unclone in prologue */
>> +	eth->h_proto = 42;
>
> ... remove this eth->h_proto write.
>
> Then bpf_dynptr_write() will succeed. like,
>
>         bpf_dynptr_from_skb(ctx, 0, &data);
>         eth = bpf_dynptr_slice(&data, 0, NULL, sizeof(*eth));
> 	if (!eth)
>                 goto out;
>
> 	/* Ignore non-test packets */
>         if (eth->h_proto != 0)
> 		goto out;
>
>         bpf_dynptr_from_skb_meta(ctx, 0, &meta);
>         /* Expect write to fail because skb is a clone. */
>         err = bpf_dynptr_write(&meta, 0, (void *)eth, sizeof(*eth), 0);
>
> The bpf_dynptr_write for a skb dynptr will do the pskb_expand_head(). The
> skb_meta dynptr write is only a memmove. It probably can also do
> pskb_expand_head() and change it to keep the data_meta.
>
> Another option is to set the DYNPTR_RDONLY_BIT in bpf_dynptr_from_skb_meta() for
> a clone skb. This restriction can be removed in the future.

Ah, crap. Forgot that bpf_dynptr_write->bpf_skb_store_bytes calls
bpf_try_make_writable(skb) behind the scenes.

OK, so the head page copy for skb clone happens either in BPF prologue
or lazily inside bpf_dynptr_write() call today.

Best if I make it consistent for skb_meta from the start, no?

Happy to take a shot at tweaking pskb_expand_head() to keep the metadata
in tact, while at it.

>
>> +
>> +	/* Expect no metadata */
>> +	bpf_dynptr_from_skb_meta(ctx, 0, &meta);
>> +	if (bpf_dynptr_size(&meta) > 0)
>> +		goto out;
>> +
>> +	test_pass = true;
>> +out:
>> +	return TC_ACT_SHOT;
>> +}

