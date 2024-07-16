Return-Path: <bpf+bounces-34915-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 418EC93270A
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 15:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF184B23DC1
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 13:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47C319AD40;
	Tue, 16 Jul 2024 13:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MoR9Lpb4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D1A1420B6;
	Tue, 16 Jul 2024 13:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721134893; cv=none; b=Ogn0a7kuqOWU/T3ciYNoViu+YbqS31pV8VN61kesnvLbjZNs5UY0ZpSsnikTsdT/S04J35TvsBQa4JB0ksMJdQ0djcZJEZDHAvNWQjsGCnbUBn930kYFyxRck3M16jEK9+ZAnQnEB6s0/Fmsmp3HX9YexmWYZdC7H8Elsj5uJHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721134893; c=relaxed/simple;
	bh=AsXL27TneBmebro039qrVN87ml4QBwhP4OAoCLWsKQA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=terKh7AHN0cDYbZcDOpKR4JTQnB502mECMP3zojqr7Z2bYOq4lPxkmOAAgBFygju9SOKD9DKGDE4JwYy4VpxVNLEDZA29R1+0RhpRANWHfgPXHcuph9Os+9zHs4Hw6avrFUXgYTkJrFiq0kPwHAqcNk0jjA2KUNDnpUrCR9Jpuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MoR9Lpb4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89890C116B1;
	Tue, 16 Jul 2024 13:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721134892;
	bh=AsXL27TneBmebro039qrVN87ml4QBwhP4OAoCLWsKQA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=MoR9Lpb4aFyXtK+Fc3Ox+UwxaF+q+3GCj6dg5wJcLLe0Hz2EK/oduZ48ONT9ez0j3
	 H7gqe8qb1nLnrNFNqX9A26BvAW4XUMZq5PxzosI8XDNbuY/opqbHWgEJCpJ3jCfrHx
	 7mJ6AGzwiUCyyyf4zau3SMQ51CyuhgbtDf6f/GazEUay7g8iP0ZIWWp0WHi9IrWpt7
	 Ld5c4ZJkIAUhsj3G88q0UkkTTrg/Ft6SHhkukUAif5YQB9dib2qQ1Np8Wq0cCKYMJV
	 MOqAGIxyp7Rm0+2ZJ7M8yAiru5PYzcrQDfUyzjZSaCO7sSvFBfugGe7W2mLXkLt0vP
	 EmM4itbW8tkYA==
From: Puranjay Mohan <puranjay@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Russell King <russell.king@oracle.com>, Alan Maguire
 <alan.maguire@oracle.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 stable@vger.kernel.org
Subject: Re: [PATCH 5.10] arm64/bpf: Remove 128MB limit for BPF JIT programs
In-Reply-To: <2024071656-valid-unpleased-d29a@gregkh>
References: <20240701114659.39539-1-pjy@amazon.com>
 <mb61py1617bua.fsf@kernel.org> <2024071656-valid-unpleased-d29a@gregkh>
Date: Tue, 16 Jul 2024 13:01:26 +0000
Message-ID: <mb61pbk2xpk2h.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> On Tue, Jul 16, 2024 at 12:36:29PM +0000, Puranjay Mohan wrote:
>>=20
>> +CC Greg
>
> Why?

I forgot to add you to the cc-list when sending this patch for stable.

> confused,
>
> greg k-h

Thanks,
Puranjay

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIoEARYKADIWIQQ3wHGvVs/5bdl78BKwwPkjG3B2nQUCZpZvJxQccHVyYW5qYXlA
a2VybmVsLm9yZwAKCRCwwPkjG3B2nTyVAQD8peHpkDOrALZFFIVKoUFSPn9O5scx
QFc7PxxJrEXLkQD6AiAoWCPOX5x6ZosBtXmvP7zrAkEPHgNHrao4teC8+AI=
=faJI
-----END PGP SIGNATURE-----
--=-=-=--

