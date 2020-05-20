Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E82D61DAA7F
	for <lists+bpf@lfdr.de>; Wed, 20 May 2020 08:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbgETGTH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 May 2020 02:19:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:55036 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725998AbgETGTH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 May 2020 02:19:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C3567AD45;
        Wed, 20 May 2020 06:19:07 +0000 (UTC)
Date:   Wed, 20 May 2020 16:18:51 +1000
From:   Aleksa Sarai <asarai@suse.de>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kees Cook <keescook@chromium.org>,
        Chris Palmer <palmer@google.com>, Jann Horn <jannh@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Matt Denton <mpdenton@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        bpf <bpf@vger.kernel.org>
Subject: Re: seccomp feature development
Message-ID: <20200520061851.rxxgz2frffqt66q6@yavin.dot.cyphar.com>
References: <202005181120.971232B7B@keescook>
 <CAG48ez1LrQvR2RHD5-ZCEihL4YT1tVgoAJfGYo+M3QukumX=OQ@mail.gmail.com>
 <20200519024846.b6dr5cjojnuetuyb@yavin.dot.cyphar.com>
 <CAADnVQKRCCHRQrNy=V7ue38skb8nKCczScpph2WFv7U_jsS3KQ@mail.gmail.com>
 <20200520012045.5yqejh6kic3gbkyw@yavin.dot.cyphar.com>
 <20200520051703.wh7s2bnpnrqxpk5j@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rn7hnswmzhtvif3b"
Content-Disposition: inline
In-Reply-To: <20200520051703.wh7s2bnpnrqxpk5j@ast-mbp.dhcp.thefacebook.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--rn7hnswmzhtvif3b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-05-19, Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> On Wed, May 20, 2020 at 11:20:45AM +1000, Aleksa Sarai wrote:
> > No it won't become copy_from_user(), nor will there be a TOCTOU race.
> >=20
> > The idea is that seccomp will proactively copy the struct (and
> > recursively any of the struct pointers inside) before the syscall runs
> > -- as this is done by seccomp it doesn't require any copy_from_user()
> > primitives in cBPF. We then run the cBPF filter on the copied struct,
> > just like how cBPF programs currently operate on seccomp_data (how this
> > would be exposed to the cBPF program as part of the seccomp ABI is the
> > topic of discussion here).
> >=20
> > Then, when the actual syscall code runs, the struct will have already
> > been copied and the syscall won't copy it again.
>=20
> Let's take bpf syscall as an example.
> Are you suggesting that all of syscall logic of conditionally parsing
> the arguments will be copy-pasted into seccomp-syscall infra, then
> it will do copy_from_user() all the data and replace all aligned_u64
> in "union bpf_attr" with kernel copied pointers instead of user pointers
> and make all of bpf syscall's copy_from_user() actions to be conditional ?
> If seccomp is on, use kernel pointers... if seccomp is off, do copy_from_=
user ?
> And the same idea will be replicated for all syscalls?

This would be done optionally per-syscall. Only syscalls which want to
opt-in to such a mechanism (such as clone3 and openat2) would be
affected. Also, bpf is possibly the least-friendly syscall to pick as an
example of these types of filters -- openat2/clone3 is much simpler to
consider.

The point is that if we both agree that seccomp needs to have a way to
do "deep argument inspection" (filtering based on the struct argument to
a syscall), then some sort of caching mechanism is simply necessary to
solve the problem. Otherwise there's a trivial TOCTOU and seccomp
filtering for such syscalls would be rendered almost useless.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--rn7hnswmzhtvif3b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEXzbGxhtUYBJKdfWmnhiqJn3bjbQFAl7Ey8kACgkQnhiqJn3b
jbS1aw/+Ke+3XabRAdGNQcKJl07/uM/ddqclXOauVrhWiCSAxWSnWVu97XP7n4Ce
gQq6Da4u3IVhScgvfuR7utNO0uprnaW7Aj4Seb8ioajFA4I5DCWzn1JJHl90et7n
0oonnFE/IQuCwcWfCJ8EVcv6HdLBxpGPXEciCX9qXUyi6ipEAlmaRI1am7SeUFcF
dfc6Nz4azXPMtrTaXlQbwQ4pLHDF1pW+rBa06mgyJlQYgvcmsmxkE3fRxhJxauBX
4sWTYrkVQu0aB3CnSONO5sqfZiZuEf0rGJqF8ETgTYSBBQ5hGT1uuvQYnCz7jtM6
AbTq8BGAMG3Ox/2s/sezHLsWJx2ypoQ34NMSSfRgacBmse56OdHGP8zEDJJRm/OA
RNqpL5ZJ9HWG8H9zor9FTcc4CvvdxUpX326QCL+l3eJrt+Afd++erZyOpfbzZhKH
MKb7aSSmhvy+NgVpZpjj8CF3mzYdAlTFVldgXRa5rvKwshz75+8uA9dCZa7MidDQ
Vmw4vIkdcWXY8c5VABuKw0p4Z41OCV15eKBDzK4e6fR4HDTM8QHe6X4sk8f3cR9F
4P5JEuO6YOfXuDGClgc0Nb89IqtwBB61EJyt/LZbwIcu4A6htR2lTsxlSJfqWHCz
Z3haeWiCQoaPN9Sgt/NXhPOn+MYJq/xqle4SAHCzKC+YdjWyvrQ=
=Iji/
-----END PGP SIGNATURE-----

--rn7hnswmzhtvif3b--
