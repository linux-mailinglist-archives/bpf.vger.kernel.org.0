Return-Path: <bpf+bounces-45820-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 260AB9DB61B
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 11:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3ADF6B257BA
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 10:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF7219340E;
	Thu, 28 Nov 2024 10:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KipBLTHO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C151C152E0C;
	Thu, 28 Nov 2024 10:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732791387; cv=none; b=tINPv3kGDq9LqiiFFKnZWGrUKLWiUlS5UiKgCnfIDnrlp1bF1e6m7rhQPURTgaUpMifkmI8tsUzhCO40TlZoPV/soDsQiJyWG1On2PhR8JnSVTUhKyxsiCL9IV9el5nWh5uakJiQN+/WViS/MWN0t7yZFgem4iYDMmJZGZQ+1HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732791387; c=relaxed/simple;
	bh=bOvTAQyGhFtSO3oOlIj+eY6C/kV6r6HSAxyPw4BMdKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QcewC9zK5JOjMsa2OjL1NcqPyWizVDRpk5t8ONn+U3DUQwnPuyv8mA4wkobh9R+eKlMtht6CTkdQcboeu+AkGg8WgIaf2MT+HgiqK0t5Mt028cRjDCUdtoZVduwbii9QCz3ZUaPXH5uf21Agc+VS76s0Rf3S2uySBzhF24UcsKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KipBLTHO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF6B5C4CECE;
	Thu, 28 Nov 2024 10:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732791387;
	bh=bOvTAQyGhFtSO3oOlIj+eY6C/kV6r6HSAxyPw4BMdKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KipBLTHOd7fgz9iEkrRex5VIoxgiURbB/2H1S4u7S/gAhQ9/XXJasuvHsZAH58mem
	 RDemU2PQxUSnQOnivpzyDP/+ifiCpPzSqfOem7s0w78grYX9Sv1Pmaw1dVeD3mjxcG
	 wr21A87QeX1ic5PKP3VJR1IHslFpXxVcrBdQsVBLPhftEGZUiSPrYwwr0jVRc5wjfl
	 QYBlGxCW7U6oPASkcSQs4vY/aoFgHB7V10F+1sOqIs+v4DWXRDazXYWHLHLeAVK1Y4
	 HDqIdbGwKCUydFYC656SkJq+Ke1IgsXcK/IcR+mhJsGc7EUExGTs40K+d2oSG1yGDz
	 8fq78bxvsjHcw==
Date: Thu, 28 Nov 2024 11:56:24 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
	Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
	Daniel Xu <dxu@dxuuu.xyz>, Jakub Kicinski <kuba@kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [RFC/RFT v2 0/3] Introduce GRO support to cpumap codebase
Message-ID: <Z0hMWCi6GRrpX8KU@lore-desk>
References: <c21dc62c-f03e-4b26-b097-562d45407618@intel.com>
 <01dcfecc-ab8e-43b8-b20c-96cc476a826d@intel.com>
 <b319014e-519c-4c2d-8b6d-1632357e66cd@app.fastmail.com>
 <rntmnecd6w7ntnazqloxo44dub2snqf73zn2jqwuur6io2xdv7@4iqbg5odgmfq>
 <05991551-415c-49d0-8f14-f99cb84fc5cb@intel.com>
 <a2ebba59-bf19-4bb9-9952-c2f63123b7cd@app.fastmail.com>
 <6db67537-6b7b-4700-9801-72b6640fc609@intel.com>
 <Z0X_Qv24e-A4Nxao@lore-desk>
 <3f6e4935-a04c-44fc-8048-7645ae40b921@kernel.org>
 <8d485cfa-eee7-481f-bb73-d00a76d2ab1c@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3w96tg7Kso12kgTu"
Content-Disposition: inline
In-Reply-To: <8d485cfa-eee7-481f-bb73-d00a76d2ab1c@intel.com>


