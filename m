Return-Path: <bpf+bounces-37954-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 937F295CEE6
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 16:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5BDE1C2290F
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 14:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED361891B2;
	Fri, 23 Aug 2024 14:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="jlaDrOju"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3FA194125;
	Fri, 23 Aug 2024 14:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421766; cv=none; b=oZwlgX/hUL86LTfG+ihJ5+h2toyurHJA4Bw25Cu1cwWkamrAPXDDUf76CC3stE1KqJF8B7k0BTogJc99AmRt0EjR1+nrRZNP2fGlbKftmatg9Y4L+qEOVJ4jfQ5VWRMZE4FqOL5qhYBmNhqub8Wq2/mNf777wTQ2jv93aMgikXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421766; c=relaxed/simple;
	bh=M/+JW3B4fr1FmeAODEX3e/e8p10B2hMp1V9Fr4Rz+m8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gEkKThaWTeQXAxKhrEkn97f3g+gOlXTHUSHQ6ILz9FaFqVqFQvBhZgtqL4wYgNCHEgONhpj1gk6mVhSIumt/xeHx9M/Fo6Cqfp6tjGbfRxqGBgv3gB3Z7A+jbahve2vIu2atD45UJH1OWgTCy8tAy7OHFFVAEOKNySPs1I5SzPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu; spf=pass smtp.mailfrom=fjasle.eu; dkim=pass (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b=jlaDrOju; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fjasle.eu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fjasle.eu;
	s=ds202307; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GxF+gOMi88g9BBo9JOx0m3wME02pBHhU7ugsa7eOpAg=; b=jlaDrOjuTijwmuVnD8iWgRrncU
	6yxUlbz5CLacwjZ/oDiZadhRopTWse3LShl6LJNsxsgLSFr0zGrM3Hkq5Zk0hjA4XzEqXkWjWGBHU
	StiWyIjZnctjVoag7pCR5VuNRVG6gN7Z1nLNe1lakLkpkNfawtrRzvOvFJW6EOJBhzCQDoqM+T6jn
	DDRX/xlE56lRGtQrcKP/M23Ce9q1hLSNiCoAU8GMrtSw3AQ5pVgNSH//3CrYKjfQqRviXTr972oQA
	qtclx9AEU/BInPyQEzE88xiZ3RMPMpD2mGWgavURamvAV9llfwL87qE4uXgFx1QlPs79MMA2AsAtY
	feutIWwQ==;
Received: from [2001:9e8:9f5:ff01:6f0:21ff:fe91:394] (port=45454 helo=bergen)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <nicolas@fjasle.eu>)
	id 1shUpT-000BrH-4G;
	Fri, 23 Aug 2024 15:59:51 +0200
Date: Fri, 23 Aug 2024 15:59:46 +0200
From: Nicolas Schier <nicolas@fjasle.eu>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH] kbuild: pahole-version: avoid errors if executing fails
Message-ID: <ZsiV0V5-UYFGkxPE@bergen>
References: <20240728125527.690726-1-ojeda@kernel.org>
 <CAK7LNARhR=GGZ2Vr-SSog1yjnjh6iT7cCEe4mpYg889GhJnO9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yO3YVrUfbWxrxaQH"
Content-Disposition: inline
In-Reply-To: <CAK7LNARhR=GGZ2Vr-SSog1yjnjh6iT7cCEe4mpYg889GhJnO9g@mail.gmail.com>
X-Operating-System: Debian GNU/Linux 12.6
Jabber-ID: nicolas@jabber.no


