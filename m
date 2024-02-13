Return-Path: <bpf+bounces-21893-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9882853C76
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 21:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDD5C1C22806
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 20:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA0162172;
	Tue, 13 Feb 2024 20:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="OVfsxu8f"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880225FF03;
	Tue, 13 Feb 2024 20:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707857552; cv=none; b=YrSu86UddSUFpplDwL8zckC8Cgiw0UZUZTNbLoZztDtFOI5rb4gZWBe9YcM6gb1TfjMEuUFj8NwJuXaP+bdNkrsnfXQEsNsb1VadVOCXHqrkn8NYhHdjSidO2S3bEId//uNhZth5ZsgwkBq2HLkgKRjZEbuukqLICYJSzsbeavo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707857552; c=relaxed/simple;
	bh=64I1TgtHDDIt6/p7AHX6u2hXP67VwmvVIRlSAqFWpzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lffe9PcQ4Ab37s2gsy6gTOacuhpWWo/jmNXEZbp55j4RPXQLzy6IDFWU4cE8R8rcZiTSe4Xjye8T670bORy64rUUI2JHKVTEoPeLe7OBBKojATWlWKiJ+GalqFYosL+3rHUpsPwAfgfjjTgAaop3LHKCUv7DwfHxbJwQuKNwFj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu; spf=pass smtp.mailfrom=fjasle.eu; dkim=pass (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b=OVfsxu8f; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fjasle.eu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fjasle.eu;
	s=ds202307; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=AynPBu8jS0YBZE5dCSOc1gqeyaauXcsGk9RK7JNo4+E=; b=OVfsxu8fyN677OC6MCjrWC9Msm
	YgE2jZ+MuT/ObdYNvqwDd6jNqdDDlQOn2T90JuFIa7XQrz7hc5Wnv4DiXOa1s+XDGZMYwxV6TAOzl
	+7beOSD+8xCsjHSh3NqSEBumSecmG3el6PHcJOQs5kdxdUqPtSgqgyIqTTIRF+galECY/WVS1zOYs
	hDliJrLgHjS0DluetlyEa26cfpoEc4hNyACTh02TGjewGvA6tuJ22l6h2hcxuFSEy8pRjvXfAulb5
	WJT9oRkUsCJsnsAQ0oInuuKqbQTsvj1fPwW6g9q3/vgI+2w8htu+kUvHX6WZKk//xtPYkA8LX0n7m
	z1HvapMA==;
Received: from [2001:9e8:9d1:8401:6f0:21ff:fe91:394] (port=36842 helo=bergen.fjasle.eu)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <nicolas@fjasle.eu>)
	id 1rZzlN-00HT8U-CK;
	Tue, 13 Feb 2024 21:52:21 +0100
Date: Tue, 13 Feb 2024 21:52:14 +0100
From: Nicolas Schier <nicolas@fjasle.eu>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, ndesaulniers@google.com,
	morbo@google.com, justinstitt@google.com, keescook@chromium.org,
	maskray@google.com, linux-kbuild@vger.kernel.org,
	bpf@vger.kernel.org, llvm@lists.linux.dev, patches@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] kbuild: Fix changing ELF file type for output of
 gen_btf for big endian
Message-ID: <ZcvWfsv1ohV5qHSI@bergen.fjasle.eu>
References: <20240212-fix-elf-type-btf-vmlinux-bin-o-big-endian-v2-1-22c0a6352069@kernel.org>
 <CAK7LNATK=8V+BroyN+uo9OynkfR6s6HtRgh=LF7yan7cPkbaTA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="k3DOEzKl6wHMV12g"
Content-Disposition: inline
In-Reply-To: <CAK7LNATK=8V+BroyN+uo9OynkfR6s6HtRgh=LF7yan7cPkbaTA@mail.gmail.com>
X-Operating-System: Debian GNU/Linux trixie/sid
Jabber-ID: nicolas@jabber.no


--k3DOEzKl6wHMV12g
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 13 Feb 2024 11:15:40 GMT, Masahiro Yamada wrote:
> On Tue, Feb 13, 2024 at 11:06=E2=80=AFAM Nathan Chancellor=20
> <nathan@kernel.org> wrote:
> >
> > Commit 90ceddcb4950 ("bpf: Support llvm-objcopy for vmlinux BTF")
> > changed the ELF type of .btf.vmlinux.bin.o to ET_REL via dd, which works
> > fine for little endian platforms:
> >
> >    00000000  7f 45 4c 46 02 01 01 00  00 00 00 00 00 00 00 00  |.ELF...=
=2E........|
> >   -00000010  03 00 b7 00 01 00 00 00  00 00 00 80 00 80 ff ff  |.......=
=2E........|
> >   +00000010  01 00 b7 00 01 00 00 00  00 00 00 80 00 80 ff ff  |.......=
=2E........|
> >
> > However, for big endian platforms, it changes the wrong byte, resulting
> > in an invalid ELF file type, which ld.lld rejects:
> >
> >    00000000  7f 45 4c 46 02 02 01 00  00 00 00 00 00 00 00 00  |.ELF...=
=2E........|
> >   -00000010  00 03 00 16 00 00 00 01  00 00 00 00 00 10 00 00  |.......=
=2E........|
> >   +00000010  01 03 00 16 00 00 00 01  00 00 00 00 00 10 00 00  |.......=
=2E........|
> >
> >   Type:                              <unknown>: 103
> >
> >   ld.lld: error: .btf.vmlinux.bin.o: unknown file type
> >
> > Fix this by updating the entire 16-bit e_type field rather than just a
> > single byte, so that everything works correctly for all platforms and
> > linkers.
> >
> >    00000000  7f 45 4c 46 02 02 01 00  00 00 00 00 00 00 00 00  |.ELF...=
=2E........|
> >   -00000010  00 03 00 16 00 00 00 01  00 00 00 00 00 10 00 00  |.......=
=2E........|
> >   +00000010  00 01 00 16 00 00 00 01  00 00 00 00 00 10 00 00  |.......=
=2E........|
> >
> >   Type:                              REL (Relocatable file)
> >
> > While in the area, update the comment to mention that binutils 2.35+
> > matches LLD's behavior of rejecting an ET_EXEC input, which occurred
> > after the comment was added.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 90ceddcb4950 ("bpf: Support llvm-objcopy for vmlinux BTF")
> > Link: https://github.com/llvm/llvm-project/pull/75643
> > Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
>=20
>=20
> Thanks.
>=20
> I will wait for a few days until
> the reviewers come back to give Reviewed-by again.

