Return-Path: <bpf+bounces-65339-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1144DB20BB9
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 16:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B82E47A3FDC
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 14:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD2023959D;
	Mon, 11 Aug 2025 14:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJgwmP3b"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A922264DE
	for <bpf@vger.kernel.org>; Mon, 11 Aug 2025 14:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754922223; cv=none; b=hcl03WLJ3mUykjEe0EvODBkWR5CbsajzYMmOcKWRdaKev+AdcngYJdRnUjpMSZZlpmoehxk7BIqzFF1nXRcydhm+o7jctSHHY3GXv/yNfkG04iTKRYcqC8wTZSd46GfDUBxAm1t5SDRLzKebeuJSC4KGwyO7aw8WqVwaXkz5Q5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754922223; c=relaxed/simple;
	bh=B+7q3Kt5dYdv/hyIGDXUFNl5mW3PlPsV4RmZSEXdFtU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HGxFcc2DZq2XIuBltyDrNizh9IQPs10ojDrmspa0iiFfIHzOdY+nHEr/aG1zX9OHZLqhysLFHhr9A6XVhdXcDw72Tyfvee/pwWM1K6GuQOD/rlg7Bd4Eztwvx9F6ovHzDQAZrgsemt+7LB/WAp6dJT/HzeFKH3v00kRmp8iRXs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJgwmP3b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE2ADC4CEF5
	for <bpf@vger.kernel.org>; Mon, 11 Aug 2025 14:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754922221;
	bh=B+7q3Kt5dYdv/hyIGDXUFNl5mW3PlPsV4RmZSEXdFtU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MJgwmP3bVz6vrBCdff7ecdnc7A2iuThlMChNjCkCruf9Bnj4+evSTvqcL1Rq3MXBr
	 wsWM0xgg80Wv4PpDLrybXViYLuTjqu5w78X3q2Gz1DVn42ceWV5uGAEg8GqklM7r1g
	 ohFf8LVLrrt3/P2SwNCo8liC0GpL5PHjHKNQXveuB4MNMpLzo06YyfimTNH/8Ijv9L
	 n3dGZ5U0eg7JmszN9n+/wdJn9QI2rWsjJ7679dpgUi7oBUa0d2WRVzXJjm1qxfsZwE
	 1hUu5MAC5YO+iIYaZEAJlet68GTbAzVSRb4YYgAzbOmTfhXxXeCnO8rbNdu9QxNIU5
	 VYdQtdn60GE1w==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-615c29fc31eso8404434a12.0
        for <bpf@vger.kernel.org>; Mon, 11 Aug 2025 07:23:41 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw+ifrWsZEMR340P0xFiuYbxuKGa1CVH2Umk4qGpQBFZoaxdiWr
	iYzMPcaXN1wsgfpS3tWnG+pwTu9nek4v85DIgAR0Kq5KTekO56goi9PYaap7xX43RYRl7DODAXK
	OAHWLTP8lZ1bApADZy9BnLxNnSBZb+PXTAHErU0KF
X-Google-Smtp-Source: AGHT+IGzrNUldFvAbePDv1iBn3bMYLnd1fENWG34npEboYHVak9FGL4QjBX5usZhH4GRr0aIyHxHtF47ADIhfeVTs8A=
X-Received: by 2002:a05:6402:4313:b0:618:3182:9ef3 with SMTP id
 4fb4d7f45d1cf-6183182a49amr2933037a12.27.1754922220264; Mon, 11 Aug 2025
 07:23:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721211958.1881379-1-kpsingh@kernel.org> <20250721211958.1881379-12-kpsingh@kernel.org>
 <2b417a1a-8f0b-4bca-ad44-aa4195040ef1@kernel.org> <CACYkzJ42L-w_eXyc1k+E7yK4DGC3xjdiwjBAznYJdXWzuq4-jA@mail.gmail.com>
