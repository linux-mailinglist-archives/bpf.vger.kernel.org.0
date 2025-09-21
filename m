Return-Path: <bpf+bounces-69130-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB4AB8DA3F
	for <lists+bpf@lfdr.de>; Sun, 21 Sep 2025 13:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59F683BF34B
	for <lists+bpf@lfdr.de>; Sun, 21 Sep 2025 11:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2422737F9;
	Sun, 21 Sep 2025 11:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ddjRj9SI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6093026D4ED
	for <bpf@vger.kernel.org>; Sun, 21 Sep 2025 11:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758454157; cv=none; b=aaVG6DNxp2vCQY/vYaUmY+eT2zPvrw3mjohhMXhu7unr9wbytE9Oi34zUGUXEMayfDhoK94DFeaMAEqJqUELiyyzsz/5gm/bj4U3dSoRqgV4NtkqXkToP6ww6ccxZp91iwEhj2VL7pKjE9F25gTbWhX612QSDmM0W30NnUS4bEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758454157; c=relaxed/simple;
	bh=uDibAdQRgBiwZXDITBNi3RWiyJSVVC1L/p5Z7AtLlKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AsytlyYvxS/pEJulH9HPKm/m+v0szXJT2WWvqAjfj7g0rr2Oi78c5DylGXAhSELwPGoVQ/g89aSmakAd3kt0y0mQB/OEbJYkpCvHUHycPHUlEi5xkgHegbXU2EYCF4xPjxWIKH0+i1y3xeSsHUiYTdiYX3TTiV+BMw1nsHRojgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ddjRj9SI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05291C16AAE
	for <bpf@vger.kernel.org>; Sun, 21 Sep 2025 11:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758454157;
	bh=uDibAdQRgBiwZXDITBNi3RWiyJSVVC1L/p5Z7AtLlKE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ddjRj9SIh0ytMcTqYjcl0iFhNcglp2IDGsV+fbsPIMsRgpjhGv4g6ZVIpmfidhap0
	 ZflzUHm2B1HE2HrPglwelkTSD4cRlkK9Bp9PYjp1W9EYPZPC5s+gWVedHYj21Sxeuo
	 K92BvdOCdDiPku2faFOns/mkedVOrwWvuEycHgYuToi9B0wbhVGY8YfnUTA575Yl1L
	 cNFOngXU0V34iyRJpyO9lNMQl5vYmHneQC4ISRKF229i9/SBeG3ozlSPJHkMGgk/2d
	 FWErYvgYxs80v7xrBWyCXOSbVRFeMgdoMwlT+VrpTBba+spDTpn+EuqSsy2+OlOjx0
	 lbR7qbmRj1QJg==
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45dcff2f313so20351185e9.0
        for <bpf@vger.kernel.org>; Sun, 21 Sep 2025 04:29:16 -0700 (PDT)
X-Gm-Message-State: AOJu0YwtGvRE948BKQ7+7IOW/QcO0+9hCt7dC9PnGIN7epfazv/ige6/
	N4Ajwj6UzanV+rt//tt7iPz12pKfXDNNvUK8hTA8m7eCWULhjqGnYi8HyjOi8jmiC2RhMLOSGLo
	rHctZriGaAzwm+s5A35pvNgXgTiepFbi92AxEjTkl
X-Google-Smtp-Source: AGHT+IGWilrVUSpy/R0BdsaxUqFxYw+xCd7rvy5kg15CgX6rtg9LAdSKHVt2GnAfxtQqmp7rxL3Uj9k6/HMT52ETNqU=
X-Received: by 2002:a05:600c:c4a3:b0:45b:7b54:881 with SMTP id
 5b1f17b1804b1-467ead67644mr69577125e9.1.1758454155468; Sun, 21 Sep 2025
 04:29:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250914215141.15144-1-kpsingh@kernel.org> <20250914215141.15144-12-kpsingh@kernel.org>
 <1f98f82e-f15a-42d1-8975-e1cb6b66129f@kernel.org> <CACYkzJ7d2K=6TC1J_72WLT1bd7+kQE-4YHEdWtQDcfoAXZZd1w@mail.gmail.com>
 <CACYkzJ4iRrjCRYB-FyGc=2X8sCY_Ot+wtmpLpJz8oT0osCzXyA@mail.gmail.com>
