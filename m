Return-Path: <bpf+bounces-14671-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D32527E769A
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 02:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 673F01F20990
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 01:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19F2A47;
	Fri, 10 Nov 2023 01:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=obs-cr.20230601.gappssmtp.com header.i=@obs-cr.20230601.gappssmtp.com header.b="JEiQh2A9"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C257E6
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 01:35:30 +0000 (UTC)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F1C25B8
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 17:35:29 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-6779fe2b7c6so1861856d6.0
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 17:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=obs-cr.20230601.gappssmtp.com; s=20230601; t=1699580128; x=1700184928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kKFqgZ3KBs91haoWW2+0vg1f3e+VyCZ835ybZkTa0Xg=;
        b=JEiQh2A9OewF0TM/vCMU2hlQjZ7vmwPt+UTmM32N9Srj/q9kQTjpTyyXufmiKN18Jb
         fI8IY6BmUjxPVl+yzwROLUW6QFrY5C0LqRMimxgagWjOdDteThmx7P0GtIRhz5Y/6TGh
         qLLHx9pKK9zYky/lP3aLDnKmMTy4DIUpcU9IJlNMsGC4HhVzq21Wb6G7ghRi11kD3IEQ
         FWw7bCDQAK0cDfWh5VCFEviUyEIqbpvzd7Jiqf4IrzIsW20CGgLQ7Hu2RIVK7XTu6qaI
         TFGeAo2EsYxKIqD4BXWqoNgKtHVf3AgCBLs7QStzcYlfY9KUrH8Ccjc6uQHDAHdFQZ7R
         217Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699580128; x=1700184928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kKFqgZ3KBs91haoWW2+0vg1f3e+VyCZ835ybZkTa0Xg=;
        b=cuYqQ3NqX5DwOcGlbq3dA2nl8yHKWUg/76N0nJvzPoIty8W18ozImgnUE6gRksQs37
         oeQxBQ3wBFKq1V353eVXSNT0MwdH29PUu6e+G3Nf2J9MxEbUU7o8MRiIgFg5C06DFZdu
         HPD8wXcPgl4/UlOXmOJsXenRPK0Yfet7wdSlo5dnueLFOMgHdbSkmQQH1fU4dq0ToDQD
         tRcTdqvDwFWKT4waJkZ43bzwOx/aQ7hx5OQh2H6aNfhBeUMA6RxNi4Ao0x5kACY0xy3I
         kwXmRzd8vtnurbopuDwipgQOzM0xrTheYbwc69y4vSF+Cg/3SRNZbIgDwO2Y6h8SmUum
         DbsQ==
X-Gm-Message-State: AOJu0YxIQv/4d0vB0yzhRXaricF1hYFNjjwIJJe03GDBuRJKXAcDW6kY
	rFBuGqCH2NBZI1bBEf0gcMdavWqUa0RzEFL7ON/Ghw==
X-Google-Smtp-Source: AGHT+IHIcwgm6Co+I0tKa//NhjyERQyrqVpD+xC3bHCdWnQD4mjEsWPadfGZduKVWVnnY6j5NE7aDQWM7uJMGPIQRvw=
X-Received: by 2002:ad4:5dc9:0:b0:66f:afb8:bcc5 with SMTP id
 m9-20020ad45dc9000000b0066fafb8bcc5mr7628839qvh.8.1699580128275; Thu, 09 Nov
 2023 17:35:28 -0800 (PST)
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
 <CADx9qWh2Q8fxR51UmE7AiWoRykA1VK70jHaNiry5KpNHUbQYhg@mail.gmail.com>
 <CAADnVQKY+B3n3CXPwg+9PbyyNvfR0DNiSsGDMh-uNA-obK6yiw@mail.gmail.com> <CADx9qWj48yftWY3mP3Df3TxC2uk7Fa4b_y=uhv=QQQS4sMtAGQ@mail.gmail.com>