--3w96tg7Kso12kgTu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Jesper Dangaard Brouer <hawk@kernel.org>
> Date: Tue, 26 Nov 2024 18:12:27 +0100
>=20
> >=20
> >=20
> >=20
> > On 26/11/2024 18.02, Lorenzo Bianconi wrote:
> >>> From: Daniel Xu <dxu@dxuuu.xyz>
> >>> Date: Mon, 25 Nov 2024 16:56:49 -0600
> >>>
> >>>>
> >>>>
> >>>> On Mon, Nov 25, 2024, at 9:12 AM, Alexander Lobakin wrote:
> >>>>> From: Daniel Xu <dxu@dxuuu.xyz>
> >>>>> Date: Fri, 22 Nov 2024 17:10:06 -0700
> >>>>>
> >>>>>> Hi Olek,
> >>>>>>
> >>>>>> Here are the results.
> >>>>>>
> >>>>>> On Wed, Nov 13, 2024 at 03:39:13PM GMT, Daniel Xu wrote:
> >>>>>>>
> >>>>>>>
> >>>>>>> On Tue, Nov 12, 2024, at 9:43 AM, Alexander Lobakin wrote:
> >>>>>
> >>>>> [...]
> >>>>>
> >>>>>> Baseline (again)
> >>>>>>
> >>>>>> =A0=A0=A0=A0Transactions=A0=A0=A0 Latency P50 (s)=A0=A0=A0 Latency=
 P90 (s)=A0=A0=A0 Latency
> >>>>>> P99 (s)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Throughput (Mbit/s)
> >>>>>> Run 1=A0=A0=A0 3169917=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0.00007295=
=A0=A0=A0 0.00007871=A0=A0=A0
> >>>>>> 0.00009343=A0=A0=A0=A0=A0=A0=A0 Run 1=A0=A0=A0 21749.43
> >>>>>> Run 2=A0=A0=A0 3228290=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0.00007103=
=A0=A0=A0 0.00007679=A0=A0=A0
> >>>>>> 0.00009215=A0=A0=A0=A0=A0=A0=A0 Run 2=A0=A0=A0 21897.17
> >>>>>> Run 3=A0=A0=A0 3226746=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0.00007231=
=A0=A0=A0 0.00007871=A0=A0=A0
> >>>>>> 0.00009087=A0=A0=A0=A0=A0=A0=A0 Run 3=A0=A0=A0 21906.82
> >>>>>> Run 4=A0=A0=A0 3191258=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0.00007231=
=A0=A0=A0 0.00007743=A0=A0=A0
> >>>>>> 0.00009087=A0=A0=A0=A0=A0=A0=A0 Run 4=A0=A0=A0 21155.15
> >>>>>> Run 5=A0=A0=A0 3235653=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0.00007231=
=A0=A0=A0 0.00007743=A0=A0=A0
> >>>>>> 0.00008703=A0=A0=A0=A0=A0=A0=A0 Run 5=A0=A0=A0 21397.06
> >>>>>> Average=A0=A0=A0 3210372.8=A0=A0=A0 0.000072182=A0=A0=A0 0.0000778=
14=A0=A0=A0
> >>>>>> 0.00009087=A0=A0=A0=A0=A0=A0=A0 Average=A0=A0=A0 21621.126
> >>>>>>
> >>>>>> cpumap v2 Olek
> >>>>>>
> >>>>>> =A0=A0=A0=A0Transactions=A0=A0=A0 Latency P50 (s)=A0=A0=A0 Latency=
 P90 (s)=A0=A0=A0 Latency
