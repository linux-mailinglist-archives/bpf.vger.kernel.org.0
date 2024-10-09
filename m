Return-Path: <bpf+bounces-41399-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 797C1996AB8
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 14:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 313A31F218D5
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 12:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2BC1A0BCA;
	Wed,  9 Oct 2024 12:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1j+opvo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01D0198A32;
	Wed,  9 Oct 2024 12:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728478081; cv=none; b=OwdzoDoGRlP4Fk8eGq5A37/ksZWKiokrn8jRW+WVBezKjIqsiVIYxoZ1VzHbTIeKp6XVIF5a/mbAA3J/nGReXN5N4F4aowOMk6od61GoDEllNF9thE6L3U2oTMgZ2KCW/CEpOM+Kmp7THOQa3MtImCBRlRiCgu9lQfLVLON6Nq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728478081; c=relaxed/simple;
	bh=qzv4ucf9GRL1iYIedFvD/yrU1VM4gBM94xHUwsCGszI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H5IeZ9otpya50u5Vq+jmkfJs9OvrLcbAsodinnlXcPgbMlw2tCsNj/qxTzQBwunsys0F5LlTO7JjRVOZokXhRaSPnhAA1NZV/Goh3iNoXnjkr2m2bWNp4QJbSNjLi5/Ut8OE9HIUzaLzjG8XG/CWdd+9lY65CeI8Gz0bUKVY39M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1j+opvo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D37A9C4CEC5;
	Wed,  9 Oct 2024 12:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728478081;
	bh=qzv4ucf9GRL1iYIedFvD/yrU1VM4gBM94xHUwsCGszI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T1j+opvoqLub5t7SGUPcYBxM4EP4F+IHarwuXv4B6m58MqVCCq94BRbNqnCX/E0DU
	 p12VDctGgZuMFvLVeHhzkTPYPzALRVzjSD4qIRlcvreG+THwkiqUsmZc4DUFfHShNv
	 NxbjWcDLiQeIUlMyZWKzoPvPNl8Ga41KWLPKjPULkE0U6SivFPTAQwHwDckV644fpT
	 5cmUS4dt+kgXtE2TCVuY/2ClNHiIewaOJstXFM/efE9e4RvER87Gf5t+cfJwNRTytO
	 33JY2+24MMzqdHAlhyT7IE6FzLmCYNwIvzeYaW9rW4ab+V1ZCCVsSzfiuCAP1jFXcX
	 BSO29p6FRYO8Q==
Date: Wed, 9 Oct 2024 14:47:58 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Daniel Xu <dxu@dxuuu.xyz>, bpf@vger.kernel.org, kuba@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	john.fastabend@gmail.com, hawk@kernel.org, martin.lau@linux.dev,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	netdev@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: Re: [RFC/RFT v2 0/3] Introduce GRO support to cpumap codebase
Message-ID: <ZwZ7fr_STZStsnln@lore-desk>
References: <cover.1726480607.git.lorenzo@kernel.org>
 <amx5t3imrrh56m7vtsmlhdzlggtv2mlhywk6266syjmijpgs2o@s2z7dollcf7l>
 <ZwZe6Bg5ZrXLkDGW@lore-desk>
 <55d2ac1c-0619-4b24-b8ab-6eb5f553c1dd@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kDUuMoXxf1257TOa"
Content-Disposition: inline
In-Reply-To: <55d2ac1c-0619-4b24-b8ab-6eb5f553c1dd@intel.com>


