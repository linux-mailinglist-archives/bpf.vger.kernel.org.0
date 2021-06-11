Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C64343A4B0F
	for <lists+bpf@lfdr.de>; Sat, 12 Jun 2021 01:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbhFKXJw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Jun 2021 19:09:52 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:39627 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbhFKXJw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Jun 2021 19:09:52 -0400
Received: by mail-wr1-f50.google.com with SMTP id l2so7599003wrw.6;
        Fri, 11 Jun 2021 16:07:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=UBBOkc9o734y28P+O9GPSYXenZ3BfhRXqmmB5JSahao=;
        b=IY8SCLBXm3eAPK6HoFLylHL1zdBlTZTTEWlfJIWUTkswzKwqALx9wb4o4ub+ZmAMEs
         R57e9arPFvjdE2x2rwCDmPKrH26WLlmd2eDht3LDo3TOapjl72EqEixlbzP6p7BcE5O4
         xMEvXsi9t5f+xMqIX3hXhM7f0a/BZuwf25MnWhKBx5w32AmAGMjZ3bmV1d1UlM0dLCt7
         4jAYKmm75Jwfd8YA00v/cLKBSKx1YeFfX/Q29nlvacMSR2lVPi2cjWjXG+b0pD/Vu/73
         5EzbsiqkT5TWMhn8dbAGX2/IgyO26H7yJ98lur8QRIae+Nnj/WWy/940oAZ/fzwklQWA
         hhig==
X-Gm-Message-State: AOAM533ScLTYVl1f1QXdju0X0fGAywqARrzxfvfv7gvl3kblrM4VEvVi
        8FlVtmxiYLco1GBy/z7DDDip1Y291GzqSQ==
X-Google-Smtp-Source: ABdhPJy7knEyPi25GvfvM6eB7+Xq3hl+OulYK9wmuOV+AE9CBBXZ3D/OoD9oXYwK6fjbANtUeWQtVQ==
X-Received: by 2002:adf:9c93:: with SMTP id d19mr6312208wre.17.1623452864445;
        Fri, 11 Jun 2021 16:07:44 -0700 (PDT)
Received: from localhost ([2a01:4b00:f41a:3600:df86:cebc:8870:2184])
        by smtp.gmail.com with ESMTPSA id s1sm14042833wmj.8.2021.06.11.16.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 16:07:43 -0700 (PDT)
Message-ID: <4ec3aa68d7f608dd6f389e3ef192b5f86c71e93b.camel@debian.org>
Subject: Re: [PATCH v2 1/2] CMakeLists.txt: enable SHARED and STATIC lib
 creation
From:   Luca Boccassi <bluca@debian.org>
To:     dwarves@vger.kernel.org
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Deepak Kumar Mishra <deepakkumar.mishra@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Jiri Olsa <jolsa@kernel.org>, siudin@fb.com,
        bpf <bpf@vger.kernel.org>
Date:   Sat, 12 Jun 2021 00:07:42 +0100
In-Reply-To: <YMPpfzNCSE8DxvOA@codewreck.org>
References: <cover.1623091959.git.deepakkumar.mishra@arm.com>
         <70cb7cb534af9850dc5fe3c4b9f4366ce7dc6316.1623091959.git.deepakkumar.mishra@arm.com>
         <YMJMdQvCWHd5J0M1@kernel.org>
         <CAEf4BzZEmLbKtUMkbV4+3rDFrSwP9Eu-tO_GvYRgRvdsQqrWTQ@mail.gmail.com>
         <YMPA1T0Cuo7xw/Sp@kernel.org>
         <CAEf4BzYwf0fO5Y9pVKPg3TOwMcq-HneG-BGU8M+oAjMyhXBwQA@mail.gmail.com>
         <9b4bcb2372f00c9ffa1b3d5d30a84755d8a3896c.camel@debian.org>
         <49ebd74aac20b3896996c3b1fdcc14e35c7a05ec.camel@debian.org>
         <8471df5c1e5aa52bedb032b2fcb3b6ce7722de6b.camel@debian.org>
         <YMPpfzNCSE8DxvOA@codewreck.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-8soL2UZdMzAlbXbzUxW/"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--=-8soL2UZdMzAlbXbzUxW/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2021-06-12 at 07:53 +0900, Dominique Martinet wrote:
