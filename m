Return-Path: <bpf+bounces-37056-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 504D6950A1B
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 18:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 738B11C20DD7
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 16:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D894D1A2540;
	Tue, 13 Aug 2024 16:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N01tNBbB"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1D4198A2F
	for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 16:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723566473; cv=none; b=V2SWIUB7cbCgdTQN5MWFu/eYu4PrAjpdkrOn8NaLNndppd2Sd4WWUXRZgbm2/0b3ZHmIHkwtCYqBvVkDL8J/JN/qyEocxP/LlPnArFXZby5Naqi/ADqFHhGzTYSx4OHrSBitQDMCLxpqmWDYRJj96oZlS8e15htrPf5Isg8aiKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723566473; c=relaxed/simple;
	bh=MVD3KtlDBNL4ylbqwBwnlNnoWPUqH8ebcS4i8wn6QPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LNAEfEn4XZU5FxZhFIpsYP8bNtCkS4xQTAWq3bGlsCKS1tbRPlkhyfaYClCG0bTxKaS3TmeMsyIo+JdWoNHorOduuGf3AG+e3lirjOQUh17S9VELkoFlMr5PT5ZV2rMgwMCl7cDzkLhNgoBhOCL489PRiOORN21dpZk3pVGitJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N01tNBbB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723566470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u/wxPouX1WnFR5+lpreMFAWfuh3u1ErH7E1Ghdyy2n8=;
	b=N01tNBbBfPWZgGXbeJxAjLcqFTnHsWq2goeBzuWkIfafi0O+stNMPsJ2zemd0DSKD09io1
	U4Sk8DOwW20oRNT/azUasG4Q6PEtCPfmEBl53jwuaqi0Bvs1I27gIVWPIRmZ8/x2XSi499
	wqgLknomSTJjQYKeNajBJLn7g3ZAOc8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-sSNci8-sP2S0bwBUCHAZKQ-1; Tue, 13 Aug 2024 12:27:47 -0400
X-MC-Unique: sSNci8-sP2S0bwBUCHAZKQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4281ca9f4dbso45881665e9.0
        for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 09:27:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723566466; x=1724171266;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/wxPouX1WnFR5+lpreMFAWfuh3u1ErH7E1Ghdyy2n8=;
        b=sipHIxjCvL8onYzDrEa64oCl8RzVPgpDXsuG+tPSauKMV8IGUqJwQf+gYHN/ypw/ej
         6XcC5VRJUX7h5BGMPMovMLc+np1StWdeftRoJ1pAsCCtgroELw01ReaK/KU1Gr3LQAkQ
         p0tW3UJ2qqFZ70tHOHitLerE6yimDyWvacnGpdshXZApIUlHNxCYPb6iKhwuOOy3Kk+1
         47LXPQocEDcIGl5wekKLVRWS+6kgI0CSW3Hg6kNacaBbcplxM9RY8BHOm3+VA+HU/Mib
         ritggGPwRJL8nQVgxWrrtil7mC2WOZomRb+8iMMWbzIW9jDvL6PmPxkK+14Fh00sTCW7
         eXyg==
X-Forwarded-Encrypted: i=1; AJvYcCVLs0JQu7OmsSjLgkcRMzRSjD7i6OrL52eug6EzTPvjmPH0E71o1eR8IwEqtG36d/2tkFg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8AxItmQE+ZYRFVmkm4qL+a9RGS6kd0VQGfv6HXkNQpplRmcAG
	I51L5FfjRdDibvA5helqjs59ng5aZtsEBTkp31+2UR1anP4Y0E1i9aCGQDm/J4OXtfyDIM+Atn+
	ALk/KE7wc+q+y4ZsO1EGlVnkdB/bepMHBNCgUbIPJ0BGV7hdO6Q==
X-Received: by 2002:a05:600c:548e:b0:428:fb96:e94a with SMTP id 5b1f17b1804b1-429dd2365ffmr468305e9.9.1723566465671;
        Tue, 13 Aug 2024 09:27:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXb6pZaD/xaaqJhSa7CuewDH0CF5WczOBWAa2z7gB9cS2UU5Nuu8dznz8JPfLdSE9X4jrIYg==
X-Received: by 2002:a05:600c:548e:b0:428:fb96:e94a with SMTP id 5b1f17b1804b1-429dd2365ffmr467855e9.9.1723566465062;
        Tue, 13 Aug 2024 09:27:45 -0700 (PDT)
Received: from localhost ([2001:b07:ab5:a597:abf4:6782:4209:952e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429c775c2b1sm149888065e9.42.2024.08.13.09.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 09:27:44 -0700 (PDT)
Date: Tue, 13 Aug 2024 18:27:41 +0200
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
Message-ID: <ZruJfencxeR8XHdm@lore-rh-laptop.lan>
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
	protocol="application/pgp-signature"; boundary="UyDdGDL3oIkMw4TE"
Content-Disposition: inline
In-Reply-To: <e0616dcc-1007-4faf-8825-6bf536799cbf@intel.com>


--UyDdGDL3oIkMw4TE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Aug 13, Alexander Lobakin wrote:
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

out of my curiority, have you tested even the gro_cells one?

Lorenzo

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
>=20

--UyDdGDL3oIkMw4TE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZruJewAKCRA6cBh0uS2t
rEIdAP9dns2tzikgzJ2YFjvZOk+3iBBzAnW4zrb0WTT/isfyBwD+MDFS8+HnM61f
CyDD9SD3t4XZuDPiuJSLQbvRrN9jtAw=
=CRDn
-----END PGP SIGNATURE-----

--UyDdGDL3oIkMw4TE--


