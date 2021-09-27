Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1BC241965D
	for <lists+bpf@lfdr.de>; Mon, 27 Sep 2021 16:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234915AbhI0O33 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Sep 2021 10:29:29 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:47097 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234897AbhI0O32 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Sep 2021 10:29:28 -0400
Received: by mail-wm1-f46.google.com with SMTP id d207-20020a1c1dd8000000b00307e2d1ec1aso129253wmd.5
        for <bpf@vger.kernel.org>; Mon, 27 Sep 2021 07:27:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=Pe0awKWgrzGEU37bwSACZiQEX9nVLxNlTGyH8Js6TmM=;
        b=50XCBx7k1vAiT/iN2FGa88BAi17cF05TKEnRn9aymSmnXBEnJ+RRxsmOV9OKL1ShYd
         DK8vBoXUJLuX1coTvDjE44mBRa5j1lhEPX5f9IXxxbVef/XAlRunP58PLPPjrfLZ6W6U
         3eE2BNzd+ewqZMUIb40V5vH36uTDaemRqyyrvQHBknGechERFLq2IEU8LH9vpknpfxtz
         n2FRhRfcQT3ZRoG6SiEgznAA2ENKZKl+QweQRTLn/4FtJYCnPpxmLyckF10wDNCRpJGr
         nOUpFHL/r6Yda9GI2IOrfr0dXfBYt4zxKRsk5JqyV4hw5RKq8luMznjv6pqKiFW93ZtD
         9DKw==
X-Gm-Message-State: AOAM533sViCL3TQNED6Yc16HDUzOqn6mnhWwEVhnsM8YUwAJYHNPMSJT
        ld3w3BNY89VJtSN7XTsjJ+8oLT0xTU0=
X-Google-Smtp-Source: ABdhPJzd4iu7RiXY65yGzXjkvUPpj9yyDMA44FDdcppzaTudnAKUSS6uz9aYEaF7PPI7hH3WV/pvuA==
X-Received: by 2002:a1c:f405:: with SMTP id z5mr15615332wma.33.1632752869040;
        Mon, 27 Sep 2021 07:27:49 -0700 (PDT)
Received: from localhost ([137.220.125.106])
        by smtp.gmail.com with ESMTPSA id k11sm7450551wrn.84.2021.09.27.07.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 07:27:48 -0700 (PDT)
Message-ID: <57d977a0dcfae6aefafac398ded80d41980e5a36.camel@debian.org>
Subject: Re: [PATCH] samples/bpf: relicense bpf_insn.h as GPL-2.0-only OR
 BSD-2-Clause
From:   Luca Boccassi <bluca@debian.org>
To:     bpf@vger.kernel.org
Cc:     josef@toxicpanda.com
Date:   Mon, 27 Sep 2021 15:27:46 +0100
In-Reply-To: <20210923000540.47344-1-luca.boccassi@gmail.com>
References: <20210923000540.47344-1-luca.boccassi@gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-I78k6dBpy646eSI+U2Bd"
User-Agent: Evolution 3.38.3-1+plugin 
MIME-Version: 1.0
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--=-I78k6dBpy646eSI+U2Bd
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

CC'ing Josef with a different address as requested.

--=20
Kind regards,
Luca Boccassi

--=-I78k6dBpy646eSI+U2Bd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCSqx93EIPGOymuRKGv37813JB4FAmFR1OIACgkQKGv37813
JB4BHBAAqBEufW50aqWCTSmJmHhtlro8YUzzV5eANs/ex9A0dLuGcVLDGDyZ1CMP
SGPGV383aN38u73wBbtbnl/I7TRZa1CIegulr3YAfMyoIZb0LeY+kpv6pfGeKGmj
jCzgiOLW2GTe7Jh2LQPuuG2a7f6jzBjK7E+XxF1aAQpkK2WIRm7ArDM+Y2LiZhqI
6uWZfx114AZZkO7UAE2jffHXXUbbb88dG+3vuOItaFNs48+65oqH+jKnPFdDuiTZ
RogEEOOVZV7cosJyj62wxgyOZJfl3xvFgZOmp8p3YDejMD0W98n3y7qlEcv2SF04
Y9c3zPLds93xXBXvUkswc24VxlamZnRi5FrP35bz2BMJ8UQMe3K4Six5A0eycafI
n0+qZ2jJ+3mELafsZOWGqH3/u6K6G48JtN5okyn2FU17LUrNgh/yp41qVBosfxd9
IeKJivKtNOHE6YYzUlAG0NmMh320oLwHuKOvEmkZtiHeDfGQ94fCixnfmCca2ArM
J3ulSRQ09wzfbJdubI15lb2wdLqhwtVQyqOYs5iZJmG5hp4NNLmtxe4u56bZs+qO
9mD8XNMdDZ3naLPKWPmJrzUlUX34cEB7S3tdWJJS5ur8HeJAPX3N+We+Nb/x7RWT
unFMzh84QXZPwcbgqU3fxSTYn33Vffc3tLeaT7+tOdUrzqEdOnA=
=vPro
-----END PGP SIGNATURE-----

--=-I78k6dBpy646eSI+U2Bd--
