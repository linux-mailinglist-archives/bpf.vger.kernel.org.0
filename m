Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F34AD4195F0
	for <lists+bpf@lfdr.de>; Mon, 27 Sep 2021 16:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234675AbhI0OJY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Sep 2021 10:09:24 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:39456 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234645AbhI0OJY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Sep 2021 10:09:24 -0400
Received: by mail-wr1-f41.google.com with SMTP id r23so26848753wra.6
        for <bpf@vger.kernel.org>; Mon, 27 Sep 2021 07:07:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=OOUtdcqiCiYBBqcdoBWVf+fr0t487RC76iorl6QaytM=;
        b=TFFghi4FBMpsHJrfQeAcg/pXQZldJdY9sO6XxJpuXAm8bZFpkSLkZv+PJux54oZkd1
         4JBrhfqkRufp+WsRKNTZckLOU8O3W2oYE9O8bEALMucOumvhTmDDxJKAuOMBWAsrMJNv
         zjWKlCeV02tI/CM7lmXZXmIoknaadiCT1tRRDLGU0uOyMdqqN1DFrbNXowDJMtRwWwpz
         qvpPBkgApJ1cVvx3GWncgkd6wVvRA4wFBx0qG0un3SzQg0sP9jYdSwDrVUPpr9YMFq2R
         rl96NhgQsLaWZQtaajYPGcgEi9RNktXD42MswoSUZv1BNGCy0vCLGqJot6F2ou3hIMoW
         Szvw==
X-Gm-Message-State: AOAM5332HsaVtD6ih6zPAvDeLh6HHXE2zoPh7MvKAqsyrDRI4G/dJy7T
        qJ4rsXlQRg0kw6ZaaTCZ1Ju4vprkosI=
X-Google-Smtp-Source: ABdhPJwM6FXiQoOJQX49wkJmNeAPlZCDKtXCfM/EP/6tCjuvRrQds1CT9bSmfKBs9j4XPFVg/WCYsA==
X-Received: by 2002:a5d:6d8e:: with SMTP id l14mr14515wrs.270.1632751665583;
        Mon, 27 Sep 2021 07:07:45 -0700 (PDT)
Received: from localhost ([137.220.125.106])
        by smtp.gmail.com with ESMTPSA id z7sm16498358wmi.43.2021.09.27.07.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 07:07:44 -0700 (PDT)
Message-ID: <bf0958b799e00e41a6ff7ea1ad3a331a7230378e.camel@debian.org>
Subject: Re: [PATCH] samples/bpf: relicense bpf_insn.h as GPL-2.0-only OR
 BSD-2-Clause
From:   Luca Boccassi <bluca@debian.org>
To:     bpf@vger.kernel.org
Cc:     bjorn@kernel.org, kuba@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, daniel@zonque.org, joe@ovn.org, jbacik@fb.com
Date:   Mon, 27 Sep 2021 15:07:43 +0100
In-Reply-To: <49c54bf3f4a95562592575062058f069654fd253.camel@debian.org>
References: <20210923000540.47344-1-luca.boccassi@gmail.com>
         <49c54bf3f4a95562592575062058f069654fd253.camel@debian.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-UT/S8tD68slbLkM1cPQY"
