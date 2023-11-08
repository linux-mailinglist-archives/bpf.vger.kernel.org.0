Return-Path: <bpf+bounces-14470-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A137E531D
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 11:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8604E1C20AF7
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 10:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF0B1095F;
	Wed,  8 Nov 2023 10:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=obs-cr.20230601.gappssmtp.com header.i=@obs-cr.20230601.gappssmtp.com header.b="PY/5uuRy"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327081094F
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 10:13:50 +0000 (UTC)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB6E1BB
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 02:13:49 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-66d76904928so40961306d6.2
        for <bpf@vger.kernel.org>; Wed, 08 Nov 2023 02:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=obs-cr.20230601.gappssmtp.com; s=20230601; t=1699438429; x=1700043229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=39MBlWaOCdGM2CMyzhbTOZ0nGzKaJYGTIKNBLjZ93vU=;
        b=PY/5uuRy6zOUhfvNG+UyI82ZCiKyaPQS1kOuuR/oboD2v5yBfj/I/nF00JbCdAa95k
         okTsc89JZQ0Zz3Wtel+uaf7rYD8Rv7sgNc5OWLEwUCa0KW61IrtPKHccm5gM6FdFJyZw
         A4Zx4da627KqQzKeiZz3WFcuD8m4KV70p+ejk2715mzVmuWO9DJ4LCX1TFFarCZusbF7
         25/Xhju4Q94lHPmSrk8YkIm98ldYt3GwvyDdtJ4VBibXcDbVPwrI1+ssUpdbZR8VuUTD
         ARd7PBaV8iRhSsIfgGfayMFAQJgSf9owY0RJd7m8maTWPYe7SnzDIu2cSH2xaNc0MF+6
         ccsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699438429; x=1700043229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=39MBlWaOCdGM2CMyzhbTOZ0nGzKaJYGTIKNBLjZ93vU=;
        b=BcPVPcNAo4vD6nGARA9fxW7hpnqwXMRzNtZ+Ahb5BsFB1l17oTjQxMTefjwff8iH7i
         1mqTDhN0UeH3BdfayZw+1IdLyuMLJZGMVehmrwg+InynUrYi/zGlCqlJz7mBckdwIypw
         aOONaQWmBsxBM+xgFVUIV0ONjlk1+EGujhSdKMz9tjnFwkr5NTe00/WVhqmYj4a01KVn
         K+Fv1yvRSBu8c5kwSpwZlQnyOl/Qawrbc0xAppOFn34gn8tL9EL/LnRZkkn5NZqXNxt2
         almrAhL2lTn1jfH55bMRMCl/BQj4E8CJnfNUOkuDK6OBwY2s9mzdEJ67XX0X7+CGcI4F
         3VFg==
X-Gm-Message-State: AOJu0YyBw80gFOrkxHhvevx1hooMcglXy3/l4u+ezHfEDWkfft6o8A6m
	JLoiBfn/7zQWMsqFKuYx7xHNVxntKwMvbvqXO8t1EQ==
X-Google-Smtp-Source: AGHT+IGqEJoddOk+W6TxKpGKidbrVC9EhhunuqTwpTmxxS0zCUx2ITyge7014RJCSs7nSeX67WLDONGAzI1WlQ0sI0g=
X-Received: by 2002:a05:6214:2509:b0:65b:150e:604b with SMTP id
 gf9-20020a056214250900b0065b150e604bmr1407230qvb.49.1699438428743; Wed, 08
 Nov 2023 02:13:48 -0800 (PST)
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
 <CADx9qWj0fWWhT4OBLqy9MJ=hSZwSfdWvsn+9AqxmvE_DuEGCTg@mail.gmail.com> <CAADnVQ+w5C_MgPh2FVK=YOXrJ2LuqHzn88jFiR+yeHzB=MBoLw@mail.gmail.com>
