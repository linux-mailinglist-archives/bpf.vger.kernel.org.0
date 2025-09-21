Return-Path: <bpf+bounces-69125-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79353B8D921
	for <lists+bpf@lfdr.de>; Sun, 21 Sep 2025 12:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56DA8188D945
	for <lists+bpf@lfdr.de>; Sun, 21 Sep 2025 10:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440EA246BC1;
	Sun, 21 Sep 2025 10:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9IFpOmk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEFE23D7F7
	for <bpf@vger.kernel.org>; Sun, 21 Sep 2025 10:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758448853; cv=none; b=mTGvt8WU4fqwhvVc6MIp1lywKipf2SYQ79qow8V7AxJc1lrr3g+MVG1kIz1bjAfbZbcB8nOqH4xqQOLbKZJCC91t81XwI7sKjvIbelhs+O9iGgQFGTrJJdoc/QIBaKUoFDgfTe2fnUbxeINlfnrOsZ3hR37nQc9+EJ2T2M7fl74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758448853; c=relaxed/simple;
	bh=fMrYrwN7xbMSjyme+FQSg9OWLuINKaQZ+W0SbHo+5/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tL7WSYxjr2gcSAVKJQRlDvok7aSCo4yQ4gaAx9BYXNP9x/8DH4HPqqtl0iBHDOKOwHzJZd11ggbre+fZHU0uSdESpL2VIDzEg0/MnF6FV8TxFFv1TX0ihjwZp7rrm1wBUX0DVzB8KTi9QpQG8jKET6n/Ztb3UiE6MX23pn4yoi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z9IFpOmk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B68BC4CEE7
	for <bpf@vger.kernel.org>; Sun, 21 Sep 2025 10:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758448853;
	bh=fMrYrwN7xbMSjyme+FQSg9OWLuINKaQZ+W0SbHo+5/U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Z9IFpOmkp8DWoElOxAztdtoEd5HnbT86d1+9rd3jLnnnRVgiTyQ+jgiagIc7ykYCT
	 RRLU5ceEwmnhfCkUdjiVmAUm9C/XtzEcP+vHyEA2Ey1Oa7MuU90A2Wu5/RvJyr6lpx
	 B0M8SipZmG8yCQwGLxfjDG6yqbwk716uQvl+fr02wHf1Zk+BRyP4OBNzTHY253ARTf
	 iTCnz+GfV6fJGKjGA/JsNO/6coGAld6r89RkpZL+7RCHwIz4nWCOqgF3TYeJv1mD2Z
	 zDp6O/fvaSOT7r/Y+sn0pq2wUZnMOvPHVHDBL6lhk5Wp27KGOpqLKIZhgqoYbbRQVi
	 b8XVVjxgifKRA==
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3f2ae6fae12so705043f8f.1
        for <bpf@vger.kernel.org>; Sun, 21 Sep 2025 03:00:53 -0700 (PDT)
X-Gm-Message-State: AOJu0YyZLdx2Jf1P5CvQ2weXfYJ5DrvcGOB1zl52lzVOKFESdf+PM40c
	CGyUGse+4sYgcu+L04H+O806v+tzDI2WGbYzAn4BOpPDCK8z96dqQAie0Q63FTttelytGmMOe7r
	OhGruyjo9y/aRER3tyTd4KgQWAINzePviPdndSkpQ
X-Google-Smtp-Source: AGHT+IHh71ltK+QSitlC0Zj1usvgE/nRdojVm9lT7daA+6GKbgndHD5WoZ3CDB515NFuqwUjeQqNwee8JsarL9M8W2o=
X-Received: by 2002:a05:6000:290a:b0:3ee:1279:6e70 with SMTP id
 ffacd0b85a97d-3ee7df1d149mr8037547f8f.20.1758448851860; Sun, 21 Sep 2025
 03:00:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250914215141.15144-1-kpsingh@kernel.org> <20250914215141.15144-12-kpsingh@kernel.org>
 <1f98f82e-f15a-42d1-8975-e1cb6b66129f@kernel.org>
