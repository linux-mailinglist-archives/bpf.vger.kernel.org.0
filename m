Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1F13A4AEF
	for <lists+bpf@lfdr.de>; Sat, 12 Jun 2021 00:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbhFKWW4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Jun 2021 18:22:56 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:41521 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbhFKWW4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Jun 2021 18:22:56 -0400
Received: by mail-wr1-f50.google.com with SMTP id o3so7501876wri.8;
        Fri, 11 Jun 2021 15:20:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=CLwkYWr2PlivmFs3sq84Cfy/6/fj81fzgEGo6DDgpcM=;
        b=BkM5zdyT7ViRmq8s8Hw89LJecP9Fkze1G3CZHaDTw6fpSHRcZetTyO1QQosGaX4CeS
         gC7VdrAbgli3Kfxn54j2vFeq5bkmxulj/TiOXOCy5jySaLl2SgBCNIRwWN1KZTzwj3kL
         wunpCkeeM3vEaggmJFVZIu0y1AcP5lgLRwBLgXo2T3rE2Y1KlQzzU23dlTQCQtv4A2R5
         ZLzshLGASMQTx9AmVagFJlPZ/bZh5k34tza49mDMabttvVLaQlTgQxB0tZBSP1TFrsAI
         Zs4srKKgkYMDwEpicWLoFmzIqa2QXqyDqhYdChqI3MDDEYxyDTzg8wAewGsQlIkc+1N3
         RAuw==
X-Gm-Message-State: AOAM530KcjqIdjDHLmmGb45NUbkBbjdI/WZkhTnR++xIyuckp/608gHR
        XOXJKFX0t8ThFxEiWVDm2DU=
X-Google-Smtp-Source: ABdhPJyMSFFqxHZD+1CitanlXmSTbIeljKPqIWZAWo/PnEAClXUg+uiDRTfCha7QkxPj+fr7zzcOMA==
X-Received: by 2002:adf:ff88:: with SMTP id j8mr6281347wrr.10.1623450056706;
        Fri, 11 Jun 2021 15:20:56 -0700 (PDT)
Received: from localhost ([2a01:4b00:f41a:3600:df86:cebc:8870:2184])
        by smtp.gmail.com with ESMTPSA id u7sm9950387wrt.18.2021.06.11.15.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 15:20:55 -0700 (PDT)
Message-ID: <49ebd74aac20b3896996c3b1fdcc14e35c7a05ec.camel@debian.org>
Subject: Re: [PATCH v2 1/2] CMakeLists.txt: enable SHARED and STATIC lib
 creation
From:   Luca Boccassi <bluca@debian.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Deepak Kumar Mishra <deepakkumar.mishra@arm.com>,
        dwarves@vger.kernel.org, Qais Yousef <qais.yousef@arm.com>,
        Jiri Olsa <jolsa@kernel.org>, siudin@fb.com,
        bpf <bpf@vger.kernel.org>
