Return-Path: <bpf+bounces-38918-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1EB96C729
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 21:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 443CA284554
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 19:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0351D86F3;
	Wed,  4 Sep 2024 19:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSu8xiSp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244521D6DD3
	for <bpf@vger.kernel.org>; Wed,  4 Sep 2024 19:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725476856; cv=none; b=h3sL4oJFpQZhoQuSKIy6faJiGKnpkI5vWaXWMs4fPne5BUmP1o65mNv+4619jSNmngDZ8wGOuz2Q2Mbi52p4azm8gAQDiMFUoSMtjWJk/liy51mcCkGqzynzw+wFje7rUzNfaBnLmkTjhQNFUalLlEsQDxu//nX8JyCmS0C0qIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725476856; c=relaxed/simple;
	bh=2r8KZygPBMLH5FuEhTswH/9ey8x18kOwDxiOF6+hA7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XqtmDjLKW1EjgSCmyekBkdcBPAt34fYYbgozQ7QoI9fkAxr8gvyLturjZF3UNB8eGlHCXxgDbuIN45f7gVdtSgq045kuRxPMybTGfKVUf/88AIgQW29UZ7GY8wSJgclMwg8jrVyXaPa3h/7acc+7br0v2xBt3S0h3JnaSPMTjVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSu8xiSp; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7c3e1081804so3990165a12.3
        for <bpf@vger.kernel.org>; Wed, 04 Sep 2024 12:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725476854; x=1726081654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9rdD7DW82+Vv11zpXCjQlGAFRc0bkHwyVmrGW0GiImw=;
        b=BSu8xiSpOxsYxxjmO3R9BuNj7kTHCOv0xrlBiA383R2a7nRBexgTDFqO2jR4OIkB6w
         MEE2Mpi32GgOqfFf8PUf0UhyrPoPBrVHZoAof0ZjwauBAU/Ud4XJbCP6+VzuuSdRnUbr
         T8OrIwvbtQBw83zee5kDN0rZ8HfOAycixiSyaubG8tLDUyXtbYHnq9Pp+oBuNv9LxObU
         VwcJZ2Bzv9hdKiqTBvqwrFMNuVJkYi1hkYHgEB4tJ2GYgCYLBr/KPz1K9WMZcRu9r0iN
         mM+uHEXwBTLEL0iqbGHGoY7NP5XBzh0xRL4bPqLB+zfM+WufsWzDrDeccHnxGOwCV24H
         Y72g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725476854; x=1726081654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9rdD7DW82+Vv11zpXCjQlGAFRc0bkHwyVmrGW0GiImw=;
        b=rnstdNa86JDWcToOwS9dPMMEFa4SGOBAqY3mXPZIu7DMr9bjSD2pgFPsuOTylqBIeq
         pewnzLvlHW0aySMX/rM2qbKzFQMbGiAS1BSIAJ5MhgDYtoRbzP5mDoVN+vae/FX83QfL
         tKUlKKRhmbrSn9SSzERQmRAAKMd/lfiAtQ0ONDyI7yIj3/RmTzWUPd7WX+rSDz06XavN
         DMRAXkYZ7rZuW7U1P1ZeETGM/GKG1I9eAMu8WtzrTAOFzzJvPgfsTsnLsXu9CKb85BYI
         QG72m0cpa0ZjaC2hPZPZX9iUBeHUQzmhj+HhE0YEQuSVrbzDa6bj/3Ey/+39Cd0GJHgw
         GETw==
X-Forwarded-Encrypted: i=1; AJvYcCVZdg2W0iuumhLeq6ar/eMJiZzQxMbAVMm9e1wR2eA6N59p8SZ8zfaJxfOrPFqxV0neqIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCzBw2wYdUuLuQq9x3FxR+k+g1G0stpnc1DGU6/gFXQvqobmjL
	2JlAUPioTRSPcIKpbt2Cyonv3XE+yqY9YhWZyQgwd/gpD+hGEB9AyJw1nTnubejgmM9ZYLmA5Z1
	eht3u02fMDP/1KDXEQ0god9z2L30=
X-Google-Smtp-Source: AGHT+IGIi3C+iItShDfDRGoHYONq9/dcRsNF6ZvvvVqr28VfSb1EQu5tc+UKTIonpQBd1HlB6jPV/im6aQ+A66j17ms=
X-Received: by 2002:a17:90b:38c6:b0:2d8:a373:481e with SMTP id
 98e67ed59e1d1-2da630ecf41mr7340839a91.24.1725476854368; Wed, 04 Sep 2024
 12:07:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1725016029.git.vmalik@redhat.com> <92146771-8756-4259-88f0-e0b61c11ad55@oracle.com>
 <3adea7f7-0e8d-4114-ba04-356cdf9d20d1@redhat.com> <CAADnVQLmo0sOCuF598nL_xoowMDwTEXzjHareG1xiWGPLM77qA@mail.gmail.com>
In-Reply-To: <CAADnVQLmo0sOCuF598nL_xoowMDwTEXzjHareG1xiWGPLM77qA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 4 Sep 2024 12:07:21 -0700
Message-ID: <CAEf4Bza=i15HZoZHyvGJrPdqUPbNxEGG5QWTDJKFnbOcT-jPZw@mail.gmail.com>
Subject: Re: [RFC bpf-next 0/3] libbpf: Add support for aliased BPF programs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Viktor Malik <vmalik@redhat.com>, Alan Maguire <alan.maguire@oracle.com>, 
	bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 1:19=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Sep 2, 2024 at 10:57=E2=80=AFPM Viktor Malik <vmalik@redhat.com> =
