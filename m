Return-Path: <bpf+bounces-57340-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 279AFAA934A
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 14:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAABB3A6139
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 12:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076A2202995;
	Mon,  5 May 2025 12:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ih/yKa8y"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77A3242901
	for <bpf@vger.kernel.org>; Mon,  5 May 2025 12:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746448567; cv=none; b=N8yNirvFwXq/PGDTKW4mMY/AnPqhoKEplJwqmFlhaEuiuCjcuM0i6lu1+Tr2SpDL6025lnfRaJgDWHfT9/K81Q6GFp+ruWkAeq08dHUzyEMQ4sb00ccCq3/pgm0Ye09TMLrgB+0qQs5obgVjTjDuFxxxhSX+kphze5dqEwLo9Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746448567; c=relaxed/simple;
	bh=IZMqJR9iPNBXOt18Q5Jcy6Sv60Nss5f+oYM3wXxVwz0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aBlYBUEpov9KPNVT9+et9ScgCpqtV7vBtM8By8qotMxpN6CWdWNX/Uj0Lu6+RMwHGY5ofmduZpy2fprf1BG5IH2KAmn4HzM7NGw+r//Fel6Nir/E7IficOK9S0Z5n7iePKb9kruz4nbVIZ6Tzd2lbGPCtWULRlIwZ8uK/ePkh4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ih/yKa8y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746448564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zd9lIH67Jb2DCCgzhluz5VdKEnmvINRsRtpDTYKsHH0=;
	b=Ih/yKa8yZMXUWBeQqAZBzRcwOU7q0aOvwiqF2Vu+n25vEHoB8FnwXPPGVu9w5SQuhCFUvD
	Noy842Sz9FNeB3TdRejQIwFBPONLAd7GH+nMQ5qqSryRU77UHjLannnZtZrmLpaKznul41
	faxSz0aLLaY2MU4TvwgfzT/WtovvKXs=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-mwGqMl9dPCCS8pBTAmNPmQ-1; Mon, 05 May 2025 08:36:03 -0400
X-MC-Unique: mwGqMl9dPCCS8pBTAmNPmQ-1
X-Mimecast-MFC-AGG-ID: mwGqMl9dPCCS8pBTAmNPmQ_1746448562
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-30c2e219d47so19294291fa.3
        for <bpf@vger.kernel.org>; Mon, 05 May 2025 05:36:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746448562; x=1747053362;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zd9lIH67Jb2DCCgzhluz5VdKEnmvINRsRtpDTYKsHH0=;
        b=PEFkGsh/3FCyL8ztWzOhs8qYoZsbQdJTfHX++2Fb2vCQE9HhdoetVWwE8hN45ormZs
         gRZytZgI4eFkP4iEZG9rnSpeLerywRAB3JSlqHF+Q7pDkj6bXvTxkwqDNAYqrd/Oy2Z1
         r3xwnWs2a5dp2dOqUv1vobQF9O5rRHV9njePuYtM6AXvRxd12LSd0M1VVEDJHL0TIfsC
         C2xj3vAHuofeGztFc1u9VypVPClQkzqEjiPYNXOYV1Q9uHaNbSiqwt9uT/vY3oma6PBl
         +8ssXum+EFXmHe+7IbRbP+zPdMqWsu++HOMpiGhfscMZzVMdeqW1rTl6knEeQ29pAnsh
         fJ8g==
X-Forwarded-Encrypted: i=1; AJvYcCXll4A2cZLWvqE8T+R70EeUmHgAhqByvx061XQUJHGqy3O2AQnRhhq5P0Iyc4i5WCWQna4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx74iZRUqqqjc/UCU5bR6wz9e+HAmHJ9GbXHPwHtPQ03z0aIq8k
	5vUnQOtnF1ae8YilJzG86b5RIxkxvNDCrVMm9beS90Hk7TbaKtx9TC5lTTBoM6AO2B6gU3VJ3ie
	Sb3W4rBefrnOlbMGeheukMc1GWD5BOJ1u6LaIQ4jdiHL94lzNUQ==
