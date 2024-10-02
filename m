Return-Path: <bpf+bounces-40785-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 843AB98E2B3
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 20:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7F6E1C21AB2
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 18:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6138215F56;
	Wed,  2 Oct 2024 18:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f0FlpsBu"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBF6212F0B
	for <bpf@vger.kernel.org>; Wed,  2 Oct 2024 18:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727894322; cv=none; b=XzXeGLCwO2CpBIs2/oCZQ7OxvI+1R6ZigdbPXbhUg2tkwMaWka0VHr3zZ7/KWkf5y5c1QdyuSQYAIqP6lb2NNG1AxrkLQHea4vB/3XxoEKlZ56dAXgnVYuddpu4Icrs+gBmEdzOHG6iEZ36t7jliwwjrOagzdZQNQhcsJOAW6do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727894322; c=relaxed/simple;
	bh=+JAxNkUMd9nppVNduwvBvddzJPZ/icaY6/SIwBoeAgg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y0Nifk/V/25mSo9cp8X03AOi6AFGsIBlDqTcfg0j9pSIlWFMTV/XqAFWToga4BL6GdPtz8IQqGpZnmnUnNjkl+DkcwyQt7nmMsOT3gGElZRN9zG9/5z4nKJ6wolimaTmKCC9rjJ2/c+iBgeN6LG1eLUb7r06Rn7j+JOotVmyuNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f0FlpsBu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727894319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TUYma/EPs1KdBK7LpDH//IRvRSF2+DVGnweHF00rvLg=;
	b=f0FlpsBuRa3TdsiXTzdkLT1sNRBj+R7n3RmiL/wEeYtuNssppeOnPrXOsYwovfFDtU9vtr
	foiizrAWK+uwfpDEZ6rk/CHf4ISNbIXPX2LIKaZJORZWMMr4HvEDql0Yd6+mAJAIxcAJtn
	rrhOd8Kf1lZi004i3sv8ArBZ8jYy+Pw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-yKfCzPZ8Nw2g9lpyh7U8tg-1; Wed, 02 Oct 2024 14:38:35 -0400
X-MC-Unique: yKfCzPZ8Nw2g9lpyh7U8tg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a93d0b27d37so3724366b.0
        for <bpf@vger.kernel.org>; Wed, 02 Oct 2024 11:38:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727894315; x=1728499115;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TUYma/EPs1KdBK7LpDH//IRvRSF2+DVGnweHF00rvLg=;
        b=YeAH6nfFZzH9dKJCfSIeHPZ638N1QJ/0dB4SD7X6Ivo8lx51inYduxcDERTlantyql
         UzGcmab59jIzVvkJEwEXjqa2ggtSAW3ZNVrfNvGNtf6HbOqcbfTbwe2/w2BfQpKb09zB
         jAVkBBg1MYPk7q/wsSAwImpXf+UHnBoffrwka4H5evZdlOeXVDhv1tmrU/o0MlTotL2i
         w8KII+ZWsyd3DuBd/Fd3/qTW7JmzN4CqdAhl+8NGWNJVQQx3AjnD5PKaZ7zJYuVMu2j/
         RSMuhuFgioHWuPnSwnqcyXiPpHzNCdtdFhKDxLzb1aHBdLt3tr0TvbUjcISCzaK/Eqm3
         1d0Q==
X-Forwarded-Encrypted: i=1; AJvYcCULQwMcDKhqeQLhdczFjwDnn1F7Ns2egg7mMdqqiOXJEevlgsC+kN34YAwFYVkCDm5geo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHilQ0jVbpJN0iWr2t4/K2tm/hBLWyHE0oURXOvrtGdyJxX6ex
	A2FGjKWHks+VKb8eNeLRrVZC9rsViTt+lTZMiRuk8wXSxucdeeED9ZSm2XHmYs+QNlvMBnDWTnk
	zbXfjTQyxE54p/nWu2lOYSJo6oYBC6Cwrxs6nqaXh/IHR5KJ9qw==
