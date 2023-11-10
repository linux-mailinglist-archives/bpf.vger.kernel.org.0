Return-Path: <bpf+bounces-14665-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6887E761C
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 01:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEF9E1C20D87
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 00:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CDFEA4;
	Fri, 10 Nov 2023 00:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=obs-cr.20230601.gappssmtp.com header.i=@obs-cr.20230601.gappssmtp.com header.b="bvd10MN+"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84597EA0
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 00:56:19 +0000 (UTC)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5FD23859
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 16:56:18 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-675b844adc7so9009086d6.0
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 16:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=obs-cr.20230601.gappssmtp.com; s=20230601; t=1699577778; x=1700182578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4dG/hRfNgimQHSL2EWxSgb1064gOdk/BgJkC+YiWFos=;
        b=bvd10MN+lvP0xsjo+0S9ix6F6oCyXCqE1rEXC3A+uRYDBNr44Q7SqPIYC1V2BnP/Pb
         aI2nC4NdBJ/KjRtOmxAkJRLEi/TgQjqtAT4TJsMRKtWJKpInH6O9PpYbhzJrvDyv6uup
         ToY/cEtWbULthCBYgLAhCB4pg6RivzOw1M3a5QlbF1da+o4YZC7HO3IMDOmIzKmiqSzE
         WqzfUJ3R/W87uzlJh+KDGGM/IpLwa3tBdQpSfGKEIR/+OrID51blyw2lFn6D8YQzwKoo
         fMRi6VU8PNMXd4zlKT8Qtus+lAX8BzJRFs4o322fz1zbNusbq+NEYppQ3JSqAohpSG+T
         M+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699577778; x=1700182578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4dG/hRfNgimQHSL2EWxSgb1064gOdk/BgJkC+YiWFos=;
        b=Rg1qU34/gUg8mm+iAenpIADvNQggcVEkdlfzZtVLZ78uCNcInmTJ31iyxjf3GbCHVt
         LczHNre5/mY86sMsolEA4FwjPHF5X2wIIW1JU4zUzAvEr1jGpXA+i26ZR91W2wGS0ZL1
         V1ExNTIh5XT1U4J/ZyxNnGxwEs6mJxboLv+qAVXRwx0k0apHiO8MVm79/3Sq0gjgtTAM
         ZSG2J1WCsKuW3fcrax3AEtd6upmetFZy0rp9nv0dTJVL/EZYQ1kVubk8w7lBHs64t8oD
         +W2PS1g1FrgNfsvNSIck6eC8xieHcafUMKIxIW259ZZTjtgH1K7bJPDHpYB6nml0fEAS
         F35w==
X-Gm-Message-State: AOJu0Yy1ZX2ujhepdCizAltM1FFDmVopFxhqzGK4SA3VEEXjynDZjQ6/
	BGG8+FvrI+KnEgcBp6VgRro8oc1bcob0uLt1m/FR/g==
X-Google-Smtp-Source: AGHT+IE6yoP7EoJEQZbJNmru7YZxS14UCc93dTurRKruh7wPnrooQYAGRTtVXXoUgqdzfrzeBpIGdj5tTIMXQz57+u8=
X-Received: by 2002:a05:6214:c81:b0:65b:2660:f577 with SMTP id
 r1-20020a0562140c8100b0065b2660f577mr5927736qvr.3.1699577777908; Thu, 09 Nov
 2023 16:56:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADx9qWgqfQdHSVn0RMMz7M2jp5pKP-bnnc7GAfFD4QbP4eFA4w@mail.gmail.com>
 <20231103212024.327833-1-hawkinsw@obs.cr> <CAADnVQLztq5W9qmGUBQeRBUJeCmTcc9H-OXCCJJzn=0baz+8_Q@mail.gmail.com>
 <CADx9qWiQA3U+j-QoZPh7z66_2iNv6B51WXmd60Y-6GKhg+k0=w@mail.gmail.com>
 <CAADnVQKXz-Y_ykNXa-sgSjo2r6F-vuO0Jx=9zHzG7j3-ZKhGYA@mail.gmail.com>
 <CADx9qWj0fWWhT4OBLqy9MJ=hSZwSfdWvsn+9AqxmvE_DuEGCTg@mail.gmail.com>
 <CAADnVQ+w5C_MgPh2FVK=YOXrJ2LuqHzn88jFiR+yeHzB=MBoLw@mail.gmail.com>
 <CADx9qWgps=T8COiFYTFPKObSUkMo9kaOKMRVub8quN_MkFM_LA@mail.gmail.com>
 <CAADnVQLhJh+qSc=xg5WDCfFzD-SO7KtoBz5MyQZUxEY0foY6aw@mail.gmail.com>
 <CADx9qWh2Q8fxR51UmE7AiWoRykA1VK70jHaNiry5KpNHUbQYhg@mail.gmail.com> <CAADnVQKY+B3n3CXPwg+9PbyyNvfR0DNiSsGDMh-uNA-obK6yiw@mail.gmail.com>