In-Reply-To: <CACYkzJ4iRrjCRYB-FyGc=2X8sCY_Ot+wtmpLpJz8oT0osCzXyA@mail.gmail.com>
From: KP Singh <kpsingh@kernel.org>
Date: Sun, 21 Sep 2025 13:29:04 +0200
X-Gmail-Original-Message-ID: <CACYkzJ56zB8f7EaowwR+TfMZQe4pXKRGUyEEhgs+3hojfDAGoA@mail.gmail.com>
X-Gm-Features: AS18NWCPNlMHCThwYg5ALw7a4S6XJbDFkImGCoT3OGt2C2FsAmvWkDZLzMSQE2k
Message-ID: <CACYkzJ56zB8f7EaowwR+TfMZQe4pXKRGUyEEhgs+3hojfDAGoA@mail.gmail.com>
Subject: Re: [PATCH v4 11/12] bpftool: Add support for signing BPF programs
To: Quentin Monnet <qmo@kernel.org>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	bboscaccy@linux.microsoft.com, paul@paul-moore.com, kys@microsoft.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 21, 2025 at 12:04=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrot=
e:
>
> On Sun, Sep 21, 2025 at 12:00=E2=80=AFPM KP Singh <kpsingh@kernel.org> wr=
ote:
> >
> > On Thu, Sep 18, 2025 at 11:04=E2=80=AFPM Quentin Monnet <qmo@kernel.org=
> wrote:
> > >
> > > 2025-09-14 23:51 UTC+0200 ~ KP Singh <kpsingh@kernel.org>
> > > > Two modes of operation being added:
> > > >
> > > > Add two modes of operation:
> > > >
> > > > * For prog load, allow signing a program immediately before loading=
. This
> > > >   is essential for command-line testing and administration.
> > > >
> > > >       bpftool prog load -S -k <private_key> -i <identity_cert> fent=
ry_test.bpf.o
> > > >
> > > > * For gen skeleton, embed a pre-generated signature into the C skel=
eton
> > > >   file. This supports the use of signed programs in compiled applic=
ations.
> > > >
> > > >       bpftool gen skeleton -S -k <private_key> -i <identity_cert> f=
entry_test.bpf.o
> > > >
> > > > Generation of the loader program and its metadata map is implemente=
d in
> > > > libbpf (bpf_obj__gen_loader). bpftool generates a skeleton that loa=
ds
> > > > the program and automates the required steps: freezing the map, cre=
ating
> > > > an exclusive map, loading, and running. Users can use standard libb=
pf
> > > > APIs directly or integrate loader program generation into their own
> > > > toolchains.
> > > >
> > > > Signed-off-by: KP Singh <kpsingh@kernel.org>
> > >
> > >
> > > Hi KP, thanks for this work! Apologies for the delay, I know I've mis=
sed
> > > v3 - and I still have some small nits from bpftool's side.
> > >
> > >
> > > > ---
> > > >  .../bpf/bpftool/Documentation/bpftool-gen.rst |  16 +-
> > > >  .../bpftool/Documentation/bpftool-prog.rst    |  18 +-
> > > >  tools/bpf/bpftool/Makefile                    |   6 +-
> > > >  tools/bpf/bpftool/cgroup.c                    |   4 +
> > > >  tools/bpf/bpftool/gen.c                       |  66 +++++-
> > > >  tools/bpf/bpftool/main.c                      |  26 ++-
> > > >  tools/bpf/bpftool/main.h                      |  11 +
> > > >  tools/bpf/bpftool/prog.c                      |  27 ++-
> > > >  tools/bpf/bpftool/sign.c                      | 212 ++++++++++++++=
++++
> > >
> > >
> > > We miss the bash completion update.
> >
> > I can send a separate follow up patch which we can review separately.
> > I don't want to block the series of bugs / comments in
> > bash-completion.
> >
> >
> > >
> > >
> > > >  9 files changed, 373 insertions(+), 13 deletions(-)
> > > >  create mode 100644 tools/bpf/bpftool/sign.c
> > > >
> > > > diff --git a/tools/bpf/bpftool/Documentation/bpftool-gen.rst b/tool=
s/bpf/bpftool/Documentation/bpftool-gen.rst
> > > > index ca860fd97d8d..cef469d758ed 100644
> > > > --- a/tools/bpf/bpftool/Documentation/bpftool-gen.rst
> > > > +++ b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
> > > > @@ -16,7 +16,8 @@ SYNOPSIS
> > > >
> > > >  **bpftool** [*OPTIONS*] **gen** *COMMAND*
> > > >
> > > > -*OPTIONS* :=3D { |COMMON_OPTIONS| | { **-L** | **--use-loader** } =
}
> > > > +*OPTIONS* :=3D { |COMMON_OPTIONS| [ { **-L** | **--use-loader** } =
]
> > > > +[ { { **-S** | **--sign** } **-k** <private_key.pem> **-i** <certi=
ficate.x509> } ] }}
> > >
> > >
> > > Please don't remove the "|" separators. I understand we may use sever=
al
> > > of these options on the command line, but if we remove them this shou=
ld
> > > be done consistently over all documentation pages.
> > >
> > >
> >
> > I had asked you in:
> >
> > https://lore.kernel.org/bpf/CACYkzJ42L-w_eXyc1k+E7yK4DGC3xjdiwjBAznYJdX=
Wzuq4-jA@mail.gmail.com/
> >
> > about what you expect in the SYNOPSIS as the current formatting is not
> > correct for how the options are grouped but did not get a reply. It's
> > easier if you just mention in your reply what's expected.
> >
> > for now, I changed my bits and made a single group for signing in [ ]
> > but no | between these options. If this is not correct, let's follow
> > up as a separate patch and not block on merging this.
> >
> > - *OPTIONS* :=3D { |COMMON_OPTIONS| | { **-L** | **--use-loader** } }
> > + *OPTIONS* :=3D { |COMMON_OPTIONS| | { **-L** | **--use-loader** }
> > + | [ { **-S** | **--sign** } { **-k** <private_key.pem> } { **-i**
> > <certificate.x509> } ] }
> >
>
> Actually let's keep it consistent with what we print from the .c file:
>
> *OPTIONS* :=3D { |COMMON_OPTIONS| |
> { **-f** | **--bpffs** } | { **-m** | **--mapcompat** } | { **-n** |
> **--nomount** } |
> { **-L** | **--use-loader** } | [ { **-S** | **--sign** } **-k**
> <private_key.pem> **-i** <certificate.x509> ] }
>
> and
>
> *OPTIONS* :=3D { |COMMON_OPTIONS| | { **-L** | **--use-loader** }
> | [ { **-S** | **--sign** } **-k** <private_key.pem> **-i**
> <certificate.x509> ] }
>
> i.e a single group in [ ] without the | so that users know all these
> are required and no { } on short options as you mentioned for *.c
> lines.
>
> - KP
>
> >
> > > >
> > > >  *COMMAND* :=3D { **object** | **skeleton** | **help** }
> > > >
> > > > @@ -186,6 +187,19 @@ OPTIONS
> > > >      skeleton). A light skeleton contains a loader eBPF program. It=
 does not use
