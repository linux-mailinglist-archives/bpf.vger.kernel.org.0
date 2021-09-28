Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0D6641B338
	for <lists+bpf@lfdr.de>; Tue, 28 Sep 2021 17:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241637AbhI1PqS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Sep 2021 11:46:18 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:35556 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241080AbhI1PqS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Sep 2021 11:46:18 -0400
Received: by mail-wm1-f47.google.com with SMTP id z184-20020a1c7ec1000000b003065f0bc631so2710808wmc.0
        for <bpf@vger.kernel.org>; Tue, 28 Sep 2021 08:44:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=rFND6hCJA6SyR8UJCIydcVngYNRiQQ/Swb5RAv45fy8=;
        b=bZ4onnaIfx+xJ90Z/4pMFVB866UKG4LcvXVCiq7hPeA5OdqW8m5dsNCVx2ijAYsX95
         3uxvAFB8qbUFvS4ysT+CvryAlRHAYPhs6BxWVWGaoCqhYFxpsmVVBj6zVWbumgapF3/0
         ywZU4f/rKLiOVQ9ndXQiL5YFU0sM+yMq5JjVSILu29c1Yoc+O0948aqJ9G8gmF9baRGO
         ARMuKXJ8dE7GgUOecky+o5VfgIevpYa/wg+VrOw6rIK11zZ7c+XJXzXgQ4Gi/bFGUvfF
         oUCvu3yk9NTe9Isi2uWkiNw5euHHdUrz8zKXbCfZ3eYCzbWXsisTBuGH8jSNQ5529Nkf
         Jy2g==
X-Gm-Message-State: AOAM533Bjzh5ldyKemuyh3aCtaCf3tIw8+1tMLNoZfGi4Ut5+Hump+GK
        QtrdP2EMiXcbgapo3jBuZe6QF/ZCkBI=
X-Google-Smtp-Source: ABdhPJym6s7NBebhZFDleAQKsXwmbP4I3Zk3NjrAUb1UunOd9A19QMd2Cxn8pYoaDUQuoFT21qlA6g==
X-Received: by 2002:a05:600c:247:: with SMTP id 7mr3520252wmj.4.1632843877621;
        Tue, 28 Sep 2021 08:44:37 -0700 (PDT)
Received: from localhost ([137.220.125.106])
        by smtp.gmail.com with ESMTPSA id q10sm3019796wmq.12.2021.09.28.08.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 08:44:37 -0700 (PDT)
Message-ID: <1aa77fde2f7f4637d9eae7807c5c55063d6a4066.camel@debian.org>
Subject: Re: [PATCH] samples/bpf: relicense bpf_insn.h as GPL-2.0-only OR
 BSD-2-Clause
From:   Luca Boccassi <bluca@debian.org>
To:     bpf@vger.kernel.org
Cc:     joe@ovn.org, "bjorn@kernel.org" <bjorn@kernel.org>
Date:   Tue, 28 Sep 2021 16:44:35 +0100
In-Reply-To: <20210923000540.47344-1-luca.boccassi@gmail.com>
References: <20210923000540.47344-1-luca.boccassi@gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-hAjYu6aGe0/oAnkUzWt2"
User-Agent: Evolution 3.38.3-1+plugin 
MIME-Version: 1.0
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--=-hAjYu6aGe0/oAnkUzWt2
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

Gentle ping. Bj=C3=B6rn and Joe, would be great to hear from you on the
above. TIA!

--=20
Kind regards,
Luca Boccassi

--=-hAjYu6aGe0/oAnkUzWt2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCSqx93EIPGOymuRKGv37813JB4FAmFTOGMACgkQKGv37813
JB6lUQ/8CB/EiPhgUF/3aNrxYAd8h74GVUCBK1+ZYcO4PqmLeqcsmOaDjNprh2I7
fKJcTEW5FJpdeUO3cVs+owzkLFzWN+PXOFtvzsDDNR98DSnuif1CaukaE1QtCIhq
tSFGlK9VBPVI9rZOjDz2HnNeJj7ef8MqFxMcDX6jdYeDD9rNOeJ71L9ESmVQ5tmG
APRrc7Sg4vIC0ASCEj3BQau1s1RjpPHhmn7/wa1YtTeOjyImNuUt4kkR9PCEvVa6
A2IGJNvQG7d65My97rorTYw4mhf99+9g6M+vY8sYq5S0X/IwTFMyFckOoe5NbRKR
qLHZio8r3fPfo7TJaW9W7bGd6s3gt8XPixo9vdfForUqvqbMOh95gGbFO+mlBNS/
TBnOOyIZSacdP/u8ZD9SN+3Q/MAyvUJqwyEa3wK1ZHfqx8CfpkdnMMof4Z+LcIM/
YGClxVlm+j5WLF/hqI3zQ1UuCQsYAN/+vd+BURq9vWrMcHeGLDp2pD/Qy0OvDnb2
Md0xsKUsAXes+4bKsUDWo9aJl/3qlcXbMJbIsUeb1fxMyLsU/mN+WsdzHd1SXmRL
NnIFUqsAnz+AMGPNsmFWWTBfngOeDYl+2hAVKvisyz/yDeSjRvK/zmb/fVlbsuK7
AfqoPwctrU+atjHbONsWYN7lMyH6P1v8AfLsemeM8SRRfT+3qWo=
=EeAb
-----END PGP SIGNATURE-----

--=-hAjYu6aGe0/oAnkUzWt2--