User-Agent: Evolution 3.38.3-1+plugin 
MIME-Version: 1.0
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--=-UT/S8tD68slbLkM1cPQY
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2021-09-23 at 11:41 +0100, Luca Boccassi wrote:
> On Thu, 2021-09-23 at 01:05 +0100, luca.boccassi@gmail.com wrote:
> > From: Luca Boccassi <bluca@debian.org>
> >=20
> > libbpf and bpftool have been dual-licensed to facilitate inclusion in
> > software that is not compatible with GPL2-only (ie: Apache2), but the
> > samples are still GPL2-only.
> >=20
> > Given these files are samples, they get naturally copied around. For
> > example
> > it is the case for samples/bpf/bpf_insn.h which was copied into the
> > systemd
> > tree:
> > https://github.com/systemd/systemd/blob/main/src/shared/linux/bpf_insn.=
h
> >=20
> > Dual-license this header as GPL-2.0-only OR BSD-2-Clause to follow
> > the same licensing used by libbpf and bpftool:
> >=20
> > 1bc38b8ff6cc ("libbpf: relicense libbpf as LGPL-2.1 OR BSD-2-Clause")
> > 907b22365115 ("tools: bpftool: dual license all files")
> >=20
> > Signed-off-by: Luca Boccassi <bluca@debian.org>
> > ---
> > Most of systemd is (L)GPL2-or-later, which means there is no
> > perceived
> > incompatibility with Apache2 softwares and can thus be linked with
> > OpenSSL 3.0. But given this GPL2-only header is included this is
> > currently
> > not possible.
> > Dual-licensing this header solves this problem for us as we are
> > scoping
> > moving to OpenSSL 3.0, see:
> >=20
> > https://lists.freedesktop.org/archives/systemd-devel/2021-September/046=
882.html
> >=20
> > The authors of this file according to git log are:
> >=20
> > Alexei Starovoitov <ast@kernel.org>
> > Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>
> > Brendan Jackman <jackmanb@google.com>
> > Chenbo Feng <fengc@google.com>
> > Daniel Borkmann <daniel@iogearbox.net>
> > Daniel Mack <daniel@zonque.org>
> > Jakub Kicinski <jakub.kicinski@netronome.com>
> > Jiong Wang <jiong.wang@netronome.com>
> > Joe Stringer <joe@ovn.org>
> > Josef Bacik <jbacik@fb.com>
> >=20
> > (excludes a commit adding the SPDX header)
> >=20
> > All authors and maintainers are CC'ed. An Acked-by from everyone in
> > the
> > above list of authors will be necessary.
> >=20
> > One could probably argue for relicensing all the samples/bpf/ files
> > given both
> > libbpf and bpftool are, however the authors list would be much larger
> > and thus
> > it would be much more difficult, so I'd really appreciate if this
> > header could
> > be handled first by itself, as it solves a real license
> > incompatibility issue
> > we are currently facing.
> >=20
> > =C2=A0samples/bpf/bpf_insn.h | 2 +-
> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/samples/bpf/bpf_insn.h b/samples/bpf/bpf_insn.h
> > index aee04534483a..29c3bb6ad1cd 100644
> > --- a/samples/bpf/bpf_insn.h
> > +++ b/samples/bpf/bpf_insn.h
> > @@ -1,4 +1,4 @@
> > -/* SPDX-License-Identifier: GPL-2.0 */
> > +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> > =C2=A0/* eBPF instruction mini library */
> > =C2=A0#ifndef __BPF_INSN_H
> > =C2=A0#define __BPF_INSN_H
>=20
> Got "address not found" for the following:
>=20
> Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>
> Jakub Kicinski <jakub.kicinski@netronome.com>
> Jiong Wang <jiong.wang@netronome.com>
>=20
> Trying again with different aliases from more recent commits for Bj=C3=B6=
rn
> and Jakub.
>=20
> I cannot find other commits from Jiong with a different email address -
> Jakub, do you happen to know how we can reach Jiong? Perhaps it's not
> necessary as it's Netronome that owns the copyright and thus your ack
> would cover both contributions?

Gentle ping. We got ACKs from Netronome and Google so far (thanks!).

--=20
Kind regards,
Luca Boccassi

--=-UT/S8tD68slbLkM1cPQY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCSqx93EIPGOymuRKGv37813JB4FAmFR0C8ACgkQKGv37813
JB7K8A/9FJZDee8/eBJEwEdawkDWvwvWDfXXj3zwWkl70rCiJurhBiBult32339L
AwkFO48+2+cMVukOY9t7rfsF4qXK59shDDd3FabVRATnxNqaOB+HB38fDZOabVkd
4auuxij8gH4nIKQnGwmTsnbh9dlWjUW8qS9G37aqdQOWvlVULyighQmFwCyzLJLN
YGSgOzN4HpSVcqa8T9zrx7NQp/VRaf4WkW9kzjEOhJXfVjihaiL9cbZjgk2P0ttf
0YXogXD+7J4WqARuI8k0kkQBkxrGgIc+V5d9gNc6ym1bbb+w5URj53Ki3HqL3c0F
lTREVlqxYIp+tffwwd75PvLuczxwNVwx6FzIhjr1JL9PH7kI8YNxB/WwGumuaMeD
AANOashrGMxKsfjHO7PV1NGwrSwt6pRcm/kQtOxM/pdruEyTIgm5Ffq4ux2e+eO2
gT4Jwnk99pyo+X0MVvE/wal/sVrrzAGNZDZARcNRgybp/8tZw4ba2dg3KJ7MzDZ9
wO5iZMaCgWxzMKAYCbw+k8nkTH7GCkkjTtJKokJZOAdiv3cIhH9G+nAeUUyvxree
otVs3VSqD8DSlphlRzGyIbHsD92j72GnzUAhH13FY6ikv85u0uvcB4NQQLDmwRnE
ikuAI77hMxtoml+78vF9yps32TTbf/h2SuUd5X28xeVFpCeeC24=
=2AFx
-----END PGP SIGNATURE-----

--=-UT/S8tD68slbLkM1cPQY--
