Return-Path: <bpf+bounces-14452-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 568A97E4E85
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 02:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E85B7281579
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 01:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53F5657;
	Wed,  8 Nov 2023 01:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hyjV2aOB"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01C9650
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 01:17:30 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B339193
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 17:17:30 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40839807e82so1514575e9.0
        for <bpf@vger.kernel.org>; Tue, 07 Nov 2023 17:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699406248; x=1700011048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c9YPgxuoMwLg76ioqZ3IgWHBoV61odditqzhqJ1hENs=;
        b=hyjV2aOB3i0iCsBRk42V6JghcEQUYE0FHxT+7oax7WHbtIsEHW1jOLxm9pJKWQQda/
         WfwWy/PdoBvmp96jfhbn3h8fYQhQUfUF/JV/kaB49K+wlbY26CCHF/xCYyJZiY9BE0Xz
         UCHCe3XTxGVpaIXQ82UuLOMfhgfc5mfXanq1elPeJCtnqvb0SorJV+gGyKs8pzQX6AA1
         4crELOzClhrc4AsLGPeMfZ4pljr2FfqUmg4q/IU+5TQh5+QalL4RF3AT585nTLZ8Cevf
         E9oXGCkvalE7gV4lVyQ8ATxi9V7Xu5RBAVSO/JMEROIKpI21NGTkpN1CD5lY2jo7Ykar
         BUTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699406248; x=1700011048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c9YPgxuoMwLg76ioqZ3IgWHBoV61odditqzhqJ1hENs=;
        b=wGI1WXFyivepLtFog7u85CYfEsCpUlKPiyNzWXGkP/6GMNIeBpjGPibeatNF9u7EvE
         25UKEy9Ha0SXfxv/2/hryJJltLqDl3wNIDpyTxZ6Y6YpSQ9ON32eiGV1bgG1UhRiHpkE
         fiwzPC1PFf5CzYI/6F0TwxASsT59sgtv8g4Cw32sz3zpwVu0mIooLlP6jSXwGkgwD6T8
         LepzqGukXVVtGKOqyBU1ZkOhwG+6SSHJ+vrYHZxBtqdlAw+/d/r7M7S3iVkTCqOyY+/2
         6Zs8KM8QXKmb2pbfvqggi1np/KabONPuFpx45e9bLJdi8YJaHXFRPT8fBIYUsjCPNSpd
         epBw==
X-Gm-Message-State: AOJu0Yzg/fyYS6cnfsf5fb/JrBhAGL78bh29WH2KM7NgFtapF/egzpM2
	94ebpNHg8Vdpz6L/FyhsuiuErVDSj1u0Dqfg6KViaaGjpok=
X-Google-Smtp-Source: AGHT+IGhxgguE4IuvkgTaiWIiGJF1oidEjPSW8RiSFLlRciJgT1GG2l/my+me8cw94xtnsn9ZFLwSSIx8ppUtjARxaw=
X-Received: by 2002:a05:600c:3ba7:b0:408:33ba:569a with SMTP id
 n39-20020a05600c3ba700b0040833ba569amr5231776wms.8.1699406248071; Tue, 07 Nov
 2023 17:17:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADx9qWgqfQdHSVn0RMMz7M2jp5pKP-bnnc7GAfFD4QbP4eFA4w@mail.gmail.com>
 <20231103212024.327833-1-hawkinsw@obs.cr> <CAADnVQLztq5W9qmGUBQeRBUJeCmTcc9H-OXCCJJzn=0baz+8_Q@mail.gmail.com>
 <CADx9qWiQA3U+j-QoZPh7z66_2iNv6B51WXmd60Y-6GKhg+k0=w@mail.gmail.com>
 <CAADnVQKXz-Y_ykNXa-sgSjo2r6F-vuO0Jx=9zHzG7j3-ZKhGYA@mail.gmail.com> <CADx9qWj0fWWhT4OBLqy9MJ=hSZwSfdWvsn+9AqxmvE_DuEGCTg@mail.gmail.com>
In-Reply-To: <CADx9qWj0fWWhT4OBLqy9MJ=hSZwSfdWvsn+9AqxmvE_DuEGCTg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 7 Nov 2023 17:17:16 -0800
Message-ID: <CAADnVQ+w5C_MgPh2FVK=YOXrJ2LuqHzn88jFiR+yeHzB=MBoLw@mail.gmail.com>
Subject: Re: [Bpf] [PATCH v3] bpf, docs: Add additional ABI working draft base text
To: Will Hawkins <hawkinsw@obs.cr>
Cc: bpf@ietf.org, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 7, 2023 at 11:56=E2=80=AFAM Will Hawkins <hawkinsw@obs.cr> wrot=
e:
>
> On Mon, Nov 6, 2023 at 3:38=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Sun, Nov 5, 2023 at 4:17=E2=80=AFPM Will Hawkins <hawkinsw@obs.cr> w=
rote:
> > >
> > > On Sun, Nov 5, 2023 at 4:51=E2=80=AFAM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Fri, Nov 3, 2023 at 2:20=E2=80=AFPM Will Hawkins <hawkinsw@obs.c=
r> wrote:
> > > > > +
> > > > > +The ABI is specified in two parts: a generic part and a processo=
r-specific part.
> > > > > +A pairing of generic ABI with the processor-specific ABI for a c=
ertain
> > > > > +instantiation of a BPF machine represents a complete binary inte=
rface for BPF
> > > > > +programs executing on that machine.
> > > > > +
> > > > > +This document is the generic ABI and specifies the parameters an=
d behavior
> > > > > +common to all instantiations of BPF machines. In addition, it de=
fines the
> > > > > +details that must be specified by each processor-specific ABI.
> > > > > +
> > > > > +These psABIs are the second part of the ABI. Each instantiation =
of a BPF
> > > > > +machine must describe the mechanism through which binary interfa=
ce
> > > > > +compatibility is maintained with respect to the issues highlight=
ed by this
> > > > > +document. However, the details that must be defined by a psABI a=
re a minimum --
> > > > > +a psABI may specify additional requirements for binary interface=
 compatibility
> > > > > +on a platform.
> > > >
> > > > I don't understand what you are trying to say in the above.
> > > > In my mind there is only one BPF psABI and it doesn't have
> > > > generic and processor parts. There is only one "processor".
> > > > BPF is such a processor.
> > >
> > > What I was trying to say was that the document here describes a
> > > generic ABI. In this document there will be areas that are specific t=
o
> > > different implementations and those would be considered processor
> > > specific. In other words, the ubpf runtime could define those things
> > > differently than the rbpf runtime which, in turn, could define those
> > > things differently than the kernel's implementation.
> >
> > I see what you mean. There is only one BPF psABI. There cannot be two.
> > ubpf can decide not to follow it, but it could only mean that
> > it's non conformant and not compatible.
>
> Okay. That was not how I was structuring the ABI. I thought we had
> decided that, as the document said, an instantiation of a machine had
> to
>
> 1. meet the gABI
> 2. specify its requirements vis a vis the psABI
> 3. (optionally) describe other requirements.
>
> If that is not what we decided then we will have to restructure the docum=
ent.

This abi.rst file is the beginning of "BPF psABI" document.
We probably should rename it to psabi.rst to avoid confusion.
See my slides from IETF 118. I hope they explain what "BPF psABI" is for.

