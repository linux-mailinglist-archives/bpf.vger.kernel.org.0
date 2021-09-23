Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F51C415C1C
	for <lists+bpf@lfdr.de>; Thu, 23 Sep 2021 12:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbhIWKm6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Sep 2021 06:42:58 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:45885 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240314AbhIWKm6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Sep 2021 06:42:58 -0400
Received: by mail-wr1-f52.google.com with SMTP id d21so15720513wra.12
        for <bpf@vger.kernel.org>; Thu, 23 Sep 2021 03:41:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=sQG19A41x7JPrHAz0h7xfaVhm2EGEKQxcIpIk6kWTdI=;
        b=3wVr/bY3EAwZXhq8qdmm+CKecDwzojP6GgpX39hn8FqLBnsHIY9nqq+nmP4zUzSFYD
         61m0u2+fGmO6jM6/Vx4ubtW75nblNDtarzXQ3g6Q3t61fDF5OTAkv12s8D1jrY3FcBWm
         BhR0+i7u6/LHGjfaRo8fKne71v6mmV5iZDT2VsinzkTf+/TyGCuAs25/3eOnOab4uhNf
         OB6bguc2bELbTahKzuXRkS4QbTEv6knCZO8HxHnofIM1a53R/SrmQY5xuEF2aicx6+vG
         irfqGD3XsVJnYyayVHKfY20s/lbowzU4zVCPM1b3gGkitqUJkiF68R+LlzvmWs6zEbeT
         /KwA==
X-Gm-Message-State: AOAM532QSJ3baJD2v+yrr8/Pd8nhPbHPw0R3dC0vd4rU560uyyLhAnpC
        TEnE3Kx9Ry69j7rDaz3G+FC65rm1x5I=
X-Google-Smtp-Source: ABdhPJyfUOWQ6zQ3phVJ1CxmGojbjoskphLMVj/UEU9aI5OquL/AFS2MlhoDvphERL3l8xuv8ytCww==
X-Received: by 2002:a7b:cc96:: with SMTP id p22mr15247597wma.67.1632393685906;
        Thu, 23 Sep 2021 03:41:25 -0700 (PDT)
Received: from localhost ([2a01:4b00:f41a:3600:df86:cebc:8870:2184])
        by smtp.gmail.com with ESMTPSA id y8sm4869374wrh.44.2021.09.23.03.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 03:41:24 -0700 (PDT)
Message-ID: <49c54bf3f4a95562592575062058f069654fd253.camel@debian.org>
Subject: Re: [PATCH] samples/bpf: relicense bpf_insn.h as GPL-2.0-only OR
 BSD-2-Clause
From:   Luca Boccassi <bluca@debian.org>
To:     bpf@vger.kernel.org
Cc:     bjorn@kernel.org, kuba@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, daniel@zonque.org, joe@ovn.org, jbacik@fb.com
Date:   Thu, 23 Sep 2021 11:41:20 +0100
In-Reply-To: <20210923000540.47344-1-luca.boccassi@gmail.com>
References: <20210923000540.47344-1-luca.boccassi@gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-EwuGTsVw/o5OifbOfDbW"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--=-EwuGTsVw/o5OifbOfDbW
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2021-09-23 at 01:05 +0100, luca.boccassi@gmail.com wrote:
> From: Luca Boccassi <bluca@debian.org>
>=20
> libbpf and bpftool have been dual-licensed to facilitate inclusion in
> software that is not compatible with GPL2-only (ie: Apache2), but the
> samples are still GPL2-only.
>=20
> Given these files are samples, they get naturally copied around. For
> example
> it is the case for samples/bpf/bpf_insn.h which was copied into the
> systemd
> tree:
> https://github.com/systemd/systemd/blob/main/src/shared/linux/bpf_insn.h
>=20
> Dual-license this header as GPL-2.0-only OR BSD-2-Clause to follow
> the same licensing used by libbpf and bpftool:
>=20
> 1bc38b8ff6cc ("libbpf: relicense libbpf as LGPL-2.1 OR BSD-2-Clause")
> 907b22365115 ("tools: bpftool: dual license all files")
>=20
> Signed-off-by: Luca Boccassi <bluca@debian.org>
> ---
> Most of systemd is (L)GPL2-or-later, which means there is no
> perceived
> incompatibility with Apache2 softwares and can thus be linked with
> OpenSSL 3.0. But given this GPL2-only header is included this is
> currently
> not possible.
> Dual-licensing this header solves this problem for us as we are
> scoping
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
> All authors and maintainers are CC'ed. An Acked-by from everyone in
> the
> above list of authors will be necessary.
>=20
> One could probably argue for relicensing all the samples/bpf/ files
> given both
> libbpf and bpftool are, however the authors list would be much larger
> and thus
> it would be much more difficult, so I'd really appreciate if this
> header could
> be handled first by itself, as it solves a real license
> incompatibility issue
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

Got "address not found" for the following:

Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>
Jakub Kicinski <jakub.kicinski@netronome.com>
Jiong Wang <jiong.wang@netronome.com>

Trying again with different aliases from more recent commits for Bj=C3=B6rn
and Jakub.

I cannot find other commits from Jiong with a different email address -
Jakub, do you happen to know how we can reach Jiong? Perhaps it's not
necessary as it's Netronome that owns the copyright and thus your ack
would cover both contributions?

--=20
Kind regards,
Luca Boccassi

--=-EwuGTsVw/o5OifbOfDbW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEE6g0RLAGYhL9yp9G8SylmgFB4UWIFAmFMWdAACgkQSylmgFB4
UWJIowf/UeT9FLzxv/8lj89Y7cuyKZyYM9OAQ4MYjYwCg0heVAXhOoIziBU2xlic
gIoGquC3Ouq/TjD+elcGuZ45JUjSWjc1Rmt/xyUbYLZvRxBPzo0JksEck9BIZuQ7
kmfFh/9xHjaS99WqoYc0QjJYjaqNDzq8Kn7+ekXA/bDjSJA6bsRcBcTNBdVdOGV1
sRNqWZz6kS5ZiTMamkoL4eo5jQix4dqYEd1HzKWRdMYHHjLcrY2UNq79WIRv+YN1
i1L8Tvq3mySKdbwaVhT2ZXAZ0Q4zhGjp6VGODiIbdbQJsV97+D0g6WzFi06KIwzc
T74Rkss0x4wc/nRw5ctSzhkp/fjNiQ==
=8faf
-----END PGP SIGNATURE-----

--=-EwuGTsVw/o5OifbOfDbW--
