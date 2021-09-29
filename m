Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B336141C9A9
	for <lists+bpf@lfdr.de>; Wed, 29 Sep 2021 18:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345121AbhI2QIs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Sep 2021 12:08:48 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:33725 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346360AbhI2QI3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Sep 2021 12:08:29 -0400
Received: by mail-wr1-f44.google.com with SMTP id t18so5260640wrb.0
        for <bpf@vger.kernel.org>; Wed, 29 Sep 2021 09:06:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=rgvI6kpnbp+4kyrVbxzC4brS5TMJKQkBVDyPJnhH13c=;
        b=wcDzYe0wilZ4YvVd4espUE85fdzV8IlIzMEPficG+iMPLjY1nv3nMO22cqi7odYi6Z
         CLOZdSuwuQtvn/R2b/JnGagaZL9+zxHMPhHNMharHbpbbvbn7b7ed5LLfYabEXRk8Qkg
         +OkP/QNvERJs+wBZmtWbz4sHAemK6hsf6LOh1yapoPw0dVMkmYpQjATCsIjMbEm/Pekv
         VKIXtmJSflkZXI7oHNq+mn2SCrivaPdgP930Oh1Lhb5LNn59TH/26OCJVeSvPf295Cbr
         6bcBt29C1GDUk1g8iZtTstBurS3Qgl4mFbH4YNVtqfS2cFyC8pPbVvZTDe1+pBmOOHmx
         X6LA==
X-Gm-Message-State: AOAM533c1s5Olfcq5QX+SVRTnZ+FwZvHD98aGYkWB11wr7vFUydK/HgO
        /aPE7ro1Wl8Uw3eUdi1Dv/pHfAxzHOU=
X-Google-Smtp-Source: ABdhPJyw2ErlVILZLkKkqAoK5NSlKxXyZUMPV2zzNBBItDND5h4H4TF2rKAnaPpglttrpiQ+T2C8LA==
X-Received: by 2002:a05:6000:1192:: with SMTP id g18mr771787wrx.63.1632931607550;
        Wed, 29 Sep 2021 09:06:47 -0700 (PDT)
Received: from localhost ([2a01:4b00:f41a:3600:360b:9754:2e3a:c344])
        by smtp.gmail.com with ESMTPSA id o17sm308250wrj.96.2021.09.29.09.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 09:06:46 -0700 (PDT)
Message-ID: <97ba65d49171c1a4eee34722d79b60e5732ce441.camel@debian.org>
Subject: Re: [PATCH] samples/bpf: relicense bpf_insn.h as GPL-2.0-only OR
 BSD-2-Clause
From:   Luca Boccassi <bluca@debian.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 29 Sep 2021 17:06:45 +0100
In-Reply-To: <20210923000540.47344-1-luca.boccassi@gmail.com>
References: <20210923000540.47344-1-luca.boccassi@gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-5eDcg0qgApBN2L6k4jLU"
User-Agent: Evolution 3.38.3-1+plugin 
MIME-Version: 1.0
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--=-5eDcg0qgApBN2L6k4jLU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2021-09-23 at 01:05 +0100, luca.boccassi@gmail.com wrote:
> From: Luca Boccassi <bluca@debian.org>
>=20
> libbpf and bpftool have been dual-licensed to facilitate inclusion in
> software that is not compatible with GPL2-only (ie: Apache2), but the
> samples are still GPL2-only.
>=20
> Given these files are samples, they get naturally copied around. For exam=
ple
> it is the case for samples/bpf/bpf_insn.h which was copied into the syste=
md
> tree: https://github.com/systemd/systemd/blob/main/src/shared/linux/bpf_i=
nsn.h
>=20
> Dual-license this header as GPL-2.0-only OR BSD-2-Clause to follow
> the same licensing used by libbpf and bpftool:
>=20
> 1bc38b8ff6cc ("libbpf: relicense libbpf as LGPL-2.1 OR BSD-2-Clause")
> 907b22365115 ("tools: bpftool: dual license all files")
>=20
> Signed-off-by: Luca Boccassi <bluca@debian.org>
> ---
> Most of systemd is (L)GPL2-or-later, which means there is no perceived
> incompatibility with Apache2 softwares and can thus be linked with
> OpenSSL 3.0. But given this GPL2-only header is included this is currentl=
y
> not possible.
> Dual-licensing this header solves this problem for us as we are scoping
> moving to OpenSSL 3.0, see:
>=20
> https://lists.freedesktop.org/archives/systemd-devel/2021-September/04688=
2.html
>=20
> The authors of this file according to git log are:
>=20
> Alexei Starovoitov <ast@kernel.org>
> Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>
> Brendan Jackman <jackmanb@google.com>
> Chenbo Feng <fengc@google.com>
> Daniel Borkmann <daniel@iogearbox.net>
> Daniel Mack <daniel@zonque.org>
> Jakub Kicinski <jakub.kicinski@netronome.com>
> Jiong Wang <jiong.wang@netronome.com>
> Joe Stringer <joe@ovn.org>
> Josef Bacik <jbacik@fb.com>
>=20
> (excludes a commit adding the SPDX header)
>=20
> All authors and maintainers are CC'ed. An Acked-by from everyone in the
> above list of authors will be necessary.
>=20
> One could probably argue for relicensing all the samples/bpf/ files given=
 both