thanks, v2 looks even better.

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

> > ---
> > Changes in v2:
> > - Rather than change the seek value for dd, update the entire e_type
> >   field (Masahiro). Due to this change, I did not carry forward the
> >   tags of v1.
> > - Slightly update commit message to remove mention of ET_EXEC, which
> >   does not match the dump (Masahiro).
> > - Update comment to mention binutils 2.35+ has the same behavior as LLD
> >   (Fangrui).
> > - Link to v1: https://lore.kernel.org/r/20240208-fix-elf-type-btf-vmlin=
ux-bin-o-big-endian-v1-1-cb3112491edc@kernel.org
> > ---
> >  scripts/link-vmlinux.sh | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> > index a432b171be82..7862a8101747 100755
> > --- a/scripts/link-vmlinux.sh
> > +++ b/scripts/link-vmlinux.sh
> > @@ -135,8 +135,13 @@ gen_btf()
> >         ${OBJCOPY} --only-section=3D.BTF --set-section-flags .BTF=3Dall=
oc,readonly \
> >                 --strip-all ${1} ${2} 2>/dev/null
> >         # Change e_type to ET_REL so that it can be used to link final =
vmlinux.
> > -       # Unlike GNU ld, lld does not allow an ET_EXEC input.
> > -       printf '\1' | dd of=3D${2} conv=3Dnotrunc bs=3D1 seek=3D16 stat=
us=3Dnone
> > +       # GNU ld 2.35+ and lld do not allow an ET_EXEC input.
> > +       if is_enabled CONFIG_CPU_BIG_ENDIAN; then
> > +               et_rel=3D'\0\1'
> > +       else
> > +               et_rel=3D'\1\0'
> > +       fi
> > +       printf "${et_rel}" | dd of=3D${2} conv=3Dnotrunc bs=3D1 seek=3D=
16 status=3Dnone
> >  }
> >
> >  # Create ${2} .S file with all symbols from the ${1} object file
> >
> > ---
> > base-commit: 54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478
> > change-id: 20240208-fix-elf-type-btf-vmlinux-bin-o-big-endian-dbc55a1e1=
296
> >
> > Best regards,
> > --
> > Nathan Chancellor <nathan@kernel.org>
> >
> >
>=20
>=20
> --=20
> Best Regards
> Masahiro Yamada

--k3DOEzKl6wHMV12g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmXL1nkACgkQB1IKcBYm
EmknARAA2E4GEywHnpFzwMKgFe11O30rRL3/W2ji1MkLji9oI5NquTUJZ6Qw/9Nc
LT69QvkdpCrRX+zpqqI+hCV5CsyXzUKbOmcd0FQ3F6jxB35QM4ko1sYLJBcw3Xau
waRdyD0agJ3IbcF85/f3xIvUk33Qhm55yMzLx/IZl7YKwI3/E4iO3JSWY1IfijMo
l9fWpu7ZOSHrbglfgONr3GPt9vLwVBP5hXxwbkbR9r2VRL8Mc5oHHFMJYcY4y3bF
wQVT7Fsz++dgnxD8VoyBBtVWrmrFx9pc/3sGbgK6tECwuVKd4ZzeGi0uRaB94Shy
AoigytM4RQo8CxDhI3E952P1IYStX3yitI6hVcYcpOK6rOikKqwc9SZvmOyNbleY
mUkeddNa3TA90BIJ1TdG+SFWdpfbx1R516pkagHLkt89jYq4uvb5pDs4QO65umxN
D0OMvKaRBpPZNmy90557DA4s0BOhs6DZWmCGWR/nsz7h5zPHi7kDVwH4I7M+1VI6
L2hQXFIYWvY17HAXHXyULgefp4bEhnvCCAzckkf6edpVdzloBhYWkzoGQn9eoERP
NT9cRMElIP5s7ejDDaB5fwog6K5oNg6Wjbce2aV0Kpb8QTx2pDT1aw2Ml+RUm83N
kiAoHupA7gVA1dio5hG1x7KZDHwK6CfhzhPFGnfFa0wNs7iWqmU=
=ghs2
-----END PGP SIGNATURE-----

--k3DOEzKl6wHMV12g--

