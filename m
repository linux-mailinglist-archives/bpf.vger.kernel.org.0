Return-Path: <bpf+bounces-41063-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFD4991DD4
	for <lists+bpf@lfdr.de>; Sun,  6 Oct 2024 12:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 053A91C2192A
	for <lists+bpf@lfdr.de>; Sun,  6 Oct 2024 10:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A1617A5B2;
	Sun,  6 Oct 2024 10:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sp6PKHFa"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5584F1791F4
	for <bpf@vger.kernel.org>; Sun,  6 Oct 2024 10:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728210477; cv=none; b=euo01SRn781GilZjCTYKSTEfLDMWNR2EjHb1c17EnWSfvNvxsBEsa8TA5h0WVPh80qIeqyc+oEaoBITvo6BGJNAX8L5flYU5opLTvSGncUSZGTK6KkBzBAZVCz1p6PuXRfdhql3JfDe+n63reL/ZksIF8lOlLP8gy/uCweBMNFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728210477; c=relaxed/simple;
	bh=pdUf/hLC7Lo8dxr0wLdHiL49Uzb6SdVg73Dg4DheOPI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PUcZQXnLMxd8XpCVf3aEzqNsKJ8rNG3sVFgsPhIHulDuPWPyO550Ep+kOzFkMZ7B05dgcKPfbZBlFOGVqVbk60Odt7glovQd9HR5YTX0djK7Oi6yYu83jzZZHbdLuVTm4GL2RmujXOHfhI2vUSbNKS4hOcfHMKsBBh4pKIVqPbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sp6PKHFa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728210474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XVAZl5VnbHOVnvJqx8bbWhlDxEgk2cc1gRj8x2Sbqjg=;
	b=Sp6PKHFaOSE7+6Zue3KeNJEU0FHAC1b+owq87+MkchLJieQsJvLA3LEB3GXGXuIxLgNBLG
	2+n1yO0TAsANdcDWItroW/c3kmcmskeoW9P67i9OTghAltjS+ejZJMO0xpT8rCmrle4msu
	VT7LKaX9xWF2xxvnIkmsyZYTLdrBWvA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-cMvtNNcWP4izqGecmXYxWg-1; Sun, 06 Oct 2024 06:27:53 -0400
X-MC-Unique: cMvtNNcWP4izqGecmXYxWg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37ccd7c3080so1372938f8f.3
        for <bpf@vger.kernel.org>; Sun, 06 Oct 2024 03:27:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728210472; x=1728815272;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XVAZl5VnbHOVnvJqx8bbWhlDxEgk2cc1gRj8x2Sbqjg=;
        b=u712x0xbbM+9Kk/zdpS4LRjQ50AGFgHvvLgVSO0uZRUZgbhTOI7UzUR+zw2lCZ36wp
         hlMl+OmTnEsl9KGN212pRju1OmbIxJVY/XcP01nGQL9wnTx/x6R9c/Hxu58HEd8oznl/
         vWqibbHeljTbQ0W3cZRsSH7SLMtjpCOCwuZrHReOijxBCVhu722fMaZ/VZlILVrSS6fX
         FIrP42QhX/+E0g0Df1Ez6VPUv3KHrx3iClfNIdzl84Q06NaWr4++GpGAMzj2YNYugTwH
         9JrYUUFZeog04PNJszf0G6wmmI11M2iFwUF1fPNwRb5O2yHSO4Y01rEI7DFAcQQOc0i9
         696A==
X-Forwarded-Encrypted: i=1; AJvYcCVGbinRjrlJ8B6SccY9L+I6JygP81DkfP1j/dqEtzvVIXua7Vf9EqJLayGLKwH0tFl19z0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR8f42skPcOtni8d6WzX4xN6qSyeKy+kLr7KvXRGV2+cRJxJjx
	6SL9eOOiTUadEJp+Ll9lpNPCjLxP3h51aG7yMl7hYN4yaUY+HXd8rKZO4Y+vKJerkmnw1eA0/Vk
	j5zxm+zB8YULUi87ndz0wipYeks21RTSjy7KxKCdjwgybVnWqFg==
