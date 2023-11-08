Return-Path: <bpf+bounces-14539-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D9B7E613C
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 00:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1CB7B20D20
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 23:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BF238DEC;
	Wed,  8 Nov 2023 23:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=obs-cr.20230601.gappssmtp.com header.i=@obs-cr.20230601.gappssmtp.com header.b="QPWDOuhm"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3495C38DDF
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 23:57:27 +0000 (UTC)
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBF925BC
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 15:57:26 -0800 (PST)
Received: by mail-vk1-xa32.google.com with SMTP id 71dfb90a1353d-4abe6a78ab2so132745e0c.0
        for <bpf@vger.kernel.org>; Wed, 08 Nov 2023 15:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=obs-cr.20230601.gappssmtp.com; s=20230601; t=1699487845; x=1700092645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ix611TUXuArUlzKgKZYbknlCpFFZo4IhUcEHvZIY0xk=;
        b=QPWDOuhmi5KYZq/5sp2S64OdkPfut+XmcXPJpAn+datW4kdzXMyD3UShK20BkoDeGE
         /gUbFzVgnG/7/E1UKl2ADJNaMJu+XsjegEMCNWjs9pxTaUFRyYrhtA69Zt3/UlZ1WjSy
         z4SKLSxR1Hgny80U2aR673/9cCAccEfs3rODurLHXMCFCwaQtQB8qXZxF/VUyhI1IJ/8
         i+XP9VFUvZzJSR0DPBj7L4eS5SybSruz52sDQBB6KRVLm+fNEHVQ2pgJYu6Jgr/kqS0T
         rgzGAfiEWB7lcTyY6cjPu35k94sftgugx5EJzbLg3orlZLQodDamyaK38Hlxqz9Tz5iH
         oGRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699487845; x=1700092645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ix611TUXuArUlzKgKZYbknlCpFFZo4IhUcEHvZIY0xk=;
        b=nCpSSTEpuv+ut2QkTpWUz8UF+GqTcSQW15EQhF5md1X4kbc9bTtLcyvl8C/Eu20x0G
         Yzb0x+45AOZMLMVoN6Le+c0MbLvISWum7GagBKwG5yrfClHo8HxC8vHJcldbbWhrdeBI
         ll5p5FxYLgiMxtWgU6Yv7DqPwrNSbouZR+r+NuBETApmX3gk4GVkB21WEXfpqQUuMjO7
         PWxtNolQckIq9St+9tVovP5PYm+ofjbSshCXt1wzfe7OMN7vwFTD6L9Iwu4tcpzS6Yhg
         ZkO2hZwh2dauFWaL+9zMhayYNefyY79CFJ4oqaP4kwnHJCKnD75AeVDESkwDI+yD0MVQ
         I6GQ==
X-Gm-Message-State: AOJu0YwEe69nhKjuoC0X2KXUWUTpnjXGeWV8rnSOkdTB2roIZLQFfDjb
	vONceXOaEjZBteOsSEPMgi4ihvT6iI9ZmLladjpnTQ==
X-Google-Smtp-Source: AGHT+IGkLPLOTIbwV1ItrgYhlchV5MeUyiDUvSTq5fK/Kq5e0JahjKflNRuQKncGxS6j8XBHciKpeDMu/lab0BwmDCs=
X-Received: by 2002:a05:6122:311f:b0:4ac:49ea:9156 with SMTP id
 cg31-20020a056122311f00b004ac49ea9156mr139356vkb.2.1699487845636; Wed, 08 Nov
 2023 15:57:25 -0800 (PST)
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
 <CADx9qWgps=T8COiFYTFPKObSUkMo9kaOKMRVub8quN_MkFM_LA@mail.gmail.com> <CAADnVQLhJh+qSc=xg5WDCfFzD-SO7KtoBz5MyQZUxEY0foY6aw@mail.gmail.com>
In-Reply-To: <CAADnVQLhJh+qSc=xg5WDCfFzD-SO7KtoBz5MyQZUxEY0foY6aw@mail.gmail.com>
From: Will Hawkins <hawkinsw@obs.cr>
Date: Wed, 8 Nov 2023 18:57:14 -0500
Message-ID: <CADx9qWh2Q8fxR51UmE7AiWoRykA1VK70jHaNiry5KpNHUbQYhg@mail.gmail.com>
Subject: Re: [Bpf] [PATCH v3] bpf, docs: Add additional ABI working draft base text
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@ietf.org, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 8, 2023 at 2:51=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Nov 8, 2023 at 2:13=E2=80=AFAM Will Hawkins <hawkinsw@obs.cr> wro=
te:
> >
> > On Tue, Nov 7, 2023 at 8:17=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Tue, Nov 7, 2023 at 11:56=E2=80=AFAM Will Hawkins <hawkinsw@obs.cr=
> wrote:
> > > >
> > > > On Mon, Nov 6, 2023 at 3:38=E2=80=AFAM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Sun, Nov 5, 2023 at 4:17=E2=80=AFPM Will Hawkins <hawkinsw@obs=
.cr> wrote:
> > > > > >
> > > > > > On Sun, Nov 5, 2023 at 4:51=E2=80=AFAM Alexei Starovoitov
> > > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > > >
> > > > > > > On Fri, Nov 3, 2023 at 2:20=E2=80=AFPM Will Hawkins <hawkinsw=
@obs.cr> wrote:
> > > > > > > > +
> > > > > > > > +The ABI is specified in two parts: a generic part and a pr=
ocessor-specific part.
> > > > > > > > +A pairing of generic ABI with the processor-specific ABI f=
or a certain
> > > > > > > > +instantiation of a BPF machine represents a complete binar=
y interface for BPF
> > > > > > > > +programs executing on that machine.
> > > > > > > > +
> > > > > > > > +This document is the generic ABI and specifies the paramet=
ers and behavior
> > > > > > > > +common to all instantiations of BPF machines. In addition,=
 it defines the
