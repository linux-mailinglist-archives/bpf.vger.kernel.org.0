Return-Path: <bpf+bounces-29629-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A99DA8C3D14
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 10:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAE121C210E5
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 08:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75751474AF;
	Mon, 13 May 2024 08:22:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906CB1EA8F;
	Mon, 13 May 2024 08:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715588575; cv=none; b=XHenWgjLkvlJoj6pvyapQb41IOmBdrd8+uphTlpgwAnMRlPT5vfwfdJ5MHjfNzJgLndEnRTGHuoOzY9m7F3YHbPmFOChYckdMHfZa4vO9B2NJGdnW/r1wEwShv8SvNVS3MWBDuPB/W66TaHU7h5pg4I6EC3bhR756Ez06JZGcmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715588575; c=relaxed/simple;
	bh=VdT02T+KafGvezTn4Q1x+u/4j/Y6V8DADyO6zaYJDI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QykCY8HNSS7aozQTQEiNqcGLIUOrgEoFtAdrDQLdvkCFZWvZRn+YFiA0UhpSBt4TuZnZZVZ1XiZpY/0uDh4o0iumYgJIXvr6dJeHYhby5hnnv5HPGOjZaucywVp7vFM3NaEciT8jNfGTTSY65FxROVjUbBQjKyMn9i6UCQcKmhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id B41411C008E; Mon, 13 May 2024 10:22:51 +0200 (CEST)
Date: Mon, 13 May 2024 10:22:51 +0200
From: Pavel Machek <pavel@denx.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	syzbot+83e7f982ca045ab4405c@syzkaller.appspotmail.com,
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Andy Lutomirski <luto@kernel.org>, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, peterz@infradead.org, xin3.li@intel.com,
	ubizjak@gmail.com, rick.p.edgecombe@intel.com, arnd@arndb.de,
	mjguzik@gmail.com, bpf@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.1 19/25] x86/mm: Remove broken vsyscall
 emulation code from the page fault code
Message-ID: <ZkHN25mewwQsCSVl@duo.ucw.cz>
References: <20240507231231.394219-1-sashal@kernel.org>
 <20240507231231.394219-19-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WWCtX4pqoop62PeZ"
Content-Disposition: inline
In-Reply-To: <20240507231231.394219-19-sashal@kernel.org>


--WWCtX4pqoop62PeZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Linus Torvalds <torvalds@linux-foundation.org>
>=20
> [ Upstream commit 02b670c1f88e78f42a6c5aee155c7b26960ca054 ]
=2E..
> IOW, I think the only right thing is to remove that horrendously broken
> code.
>=20
> The attached patch looks like the ObviouslyCorrect(tm) thing to do.
>=20
> NOTE! This broken code goes back to this commit in 2011:
>=20
>   4fc3490114bb ("x86-64: Set siginfo and context on vsyscall emulation fa=
ults")
>=20
> .. and back then the reason was to get all the siginfo details right.
> Honestly, I do not for a moment believe that it's worth getting the sigin=
fo
> details right here, but part of the commit says:
>=20
>     This fixes issues with UML when vsyscall=3Demulate.
>=20
> .. and so my patch to remove this garbage will probably break UML in this
> situation.
>=20
> I do not believe that anybody should be running with vsyscall=3Demulate in
> 2024 in the first place, much less if you are doing things like UML. But
> let's see if somebody screams.

Surely this should not go to stable with just 14days in mainline? We
don't want stable users to scream.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--WWCtX4pqoop62PeZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZkHN2wAKCRAw5/Bqldv6
8v7TAKCYmhtelhRRukx/Uu3Lrg8bHYnsIQCgi4ELc23Gr4P2w85lRLVFAGxcYbg=
=mLrd
-----END PGP SIGNATURE-----

--WWCtX4pqoop62PeZ--

