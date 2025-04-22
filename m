Return-Path: <bpf+bounces-56450-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFCDA977EA
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 22:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C07E1B62266
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 20:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00952D86B5;
	Tue, 22 Apr 2025 20:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GsVPy6sn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DC6253B66;
	Tue, 22 Apr 2025 20:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745354742; cv=none; b=nJxhbE+Ud1SNg/7/zUf368qjeZiDWarahmLSjT2CJ4su7z0Bozbrim6aWuyLN4dxBBgS86spYzKPFCiWrHgWd2RJd+5kiOmqF+5SIfHhA79insmKvdJJck5q0ojQM0lB03FR/KPyX5feQcEIVJMddWjqWRA7iuxNQucByHOaheo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745354742; c=relaxed/simple;
	bh=MJ5S+KQLxIB48vX0Ihl/KfPtakrlHzBZwn8kDNqlnnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R8wgGyJ3PzOmZjL5x7+KPeXHgixEatSJ6i1oKyy4gAquGOWGRLItDkbI7SRejW8BwxnnWcqEznKDsg3Z3D10YJCkrTrOeZPI5Oyh2MlyToB0uVqwSvQSQurs+zEe5wZxudghJkyfAKttcavkd6rWflZ8CE1VmPLvhGuzQOF1uGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GsVPy6sn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C28B0C4CEE9;
	Tue, 22 Apr 2025 20:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745354740;
	bh=MJ5S+KQLxIB48vX0Ihl/KfPtakrlHzBZwn8kDNqlnnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GsVPy6snjMDSqhZymlQ62f7cXJ3/O43N4/ajb2HAu4fmj4Xe9G3IXnXmVNJikHgUF
	 Cv/Qoq0L5TdNk94EADlNyPXNO0H6jqo7l/N/aT4uWAeEs5ojaeNG6GGkidZO/XYC0P
	 kforbtCfjMUOrXpcxMkyCz2QExsfWkEZZvmd2t7b2Tq2mbmayf1PaiZygkBt5r7zGh
	 cjwkamQWlj4rWFcoVsXAjTOkox6owNw0H6RB80itISc/ZXDO/ToYXEJ7uOc+xwNU1w
	 CzdVSz/NSwqatLsFV6xsrztiTIoPDmwkJZGNuiowT3WnCDKfEVWSrobC/+jJ9+lru2
	 lZ/++QfT886sg==
Date: Tue, 22 Apr 2025 22:45:31 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, Song Liu <songliubraving@fb.com>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, 
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Alan Maguire <alan.maguire@oracle.com>, 
	David Laight <David.Laight@aculab.com>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>, 
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 22/22] man2: Add uprobe syscall page
Message-ID: <6rauz4mwgjpcmdbpny3pnh632t3wbequxni2iqdvs3bmjbzqzt@7cykilsvoggn>
References: <20250421214423.393661-1-jolsa@kernel.org>
 <20250421214423.393661-23-jolsa@kernel.org>
 <42yzod7olktnj4meijj57j5peiojywo2d47d5gefnbmbwxfz4b@5ek6puondmck>
 <aAehVOlj-W5kVyW3@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qmtdhiidifqdy7ta"
Content-Disposition: inline
In-Reply-To: <aAehVOlj-W5kVyW3@krava>


--qmtdhiidifqdy7ta
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, Song Liu <songliubraving@fb.com>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, 
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Alan Maguire <alan.maguire@oracle.com>, 
	David Laight <David.Laight@aculab.com>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>, 
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 22/22] man2: Add uprobe syscall page
References: <20250421214423.393661-1-jolsa@kernel.org>
 <20250421214423.393661-23-jolsa@kernel.org>
 <42yzod7olktnj4meijj57j5peiojywo2d47d5gefnbmbwxfz4b@5ek6puondmck>
 <aAehVOlj-W5kVyW3@krava>
MIME-Version: 1.0
In-Reply-To: <aAehVOlj-W5kVyW3@krava>

Hi Jiri,

On Tue, Apr 22, 2025 at 04:01:56PM +0200, Jiri Olsa wrote:
> > > +is an alternative to breakpoint instructions
> > > +for triggering entry uprobe consumers.
> >=20
> > What are breakpoint instructions?
>=20
> it's int3 instruction to trigger breakpoint (on x86_64)

I guess it's something that people who do that stuff understand.
I don't, but I guess your intended audience will be okay with it.  :)

> > The pages are almost identical.  Should we document both pages in the
> > same page?
>=20
> great, I was wondering this was an option, looks much better
> should we also add uprobe link, like below?

Yep, sure.  Thanks for the reminder!


Have a lovely night!
Alex

--=20
<https://www.alejandro-colomar.es/>

--qmtdhiidifqdy7ta
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmgH/+MACgkQ64mZXMKQ
wqlMwQ//U7jqY0ACZbbASQiYf/M/8TTZb4gnLDYB3NTU5OiuEOnRuMbB/OMZOQju
W6nUOJJXszsJ2a/GjDA6bhWe0Z64UoVpqRzQGXxLOVk31c8OlztiVgu40+jqaCbw
syhUGyTAkYeT/wFK6mpU0bEo1Nr5TQotr0hBaqg8qwtdkAprI1jjSyJF4/R+33ou
xj5+hMX2HGbsnc5xymVIJ4MFhlEdpVqoEHQe2JvBXmHzUoWGByv0x1yKIiDANgrJ
rzq20V9uSVIGBQvjxr+GU22kz5LiLtyvaMnslwH+M6JabrYzr6Y+GfnforlGpmSP
2L5iBrYHjVHAOAvhCUZo+F6q5XuGm642sSpu4U3vKwkgLpsdOiZvCrLNR5+qUXss
LDbUErFKjSAGuKGYMBYXuiXHcZwdUtAPrGouQoRRO2erMpJZy9M/tYS8Gru/tFPa
92JsnhsClRax8Vo/1L25HpcSvBXu46uQDgttKaU+5zMwAqAkWbGjy8UJWiNt30y/
nR28GPuKkWfIQasIPypXL+j2MaQrV62i2CFuttHuQay11ItDjy37Hi8ah+kKYny6
ZOn5rphEcVdT4MHW5soU9ggRVgJa5iv1t69KKIXMquj5GOFdr9iG+dsAR3+J5Gfd
B1lJ+J8IY9fHTHHYzZelwVb4Y0WEIHaLSK7UjN13dxPjfQZGsuU=
=mzRW
-----END PGP SIGNATURE-----

--qmtdhiidifqdy7ta--