> > > > > > > > +details that must be specified by each processor-specific =
ABI.
> > > > > > > > +
> > > > > > > > +These psABIs are the second part of the ABI. Each instanti=
ation of a BPF
> > > > > > > > +machine must describe the mechanism through which binary i=
nterface
> > > > > > > > +compatibility is maintained with respect to the issues hig=
hlighted by this
> > > > > > > > +document. However, the details that must be defined by a p=
sABI are a minimum --
> > > > > > > > +a psABI may specify additional requirements for binary int=
erface compatibility
> > > > > > > > +on a platform.
> > > > > > >
> > > > > > > I don't understand what you are trying to say in the above.
> > > > > > > In my mind there is only one BPF psABI and it doesn't have
> > > > > > > generic and processor parts. There is only one "processor".
> > > > > > > BPF is such a processor.
> > > > > >
> > > > > > What I was trying to say was that the document here describes a
> > > > > > generic ABI. In this document there will be areas that are spec=
ific to
> > > > > > different implementations and those would be considered process=
or
> > > > > > specific. In other words, the ubpf runtime could define those t=
hings
> > > > > > differently than the rbpf runtime which, in turn, could define =
those
> > > > > > things differently than the kernel's implementation.
> > > > >
> > > > > I see what you mean. There is only one BPF psABI. There cannot be=
 two.
> > > > > ubpf can decide not to follow it, but it could only mean that
> > > > > it's non conformant and not compatible.
> > > >
> > > > Okay. That was not how I was structuring the ABI. I thought we had
> > > > decided that, as the document said, an instantiation of a machine h=
ad
> > > > to
> > > >
> > > > 1. meet the gABI
> > > > 2. specify its requirements vis a vis the psABI
> > > > 3. (optionally) describe other requirements.
> > > >
> > > > If that is not what we decided then we will have to restructure the=
 document.
> > >
> > > This abi.rst file is the beginning of "BPF psABI" document.
> > > We probably should rename it to psabi.rst to avoid confusion.
> > > See my slides from IETF 118. I hope they explain what "BPF psABI" is =
for.
> >
> > Of course they do! Thank you! My only question: In the language I was
> > using, I was taking a cue from the System V world where there is a
> > Generic ABI and a psABI. The Generic ABI applies to all System V
> > compatible systems and defines certain processor-specific details that
> > each platform must specify to define a complete ABI. In particular, I
> > took this language as inspiration
> >
> > """
> > The System V ABI is composed of two basic parts: A generic part of the
> > specification describes those parts of the interface that remain
> > constant across all hardware implementations of System V, and a
> > processor-specific part of the specification describes the parts of
> > the specification that are specific to a particular processor
> > architecture. Together, the generic ABI (or gABI) and the processor
> > specific supplement (or psABI) provide a complete interface
> > specification for compiled application programs on systems that share
> > a common hardware architecture.
> > """
>
> I see where you got the inspiration from, but it's not applicable
> in the BPF case. BPF is such one and only processor.
> We're not changing nor adding anything to Sys V generic parts.

That was not quite what I was saying. What I started to draft is
something (yes, modeled after the Sys V (g/ps)ABI) but _brand new_ for
BPF. I think that is where I have been failing to communicate
correctly. What I was proposing was inspired by other ABIs but
completely separate and orthogonal. That is the reason for the
document speaking of a BPF Machine like:

ABI-conforming BPF Machine Instantiation: A physical or logical realization
   of a computer system capable of executing BPF programs consistently with=
 the
   specifications outlined in this document.

because it is a (not necessarily physical) entity that executes BPF
programs (i.e. a "BPF CPU") for which we are specifying the binary
compatibility. In other words, the document as it stands is proposing
a gABI where

the kernel's "BPF CPU" would have its own psABI
ubpf's "BPF CPU" would have its own psABI

and others could do the same into the future so long as they met the
gABI guidelines and properly outlined the way that they handle the
processor-specific details.

My goal with writing was to give us the chance to build a whole
separate structure free and clear from Sys V so we could define our
own rules if/where there is misalignment between BPF programs and
programs that execute on a traditional CPU.

If you believe that we should just define a psABI for BPF and slot in
to the SysV ABI that is perfectly okay with me (again, you are the
expert) but that is very different than the way the currently proposed
document is written.

Will