wrote:
> >
> > On 9/2/24 19:01, Alan Maguire wrote:
> > > On 02/09/2024 07:58, Viktor Malik wrote:
> > >> TL;DR
> > >>
> > >> This adds libbpf support for creating multiple BPF programs having t=
he
> > >> same instructions using symbol aliases.
> > >>
> > >> Context
> > >> =3D=3D=3D=3D=3D=3D=3D
> > >>
> > >> bpftrace has so-called "wildcarded" probes which allow to attach the
> > >> same program to multple different attach points. For k(u)probes, thi=
s is
> > >> easy to do as we can leverage k(u)probe_multi, however, other progra=
m
> > >> types (fentry/fexit, tracepoints) don't have such features.
> > >>
> > >> Currently, what bpftrace does is that it creates a copy of the progr=
am
> > >> for each attach point. This naturally results in a lot of redundant =
code
> > >> in the produced BPF object.
> > >>
> > >> Proposal
> > >> =3D=3D=3D=3D=3D=3D=3D=3D
> > >>
> > >> One way to address this problem would be to use *symbol aliases*. In
> > >> short, they allow to have multiple symbol table entries for the same
> > >> address. In bpftrace, we would create them using llvm::GlobalAlias. =
In
> > >> C, it can be achieved using compiler __attribute__((alias(...))):
> > >>
> > >>     int BPF_PROG(prog)
> > >>     {
> > >>         [...]
> > >>     }
> > >>     int prog_alias() __attribute__((alias("prog")));
> > >>
> > >> When calling bpf_object__open, libbpf is currently able to discover =
all
> > >> the programs and internally does a separate copy of the instructions=
 for
> > >> each aliased program. What libbpf cannot do, is perform relocations =
b/c
> > >> it assumes that each instruction belongs to a single program only. T=
he
> > >> second patch of this series changes relocation collection such that =
it
> > >> records relocations for each aliased program. With that, bpftrace ca=
n
> > >> emit just one copy of the full program and an alias for each target
> > >> attach point.
> > >>
> > >> For example, considering the following bpftrace script collecting th=
e
> > >> number of hits of each VFS function using fentry over a one second
> > >> period:
> > >>
> > >>     $ bpftrace -e 'kfunc:vfs_* { @[func] =3D count() } i:s:1 { exit(=
) }'
> > >>     [...]
> > >>
> > >> this change will allow to reduce the size of the in-memory BPF objec=
t
> > >> that bpftrace generates from 60K to 9K.

Tbh, I'm not too keen on adding this aliasing complication just for
this. It seems a bit too intrusive for something so obscure.

retsnoop doesn't need this and bypasses the issue by cloning with
bpf_prog_load(), can bpftrace follow the same model? If we need to add
some getters to bpf_program() to make this easier, that sounds like a
better long-term investment, API-wise.

> > >>
> > >> For reference, the bpftrace PoC is in [1].
> > >>
> > >> The advantage of this change is that for BPF objects without aliases=
, it
> > >> doesn't introduce any overhead.
> > >>
> > >
> > > A few high-level questions - apologies in advance if I'm missing the
> > > point here.
> > >
> > > Could bpftrace use program linking to solve this issue instead? So we=
'd
> > > have separate progs for the various attach points associated with vfs=
_*
> > > functions, but they would all call the same global function. That
> > > _should_ reduce the memory footprint of the object I think - or are
> > > there issues with doing that?
> >
> > That's a good suggestion, thanks! We added subprograms to bpftrace only
> > relatively recently so I didn't really think about this option. I'll
> > definitely give it a try as it could be even more efficient.
> >
> > > I also wonder if aliasing helps memory
> > > footprint fully, especially if we end up with separate copies of the
> > > program for relocation purposes; won't we have separate copies in-ker=
nel
> > > then too? So I _think_ the memory utilization you're concerned about =
is
> > > not what's running in the kernel, but the BPF object representation i=
n
> > > bpftrace; is that right?
> >
> > Yes, that is correct. libbpf will create a copy of the program for each
> > symbol in PROGBITS section that it discovers (including aliases) and th=
e
> > copies will be loaded into kernel.
> >
> > It's mainly the footprint of the BPF object produced by bpftrace that I
> > was concerned about. (The reason is that we work on ahead-of-time
> > compilation so it will directly affect the size of the pre-compiled
> > binaries). But the above solution using global subprograms should reduc=
e
> > the in-kernel footprint, too, so I'll try to add it and see if it would
> > work for bpftrace.
>
> I think it's a half solution, since prog will be duplicated anyway and
> loaded multiple times into the kernel.
>
> I think it's better to revive this patch sets:
>
> v1:
> https://lore.kernel.org/bpf/20240220035105.34626-1-dongmenglong.8@bytedan=
ce.com/
>
> v2:
> https://lore.kernel.org/bpf/20240311093526.1010158-1-dongmenglong.8@byted=
ance.com/
>
> Unfortunately it went off rails, because we went deep into trying
> to save bpf trampoline memory too.
>

+1 to adding multi-attach fentry, even if it will have to duplicate trampol=
ines

> I think it can still land.
> We can load fentry program once and attach it in multiple places
> with many bpf links.
> That is still worth doing.

This part I'm confused about, but we can postpone discussion until
someone actually works on this.

>
> I think it should solve retsnoop and bpftrace use cases.
> Not perfect, since there will be many trampolines, but still an improveme=
nt.
>

retsnoop is fine already through bpf_prog_load()-based cloning, but
faster attachment for fentry/fexit would definitely help.