Date:   Fri, 11 Jun 2021 23:20:55 +0100
In-Reply-To: <9b4bcb2372f00c9ffa1b3d5d30a84755d8a3896c.camel@debian.org>
References: <cover.1623091959.git.deepakkumar.mishra@arm.com>
         <70cb7cb534af9850dc5fe3c4b9f4366ce7dc6316.1623091959.git.deepakkumar.mishra@arm.com>
         <YMJMdQvCWHd5J0M1@kernel.org>
         <CAEf4BzZEmLbKtUMkbV4+3rDFrSwP9Eu-tO_GvYRgRvdsQqrWTQ@mail.gmail.com>
         <YMPA1T0Cuo7xw/Sp@kernel.org>
         <CAEf4BzYwf0fO5Y9pVKPg3TOwMcq-HneG-BGU8M+oAjMyhXBwQA@mail.gmail.com>
         <9b4bcb2372f00c9ffa1b3d5d30a84755d8a3896c.camel@debian.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-H5n3Qq5IpLOmJQK05FAx"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--=-H5n3Qq5IpLOmJQK05FAx
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2021-06-11 at 23:17 +0100, Luca Boccassi wrote:
> On Fri, 2021-06-11 at 13:08 -0700, Andrii Nakryiko wrote:
> On Fri, Jun 11, 2021 at 1:00 PM Arnaldo Carvalho de Melo
> <arnaldo.melo@gmail.com> wrote:
> >=20
> > Em Fri, Jun 11, 2021 at 12:34:13PM -0700, Andrii Nakryiko escreveu:
> > > On Thu, Jun 10, 2021 at 10:31 AM Arnaldo Carvalho de Melo
> > > <arnaldo.melo@gmail.com> wrote:
> > > >=20
> > > > Em Tue, Jun 08, 2021 at 12:50:13AM +0530, Deepak Kumar Mishra
> > > > escreveu:
> > > > > CMakeLists.txt does not allow creation of static library and
> > > > > link applications
> > > > > accordingly.
> > > > >=20
> > > > > Creation of SHARED and STATIC should be allowed using -
> > > > > DBUILD_SHARED_LIBS
> > > > > If -DBUILD_SHARED_LIBS option is not supplied, CMakeLists.txt
> > > > > sets it to ON.
> > > > >=20
> > > > > Ex:
> > > > > cmake -D__LIB=3Dlib -DBUILD_SHARED_LIBS=3DOFF ..
> > > > > cmake -D__LIB=3Dlib -DBUILD_SHARED_LIBS=3DON ..
> > > >=20
> > > > Had to do some fixups due to a previous patch touching
> > > > CMakeLists.txt,
> > > > please check below.
> > > >=20
> > > > I tested it and added some performance notes.
> > >=20
> > > Hey Arnaldo, Deepak,
> > >=20
> > > I think this commit actually breaks libbpf's CI (see [0]) and my
> > > local
> > > setup as well (see output below). It seems like now we are using
> > > system-wide libbpf headers, while still building local libbpf
> > > sources.
> > > This is pretty bad because system-wide headers might be too old
> > > or
> > > just missing.
> >=20
> > I can't check this right now, but isn't this related to this one
> > instead?
>=20
> Heh, I beat you by 5 minutes ;)
>=20
>=20
> Hi,
>=20
> This should not be the case - the local paths are added to CMake and
> should win, unless something is going wrong - which is of course
> possible. A quick build of the current tip of the master branch would
> seem to confirm things are working - building with -
> DLIBBPF_EMBEDDED=3Doff (which does force to use the system library, and
> defaults to on) the build fails, while building without any options
> on
> a new tree the build succeeds.
>=20
> I'll fetch the script and try to reproduce, as it might be using
> other
> options - I assume it's this one, right?
>=20
> https://github.com/libbpf/libbpf/blob/master/travis-ci/vmtest/build_pahol=
e.sh

Right, so this script is using the CMake option "-D__LIB=3Dlib", and the
issue is reproducible when that happens, on a clean tree without any
other options, which is indeed wrong. I was not aware of that so didn't
test with it, apologies.
I'll see if I can come up with a fix, if noone else beats me to it.

--=20
Kind regards,
Luca Boccassi

--=-H5n3Qq5IpLOmJQK05FAx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEE6g0RLAGYhL9yp9G8SylmgFB4UWIFAmDD4ccACgkQSylmgFB4
UWLpXgf+P2X9ztMAX1v3UHkYmQ+XVu9pmaiUAeV5ZGXKcN6O1RCa/ItTwsucpgOJ
Kmi7RwRj+mdQrD9tvYQsTn1ZVzQ+1AWA4L0VyNfUmqRdivu5/gh7Ij9cx2II99ZH
dNFitLwS2ZdS+hw5wNkY9I12xZcC1eCEd9pLpWY+/Bjd3NuQmFCWMLL7/S88ddTI
VA7eBnG9bFanM2U7I/k+ol98hlbC6iYz5oN4cGOv+3gu/IHdDfgL0S/G38sRdx2Y
5z/G0YknS0xasJwQTnidFd+3ISkagVsA9hSOi2GwEw7y4ChM9CwM7bZydFyTwuIK
EVn9R0vkYdsLAyPnPYommGZ8BQk5tA==
=VWId
-----END PGP SIGNATURE-----

--=-H5n3Qq5IpLOmJQK05FAx--