In-Reply-To: <CADx9qWj48yftWY3mP3Df3TxC2uk7Fa4b_y=uhv=QQQS4sMtAGQ@mail.gmail.com>
From: Will Hawkins <hawkinsw@obs.cr>
Date: Thu, 9 Nov 2023 20:35:17 -0500
Message-ID: <CADx9qWh7oPxNY3GjvSgQscgXhkGTNszwbrfkMG8Rj9Li3Se7WQ@mail.gmail.com>
Subject: Re: [Bpf] [PATCH v3] bpf, docs: Add additional ABI working draft base text
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@ietf.org, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 9, 2023 at 7:56=E2=80=AFPM Will Hawkins <hawkinsw@obs.cr> wrote=
:
>
> On Thu, Nov 9, 2023 at 1:31=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, Nov 8, 2023 at 3:57=E2=80=AFPM Will Hawkins <hawkinsw@obs.cr> w=
rote:
> > >
> > > On Wed, Nov 8, 2023 at 2:51=E2=80=AFPM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Wed, Nov 8, 2023 at 2:13=E2=80=AFAM Will Hawkins <hawkinsw@obs.c=
r> wrote:
> > > > >
> > > > > On Tue, Nov 7, 2023 at 8:17=E2=80=AFPM Alexei Starovoitov
> > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > >
> > > > > > On Tue, Nov 7, 2023 at 11:56=E2=80=AFAM Will Hawkins <hawkinsw@=
obs.cr> wrote:
> > > > > > >
> > > > > > > On Mon, Nov 6, 2023 at 3:38=E2=80=AFAM Alexei Starovoitov
> > > > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > > > >
> > > > > > > > On Sun, Nov 5, 2023 at 4:17=E2=80=AFPM Will Hawkins <hawkin=
sw@obs.cr> wrote:
> > > > > > > > >
> > > > > > > > > On Sun, Nov 5, 2023 at 4:51=E2=80=AFAM Alexei Starovoitov
> > > > > > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Fri, Nov 3, 2023 at 2:20=E2=80=AFPM Will Hawkins <ha=
wkinsw@obs.cr> wrote:
> > > > > > > > > > > +
> > > > > > > > > > > +The ABI is specified in two parts: a generic part an=
d a processor-specific part.
> > > > > > > > > > > +A pairing of generic ABI with the processor-specific=
 ABI for a certain
> > > > > > > > > > > +instantiation of a BPF machine represents a complete=
 binary interface for BPF
> > > > > > > > > > > +programs executing on that machine.
> > > > > > > > > > > +
> > > > > > > > > > > +This document is the generic ABI and specifies the p=
arameters and behavior
> > > > > > > > > > > +common to all instantiations of BPF machines. In add=
ition, it defines the
> > > > > > > > > > > +details that must be specified by each processor-spe=
cific ABI.
> > > > > > > > > > > +
> > > > > > > > > > > +These psABIs are the second part of the ABI. Each in=
stantiation of a BPF
> > > > > > > > > > > +machine must describe the mechanism through which bi=
nary interface
> > > > > > > > > > > +compatibility is maintained with respect to the issu=
es highlighted by this
> > > > > > > > > > > +document. However, the details that must be defined =
by a psABI are a minimum --
> > > > > > > > > > > +a psABI may specify additional requirements for bina=
ry interface compatibility
> > > > > > > > > > > +on a platform.
> > > > > > > > > >
> > > > > > > > > > I don't understand what you are trying to say in the ab=
ove.
> > > > > > > > > > In my mind there is only one BPF psABI and it doesn't h=
ave
> > > > > > > > > > generic and processor parts. There is only one "process=
or".
> > > > > > > > > > BPF is such a processor.
> > > > > > > > >
> > > > > > > > > What I was trying to say was that the document here descr=
ibes a
> > > > > > > > > generic ABI. In this document there will be areas that ar=
e specific to
> > > > > > > > > different implementations and those would be considered p=
rocessor
> > > > > > > > > specific. In other words, the ubpf runtime could define t=
hose things
> > > > > > > > > differently than the rbpf runtime which, in turn, could d=
efine those
> > > > > > > > > things differently than the kernel's implementation.
> > > > > > > >
> > > > > > > > I see what you mean. There is only one BPF psABI. There can=
not be two.
> > > > > > > > ubpf can decide not to follow it, but it could only mean th=
at
> > > > > > > > it's non conformant and not compatible.
> > > > > > >
> > > > > > > Okay. That was not how I was structuring the ABI. I thought w=
e had
> > > > > > > decided that, as the document said, an instantiation of a mac=
hine had
> > > > > > > to
> > > > > > >
> > > > > > > 1. meet the gABI
> > > > > > > 2. specify its requirements vis a vis the psABI
> > > > > > > 3. (optionally) describe other requirements.
> > > > > > >
> > > > > > > If that is not what we decided then we will have to restructu=
re the document.
> > > > > >
> > > > > > This abi.rst file is the beginning of "BPF psABI" document.
> > > > > > We probably should rename it to psabi.rst to avoid confusion.
> > > > > > See my slides from IETF 118. I hope they explain what "BPF psAB=
I" is for.
> > > > >
> > > > > Of course they do! Thank you! My only question: In the language I=
 was
