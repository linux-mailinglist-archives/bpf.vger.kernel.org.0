Return-Path: <bpf+bounces-14621-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BF97E718B
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 19:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 937471C20C11
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 18:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4876832C8F;
	Thu,  9 Nov 2023 18:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ss9JVRON"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3453236B0E
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 18:31:31 +0000 (UTC)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4D130F9
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 10:31:30 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-5099184f8a3so506972e87.2
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 10:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699554688; x=1700159488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MC6H09I3XmxyrD/4OQ6oF47d4gO3IQyjlYDr38dU+yc=;
        b=Ss9JVRONktPJg4MNs1i0c0a74qvFRhy74rSSNYmRbO1TlQtpsTaPZPpZ2uEPHAJF+Z
         pLXrBTJG8cEYwSQ5kOaP/U5r8tfERaSyGdkKU8r7YiPdLzNendLO+mtdD8KY5WPmZQGq
         VkXPYIA8wygd5dhxRWjCAVu6jLy/1we1gxgxIR7AFT4NdUi9QgUIc6RAgcrE4fn9IaaL
         uCfwQgWKQaVjNlkDsdr5PyxvoASB5n4xBv2CKa6ZycOB3C5leuzp6UUA6MqSGXdHT3EG
         dBZe2MXSUd1wQa1RLDhZrM8+phJQVkks1OhB95fHvkTyLRcZxoJBYOJd1nRTKuwDbhAN
         cCQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699554688; x=1700159488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MC6H09I3XmxyrD/4OQ6oF47d4gO3IQyjlYDr38dU+yc=;
        b=GLXPQRzxPHyScU1dbbS+kQZRLv7Z2fNJz90BoWA1KJYofQHm9fhV2eHNoedCJhq71x
         KupiL+qF+sFtiiO8TZi3ERKeS9UmGK2jW+Bf/SeYZ3jrQs/5MSWyQ1WFWRsJw4aVeieB
         xlIdxFrY/Z+6xVyrCOINZy0CZvLiFEb53tdNG9d9HakJfFbPEGe67qArAXGmMmbbXyfp
         0Um8+C31YJ6bIzOfSqQ9EJUAMTlQZrGs5wbdmwztbswZ7p14D2PLo6JezbQO8ZSrQ3gs
         ZsVTVPkGirHa3gJVfv28k3LmzVO8t6bHtzqaZKQmWlu8DiQQMzvjWBXryNxq7IIJCJoQ
         Ec7A==
X-Gm-Message-State: AOJu0YzrJP/7nJ0hsjjWgOLN5TrsnzBa8qNK5wJ7UsmlgmTTf5gkix8L
	QYu8Lm1C3dyxX0wCm3wiQ4+WHpehUPA0z/y6Zeg=
X-Google-Smtp-Source: AGHT+IFd9F3PyLbwLkebT/Qo2uXTLXCITz78+ZLR34lJeC/jmTWrhBh+eb1j+B+PkCWjhgzBqyItz77/axzHf9yIS0Q=
X-Received: by 2002:a05:6512:5c2:b0:4ff:a8c6:d1aa with SMTP id
 o2-20020a05651205c200b004ffa8c6d1aamr2249108lfo.48.1699554688095; Thu, 09 Nov
 2023 10:31:28 -0800 (PST)
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
 <CAADnVQLhJh+qSc=xg5WDCfFzD-SO7KtoBz5MyQZUxEY0foY6aw@mail.gmail.com> <CADx9qWh2Q8fxR51UmE7AiWoRykA1VK70jHaNiry5KpNHUbQYhg@mail.gmail.com>
In-Reply-To: <CADx9qWh2Q8fxR51UmE7AiWoRykA1VK70jHaNiry5KpNHUbQYhg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 9 Nov 2023 10:31:16 -0800
Message-ID: <CAADnVQKY+B3n3CXPwg+9PbyyNvfR0DNiSsGDMh-uNA-obK6yiw@mail.gmail.com>
Subject: Re: [Bpf] [PATCH v3] bpf, docs: Add additional ABI working draft base text
To: Will Hawkins <hawkinsw@obs.cr>
Cc: bpf@ietf.org, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 8, 2023 at 3:57=E2=80=AFPM Will Hawkins <hawkinsw@obs.cr> wrote=
:
>
> On Wed, Nov 8, 2023 at 2:51=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, Nov 8, 2023 at 2:13=E2=80=AFAM Will Hawkins <hawkinsw@obs.cr> w=
rote:
> > >
> > > On Tue, Nov 7, 2023 at 8:17=E2=80=AFPM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Tue, Nov 7, 2023 at 11:56=E2=80=AFAM Will Hawkins <hawkinsw@obs.=
cr> wrote:
> > > > >
> > > > > On Mon, Nov 6, 2023 at 3:38=E2=80=AFAM Alexei Starovoitov
> > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > >
> > > > > > On Sun, Nov 5, 2023 at 4:17=E2=80=AFPM Will Hawkins <hawkinsw@o=
bs.cr> wrote:
> > > > > > >
> > > > > > > On Sun, Nov 5, 2023 at 4:51=E2=80=AFAM Alexei Starovoitov
> > > > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > > > >
> > > > > > > > On Fri, Nov 3, 2023 at 2:20=E2=80=AFPM Will Hawkins <hawkin=
sw@obs.cr> wrote:
> > > > > > > > > +
> > > > > > > > > +The ABI is specified in two parts: a generic part and a =
processor-specific part.
> > > > > > > > > +A pairing of generic ABI with the processor-specific ABI=
 for a certain
