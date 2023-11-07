Return-Path: <bpf+bounces-14441-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 909667E4976
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 20:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7706E1C2099C
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 19:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771B036B08;
	Tue,  7 Nov 2023 19:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=obs-cr.20230601.gappssmtp.com header.i=@obs-cr.20230601.gappssmtp.com header.b="VETaA6jD"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D74F34CE7
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 19:56:20 +0000 (UTC)
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA9AE7
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 11:56:19 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id ada2fe7eead31-45da9f949aaso1665207137.2
        for <bpf@vger.kernel.org>; Tue, 07 Nov 2023 11:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=obs-cr.20230601.gappssmtp.com; s=20230601; t=1699386978; x=1699991778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xjOaWaxhB0I1LfMyCOktuLSgP+foQf9G3E2ZX7OHvsY=;
        b=VETaA6jDP5/X44uCvHd/04NxHnVMYsXUGIQnuz+mjXY4PqQidWqWznduFhBvZvWin/
         FLVR+dJjKLLSmJu9lGkbW0eI6ZLpE7hEdpp4LJ4Hovk1Rna3kz3KIu6uGFzYx7nQuieR
         wvDRtzS3srWLK6NgIzOg1Sh0FTQUV1VX5lKUk2/mAZuCnzTESZYM/58m74/4ZAGmS7DX
         yfTdHNPhKcSv8I4tKv0MIgEBA1mFgPJDqb84nvtI8GWA6aYTPzy8hJDuFDRHLtoPzUBt
         yB3ybKAXA4k9CN7XUhNVHc832BmXP6U+QtIA8XNEcWBCK2/rrH+aGrq+iwgjnUGrF590
         GtUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699386978; x=1699991778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xjOaWaxhB0I1LfMyCOktuLSgP+foQf9G3E2ZX7OHvsY=;
        b=hlG5Jh7JwKBp5JCMtzzWuv4c7RVv9LfNqpU/nt77T42LBercQp6kbgTNuvsNe9g0FH
         6LOsefx9ikcWlWhZQMN6XYXx9II7nuqlB75zXzV3wWomGAXwQSsW18sqXl1048/Jio8W
         hZhrXB/wOGn2bkYQclwt6CTibQapRkat0KSwOC/XGY6wiO9zl6sHjVxEsyl9qok7Murc
         VDD8sQ+EBKdrHsDBDFdoQYSSslB8SwUyV5wTvcEkVELhCX7x81D5bPax2Jw8Qeg77/t9
         gP9cjJRYldgWHsaLl/dT+nNHKP6oH/Q9tbdmxTBz99cbx4G5awhp2bgd7zD485+UTdfY
         Pehg==
X-Gm-Message-State: AOJu0YxfRds7wl3+KxGtgMdO9Aq8v3mQKBN238mWKlcHO4MMIj6q3hdl
	2MBLTV6Frl0PfQFygkfe9HyQEyRscHtnuFjMAhBWZJu04io8LSHg
X-Google-Smtp-Source: AGHT+IGR4J2p0Gc8io1ZhH7XE5wrcbH80Sc616yItZ7zPJr0mc3fF9JlJKaGh2rze/GRKN/n2C5Ml9nAgWEHUgWBLWA=
X-Received: by 2002:a05:6102:aca:b0:45f:4ba5:1c4e with SMTP id
 m10-20020a0561020aca00b0045f4ba51c4emr4303563vsh.35.1699386978430; Tue, 07
 Nov 2023 11:56:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADx9qWgqfQdHSVn0RMMz7M2jp5pKP-bnnc7GAfFD4QbP4eFA4w@mail.gmail.com>
 <20231103212024.327833-1-hawkinsw@obs.cr> <CAADnVQLztq5W9qmGUBQeRBUJeCmTcc9H-OXCCJJzn=0baz+8_Q@mail.gmail.com>
 <CADx9qWiQA3U+j-QoZPh7z66_2iNv6B51WXmd60Y-6GKhg+k0=w@mail.gmail.com> <CAADnVQKXz-Y_ykNXa-sgSjo2r6F-vuO0Jx=9zHzG7j3-ZKhGYA@mail.gmail.com>
In-Reply-To: <CAADnVQKXz-Y_ykNXa-sgSjo2r6F-vuO0Jx=9zHzG7j3-ZKhGYA@mail.gmail.com>
From: Will Hawkins <hawkinsw@obs.cr>
Date: Tue, 7 Nov 2023 14:56:04 -0500
Message-ID: <CADx9qWj0fWWhT4OBLqy9MJ=hSZwSfdWvsn+9AqxmvE_DuEGCTg@mail.gmail.com>
Subject: Re: [Bpf] [PATCH v3] bpf, docs: Add additional ABI working draft base text
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@ietf.org, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 6, 2023 at 3:38=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sun, Nov 5, 2023 at 4:17=E2=80=AFPM Will Hawkins <hawkinsw@obs.cr> wro=
te:
> >
> > On Sun, Nov 5, 2023 at 4:51=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Fri, Nov 3, 2023 at 2:20=E2=80=AFPM Will Hawkins <hawkinsw@obs.cr>=
 wrote:
> > > > +
> > > > +The ABI is specified in two parts: a generic part and a processor-=
specific part.
> > > > +A pairing of generic ABI with the processor-specific ABI for a cer=
tain
> > > > +instantiation of a BPF machine represents a complete binary interf=
ace for BPF
> > > > +programs executing on that machine.
> > > > +
> > > > +This document is the generic ABI and specifies the parameters and =
behavior
> > > > +common to all instantiations of BPF machines. In addition, it defi=
nes the
> > > > +details that must be specified by each processor-specific ABI.
> > > > +
> > > > +These psABIs are the second part of the ABI. Each instantiation of=
 a BPF
> > > > +machine must describe the mechanism through which binary interface
> > > > +compatibility is maintained with respect to the issues highlighted=
 by this
> > > > +document. However, the details that must be defined by a psABI are=
 a minimum --
> > > > +a psABI may specify additional requirements for binary interface c=
ompatibility
> > > > +on a platform.
> > >
> > > I don't understand what you are trying to say in the above.
> > > In my mind there is only one BPF psABI and it doesn't have
> > > generic and processor parts. There is only one "processor".
> > > BPF is such a processor.
> >
> > What I was trying to say was that the document here describes a
> > generic ABI. In this document there will be areas that are specific to
> > different implementations and those would be considered processor
> > specific. In other words, the ubpf runtime could define those things
> > differently than the rbpf runtime which, in turn, could define those
> > things differently than the kernel's implementation.
>
> I see what you mean. There is only one BPF psABI. There cannot be two.
> ubpf can decide not to follow it, but it could only mean that
> it's non conformant and not compatible.

Okay. That was not how I was structuring the ABI. I thought we had
decided that, as the document said, an instantiation of a machine had
to

1. meet the gABI
2. specify its requirements vis a vis the psABI
3. (optionally) describe other requirements.

If that is not what we decided then we will have to restructure the documen=
t.

Will

