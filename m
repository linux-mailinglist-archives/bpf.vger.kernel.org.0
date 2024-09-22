Return-Path: <bpf+bounces-40172-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AC197E0B1
	for <lists+bpf@lfdr.de>; Sun, 22 Sep 2024 11:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 898EF1F2136C
	for <lists+bpf@lfdr.de>; Sun, 22 Sep 2024 09:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7DC13C683;
	Sun, 22 Sep 2024 09:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JuBmOyLA"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4313B7AC
	for <bpf@vger.kernel.org>; Sun, 22 Sep 2024 09:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726996688; cv=none; b=CQRNq9x7onj3OeAo0FAxGluKqEej3h5T0MPpagCBx+++uXvmmnsXtyPW9EhEQ73nlzcE4zvFNspfwtOlmNDsWtUm8N4O/PcZY34s+XyeGFHNuqRxzo29ztLd5LtjhWm49DJ2FeZiD35BGCOah4DChBuDHjlJtgrETvgBvphVk0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726996688; c=relaxed/simple;
	bh=CkVf/BUTbleDBi4ErBkX5kkH/UNmslDmWgD0qCX81Lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b1OTYtx/iFXoUsI40ItxXgThAVECxrNtamu3HY+ZuwfVC4Sc/2CLC+duR6ssWxDAxXWoW/Fm7duQOtPIHFXdS9lYuGsse1uaL/Y7JvnSi26FQwRN2JAaEaUCqbKpbaYfx8lkRhhK0RW/uT6nejbSwOMr0+YlDISoniakm2wd3F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JuBmOyLA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726996686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NXAx1lyb+OHUcXTVhf/rtzN8Qm/38mHOyytwY0XpYps=;
	b=JuBmOyLA9ZGi7VB/tFe6hmcSoZOAVSYuSIQjJLgEjYE9bigyhHOMJs/Bb+F8R4vRf4VJV9
	L3WbtvAo36gaVUbv5W81T8S/wTtMkT0UXB5QdKYDjJVyCfhFmLcrYEBhLWIOosQGyHqIIO
	pvd8r1vhaY9dwkSpoiPtRtxru1gWoF4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-iKuV1c9WOPa4KMayun-gMg-1; Sun, 22 Sep 2024 05:18:04 -0400
X-MC-Unique: iKuV1c9WOPa4KMayun-gMg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a8a8931ef97so108273566b.3
        for <bpf@vger.kernel.org>; Sun, 22 Sep 2024 02:18:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726996683; x=1727601483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NXAx1lyb+OHUcXTVhf/rtzN8Qm/38mHOyytwY0XpYps=;
        b=P56SC5F5nGPrziewHqY5uYPaYvjxP+/q+Dvs2GoZ2EkJKEtQ3uVOIhOQFyxrzmSRNZ
         6tELZvdXfmsJrJqA7GN5Mew65lCuXeDr1I4D6sWfyhx4RdtwxmHwHCHofK0NNTjSDF1S
         7QiVeFCoGOwNdconq1MCJQh5wuxK8K+sOzJ335/JBQmXjuLs9YCJeBO4AKPyaKjj8dfF
         wvrWOheDyj44M53mbUQw3iJ2R5t2IidMNdTBBvfvcKwRGYezXcEthSUHN846SMmSMFS8
         IrfTcRFYCiEHiEldAt1rWjHxfj8OrbHOP0w61iNEI1OlLGwXCNzBucPtlzVwQNjs1ejj
         Cn4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXTLFNkjPPu9jpm3xFn8VBfysXZd1Jvj/octswsKjUHl84/LnkzsUaKoOM4waUx1lCJkII=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoDcSCBzMSGH9i4V8uU7741U7VhQbIY4pVgOhxwf7NwGssD//v
	hSdqKhcWusvF5xbNLRIHII1irGZKlJTUdp2No1RZw7WUaxMCGCfZkPpI8hM8FOxiMInQ2agi1Qz
	eZyixQ6LJvpjYHNnxevK2eOn3CYHcpa75dAM4jNmPxkQCGrmcAB+H46qfO2jC
X-Received: by 2002:a05:6402:1e93:b0:5c5:bb26:5029 with SMTP id 4fb4d7f45d1cf-5c5bb265071mr4715738a12.9.1726996683127;
        Sun, 22 Sep 2024 02:18:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEf9TMYT2IhPElc8dV5tR8Nn2xYHdfg3DTnHOp+UvWeEV68rpjCdJBZeyRvvMen4+MhNa6mbg==
X-Received: by 2002:a50:8dc5:0:b0:5c4:64e6:55a4 with SMTP id 4fb4d7f45d1cf-5c464e659b7mr8744624a12.12.1726996671718;
        Sun, 22 Sep 2024 02:17:51 -0700 (PDT)
Received: from localhost (net-93-146-37-148.cust.vodafonedsl.it. [93.146.37.148])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9061328bb0sm1060048066b.193.2024.09.22.02.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 02:17:51 -0700 (PDT)
Date: Sun, 22 Sep 2024 11:17:50 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@kernel.org>,
	bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org,
	john.fastabend@gmail.com, edumazet@google.com, pabeni@redhat.com,
	toke@toke.dk, sdf@fomichev.me, tariqt@nvidia.com, saeedm@nvidia.com,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	intel-wired-lan@lists.osuosl.org, mst@redhat.com,
	jasowang@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	kernel-team <kernel-team@cloudflare.com>,
	Yan Zhai <yan@cloudflare.com>
