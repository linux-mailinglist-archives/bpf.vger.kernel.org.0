Return-Path: <bpf+bounces-14520-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5FB7E5ED9
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 20:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 109D22812E7
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 19:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648A437160;
	Wed,  8 Nov 2023 19:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTtl1ymg"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D713715A
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 19:51:55 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5921FC3
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 11:51:54 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40850b244beso42045e9.2
        for <bpf@vger.kernel.org>; Wed, 08 Nov 2023 11:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699473113; x=1700077913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJ6MrX10L+eqVpMhnTztqFuS/silJbeJQywy4Iq139k=;
        b=iTtl1ymgq08guEdNm5Wflz5R5GZGTYGtdkzxecfK1KvnW6a5H9SFKm9Qf62778bjOw
         CcQS8BuNrDhLTQO4SfbQPc3SAaxDSNLVltrxCrREDSYNy8cbI0OFJm78fEY2tR3+nJt2
         vhtrCWHmZ1oaqLloNSlKW7Vu0sJjibENVFoH4eBAj3pwLchgkcrcNspb8CcJD4Rw0v1p
         0XWLrcWwjH3pZwiUvto5gIV44GhPi/AR/rWIiPgfAG7cRTUfFurfsE2GUTG+x28YrE3I
         kmhbMuKFwZdhF0f05CKU5iC25XNgmxUGk+pTQhqWhyMazbCAjPFLl1JjlkDENEUfHh+9
         bYUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699473113; x=1700077913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xJ6MrX10L+eqVpMhnTztqFuS/silJbeJQywy4Iq139k=;
        b=tEyRnhCCjFGNimDcJQTvut6ySC8D/qyqSmLVt9z1tDlDmfsMzNM0Bo3cxP5tSE57/d
         s0B+PPIrnWCT6kbd+anNyjerm0uYYtfT9HsLqZQAxO13lyQjtfM/3TUGj6+ZOilZgY6t
         rKQ0L5d6C63Ig4vNNXJzKMtHuDCSiS8W6lEUG7Gm1mpU1+r8NHwlvggYD5siApcc/jZi
         One9V2EXuG6sisSVQFZ4IWCXVUslv4Bpc7pRvAgU9C9RPugOArBvWoM87nBRc6SPucrc
         /Qvzgw2Tf2TdbLl8Rxj5UGL3MNnNVwNf4gpQiVcUSz6TX3LklTo9n5k6QHu3cpcPj7fw
         Zamw==
X-Gm-Message-State: AOJu0YwEjUtBf8D1SQsGoGM+pXjcscMpSeioT2pZm5X5GxNYnjLLnrvj
	dZiAEChILTqZghn5JnW9ZdFnFizZJUYwIxtXBXc=
X-Google-Smtp-Source: AGHT+IE5lx+H7UoCE0axLzFtUPZtpqfVSX09Pjmw4hK0G3wM0mN7wlTHbxz3cv/6HwOpfEf+Oabeq62pNEnIcShJOyA=
X-Received: by 2002:a05:6000:1364:b0:32f:7e4e:535d with SMTP id
 q4-20020a056000136400b0032f7e4e535dmr2522737wrz.15.1699473112588; Wed, 08 Nov
 2023 11:51:52 -0800 (PST)
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
 <CAADnVQ+w5C_MgPh2FVK=YOXrJ2LuqHzn88jFiR+yeHzB=MBoLw@mail.gmail.com> <CADx9qWgps=T8COiFYTFPKObSUkMo9kaOKMRVub8quN_MkFM_LA@mail.gmail.com>