> > > >      the majority of the libbpf infrastructure, and does not need l=
ibelf.
> > > >
> > > > +-S, --sign
> > > > +    For skeletons, generate a signed skeleton. This option must be=
 used with
> > > > +    **-k** and **-i**. Using this flag implicitly enables **--use-=
loader**.
> > > > +    See the "Signed Skeletons" section in the description of the
> > > > +    **gen skeleton** command for more details.
> > >
> > >
> > > 404: Section not found!
> >
> > Removing this.
> >
> > >
> > >
> > > > +
> > > > +-k <private_key.pem>
> > > > +    Path to the private key file in PEM format, required for signi=
ng.
> > > > +
> > > > +-i <certificate.x509>
> > > > +    Path to the X.509 certificate file in PEM or DER format, requi=
red for
> > > > +    signing.
> > > > +
> > > >  EXAMPLES
> > > >  =3D=3D=3D=3D=3D=3D=3D=3D
> > > >  **$ cat example1.bpf.c**
> > > > diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/too=
ls/bpf/bpftool/Documentation/bpftool-prog.rst
> > > > index f69fd92df8d8..55b812761df2 100644
> > > > --- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> > > > +++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> > > > @@ -16,9 +16,9 @@ SYNOPSIS
> > > >
> > > >  **bpftool** [*OPTIONS*] **prog** *COMMAND*
> > > >
> > > > -*OPTIONS* :=3D { |COMMON_OPTIONS| |
> > > > -{ **-f** | **--bpffs** } | { **-m** | **--mapcompat** } | { **-n**=
 | **--nomount** } |
> > > > -{ **-L** | **--use-loader** } }
> > > > +*OPTIONS* :=3D { |COMMON_OPTIONS| [ { **-f** | **--bpffs** } ] [ {=
 **-m** | **--mapcompat** } ]
> > > > +[ { **-n** | **--nomount** } ] [ { **-L** | **--use-loader** } ]
> > > > +[ { { **-S** | **--sign** } **-k** <private_key.pem> **-i** <certi=
ficate.x509> } ] }
> > >
> > >
> > > Same for "|" separators
> >
> > Done
> >
> > >
> > >
> > > >
> > > >  *COMMANDS* :=3D
> > > >  { **show** | **list** | **dump xlated** | **dump jited** | **pin**=
 | **load** |
> > > > @@ -248,6 +248,18 @@ OPTIONS
> > > >      creating the maps, and loading the programs (see **bpftool pro=
g tracelog**
> > > >      as a way to dump those messages).
> > > >
> > > > +-S, --sign
> > > > +    Enable signing of the BPF program before loading. This option =
must be
> > > > +    used with **-k** and **-i**. Using this flag implicitly enable=
s
> > > > +    **--use-loader**.
> > > > +
> > > > +-k <private_key.pem>
> > > > +    Path to the private key file in PEM format, required when sign=
ing.
> > > > +
> > > > +-i <certificate.x509>
> > > > +    Path to the X.509 certificate file in PEM or DER format, requi=
red when
> > > > +    signing.
> > > > +
> > > >  EXAMPLES
> > > >  =3D=3D=3D=3D=3D=3D=3D=3D
> > > >  **# bpftool prog show**
> > >
> > > > diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> > > > index 67a60114368f..694e61f1909e 100644
> > > > --- a/tools/bpf/bpftool/gen.c
> > > > +++ b/tools/bpf/bpftool/gen.c
> > >
> > > > @@ -1930,7 +1988,7 @@ static int do_help(int argc, char **argv)
> > > >               "       %1$s %2$s help\n"
> > > >               "\n"
> > > >               "       " HELP_SPEC_OPTIONS " |\n"
> > > > -             "                    {-L|--use-loader} }\n"
> > > > +             "                    {-L|--use-loader} | [ {-S|--sign=
 } {-k} <private_key.pem> {-i} <certificate.x509> ]}\n"
> > >
> > >
> > > Nit: No need for curly braces when you just have a short option name,
> > > for "-k" and "-i".

I now remember why I added curly braces here, without them the test fails:

kpsingh@kpsingh-genoa:~/projects/linux$ st
kpsingh@kpsingh-genoa:~/projects/linux/tools/testing/selftests/bpf$
./test_bpftool_synctypes.py
Comparing /home/kpsingh/projects/linux/tools/bpf/bpftool/prog.c
(do_help() OPTIONS) and
/home/kpsingh/projects/linux/tools/bpf/bpftool/Documentation/bpftool-prog.r=
st
(OPTIONS): {'-i', '-k'}

So, for now, I have put the curly braces so that the test passes.

