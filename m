Return-Path: <bpf+bounces-65424-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DB8B2282D
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 15:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A15162674E
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 13:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC4926B2C8;
	Tue, 12 Aug 2025 13:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="E4oZonsI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B57263C8E
	for <bpf@vger.kernel.org>; Tue, 12 Aug 2025 13:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755004354; cv=none; b=aWjdJpcQyoDFX5s3WXpCr0Zf04fzS8sxLxxe9KtnF5lXrAmZg1SEM0S+1SCDSTzx6fe61MX09NfSOaqiUv/Q4N3SgZg4Ew9a6rJ8aXzgtEmGP9oLna2tYd9x6ZHGjz5BhoIdJEROavOibXqsaKWl0BxI63G/K7g4fYO0ZkLZGX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755004354; c=relaxed/simple;
	bh=Q+dL7YFTgtidPt9hAucGWE8TjdN8c70nvX6A662Fl2w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uT6aH2abaK5NGLJDjXSW15GL7GRzciP4Ed0eGQfjtlDkd9U+b4CStor6VUcraX4g2a6D3+R7udTNsE2jTwqvi9ZgeSIubtlYyIqTFmMo753Sk95waIyKCAnP/jLDlv7BT7vyOchej0wT8z/z7TJJnmGSAlHyvRSXXbH60J50xZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=E4oZonsI; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-60bfcada295so8961600a12.1
        for <bpf@vger.kernel.org>; Tue, 12 Aug 2025 06:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1755004350; x=1755609150; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=GgN8nQ/+ZBonr/SCQL/NYBCNen8CZvRuzj39S0Wnd8Y=;
        b=E4oZonsI0MyGC2wRcNWppPN49S3t831aBOGhWZnZm9ofyX1xV93WvNJvy95UrVlazW
         inwm27E8jfy9J/YWrKrdc1BKtwa9beTZDWn3iJNU73vbVvydNYvdBaZV0uwKp0ezcAPK
         GtPcwQm+69YjKYJ2VVMbuPI7r98voA2dih+F06dTY8zl4cLMTOR8GbYvGq8Z/X6DiZoR
         xGDyFXq5Ws43C5f6sJYMlHbFJZeZ3Pn/6pemyqW8cMW4vpk8zicg0arcZiZKi9Z7Z/rn
         OchaOy2l8/HihYNCJtT7ZqQOWDdxQ+UVO+J5xytp0Dtt6fklJy02AiAnXkJQHpRSs1X9
         wX7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755004350; x=1755609150;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GgN8nQ/+ZBonr/SCQL/NYBCNen8CZvRuzj39S0Wnd8Y=;
        b=SB34lreGRYbkiFmiLMtlFu2zlfZWc3BTffnarI/z93hk2DD6BHap1G/9M3KDchXFHf
         1q1uP7anevgXr4Sz0U0Vtm5RHSRilosgTMvL4DE8lnBglXYcEZpBLggBg/PfJGo7BEdl
         RfPKGmSBHpbKIFNodQKUE6rRcKiNcgtJHLRDazw2bUQvSsQhAnZOapHaNgdPYD6edGP1
         xYogTTJmK2FxL9o1LPLuR1mcjry9Acadw3OKMXXQCh8OPJneBiP4NKLhmjGAxBLQ8szK
         GoDy9CaXSgYi16krCxfBBTuEVmTEprQlVcgaNa2tqeqJqlOINs+TX6tyCQV6nCdzbmG3
         sX/w==
X-Forwarded-Encrypted: i=1; AJvYcCW0rPqmKfMP+XcTz1Ysil+BPwHrKnupCubLzbvCqEe9uBNxMpidW2HfSv/+e8i8tDuPdqk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0nun+U1QIFwSC6r+AHlrkhJ73qmHamf4cZ6s0dfevuoIQ0XOi
	CQj1J0XDaBHeOD2z1BNHtCZB/iV27JvE8iR+5geeRFK+Abfp1lHPFe+IS6iXErIrHx4=