> > > > > > > > > +instantiation of a BPF machine represents a complete bin=
ary interface for BPF
> > > > > > > > > +programs executing on that machine.
> > > > > > > > > +
> > > > > > > > > +This document is the generic ABI and specifies the param=
eters and behavior
> > > > > > > > > +common to all instantiations of BPF machines. In additio=
n, it defines the
> > > > > > > > > +details that must be specified by each processor-specifi=
c ABI.
> > > > > > > > > +
> > > > > > > > > +These psABIs are the second part of the ABI. Each instan=
tiation of a BPF
> > > > > > > > > +machine must describe the mechanism through which binary=
 interface
> > > > > > > > > +compatibility is maintained with respect to the issues h=
ighlighted by this
> > > > > > > > > +document. However, the details that must be defined by a=
 psABI are a minimum --
> > > > > > > > > +a psABI may specify additional requirements for binary i=
nterface compatibility
> > > > > > > > > +on a platform.
> > > > > > > >
> > > > > > > > I don't understand what you are trying to say in the above.
> > > > > > > > In my mind there is only one BPF psABI and it doesn't have
> > > > > > > > generic and processor parts. There is only one "processor".
> > > > > > > > BPF is such a processor.
> > > > > > >
> > > > > > > What I was trying to say was that the document here describes=
 a
> > > > > > > generic ABI. In this document there will be areas that are sp=
ecific to
> > > > > > > different implementations and those would be considered proce=
ssor
> > > > > > > specific. In other words, the ubpf runtime could define those=
 things
> > > > > > > differently than the rbpf runtime which, in turn, could defin=
e those
> > > > > > > things differently than the kernel's implementation.
> > > > > >
> > > > > > I see what you mean. There is only one BPF psABI. There cannot =
be two.
> > > > > > ubpf can decide not to follow it, but it could only mean that
> > > > > > it's non conformant and not compatible.
> > > > >
> > > > > Okay. That was not how I was structuring the ABI. I thought we ha=
d
> > > > > decided that, as the document said, an instantiation of a machine=
 had
> > > > > to
> > > > >
> > > > > 1. meet the gABI
> > > > > 2. specify its requirements vis a vis the psABI
> > > > > 3. (optionally) describe other requirements.
> > > > >
> > > > > If that is not what we decided then we will have to restructure t=
he document.
> > > >
> > > > This abi.rst file is the beginning of "BPF psABI" document.
> > > > We probably should rename it to psabi.rst to avoid confusion.
> > > > See my slides from IETF 118. I hope they explain what "BPF psABI" i=
s for.
> > >
> > > Of course they do! Thank you! My only question: In the language I was
> > > using, I was taking a cue from the System V world where there is a
> > > Generic ABI and a psABI. The Generic ABI applies to all System V
> > > compatible systems and defines certain processor-specific details tha=
t
> > > each platform must specify to define a complete ABI. In particular, I
> > > took this language as inspiration
> > >
> > > """
> > > The System V ABI is composed of two basic parts: A generic part of th=
e
> > > specification describes those parts of the interface that remain
> > > constant across all hardware implementations of System V, and a
> > > processor-specific part of the specification describes the parts of
> > > the specification that are specific to a particular processor
> > > architecture. Together, the generic ABI (or gABI) and the processor
> > > specific supplement (or psABI) provide a complete interface
> > > specification for compiled application programs on systems that share
> > > a common hardware architecture.
> > > """
> >
> > I see where you got the inspiration from, but it's not applicable
> > in the BPF case. BPF is such one and only processor.
> > We're not changing nor adding anything to Sys V generic parts.
>
> That was not quite what I was saying. What I started to draft is
> something (yes, modeled after the Sys V (g/ps)ABI) but _brand new_ for
> BPF. I think that is where I have been failing to communicate
> correctly. What I was proposing was inspired by other ABIs but
> completely separate and orthogonal. That is the reason for the
> document speaking of a BPF Machine like:
>
> ABI-conforming BPF Machine Instantiation: A physical or logical realizati=
on
>    of a computer system capable of executing BPF programs consistently wi=
th the
>    specifications outlined in this document.
>
> because it is a (not necessarily physical) entity that executes BPF
> programs (i.e. a "BPF CPU") for which we are specifying the binary
> compatibility. In other words, the document as it stands is proposing
> a gABI where
>
> the kernel's "BPF CPU" would have its own psABI
> ubpf's "BPF CPU" would have its own psABI

and how would you expect that to work?
psABI is a compiler spec in the first place.
The user would use clang -O2 -target bpf_kernel vs -target bpf_ubpf ?