In-Reply-To: <1f98f82e-f15a-42d1-8975-e1cb6b66129f@kernel.org>
From: KP Singh <kpsingh@kernel.org>
Date: Sun, 21 Sep 2025 12:00:40 +0200
X-Gmail-Original-Message-ID: <CACYkzJ7d2K=6TC1J_72WLT1bd7+kQE-4YHEdWtQDcfoAXZZd1w@mail.gmail.com>
X-Gm-Features: AS18NWAH11aGIF8cUrM-QdQUlLzd7Nr-83cPEvL8RNlzHWpZkLJx_iXxkgSsyNE
Message-ID: <CACYkzJ7d2K=6TC1J_72WLT1bd7+kQE-4YHEdWtQDcfoAXZZd1w@mail.gmail.com>
Subject: Re: [PATCH v4 11/12] bpftool: Add support for signing BPF programs
To: Quentin Monnet <qmo@kernel.org>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	bboscaccy@linux.microsoft.com, paul@paul-moore.com, kys@microsoft.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 11:04=E2=80=AFPM Quentin Monnet <qmo@kernel.org> wr=
ote:
>
> 2025-09-14 23:51 UTC+0200 ~ KP Singh <kpsingh@kernel.org>
> > Two modes of operation being added:
> >
> > Add two modes of operation:
> >
> > * For prog load, allow signing a program immediately before loading. Th=
is
> >   is essential for command-line testing and administration.
> >
> >       bpftool prog load -S -k <private_key> -i <identity_cert> fentry_t=
est.bpf.o
> >
> > * For gen skeleton, embed a pre-generated signature into the C skeleton
> >   file. This supports the use of signed programs in compiled applicatio=
ns.
> >
> >       bpftool gen skeleton -S -k <private_key> -i <identity_cert> fentr=
y_test.bpf.o
> >
> > Generation of the loader program and its metadata map is implemented in
> > libbpf (bpf_obj__gen_loader). bpftool generates a skeleton that loads
> > the program and automates the required steps: freezing the map, creatin=
g
> > an exclusive map, loading, and running. Users can use standard libbpf
> > APIs directly or integrate loader program generation into their own
> > toolchains.
> >
> > Signed-off-by: KP Singh <kpsingh@kernel.org>
>
>
> Hi KP, thanks for this work! Apologies for the delay, I know I've missed
> v3 - and I still have some small nits from bpftool's side.
>
>
> > ---
> >  .../bpf/bpftool/Documentation/bpftool-gen.rst |  16 +-
> >  .../bpftool/Documentation/bpftool-prog.rst    |  18 +-
> >  tools/bpf/bpftool/Makefile                    |   6 +-
> >  tools/bpf/bpftool/cgroup.c                    |   4 +
> >  tools/bpf/bpftool/gen.c                       |  66 +++++-
> >  tools/bpf/bpftool/main.c                      |  26 ++-
> >  tools/bpf/bpftool/main.h                      |  11 +
> >  tools/bpf/bpftool/prog.c                      |  27 ++-
> >  tools/bpf/bpftool/sign.c                      | 212 ++++++++++++++++++
>
>
> We miss the bash completion update.

I can send a separate follow up patch which we can review separately.
I don't want to block the series of bugs / comments in
bash-completion.


>
>
> >  9 files changed, 373 insertions(+), 13 deletions(-)
> >  create mode 100644 tools/bpf/bpftool/sign.c
> >
> > diff --git a/tools/bpf/bpftool/Documentation/bpftool-gen.rst b/tools/bp=
f/bpftool/Documentation/bpftool-gen.rst
> > index ca860fd97d8d..cef469d758ed 100644
> > --- a/tools/bpf/bpftool/Documentation/bpftool-gen.rst
> > +++ b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
> > @@ -16,7 +16,8 @@ SYNOPSIS
> >
> >  **bpftool** [*OPTIONS*] **gen** *COMMAND*
> >
> > -*OPTIONS* :=3D { |COMMON_OPTIONS| | { **-L** | **--use-loader** } }
> > +*OPTIONS* :=3D { |COMMON_OPTIONS| [ { **-L** | **--use-loader** } ]
> > +[ { { **-S** | **--sign** } **-k** <private_key.pem> **-i** <certifica=
te.x509> } ] }}
>
>
> Please don't remove the "|" separators. I understand we may use several
> of these options on the command line, but if we remove them this should
> be done consistently over all documentation pages.
>
>

I had asked you in:

https://lore.kernel.org/bpf/CACYkzJ42L-w_eXyc1k+E7yK4DGC3xjdiwjBAznYJdXWzuq=
4-jA@mail.gmail.com/

about what you expect in the SYNOPSIS as the current formatting is not
correct for how the options are grouped but did not get a reply. It's
easier if you just mention in your reply what's expected.

for now, I changed my bits and made a single group for signing in [ ]
but no | between these options. If this is not correct, let's follow
up as a separate patch and not block on merging this.

- *OPTIONS* :=3D { |COMMON_OPTIONS| | { **-L** | **--use-loader** } }
+ *OPTIONS* :=3D { |COMMON_OPTIONS| | { **-L** | **--use-loader** }
+ | [ { **-S** | **--sign** } { **-k** <private_key.pem> } { **-i**
<certificate.x509> } ] }