In-Reply-To: <CADx9qWgps=T8COiFYTFPKObSUkMo9kaOKMRVub8quN_MkFM_LA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 8 Nov 2023 11:51:41 -0800
Message-ID: <CAADnVQLhJh+qSc=xg5WDCfFzD-SO7KtoBz5MyQZUxEY0foY6aw@mail.gmail.com>
Subject: Re: [Bpf] [PATCH v3] bpf, docs: Add additional ABI working draft base text
To: Will Hawkins <hawkinsw@obs.cr>
Cc: bpf@ietf.org, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 8, 2023 at 2:13=E2=80=AFAM Will Hawkins <hawkinsw@obs.cr> wrote=
:
>
> On Tue, Nov 7, 2023 at 8:17=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Nov 7, 2023 at 11:56=E2=80=AFAM Will Hawkins <hawkinsw@obs.cr> =
wrote:
> > >
> > > On Mon, Nov 6, 2023 at 3:38=E2=80=AFAM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Sun, Nov 5, 2023 at 4:17=E2=80=AFPM Will Hawkins <hawkinsw@obs.c=
r> wrote:
> > > > >
> > > > > On Sun, Nov 5, 2023 at 4:51=E2=80=AFAM Alexei Starovoitov
> > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > >
> > > > > > On Fri, Nov 3, 2023 at 2:20=E2=80=AFPM Will Hawkins <hawkinsw@o=
bs.cr> wrote:
> > > > > > > +
> > > > > > > +The ABI is specified in two parts: a generic part and a proc=
essor-specific part.
> > > > > > > +A pairing of generic ABI with the processor-specific ABI for=
 a certain
> > > > > > > +instantiation of a BPF machine represents a complete binary =
interface for BPF
> > > > > > > +programs executing on that machine.
> > > > > > > +
> > > > > > > +This document is the generic ABI and specifies the parameter=
s and behavior
> > > > > > > +common to all instantiations of BPF machines. In addition, i=
t defines the
> > > > > > > +details that must be specified by each processor-specific AB=
I.
> > > > > > > +
> > > > > > > +These psABIs are the second part of the ABI. Each instantiat=
ion of a BPF
> > > > > > > +machine must describe the mechanism through which binary int=
erface
> > > > > > > +compatibility is maintained with respect to the issues highl=
ighted by this
> > > > > > > +document. However, the details that must be defined by a psA=
BI are a minimum --
> > > > > > > +a psABI may specify additional requirements for binary inter=
face compatibility
> > > > > > > +on a platform.
> > > > > >
> > > > > > I don't understand what you are trying to say in the above.
> > > > > > In my mind there is only one BPF psABI and it doesn't have
> > > > > > generic and processor parts. There is only one "processor".
> > > > > > BPF is such a processor.
> > > > >
> > > > > What I was trying to say was that the document here describes a
> > > > > generic ABI. In this document there will be areas that are specif=
ic to
> > > > > different implementations and those would be considered processor
> > > > > specific. In other words, the ubpf runtime could define those thi=
ngs
> > > > > differently than the rbpf runtime which, in turn, could define th=
ose
> > > > > things differently than the kernel's implementation.
> > > >
> > > > I see what you mean. There is only one BPF psABI. There cannot be t=
wo.
> > > > ubpf can decide not to follow it, but it could only mean that
> > > > it's non conformant and not compatible.
> > >
> > > Okay. That was not how I was structuring the ABI. I thought we had
> > > decided that, as the document said, an instantiation of a machine had
> > > to
> > >
> > > 1. meet the gABI
> > > 2. specify its requirements vis a vis the psABI
> > > 3. (optionally) describe other requirements.
> > >
> > > If that is not what we decided then we will have to restructure the d=
ocument.
> >
> > This abi.rst file is the beginning of "BPF psABI" document.
> > We probably should rename it to psabi.rst to avoid confusion.
> > See my slides from IETF 118. I hope they explain what "BPF psABI" is fo=
r.
>
> Of course they do! Thank you! My only question: In the language I was
> using, I was taking a cue from the System V world where there is a
> Generic ABI and a psABI. The Generic ABI applies to all System V
> compatible systems and defines certain processor-specific details that
> each platform must specify to define a complete ABI. In particular, I
> took this language as inspiration
>
> """
> The System V ABI is composed of two basic parts: A generic part of the
> specification describes those parts of the interface that remain
> constant across all hardware implementations of System V, and a
> processor-specific part of the specification describes the parts of
> the specification that are specific to a particular processor
> architecture. Together, the generic ABI (or gABI) and the processor
> specific supplement (or psABI) provide a complete interface
> specification for compiled application programs on systems that share
> a common hardware architecture.
> """

I see where you got the inspiration from, but it's not applicable
in the BPF case. BPF is such one and only processor.
We're not changing nor adding anything to Sys V generic parts.