> > > > > using, I was taking a cue from the System V world where there is =
a
> > > > > Generic ABI and a psABI. The Generic ABI applies to all System V
> > > > > compatible systems and defines certain processor-specific details=
 that
> > > > > each platform must specify to define a complete ABI. In particula=
r, I
> > > > > took this language as inspiration
> > > > >
> > > > > """
> > > > > The System V ABI is composed of two basic parts: A generic part o=
f the
> > > > > specification describes those parts of the interface that remain
> > > > > constant across all hardware implementations of System V, and a
> > > > > processor-specific part of the specification describes the parts =
of
> > > > > the specification that are specific to a particular processor
> > > > > architecture. Together, the generic ABI (or gABI) and the process=
or
> > > > > specific supplement (or psABI) provide a complete interface
> > > > > specification for compiled application programs on systems that s=
hare
> > > > > a common hardware architecture.
> > > > > """
> > > >
> > > > I see where you got the inspiration from, but it's not applicable
> > > > in the BPF case. BPF is such one and only processor.
> > > > We're not changing nor adding anything to Sys V generic parts.
> > >
> > > That was not quite what I was saying. What I started to draft is
> > > something (yes, modeled after the Sys V (g/ps)ABI) but _brand new_ fo=
r
> > > BPF. I think that is where I have been failing to communicate
> > > correctly. What I was proposing was inspired by other ABIs but
> > > completely separate and orthogonal. That is the reason for the
> > > document speaking of a BPF Machine like:
> > >
> > > ABI-conforming BPF Machine Instantiation: A physical or logical reali=
zation
> > >    of a computer system capable of executing BPF programs consistentl=
y with the
> > >    specifications outlined in this document.
> > >
> > > because it is a (not necessarily physical) entity that executes BPF
> > > programs (i.e. a "BPF CPU") for which we are specifying the binary
> > > compatibility. In other words, the document as it stands is proposing
> > > a gABI where
> > >
> > > the kernel's "BPF CPU" would have its own psABI
> > > ubpf's "BPF CPU" would have its own psABI
> >
> > and how would you expect that to work?
> > psABI is a compiler spec in the first place.
> > The user would use clang -O2 -target bpf_kernel vs -target bpf_ubpf ?
>
> They could use some other compiler, too.

I hit send too soon. Sorry.

To elaborate, it is my opinion that a (g/ps)ABI does more than just
specify a compiler. There are also aspects that have an impact on the
linker and the loader, among others. See, e.g., Chapter 3 Section 4 of
the x86-64 psABI describing process initialization. Or, 3.7 of the
same document describing a stack unwinding algorithm.

I think that we should write our documents with the *expectation* that
an ecosystem of tools will exist beyond the ones that exist now. That
way we won't end up in the "Perl is the only thing that can parse
Perl" conundrum. What's more, clang is even today not the only thing
that generates BPF machine code ([1], among others, I'm sure!).

[1] https://github.com/Alan-Jowett/bpf_conformance/

