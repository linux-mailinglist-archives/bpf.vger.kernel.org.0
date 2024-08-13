Return-Path: <bpf+bounces-37055-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 585F49509F0
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 18:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10EBF282107
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 16:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054061A0B0F;
	Tue, 13 Aug 2024 16:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fd6uTRaQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770231A072C;
	Tue, 13 Aug 2024 16:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723565703; cv=none; b=cqGO3m9ZgVeMfUkkXirp3h0EEhBZs/9vgMElCwS1FHWvCpLoI/R5FlGiFAa7VBjZTFF7STOd2TfME6V3JNl6MMZTMTfPEyvvVTkrVX+Td0a21eV/BaJrXwm0xU//Y0cftZ6g9AptEpb4Ck3yvGgKXgiG63LhVTCLZyqcER0nQaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723565703; c=relaxed/simple;
	bh=wWRk/ig6it//ajoyfhkkyiqGpNMUQDGFY8uKZrOH+uY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Su04/nO2WIttrcOZ5tbEAlnx420jofmO62tLzx4i5gLwkGSTZ/p3TkbV0Be0XEF6ZcyMr9rX7FwWdVWc/DKPGs2rh1crIF/7XMehBTBGCEt6KB9YogQ/zfTuYh4Vx1Mc7yWWA56uO6FXzxk9XpVLy3NfkVWolYQHl7PyrbXjC2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fd6uTRaQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E790C4AF09;
	Tue, 13 Aug 2024 16:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723565702;
	bh=wWRk/ig6it//ajoyfhkkyiqGpNMUQDGFY8uKZrOH+uY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fd6uTRaQhzwKyOcwZ8tYlTQzfqCrD5z77SN16iWeyG2dpkDiS7OAOdp9K1j5z3jhE
	 8+QSEredJWKtfS/ERtkFJE6F8bOpCpabZtLAkZWdszdgSgtSVO3YopEHjXZiLw9DhS
	 /vg352VV5XeOhXj/PIdt3e1DTS8kl2UZtCue/m6OkGH9H7Ed3Po4TlFtA27NdJ/2pH
	 c9zwNE3EYdfDKgCS/Dj079wKJe87QCjz8/b8aByNmaHVGXuTiMnADNsx7WeL1ozl8L
	 vLn+b7yxvY0UZoNm8ySHHmt9fgmKAas5fmsUg5zCkpViUqAqn0EYbHAQg8OyMJ+Vye
	 WOzD6Fll4QPMQ==
Date: Tue, 13 Aug 2024 18:14:57 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
	Daniel Xu <dxu@dxuuu.xyz>,
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
Message-ID: <ZruGgYWXJ7Us4KOF@lore-rh-laptop.lan>
References: <20220628194812.1453059-1-alexandr.lobakin@intel.com>
 <20220628194812.1453059-33-alexandr.lobakin@intel.com>
 <cadda351-6e93-4568-ba26-21a760bf9a57@app.fastmail.com>
 <ZrRPbtKk7RMXHfhH@lore-rh-laptop>
 <54aab7ec-80e9-44fd-8249-fe0cabda0393@intel.com>
 <e0616dcc-1007-4faf-8825-6bf536799cbf@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Tirl59qwXJ/ukPZ5"
Content-Disposition: inline
In-Reply-To: <e0616dcc-1007-4faf-8825-6bf536799cbf@intel.com>