Subject: Re: [RFC bpf-next 0/4] Add XDP rx hw hints support performing
 XDP_REDIRECT
Message-ID: <Zu_gvkXe4RYjJXtq@lore-desk>
References: <cover.1726935917.git.lorenzo@kernel.org>
 <1f53cd74-6c1e-4a1c-838b-4acc8c5e22c1@intel.com>
 <09657be6-b5e2-4b5a-96b6-d34174aadd0a@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="inD87LbY/R9ETazn"
Content-Disposition: inline
In-Reply-To: <09657be6-b5e2-4b5a-96b6-d34174aadd0a@kernel.org>


--inD87LbY/R9ETazn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>=20
>=20
> On 21/09/2024 22.17, Alexander Lobakin wrote:
> > From: Lorenzo Bianconi <lorenzo@kernel.org>
> > Date: Sat, 21 Sep 2024 18:52:56 +0200
> >=20
> > > This series introduces the xdp_rx_meta struct in the xdp_buff/xdp_fra=
me
> >=20
> > &xdp_buff is on the stack.
> > &xdp_frame consumes headroom.
> >=20
> > IOW they're size-sensitive and putting metadata directly there might
> > play bad; if not now, then later.
> >=20
> > Our idea (me + Toke) was as follows:
> >=20
> > - new BPF kfunc to build generic meta. If called, the driver builds a
> >    generic meta with hash, csum etc., in the data_meta area.
>=20
> I do agree that it should be the XDP prog (via a new BPF kfunc) that
> decide if xdp_frame should be updated to contain a generic meta struct.
> *BUT* I think we should use the xdp_frame area, and not the
> xdp->data_meta area.

ack, I will add a new kfunc for it.

>=20
> A details is that I think this kfunc should write data directly into
> xdp_frame area, even then we are only operating on the xdp_buff, as we
> do have access to the area xdp_frame will be created in.

this would avoid to copy it when we convert from xdp_buff to xdp_frame, nic=
e :)

>=20
>=20
> When using data_meta area, then netstack encap/decap needs to move the
> data_meta area (extra cycles).  The xdp_frame area (live in top) don't
> have this issue.
>=20
> It is easier to allow xdp_frame area to survive longer together with the
> SKB. Today we "release" this xdp_frame area to be used by SKB for extra
> headroom (see xdp_scrub_frame).  I can imagine that we can move SKB
> fields to this area, and reduce the size of the SKB alloc. (This then
> becomes the mini-SKB we discussed a couple of years ago).
>=20
>=20
> >    Yes, this also consumes headroom, but only when the corresponding fu=
nc
> >    is called. Introducing new fields like you're doing will consume it
> >    unconditionally;
>=20
> We agree on the kfunc call marks area as consumed/in-use.  We can extend
> xdp_frame statically like Lorenzo does (with struct xdp_rx_meta), but
> xdp_frame->flags can be used for marking this area as used or not.

the only downside with respect to a TLV approach would be to consume all the
xdp_rx_meta as soon as we set a single xdp rx hw hint in it, right?
The upside is it is easier and it requires less instructions.

>=20
>=20
> > - when &xdp_frame gets converted to sk_buff, the function checks whether
> >    data_meta contains a generic structure filled with hints.
> >=20
>=20
> Agree, but take data from xdp_frame->xdp_rx_meta.
>=20
> When XDP returns XDP_PASS, then I also want to see this data applied to
> the SKB. In patchset[1] Yan called this xdp_frame_fixup_skb_offloading()
> and xdp_buff_fixup_skb_offloading(). (Perhaps "fixup" isn't the right
> term, "apply" is perhaps better).  Having this generic-name allow us to
> extend with newer offloads, and eventually move members out of SKB.
>=20
> We called it "fixup", because our use-case is that our XDP load-balancer
> (Unimog) XDP_TX bounce packets with in GRE header encap, and on the
> receiving NIC (due to encap) we lost the HW hash/csum, which we want to
> transfer from the original NIC, decap in XDP and apply the original HW
> hash/csum via this "fixup" call.

I already set skb metadata converting xdp_frame into a skb in
__xdp_build_skb_from_frame() but I can collect all this logic in a single
routine.

Regards,
Lorenzo

>=20
> --Jesper
>=20
> [1] https://lore.kernel.org/all/cover.1718919473.git.yan@cloudflare.com/
>=20
> > We also thought about &skb_shared_info, but it's also size-sensitive as
> > it consumes tailroom.
> >=20
> > > one as a container to store the already supported xdp rx hw hints (rx=
_hash
> > > and rx_vlan, rx_timestamp will be stored in skb_shared_info area) whe=
n the
> > > eBPF program running on the nic performs XDP_REDIRECT. Doing so, we a=
re able
> > > to set the skb metadata converting the xdp_buff/xdp_frame to a skb.
> >=20
> > Thanks,
> > Olek
>=20

--inD87LbY/R9ETazn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZu/gvgAKCRA6cBh0uS2t
rBMGAQCny4oFrmk5dJWIQ0C1+/9UKb9+b/klnvNkYgQWGI7uwgD/Qn+xWmGdaRXY
s4/PVtYfv9dsYkKnnnco+8sDesjq9Ao=
=rOzF
-----END PGP SIGNATURE-----

--inD87LbY/R9ETazn--