> >
> >  *COMMAND* :=3D { **object** | **skeleton** | **help** }
> >
> > @@ -186,6 +187,19 @@ OPTIONS
> >      skeleton). A light skeleton contains a loader eBPF program. It doe=
s not use
> >      the majority of the libbpf infrastructure, and does not need libel=
f.
> >
> > +-S, --sign
> > +    For skeletons, generate a signed skeleton. This option must be use=
d with
> > +    **-k** and **-i**. Using this flag implicitly enables **--use-load=
er**.
> > +    See the "Signed Skeletons" section in the description of the
> > +    **gen skeleton** command for more details.
>
>
> 404: Section not found!

Removing this.

>
>
> > +
> > +-k <private_key.pem>
> > +    Path to the private key file in PEM format, required for signing.
> > +
> > +-i <certificate.x509>
> > +    Path to the X.509 certificate file in PEM or DER format, required =
for
> > +    signing.
> > +
> >  EXAMPLES
> >  =3D=3D=3D=3D=3D=3D=3D=3D
> >  **$ cat example1.bpf.c**
> > diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/b=
pf/bpftool/Documentation/bpftool-prog.rst
> > index f69fd92df8d8..55b812761df2 100644
> > --- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> > +++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> > @@ -16,9 +16,9 @@ SYNOPSIS
> >
> >  **bpftool** [*OPTIONS*] **prog** *COMMAND*
> >
> > -*OPTIONS* :=3D { |COMMON_OPTIONS| |
> > -{ **-f** | **--bpffs** } | { **-m** | **--mapcompat** } | { **-n** | *=
*--nomount** } |
> > -{ **-L** | **--use-loader** } }
> > +*OPTIONS* :=3D { |COMMON_OPTIONS| [ { **-f** | **--bpffs** } ] [ { **-=
m** | **--mapcompat** } ]
> > +[ { **-n** | **--nomount** } ] [ { **-L** | **--use-loader** } ]
> > +[ { { **-S** | **--sign** } **-k** <private_key.pem> **-i** <certifica=
te.x509> } ] }
>
>
> Same for "|" separators

Done

>
>
> >
> >  *COMMANDS* :=3D
> >  { **show** | **list** | **dump xlated** | **dump jited** | **pin** | *=
*load** |
> > @@ -248,6 +248,18 @@ OPTIONS
> >      creating the maps, and loading the programs (see **bpftool prog tr=
acelog**
> >      as a way to dump those messages).
> >
> > +-S, --sign
> > +    Enable signing of the BPF program before loading. This option must=
 be
> > +    used with **-k** and **-i**. Using this flag implicitly enables
> > +    **--use-loader**.
> > +
> > +-k <private_key.pem>
> > +    Path to the private key file in PEM format, required when signing.
> > +
> > +-i <certificate.x509>
> > +    Path to the X.509 certificate file in PEM or DER format, required =
when
> > +    signing.
> > +
> >  EXAMPLES
> >  =3D=3D=3D=3D=3D=3D=3D=3D
> >  **# bpftool prog show**
>
> > diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> > index 67a60114368f..694e61f1909e 100644
> > --- a/tools/bpf/bpftool/gen.c
> > +++ b/tools/bpf/bpftool/gen.c
>
> > @@ -1930,7 +1988,7 @@ static int do_help(int argc, char **argv)
> >               "       %1$s %2$s help\n"
> >               "\n"
> >               "       " HELP_SPEC_OPTIONS " |\n"
> > -             "                    {-L|--use-loader} }\n"
> > +             "                    {-L|--use-loader} | [ {-S|--sign } {=
-k} <private_key.pem> {-i} <certificate.x509> ]}\n"
>
>
> Nit: No need for curly braces when you just have a short option name,
> for "-k" and "-i".

Done.

