Return-Path: <bpf+bounces-36824-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BB494DB46
	for <lists+bpf@lfdr.de>; Sat, 10 Aug 2024 10:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04267B21CD9
	for <lists+bpf@lfdr.de>; Sat, 10 Aug 2024 08:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D129149DF7;
	Sat, 10 Aug 2024 08:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gI/vLAHu"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD82335BA
	for <bpf@vger.kernel.org>; Sat, 10 Aug 2024 08:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723276846; cv=none; b=WawdeKBaGe12B41712eDcbCCw/Fd7ki53NWsXm0CpkZYYVyGu89QipPYgXp0cZW9VUIbEbwy1QQS11y+Zl1IqQxaC9tby088Hmhe4wIPkprJeN/1K/U4qv8Hbvep1JyRAMcc0o6LUPfNW/n2Rig7j7PAizxPDaCa8viHUAbbUGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723276846; c=relaxed/simple;
	bh=FxumrIDW6qoxo9gfQ9R1lcQJdhBiVgoBIKMyeVQ2eZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dxHhy1WSWwLBMmDQvaA+WJbrLmRp6najAZS3IYayrVXr9ERaE98y1RflPStk6Xum0M1knOReUXJSVhxNRvsA6ue8JTfE3IRTmK+EUUsKMFoxRGvhz7/vNY8FXFUmO4YnQ0Yhyhopd2XGRuDHBfy72E4BPipN9QflNQIm7kTjRjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gI/vLAHu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723276844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cxaBsOWYXbQjl952d0wR8HU0oXx4pPetERcANE2n4pw=;
	b=gI/vLAHucsJzDuwknrYb5jqDUUI6+jvHh4qMHWt+xDTtTg5WSujV6B5vscSHSjF7imSY1a
	TSAqGOAUQmZFs0B3eMZstLdE90cn6df/tKeJ6TAFqaETYcyFFhkkBr3C2qfmsMehZ6DcOv
	5lkDXJarpFbkhzD6ecTnvJBuIbMpBHM=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-nf-PBsc_NXmHYSKJqL4xuQ-1; Sat, 10 Aug 2024 04:00:42 -0400
X-MC-Unique: nf-PBsc_NXmHYSKJqL4xuQ-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-52efd4afebeso3270479e87.2
        for <bpf@vger.kernel.org>; Sat, 10 Aug 2024 01:00:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723276840; x=1723881640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cxaBsOWYXbQjl952d0wR8HU0oXx4pPetERcANE2n4pw=;
        b=dOMJ0ky4qd+I/oDA7dfojrDmqHS1MVyR0yXbfNXlM6MWaIJ3+eUkgfmV+09ZSaD8QA
         pMQufBvsdBOSMVhRCoVL8CLK4IkJvPlu4gDBzH90Ejq53FyhVJwlqqL0Ix9XcgwqQyEl
         YhniXNOaby6DUeV6SoirmgS+sDWkBHtj/jkHLWRu4rUsH3dLhdXPL8ysB/TiuJonN93/
         ON6I+gssOjk7iZok6sJxMvGgkbDDcuOxJvpv4cTpo9INhDp9RsURlcTSqVA7SgNpnvA3
         cQInfwh4sT8abGM/p5FpnI+Fg2fgAT2MX6pUBfbjyyKwjbdD5HDfsC1JaeVZhICgYvWe
         FRrg==
X-Forwarded-Encrypted: i=1; AJvYcCWGOaNlKpszCKVaR/cL6u8g4rmSRhzcr49NvLpkPBlxXndumbL0NbgKLpQIPjhcZC3ISgG6cgVyAYRAXTl379Cy8GCI
X-Gm-Message-State: AOJu0Yy0aX3NO5wU5qG8G6pAcPb47RprPEB8n8yiiYiuqa6WXG4VFBSY
	c1I7S2Ht0q8g++O/57itCkryjhYrShdFHxN3PmfKrzvozoX2JKs5PjTiV+3v/12xgDmdgUuV1qb
	7NUx73IqiYdqwKA5POX64dR5sIVQ/7OSu2lN5jkNLcc78TcRptg==
X-Received: by 2002:a2e:be9d:0:b0:2f0:20cd:35fc with SMTP id 38308e7fff4ca-2f1a6c4cf01mr33426581fa.7.1723276840295;
        Sat, 10 Aug 2024 01:00:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHm7k8IUz5d3cudToCANSXgZtSllkVKwZwQhLwKqQ43m1YO/m1NdkmZJerxkfQZ0JUye0k27A==
X-Received: by 2002:a2e:be9d:0:b0:2f0:20cd:35fc with SMTP id 38308e7fff4ca-2f1a6c4cf01mr33426271fa.7.1723276839630;
        Sat, 10 Aug 2024 01:00:39 -0700 (PDT)