In-Reply-To: <CACYkzJ42L-w_eXyc1k+E7yK4DGC3xjdiwjBAznYJdXWzuq4-jA@mail.gmail.com>
From: KP Singh <kpsingh@kernel.org>
Date: Mon, 11 Aug 2025 16:23:29 +0200
X-Gmail-Original-Message-ID: <CACYkzJ4_DUx-HXmygptxKDg1PjkwnQGKzkfRMms8O_wN2Urpmg@mail.gmail.com>
X-Gm-Features: Ac12FXyDmlbbIaWinOheDvXewMQ7uUt3cJ1XAoL9bvfYtn1bF_dEWwD3pU7hQKs
Message-ID: <CACYkzJ4_DUx-HXmygptxKDg1PjkwnQGKzkfRMms8O_wN2Urpmg@mail.gmail.com>
Subject: Re: [PATCH v2 11/13] bpftool: Add support for signing BPF programs
To: Quentin Monnet <qmo@kernel.org>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	bboscaccy@linux.microsoft.com, paul@paul-moore.com, kys@microsoft.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 7:07=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote=
:
>
> On Tue, Jul 22, 2025 at 5:51=E2=80=AFPM Quentin Monnet <qmo@kernel.org> w=
rote:
> >
> > 2025-07-21 23:19 UTC+0200 ~ KP Singh <kpsingh@kernel.org>
> > > Two modes of operation being added:
> > >
> > > Add two modes of operation:
> > >
> > > * For prog load, allow signing a program immediately before loading. =
This
> > >   is essential for command-line testing and administration.
> > >
> > >       bpftool prog load -S -k <private_key> -i <identity_cert> fentry=
_test.bpf.o
> > >
> > > * For gen skeleton, embed a pre-generated signature into the C skelet=
on
> > >   file. This supports the use of signed programs in compiled applicat=
ions.
> > >
> > >       bpftool gen skeleton -S -k <private_key> -i <identity_cert> fen=
try_test.bpf.o
> > >
> > > Generation of the loader program and its metadata map is implemented =
in
> > > libbpf (bpf_obj__gen_loader). bpftool generates a skeleton that loads
> > > the program and automates the required steps: freezing the map, creat=
ing
> > > an exclusive map, loading, and running. Users can use standard libbpf
> > > APIs directly or integrate loader program generation into their own
> > > toolchains.
> >
> >
> > Thanks KP! Some bpftool-related comments below. Looks good overall, I
> > mostly have minor comments.
> >
> > One concern might be the license for the new file, GPL-2.0 in your
> > patch, whereas bpftool is dual-licensed. I hope this is simply an overs=
ight?
>
> An oversight, fixed.
>
> >
> >
> > >
> > > Signed-off-by: KP Singh <kpsingh@kernel.org>
> > > ---
> > >  .../bpf/bpftool/Documentation/bpftool-gen.rst |  12 +
> > >  .../bpftool/Documentation/bpftool-prog.rst    |  12 +
> > >  tools/bpf/bpftool/Makefile                    |   6 +-
> > >  tools/bpf/bpftool/cgroup.c                    |   5 +-
> > >  tools/bpf/bpftool/gen.c                       |  58 ++++-
> > >  tools/bpf/bpftool/main.c                      |  21 +-
> > >  tools/bpf/bpftool/main.h                      |  11 +
> > >  tools/bpf/bpftool/prog.c                      |  25 +++
> > >  tools/bpf/bpftool/sign.c                      | 210 ++++++++++++++++=
++
> > >  9 files changed, 352 insertions(+), 8 deletions(-)
> > >  create mode 100644 tools/bpf/bpftool/sign.c
> > >
> > > diff --git a/tools/bpf/bpftool/Documentation/bpftool-gen.rst b/tools/=
bpf/bpftool/Documentation/bpftool-gen.rst
> > > index ca860fd97d8d..2997313003b1 100644
> > > --- a/tools/bpf/bpftool/Documentation/bpftool-gen.rst
> > > +++ b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
> > > @@ -185,6 +185,18 @@ OPTIONS
> > >      For skeletons, generate a "light" skeleton (also known as "loade=
r"
> > >      skeleton). A light skeleton contains a loader eBPF program. It d=
oes not use
> > >      the majority of the libbpf infrastructure, and does not need lib=
elf.
> >
> >
> > Blank line separator, please
>
> done
>
> >
> >
> > > +-S, --sign
> > > +    For skeletons, generate a signed skeleton. This option must be u=
sed with
> > > +    **-k** and **-i**. Using this flag implicitly enables **--use-lo=
ader**.
> > > +    See the "Signed Skeletons" section in the description of the
> > > +    **gen skeleton** command for more details.
> > > +
> > > +-k <private_key.pem>
> > > +    Path to the private key file in PEM format, required for signing=
.
> > > +
> > > +-i <certificate.x509>
> > > +    Path to the X.509 certificate file in PEM or DER format, require=
d for
> > > +    signing.
> >
> >
> > Please also update the options list in the SYNOPSIS section at the top
> > of the page; and the option list at the bottom of gen.c (just like for
> > "--use-loader").
>
> done also, isn't this the right formatting for the SYNOPSIS given that
> some of these are optional?
>
> **bpftool** [*OPTIONS*] **prog** *COMMAND*
> *OPTIONS* :=3D { |COMMON_OPTIONS| [ { **-f** | **--bpffs** } ] [ {
> **-m** | **--mapcompat** } ]
> [ { **-n** | **--nomount** } ] [ { **-L** | **--use-loader** } ]
> [ { { **-S** | **--sign** } **-k** <private_key.pem> **-i**
> <certificate.x509> } ] }
>
> not an expert here but I vaguely remember.
>
> Also do you think we need to:
>
>                 { "use-loader", no_argument,    NULL,   'L' },
> -               { "sign",       required_argument, NULL, 'S'},
> +               { "sign",       no_argument,    NULL,   'S' },
>
>
> Now that we don't use an argument blob for --sign?
>
>
> >
> > Can you also please take a look at the bash completion update? It
> > shouldn't be too hard if you look at how it deals with other options, i=
n
> > particular --base-btf that also takes one argument - and I can help if
> > necessary.
>
> I will give it a go.
>
> >
> >
> > >
> > >  EXAMPLES
> > >  =3D=3D=3D=3D=3D=3D=3D=3D
> > > diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools=
/bpf/bpftool/Documentation/bpftool-prog.rst
> > > index f69fd92df8d8..dc2ca196137e 100644
> > > --- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> > > +++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> > > @@ -248,6 +248,18 @@ OPTIONS
> > >      creating the maps, and loading the programs (see **bpftool prog =
tracelog**
> > >      as a way to dump those messages).
> > >
> > > +-S, --sign
> > > +    Enable signing of the BPF program before loading. This option mu=
st be
> > > +    used with **-k** and **-i**. Using this flag implicitly enables
> > > +    **--use-loader**.
> > > +
> > > +-k <private_key.pem>
> > > +    Path to the private key file in PEM format, required when signin=
g.
> > > +
> > > +-i <certificate.x509>
> > > +    Path to the X.509 certificate file in PEM or DER format, require=
d when
> > > +    signing.
> >
> >
> > Same as for skeletons: please update the list of options in the synopsi=
s
> > and at the bottom of prog.c (bash completion for skeletons' options
> > should also cover this case, so no additional work required here).
> >
> >
> > > +
> > >  EXAMPLES
> > >  =3D=3D=3D=3D=3D=3D=3D=3D
> > >  **# bpftool prog show**
> > > diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> > > index 9e9a5f006cd2..586d1b2595d1 100644
> > > --- a/tools/bpf/bpftool/Makefile
> > > +++ b/tools/bpf/bpftool/Makefile
> > > @@ -130,8 +130,8 @@ include $(FEATURES_DUMP)
> > >  endif
> > >  endif
> > >
> > > -LIBS =3D $(LIBBPF) -lelf -lz
> > > -LIBS_BOOTSTRAP =3D $(LIBBPF_BOOTSTRAP) -lelf -lz
> > > +LIBS =3D $(LIBBPF) -lelf -lz -lcrypto
> > > +LIBS_BOOTSTRAP =3D $(LIBBPF_BOOTSTRAP) -lelf -lz -lcrypto
> > >
> > >  ifeq ($(feature-libelf-zstd),1)
> > >  LIBS +=3D -lzstd
> > > @@ -194,7 +194,7 @@ endif
> > >
> > >  BPFTOOL_BOOTSTRAP :=3D $(BOOTSTRAP_OUTPUT)bpftool
> > >
> > > -BOOTSTRAP_OBJS =3D $(addprefix $(BOOTSTRAP_OUTPUT),main.o common.o j=
son_writer.o gen.o btf.o)
> > > +BOOTSTRAP_OBJS =3D $(addprefix $(BOOTSTRAP_OUTPUT),main.o common.o j=
son_writer.o gen.o btf.o sign.o)
> > >  $(BOOTSTRAP_OBJS): $(LIBBPF_BOOTSTRAP)
> > >
> > >  OBJS =3D $(patsubst %.c,$(OUTPUT)%.o,$(SRCS)) $(OUTPUT)disasm.o
> > > diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
> > > index 944ebe21a216..90c9aa297806 100644
> > > --- a/tools/bpf/bpftool/cgroup.c
> > > +++ b/tools/bpf/bpftool/cgroup.c
> > > @@ -1,7 +1,10 @@
> > >  // SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > >  // Copyright (C) 2017 Facebook
> > >  // Author: Roman Gushchin <guro@fb.com>
> > > -
> >
> >
> > Let's keep the blank line
>
> Done
>
> >
> >
> > > +#undef GCC_VERSION
> > > +#ifndef _GNU_SOURCE
> > > +#define _GNU_SOURCE
> > > +#endif
> >
> >
> > What are these for?
>
> kpsingh@kpsingh-genoa:~/projects/linux/tools/bpf/bpftool$ vmk
>
> Auto-detecting system features:
> ...                         clang-bpf-co-re: [ on  ]
> ...                                    llvm: [ on  ]
> ...                                  libcap: [ on  ]
> ...                                  libbfd: [ OFF ]
>
> In file included from cgroup.c:19:
> In file included from ./main.h:16:
> /home/kpsingh/projects/linux/tools/bpf/bpftool/libbpf/include/bpf/skel_in=
ternal.h:87:9:
> error: call to undeclared function 'syscall'; ISO C99 and later do not
> support implicit function declarations
> [-Wimplicit-function-declaration]
>    87 |         return syscall(__NR_bpf, cmd, attr, size);
>       |                ^
> 1 error generated.
>
> >
> >
> > >  #define _XOPEN_SOURCE 500
> > >  #include <errno.h>
> > >  #include <fcntl.h>
> >
> > [...]
> >
> > > diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
> > > index 2b7f2bd3a7db..fc25bb390ec7 100644
> > > --- a/tools/bpf/bpftool/main.c
> > > +++ b/tools/bpf/bpftool/main.c
> > > @@ -33,6 +33,9 @@ bool relaxed_maps;
> > >  bool use_loader;
> > >  struct btf *base_btf;
> > >  struct hashmap *refs_table;
> > > +bool sign_progs;
> > > +const char *private_key_path;
> > > +const char *cert_path;
> > >
> > >  static void __noreturn clean_and_exit(int i)
> > >  {
> > > @@ -447,6 +450,7 @@ int main(int argc, char **argv)
> > >               { "nomount",    no_argument,    NULL,   'n' },
> > >               { "debug",      no_argument,    NULL,   'd' },
> > >               { "use-loader", no_argument,    NULL,   'L' },
> > > +             { "sign",       required_argument, NULL, 'S'},
> > >               { "base-btf",   required_argument, NULL, 'B' },
> > >               { 0 }
> > >       };
> > > @@ -473,7 +477,7 @@ int main(int argc, char **argv)
> > >       bin_name =3D "bpftool";
> > >
> > >       opterr =3D 0;
> > > -     while ((opt =3D getopt_long(argc, argv, "VhpjfLmndB:l",
> > > +     while ((opt =3D getopt_long(argc, argv, "VhpjfLmndSi:k:B:l",
> > >                                 options, NULL)) >=3D 0) {
> > >               switch (opt) {
> > >               case 'V':
> > > @@ -519,6 +523,16 @@ int main(int argc, char **argv)
> > >               case 'L':
> > >                       use_loader =3D true;
> > >                       break;
> > > +             case 'S':
> > > +                     sign_progs =3D true;
> > > +                     use_loader =3D true;
> > > +                     break;
> > > +             case 'k':
> > > +                     private_key_path =3D optarg;
> > > +                     break;
> > > +             case 'i':
> > > +                     cert_path =3D optarg;
> > > +                     break;
> > >               default:
> > >                       p_err("unrecognized option '%s'", argv[optind -=
 1]);
> > >                       if (json_output)
> > > @@ -533,6 +547,11 @@ int main(int argc, char **argv)
> > >       if (argc < 0)
> > >               usage();
> > >
> > > +     if (sign_progs && (private_key_path =3D=3D NULL || cert_path =
=3D=3D NULL)) {
> > > +             p_err("-i <identity_x509_cert> and -k <private> key mus=
t be supplied with -S for signing");
> > > +             return -EINVAL;
> > > +     }
> >
> >
> > What if -i and/or -k are passed without -S?
>
> We can either print a warning or error out
>
> A) User does not want to sign removes --sign and forgets to remove -i
> -k (better with warning)
> B) User wants to sign but forgets to --sign (better with error)
>
> I'd say we print an error so that we don't accidentally not sign, WDYT?
>
> The reason why I think we should keep an explicit --sign is because we
> can also extend this to have e.g. --verify.

if (!sign_progs && (private_key_path !=3D NULL || cert_path !=3D NULL)) {
p_err("-i <identity_x509_cert> and -k <private> also need --sign to be
used for sign programs");
return -EINVAL;
}

I will error out, I was waiting for Quentin's reply, we can fix it
later if needed.

- KP

>
> - KP
>
> >
> >
> > > +
> > >       if (version_requested)
> > >               ret =3D do_version(argc, argv);
> > >       else
> > > diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
> > > index 6db704fda5c0..f921af3cda87 100644
> > > --- a/tools/bpf/bpftool/main.h
> > > +++ b/tools/bpf/bpftool/main.h
> > > @@ -6,9 +6,14 @@
> > >
> > >  /* BFD and kernel.h both define GCC_VERSION, differently */
> > >  #undef GCC_VERSION
> > > +#ifndef _GNU_SOURCE
> > > +#define _GNU_SOURCE
> > > +#endif
> > >  #include <stdbool.h>
> > >  #include <stdio.h>
> > > +#include <errno.h>
> > >  #include <stdlib.h>
> > > +#include <bpf/skel_internal.h>
> >
> >
> > Wnat do you need these includes (and _GNU_SOURCE) in main.h for?
>
> Explained above, let me know if you have better ideas on where to place t=
hese.
>
> >
> >
> > >  #include <linux/bpf.h>
> > >  #include <linux/compiler.h>
> > >  #include <linux/kernel.h>
> >
> > [...]
> >
> > > diff --git a/tools/bpf/bpftool/sign.c b/tools/bpf/bpftool/sign.c
> > > new file mode 100644
> > > index 000000000000..f0b5dd10a46b
> > > --- /dev/null
> > > +++ b/tools/bpf/bpftool/sign.c
> > > @@ -0,0 +1,210 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> >
> >
> > Please consider making this file dual-licensed like the rest of
> > bpftool's source code, "(GPL-2.0-only OR BSD-2-Clause)".
>
> Done.
>
> >
> >
> > > +
> > > +/*
> > > + * Copyright (C) 2022 Google LLC.
> >
> >
> > 2025?
>
> Let's keep it 2022, nah just kidding :) Thanks.
>
> >
> >
> > > + */
> > > +#define _GNU_SOURCE
> >
> >
> > Please guard this:
> >
> >         #ifndef _GNU_SOURCE
> >         #define _GNU_SOURCE
> >         #endif
> >
> > This is because "llvm-config --cflags" passes -D_GNU_SOURCE and we may
> > end up with a duplicate definition, otherwise.
>
> ack, done.
>
> >
> >
> > > +#include <stdio.h>
> > > +#include <stdlib.h>
> > > +#include <stdint.h>
> > > +#include <stdbool.h>
> > > +#include <string.h>
> > > +#include <string.h>
> > > +#include <getopt.h>
> > > +#include <err.h>
> > > +#include <openssl/opensslv.h>
> > > +#include <openssl/bio.h>
> > > +#include <openssl/evp.h>
> > > +#include <openssl/pem.h>
> > > +#include <openssl/err.h>
> > > +#include <openssl/cms.h>
> > > +#include <linux/keyctl.h>
> > > +#include <errno.h>
> > > +
> > > +#include <bpf/skel_internal.h>
> > > +
> > > +#include "main.h"
> > > +
> > > +#define OPEN_SSL_ERR_BUF_LEN 256
> > > +
> > > +static void display_openssl_errors(int l)
> > > +{
> > > +     char buf[OPEN_SSL_ERR_BUF_LEN];
> > > +     const char *file;
> > > +     const char *data;
> > > +     unsigned long e;
> > > +     int flags;
> > > +     int line;
> > > +
> > > +     while ((e =3D ERR_get_error_all(&file, &line, NULL, &data, &fla=
gs))) {
> > > +             ERR_error_string_n(e, buf, sizeof(buf));
> > > +             if (data && (flags & ERR_TXT_STRING)) {
> > > +                     p_err("OpenSSL %s: %s:%d: %s\n", buf, file, lin=
e, data);
> >
> >
> > Please remove the trailing '\n', p_err() handles it already.
> >
> >
> > > +             } else {
> > > +                     p_err("OpenSSL %s: %s:%d\n", buf, file, line);
> >
> >
> > Same here.
>
> done.
>
> - KP
>
> >
> > [...]