> Luca Boccassi wrote on Fri, Jun 11, 2021 at 11:45:25PM +0100:
> > Actually that was my mistake, used the wrong build tree (sorry,
> > it's
> > late!). I can however reproduce the issue in a chroot running the
> > libbpf CI script. Still looking.
>=20
> with the ci script I get
>=20
> $ /usr/lib64/ccache/cc -DDWARVES_MAJOR_VERSION=3D1 -
> DDWARVES_MINOR_VERSION=3D21 -D_GNU_SOURCE -Ddwarves_EXPORTS -
> I/path/to/pahole/build -I/path/to/pahole -
> I/path/to/pahole/lib/include -I/path/to/pahole/lib/bpf/include/uapi -
> D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -O2 -g -DNDEBUG -fPIC -MD
> -MT CMakeFiles/dwarves.dir/btf_encoder.c.o -MF
> CMakeFiles/dwarves.dir/btf_encoder.c.o.d -o
> CMakeFiles/dwarves.dir/btf_encoder.c.o -c
> /path/to/pahole/btf_encoder.c
> /path/to/pahole/btf_encoder.c: In function =E2=80=98btf_encoder__add_floa=
t=E2=80=99:
> /path/to/pahole/btf_encoder.c:224:22: warning: implicit declaration
> of function =E2=80=98btf__add_float=E2=80=99; did you mean =E2=80=98btf__=
add_var=E2=80=99? [-
> Wimplicit-function-declaration]
> =C2=A0 224 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int32_t id =
=3D btf__add_float(encoder->btf, name,
> BITS_ROUNDUP_BYTES(bt->bit_size));
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 ^~~~~~~~~~~~~~
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 btf__add_var
>=20
>=20
>=20
> with btf__add_float defined in .../pahole/lib/bpf/src/btf.h
> and btf_encoder.c including linux/btf.h
>=20
>=20
> changing btf_loader.c to include bpf/btf.h instead fixes the issue
> for me:
>=20
> diff --git a/btf_loader.c b/btf_loader.c
> index 75ec674b3b3e..272c73bca7fe 100644
> --- a/btf_loader.c
> +++ b/btf_loader.c
> @@ -20,7 +20,7 @@
> =C2=A0#include <string.h>
> =C2=A0#include <limits.h>
> =C2=A0#include <libgen.h>
> -#include <linux/btf.h>
> +#include <bpf/btf.h>
> =C2=A0#include <bpf/libbpf.h>
> =C2=A0#include <zlib.h>

I've just sent a patch - the issue is that the original commit included
a symlink lib/include/bpf -> ../bpf/src as suggested by Andrii here:

https://www.spinics.net/lists/dwarves/msg00738.html

git show 82749180b23d3c9c060108bc290ae26507fc324e -- lib/include
    commit 82749180b23d3c9c060108bc290ae26507fc324e
    Author: Luca Boccassi <bluca@debian.org>
    Date:   Mon Jan 4 22:16:22 2021 +0000
   =20
        libbpf: allow to use packaged version
   =20
        Add a new CMake option, LIBBPF_EMBEDDED, to switch between the
        embedded version and the system version (searched via pkg-config)
        of libbpf. Set the embedded version as the default.
   =20
        Signed-off-by: Luca Boccassi <bluca@debian.org>
        Cc: dwarves@vger.kernel.org
        Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
   =20
    diff --git a/lib/include/bpf b/lib/include/bpf
    new file mode 120000
    index 0000000..4c41b71
    --- /dev/null
    +++ b/lib/include/bpf
    @@ -0,0 +1 @@
    +../bpf/src
    \ No newline at end of file

When the patch was reverted and re-added, the symlink was dropped.

It stayed in my local tree, and I completely missed it - that's why the
build was working fine for me! D'oh!
Adding the symlink back fixes the build with the libbpf CI script. I
would be grateful if folks who are seeing the issue could apply the
patch (or create the symlink) and confirm whether it fixes the problem
or not. Thanks!

--=20
Kind regards,
Luca Boccassi

--=-8soL2UZdMzAlbXbzUxW/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEE6g0RLAGYhL9yp9G8SylmgFB4UWIFAmDD7L4ACgkQSylmgFB4
UWKrJQgAl4Q0Y6gRGPqSydzQr5byoICSzzetlIltEHnM6pK6DZVeGkh0Uz0ioujr
nxGVK56cCCpKdWsj/AgcbSihCkDg5PNBlvIux7AmYrcPcQvMXmJXboz+5FEWP3Px
b42UCiKkThTsNqvZ8CVueLwfj7maj7GATMo08UW/0WchCUnXMQRRXWCoPHNfT2zl
or4dlrLHOho31IfrLZGtcBOXlk59CEPYTFk5gNiMcOuirNbsAPPFegbTwWK1yYtk
od3Cu3WYJ+hPitywDCiZL0S546kIQ4TtHLsBKRH8WC0p8oXoQwBHjCth6FutVuwM
lIJmHnYyEnC6NbbdidQbIFSPNEBNEA==
=iHCA
-----END PGP SIGNATURE-----

--=-8soL2UZdMzAlbXbzUxW/--