--kDUuMoXxf1257TOa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Lorenzo Bianconi <lorenzo@kernel.org>
> Date: Wed, 9 Oct 2024 12:46:00 +0200
>=20
> >> Hi Lorenzo,
> >>
> >> On Mon, Sep 16, 2024 at 12:13:42PM GMT, Lorenzo Bianconi wrote:
> >>> Add GRO support to cpumap codebase moving the cpu_map_entry kthread t=
o a
> >>> NAPI-kthread pinned on the selected cpu.
> >>>
> >>> Changes in rfc v2:
> >>> - get rid of dummy netdev dependency
> >>>
> >>> Lorenzo Bianconi (3):
> >>>   net: Add napi_init_for_gro routine
> >>>   net: add napi_threaded_poll to netdevice.h
> >>>   bpf: cpumap: Add gro support
> >>>
> >>>  include/linux/netdevice.h |   3 +
> >>>  kernel/bpf/cpumap.c       | 123 ++++++++++++++++--------------------=
--
> >>>  net/core/dev.c            |  27 ++++++---
> >>>  3 files changed, 73 insertions(+), 80 deletions(-)
> >>>
> >>> --=20
> >>> 2.46.0
> >>>
> >>
> >> Sorry about the long delay - finally caught up to everything after
> >> conferences.
> >>
> >> I re-ran my synthetic tests (including baseline). v2 is somehow showing
> >> 2x bigger gains than v1 (~30% vs ~14%) for tcp_stream. Again, the only
> >> variable I changed is kernel version - steering prog is active for bot=
h.
> >>
> >>
> >> Baseline (again)						=09
> >>
> >> ./tcp_rr -c -H $TASK_IP -p 50,90,99 -T4 -F8 -l30			        ./tcp_strea=
m -c -H $TASK_IP -T8 -F16 -l30
> >> 						=09
> >> 	Transactions	Latency P50 (s)	Latency P90 (s)	Latency P99 (s)			Throug=
hput (Mbit/s)
> >> Run 1	2560252	        0.00009087	0.00010495	0.00011647		Run 1	15479.31
> >> Run 2	2665517	        0.00008575	0.00010239	0.00013311		Run 2	15162.48
> >> Run 3	2755939	        0.00008191	0.00010367	0.00012287		Run 3	14709.04
> >> Run 4	2595680	        0.00008575	0.00011263	0.00012671		Run 4	15373.06
> >> Run 5	2841865	        0.00007999	0.00009471	0.00012799		Run 5	15234.91
> >> Average	2683850.6	0.000084854	0.00010367	0.00012543		Average	15191.76
> >> 						=09
> >> cpumap NAPI patches v2						=09
> >> 						=09
> >> 	Transactions	Latency P50 (s)	Latency P90 (s)	Latency P99 (s)			Throug=
hput (Mbit/s)
> >> Run 1	2577838	        0.00008575	0.00012031	0.00013695		Run 1	19914.56
> >> Run 2	2729237	        0.00007551	0.00013311	0.00017663		Run 2	20140.92
> >> Run 3	2689442	        0.00008319	0.00010495	0.00013311		Run 3	19887.48
> >> Run 4	2862366	        0.00008127	0.00009471	0.00010623		Run 4	19374.49
> >> Run 5	2700538	        0.00008319	0.00010367	0.00012799		Run 5	19784.49
> >> Average	2711884.2	0.000081782	0.00011135	0.000136182		Average	19820.388
> >> Delta	1.04%	        -3.62%	        7.41%	        8.57%			        30.47%
> >>
> >> Thanks,
> >> Daniel
> >=20
> > Hi Daniel,
> >=20
> > cool, thx for testing it.
> >=20
> > @Olek: how do we want to proceed on it? Are you still working on it or =
do you want me
> > to send a regular patch for it?
>=20
> Hi,
>=20
> I had a small vacation, sorry. I'm starting working on it again today.

ack, no worries. Are you going to rebase the other patches on top of it
or are you going to try a different approach?

Regards,
Lorenzo

>=20
> >=20
> > Regards,
> > Lorenzo
>=20
> Thanks,
> Olek

--kDUuMoXxf1257TOa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZwZ7fgAKCRA6cBh0uS2t
rMNJAQCW5cGMnsVDgt+mpnZyRJ6bKHxvq+zejW/Eo0aPKGpFcQEA1dH42YaVhnT/
l2f04ZVlZCk10WPkRXb8G4TJhLmrzgc=
=Yyo1
-----END PGP SIGNATURE-----

--kDUuMoXxf1257TOa--

