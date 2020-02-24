Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89AAD16B7D8
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2020 03:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgBYC4V (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Feb 2020 21:56:21 -0500
Received: from 14.mo1.mail-out.ovh.net ([178.32.97.215]:57312 "EHLO
        14.mo1.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728725AbgBYC4V (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Feb 2020 21:56:21 -0500
X-Greylist: delayed 25200 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Feb 2020 21:56:20 EST
Received: from player750.ha.ovh.net (unknown [10.110.103.121])
        by mo1.mail-out.ovh.net (Postfix) with ESMTP id 8D4191AF98F
        for <bpf@vger.kernel.org>; Mon, 24 Feb 2020 20:50:42 +0100 (CET)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player750.ha.ovh.net (Postfix) with ESMTPSA id 1EF42FACCA95;
        Mon, 24 Feb 2020 19:50:30 +0000 (UTC)
Date:   Mon, 24 Feb 2020 20:50:28 +0100
From:   Stephen Kitt <steve@sk2.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] docs: sysctl/kernel: document BPF entries
Message-ID: <20200224205028.0f283991@heffalump.sk2.org>
In-Reply-To: <CAADnVQ+QNxFk97fnsY1NL1PQWykdok_ha_KajCc68bRT1BLp2A@mail.gmail.com>
References: <20200221165801.32687-1-steve@sk2.org>
        <CAADnVQ+QNxFk97fnsY1NL1PQWykdok_ha_KajCc68bRT1BLp2A@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/lBH_=silp1qlYcgdNQGqEQU"; protocol="application/pgp-signature"
X-Ovh-Tracer-Id: 2959427907037646189
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrledtgddufedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtsehgtderreertdejnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeehtddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehsthgvvhgvsehskhdvrdhorhhgpdhrtghpthhtohepsghpfhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

--Sig_/lBH_=silp1qlYcgdNQGqEQU
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 23 Feb 2020 14:44:31 -0800, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Fri, Feb 21, 2020 at 10:18 AM Stephen Kitt <steve@sk2.org> wrote:
> > @@ -1152,6 +1166,16 @@ NMI switch that most IA32 servers have fires
> > unknown NMI up, for example.  If a system hangs up, try pressing the NMI
> > switch.
> >
> >
> > +unprivileged_bpf_disabled
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > +
> > +Writing 1 to this entry will disabled unprivileged calls to ``bpf()``;=
 =20
>=20
> 'will disable' ?

Indeed, thanks.

> It doesn't apply to bpf-next with:
> error: sha1 information is lacking or useless
> (Documentation/admin-guide/sysctl/kernel.rst).
> error: could not build fake ancestor
> Patch failed at 0001 docs: sysctl/kernel: Document BPF entries

Sorry, I forgot to include the base commit information; this is against
8f21f54b8a95 in docs-next.

I=E2=80=99ll wait for that to make it to Linus=E2=80=99 tree and re-submit =
the patch (with
the fix above).

Regards,

Stephen

--Sig_/lBH_=silp1qlYcgdNQGqEQU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEnPVX/hPLkMoq7x0ggNMC9Yhtg5wFAl5UKQQACgkQgNMC9Yht
g5z5EQ//Zl8bjwdpgTF5kG/EpgkAQyDPj7ywh5fddVbS3m15ur7ePYWp10JF0wCv
mNfX6fRXoR9sVaixAR1Zh6fwGO2Ys1g3V2EwBnyVzk3Sge6vaKg39wjT/YudiIEW
JquM/F4XNz7OwbR2jadEVYhbasg9RJPzGqDJyU3rHtSBGcOxc7ceqrH1P0udmyfE
dfLlq+u/KMyGxbFtJDxeHNMa3RRgs2ga9HxYosOzNCoL4p01oR3WGMaUjheXhCL8
QtzzVU2fljAi7lkSt+SI/jt+eYvgc+oUKxe1iPPcoFnUBxbGaDaVg+fHMlioCQ/n
08NquweGb6QGf7HYi/6NIlwRbcLSxUBTnKeGMpnYaC1SQxSTASw+cNT2hiZTcDqj
L8jn937vcR/mQWK/gPepVzpRMxYO0iQhNX32+aada1iolz+58BLvlHa3wdqTPR+/
SFaSbtde1GJMqJubqYLVGRswKQzsPuMZ0djWKiPyEx+BP4clIQnNCB00OyfAvb6j
SqbUwnPsDboBoPxrcyMQ213YVd1M69NwhwWaAD+N7U7ArFd1wU0yQ1J0Mowxae9W
jy89cdKGt00IZn6d7rDazAScN8lPC5N4o+5FTlqdoOoOVwE31LRWu8kcKT6uDfJ5
TJRE+jDZ5Ux4ByABc5l+yFkmVRb+J/ivBgeh2wKUy3CtRxJaf/E=
=TJvz
-----END PGP SIGNATURE-----

--Sig_/lBH_=silp1qlYcgdNQGqEQU--