X-Gm-Gg: ASbGncvrSeAgtqpcZmwBAdL8Hb984nkklL4QyKsuRctnWH8wTLPGxzNAmM8OFic2yPI
	qfwVbQlEYKxSGO36XZUh1viKVuMB6xmA7uAt7K46CRT4ABg73atpiv1r4q2g8BFvCHF+v6vnPfl
	KKoq7yKzmdaXWSMBPhj70zouxR1xwG48IFVwH3y2S9wO964thz4NoD9xuOm/gIslqSgs3q6L8wf
	f8rOfDg0K3k8cliyIx9Foh/CGllRwPbRXZN6KRqJZkozkSJYYPaM2XqBcp1//OSbY7yqR0sxuYS
	PIFRC4LYm4BquTJY/B8/Yma8Hk/jae77OdfG
X-Received: by 2002:a05:6512:318e:b0:545:fc8:e155 with SMTP id 2adb3069b0e04-54eb2436aa6mr2036246e87.20.1746448561705;
        Mon, 05 May 2025 05:36:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiPe/m5oiRtynwFrSESjlPJAHzC15+fcCBqHbmvlKgn5bCmAMioBgv5JkcqtWB1sA/GsZ2MA==
X-Received: by 2002:a05:6512:318e:b0:545:fc8:e155 with SMTP id 2adb3069b0e04-54eb2436aa6mr2036232e87.20.1746448561187;
        Mon, 05 May 2025 05:36:01 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ea94f227csm1686964e87.208.2025.05.05.05.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 05:36:00 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id A16291A0BD84; Mon, 05 May 2025 14:35:59 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Arthur Fabre
 <arthur@arthurfabre.com>, Network Development <netdev@vger.kernel.org>,
 bpf <bpf@vger.kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, Yan
 Zhai <yan@cloudflare.com>, jbrandeburg@cloudflare.com,
 lbiancon@redhat.com, Alexei Starovoitov <ast@kernel.org>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 kernel-team@cloudflare.com
Subject: Re: [PATCH RFC bpf-next v2 01/17] trait: limited KV store for
 packet metadata
In-Reply-To: <87a57r4azq.fsf@cloudflare.com>
References: <20250422-afabre-traits-010-rfc2-v2-0-92bcc6b146c9@arthurfabre.com>
 <20250422-afabre-traits-010-rfc2-v2-1-92bcc6b146c9@arthurfabre.com>
 <CAADnVQJeCC5j4_ss2+G2zjMbAcn=G3JLeAJCBZRC8uzfsVAjMA@mail.gmail.com>
 <D9FYTORERFI7.36F4WG8G3NHGX@arthurfabre.com>
 <CAADnVQKe3Jfd+pVt868P32-m2a-moP4H7ms_kdZnrYALCxx53Q@mail.gmail.com>
 <87frhqnh0e.fsf@toke.dk> <87ikmle9t4.fsf@cloudflare.com>
 <875xik7gsk.fsf@toke.dk> <87a57r4azq.fsf@cloudflare.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 05 May 2025 14:35:59 +0200
Message-ID: <871pt35j68.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jakub Sitnicki <jakub@cloudflare.com> writes:

