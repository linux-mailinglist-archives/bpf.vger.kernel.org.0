Return-Path: <bpf+bounces-41386-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FD2996790
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 12:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68FA9285AF0
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 10:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749CF190470;
	Wed,  9 Oct 2024 10:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gupJofFz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8EA18E351;
	Wed,  9 Oct 2024 10:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728470764; cv=none; b=o1Byvcxmiv7Kem8nFcdqmzMDzBhbin3i9k+cF284AG6JZc/sBlQzryKMf+HqPD9Qe3CNXvm6n/2z7VBZ9oR5g4F7d2UDqbUen5E02V55j/Q6OjmUhiPnBy6eKqvBDxf6oj5rp2+uA7BgqdVBJKqauPjDu8lSx9fj3jT0ugzwGRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728470764; c=relaxed/simple;
	bh=7ogfy63NCCHiSq49N0zXYSztoBG+LmVx6sEdMeXj01U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kz8pMq35b6iQ9uIbDDgbGDm0XOLVUzH7PIJ7KZiShWtD8AqCxRkfQiZhE0MvnXLUd57iswB3z9nFr+KBuqUVEFIsYvEkxY6rhwJ3KbF0/HQcr70nRhKVLCwRad/nRciFRXK1QMjrAfiPYOokfg55tJhlhhang4cADQXow1J8RLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gupJofFz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9CE2C4CEC5;
	Wed,  9 Oct 2024 10:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728470763;
	bh=7ogfy63NCCHiSq49N0zXYSztoBG+LmVx6sEdMeXj01U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gupJofFz/1KFx5SHdOOc4kiE9gC3+gLfGr9td62OwqUsqLTWrK/GpaVql4Vh7AciM
	 t5xyQ1PrvkBIidDk6sCIYHWKi2zxqCfCZCU4pABNqqC6snStLEwYSlads5xWLwWyMS
	 aXaz/9kaER5BVJdnAYPVa449NhlqC3nt8ol/8PG6GsVxkWP1rj45PthxVtKKj6dH+W
	 /ifqA0QffMGxZNSD7x7Rbb5RPT3psi+RsiGZZRzuYMaBDReLlIBrRdRtWWmW6QtbKM
	 uxoRS6dgWgAX71nGhw/IcnTId2d5Rhr9Ey5pv8GQZkh82QCRNf8H7bVsbE03a7nm+n
	 Qdfe+lh8CqZlQ==
Date: Wed, 9 Oct 2024 12:46:00 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: bpf@vger.kernel.org, kuba@kernel.org, aleksander.lobakin@intel.com,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	john.fastabend@gmail.com, hawk@kernel.org, martin.lau@linux.dev,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	netdev@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: Re: [RFC/RFT v2 0/3] Introduce GRO support to cpumap codebase
Message-ID: <ZwZe6Bg5ZrXLkDGW@lore-desk>
References: <cover.1726480607.git.lorenzo@kernel.org>
 <amx5t3imrrh56m7vtsmlhdzlggtv2mlhywk6266syjmijpgs2o@s2z7dollcf7l>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4BEHZd7sa3dhiYCn"
Content-Disposition: inline
In-Reply-To: <amx5t3imrrh56m7vtsmlhdzlggtv2mlhywk6266syjmijpgs2o@s2z7dollcf7l>


--4BEHZd7sa3dhiYCn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi Lorenzo,
>=20
> On Mon, Sep 16, 2024 at 12:13:42PM GMT, Lorenzo Bianconi wrote:
> > Add GRO support to cpumap codebase moving the cpu_map_entry kthread to a
> > NAPI-kthread pinned on the selected cpu.
> >=20
> > Changes in rfc v2:
> > - get rid of dummy netdev dependency
> >=20
> > Lorenzo Bianconi (3):
> >   net: Add napi_init_for_gro routine
> >   net: add napi_threaded_poll to netdevice.h
> >   bpf: cpumap: Add gro support
> >=20
> >  include/linux/netdevice.h |   3 +
> >  kernel/bpf/cpumap.c       | 123 ++++++++++++++++----------------------
> >  net/core/dev.c            |  27 ++++++---
> >  3 files changed, 73 insertions(+), 80 deletions(-)
> >=20
> > --=20
> > 2.46.0
> >=20
>=20
> Sorry about the long delay - finally caught up to everything after
> conferences.
>=20
> I re-ran my synthetic tests (including baseline). v2 is somehow showing
> 2x bigger gains than v1 (~30% vs ~14%) for tcp_stream. Again, the only
> variable I changed is kernel version - steering prog is active for both.
>=20
>=20
> Baseline (again)						=09
>=20
> ./tcp_rr -c -H $TASK_IP -p 50,90,99 -T4 -F8 -l30			        ./tcp_stream -=
c -H $TASK_IP -T8 -F16 -l30
> 						=09
> 	Transactions	Latency P50 (s)	Latency P90 (s)	Latency P99 (s)			Throughpu=
t (Mbit/s)
> Run 1	2560252	        0.00009087	0.00010495	0.00011647		Run 1	15479.31
> Run 2	2665517	        0.00008575	0.00010239	0.00013311		Run 2	15162.48
> Run 3	2755939	        0.00008191	0.00010367	0.00012287		Run 3	14709.04
> Run 4	2595680	        0.00008575	0.00011263	0.00012671		Run 4	15373.06
> Run 5	2841865	        0.00007999	0.00009471	0.00012799		Run 5	15234.91
> Average	2683850.6	0.000084854	0.00010367	0.00012543		Average	15191.76
> 						=09
> cpumap NAPI patches v2						=09
> 						=09
> 	Transactions	Latency P50 (s)	Latency P90 (s)	Latency P99 (s)			Throughpu=
t (Mbit/s)
> Run 1	2577838	        0.00008575	0.00012031	0.00013695		Run 1	19914.56
> Run 2	2729237	        0.00007551	0.00013311	0.00017663		Run 2	20140.92
> Run 3	2689442	        0.00008319	0.00010495	0.00013311		Run 3	19887.48
> Run 4	2862366	        0.00008127	0.00009471	0.00010623		Run 4	19374.49
> Run 5	2700538	        0.00008319	0.00010367	0.00012799		Run 5	19784.49
> Average	2711884.2	0.000081782	0.00011135	0.000136182		Average	19820.388
> Delta	1.04%	        -3.62%	        7.41%	        8.57%			        30.47%
>=20
> Thanks,
> Daniel

Hi Daniel,

cool, thx for testing it.

@Olek: how do we want to proceed on it? Are you still working on it or do y=
ou want me
to send a regular patch for it?

Regards,
Lorenzo

--4BEHZd7sa3dhiYCn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZwZe6AAKCRA6cBh0uS2t
rFVuAQCeYYTrJAMzE3J5ypktdAIYHT8ShePpXG4KJvD7gJokTAEAhY1ua80JsgUL
XZ1oa28DT9S5HUC5xR6nbEy5dvOuQQE=
=xdqd
-----END PGP SIGNATURE-----

--4BEHZd7sa3dhiYCn--

