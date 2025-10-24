Return-Path: <bpf+bounces-72119-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35191C0702C
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 17:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DB7F3BF70D
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 15:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CAE32B996;
	Fri, 24 Oct 2025 15:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="AXj3YSc+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504A031C56D
	for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 15:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761320415; cv=none; b=TXUgU3Ptzzib+YyC61gGymRAOycJMi/VGNHzXRf6wUI/jiglhwuPozQba3v8V3zydfPHQJHoTqAgjxonWRfgfsapat6dvvCLvjoXV3LptUfNscC5+2+KrYP0MBFgThGa+KK1KgXMZPMPbdTPnyVECbuRlL/AIxlA06zKipFhBOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761320415; c=relaxed/simple;
	bh=TOTw9cyt0jzOOFOkRrXql7e84izLCjdIR8/b0Dfclw4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=poil+nlm5i6463l+JTS1GPbgBrP3+z5KSwZ4nEtHw7hT3nqywt7o9YU3RW/mI1JtsBw7OFby6WCWyDJlvpp56/NwN1DxHLsNIiEcbVhBosld4aimthTWqOXW3J8kA4HSUWe+j/yOTI10TxdncKgc8Wl+EI+3s2R3LMpmdguqxcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=AXj3YSc+; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b6d53684cfdso499714366b.0
        for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 08:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1761320410; x=1761925210; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=htCDT17I+oR0txxNfdsHCVMXppAnM5WVr/frwza3Ggc=;
        b=AXj3YSc+F8bqsV37gGKLJv+m9fKZ/i6oN00XJEWh/3Xpz8WB2BQzx5FmxYc1dvxfmM
         13Ymr+ki9lktA/o0VHVApUvGaW0fPilSnGWyEbb+HRJrWyV6zAiGFyWhKuz/Vanm8Hdk
         g94JuVbtT57CIkUqeIZhNvSwXV0WHRp3vZRaE5Wkqj2KIelESMdQCpS3HdvEJghdkoiW
         thk3ovAR9asddohS0kmKJKPQRTlU6C7yLPaCeWW0AvVvoFxPcz0vR76k8ZRL0rwYw9sG
         qlwAewBBRtnsNFMt6nSaWcO40IObyMImUpnqlgBMbV8O/qULjGkFFIyVf0U95k93kdNd
         L2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761320410; x=1761925210;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=htCDT17I+oR0txxNfdsHCVMXppAnM5WVr/frwza3Ggc=;
        b=LEbVZrp+u9qN8Eru/QV99riswLog3sNauYkXZSji70ZyCzQF+uad1kSYaYxyihN2wG
         GNMbc6+KOFvK30MBTiUS/KWDzPCje81SiOAi8jtvoDC8ExFotdjVs3ald0cQoFCOI+JB
         8Mz05rV5ZYRJR6q4QIcU0klVBi02yNXR3RC9kNoBGbqyYNOFKnQYG8gDKeIx5ZTWb0lp
         1HVGeSisnmHBxNfnKdja4z3JjdLWLLjetglNdV7C/2e5Wl+Uclsm0W5xCgmCp8qz5dw6
         nokJZAxNoHF1LI7GC1i4imXA4A4G6QJJkqdCAaIG7BiUGcBB6uF2/wVXQotoVtSm+l4e
         toJg==
X-Forwarded-Encrypted: i=1; AJvYcCU1hknKIPixXloIuAFvv8r69DYTBY0SqhqoB5T3PJLGG5DDmZPrBS4j/AVzgh70alkNBFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsLYWGUo6j8/1kF2Ch7UT8DVoUn1ZVauGLo8ksI5BpDBfNMJMu
	Np/sD2El4SbvQryNKe81yo4tdNkc3MS6OKIQhiYXfwc+sa7kiyCWC07onWMqV7GVx60=