X-Gm-Gg: ASbGncv7YsR3ffW0wnczld5mFLrNLFgu365FM6KwHdsL0brAyku+1ZPjkFGlRo8aEXJ
	Vw6kYYJ+YW6Es+h7LPea5GJoYDr3LlSCnae7Ry6Ifn9HySFoqZ0FNOn6JnFfDSUv3ur1TVNXI9H
	E1EqUEchNO1yVzQNInFMtWvu+OQUmGMdy/nbGfbA3Kpes1LpKHTpvLWbYiBd2MBEnOVvjjLAKqW
	1obgiHzi8z3bPOZUBSaU1F/JAhJhO4wPLAjugfHTtiRmDIfvAIw5Ez2ZxPMCagUClNtC7rVwSrN
	BR+xDOEc0W7ff7mEoKYsJfW/TXe8FDFDMzsOpEgkoee9TPdY5Arx4k4AtzrlwpDa6bIVpSSWVPa
	64y10LNWPslXZ8g==
X-Google-Smtp-Source: AGHT+IGYkWNVCxVtLaUEBzhBIySoDMQD8gWWPT0ensnCh7ERmB5oa7n6sdlG5N5YvOVg30lpB7DclA==
X-Received: by 2002:a05:6402:454e:b0:615:6fae:d766 with SMTP id 4fb4d7f45d1cf-617e2e75a33mr11760712a12.26.1755004350478;
        Tue, 12 Aug 2025 06:12:30 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:105])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a911567fsm19715114a12.61.2025.08.12.06.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 06:12:29 -0700 (PDT)
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
In-Reply-To: <e30d66a8-c4de-4d81-880d-36d996b67854@linux.dev> (Martin KaFai
	Lau's message of "Fri, 8 Aug 2025 14:31:33 -0700")
References: <20250804-skb-metadata-thru-dynptr-v6-0-05da400bfa4b@cloudflare.com>
	<20250804-skb-metadata-thru-dynptr-v6-9-05da400bfa4b@cloudflare.com>
	<7a73fb00-9433-40d7-acb7-691f32f198ff@linux.dev>
	<87h5yi82gp.fsf@cloudflare.com>
	<e30d66a8-c4de-4d81-880d-36d996b67854@linux.dev>
Date: Tue, 12 Aug 2025 15:12:28 +0200
Message-ID: <87tt2cr8eb.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Aug 08, 2025 at 02:31 PM -07, Martin KaFai Lau wrote:
> On 8/8/25 4:41 AM, Jakub Sitnicki wrote:
>> On Thu, Aug 07, 2025 at 05:33 PM -07, Martin KaFai Lau wrote:
>>> On 8/4/25 5:52 AM, Jakub Sitnicki wrote:
>>>> +/* Check that skb_meta dynptr is empty */
>>>> +SEC("tc")
>>>> +int ing_cls_dynptr_empty(struct __sk_buff *ctx)
>>>> +{
>>>> +	struct bpf_dynptr data, meta;
>>>> +	struct ethhdr *eth;
>>>> +
>>>> +	bpf_dynptr_from_skb(ctx, 0, &data);
>>>> +	eth = bpf_dynptr_slice_rdwr(&data, 0, NULL, sizeof(*eth));
>>>
>>> If this is bpf_dynptr_slice() instead of bpf_dynptr_slice_rdwr() and...
>>>
>>>> +	if (!eth)
>>>> +		goto out;
>>>> +	/* Ignore non-test packets */
>>>> +	if (eth->h_proto != 0)
>>>> +		goto out;
>>>> +	/* Packet write to trigger unclone in prologue */
>>>> +	eth->h_proto = 42;
>>>
>>> ... remove this eth->h_proto write.
>>>
>>> Then bpf_dynptr_write() will succeed. like,
>>>
>>>          bpf_dynptr_from_skb(ctx, 0, &data);
>>>          eth = bpf_dynptr_slice(&data, 0, NULL, sizeof(*eth));
>>> 	if (!eth)
>>>                  goto out;
>>>
>>> 	/* Ignore non-test packets */
>>>          if (eth->h_proto != 0)
>>> 		goto out;
>>>
>>>          bpf_dynptr_from_skb_meta(ctx, 0, &meta);
>>>          /* Expect write to fail because skb is a clone. */
>>>          err = bpf_dynptr_write(&meta, 0, (void *)eth, sizeof(*eth), 0);
>>>
>>> The bpf_dynptr_write for a skb dynptr will do the pskb_expand_head(). The
>>> skb_meta dynptr write is only a memmove. It probably can also do
>>> pskb_expand_head() and change it to keep the data_meta.
>>>
>>> Another option is to set the DYNPTR_RDONLY_BIT in bpf_dynptr_from_skb_meta() for
>>> a clone skb. This restriction can be removed in the future.
>> Ah, crap. Forgot that bpf_dynptr_write->bpf_skb_store_bytes calls
>> bpf_try_make_writable(skb) behind the scenes.
>> OK, so the head page copy for skb clone happens either in BPF prologue
>> or lazily inside bpf_dynptr_write() call today.
>> Best if I make it consistent for skb_meta from the start, no?
>> Happy to take a shot at tweaking pskb_expand_head() to keep the metadata
>> in tact, while at it.
>
> There is no write helper for the data_meta now. It must directly write to
> skb->data_meta, so data_meta is a read-only for a clone now. I guess the current
> use case is mostly for tc to read the data_meta immediately after the xdp prog
> has added it (fwiw, it is how we tried to use it also), so it is usually not a
> clone (?). Not even sure if it currently has a write use case considering, 1)
> there is no bpf_"skb"_adjust_meta, and 2) the upper layer cannot use it.
>
> No strong opinion to either copy the metadata on a clone or set the dynptr
> rdonly for a clone. I am ok with either way.
>
> A brain dump:
> On one hand, it is hard to comment without visibility on how will it look like
> when data_meta can be preserved in the future, e.g. what may be the overhead but
> there is flags in bpf_dynptr_from_skb_meta and bpf_dynptr_write, so there is
> some flexibility. On the other hand, having a copy will be less surprise on the
> clone skb like what we have discovered in this and the earlier email thread but
> I suspect there is actually no write use case on the skb data_meta now.