> libbpf and bpftool are, however the authors list would be much larger and=
 thus
> it would be much more difficult, so I'd really appreciate if this header =
could
> be handled first by itself, as it solves a real license incompatibility i=
ssue
> we are currently facing.
>=20
> =C2=A0samples/bpf/bpf_insn.h | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/samples/bpf/bpf_insn.h b/samples/bpf/bpf_insn.h
> index aee04534483a..29c3bb6ad1cd 100644
> --- a/samples/bpf/bpf_insn.h
> +++ b/samples/bpf/bpf_insn.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> =C2=A0/* eBPF instruction mini library */
> =C2=A0#ifndef __BPF_INSN_H
> =C2=A0#define __BPF_INSN_H

Hello Alexei and Daniel,

We got the following acks so far:

Acked-by: Brendan Jackman <jackmanb@google.com>
Acked-by: Chenbo Feng <fengc@google.com>
Acked-by: Joe Stringer <joe@ovn.org>
Acked-by: Simon Horman <simon.horman@corigine.com>
Acked-by: Daniel Mack <daniel@zonque.org>
Acked-by: Josef Bacik <josef@toxicpanda.com>
Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>

Magnus covers Intel's portion, and Simon covers Netronome's portion.

So as far as I understand, only your two acks are missing and then it's
job done and we can go home!

--=20
Kind regards,
Luca Boccassi

--=-5eDcg0qgApBN2L6k4jLU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCSqx93EIPGOymuRKGv37813JB4FAmFUjxUACgkQKGv37813
JB4M9A//VqzDkGMdWW0M8NHrtE+FEDeAM1a/kFEeOumksc7NV7hV1/SUqUCh1yCH
EbrtRwQXcNwtFWFZqO/1GhEQsL3aGpeLlOUt961UM+X7zgQtP9gLQH0A+757b/rL
xKbv2QG2sb8aLq7tY/Vn8EHNVAN2rakPoXsDPW0oJnxAASlvol6W3OkHShPcYVOq
vk5wCjXWLKRv7+SRyf0qCcCoHK1sc1vOBGqY/Ev7++X7t5s9GapDWMiQMwKt+HEx
95QnfCt/llIg9kEfNGTOuhl2b5APWmrnn8joo9eLriCtNrExp8YxwPOFTvHNHphz
mkpyf8cy+YURL99ScUeuX3Qr7pIhxS+PomJ7YQjD9LPckONWhUztvUouG3WtxBWB
UlwPOKTH/96hH6/O23S4qXTfN84aPZaMLEQj6hAL/jbpBDy9AIKnOM9gDy6fuURT
WtbnyVH8flv2ga2WaN2TWNQeKSg93i+/VZPBYeWOs8fUTFJqmOylSUDyIVcUFxIn
JHcNFtKbV2B6lZQ+KksFn//P9ESKwwPreyiWBMknSuuXrBPNM5D9D2O4xLVrlSg3
u67R6SyMMGo6U97WVoHP0xV90VMH6AZG2o3BUeN5gSpft/4mv+MYokCTYLaxFo1b
i3BuOqfQ2okCTkeyWLWH8/jXb8Sm5cxOMlHHDEEth6Pi+BGeSyM=
=vR6D
-----END PGP SIGNATURE-----

--=-5eDcg0qgApBN2L6k4jLU--