X-Gm-Gg: ASbGncv+wZulV2xowls7L05uKCyx+rCyCWhd/weXqdTBW3IGoFgivl0XQMsA810uAH3
	pDFidwho3NWVOTgHrKqxAoy+MR0KimS0MUe6M52MDyR+THeShj2WMlohOTUp3T2Mraka0XCIRE7
	xmZbdDIeIVy6cyzv5c+KoAlziJYhyPTrvGhuDGesllk+l/2f46T9vMRUuzqE6HC4FJMSHEWUc9A
	/xYXGyevJHdJu7kD39fsF/0Q8KqR8bgB/qX1i43WEh2/nsyG4+M5eIOykiGZjQ9Zj6ZNmB6Snnb
	qSNRvPjefT1WmCDIOVOX5KmaxiaDpXJ1hlz2TmR3OwzoRhnZK7JXz7+mrXVlsf/IyxfSr3R9haE
	hqH59FbCIggYxjwe6BMWR//5sEo50CEdc2YlP8zYup4zt/Ytr7vFQLGNyEd3ZRewN5q+vMTb/mp
	8H5w==
X-Google-Smtp-Source: AGHT+IEJVI4kQmjTK1q9deoNiLGnVsziSLE5151UvJovcemype2yzzkCb8sGREpuNVCmeBY3siEdjA==
X-Received: by 2002:a17:907:9607:b0:b53:e871:f0ea with SMTP id a640c23a62f3a-b6475510df3mr3834214966b.56.1761320410479;
        Fri, 24 Oct 2025 08:40:10 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:12f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d511d02c4sm562769366b.15.2025.10.24.08.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 08:40:10 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  John Fastabend <john.fastabend@gmail.com>,
  Stanislav Fomichev <sdf@fomichev.me>,  Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>,  Eduard Zingerman
 <eddyz87@gmail.com>,  Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>,  KP Singh <kpsingh@kernel.org>,  Hao Luo
 <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Arthur Fabre
 <arthur@arthurfabre.com>,  bpf@vger.kernel.org,  netdev@vger.kernel.org,
  kernel-team@cloudflare.com, Jesper Dangaard Brouer <hawk@kernel.org>
Subject: Re: [PATCH bpf-next v2 11/15] selftests/bpf: Expect unclone to
 preserve skb metadata