X-Received: by 2002:a17:907:9348:b0:a86:6fb3:fda5 with SMTP id a640c23a62f3a-a98f8270820mr371290666b.32.1727894314686;
        Wed, 02 Oct 2024 11:38:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExdrouJzpTfhyO+07C7yEl3jbSIHHoX9mHnVfOzQyx5ho+dLqj02EqamCslBCs+aZY/ib4TA==
X-Received: by 2002:a17:907:9348:b0:a86:6fb3:fda5 with SMTP id a640c23a62f3a-a98f8270820mr371288666b.32.1727894314291;
        Wed, 02 Oct 2024 11:38:34 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2998cb2sm897131766b.197.2024.10.02.11.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 11:38:33 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id B692315802F2; Wed, 02 Oct 2024 20:38:32 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Arthur Fabre
 <afabre@cloudflare.com>, Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Jakub Sitnicki
 <jakub@cloudflare.com>, Alexander Lobakin <aleksander.lobakin@intel.com>,
 bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org,
 john.fastabend@gmail.com, edumazet@google.com, pabeni@redhat.com,
 sdf@fomichev.me, tariqt@nvidia.com, saeedm@nvidia.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, mst@redhat.com, jasowang@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, kernel-team
 <kernel-team@cloudflare.com>, Yan Zhai <yan@cloudflare.com>
Subject: Re: [RFC bpf-next 0/4] Add XDP rx hw hints support performing
 XDP_REDIRECT
In-Reply-To: <Zv18pxsiTGTZSTyO@mini-arch>
References: <87wmiysi37.fsf@toke.dk> <D4GBY7CHJNJ6.3O18I5W1FTPKR@bobby>
 <87ldzds8bp.fsf@toke.dk> <D4H5CAN4O95E.3KF8LAH75FYD4@bobby>
 <ZvbKDT-2xqx2unrx@lore-rh-laptop> <871q11s91e.fsf@toke.dk>
 <ZvqQOpqnK9hBmXNn@lore-desk> <D4KJ7DUXJQC5.2UFST9L3CUOH7@bobby>
 <ZvwNQqN4gez1Ksfn@lore-desk> <87zfnnq2hs.fsf@toke.dk>
 <Zv18pxsiTGTZSTyO@mini-arch>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 02 Oct 2024 20:38:32 +0200
Message-ID: <87ttdunydz.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Stanislav Fomichev <stfomichev@gmail.com> writes:

> On 10/01, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>>=20
>> >> On Mon Sep 30, 2024 at 1:49 PM CEST, Lorenzo Bianconi wrote:
>> >> > > Lorenzo Bianconi <lorenzo@kernel.org> writes:
>> >> > >=20
>> >> > > >> > We could combine such a registration API with your header fo=
rmat, so
>> >> > > >> > that the registration just becomes a way of allocating one o=
f the keys
>> >> > > >> > from 0-63 (and the registry just becomes a global copy of th=
e header).
>> >> > > >> > This would basically amount to moving the "service config fi=
le" into the
>> >> > > >> > kernel, since that seems to be the only common denominator w=
e can rely
>> >> > > >> > on between BPF applications (as all attempts to write a comm=
on daemon
>> >> > > >> > for BPF management have shown).
>> >> > > >>=20
>> >> > > >> That sounds reasonable. And I guess we'd have set() check the =
global
>> >> > > >> registry to enforce that the key has been registered beforehan=
d?
>> >> > > >>=20
>> >> > > >> >
>> >> > > >> > -Toke
>> >> > > >>=20
>> >> > > >> Thanks for all the feedback!
>> >> > > >
>> >> > > > I like this 'fast' KV approach but I guess we should really eva=
luate its
>> >> > > > impact on performances (especially for xdp) since, based on the=
 kfunc calls