> On Thu, May 01, 2025 at 12:43 PM +02, Toke H=C3=B8iland-J=C3=B8rgensen wr=
ote:
>> Jakub Sitnicki <jakub@cloudflare.com> writes:
>>
>>> On Wed, Apr 30, 2025 at 11:19 AM +02, Toke H=C3=B8iland-J=C3=B8rgensen =
wrote:
>>>> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>>>>
>>>>> On Fri, Apr 25, 2025 at 12:27=E2=80=AFPM Arthur Fabre <arthur@arthurf=
abre.com> wrote:
>>>>>>
>>>>>> On Thu Apr 24, 2025 at 6:22 PM CEST, Alexei Starovoitov wrote:
>>>>>> > On Tue, Apr 22, 2025 at 6:23=E2=80=AFAM Arthur Fabre <arthur@arthu=
rfabre.com> wrote:
>>>
>>> [...]
>>>
>>>>>> * Hardware metadata: metadata exposed from NICs (like the receive
>>>>>>   timestamp, 4 tuple hash...) is currently only exposed to XDP progr=
ams
>>>>>>   (via kfuncs).
>>>>>>   But that doesn't expose them to the rest of the stack.
>>>>>>   Storing them in traits would allow XDP, other BPF programs, and the
>>>>>>   kernel to access and modify them (for example to into account
>>>>>>   decapsulating a packet).
>>>>>
>>>>> Sure. If traits =3D=3D existing metadata bpf prog in xdp can communic=
ate
>>>>> with bpf prog in skb layer via that "trait" format.
>>>>> xdp can take tuple hash and store it as key=3D=3D0 in the trait.
>>>>> The kernel doesn't need to know how to parse that format.
>>>>
>>>> Yes it does, to propagate it to the skb later. I.e.,
>>>>
>>>> XDP prog on NIC: get HW hash, store in traits, redirect to CPUMAP
>>>> CPUMAP: build skb, read hash from traits, populate skb hash
>>>>
>>>> Same thing for (at least) timestamps and checksums.
>>>>
>>>> Longer term, with traits available we could move more skb fields into
>>>> traits to make struct sk_buff smaller (by moving optional fields to
>>>> traits that don't take up any space if they're not set).
>>>
>>> Perhaps we can have the cake and eat it too.
>>>
>>> We could leave the traits encoding/decoding out of the kernel and, at
>>> the same time, *expose it* to the network stack through BPF struct_ops
>>> programs. At a high level, for example ->get_rx_hash(), not the
>>> individual K/V access. The traits_ops vtable could grow as needed to
>>> support new use cases.
>>>
>>> If you think about it, it's not so different from BPF-powered congestion
>>> algorithms and scheduler extensions. They also expose some state, kept =
in
>>> maps, that only the loaded BPF code knows how to operate on.
>>
>> Right, the difference being that the kernel works perfectly well without
>> an eBPF congestion control algorithm loaded because it has its own
>> internal implementation that is used by default.
>
> It seems to me that any code path on the network stack still needs to
> work *even if* traits K/V is not available. There has to be a fallback -
> like, RX hash not present in traits K/V? must recompute it. There is no
> guarantee that there will be space available in the traits K/V store for
> whatever value the network stack would like to cache there.

The stack is in control of both the memory allocation and the placement
of the kv-store, so it could totally guarantee that if needed. Which is
the whole point of making this kernel-internal, IMO.

> So if we can agree that traits K/V is a cache, with limited capacity,
> and any code path accessing it must be prepared to deal with a cache
> miss, then I think with struct_ops approach you could have a built-in
> default implementation for exclusive use by the network stack.

If we have such a default implementation (which would presumably be the
one in this series), why would anyone override it? The need for that
seems a bit speculative, so why not just start with the one
implementation, and add the override if a really compelling use case
does eventually turn up?

> This default implementation of the storage access just wouldn't be
> exposed to the BPF or user-space. If you want access from BPF/userland,
> then you'd need to provide a BPF-backed struct_ops for accessing traits
> K/V.
>
>> Having a hard dependency on BPF for in-kernel functionality is a
>> different matter, and limits the cases it can be used for.
>
> Notice that we already rely on XDP program being attached or the storage
> for traits K/V is not available.
>
>> Besides, I don't really see the point of leaving the encoding out of the
>> kernel? We keep the encoding kernel-internal anyway, and just expose a
>> get/set API, so there's no constraint on changing it later (that's kinda
>> the whole point of doing that). And with bulk get/set there's not an
>> efficiency argument either. So what's the point, other than doing things
>> in BPF for its own sake?
>
> There's the additional complexity in the socket glue layer, but I've
> already mentioned that.
>
> What I think makes it even more appealing is that with the high-level
> struct_ops approach, we abstract away the individual K/V pair access and
> leave the problem of "key registration" (e.g., RX hash is key 42) to the
> user-provided implementation.
>
> You, as the user, decide for your particular system how you want to lay
> out the values and for which values you actually want to reserve
> space. IOW, we leave any trade off decisions to the user in the spirit
> of providing a mechanism, not policy.

But we already have such a possibility, that's basically the metadata
space that XDP/TC already has access to. And the whole reason why this
patch set makes sense is that we need something where the kernel
provides something more structured (K/V) that facilitates sharing across
applications that don't have central coordination across the system.
Punting that (back) off to BPF just gets us back to square one...

-Toke