X-Received: by 2002:adf:a31a:0:b0:37c:cfa8:a6b3 with SMTP id ffacd0b85a97d-37d0e6bbcd0mr4507497f8f.3.1728210471824;
        Sun, 06 Oct 2024 03:27:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6qk3pGSWh3Zpopbs1lFqrQC8wz61+RnAEMorGwbSBnz1kbEzfNV6nRuULWqiuppvReXLLRw==
X-Received: by 2002:adf:a31a:0:b0:37c:cfa8:a6b3 with SMTP id ffacd0b85a97d-37d0e6bbcd0mr4507480f8f.3.1728210471294;
        Sun, 06 Oct 2024 03:27:51 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1691b5ddsm3399541f8f.47.2024.10.06.03.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 03:27:50 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 54C981580A31; Sun, 06 Oct 2024 12:27:48 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Stanislav Fomichev <stfomichev@gmail.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>
Cc: Daniel Xu <dxu@dxuuu.xyz>, Arthur Fabre <afabre@cloudflare.com>, Lorenzo
 Bianconi <lorenzo@kernel.org>, Lorenzo Bianconi
 <lorenzo.bianconi@redhat.com>, Jakub Sitnicki <jakub@cloudflare.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, kuba@kernel.org, john.fastabend@gmail.com,
 edumazet@google.com, pabeni@redhat.com, sdf@fomichev.me,
 tariqt@nvidia.com, saeedm@nvidia.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, intel-wired-lan@lists.osuosl.org,
 mst@redhat.com, jasowang@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, kernel-team <kernel-team@cloudflare.com>,
 Yan Zhai <yan@cloudflare.com>
Subject: Re: [RFC bpf-next 0/4] Add XDP rx hw hints support performing
 XDP_REDIRECT
In-Reply-To: <ZwArrsqrYx7IM5tq@mini-arch>
References: <D4KJ7DUXJQC5.2UFST9L3CUOH7@bobby> <ZvwNQqN4gez1Ksfn@lore-desk>
 <87zfnnq2hs.fsf@toke.dk> <Zv18pxsiTGTZSTyO@mini-arch>
 <87ttdunydz.fsf@toke.dk> <Zv3N5G8swr100EXm@mini-arch>
 <D4LYNKGLE7G0.3JAN5MX1ATPTB@bobby> <Zv794Ot-kOq1pguM@mini-arch>
 <2fy5vuewgwkh3o3mx5v4bkrzu6josqylraa4ocgzqib6a7ozt4@hwsuhcibtcb6>
 <038fffa3-1e29-4c6d-9e27-8181865dca46@kernel.org>
 <ZwArrsqrYx7IM5tq@mini-arch>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Sun, 06 Oct 2024 12:27:48 +0200
Message-ID: <87ldz1edaz.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Stanislav Fomichev <stfomichev@gmail.com> writes:

> On 10/04, Jesper Dangaard Brouer wrote:
>>=20
>>=20
>> On 04/10/2024 04.13, Daniel Xu wrote:
>> > On Thu, Oct 03, 2024 at 01:26:08PM GMT, Stanislav Fomichev wrote:
>> > > On 10/03, Arthur Fabre wrote:
>> > > > On Thu Oct 3, 2024 at 12:49 AM CEST, Stanislav Fomichev wrote:
>> > > > > On 10/02, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> > > > > > Stanislav Fomichev <stfomichev@gmail.com> writes:
>> > > > > >=20
>> > > > > > > On 10/01, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> > > > > > > > Lorenzo Bianconi <lorenzo@kernel.org> writes:
>> > > > > > > >=20
>> > > > > > > > > > On Mon Sep 30, 2024 at 1:49 PM CEST, Lorenzo Bianconi =
wrote:
>> > > > > > > > > > > > Lorenzo Bianconi <lorenzo@kernel.org> writes:
>> > > > > > > > > > > >=20
>> [...]
>> > > > > > > > > > > > >=20
>> > > > > > > > > > > > > I like this 'fast' KV approach but I guess we sh=
ould really evaluate its
>> > > > > > > > > > > > > impact on performances (especially for xdp) sinc=
e, based on the kfunc calls
>> > > > > > > > > > > > > order in the ebpf program, we can have one or mu=
ltiple memmove/memcpy for
>> > > > > > > > > > > > > each packet, right?
>> > > > > > > > > > > >=20
>> > > > > > > > > > > > Yes, with Arthur's scheme, performance will be ord=
ering dependent. Using
>>=20
>> I really like the *compact* Key-Value (KV) store idea from Arthur.
>>  - The question is it is fast enough?
>>=20
>> I've promised Arthur to XDP micro-benchmark this, if he codes this up to
>> be usable in the XDP code path.  Listening to the LPC recording I heard
>> that Alexei also saw potential and other use-case for this kind of
>> fast-and-compact KV approach.
>>=20
>> I have high hopes for the performance, as Arthur uses POPCNT instruction
>> which is *very* fast[1]. I checked[2] AMD Zen 3 and 4 have Ops/Latency=
=3D1
>> and Reciprocal throughput 0.25.
>>=20
>>  [1] https://www.agner.org/optimize/blog/read.php?i=3D853#848
>>  [2] https://www.agner.org/optimize/instruction_tables.pdf
>>=20
>> [...]
>> > > > There are two different use-cases for the metadata:
>> > > >=20
>> > > > * "Hardware" metadata (like the hash, rx_timestamp...). There are =
only a
>> > > >    few well known fields, and only XDP can access them to set them=
 as