>> >> > > > order in the ebpf program, we can have one or multiple memmove/=
memcpy for
>> >> > > > each packet, right?
>> >> > >=20
>> >> > > Yes, with Arthur's scheme, performance will be ordering dependent=
. Using
>> >> > > a global registry for offsets would sidestep this, but have the
>> >> > > synchronisation issues we discussed up-thread. So on balance, I t=
hink
>> >> > > the memmove() suggestion will probably lead to the least pain.
>> >> > >=20
>> >> > > For the HW metadata we could sidestep this by always having a fix=
ed
>> >> > > struct for it (but using the same set/get() API with reserved key=
s). The
>> >> > > only drawback of doing that is that we statically reserve a bit of
>> >> > > space, but I'm not sure that is such a big issue in practice (at =
least
>> >> > > not until this becomes to popular that the space starts to be con=
tended;
>> >> > > but surely 256 bytes ought to be enough for everybody, right? :)).
>> >> >
>> >> > I am fine with the proposed approach, but I think we need to verify=
 what is the
>> >> > impact on performances (in the worst case??)
>> >>=20
>> >> If drivers are responsible for populating the hardware metadata before
>> >> XDP, we could make sure drivers set the fields in order to avoid any
>> >> memove() (and maybe even provide a helper to ensure this?).
>> >
>> > nope, since the current APIs introduced by Stanislav are consuming NIC
>> > metadata in kfuncs (mainly for af_xdp) and, according to my understand=
ing,
>> > we want to add a kfunc to store the info for each NIC metadata (e.g rx=
-hash,
>> > timestamping, ..) into the packet (this is what Toke is proposing, rig=
ht?).
>> > In this case kfunc calling order makes a difference.
>> > We can think even to add single kfunc to store all the info for all th=
e NIC
>> > metadata (maybe via a helping struct) but it seems not scalable to me =
and we
>> > are losing kfunc versatility.
>>=20
>> Yes, I agree we should have separate kfuncs for each metadata field.
>> Which means it makes a lot of sense to just use the same setter API that
>> we use for the user-registered metadata fields, but using reserved keys.
>> So something like:
>>=20
>> #define BPF_METADATA_HW_HASH      BIT(60)
>> #define BPF_METADATA_HW_TIMESTAMP BIT(61)
>> #define BPF_METADATA_HW_VLAN      BIT(62)
>> #define BPF_METADATA_RESERVED (0xffff << 48)
>>=20
>> bpf_packet_metadata_set(pkt, BPF_METADATA_HW_HASH, hash_value);
>>=20
>>=20
>> As for the internal representation, we can just have the kfunc do
>> something like:
>>=20
>> int bpf_packet_metadata_set(field_id, value) {
>>   switch(field_id) {
>>     case BPF_METADATA_HW_HASH:
>>       pkt->xdp_hw_meta.hash =3D value;
>>       break;
>>     [...]
>>     default:
>>       /* do the key packing thing */
>>   }
>> }
>>=20
>>=20
>> that way the order of setting the HW fields doesn't matter, only the
>> user-defined metadata.
>
> Can you expand on why we need the flexibility of picking the metadata fie=
lds
> here? Presumably we are talking about the use-cases where the XDP program
> is doing redirect/pass and it doesn't really know who's the final
> consumer is (might be another xdp program or might be the xdp->skb
> kernel case), so the only sensible option here seems to be store everythi=
ng?

For the same reason that we have separate kfuncs for each metadata field
when getting it from the driver: XDP programs should have the
flexibility to decide which pieces of metadata they need, and skip the
overhead of stuff that is not needed.

For instance, say an XDP program knows that nothing in the system uses
timestamps; in that case, it can skip both the getter and the setter
call for timestamps.

I suppose we *could* support just a single call to set the skb meta,
like:

bpf_set_skb_meta(struct xdp_md *pkt, struct xdp_hw_meta *data);

...but in that case, we'd need to support some fields being unset
anyway, and the program would have to populate the struct on the stack
before performing the call. So it seems simpler to just have symmetry
between the get (from HW) and set side? :)

-Toke