In-Reply-To: <CAADnVQKY+B3n3CXPwg+9PbyyNvfR0DNiSsGDMh-uNA-obK6yiw@mail.gmail.com>
From: Will Hawkins <hawkinsw@obs.cr>
Date: Thu, 9 Nov 2023 19:56:07 -0500
Message-ID: <CADx9qWj48yftWY3mP3Df3TxC2uk7Fa4b_y=uhv=QQQS4sMtAGQ@mail.gmail.com>
Subject: Re: [Bpf] [PATCH v3] bpf, docs: Add additional ABI working draft base text
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@ietf.org, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 9, 2023 at 1:31=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Nov 8, 2023 at 3:57=E2=80=AFPM Will Hawkins <hawkinsw@obs.cr> wro=
te:
> >
> > On Wed, Nov 8, 2023 at 2:51=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Wed, Nov 8, 2023 at 2:13=E2=80=AFAM Will Hawkins <hawkinsw@obs.cr>=
 wrote:
> > > >
> > > > On Tue, Nov 7, 2023 at 8:17=E2=80=AFPM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Tue, Nov 7, 2023 at 11:56=E2=80=AFAM Will Hawkins <hawkinsw@ob=
s.cr> wrote:
> > > > > >
> > > > > > On Mon, Nov 6, 2023 at 3:38=E2=80=AFAM Alexei Starovoitov
> > > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > > >
> > > > > > > On Sun, Nov 5, 2023 at 4:17=E2=80=AFPM Will Hawkins <hawkinsw=
@obs.cr> wrote:
> > > > > > > >
> > > > > > > > On Sun, Nov 5, 2023 at 4:51=E2=80=AFAM Alexei Starovoitov
> > > > > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > On Fri, Nov 3, 2023 at 2:20=E2=80=AFPM Will Hawkins <hawk=
insw@obs.cr> wrote:
> > > > > > > > > > +
> > > > > > > > > > +The ABI is specified in two parts: a generic part and =
a processor-specific part.
> > > > > > > > > > +A pairing of generic ABI with the processor-specific A=
BI for a certain
> > > > > > > > > > +instantiation of a BPF machine represents a complete b=
inary interface for BPF
> > > > > > > > > > +programs executing on that machine.
> > > > > > > > > > +
> > > > > > > > > > +This document is the generic ABI and specifies the par=
ameters and behavior
> > > > > > > > > > +common to all instantiations of BPF machines. In addit=
ion, it defines the
> > > > > > > > > > +details that must be specified by each processor-speci=
fic ABI.
> > > > > > > > > > +
> > > > > > > > > > +These psABIs are the second part of the ABI. Each inst=
antiation of a BPF
> > > > > > > > > > +machine must describe the mechanism through which bina=
ry interface
> > > > > > > > > > +compatibility is maintained with respect to the issues=
 highlighted by this
> > > > > > > > > > +document. However, the details that must be defined by=
 a psABI are a minimum --