>
>
> >               "",
> >               bin_name, "gen");
> >
> > diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
> > index 0f1183b2ed0a..c78eb80b9c94 100644
> > --- a/tools/bpf/bpftool/main.c
> > +++ b/tools/bpf/bpftool/main.c
> > @@ -33,6 +33,9 @@ bool relaxed_maps;
> >  bool use_loader;
> >  struct btf *base_btf;
> >  struct hashmap *refs_table;
> > +bool sign_progs;
> > +const char *private_key_path;
> > +const char *cert_path;
> >
> >  static void __noreturn clean_and_exit(int i)
> >  {
> > @@ -448,6 +451,7 @@ int main(int argc, char **argv)
> >               { "nomount",    no_argument,    NULL,   'n' },
> >               { "debug",      no_argument,    NULL,   'd' },
> >               { "use-loader", no_argument,    NULL,   'L' },
> > +             { "sign",       no_argument,    NULL,   'S' },
> >               { "base-btf",   required_argument, NULL, 'B' },
> >               { 0 }
> >       };
> > @@ -474,7 +478,7 @@ int main(int argc, char **argv)
> >       bin_name =3D "bpftool";
> >
> >       opterr =3D 0;
> > -     while ((opt =3D getopt_long(argc, argv, "VhpjfLmndB:l",
> > +     while ((opt =3D getopt_long(argc, argv, "VhpjfLmndSi:k:B:l",
> >                                 options, NULL)) >=3D 0) {
> >               switch (opt) {
> >               case 'V':
> > @@ -520,6 +524,16 @@ int main(int argc, char **argv)
> >               case 'L':
> >                       use_loader =3D true;
> >                       break;
> > +             case 'S':
> > +                     sign_progs =3D true;
> > +                     use_loader =3D true;
> > +                     break;
> > +             case 'k':
> > +                     private_key_path =3D optarg;
> > +                     break;
> > +             case 'i':
> > +                     cert_path =3D optarg;
> > +                     break;
> >               default:
> >                       p_err("unrecognized option '%s'", argv[optind - 1=
]);
> >                       if (json_output)
> > @@ -534,6 +548,16 @@ int main(int argc, char **argv)
> >       if (argc < 0)
> >               usage();
> >
> > +     if (sign_progs && (private_key_path =3D=3D NULL || cert_path =3D=
=3D NULL)) {
> > +             p_err("-i <identity_x509_cert> and -k <private> key must =
be supplied with -S for signing");
> > +             return -EINVAL;
> > +     }
> > +
> > +     if (!sign_progs && (private_key_path !=3D NULL || cert_path !=3D =
NULL)) {
> > +             p_err("-i <identity_x509_cert> and -k <private> also need=
 --sign to be used for sign programs");
>
>
> Typo: s/to be used for sign/to sign/

        if (!sign_progs && (private_key_path !=3D NULL || cert_path !=3D NU=
LL)) {
-               p_err("-i <identity_x509_cert> and -k <private> also
need --sign to be used for sign programs");
+               p_err("-i <identity_x509_cert> and -k <private> need
to explicitly pass --sign to sign the programs");
                return -EINVAL;

>
>
> > +             return -EINVAL;
> > +     }
> > +
> >       if (version_requested)
> >               ret =3D do_version(argc, argv);
> >       else
>
> > diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> > index cf18c3879680..f78a5135f104 100644
> > --- a/tools/bpf/bpftool/prog.c
> > +++ b/tools/bpf/bpftool/prog.c
>
> > @@ -1953,6 +1956,24 @@ static int try_loader(struct gen_loader_opts *ge=
n)
> >       opts.insns =3D gen->insns;
> >       opts.insns_sz =3D gen->insns_sz;
> >       fds_before =3D count_open_fds();
> > +
> > +     if (sign_progs) {
> > +             opts.excl_prog_hash =3D prog_sha;
> > +             opts.excl_prog_hash_sz =3D sizeof(prog_sha);
> > +             opts.signature =3D sig_buf;
> > +             opts.signature_sz =3D MAX_SIG_SIZE;
> > +             opts.keyring_id =3D KEY_SPEC_SESSION_KEYRING;
> > +
> > +             err =3D bpftool_prog_sign(&opts);
> > +             if (err < 0)
> > +                     return err;
>
>
> On error here, I think you need the same as below: an error message, and
> a "goto out" to free log_buf.

Done

>
>
> > +
> > +             err =3D register_session_key(cert_path);
> > +             if (err < 0) {
> > +                     p_err("failed to add session key");
> > +                     goto out;
> > +             }
> > +     }
> >       err =3D bpf_load_and_run(&opts);
> >       fd_delta =3D count_open_fds() - fds_before;
> >       if (err < 0 || verifier_logs) {
> > @@ -1961,6 +1982,7 @@ static int try_loader(struct gen_loader_opts *gen=
)
> >                       fprintf(stderr, "loader prog leaked %d FDs\n",
> >                               fd_delta);
> >       }
> > +out:
> >       free(log_buf);
> >       return err;
> >  }
> > @@ -1988,6 +2010,9 @@ static int do_loader(int argc, char **argv)
> >               goto err_close_obj;
> >       }
> >
> > +     if (sign_progs)
> > +             gen.gen_hash =3D true;
> > +
> >       err =3D bpf_object__gen_loader(obj, &gen);
> >       if (err)
> >               goto err_close_obj;
> > @@ -2562,7 +2587,7 @@ static int do_help(int argc, char **argv)
> >               "       METRIC :=3D { cycles | instructions | l1d_loads |=
 llc_misses | itlb_misses | dtlb_misses }\n"
> >               "       " HELP_SPEC_OPTIONS " |\n"
> >               "                    {-f|--bpffs} | {-m|--mapcompat} | {-=
n|--nomount} |\n"
> > -             "                    {-L|--use-loader} }\n"
> > +             "                    {-L|--use-loader} | [ {-S|--sign } {=
-k} <private_key.pem> {-i} <certificate.x509> ] \n"
>
>
> "... -k <private_key.pem> -i <certificate.x509> ..."

done.

>
> The rest of the patch looks good.
>
> Thanks,
> Quentin