In-Reply-To: <e9f3ccc7-750b-4d60-ae03-ac493b766b56@linux.dev> (Martin KaFai
	Lau's message of "Thu, 23 Oct 2025 19:32:44 -0700")
References: <20251019-skb-meta-rx-path-v2-0-f9a58f3eb6d6@cloudflare.com>
	<20251019-skb-meta-rx-path-v2-11-f9a58f3eb6d6@cloudflare.com>
	<2753c96b-48f9-480e-923c-60d2c20ebb03@linux.dev>
	<87ms5hvnlk.fsf@cloudflare.com>
	<e9f3ccc7-750b-4d60-ae03-ac493b766b56@linux.dev>
Date: Fri, 24 Oct 2025 17:40:09 +0200
Message-ID: <87ecqsux46.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Oct 23, 2025 at 07:32 PM -07, Martin KaFai Lau wrote:
> On 10/23/25 4:55 AM, Jakub Sitnicki wrote:
>> On Wed, Oct 22, 2025 at 04:12 PM -07, Martin KaFai Lau wrote:
>>> On 10/19/25 5:45 AM, Jakub Sitnicki wrote:
>>>> @@ -447,12 +448,14 @@ int clone_dynptr_empty_on_meta_slice_write(struct __sk_buff *ctx)
>>>>      /*
>>>>     * Check that skb_meta dynptr is read-only before prog writes to packet payload
>>>> - * using dynptr_write helper. Applies only to cloned skbs.
>>>> + * using dynptr_write helper, and becomes read-write afterwards. Applies only to
>>>> + * cloned skbs.
>>>>     */
>>>>    SEC("tc")
>>>> -int clone_dynptr_rdonly_before_data_dynptr_write(struct __sk_buff *ctx)
>>>> +int clone_dynptr_rdonly_before_data_dynptr_write_then_rw(struct __sk_buff *ctx)
>>>>    {
>>>>    	struct bpf_dynptr data, meta;
>>>> +	__u8 meta_have[META_SIZE];
>>>>    	const struct ethhdr *eth;
>>>>      	bpf_dynptr_from_skb(ctx, 0, &data);
>>>> @@ -465,15 +468,23 @@ int clone_dynptr_rdonly_before_data_dynptr_write(struct __sk_buff *ctx)
>>>>      	/* Expect read-only metadata before unclone */
>>>>    	bpf_dynptr_from_skb_meta(ctx, 0, &meta);
>>>> -	if (!bpf_dynptr_is_rdonly(&meta) || bpf_dynptr_size(&meta) != META_SIZE)
>>>> +	if (!bpf_dynptr_is_rdonly(&meta))
>>>
>>> Can the bpf_dynptr_set_rdonly() be lifted from the bpf_dynptr_from_skb_meta()?
>>>
>>> iiuc, the remaining thing left should be handling a cloned skb in
>>> __bpf_dynptr_write()? The __bpf_skb_store_bytes() is using
>>> bpf_try_make_writable, so maybe something similar can be done for the
>>> BPF_DYNPTR_TYPE_SKB_META?
>> I'm with you. This is not user-friendly at all currently.
>> This patch set has already gotten quite long so how about I split out
>> the pskb_expand_head patch (#1) and the related selftest change (patch
>> #11) from this series, expand it to lift bpf_dynptr_set_rdonly()
>> limitation for skb_meta dynptr, and do that first in a dedicated series?
>
> A followup on lifting the bpf_dynptr_set_rdonly is fine and keep this set as
> is. Just want to check if there is anything stopping it. However, imo, having
> one or two patches over is fine. The set is not difficult to follow.

All right. I will pile that one on. 16 makes it a nice even number.

[...]

>>> I have a high level question about the set. I assume the skb_data_move() in
>>> patch 2 will be useful in the future to preserve the metadata across the
>>> stack. Preserving the metadata across different tc progs (which this set does)
>>> is nice to have but it is not the end goal. Can you shed some light on the plan
>>> for building on top of this set?
>> Right. Starting at the highest level, I want to work toward preserving
>> the metadata on RX path first (ongoing), forward path next, and TX path
>> last.
>> On RX path, the end game is for sk_filter prog to be able to access
>> metadata thru dynptr. For that we need to know where the metadata
>> resides. I see two ways how we can tackle that:
>> A) We keep relying on metadata being in front of skb_mac_header().
>>     Fun fact - if you don't call any TC BPF helpers that touch
>>     skb->mac_header and don't have any tunnel or tagging devices on RX
>>     path, this works out of the box today. But we need to make sure that
>>     any call site that changes the MAC header offset, moves the
>>     metadata. I expect this approach will be a pain on TX path.
>> ... or ...
>> B) We track the metadata offset separately from MAC header offset
>>     This requires additional state, we need to store the metadata offset
>>     somewhere. However, in exchange for a couple bytes we gain some
>>     benefits:
>>     1. We don't need to move the metadata after skb_pull.
>>     2. We only need to move the metadata for skb_push if there's not
>>       enough space left, that is the gap between skb->data and where
>>       metadata ends is too small.
>>       (This means that anyone who is not using skb->data_meta on RX path
>>       but the skb_meta dynptr instead, can avoid any memmove's of the
>>       metadata itself.)
>
>
> I don't think I get this part. For example, bpf_dynptr_slice_rdwr(&meta_dynptr)
> should be treated like
> skb->data_meta also?

That's the thing. With dynptr we don't care where the metadata is
located. Hence, no need to move it before the prog runs, even if there
is a gap between the metadata and the MAC header, say, because of GRE
decap. If we track metadata separately the skb_metadata_end() could
become:

static inline void *skb_metadata_end(const struct sk_buff *skb)
{
	return skb->head + skb_shinfo(skb)->meta_end;
}

[..]

> Having a way to separately track the metadata start/end is useful.
> An unrelated dumb/lazy question, is it possible/lot-of-changes to put the
> metadata in the head (or after xdp_frame?) in the RX path?

We've been asking ourselves the same theoretical question. There are
at least a couple challenges to retrofit such change:

1. You'd need a way to track where the metadata ends in XDP. As I hear
   from Jesper, XDP metadata was intentionally placed right in front of
   the packet to avoid computing/loading another pointer.

2. You'd be moving the contents when growing the metadata with
   bpf_xdp_adjust_meta. Or you'd need to add a way to resize it by
   moving the end.

Not really something we've considered attacking ATM.

My gut feeling is that it will do us good to leave the metadata close to
the MAC header during the initial adoption phase to catch all the call
sites that push headers without moving the metadata and need fixing.

[...]

