Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7352E3CC480
	for <lists+bpf@lfdr.de>; Sat, 17 Jul 2021 18:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbhGQQmc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 17 Jul 2021 12:42:32 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:42607 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbhGQQmb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 17 Jul 2021 12:42:31 -0400
Received: by mail-wr1-f47.google.com with SMTP id r11so15722763wro.9;
        Sat, 17 Jul 2021 09:39:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=X61Wv2GAtfHuqDlRjyZbo+oRTzScZVNxySIFDR9b8jE=;
        b=su3G5PEGcAs5FLRp1dzJ+USIYQVWgiuIfcLbQlDonKnKngdbHEsb3xRjgdHMRlVYcO
         VbMYx0IUfaRe9g61/JXh77p8VYlfalGnh2NY1kSasAaePcb96Ww8uCR1ax9EhLni9823
         l540CFbBNa99OVr7jdo/LiGAwX5QpqtmxlLhRu9fEsLdZJvk9fjVJyCdTUmr9dz6O0Ug
         urhRCMt5LwF7SncigQPa8tmDBURlbpyEJeEqmnzxOQ54Yvc1W7Qpw2CgfHWRFJeGpaSK
         r/Mc3TO6Ko03OVcJwg7P7VIVnco6o+EATQX+X+yEmrafQOaPgfSXkbg2wtFLqJvhON2U
         Ti9A==
X-Gm-Message-State: AOAM530f2cqh8nDjr22rCb9I4A4xt7bgnFvMJzgqZggL3kdIvO8VUwUj
        IBcVKPrH9nHTlWsBGgIUtzI=
X-Google-Smtp-Source: ABdhPJwPb2IyRC6jQmSq9WjmsOHuGCPni2baAbGPlGqqOITZR3w37u9m2v1NcDDWI20YIWiykjV8BQ==
X-Received: by 2002:a5d:4d01:: with SMTP id z1mr19313955wrt.34.1626539973159;
        Sat, 17 Jul 2021 09:39:33 -0700 (PDT)
Received: from localhost ([137.220.125.106])
        by smtp.gmail.com with ESMTPSA id f15sm13785095wmj.15.2021.07.17.09.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 09:39:32 -0700 (PDT)
Message-ID: <4fc90a7d13c529ccc99b9c8582b33f412c65303f.camel@debian.org>
Subject: Re: [RFT] Testing 1.22
From:   Luca Boccassi <bluca@debian.org>
To:     Michal =?ISO-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com,
        Michael Petlan <mpetlan@redhat.com>
Date:   Sat, 17 Jul 2021 17:39:30 +0100
In-Reply-To: <20210717163626.GN24916@kitsune.suse.cz>
References: <YK+41f972j25Z1QQ@kernel.org>
         <20210715213120.GJ24916@kitsune.suse.cz> <YPGIxJao9SrsiG9X@kernel.org>
         <484bd96c1ae52516d54a5a45f2be108ee838f77a.camel@debian.org>
         <22b863ce92fb0f90006eee9a2a1bf82a7352cf1b.camel@debian.org>
         <20210716201248.GL24916@kitsune.suse.cz>
         <f699a04791efbb6936ef19a8dbfc99f6e77e7136.camel@debian.org>
         <20210717151003.GM24916@kitsune.suse.cz>
         <b07015ebd7bbadb06a95a5105d9f6b4ed5817b2f.camel@debian.org>
         <20210717163626.GN24916@kitsune.suse.cz>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-wEF/x88D6+CRUEf575VO"
User-Agent: Evolution 3.30.5-1.2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--=-wEF/x88D6+CRUEf575VO
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2021-07-17 at 18:36 +0200, Michal Such=C3=A1nek wrote:
> On Sat, Jul 17, 2021 at 04:14:54PM +0100, Luca Boccassi wrote:
> > On Sat, 2021-07-17 at 17:10 +0200, Michal Such=C3=A1nek wrote:
> > > Hello,
> ...
> > > So this libbpf comes from the kernel, and there is a separate github
> > > repository for libbpf.
> > >=20
> > > Should the kernel ship its own copy of the library?
> > >=20
> > > Seeing that the one in the kernel is 0.3.0 and the required one for
> > > dwarves is 0.4.0 maybe the one in the kernel needs updating if it nee=
ds
> > > to be shipped there?
> > >=20
> > > I wil file a bug to build the libbpf from the git repo instead of the
> > > kernel to make the openSUSE libbpf less baroque.
> >=20
> > They provide the same ABI, so there should be only one in the same
> > distro, the kernel package shouldn't ship its own copy if there's a
> > standalone package built from the standalone sources.
> > If you are asking why the sources are still present in the upstream
> > kernel, I don't know - maybe historical reasons, since that's where it
> > came from? But AFAIK the majority of distros don't use that anymore.
>=20
> FWIW the libbpf from github does not work for me with LTO (GCC 11).
>=20
> Also there is a problem that LIBDIR is /usr/lib64 on arm64 ppc64(le) and
> s390x but the library gets installed into /usr/lib by default. For some
> reason x86_64 is the only 64bit arch that works out of the box.
>=20
> Thanks
>=20
> Michal

I don't know about LTO - but for LIBDIR, you can use LIBSUBDIR=3D like we
do in Debian:=20
https://tracker.debian.org/media/packages/libb/libbpf/rules-0.4.0-1

--=20
Kind regards,
Luca Boccassi

--=-wEF/x88D6+CRUEf575VO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCSqx93EIPGOymuRKGv37813JB4FAmDzB8IACgkQKGv37813
JB7O7g/+IHefceBqrniJe1R8AsZz/mLKXzI4JUW/GmiqCLXdIfyRCA2BcfX7N3sm
AiOPfibFEthXFy3ZqQqy52wYD8hddMbaIgESamL/M3bl5FV1s5GHpLn/cW+bwq8V
dNzBtkwIR+KY/sjZRFDVMTAGCeFrN5fCx7/MJILA4CGF5HvvYoZDAyOZP4005SeN
RnZ0ZPAGFYPaNOOQ9DK0CE2lJBz+IR/B9oTpd9Jrhyo2ykghQyhfYay4cGj5VMOm
I48EejAUXxJMlzqW6LzF3zH2ZUzwNQ8Zk59iBmJ2Sip7TKkCP15Ocz++TuJ1wGQP
P6dNU4qmZvBCaO+ZQ3+r7ERCRYdx2GxRvlmvqwfEIu4Gy0SB1+v0YfuGNB/LTK9i
I8Ua7rbdaskgMgU8zkkFab4iDr2h1ZA3FaOC29NjhVHq4c26J2nvIaZvcgwq4Ot2
p2vNfq6TnIdvJ41j+UnEa5ka+Sku7xLEnOxDei0ucge7qliA2pL6KYZSA52K9Ody
Iv1SpZUBczJlkw6UdaYMJdQp+F9GGdschNT28tYXgkxR0Vc5inr5a+9jEll0BvPW
q7AY39/1X8xSrZvBcx603pO7Ae0bUSBTLAL1qrEX/YjulJW/tJAnU0lZWhyC09P1
CZOJdhF3h6OmNpdtGz7QUem9FedH2FsBCJCOjwyKdO5VCklUUS4=
=Lip9
-----END PGP SIGNATURE-----

--=-wEF/x88D6+CRUEf575VO--