Received: from localhost (53.116.107.80.static.otenet.gr. [80.107.116.53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429c7736b05sm19723545e9.29.2024.08.10.01.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Aug 2024 01:00:39 -0700 (PDT)
Date: Sat, 10 Aug 2024 10:00:36 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Daniel Xu <dxu@dxuuu.xyz>,
	Alexander Lobakin <alexandr.lobakin@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	"toke@redhat.com" <toke@redhat.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Yajun Deng <yajun.deng@linux.dev>,
	Willem de Bruijn <willemb@google.com>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, xdp-hints@xdp-project.net
Subject: Re: [xdp-hints] Re: [PATCH RFC bpf-next 32/52] bpf, cpumap: switch
 to GRO from netif_receive_skb_list()
Message-ID: <ZrceJNrf2EkCD4Av@lore-rh-laptop>
References: <20220628194812.1453059-1-alexandr.lobakin@intel.com>
 <20220628194812.1453059-33-alexandr.lobakin@intel.com>
 <cadda351-6e93-4568-ba26-21a760bf9a57@app.fastmail.com>
 <ZrRPbtKk7RMXHfhH@lore-rh-laptop>
 <54aab7ec-80e9-44fd-8249-fe0cabda0393@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3tjfGVd/eoZK+rGd"
Content-Disposition: inline
In-Reply-To: <54aab7ec-80e9-44fd-8249-fe0cabda0393@intel.com>


--3tjfGVd/eoZK+rGd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Aug 08, Alexander Lobakin wrote:
> From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
> Date: Thu, 8 Aug 2024 06:54:06 +0200
>=20
> >> Hi Alexander,
> >>
> >> On Tue, Jun 28, 2022, at 12:47 PM, Alexander Lobakin wrote:
> >>> cpumap has its own BH context based on kthread. It has a sane batch
> >>> size of 8 frames per one cycle.
> >>> GRO can be used on its own, adjust cpumap calls to the
> >>> upper stack to use GRO API instead of netif_receive_skb_list() which
> >>> processes skbs by batches, but doesn't involve GRO layer at all.
> >>> It is most beneficial when a NIC which frame come from is XDP
> >>> generic metadata-enabled, but in plenty of tests GRO performs better
> >>> than listed receiving even given that it has to calculate full frame
> >>> checksums on CPU.
> >>> As GRO passes the skbs to the upper stack in the batches of
> >>> @gro_normal_batch, i.e. 8 by default, and @skb->dev point to the
> >>> device where the frame comes from, it is enough to disable GRO
> >>> netdev feature on it to completely restore the original behaviour:
> >>> untouched frames will be being bulked and passed to the upper stack
> >>> by 8, as it was with netif_receive_skb_list().
> >>>
> >>> Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> >>> ---
> >>>  kernel/bpf/cpumap.c | 43 ++++++++++++++++++++++++++++++++++++++-----
> >>>  1 file changed, 38 insertions(+), 5 deletions(-)
> >>>
> >>
> >> AFAICT the cpumap + GRO is a good standalone improvement. I think
> >> cpumap is still missing this.
>=20
> The only concern for having GRO in cpumap without metadata from the NIC
> descriptor was that when the checksum status is missing, GRO calculates
> the checksum on CPU, which is not really fast.
> But I remember sometimes GRO was faster despite that.

For the moment we could test it with UDP traffic with checksum disabled.

Regards,
Lorenzo

>=20
> >>
> >> I have a production use case for this now. We want to do some intellig=
ent
> >> RX steering and I think GRO would help over list-ified receive in some=
 cases.
> >> We would prefer steer in HW (and thus get existing GRO support) but no=
t all
> >> our NICs support it. So we need a software fallback.
> >>
> >> Are you still interested in merging the cpumap + GRO patches?
>=20
> For sure I can revive this part. I was planning to get back to this
> branch and pick patches which were not related to XDP hints and send
> them separately.
>=20
> >=20
> > Hi Daniel and Alex,
> >=20
> > Recently I worked on a PoC to add GRO support to cpumap codebase:
> > - https://github.com/LorenzoBianconi/bpf-next/commit/a4b8264d5000ecf016=
da5a2dd9ac302deaf38b3e
> >   Here I added GRO support to cpumap through gro-cells.
> > - https://github.com/LorenzoBianconi/bpf-next/commit/da6cb32a4674aa7240=
1c7414c9a8a0775ef41a55
> >   Here I added GRO support to cpumap trough napi-threaded APIs (with a =
some
> >   changes to them).
>=20
> Hmm, when I was testing it, adding a whole NAPI to cpumap was sorta
> overkill, that's why I separated GRO structure from &napi_struct.
>=20
> Let me maybe find some free time, I would then test all 3 solutions
> (mine, gro_cells, threaded NAPI) and pick/send the best?
>=20
> >=20
> > Please note I have not run any performance tests so far, just verified =
it does
> > not crash (I was planning to resume this work soon). Please let me know=
 if it
> > works for you.
> >=20
> > Regards,
> > Lorenzo
> >=20
> >>
> >> Thanks,
> >> Daniel
>=20
> Thanks,
> Olek
>=20

--3tjfGVd/eoZK+rGd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZrceIQAKCRA6cBh0uS2t
rAuOAP9lAP+wUtI4DT03vstan8oVHlFYyfbFpQ5S9GXv19t6iQD+Oq31gcfUQN93
0x2SbfWudVdpE9DvTKzXi6mE/f29ZAc=
=6Wya
-----END PGP SIGNATURE-----

--3tjfGVd/eoZK+rGd--