>> > > >    metadata, so storing them in a struct somewhere could make sens=
e.
>> > > >=20
>> > > > * Arbitrary metadata used by services. Eg a TC filter could set a =
field
>> > > >    describing which service a packet is for, and that could be reu=
sed for
>> > > >    iptables, routing, socket dispatch...
>> > > >    Similarly we could set a "packet_id" field that uniquely identi=
fies a
>> > > >    packet so we can trace it throughout the network stack (through
>> > > >    clones, encap, decap, userspace services...).
>> > > >    The skb->mark, but with more room, and better support for shari=
ng it.
>> > > >=20
>> > > > We can only know the layout ahead of time for the first one. And t=
hey're
>> > > > similar enough in their requirements (need to be stored somewhere =
in the
>> > > > SKB, have a way of retrieving each one individually, that it seems=
 to
>> > > > make sense to use a common API).
>> > >=20
>> > > Why not have the following layout then?
>> > >=20
>> > > +---------------+-------------------+-------------------------------=
---------+------+
>> > > | more headroom | user-defined meta | hw-meta (potentially fixed skb=
 format) | data |
>> > > +---------------+-------------------+-------------------------------=
---------+------+
>> > >                  ^                                                  =
          ^
>> > >              data_meta                                              =
        data
>> > >=20
>> > > You obviously still have a problem of communicating the layout if you
>> > > have some redirects in between, but you, in theory still have this
>> > > problem with user-defined metadata anyway (unless I'm missing
>> > > something).
>> > >=20
>>=20
>> Hmm, I think you are missing something... As far as I'm concerned we are
>> discussing placing the KV data after the xdp_frame, and not in the XDP
>> data_meta area (as your drawing suggests).  The xdp_frame is stored at
>> the very top of the headroom.  Lorenzo's patchset is extending struct
>> xdp_frame and now we are discussing to we can make a more flexible API
>> for extending this. I understand that Toke confirmed this here [3].  Let
>> me know if I missed something :-)
>>=20
>>  [3] https://lore.kernel.org/all/874j62u1lb.fsf@toke.dk/
>>
>> As part of designing this flexible API, we/Toke are trying hard not to
>> tie this to a specific data area.  This is a good API design, keeping it
>> flexible enough that we can move things around should the need arise.
>>=20
>> I don't think it is viable to store this KV data in XDP data_meta area,
>> because existing BPF-prog's already have direct memory (write) access
>> and can change size of area, which creates too much headache with
>> (existing) BPF-progs creating unintentional breakage for the KV store,
>> which would then need extensive checks to handle random corruptions
>> (slowing down KV-store code).
>
> Yes, I'm definitely missing the bigger picture. If we want to have a glob=
al
> metadata registry in the kernel, why can't it be built on top of the exis=
ting
> area?

Because we have no way of preventing existing XDP programs from
overwriting (corrupting) the area using the xdp_adjust_meta() API and
data_meta field.

But in a sense the *memory area* is shared between the two APIs, in the
sense that they both use the headroom before the packet data, just from
opposite ends. So if you store lots of data using the new KV API, that
space will no longer be available for xdp_adjust_{head,meta}. But the
kernel can enforce this so we don't get programs corrupting the KV
format.

-Toke