> > > > > > > > > > +a psABI may specify additional requirements for binary=
 interface compatibility
> > > > > > > > > > +on a platform.
> > > > > > > > >
> > > > > > > > > I don't understand what you are trying to say in the abov=
e.
> > > > > > > > > In my mind there is only one BPF psABI and it doesn't hav=
e
> > > > > > > > > generic and processor parts. There is only one "processor=
".
> > > > > > > > > BPF is such a processor.
> > > > > > > >
> > > > > > > > What I was trying to say was that the document here describ=
es a
> > > > > > > > generic ABI. In this document there will be areas that are =
specific to
> > > > > > > > different implementations and those would be considered pro=
cessor
> > > > > > > > specific. In other words, the ubpf runtime could define tho=
se things
> > > > > > > > differently than the rbpf runtime which, in turn, could def=
ine those
> > > > > > > > things differently than the kernel's implementation.
> > > > > > >
> > > > > > > I see what you mean. There is only one BPF psABI. There canno=
t be two.
> > > > > > > ubpf can decide not to follow it, but it could only mean that
> > > > > > > it's non conformant and not compatible.
> > > > > >
> > > > > > Okay. That was not how I was structuring the ABI. I thought we =
had
> > > > > > decided that, as the document said, an instantiation of a machi=
ne had
> > > > > > to
> > > > > >
> > > > > > 1. meet the gABI
> > > > > > 2. specify its requirements vis a vis the psABI
> > > > > > 3. (optionally) describe other requirements.
> > > > > >
> > > > > > If that is not what we decided then we will have to restructure=
 the document.
> > > > >
> > > > > This abi.rst file is the beginning of "BPF psABI" document.
> > > > > We probably should rename it to psabi.rst to avoid confusion.
> > > > > See my slides from IETF 118. I hope they explain what "BPF psABI"=
 is for.
> > > >
> > > > Of course they do! Thank you! My only question: In the language I w=
as
> > > > using, I was taking a cue from the System V world where there is a
> > > > Generic ABI and a psABI. The Generic ABI applies to all System V
> > > > compatible systems and defines certain processor-specific details t=
hat
> > > > each platform must specify to define a complete ABI. In particular,=
 I
> > > > took this language as inspiration
> > > >
> > > > """
> > > > The System V ABI is composed of two basic parts: A generic part of =
the
> > > > specification describes those parts of the interface that remain
> > > > constant across all hardware implementations of System V, and a
> > > > processor-specific part of the specification describes the parts of
> > > > the specification that are specific to a particular processor
> > > > architecture. Together, the generic ABI (or gABI) and the processor
> > > > specific supplement (or psABI) provide a complete interface
> > > > specification for compiled application programs on systems that sha=
re
> > > > a common hardware architecture.
> > > > """
> > >
> > > I see where you got the inspiration from, but it's not applicable
> > > in the BPF case. BPF is such one and only processor.
> > > We're not changing nor adding anything to Sys V generic parts.
> >
> > That was not quite what I was saying. What I started to draft is
> > something (yes, modeled after the Sys V (g/ps)ABI) but _brand new_ for
> > BPF. I think that is where I have been failing to communicate
> > correctly. What I was proposing was inspired by other ABIs but
> > completely separate and orthogonal. That is the reason for the
> > document speaking of a BPF Machine like:
> >
> > ABI-conforming BPF Machine Instantiation: A physical or logical realiza=
tion
> >    of a computer system capable of executing BPF programs consistently =
with the
> >    specifications outlined in this document.
> >
> > because it is a (not necessarily physical) entity that executes BPF
> > programs (i.e. a "BPF CPU") for which we are specifying the binary
> > compatibility. In other words, the document as it stands is proposing
> > a gABI where
> >
> > the kernel's "BPF CPU" would have its own psABI
> > ubpf's "BPF CPU" would have its own psABI
>
> and how would you expect that to work?
> psABI is a compiler spec in the first place.
> The user would use clang -O2 -target bpf_kernel vs -target bpf_ubpf ?

They could use some other compiler, too.

