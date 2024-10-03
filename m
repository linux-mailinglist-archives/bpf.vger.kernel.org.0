Return-Path: <bpf+bounces-40815-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6443698E9BE
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 08:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D100C28184E
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 06:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD107A724;
	Thu,  3 Oct 2024 06:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="gAwS4c57"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1F1208A9
	for <bpf@vger.kernel.org>; Thu,  3 Oct 2024 06:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727937314; cv=none; b=G5wH1vz8Yt/TXnh783ZBQyBOSrffFKHiuNtQ5wyeyZpY0dQ/NIeuZC+4N8XGZRtywQjMETC3elxSYep1kwI23InTJzKKhgoPQ57lw0R4ktdhvj+9Fylz6TVEPGQsR/IMaj3THWEQQrZPcRrAim5jlpDMlyAdWl51rnxdtRCll8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727937314; c=relaxed/simple;
	bh=ZgKMQgrTlpqAaciWFAAkm9D5J1TD8UxILiaJDvpjets=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=S4FJydp25OrAHvVOb1hryhBkEQboQto7OgUT0fRnRx+sc9xAJmosAjXtMdFusc5fYWdOoBVfOweaAzTtiStwNrdoR/vDyvpWOyXxFUFeEEvWp2FMvfKWzBdrAqlfvemCYRyBqe/kVIqIgyuzqNzWrqPATCQ2vnbqcL8SufNcrK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=gAwS4c57; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cbc38a997so3258705e9.1
        for <bpf@vger.kernel.org>; Wed, 02 Oct 2024 23:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1727937310; x=1728542110; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N4rfjZLoUiX7LpaLbuzZxhQKAqk1hkqOVodJ4+flRDM=;
        b=gAwS4c57HMtOclcFf3Eu8prN7UrG7IJsSUeImqqjB1MHnVNwEq0egSSzZXDpxbEYoZ
         E9M+1yZaiTZKxNF+rqD0M+K7Qr7bqc03wUC93O9RxBtnpRo2AeQijPRDK16tPlJMW280
         rj/k5p0USoF/ZMPggFhIr/+CoTs6xPtdF4930lQEF+cBCI7uCmff+/n2JbMU4kKXuDCf
         wvZr8cnqrHAW7pjHoAdLcqDAxz488CNbGwZHnebrFOzB6/sNdr7vXm6TVLJyBCT7GEl3
         Wjx9IvWmUcv5w3jUZlm79VWfXslCOGlm9PoBeiDx3JgbwzUruXBOZkeFyNOh6zR/CTJV
         Eotg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727937310; x=1728542110;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N4rfjZLoUiX7LpaLbuzZxhQKAqk1hkqOVodJ4+flRDM=;
        b=aECrghYY4q3W2xC10vwBOcFlBStI1Unhcxi7AtNrQ3bJKy+q7mTtgk5uGUS9qqZNxI
         71Sh0vw2VsD9JHW3e8byP4qjyWsXxzkl4PRwANoem5AzACCkg7XyGNtEqxrlAEzgscpb
         N1XXpBR93kOMuamweOEcia7PlwApoNupDeF6elhIkHcM8UggcQMFUBbx7L52Qqe9uWDe
         enzOtpMHtjtUPwSZO9z7h+Zaesb+jVbaIyeqO6Hm/rkBA6Tb7MduIqoiS/jtyyS+Mv3M
         Lsrsgl7AGjBX41bYAoNaoyx1gEBTQsYSGQEcocm8L2YBScmQhvWayxPsKcd55wKbjiRU
         MDiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxIX1xp0ra6fzs54UE309lFsyUeZyxnJ0NhRxKtgHGreZBsUkKe+LqxIQPdAwxEBimG58=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlAbVgaiavpZeQcJvEdi77h3q8wxi2ASrj1ay6IchDdVI+xWhr
	/GqsNIXYK/MHcUF6BT4Ec0Sra0G0U/Z2cucL2tlXNBBTIoFsz/siBwd4wDjK3Cs=
X-Google-Smtp-Source: AGHT+IFppr1P2N6tb8E4QOgYU6oJ/Xj7hkZoH3KFMunREaX7pS4Cha4UmFYK1ubPULDrtl6JNcY6+g==
X-Received: by 2002:a05:600c:3b1d:b0:42c:b81b:c49c with SMTP id 5b1f17b1804b1-42f7df49b84mr11349435e9.10.1727937310514;
        Wed, 02 Oct 2024 23:35:10 -0700 (PDT)
