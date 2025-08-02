Return-Path: <bpf+bounces-64955-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8027B18ABB
	for <lists+bpf@lfdr.de>; Sat,  2 Aug 2025 07:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 831351AA2B97
	for <lists+bpf@lfdr.de>; Sat,  2 Aug 2025 05:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF49F1A8F60;
	Sat,  2 Aug 2025 05:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="kLrI7spz"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAE3A59;
	Sat,  2 Aug 2025 05:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754111288; cv=none; b=oJN7ROyxEl5R9LAGurL08fB7v8soy+pwNVj9/Fuk2K7kmfLINHsu5tHIAeakiPLJumxUwGchjCh6H6+LwnzdpeYv62sAxPuluvDJzQkNilIFZMr+Sg4quAX9iDaKQb3G+Bz572W87w4nLsG4CSw0kKawLyFfj2+UwAWUFJdIPUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754111288; c=relaxed/simple;
	bh=jruZhS7mCx8GQTSYRYMdVG/WMEW6NV2TbD6k6UtMdFA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PBXExRNI7bnIWk5Ro1afH5D8xHI4NA4y8JvqgmrlaVkYf2mRKNGsCgPnykMn9I5pKWlYg97vZ0RC1A71SddiMkDDQ3fF048ySseUGV83djEitUlfyAO/aWYeZkobp0/rt4VyEjBiE+zPDTHdv1u2L0pHVXpNc8qLof4fJLE51to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=kLrI7spz; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=202503; t=1754111275;
	bh=rwjvQEcgaDxeOlLgdTjlpv1NgjGhPHAakQTWLZ39Tx0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kLrI7spzu2rrq5UChQcgEIcNbrvjQ9diARVIoLlizdFNOTze5R7HffREm4cT8zfpN
	 Yry0T4pxpdTN27Ed3oIl+n1wAY4ueqUnkPUJANYKfgZt+hdTFu/fHkuAy0mwVIAsJp
	 gu3mlDtMRhBYd1HgCkx2t3Ixu8rFpAbJr8xBGov/oeb35Oa6SU48fq//zeSks5R8Tw
	 vcvjxJcp7DX61z24rlq0DjbX4g6Kn49PZVG2c7ajMyoA/aXWOIC1iu5c/WTLx/Epkq
	 8RUabLJb1Nz4Moy2cEUMoo04XuBkjHYk0xg9opOGX5pQUa8b7RCzz7C+XADy/HRMOb
	 0oWU5nioFmJOw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4bv9n32Jh9z4xQV;
	Sat,  2 Aug 2025 15:07:51 +1000 (AEST)
Date: Sat, 2 Aug 2025 15:07:46 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Byungchul Park <byungchul@sk.com>
Cc: linux-mm@kvack.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
 harry.yoo@oracle.com, ast@kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, saeedm@nvidia.com,
 leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
 andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
 akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, horms@kernel.org, jackmanb@google.com,
 hannes@cmpxchg.org, ziy@nvidia.com, ilias.apalodimas@linaro.org,
 willy@infradead.org, brauner@kernel.org, kas@kernel.org, yuzhao@google.com,
 usamaarif642@gmail.com, baolin.wang@linux.alibaba.com,
 almasrymina@google.com, toke@redhat.com, asml.silence@gmail.com,
 bpf@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH linux-next v3] mm, page_pool: introduce a new page type
 for page pool in page type
Message-ID: <20250802150746.139a71be@canb.auug.org.au>
In-Reply-To: <20250729110210.48313-1-byungchul@sk.com>
References: <20250729110210.48313-1-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/9yZ=dZN+zFc/Vgnr2iwwEfw";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/9yZ=dZN+zFc/Vgnr2iwwEfw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 29 Jul 2025 20:02:10 +0900 Byungchul Park <byungchul@sk.com> wrote:
>
> Changes from v2:
> 	1. Rebase on linux-next as of Jul 29.

Why are you basing development work in linux-next.  That is a
constantly rebasing tree.  Please base your work on some stable tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/9yZ=dZN+zFc/Vgnr2iwwEfw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmiNnSMACgkQAVBC80lX
0Gwf5Af+OMS7P8r7BKoR4DA+yUDiA60JSyGPWh4mtpdZbMuKCEDcbw1mrTbju/Cz
2Wab4zw/I/sx4WbpNZXspJMAdvxoGkzZZHQ7oq/B71pkdLgmP9SslfC6HLQNfmiI
+Lmmf9g8ASSFp+zjEAW/aU6nUZPUvywvt8tu5K/CAY1wvZqeEgf7n8Plg/Ef3hoh
3A0t3a1JRLbcqHxMAXeq+2DJ0twEP2QiC8nXxqOJSzq56jMFAvliO2vjZr0XHMBT
4Rki4Rfin3TM2MNLPM+fmIbkmuUBlAMI3qzkbPPuSVVw/j6OyexXePk2cusGRtVI
o2d7E7WZVhsEtKWo5PGb/NGaJqwnlw==
=6CHZ
-----END PGP SIGNATURE-----

--Sig_/9yZ=dZN+zFc/Vgnr2iwwEfw--