In-Reply-To: <CAADnVQ+w5C_MgPh2FVK=YOXrJ2LuqHzn88jFiR+yeHzB=MBoLw@mail.gmail.com>
From: Will Hawkins <hawkinsw@obs.cr>
Date: Wed, 8 Nov 2023 05:13:37 -0500
Message-ID: <CADx9qWgps=T8COiFYTFPKObSUkMo9kaOKMRVub8quN_MkFM_LA@mail.gmail.com>
Subject: Re: [Bpf] [PATCH v3] bpf, docs: Add additional ABI working draft base text
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@ietf.org, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 7, 2023 at 8:17=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Nov 7, 2023 at 11:56=E2=80=AFAM Will Hawkins <hawkinsw@obs.cr> wr=
ote:
> >
> > On Mon, Nov 6, 2023 at 3:38=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Sun, Nov 5, 2023 at 4:17=E2=80=AFPM Will Hawkins <hawkinsw@obs.cr>=
 wrote:
> > > >
> > > > On Sun, Nov 5, 2023 at 4:51=E2=80=AFAM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Fri, Nov 3, 2023 at 2:20=E2=80=AFPM Will Hawkins <hawkinsw@obs=
.cr> wrote:
> > > > > > +
> > > > > > +The ABI is specified in two parts: a generic part and a proces=
sor-specific part.
> > > > > > +A pairing of generic ABI with the processor-specific ABI for a=
 certain
> > > > > > +instantiation of a BPF machine represents a complete binary in=
terface for BPF
> > > > > > +programs executing on that machine.
> > > > > > +
> > > > > > +This document is the generic ABI and specifies the parameters =
and behavior
> > > > > > +common to all instantiations of BPF machines. In addition, it =
defines the
> > > > > > +details that must be specified by each processor-specific ABI.
> > > > > > +
> > > > > > +These psABIs are the second part of the ABI. Each instantiatio=
n of a BPF
> > > > > > +machine must describe the mechanism through which binary inter=
face
> > > > > > +compatibility is maintained with respect to the issues highlig=
hted by this
> > > > > > +document. However, the details that must be defined by a psABI=
 are a minimum --
> > > > > > +a psABI may specify additional requirements for binary interfa=
ce compatibility
> > > > > > +on a platform.
> > > > >
> > > > > I don't understand what you are trying to say in the above.
> > > > > In my mind there is only one BPF psABI and it doesn't have
> > > > > generic and processor parts. There is only one "processor".
> > > > > BPF is such a processor.
> > > >
> > > > What I was trying to say was that the document here describes a
> > > > generic ABI. In this document there will be areas that are specific=
 to
> > > > different implementations and those would be considered processor
> > > > specific. In other words, the ubpf runtime could define those thing=
s
> > > > differently than the rbpf runtime which, in turn, could define thos=
e
> > > > things differently than the kernel's implementation.
> > >
> > > I see what you mean. There is only one BPF psABI. There cannot be two=
.
> > > ubpf can decide not to follow it, but it could only mean that
> > > it's non conformant and not compatible.
> >
> > Okay. That was not how I was structuring the ABI. I thought we had
> > decided that, as the document said, an instantiation of a machine had
> > to
> >
> > 1. meet the gABI
> > 2. specify its requirements vis a vis the psABI
> > 3. (optionally) describe other requirements.
> >
> > If that is not what we decided then we will have to restructure the doc=
ument.
>
> This abi.rst file is the beginning of "BPF psABI" document.
> We probably should rename it to psabi.rst to avoid confusion.
> See my slides from IETF 118. I hope they explain what "BPF psABI" is for.

Of course they do! Thank you! My only question: In the language I was
using, I was taking a cue from the System V world where there is a
Generic ABI and a psABI. The Generic ABI applies to all System V
compatible systems and defines certain processor-specific details that
each platform must specify to define a complete ABI. In particular, I
took this language as inspiration

"""
The System V ABI is composed of two basic parts: A generic part of the
specification describes those parts of the interface that remain
constant across all hardware implementations of System V, and a
processor-specific part of the specification describes the parts of
the specification that are specific to a particular processor
architecture. Together, the generic ABI (or gABI) and the processor
specific supplement (or psABI) provide a complete interface
specification for compiled application programs on systems that share
a common hardware architecture.
"""

See [1].

If you want this document to just be the psABI for Linux, then that is
what we will do -- you are the expert and I am just the drafter.

[1] https://www.sco.com/developers/gabi/
Will

