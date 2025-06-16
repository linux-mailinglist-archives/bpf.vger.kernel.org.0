Return-Path: <bpf+bounces-60709-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B00E2ADB060
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 14:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9DCB16A035
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 12:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A69292B3F;
	Mon, 16 Jun 2025 12:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WS5IU3x+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80502292B2E;
	Mon, 16 Jun 2025 12:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750077479; cv=none; b=L1SBgoUKJpCQGXqtVEqnO8RPluP9i5ONizyQ2RFpswqnqv5tmscaoocpH8f9Lk3XG7WsXyC4IXae1LJ3mMNCtv2JW/Ys7DJ50T6vFjHyrqBmAmuhnch+lE3+eXn8rgKyNRLJSlbupyTLDnGfs9OtaFLjl2uJe4+t7rg8fVCInVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750077479; c=relaxed/simple;
	bh=JEPCADCrq2LrIHlVTuB+oCD1W34hSnP5MMMpgsVOuKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H9Pnukv5oqrYvsUxCAynMlrBQe4hmqmSFrCqCJpfK90xLed9/57IQu3T032HaPPlRSaSlHksxEyVJlITByOX2uA6Iu9KHiKee0gpK/m+dxF8tcVaFa3pSXoEKjIkVdvLuk2S12ysXRXpGNcqFYTOeLaZTuhwTk1idlxz7sLnS54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WS5IU3x+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C8BAC4CEF1;
	Mon, 16 Jun 2025 12:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750077479;
	bh=JEPCADCrq2LrIHlVTuB+oCD1W34hSnP5MMMpgsVOuKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WS5IU3x+XWWg1hmoTFlnpT1Z8p1Z6y/0Gbf107QHyL2Nb9C9uXW+NHqAmSLb3cyiz
	 5ES1r/yqw3KFf6JspBh+fA3XvOX5H+FZK83cvjH4Zkrq7NxKGjPUNS4H12SDlk/7Gj
	 HGyHTnZqqZHrXSRjvlYJOTSan1MUs2r32HbYvfEoMBsAPYY9VmjkMo0SXv5MT9DTh8
	 XqxwgIWlThLhXpobS6Qq2vH9ke+RsaF3iX7Zg9pgHEAx8RZZ4xNn4A9j471piG1OgU
	 zKi+zkgVmFtHZw25ARaTka3YtEy/wrQN5HsjebiFUVyH1I1+pFkYq8kc4D20SXtAes
	 ksOGhLOPTC5Qg==
Date: Mon, 16 Jun 2025 14:37:56 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <borkmann@iogearbox.net>,
	Eric Dumazet <eric.dumazet@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, sdf@fomichev.me,
	kernel-team@cloudflare.com, arthur@arthurfabre.com,
	jakub@cloudflare.com, Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH bpf-next V1 7/7] net: xdp: update documentation for
 xdp-rx-metadata.rst
Message-ID: <aFAQJKQ5wM-htTWN@lore-desk>
References: <174897271826.1677018.9096866882347745168.stgit@firesoul>
 <174897279518.1677018.5982630277641723936.stgit@firesoul>
 <aEJWTPdaVmlIYyKC@mini-arch>
 <bf7209aa-8775-448d-a12e-3a30451dad22@iogearbox.net>
 <87plfbcq4m.fsf@toke.dk>
 <aEixEV-nZxb1yjyk@lore-rh-laptop>
 <aEj6nqH85uBe2IlW@mini-arch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VywHLU06xENyqKzr"
Content-Disposition: inline
In-Reply-To: <aEj6nqH85uBe2IlW@mini-arch>


--VywHLU06xENyqKzr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jun 10, Stanislav Fomichev wrote:
> On 06/11, Lorenzo Bianconi wrote:
> > > Daniel Borkmann <daniel@iogearbox.net> writes:
> > >=20
> > [...]
> > > >>=20
> > > >> Why not have a new flag for bpf_redirect that transparently stores=
 all
> > > >> available metadata? If you care only about the redirect -> skb cas=
e.
> > > >> Might give us more wiggle room in the future to make it work with
> > > >> traits.
> > > >
> > > > Also q from my side: If I understand the proposal correctly, in ord=
er to fully
> > > > populate an skb at some point, you have to call all the bpf_xdp_met=
adata_* kfuncs
> > > > to collect the data from the driver descriptors (indirect call), an=
d then yet
> > > > again all equivalent bpf_xdp_store_rx_* kfuncs to re-store the data=
 in struct
> > > > xdp_rx_meta again. This seems rather costly and once you add more k=
funcs with
> > > > meta data aren't you better off switching to tc(x) directly so the =
driver can
> > > > do all this natively? :/
> > >=20
> > > I agree that the "one kfunc per metadata item" scales poorly. IIRC, t=
he
> > > hope was (back when we added the initial HW metadata support) that we
> > > would be able to inline them to avoid the function call overhead.
> > >=20
> > > That being said, even with half a dozen function calls, that's still a
> > > lot less overhead from going all the way to TC(x). The goal of the use
> > > case here is to do as little work as possible on the CPU that initial=
ly
> > > receives the packet, instead moving the network stack processing (and
> > > skb allocation) to a different CPU with cpumap.
> > >=20
> > > So even if the *total* amount of work being done is a bit higher beca=
use
> > > of the kfunc overhead, that can still be beneficial because it's split
> > > between two (or more) CPUs.
> > >=20
> > > I'm sure Jesper has some concrete benchmarks for this lying around
> > > somewhere, hopefully he can share those :)
> >=20
> > Another possible approach would be to have some utility functions (not =
kfuncs)
> > used to 'store' the hw metadata in the xdp_frame that are executed in e=
ach
> > driver codebase before performing XDP_REDIRECT. The downside of this ap=
proach
> > is we need to parse the hw metadata twice if the eBPF program that is b=
ounded
> > to the NIC is consuming these info. What do you think?
>=20
> That's the option I was asking about. I'm assuming we should be able
> to reuse existing xmo metadata callbacks for this. We should be able
> to hide it from the drivers also hopefully.

If we move the hw metadata 'store' operations to the driver codebase (runni=
ng
xmo metadata callbacks before performing XDP_REDIRECT), we will parse the hw
metadata twice if we attach to the NIC an AF_XDP program consuming the hw
metadata, right? One parsing is done by the AF_XDP hw metadata kfunc, and t=
he
second one would be performed by the native driver codebase.  Moreover, this
approach seems less flexible. What do you think?

Regards,
Lorenzo

--VywHLU06xENyqKzr
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaFAQJAAKCRA6cBh0uS2t
rKclAQCvfdnSjaqfL2sEVEPBTg9ms7jItZe4mgSn6ex5xtWOiwD+Lx/hyzIw/HoR
RuExYSMdd4VZH0G/erckZ9r5j0ByWAI=
=BJjO
-----END PGP SIGNATURE-----

--VywHLU06xENyqKzr--