> >>>>>> P99 (s)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Throughput (Mbit/s)
> >>>>>> Run 1=A0=A0=A0 3253651=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0.00007167=
=A0=A0=A0 0.00007807=A0=A0=A0
> >>>>>> 0.00009343=A0=A0=A0=A0=A0=A0=A0 Run 1=A0=A0=A0 13497.57
> >>>>>> Run 2=A0=A0=A0 3221492=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0.00007231=
=A0=A0=A0 0.00007743=A0=A0=A0
> >>>>>> 0.00009087=A0=A0=A0=A0=A0=A0=A0 Run 2=A0=A0=A0 12115.53
> >>>>>> Run 3=A0=A0=A0 3296453=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0.00007039=
=A0=A0=A0 0.00007807=A0=A0=A0
> >>>>>> 0.00009087=A0=A0=A0=A0=A0=A0=A0 Run 3=A0=A0=A0 12323.38
> >>>>>> Run 4=A0=A0=A0 3254460=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0.00007167=
=A0=A0=A0 0.00007807=A0=A0=A0
> >>>>>> 0.00009087=A0=A0=A0=A0=A0=A0=A0 Run 4=A0=A0=A0 12901.88
> >>>>>> Run 5=A0=A0=A0 3173327=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0.00007295=
=A0=A0=A0 0.00007871=A0=A0=A0
> >>>>>> 0.00009215=A0=A0=A0=A0=A0=A0=A0 Run 5=A0=A0=A0 12593.22
> >>>>>> Average=A0=A0=A0 3239876.6=A0=A0=A0 0.000071798=A0=A0=A0 0.0000780=
7=A0=A0=A0
> >>>>>> 0.000091638=A0=A0=A0=A0=A0=A0=A0 Average=A0=A0=A0 12686.316
> >>>>>> Delta=A0=A0=A0 0.92%=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -0.53%=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 0.33%=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
> >>>>>> 0.85%=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -41=
=2E32%
> >>>>>>
> >>>>>>
> >>>>>> It's very interesting that we see -40% tput w/ the patches. I went
> >>>>>> back
> >>>>>
> >>>>> Oh no, I messed up something =3D\
> >>>>>
> >>>>> Could you please also test not the whole series, but patches 1-3
> >>>>> (up to
> >>>>> "bpf:cpumap: switch to GRO...") and 1-4 (up to "bpf: cpumap: reuse =
skb
> >>>>> array...")? Would be great to see whether this implementation works
> >>>>> worse right from the start or I just broke something later on.
> >>>>
> >>>> Patches 1-3 reproduces the -40% tput numbers.
> >>>
> >>> Ok, thanks! Seems like using the hybrid approach (GRO, but on top of
> >>> cpumap's kthreads instead of NAPI) really performs worse than switchi=
ng
> >>> cpumap to NAPI.
> >>>
> >>>>
> >>>> With patches 1-4 the numbers get slightly worse (~1gbps lower) but
> >>>> it was noisy.
> >>>
> >>> Interesting, I was sure patch 4 optimizes stuff... Maybe I'll give up
> >>> on it.
> >>>
> >>>>
> >>>> tcp_rr results were unaffected.
> >>>
> >>> @ Jakub,
> >>>
> >>> Looks like I can't just use GRO without Lorenzo's conversion to NAPI,=
 at
> >>> least for now =3D\ I took a look on the backlog NAPI and it could be =
used,
> >>> although we'd need a pointer in the backlog to the corresponding cpum=
ap
> >>> + also some synchronization point to make sure backlog NAPI won't acc=
ess
> >>> already destroyed cpumap.
> >>>
> >>> Maybe Lorenzo could take a look...
> >>
> >> it seems to me the only difference would be we will use the shared
> >> backlog_napi
> >> kthreads instead of having a dedicated kthread for each cpumap entry
> >> but we still
> >> need the napi poll logic. I can look into it if you prefer the shared
> >> kthread
> >> approach.
> >=20
> > I don't like a shared kthread approach. For my use-case I want to give
> > the "remote" CPU-map kthreads higher scheduling priority. (As it will be
> > running a 2nd XDP BPF DDoS program protecting against overload by
> > dropping packets).
>=20
> Oh, that is also valid.
> Let's see what Jakub replies, for now I'm leaning towards posting
> approach from this RFC with my bulk allocation from the NAPI cache.

I guess it would be better to keep them separated to check what are the eff=
ects
of each change (GRO for cpumap and bulk allocation). I guess you can post y=
our
changes on top of mine if we all agree the proposed approach is fine.
What do you think?

Regards,
Lorenzo

>=20
> >=20
> > Thus, I'm not a fan of using the shared backlog_napi.=A0 As I don't want
> > to give backlog NAPI high priority, in my use-case.
> >=20
> >> @Jakub: what do you think?
> >=20
> >=20
> > --Jesper
>=20
> Thanks,
> Olek

--3w96tg7Kso12kgTu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ0hMWAAKCRA6cBh0uS2t
rH3oAQDofsq++iDtfZmwDdysHY03ijOAX7Rz3TalhBq4KSl6UAD/QwZL5M5EmNSS
PO47NqxSSgAvH2AQ47VRO6wcTLiceAY=
=/DUx
-----END PGP SIGNATURE-----

--3w96tg7Kso12kgTu--