All makes sense.

To keep things simple and consistent, it would be best to have a single
unclone (bpf_try_make_writable) point caused by a write to metadata
through an skb clone.

Today, the unclone in the prologue can already be triggered by a write
to data_meta from a dead branch. Despite being useless, since
pskb_expand_head resets meta_len.

We also need the prologue unclone for bpf_dynptr_slice_rdwr created from
an skb_meta dynptr, because creating a slice does not invalidate packet
pointers by contract.

So I'm thinking it makes sense to unclone in the prologue if we see a
potential bpf_dynptr_write to skb_meta dynptr as well. This could be
done by tweaking check_helper_call to set the seen_direct_write flag:

static int check_helper_call(...)
{
        // ...
       	switch (func_id) {
        // ...
	case BPF_FUNC_dynptr_write:
	{
                // ...
		dynptr_type = dynptr_get_type(env, reg);
                // ...
		if (dynptr_type == BPF_DYNPTR_TYPE_SKB ||
		    dynptr_type == BPF_DYNPTR_TYPE_SKB_META)
			changes_data = true;
		if (dynptr_type == BPF_DYNPTR_TYPE_SKB_META)
			env->seen_direct_write = true;

		break;
	}
        // ...
}

That would my the plan for the next iteration, if it sounds sensible.

As for keeping metadata intact past a pskb_expand_head call, on second
thought, I'd leave that for the next patch set, to keep the patch count
within single digits.


