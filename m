Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9109B180CCD
	for <lists+bpf@lfdr.de>; Wed, 11 Mar 2020 01:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbgCKA04 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Mar 2020 20:26:56 -0400
Received: from 16.mo5.mail-out.ovh.net ([87.98.174.144]:44638 "EHLO
        16.mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbgCKA04 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Mar 2020 20:26:56 -0400
X-Greylist: delayed 8973 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Mar 2020 20:26:53 EDT
Received: from player759.ha.ovh.net (unknown [10.110.208.144])
        by mo5.mail-out.ovh.net (Postfix) with ESMTP id A1AFF27100A
        for <bpf@vger.kernel.org>; Tue, 10 Mar 2020 22:57:18 +0100 (CET)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player759.ha.ovh.net (Postfix) with ESMTPSA id 5878B104D32F2;
        Tue, 10 Mar 2020 21:57:05 +0000 (UTC)
Date:   Tue, 10 Mar 2020 22:57:02 +0100
From:   Stephen Kitt <steve@sk2.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] docs: sysctl/kernel: document BPF entries
Message-ID: <20200310225702.2da4519c@heffalump.sk2.org>
In-Reply-To: <CAADnVQJ0EephJiY8F5KJFbYPBg2=hTHOi3WOUtVFE=qgoVbSuA@mail.gmail.com>
References: <20200309180350.21075-1-steve@sk2.org>
        <CAADnVQJ0EephJiY8F5KJFbYPBg2=hTHOi3WOUtVFE=qgoVbSuA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/O4H7GWQKOH1ilLfxU.Pj.YK"; protocol="application/pgp-signature"
X-Ovh-Tracer-Id: 954200173656165741
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedruddvtddgudegiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgesghdtreerredtvdenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrieehrddvhedrvddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejheelrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdprhgtphhtthhopegsphhfsehvghgvrhdrkhgvrhhnvghlrdhorhhg
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

--Sig_/O4H7GWQKOH1ilLfxU.Pj.YK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Mar 2020 10:47:15 -0700, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:

> On Mon, Mar 9, 2020 at 11:05 AM Stephen Kitt <steve@sk2.org> wrote:
> >
> > Based on the implementation in kernel/bpf/syscall.c,
> > kernel/bpf/trampoline.c, include/linux/filter.h, and the documentation
> > in bpftool-prog.rst.
> >
> > The section style doesn't match the surrounding sections; it matches
> > the style of the reworked kernel.rst queued up in docs-next.
> >
> > Signed-off-by: Stephen Kitt <steve@sk2.org>
> > ---
> >
> > Notes:
> >     Changes since v1:
> >     - rebased on bpf-next instead of docs-next.
> >
> >  Documentation/admin-guide/sysctl/kernel.rst | 24 +++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >
> > diff --git a/Documentation/admin-guide/sysctl/kernel.rst
> > b/Documentation/admin-guide/sysctl/kernel.rst index
> > def074807cee..eea7afd509ac 100644 ---
> > a/Documentation/admin-guide/sysctl/kernel.rst +++
> > b/Documentation/admin-guide/sysctl/kernel.rst @@ -174,6 +174,20 @@ See
> > the type_of_loader and ext_loader_ver fields in
> > Documentation/x86/boot.rst for additional information.
> >
> >
> > +bpf_stats_enabled
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Controls whether the kernel should collect statistics on BPF programs
> > +(total time spent running, number of times run...). Enabling
> > +statistics causes a slight reduction in performance on each program
> > +run. The statistics can be seen using ``bpftool``.
> > +
> > +=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +0 Don't collect statistics (default).
> > +1 Collect statistics.
> > +=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +
> >  cap_last_cap:
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > @@ -1123,6 +1137,16 @@ NMI switch that most IA32 servers have fires
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
> same typo as was pointed out earlier.

Oh dear, sorry about that, v3 is on its way :-(.

Regards,

Stephen

--Sig_/O4H7GWQKOH1ilLfxU.Pj.YK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEnPVX/hPLkMoq7x0ggNMC9Yhtg5wFAl5oDS4ACgkQgNMC9Yht
g5wY9hAAk12F/rXYyveXRZ0+57xIPIGL2rBRZOEF8WxN8lEbpREk35+vufvy4p0l
cxnAPh/aIcZA9dkxZOA1prAK+B6Q2tIvCKXLWOhr5WW3C31hEDfPfbqr9PvPp9DJ
m1JorpMHFdiwYOymrTBg+Xgm8I/4F6InRlnHchNAMw/kronscoCFC7sh6yJiXRrr
gyEV7tA5IQm4rGzCwxOIyU3IqeKvNOyeh41aor4YcjL7Y3l+WB7XV2XieVP7zX1Z
OwvrFGWKJGz+rj3A4i5JLZchFfnwuA3jVS80QbyfpMNuS/ICWGoDCYw3K5mqvwce
00Ur1+UCAH41PIT8If0yF7/hDzyr/X8ZHcdvjoObOqTJ33rjxJWEnezzlXqNUwiz
qhmVNaJ3TUmSkGpMlu0ATEzoj0yvgeuXtoq9DjrXaZ+BKWsMgnUaE3+7jMlbuUIJ
hMD/0Fk+d8x4dTUUIyIkHvSFrJq5TEtWYsTlIWpP0KvLLf3Uf+11/Ve4vtPsHsVC
qyOMa9arCvV82yjRzvR2m74+ld1zBk7lH0r+X6mLnX4iJd6MNLY79UCUZ0ACTWME
xQQ7kENBvARy+UHwkwNpv4ybd1P+1I6hZu+NKvV+ZWkXvqGsr71v0N1nEgbd+ZSV
kadnjSZlyoMP546no7de7kvl2iAqB1UDeD2L26W5zHCRjprStlA=
=6Whk
-----END PGP SIGNATURE-----

--Sig_/O4H7GWQKOH1ilLfxU.Pj.YK--