--Tirl59qwXJ/ukPZ5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Alexander Lobakin <aleksander.lobakin@intel.com>
> Date: Thu, 8 Aug 2024 13:57:00 +0200
>=20
> > From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
> > Date: Thu, 8 Aug 2024 06:54:06 +0200
> >=20
> >>> Hi Alexander,
> >>>
> >>> On Tue, Jun 28, 2022, at 12:47 PM, Alexander Lobakin wrote:
> >>>> cpumap has its own BH context based on kthread. It has a sane batch
> >>>> size of 8 frames per one cycle.
> >>>> GRO can be used on its own, adjust cpumap calls to the
> >>>> upper stack to use GRO API instead of netif_receive_skb_list() which
> >>>> processes skbs by batches, but doesn't involve GRO layer at all.
> >>>> It is most beneficial when a NIC which frame come from is XDP
> >>>> generic metadata-enabled, but in plenty of tests GRO performs better
> >>>> than listed receiving even given that it has to calculate full frame
> >>>> checksums on CPU.
> >>>> As GRO passes the skbs to the upper stack in the batches of
> >>>> @gro_normal_batch, i.e. 8 by default, and @skb->dev point to the
> >>>> device where the frame comes from, it is enough to disable GRO
> >>>> netdev feature on it to completely restore the original behaviour:
> >>>> untouched frames will be being bulked and passed to the upper stack
> >>>> by 8, as it was with netif_receive_skb_list().
> >>>>
> >>>> Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> >>>> ---
> >>>>  kernel/bpf/cpumap.c | 43 ++++++++++++++++++++++++++++++++++++++-----
> >>>>  1 file changed, 38 insertions(+), 5 deletions(-)
> >>>>
> >>>
> >>> AFAICT the cpumap + GRO is a good standalone improvement. I think
> >>> cpumap is still missing this.
> >=20
> > The only concern for having GRO in cpumap without metadata from the NIC
> > descriptor was that when the checksum status is missing, GRO calculates
> > the checksum on CPU, which is not really fast.
> > But I remember sometimes GRO was faster despite that.
> >=20
> >>>
> >>> I have a production use case for this now. We want to do some intelli=
gent
> >>> RX steering and I think GRO would help over list-ified receive in som=
e cases.
> >>> We would prefer steer in HW (and thus get existing GRO support) but n=
ot all
> >>> our NICs support it. So we need a software fallback.
> >>>
> >>> Are you still interested in merging the cpumap + GRO patches?
> >=20
> > For sure I can revive this part. I was planning to get back to this
> > branch and pick patches which were not related to XDP hints and send
> > them separately.
> >=20
> >>
> >> Hi Daniel and Alex,
> >>
> >> Recently I worked on a PoC to add GRO support to cpumap codebase:
> >> - https://github.com/LorenzoBianconi/bpf-next/commit/a4b8264d5000ecf01=
6da5a2dd9ac302deaf38b3e
> >>   Here I added GRO support to cpumap through gro-cells.
> >> - https://github.com/LorenzoBianconi/bpf-next/commit/da6cb32a4674aa724=
01c7414c9a8a0775ef41a55
> >>   Here I added GRO support to cpumap trough napi-threaded APIs (with a=
 some
> >>   changes to them).
> >=20
> > Hmm, when I was testing it, adding a whole NAPI to cpumap was sorta
> > overkill, that's why I separated GRO structure from &napi_struct.
> >=20
> > Let me maybe find some free time, I would then test all 3 solutions
> > (mine, gro_cells, threaded NAPI) and pick/send the best?
> >=20
> >>
> >> Please note I have not run any performance tests so far, just verified=
 it does
> >> not crash (I was planning to resume this work soon). Please let me kno=
w if it
> >> works for you.
>=20
> I did tests on both threaded NAPI for cpumap and my old implementation
> with a traffic generator and I have the following (in Kpps):
>=20
>             direct Rx    direct GRO    cpumap    cpumap GRO
> baseline    2900         5800          2700      2700 (N/A)
> threaded                               2300      4000
> old GRO                                2300      4000

cool, very nice improvement

>=20
> IOW,
>=20
> 1. There are no differences in perf between Lorenzo's threaded NAPI
>    GRO implementation and my old implementation, but Lorenzo's is also
>    a very nice cleanup as it switches cpumap to threaded NAPI completely
>    and the final diffstat even removes more lines than adds, while mine
>    adds a bunch of lines and refactors a couple hundred, so I'd go with
>    his variant.
>=20
> 2. After switching to NAPI, the performance without GRO decreases (2.3
>    Mpps vs 2.7 Mpps), but after enabling GRO the perf increases hugely
>    (4 Mpps vs 2.7 Mpps) even though the CPU needs to compute checksums
>    manually.
>=20
> Note that the code is not polished to the top and I also have a good
> improvement for allocating skb heads from the percpu NAPI cache in my
> old tree which I'm planning to add to the series, so the final
> improvement will be even bigger.
>=20
> + after we find how to pass checksum hint to cpumap, it will be yet
> another big improvement for GRO (current code won't benefit from
> this at all)
>=20
> To Lorenzo:
>=20
> Would it be fine if I prepare a series containing your patch for
> threaded NAPI for cpumap (I'd polish it and break into 2 or 3) +
> skb allocation optimization and send it OR you wanted to send this
> on your own? I'm fine with either, in the first case, everything
> would land within one series with the respective credits; in case
> of the latter, I'd need to send a followup :)

Sure, I am fine to send my codebase into a bigger series.
Thanks a lot for testing :)

Regards,
Lorenzo

>=20
> >>
> >> Regards,
> >> Lorenzo
> >>
> >>>
> >>> Thanks,
> >>> Daniel
>=20
> Thanks,
> Olek

--Tirl59qwXJ/ukPZ5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZruGfgAKCRA6cBh0uS2t
rO0rAP93QPZ9/V1zCcY5XFDUgHxSm/VXmEiTrHqOEgiT/wPijwEAiWSWE+nBfdog
3l6+Fy1eMFBoOJw6LSAEF73jVIwAYgM=
=LY2S
-----END PGP SIGNATURE-----

--Tirl59qwXJ/ukPZ5--