Received: from localhost ([2a09:bac1:27c0:58::31:92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d082d2295sm523423f8f.107.2024.10.02.23.35.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 23:35:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 03 Oct 2024 08:35:07 +0200
Message-Id: <D4LYNKGLE7G0.3JAN5MX1ATPTB@bobby>
Cc: "Lorenzo Bianconi" <lorenzo@kernel.org>, "Lorenzo Bianconi"
 <lorenzo.bianconi@redhat.com>, "Jesper Dangaard Brouer" <hawk@kernel.org>,
 "Jakub Sitnicki" <jakub@cloudflare.com>, "Alexander Lobakin"
 <aleksander.lobakin@intel.com>, <bpf@vger.kernel.org>,
 <netdev@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <davem@davemloft.net>, <kuba@kernel.org>, <john.fastabend@gmail.com>,
 <edumazet@google.com>, <pabeni@redhat.com>, <sdf@fomichev.me>,
 <tariqt@nvidia.com>, <saeedm@nvidia.com>, <anthony.l.nguyen@intel.com>,
 <przemyslaw.kitszel@intel.com>, <intel-wired-lan@lists.osuosl.org>,
 <mst@redhat.com>, <jasowang@redhat.com>, <mcoquelin.stm32@gmail.com>,
 <alexandre.torgue@foss.st.com>, "kernel-team" <kernel-team@cloudflare.com>,
 "Yan Zhai" <yan@cloudflare.com>
Subject: Re: [RFC bpf-next 0/4] Add XDP rx hw hints support performing
 XDP_REDIRECT
From: "Arthur Fabre" <afabre@cloudflare.com>
To: "Stanislav Fomichev" <stfomichev@gmail.com>,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
X-Mailer: aerc 0.8.2
References: <87ldzds8bp.fsf@toke.dk> <D4H5CAN4O95E.3KF8LAH75FYD4@bobby>
 <ZvbKDT-2xqx2unrx@lore-rh-laptop> <871q11s91e.fsf@toke.dk>
 <ZvqQOpqnK9hBmXNn@lore-desk> <D4KJ7DUXJQC5.2UFST9L3CUOH7@bobby>
 <ZvwNQqN4gez1Ksfn@lore-desk> <87zfnnq2hs.fsf@toke.dk>
 <Zv18pxsiTGTZSTyO@mini-arch> <87ttdunydz.fsf@toke.dk>
 <Zv3N5G8swr100EXm@mini-arch>
In-Reply-To: <Zv3N5G8swr100EXm@mini-arch>

On Thu Oct 3, 2024 at 12:49 AM CEST, Stanislav Fomichev wrote:
> On 10/02, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> > Stanislav Fomichev <stfomichev@gmail.com> writes:
> >=20
> > > On 10/01, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> > >> Lorenzo Bianconi <lorenzo@kernel.org> writes:
> > >>=20
> > >> >> On Mon Sep 30, 2024 at 1:49 PM CEST, Lorenzo Bianconi wrote:
> > >> >> > > Lorenzo Bianconi <lorenzo@kernel.org> writes:
> > >> >> > >=20
> > >> >> > > >> > We could combine such a registration API with your heade=
r format, so
> > >> >> > > >> > that the registration just becomes a way of allocating o=
ne of the keys
> > >> >> > > >> > from 0-63 (and the registry just becomes a global copy o=
f the header).
> > >> >> > > >> > This would basically amount to moving the "service confi=
g file" into the
> > >> >> > > >> > kernel, since that seems to be the only common denominat=
or we can rely
> > >> >> > > >> > on between BPF applications (as all attempts to write a =
common daemon
> > >> >> > > >> > for BPF management have shown).
> > >> >> > > >>=20
> > >> >> > > >> That sounds reasonable. And I guess we'd have set() check =
the global
> > >> >> > > >> registry to enforce that the key has been registered befor=
ehand?
> > >> >> > > >>=20
> > >> >> > > >> >
> > >> >> > > >> > -Toke
> > >> >> > > >>=20
> > >> >> > > >> Thanks for all the feedback!
> > >> >> > > >
> > >> >> > > > I like this 'fast' KV approach but I guess we should really=
 evaluate its
> > >> >> > > > impact on performances (especially for xdp) since, based on=
 the kfunc calls
> > >> >> > > > order in the ebpf program, we can have one or multiple memm=
ove/memcpy for
> > >> >> > > > each packet, right?
> > >> >> > >=20
> > >> >> > > Yes, with Arthur's scheme, performance will be ordering depen=
dent. Using
> > >> >> > > a global registry for offsets would sidestep this, but have t=
he
> > >> >> > > synchronisation issues we discussed up-thread. So on balance,=
 I think
> > >> >> > > the memmove() suggestion will probably lead to the least pain=
.
> > >> >> > >=20
> > >> >> > > For the HW metadata we could sidestep this by always having a=
 fixed
> > >> >> > > struct for it (but using the same set/get() API with reserved=
 keys). The
> > >> >> > > only drawback of doing that is that we statically reserve a b=
it of
> > >> >> > > space, but I'm not sure that is such a big issue in practice =
(at least
> > >> >> > > not until this becomes to popular that the space starts to be=
 contended;
> > >> >> > > but surely 256 bytes ought to be enough for everybody, right?=
 :)).
> > >> >> >
> > >> >> > I am fine with the proposed approach, but I think we need to ve=
rify what is the
> > >> >> > impact on performances (in the worst case??)
> > >> >>=20
> > >> >> If drivers are responsible for populating the hardware metadata b=
efore
> > >> >> XDP, we could make sure drivers set the fields in order to avoid =
any
> > >> >> memove() (and maybe even provide a helper to ensure this?).
> > >> >
> > >> > nope, since the current APIs introduced by Stanislav are consuming=
 NIC
> > >> > metadata in kfuncs (mainly for af_xdp) and, according to my unders=
tanding,
> > >> > we want to add a kfunc to store the info for each NIC metadata (e.=
g rx-hash,
> > >> > timestamping, ..) into the packet (this is what Toke is proposing,=
 right?).
> > >> > In this case kfunc calling order makes a difference.
> > >> > We can think even to add single kfunc to store all the info for al=
l the NIC
> > >> > metadata (maybe via a helping struct) but it seems not scalable to=
 me and we
> > >> > are losing kfunc versatility.
> > >>=20
> > >> Yes, I agree we should have separate kfuncs for each metadata field.
> > >> Which means it makes a lot of sense to just use the same setter API =
that
> > >> we use for the user-registered metadata fields, but using reserved k=
eys.
> > >> So something like:
> > >>=20
> > >> #define BPF_METADATA_HW_HASH      BIT(60)
> > >> #define BPF_METADATA_HW_TIMESTAMP BIT(61)
> > >> #define BPF_METADATA_HW_VLAN      BIT(62)
> > >> #define BPF_METADATA_RESERVED (0xffff << 48)
> > >>=20
> > >> bpf_packet_metadata_set(pkt, BPF_METADATA_HW_HASH, hash_value);
> > >>=20
> > >>=20
> > >> As for the internal representation, we can just have the kfunc do
> > >> something like:
> > >>=20
> > >> int bpf_packet_metadata_set(field_id, value) {
> > >>   switch(field_id) {
> > >>     case BPF_METADATA_HW_HASH:
> > >>       pkt->xdp_hw_meta.hash =3D value;
> > >>       break;
> > >>     [...]
> > >>     default:
> > >>       /* do the key packing thing */
> > >>   }
> > >> }
> > >>=20
> > >>=20
> > >> that way the order of setting the HW fields doesn't matter, only the
> > >> user-defined metadata.
> > >
> > > Can you expand on why we need the flexibility of picking the metadata=
 fields
> > > here? Presumably we are talking about the use-cases where the XDP pro=
gram
> > > is doing redirect/pass and it doesn't really know who's the final
> > > consumer is (might be another xdp program or might be the xdp->skb
> > > kernel case), so the only sensible option here seems to be store ever=
ything?
> >=20
> > For the same reason that we have separate kfuncs for each metadata fiel=
d
> > when getting it from the driver: XDP programs should have the
> > flexibility to decide which pieces of metadata they need, and skip the
> > overhead of stuff that is not needed.
> >=20
> > For instance, say an XDP program knows that nothing in the system uses
> > timestamps; in that case, it can skip both the getter and the setter
> > call for timestamps.
>
> But doesn't it put us in the same place? Where the first (native) xdp pro=
gram
> needs to know which metadata the final consumer wants. At this point
> why not propagate metadata layout as well?
>
> (or maybe I'm still missing what exact use-case we are trying to solve)

There are two different use-cases for the metadata:

* "Hardware" metadata (like the hash, rx_timestamp...). There are only a
  few well known fields, and only XDP can access them to set them as
  metadata, so storing them in a struct somewhere could make sense.

* Arbitrary metadata used by services. Eg a TC filter could set a field
  describing which service a packet is for, and that could be reused for
  iptables, routing, socket dispatch...
  Similarly we could set a "packet_id" field that uniquely identifies a
  packet so we can trace it throughout the network stack (through
  clones, encap, decap, userspace services...).
  The skb->mark, but with more room, and better support for sharing it.

We can only know the layout ahead of time for the first one. And they're
similar enough in their requirements (need to be stored somewhere in the
SKB, have a way of retrieving each one individually, that it seems to
make sense to use a common API).

>
> > I suppose we *could* support just a single call to set the skb meta,
> > like:
> >=20
> > bpf_set_skb_meta(struct xdp_md *pkt, struct xdp_hw_meta *data);
> >=20
> > ...but in that case, we'd need to support some fields being unset
> > anyway, and the program would have to populate the struct on the stack
> > before performing the call. So it seems simpler to just have symmetry
> > between the get (from HW) and set side? :)
>
> Why not simply bpf_set_skb_meta(struct xdp_md *pkt) and let it store
> the metadata somewhere in xdp_md directly? (also presumably by
> reusing most of the existing kfuncs/xmo_xxx helpers)

If we store it in xdp_md, the metadata won't be available higher up the
stack (or am I missing something?). I think one of the goals is to let
things other than XDP access it (maybe even the network stack itself?).