--yO3YVrUfbWxrxaQH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 23 Aug 2024 02:28:28 GMT, Masahiro Yamada wrote:
> Date: Fri, 23 Aug 2024 02:28:28 +0900
> From: Masahiro Yamada <masahiroy@kernel.org>
> To: Miguel Ojeda <ojeda@kernel.org>
> Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
>  <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
>  Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song L=
iu
>  <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabe=
nd
>  <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
>  Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
>  <jolsa@kernel.org>, bpf@vger.kernel.org, Nathan Chancellor
>  <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>,
>  linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
>  patches@lists.linux.dev
> Subject: Re: [PATCH] kbuild: pahole-version: avoid errors if executing fa=
ils
> X-Mailing-List: linux-kbuild@vger.kernel.org
> Message-ID: <CAK7LNARhR=3DGGZ2Vr-SSog1yjnjh6iT7cCEe4mpYg889GhJnO9g@mail.g=
mail.com>
>=20
> On Sun, Jul 28, 2024 at 9:55=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> w=
rote:
> >
> > Like patch "rust: suppress error messages from
> > CONFIG_{RUSTC,BINDGEN}_VERSION_TEXT" [1], do not assume the file existi=
ng
> > and being executable implies executing it will succeed. Instead, bail
> > out if executing it fails for any reason.
> >
> > For instance, `pahole` may be built for another architecture, may be a
> > program we do not expect or may be completely broken:
> >
> >     $ echo 'bad' > bad-pahole
> >     $ chmod u+x bad-pahole
> >     $ make PAHOLE=3D./bad-pahole defconfig
> >     ...
> >     ./bad-pahole: 1: bad: not found
> >     init/Kconfig:112: syntax error
> >     init/Kconfig:112: invalid statement
>=20
>=20
>=20
> Even with this patch applied, a syntax error can happen.
>=20
> $ git log --oneline -1
> dd1c54d77f11 kbuild: pahole-version: avoid errors if executing fails
> $ echo 'echo' > bad-pahole
> $ chmod u+x bad-pahole
> $ make PAHOLE=3D./bad-pahole defconfig
> *** Default configuration is based on 'x86_64_defconfig'
> init/Kconfig:114: syntax error
> init/Kconfig:114: invalid statement
> make[2]: *** [scripts/kconfig/Makefile:95: defconfig] Error 1
> make[1]: *** [/home/masahiro/workspace/linux-kbuild/Makefile:680:
> defconfig] Error 2
> make: *** [Makefile:224: __sub-make] Error 2
>=20

Do we have to catch all possibilities?  Then, what about this:


#!/bin/sh
trap "echo 0; exit 1" EXIT
set -e

output=3D$("$@" --version 2>/dev/null)

output=3D$(echo "${output}" |  sed -nE 's/^v([0-9]+)\.([0-9][0-9])$/\1\2/p')
if [ -z "${output}" ]; then
	echo "warning: pahole binary '$1' outputs incompatible version number, pah=
ole will not be used." >&2
	exit 1
fi

echo "${output}"
trap EXIT



Kind regards,
Nicolas

--yO3YVrUfbWxrxaQH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmbIlcYACgkQB1IKcBYm
EmlIXhAAw5al6h44X2UnA31bKgo8H+OA3wzHIF1UTZOMe02NkAtVFidcpkKqxLih
n5bOp6VjVr5KRcp7O45TAIWJ4Bm3G4PHX52MrohtW5GXABeoVRQTsCTdS1BB1PTh
9nZZIvKF3ONqHGDSfYXHP72bfW1bVn1pzgMj/FA6GhRkv1n4AQVfO1Ohyacrn4go
AT+6hu3gWwtj0CqeYJVBJ66GNDBCC9eoc++79WB0BQipZRNr3sHHznb7pOA+3M57
iRhDdiVDIwmUcQTfj7oS/H/hlTLW5BeYhmXUyLDQaq3yAgcnKyQPCfdftVNmlmyN
hI+jPJKnhYLGvB8UPj63GJudRqW/RNqE7ewZF2aOvC7+IaZwdRhaduOrCkBU+pNY
/YYDOkEElGNRKHW9J5zFDuPQwlFDaLfCZ4hezgXYpiZTN7NggYKHa/ba32BgGPjr
DR7OPk+lR2FArLTbzJa9I0KYmPdrKi6KNE0loghDcnLXySLHCStwahKwg7BZ+/US
o5hgWMaeeNw9NuuscNYmHryKzKMAhGjtEE5wWJfdpyyOsqyiohCI/Mx0jKSOysGW
mhgOynT2Tnq8sOPYg3vbIjYECabONecL1Q79TeJGVV5e879B3nTkZVAgV6cX5xP5
6rZK7XWdqSaR/RxNulPl3wy+eJIEWI1D4j4ogbGfm0xWNmqr1TI=
=aokD
-----END PGP SIGNATURE-----

--yO3YVrUfbWxrxaQH--

